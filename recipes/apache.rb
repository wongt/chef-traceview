include_recipe "traceview::default"

package "libapache2-mod-oboe" do
    action :install
end

template "/etc/apache2/mods-available/oboe.conf" do
    cookbook node['traceview']['apache']['cookbook']
    source node['traceview']['apache']['template']
    mode "0644"
    owner "root"
    group "root"
    notifies :reload, "service[apache2]", :delayed
end

if node['traceview']['appname']
ruby_block "register traceview app" do
  block do
    require 'rest-client'

    begin
      response = RestClient.post('https://api.tv.appneta.com/api-v1/assign_app', {
        :key => node['traceview']['access_key'],
        :hostname => node['hostname'],
        :appname => node['traceview']['appname'],
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
