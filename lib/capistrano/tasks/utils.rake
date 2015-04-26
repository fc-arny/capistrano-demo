namespace :demo do
  namespace :utils do
    # desc 'Create symlink to file'
    # task :link_data do
    #   on roles(fetch(:demo_role)) do
    #     within fetch(:demo_path) do
    #       source = fetch(:demo_db)
    #       target = fetch(:demo_path).join('db', 'data.yml')
    #
    #
    #       unless test "[ -L #{target} ]"
    #         if test "[ -f #{target} ]"
    #           execute :rm, target
    #         end
    #         execute :sudo, :ln, '-s', source, target
    #       end
    #     end
    #   end
    # end

    # desc 'Symlink directories'
    task :link_dirs do
      next unless any? :demo_linked_dirs
      on roles(fetch(:demo_role)) do

        fetch(:demo_linked_dirs).each do |dir|
          target = fetch(:demo_path).join(dir)
          source = shared_path.join(dir)

          unless test "[ -L #{target} ]"
            if test "[ -d #{target} ]"
              execute :rm, '-rf', target
            end
            execute :ln, '-s', source, target
          end
        end
      end
    end

    # desc 'Copy dirs (cache) for speed-up (by default bundler cache and precompiled assets)'
    task :copy_dirs do
      next unless any? :demo_copied_dirs

      on roles(fetch(:demo_role)) do
        fetch(:demo_copied_dirs).each do |dir|
          source = shared_path.join(dir)
          target = fetch(:demo_path).join(dir)

          execute :mkdir, '-p', target
          execute :cp, '-an',  "#{source}/. #{target}"
        end
      end

    end
  end
end