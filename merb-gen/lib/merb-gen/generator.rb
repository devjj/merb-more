module Merb

  module Generators
    
    extend Templater::Manifold
    
    desc <<-DESC
      Generate components for your application or entirely new applications.
    DESC
    
    class Generator < Templater::Generator
      
      def initialize(*args)
        super
        options[:orm] ||= Merb.orm_generator_scope
        options[:testing_framework] ||= Merb.test_framework_generator_scope
        
        options[:orm] = :none if options[:orm] == :merb_default # FIXME: temporary until this is fixed in merb-core 
      end
    
      # Inside a template, wraps a block of code properly in modules, keeping the indentation correct
      # 
      # @param modules<Array[#to_s]> an array of modules to use for nesting
      # @option indent<Integer> number of integers to indent the modules by
      def with_modules(modules, options={}, &block)
        indent = options[:indent] || 0
        text = capture(&block)
        modules.each_with_index do |mod, i|
          concat(("  " * (indent + i)) + "module #{mod}\n", block.binding)
        end
        text = text.to_a.map{ |line| ("  " * modules.size) + line }.join
        concat(text, block.binding)
        modules.reverse.each_with_index do |mod, i|
          concat(("  " * (indent + modules.size - i - 1)) + "end # #{mod}\n", block.binding)
        end
      end
      
      # Returns a string of num times '..', useful for example in tests for namespaced generators
      # to find the spec_helper higher up in the directory structure.
      #
      # @param num<Integer> number of directories up
      # @return <String> concatenated string 
      def go_up(num)
        (["'..'"] * num).join(', ')
      end
    
      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'generators', 'templates')
      end
    end
    
  end  
  
end