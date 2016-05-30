module RedmineNewIssueStatus
  module IssuePatch
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        alias_method_chain :new_statuses_allowed_to, :extension
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def new_statuses_allowed_to_with_extension(user=User.current, include_default=false)
        return [default_status] if new_record?
        new_statuses_allowed_to_without_extension(user, include_default)
      end
    end
  end
end