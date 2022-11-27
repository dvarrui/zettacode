# frozen_string_literal: true

require "test_helper"

class CommandTest < Test::Unit::TestCase
  test "help" do
    assert_equal true, system("zettacode --help >/dev/null")
  end

  test "version" do
    assert_equal true, system("zettacode --version >/dev/null")
  end
end
