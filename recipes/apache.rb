package "libapache2-mod-oboe" do
    action :install
end

tracing_mode = "always"
sampling_rate = "300000"

if node.key?("tracelytics")
    tracing_mode = node["tracelytics"].fetch("tracing_mode", tracing_mode)
    sampling_rate = node["tracelytics"].fetch("sampling_rate", sampling_rate)
end

template "/etc/apache2/mods-available/oboe.conf" do
    source "etc/apache2/mods-available/oboe.conf.erb"
    mode "0644"
    owner "root"
    group "root"
    variables(
        :tracing_mode => tracing_mode,
        :sampling_rate => sampling_rate
    )
    action :create
end

service "apache2" do
    action :reload
end

if node['tracelytics']['appname']
ruby_block "register tracelytics app" do
  block do
    require 'rest-client'
    
    begin
      response = RestClient.post('https://api.tracelytics.com/api-v1/assign_app', {
        :key => node['tracelytics']['access_key'],
        :hostname => node['hostname'],
        :appname => node['tracelytics']['appname'],
        :layer => "apache"
      })
      
      Chef::Log.debug("register POST request response: #{response}")
    rescue RestClient::Exception => e
      Chef::Log.error("POST error; response body: '#{e.http_body}' response code: #{e.http_code}")
      raise e
    end
  end
end
end