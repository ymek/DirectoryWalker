class DirectoryWalker
  attr_accessor :dir_name, :extension, :count

  def initialize(dir_name, extension = '.')
    @dir = dir_name
    @count = 0
    @extension = extension
  end

  def calculate
    calculate_dirs(@dir, extension)
    puts "Total size is: #{@count}"
  end

  def calculate_dirs(dirname, extension = '')
    files = Dir.entries(dirname)
    Dir.chdir(dirname)

    files.each do |file|
      if file == "." || file == ".."
        next
      elsif File.ftype(file) == "directory"
        calculate_dirs(file, extension)
        Dir.chdir("..")
      else
        if /#{extension}$/.match(file)
          puts "adding size of #{file} to total size"
          @count += File.stat(file).size
        end
      end
    end
  end
end
