require 'spec_helper_acceptance'

describe 'thin site' do

  it 'should work idempotently with no errors' do
    pp = <<-EOS
    class { 'thin': }
    thin::site { 'site1':
      chdir => '/opt/thin'
    }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end

  describe port(3000) do
    it { should be_listening }
  end

  describe file('/var/log/site1') do
    it { should be_directory }
  end

end
