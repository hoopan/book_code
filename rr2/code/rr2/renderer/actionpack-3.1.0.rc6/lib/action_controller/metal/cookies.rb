#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController #:nodoc:
  module Cookies
    extend ActiveSupport::Concern

    include RackDelegation

    included do
      helper_method :cookies
    end

    private
      def cookies
        request.cookie_jar
      end
  end
end