include_recipe "tracelytics::default"

package "libapache2-mod-oboe" do
    action :install
end

template "/etc/apache2/mods-available/oboe.conf" do
    cookbook node['tracelytics']['apache']['cookbook']
    source node['tracelytics']['apache']['template']
    mode "0644"
    owner "root"
    group "root"
    notifies :reload, "service[apache2]", :delayed
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