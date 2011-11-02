#!/usr/bin/env ruby
require 'fileutils'

tv_show_pattern = /^([\w\. ]+)[ -]*s(\d+)/i
download_path = ARGV[0]
library_path = ARGV[1]
Dir.entries(download_path).select { |filename| (filename =~ /\.avi$/ || filename =~ /\.mkv$/) && filename =~ tv_show_pattern }.each do |filename|
  match_data = tv_show_pattern.match(filename)
  show_name = match_data[1].gsub('.', ' ').split.each { |word| word.capitalize! }.join(" ")
  season = match_data[2].sub(/^0+/, '')
  #puts show_name + " - " + season


  show_path = "#{library_path}/#{show_name}"
  season_path = "#{show_path}/Season #{season}"
  puts show_path
  puts "#{season_path}/#{filename}"

  File.directory?(show_path) || Dir.mkdir(show_path)
  File.directory?(season_path) || Dir.mkdir(season_path)
  FileUtils.mv("#{download_path}/#{filename}", "#{season_path}/#{filename}")
end
