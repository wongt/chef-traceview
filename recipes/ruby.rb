include_recipe 'rvm'


rvm_gem 'oboe' do
    action  :install
    options :source => 'http://gem.tracelytics.com' 
end

rvm_gem 'oboe_fu' do
    action  :install
    options :source => 'http://gem.tracelytics.com' 
end
