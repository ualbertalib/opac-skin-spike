require "rvm/capistrano"
require 'bundler/capistrano'
 
set :application, "neos_catalogue_lite"
set :repository,  "http://github.com/ualbertalib/neos_catalogue_lite"
 
set :scm, :git
 
set :use_sudo, false
 
default_run_options[:pty] = true
 
set :user, "asdp"
set :group, user
set :runner, user
 
set :host, "#{user}@virtual"
role :web, host
role :app, host
 
set :rack_env, :production
 
set :deploy_to, "/home/asdp/#{application}"
set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
 
#set :public_children, ["css","img","js"]
 
namespace :deploy do

# need to add task to start elasticsearch (also, server need Java to run elasticsearch)
#
 task :restart do
   run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D; fi"
 end
 
 task :start do
   run "cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D"
 end
 
 task :stop do
   run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
 end
 
end
