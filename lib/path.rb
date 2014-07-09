class Path < String

	def initialize(string = Path.root)
		super(string)
	end

	def /(obj)
		Path.new(File.join(self, obj.to_s))
	end

	def +(obj)
		Path.new(self.to_s + obj.to_s)
	end

	def exist?
		File.exists?(self)
	end
	
	alias exists? exist?

	def directory?
		File.directory?(self)
	end

	def file?
		exist? && !directory?
	end

	def files(pattern = "*")
		if directory?
			Dir.glob(File.join(self, pattern)).collect{|p|Path.new(p)}
		else
			raise "Not a directory:(#{self})"
		end
	end

	def read
		if file?
			File.open(self).read
		else
			raise "Not a file:(#{self})"
		end
	end

	def directory
		File.dirname(self)
	end

	def file
		File.basename(self)
	end

	def extension
		File.extname(self)[1..-1]
	end

	def filename
		File.basename(self, File.extname(self))
	end

	def inspect
		"#<Path:#{(object_id * 2).to_s(16)}:#{self}>"
	end

	def self.relative
		path = get_path_from_caller(caller)
		dir = File.dirname(path)
		raise "Path doesn't seem to exist:#{last_call.inspect}" if !File.exist?(dir)
		Path.new(dir)
	end

	def self.home
		Path.new(ENV['HOME'])
	end

	def self.root
		Path.new("/")
	end

	def self.pwd
		Path.new(Dir.pwd)
	end

	private

	def self.get_path_from_caller(caller)
		last_call = caller.first
		matches = last_call.scan(/(.*?):(\d*)(:in\s`.*')?$/)
		raise "Path name conflicts with caller syntax:#{last_call.inspect}" if matches.length != 1
		path, line_number, method = matches.first
		path
	end

end

class String
	def to_path
		Path.new(self)
	end
end