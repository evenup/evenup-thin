require 'spec_helper'
 
describe 'thin', :type => :class do

  it { should create_class('thin') }
  it { should contain_package('rubygem-thin') }
  it { should contain_service('thin') }
  it { should contain_file('/etc/init.d/thin') }
  it { should contain_user('thin') }
  it { should contain_group('thin') }

end
