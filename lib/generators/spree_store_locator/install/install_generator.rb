module SpreeStoreLocator
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require spree/frontend/spree_store_locator\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require spree/backend/spree_store_locator\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require spree/frontend/spree_store_locator\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require spree/backend/spree_store_locator\n", :before => /\*\//, :verbose => true
      end

      def add_templates
        copy_file 'infowindow-description.html', 'public/templates/infowindow-description.html'
        copy_file 'location-list-description.html', 'public/templates/location-list-description.html'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_store_locator'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
