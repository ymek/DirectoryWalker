#!/usr/bin/env ruby

require_relative 'DirectoryWalker'
require 'minitest/autorun'

class DirectoryTest < MiniTest::Unit::TestCase

  def test_calculate_documents
    dir = DirectoryWalker.new("/Users/alex/Documents/", "")

    dir.calculate
    assert_in_delta(1778685032, dir.count, 0.01)
  end

  def test_specific_extension
    dir = DirectoryWalker.new("/Users/alex/Desktop/", ".plist")

    dir.calculate
    assert_in_delta(180, dir.count, 0.01)
  end
end
