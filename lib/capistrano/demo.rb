# require 'yaml_db'

require_relative 'demo/tasks'
require_relative 'demo/setup'
require_relative 'demo/utils'
require_relative 'demo/db'

def demo_branch
  fetch(:demo_branch, `git rev-parse --abbrev-ref HEAD`.strip).downcase
end

def demo_host
  fetch(:demo_host)
end

def demo_url
  format("%s.%s", demo_branch, demo_host)
end

def demo_path
  deploy_path.join('demo', demo_branch)
end

def demo_default_db
  format("%s_%s", fetch(:application), fetch(:stage))
end