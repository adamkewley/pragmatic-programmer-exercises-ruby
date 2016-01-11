#!/usr/bin/env ruby

# Halfway though the book, we realized we hadn't put a use strict
# directive into many of our Perl examples. Write a script that
# goes through the .pl files in a directory and adds a use strict
# at the end of the initial comment block to all files that don't
# already have one. 

require 'fileutils'

directory_to_scan = ARGV[0] ||= '.'

Dir.chdir directory_to_scan
Dir.glob '*.pl' do |perl_file_path|
  FileUtils.copy_file perl_file_path, "#{File.basename perl_file_path}.bak"

  perl_file_content = File.read perl_file_path

  if perl_file_content !~ /^use strict;/m
    first_non_comment_line_index = perl_file_content.index /^\s*[^#]/

    output_file =  perl_file_content.insert(first_non_comment_line_index, "use strict;\n")
    puts output_file
  else
    puts "File #{perl_file} contains a use strict statement, ignoring"
  end

end
