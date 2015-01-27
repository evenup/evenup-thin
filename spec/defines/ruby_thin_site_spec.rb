require 'spec_helper'

describe 'thin::site', :type => :define do
  let(:title) { 'test_site' }
  let(:facts) { { :operatingsystemmajrelease => '6' } }
  let(:pre_condition) { 'class {"thin": }'}
  let(:params) { { 'chdir' => '/var/somewhere' } }

  context 'common' do
    it { should contain_file('/etc/thin/test_site.yml') }
    it { should contain_service('thin-test_site') }
    it { should contain_file('/var/log/test_site') }
  end

  context "when setting parameters" do
    let(:params) { {
      :chdir                => '/var/somewhere',
      :address              => '127.0.0.1',
      :daemonize            => false,
      :environment          => 'development',
      :log                  => '/var/log/somelog',
      :group                => 'groupname',
      :max_conns            => 123,
      :max_persistent_conns => 12,
      :pid                  => '/var/myapp/lock',
      :port                 => 4567,
      :servers              => 1,
      :timeout              => 10,
      :user                 => 'username'
    } }

    it { should contain_file('/etc/thin/test_site.yml').with_content(/chdir:\s\/var\/somewhere/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/address:\s127\.0\.0\.1/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/port:\s4567/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/pid:\s\/var\/myapp\/lock/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/log:\s\/var\/log\/somelog/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/timeout:\s10/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/max_conns:\s123/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/environment:\sdevelopment/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/max_persistent_conns:\s12/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/servers:\s1/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/group:\sgroupname/) }
    it { should contain_file('/etc/thin/test_site.yml').with(:notify => 'Service[thin-test_site]') }
  end

  context 'operatingsystemmajrelease == 6' do
    let(:facts) { { :operatingsystemmajrelease => '6' } }
    it { should contain_file('/etc/init.d/thin-test_site') }
  end

  context 'operatingsystemmajrelease == 7' do
    let(:facts) { { :operatingsystemmajrelease => '7' } }
    it { should contain_file('/usr/lib/systemd/system/thin-test_site.service') }
  end

  context 'disabling service management' do
    let(:params) { { :chdir => '/var/somewhere', :manage_service => false } }
    it { should contain_file('/etc/thin/test_site.yml').with(:notify => [] ) }
    it { should_not contain_service('thin-test_site') }
  end
end
