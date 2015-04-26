namespace :demo do
  namespace :setup do
    # desc 'Bootstrap demo plugin'
    task :bootstrap do
      set :demo_branch, ask('branch name', fetch(:demo_branch, demo_branch))
      set :demo_db, ask('database name', fetch(:demo_db, demo_default_db))
      set :release_path, demo_path

      def current_path
        deploy_path.join('demo', demo_branch)
      end
    end

    # desc 'Fetch code from rebunlo\'s branch'
    task :code  => [:bootstrap] do
      set :branch, demo_branch

      on roles(fetch(:demo_role)) do
        # Create dir for demo-host
        execute :mkdir, "-p #{fetch(:demo_path)}"

        # Upload code
        with fetch(:git_environmental_variables) do
          within repo_path do
            set :release_path, fetch(:demo_path)
            strategy.update
            strategy.release
          end
        end

        invoke 'demo:utils:link_dirs'
        invoke 'demo:utils:copy_dirs'
      end
    end

    # desc 'Install gems'
    task :gems => [:bootstrap] do
      set :bundle_gemfile, demo_path.join('Gemfile')

      on roles(fetch(:demo_role)) do
        invoke 'bundler:install'
      end
    end

    desc 'Setting database name and run migration'
    task :db => [:code, :configs] do
      on roles(fetch(:demo_role)) do
        within fetch(:demo_path) do
          with rails_env: fetch(:rails_env) do
            # if fetch(:create_db).downcase == 'y'
            #   info '[Re]Creating database'
            #
            #   invoke 'demo:utils:link_data'
            #   execute :rake, 'db:drop db:create db:schema:load db:data:load db:migrate'
            # else
              info 'Running migration'
              execute :rake, 'db:migrate'
            # end
          end
        end
      end
    end

    desc 'Setup server configs from templates'
    task :configs => [:code] do
      next if fetch(:demo_templates_dir).nil?

      on roles(fetch(:demo_role)) do
        within fetch(:demo_path) do
          fetch(:demo_templates_entries).each do |entry|
            upload! StringIO.new(ERB.new(File.read(fetch(:demo_templates_dir) + entry[:template])).result(binding)), entry[:file]

            next if entry[:link].nil?

            unless test "[ -L #{entry[:link]} ]"
              if test "[ -d #{entry[:link]} ]"
                execute :rm, '-rf', entry[:link]
              end
              execute :ln, '-s', entry[:file], entry[:link]
            end
          end
        end
      end
    end

    desc 'Precompile assets for demo host'
    task :assets => [:code] do
      on roles(fetch(:demo_role)) do
        within fetch(:demo_path) do
          with rails_env: fetch(:rails_env) do
            execute :rake, 'assets:precompile'
          end
        end
      end
    end
  end
end
