require 'redmine'

require_dependency 'redmine_new_issue_status_issue_patch'

Redmine::Plugin.register :redmine_new_issue_status do
  name 'Redmine New Issue Status'
  author 'Yura Zaplavnov'
  description 'Redmine plugin to create new issues with default status configured for particular tracker.'
  version '3.0'
  url 'https://github.com/xeagle2/redmine_new_issue_status'
  author_url 'https://github.com/xeagle2'
end

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    Issue.send(:include, RedmineNewIssueStatus::IssuePatch)
  end
else
  Dispatcher.to_prepare do
    Issue.send(:include, RedmineNewIssueStatus::IssuePatch)
  end
end