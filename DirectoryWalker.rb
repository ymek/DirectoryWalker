class DirectoryWalker
  attr_accessor :dir_name, :extension, :count

  def initialize(dir_name, extension)
    @dir = dir_name
    @count = 0
    @extension = extension
  end

  def calculate
    if @extension == nil
      @extension = "."
    end
    calculate_dirs(@dir, @extension)
    puts "Total size is: #{@count}"
  end

  def calculate_dirs(dirname, extension="")
    files = Dir.entries(dirname)
    Dir.chdir(dirname)

    files.each do |x|
      if x == "." || x == ".."
        next
      elsif File.ftype(x) == "directory"
        calculate_dirs(x, extension)
        Dir.chdir("..")
      else
        if /#{extension}$/.match(x)
          puts "adding size of #{x} to total size"
          @count += File.stat(x).size
        end
      end
    end
  end
end
