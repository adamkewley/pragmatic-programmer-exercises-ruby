#!/usr/bin env ruby

=begin
Input file format:
  
  # Add a product
  # to the 'on order' list

  M AddProduct
  F id          int
  F name        char[30]
  F order_code  int
  E

  Example output - C

  /* Add a product */
  /* to the 'on-order' list */
  typedef struct {
    int  id;
    char name[30];
    int  order_code;
  } AddProductMsg;

  Example output - Pascal
  
  { Add a product }
  { to the 'on order' list }
  AddProductMsg = packed record
    id:         LongInt
    name:       array[0..29] of char;
    order_code: LongInt;
  end;

  
  Target output - C#

  // Add a product
  // to the 'on order' list
  class AddProductMsg {
    int       Id;
    char[]    Name = new char[30];
    int       OrderCode;
  }  

  Target output - F#

  // Add a product
  // to the 'on order' list
  type AddProductMsg = {
    id : int;
    name : char;
    orderCode : char[30];
  }
=end

output_format = ARGV.shift
file_to_convert = ARGF.read


require_relative "#{output_format}_generator"

current_record_identifier = ''
output = ""

file_to_convert.lines.each do |line|
  output << case line.chomp
  when /^\s*$/                  # Blank line
    Generator.blank_line
  when /^\s*#(.*)$/             # Comment, $1 = comment string
    Generator.comment($1)
  when /^\s*M\s*(\w+)$/         # Model def start, $1 = model name
    Generator.model_start($1)
  when /^\s*E\s*$/              # Model def end
    Generator.model_end
  when /^\s*F\s*(\w+)\s*(.+)$/  # Field def, $1 = field name, $2 = type
    Generator.field($1, $2)
  end
end

puts output
