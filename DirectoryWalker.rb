class DirectoryWalker
  attr_accessor :directory, :extension, :count

  def initialize(directory, extension = nil)
    @directory = directory
    @count = 0
    @extension = extension
  end

  class << self
    def readable_path?(path)
      File.exists?(path) && File.readable?(path)
    end

    def valid_directory?(dir_path)
      (real_path = File.realdirpath(dir_path)) &&
        DirectoryWalker.readable_path?(real_path) &&
        File.directory?(real_path)
    end

    def valid_file?(file_name)
      (real_path = File.realdirpath(file_name)) &&
        DirectoryWalker.readable_path?(real_path) &&
        File.file?(real_path)
    end
  end

  def find_size
    directory_walk(@directory)
    puts "Total size is: #{@count}"
  end

  def directory_walk(directory)
    Dir.foreach(directory) do |filename|
      next if %w(. ..).include?(filename)

      file = File.join(directory, filename)
      if DirectoryWalker.valid_directory?(file)
        directory_walk(file)
      elsif DirectoryWalker.valid_file?(file)
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
