require 'spec_helper_acceptance'

describe 'thin class' do

  context 'install' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'thin': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe user('thin') do
      it { should exist }
    end

    describe group('thin') do
      it { should exist }
    end
  end # install

end
