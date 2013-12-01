class DirectoryWalker
  attr_accessor :directory, :extension, :count

  def initialize(directory, extension = nil)
    @directory = directory
    @count = 0
    @extension = extension
  end

  def find_size
    directory_walk(@directory)
    puts "Total size is: #{@count}"
  end

  def directory_walk(directory)
    Dir.foreach(directory) do |filename|
      next if %w(. ..).include?(filename)

      file = File.join(directory, filename)
      if File.directory?(file)
        directory_walk(file)
      else
        add_file(file)
      end
    end
  end

  def add_file(file)
    if @extension.nil? || File.extname(file).eql?(@extension)
      puts "adding size of #{file} to total size"
      @count += File.stat(file).size
    end
  end
end
