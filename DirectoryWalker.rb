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
    Dir.foreach(dirname) do |filename|
      next if %w(. ..).include?(filename)

      file = File.join(dirname, filename)

      if File.directory?(file)
        calculate_dirs(file)
      else
        handle_file(file)
      end
    end
  end

  def handle_file(file)
    if /#{@extension}$/.match(file)
      puts "adding size of #{file} to total size"
      @count += File.stat(file).size
    end
  end
end
