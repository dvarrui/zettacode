# frozen_string_literal: true

require "test_helper"

class ZettacodeTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Zettacode.const_defined?(:VERSION)
    end
  end

  test "something useful" do
    assert_equal("expected", "actual")
  end
end
