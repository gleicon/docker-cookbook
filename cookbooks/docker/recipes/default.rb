package "bsdtar" do
    action :install
end

package "linux-image-extra-virtual" do
    action :install
end
 
remote_file "/tmp/docker-master.tgz" do
    os = `uname -s`.strip
    arch = `uname -m`.strip
    source "http://get.docker.io/builds/#{os}/#{arch}/docker-master.tgz"
    notifies :run, "bash[install]"
    action :create_if_missing
end

bash "install" do
  code <<-EOH
    tar zvxf /tmp/docker-master.tgz -C /tmp
    mv /tmp/docker-master/docker /usr/local/bin
  EOH
  action :run
end


