#!/usr/bin/env ruby

def select_pen(pen_id)
  puts "Pen ID #{pen_id} selected"
end

def pen_down
  puts 'Pen down on canvas'
end

def pen_up
  puts 'Lifted pen from canvas'
end

def draw(direction, distance)
  puts "Drawn #{distance} units in direction #{direction}"
end

commands = [
  { symbol: 'P', has_arguments: true,  command: method(:select_pen).to_proc },      # Select a pen (pen ID)
  { symbol: 'D', has_arguments: false, command: method(:pen_down).to_proc },        # Put pen down on canvas
  { symbol: 'U', has_arguments: false, command: method(:pen_up).to_proc },          # Lift pen up from canvas
  { symbol: 'W', has_arguments: true,  command: method(:draw).to_proc.curry['W'] }, # Draw west `x` units
  { symbol: 'N', has_arguments: true,  command: method(:draw).to_proc.curry['N'] }, # Draw north `x` units
  { symbol: 'E', has_arguments: true,  command: method(:draw).to_proc.curry['E'] }, # Draw east `x` units 
  { symbol: 'S', has_arguments: true,  command: method(:draw).to_proc.curry['S'] }  # Draw south `x` units
]

# Read and execute a pen file
pen_file_path = ARGV[0]
pen_commands = File.readlines(pen_file_path)

parsed_commands = pen_commands.map do |pen_command_line|
  pen_command_line.match /^(.)\s*([^\s\#]*)/
  { symbol: $1, arguments: $2 }
end

# Execute the correct commands
parsed_commands.each do |parsed_command|
  matched_command = commands.select { |command| command[:symbol] == parsed_command[:symbol] }.first

  puts "Command symbol, #{parsed_command[:symbol]}, not found" if matched_command.nil?
  
  if matched_command[:has_arguments] then
    matched_command[:command].call(parsed_command[:arguments])
  else
    matched_command[:command].call
  end
end
