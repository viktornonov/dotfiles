#!/usr/bin/env ruby
COMMAND = "gcc -Wall -Wextra -pedantic -std=c11"

COLOR_OFF = "\e[0m"     # Text Reset
RED       = "\e[31m"    # Red
GREEN     = "\e[32m"    # Green

require 'listen'

listener = Listen.to('.', only: /\.c/) do |modified, added, removed|
  file = modified.first #I care only for the first
  puts "Modified #{file}"

  `#{COMMAND} #{file}`
  if $?.exitstatus == 0
    puts "#{GREEN}> Executing#{COLOR_OFF}"
    Kernel.system "./a.out"
  else
    puts "#{RED}> Not executing#{COLOR_OFF}"
  end
  puts "\n" + "-"*30 + "\n"
end

listener.start
sleep
