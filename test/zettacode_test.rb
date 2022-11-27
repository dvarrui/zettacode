# frozen_string_literal: true

require "test_helper"

class ZettacodeTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Zettacode.const_defined?(:VERSION)
    end
  end

  test "BASEFOLDER" do
    assert do
      ::Zettacode.const_defined?(:BASEFOLDER)
    end
  end
end
