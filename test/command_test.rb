# frozen_string_literal: true

require "test_helper"

class CommandTest < Test::Unit::TestCase
  test "help" do
    assert_equal true, system("zettacode --help >/dev/null")
  end

  test "version" do
    assert_equal true, system("zettacode --version >/dev/null")
  end

  test "parse error" do
    assert_equal false, system("zettacode --parse test/files >/dev/null")
    assert_equal false, system("zettacode --parse test/files/input0.xml >/dev/null")
  end
end
