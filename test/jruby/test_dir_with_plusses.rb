require 'test/unit'
require 'test/jruby/test_helper'

class TestDirWithPlusses < Test::Unit::TestCase
  include TestHelper

  def prefix
    if JRuby.runtime.instance_config.legacy_load_service_enabled? || IS_JAR_EXECUTION
      File.dirname(File.expand_path(__FILE__))
    else
      'uri:classloader:/test/jruby'
    end
  end

  def test_loaded_FILE_in_dir_with_plusses
    begin
      load 'test/jruby/dir_with_plusses_+++/required.rb'
      assert_equal(
        File.join(prefix, 'dir_with_plusses_+++', 'required.rb'),
        $dir_with_plusses_FILE
      )
    ensure
      # reset global
      $dir_with_plusses_FILE = nil
    end
  end

  def test_required_FILE_in_dir_with_plusses
    begin
      require 'test/jruby/dir_with_plusses_+++/required.rb'
      assert_equal(
        File.join(prefix, 'dir_with_plusses_+++', 'required.rb'),
        $dir_with_plusses_FILE
      )
    ensure
      # remove entry from loaded features and reset global
      $".pop
      $dir_with_plusses_FILE = nil
    end
  end
end
