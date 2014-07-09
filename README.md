camino
======

Sugar syntax for your path handling.

    File.open(File.join(File.dirname(__FILE__), "my_file.txt")).read
    #becomes
    ( Path.realative / "my_file.txt" ).read


Generate Paths using the following methods
    
    "/my_path".to_path
    Path.new("/my_path")
    Path.relative
    Path.root
    Path.home
    Path.pwd

Once you have created a Path object you can use the / and + operators with them.  All arguments get cast to strings.

    Path.home / "folder" / 123 + ".txt" #=> "/Users/me/folder/123.txt"

You can perform various tests on paths

    path.exist?
    path.directory?
    path.file?
    
If a path exists you can do some work with it.
  
    if path.file?
      path.read #=>File contents
    elsif path.directory?
      path.files #=>An array of path objects
    end

Path inherits from string so you can still handle it like you would any other string.

    require(Path.home/"my_script.rb")
    
