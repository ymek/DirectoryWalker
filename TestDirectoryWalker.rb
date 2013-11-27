#!/usr/bin/env ruby

require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'DirectoryWalker')

class DirectoryTest < MiniTest::Unit::TestCase

  def setup
    @directory = "/Users/alex/Documents/"
  end

  def test_calculate_documents
    dir = DirectoryWalker.new(@directory, "")

    dir.calculate
    assert_in_delta(1778685032, dir.count, 0.01)
  end

  def test_specific_extension
    dir = DirectoryWalker.new(@directory, ".plist")

    dir.calculate
    assert_in_delta(180, dir.count, 0.01)
  end
end
