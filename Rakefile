require 'rake'
require 'fileutils'

DOTFILES = {
  ".bash_profile" => Dir.home,
  ".gitconfig" => Dir.home,
  ".vimrc" => Dir.home,
  ".zshrc" => Dir.home,
  ".tmux.conf" => Dir.home,
}

desc "Install dotfiles"
task :install do
  puts "Just starting"

  DOTFILES.each_pair do |file, directory|
    symlink_dotfiles(file, directory)
  end

  #powerline modifcation
  powerline_loc = `pip show powerline-status | grep Location | awk '{print $2}'`
  if powerline_loc.present?
    File.open("#{Dir.home}/.zshrc", 'a') do |zshrc|
      zshrc.puts "export POWERLINE_LOC=\"#{powerline_loc}\""
      zshrc.puts "export PATH=\"$PATH:$POWERLINE_LOC/../../../bin/\""
    end
  end

  install_fonts

  puts "===================="
  puts "===== Finished ====="
  puts "===================="
end

def symlink_dotfiles(file, directory)
  files.each do |f|
    puts "Processing #{file}"
    source = file
    target = "#{directory}/#{file}"

    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) ||
                                (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...backing up at #{target}.bak..."
      run %{ mv "#{directory}/.#{file}" "#{directory}/.#{file}.bak" }
    end

    run %{ ln -nfs "#{source}" "#{target}" }

    puts "=========================================================="
    puts
  end
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for tmux Powerline."
  puts "======================================================"
  run %{ cp -f $HOME/github/dotfiles/fonts/* $HOME/Library/Fonts } if RUBY_PLATFORM.downcase.include?("darwin")
  puts
end
