#!/usr/bin/env ruby

require 'minitest/autorun'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'DirectoryWalker')

class DirectoryTest < MiniTest::Unit::TestCase

  def setup
    @directory = File.join(File.dirname(__FILE__), 'test')
    Dir.mkdir(@directory)
    Dir.chdir(@directory) do |dir|
      ('a'..'c').each do |name|
        File.open(name, 'w+') do |fp|
          fp.print 'foo'
        end

        File.open("#{name}.test", 'w+') do |fp|
          fp.print 'bar'
        end
      end
    end
  end

  def teardown
    FileUtils.rm_rf(@directory)
  end

  def test_calculate_documents
    dir = DirectoryWalker.new(@directory)

    dir.calculate
    assert_in_delta(18, dir.count, 0.01)
  end

  def test_specific_extension
    dir = DirectoryWalker.new(@directory, ".test")

    dir.calculate
    assert_in_delta(9, dir.count, 0.01)
  end
end
