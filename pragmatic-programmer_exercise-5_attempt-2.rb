#!/usr/bin/env ruby

draw = Proc.new do |direction, distance|
  "Drawn #{direction} #{distance} units"
end

commands = {
  'P' => Proc.new { |pen_id| "Selected pen #{pen_id}" },
  'D' => Proc.new { 'Put pen down onto the canvas' },
  'W' => draw.curry['west'],
  'N' => draw.curry['north'],
  'E' => draw.curry['east'],
  'S' => draw.curry['south'],
  'U' => Proc.new { 'Lifted pen from the canvas' }
}

# Parse input file
ARGF.each_with_index do |line, line_number|
  line.match /\A(\w) ([^ ])* .*\Z/ do |match|
    command_key = $1
    command_argument = $2
    if commands.has_key? command_key
      command_output = commands[command_key].call(command_argument)
      puts command_output
    else
      # Line number is 0 indexed, need to increment it
      raise "An unrecognized command, '#{command_key}', was found on line #{line_number + 1}"
    end
  end
end
