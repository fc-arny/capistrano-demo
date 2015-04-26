namespace :load do
  task :defaults do
    set :demo_role, :all

    set :demo_branch, demo_branch

    set :demo_db, -> { demo_default_db }
    set :demo_path, -> { demo_path }

    set :demo_host, -> { fetch(:application) }

    set :demo_restart_cmd, -> { raise 'You mast specify "demo_restart_cmd" proc' }

    set :demo_linked_dirs, %w(public/uploads)
    set :demo_copied_dirs, %w(vendor/cache)

    set :demo_templates_dir, nil
    set :demo_templates_entries, []
  end
end


namespace :demo do
  desc 'Chain of task for creating demo-host'
  task :create  do
    %w{code configs gems db assets}.each do |task|
      invoke "demo:setup:#{task}"
    end

    invoke 'demo:restart'

    puts  "------> Demo host created: http://#{demo_url}".colorize(:light_green)
  end

  desc 'Destroy demo-host'
  task :destroy => [:'setup:bootstrap'] do
    on roles(fetch(:demo_role)) do
      fetch(:demo_templates_entries).each do |entry|
        next if entry[:link].nil?

        execute :rm, entry[:link]
      end

      execute :rm, '-rf', fetch(:demo_path)
    end
  end


  desc 'Restart demo-server and services'
  task :restart => [:'setup:bootstrap'] do
    on roles(fetch(:demo_role)) do
      fetch(:demo_restart_cmd)
    end
  end

end