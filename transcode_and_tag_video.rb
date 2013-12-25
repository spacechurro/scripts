#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'

download_path = ARGV[0]

def video_file?(file_path)
  file_path =~ /\.(avi|mkv|mp4|m4v)$/
end

def needs_transcoding?(file_path)
  file_path !~ /\.(mp4|m4v)$/
end

file_paths = Dir.glob("#{download_path}/*").select { |file_path| video_file?(file_path) }

file_paths.each do |file_path|
  dir = File.dirname(file_path)
  file_name = File.basename(file_path)

  if needs_transcoding?(file_name)
    mp4_file_name = file_name.gsub(/\.[^\.]+$/, '.mp4')
    mp4_file_path = "#{dir}/#{mp4_file_name}"
    `HandBrakeCLI -i "#{file_path}" -o "#{mp4_file_path}"`
    FileUtils.mv(file_path, '/Users/sergio/.Trash/')
  else 
    mp4_file_path = file_path
  end

 `open "#{mp4_file_path}" -a /Applications/iDentify.app`
 FileUtils.mv(mp4_file_path, '/Users/sergio/Music/iTunes/iTunes Media/Automatically Add to iTunes.localized/')
end
