# frozen_string_literal: true

require "test_helper"
require_relative "../lib/zettacode"

class ParseTest < Test::Unit::TestCase
  test "parse test/files/input1.xml" do
    filepath = "test/files/input1.xml"
    folder = "test/temp"

    raw_content, to_folder = Zettacode::Parse.read_content_from filepath, folder
    # dirty_examples, dirty_global = scrap_examples_from raw_content
    # clean_examples = clean dirty_examples
    # save_files clean_examples, to_folder

    assert_equal "test/temp/hello_world.text", to_folder
    assert_equal 135835, raw_content.size
  end
end
