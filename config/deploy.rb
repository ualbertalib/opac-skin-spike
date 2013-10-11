require "rvm-capistrano"

set :application, "neos_catalogue_lite"
set :repository,  "http://github.com/ualbertalib/neos_catalogue_lite.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "142.244.35.88"                          # Your HTTP server, Apache/etc
role :app, "142.244.35.88"                          # This may be the same as your `Web` server
role :db,  "142.244.35.88", :primary=>true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, 'sam'
set :use_sudo, false
set :deploy_to, "/home/sam/#{application}"
set :deploy_via, :remote_cache


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"

namespace :deploy do
  task :bundle_gems do
    run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
  task :start do 
    run "unicorn"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
   # run "touch #{File.join(current_path,'tmp','restart.txt')}"
    #run "unicorn"
  end
end
