include_recipe "tracelytics::default"

package "php-oboe" do
    action :install
end

template "/etc/php5/conf.d/oboe.ini" do
    source "oboe.ini.erb"
    mode "0644"
    owner "root"
    group "root"
    notifies :restart, "service[apache2]", :delayed
end

if node['tracelytics']['php']['appname']
ruby_block "register PHP layer with tracelytics app" do
  block do
    require 'rest-client'
    
    begin
      response = RestClient.post('https://api.tracelytics.com/api-v1/assign_app', {
        :key => node['tracelytics']['access_key'],
        :hostname => node['hostname'],
        :appname => node['tracelytics']['php']['appname'],
        :layer => "PHP"
      })
      
      Chef::Log.debug("register POST request response: #{response}")
    rescue RestClient::Exception => e
      Chef::Log.error("POST error; response body: '#{e.http_body}' response code: #{e.http_code}")
      raise e
    end
  end
end
end