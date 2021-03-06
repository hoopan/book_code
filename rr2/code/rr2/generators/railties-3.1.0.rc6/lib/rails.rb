#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/ruby_version_check'

require 'pathname'

require 'active_support'
require 'active_support/core_ext/kernel/reporting'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/logger'

require 'rails/application'
require 'rails/version'

require 'active_support/railtie'
require 'action_dispatch/railtie'

# For Ruby 1.8, this initialization sets $KCODE to 'u' to enable the
# multibyte safe operations. Plugin authors supporting other encodings
# should override this behavior and set the relevant +default_charset+
# on ActionController::Base.
#
# For Ruby 1.9, UTF-8 is the default internal and external encoding.
if RUBY_VERSION < '1.9'
  $KCODE='u'
else
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

module Rails
  autoload :Info, 'rails/info'
  autoload :InfoController, 'rails/info_controller'

  class << self
    def application
      @@application ||= nil
    end

    def application=(application)
      @@application = application
    end

    # The Configuration instance used to configure the Rails environment
    def configuration
      application.config
    end

    def initialize!
      application.initialize!
    end

    def initialized?
      @@initialized || false
    end

    def initialized=(initialized)
      @@initialized ||= initialized
    end

    def logger
      @@logger ||= nil
    end

    def logger=(logger)
      @@logger = logger
    end

    def backtrace_cleaner
      @@backtrace_cleaner ||= begin
        # Relies on Active Support, so we have to lazy load to postpone definition until AS has been loaded
        require 'rails/backtrace_cleaner'
        Rails::BacktraceCleaner.new
      end
    end

    def root
      application && application.config.root
    end

    def env
      @_env ||= ActiveSupport::StringInquirer.new(ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development")
    end

    def env=(environment)
      @_env = ActiveSupport::StringInquirer.new(environment)
    end

    def cache
      RAILS_CACHE
    end

    # Returns all rails groups for loading based on:
    #
    # * The Rails environment;
    # * The environment variable RAILS_GROUPS;
    # * The optional envs given as argument and the hash with group dependencies;
    #
    # == Examples
    #
    #   groups :assets => [:development, :test]
    #
    #   # Returns
    #   # => [:default, :development, :assets] for Rails.env == "development"
    #   # => [:default, :production]           for Rails.env == "production"
    #
    def groups(*groups)
      hash = groups.extract_options!
      env = Rails.env
      groups.unshift(:default, env)
      groups.concat ENV["RAILS_GROUPS"].to_s.split(",")
      groups.concat hash.map { |k,v| k if v.map(&:to_s).include?(env) }
      groups.compact!
      groups.uniq!
      groups
    end

    def version
      VERSION::STRING
    end

    def public_path
      application && application.paths["public"].first
    end
  end
end
