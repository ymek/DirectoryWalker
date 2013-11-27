#!/usr/bin/env ruby
require 'DirectoryWalker'

dir_name = ARGV[0].dup
DirectoryWalker.new(dir_name, ARGV[1]).calculate
