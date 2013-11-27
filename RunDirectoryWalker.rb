#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'DirectoryWalker')

dir_name = ARGV[0].dup
DirectoryWalker.new(dir_name, ARGV[1]).find_size
