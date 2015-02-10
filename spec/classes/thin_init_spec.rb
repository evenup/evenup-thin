require 'spec_helper'

describe 'thin', :type => :class do
  let(:facts) { { :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :path => '/tmp', :id => 0 } }

  context 'default' do
    it { should contain_package('thin').with(:ensure => 'latest', :provider => 'gem') }
    it { should contain_user('thin') }
    it { should contain_group('thin') }
  end

  context 'set package params' do
    let(:params) { {
      :package_name     => 'rubygem-thin',
      :package_version  => '1.6.0-1',
      :package_provider => 'rpm',
    }}
    it { should contain_package('rubygem-thin').with(:ensure => '1.6.0-1', :provider => 'rpm') }
  end

end
