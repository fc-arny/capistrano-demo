namespace :load do
  task :defaults do
    set :feature_branch, -> { :app }
  end
end

namespace :demo do
  desc 'Deploy feature branch to '
  task :demo do

  end
end

def current_branch

end  