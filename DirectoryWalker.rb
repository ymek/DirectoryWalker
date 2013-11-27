class DirectoryWalker
  attr_accessor :dir_name, :extension, :count

  def initialize(dir_name, extension = '.')
    @dir = dir_name
    @count = 0
    @extension = extension
  end

  def calculate
    calculate_dirs(@dir)
    puts "Total size is: #{@count}"
  end

  def calculate_dirs(dirname)
    files = Dir.entries(dirname)
    Dir.chdir(dirname)

    files.each do |file|
      next if %w(. ..).include?(file)

      if File.directory?(file)
        calculate_dirs(file)
        Dir.chdir("..")
      else
        if /#{@extension}$/.match(file)
          puts "adding size of #{file} to total size"
          @count += File.stat(file).size
        end
      end
    end
  end
end
