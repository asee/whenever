require 'chronic'

# Hoping to load Rails' Rakefile
begin
  load 'Rakefile' unless defined?(ActiveSupport)
rescue LoadError
  nil
end

# If Rails' rakefile was loaded than so was active_support, but
# if this is being used in a non-rails enviroment we need to require it.
# It was previously defined as a dependency of this gem, but that became
# problematic. See: http://github.com/javan/whenever/issues#issue/1
load_failed = false
begin
  require 'active_support/all'    
rescue LoadError, Gem::Exception # RubyGems before 1.3.3 raise this general error.  

  # In earlier rails versions, we activate active_support like this:
  begin
    require 'activesupport'
  rescue LoadError, Gem::Exception
    load_failed = true
  end
end
if load_failed
  warn 'To use Whenever you need the active_support gem:'
  warn '$ gem install activesupport'
  exit(1)
end

# Whenever files
require 'whenever/base'
require 'whenever/job_list'
require 'whenever/job_types/default'
require 'whenever/job_types/rake_task'
require 'whenever/job_types/runner'
require 'whenever/outputs/cron'
require 'whenever/outputs/cron/output_redirection'
require 'whenever/command_line'
require 'whenever/version'