module Merb::Generators
  
  class LayoutGenerator < NamedGenerator

    def self.source_root
      File.join(super, 'component', 'layout')
    end
    
    desc <<-DESC
      Generates a layout
    DESC
    
    #option :testing_framework, :desc => 'Testing framework to use (one of: rspec, test_unit)'
    option :template_engine, :default => :erb, :desc => 'Specify what template engine should be used (one of: erb, haml...)'
    
    first_argument :name, :required => true, :desc => "layout name"
    
    template :layout_erb, :template_engine => :erb do
      source('app/views/layout/%file_name%.html.erb')
      destination("app/views/layout/#{file_name}.html.erb")
    end
    
  end
  
  add :layout, LayoutGenerator
  
end
