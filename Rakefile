require 'rake'
require 'fileutils'

DOTFILES = {
  ".bash_profile" => Dir.home,
  ".gitconfig" => Dir.home,
  ".vimrc" => Dir.home,
  ".zshrc" => Dir.home,
  ".tmux.conf" => Dir.home,
}

DOTFILES_DIR = "#{Dir.home}/github/dotfiles"

desc "Install dotfiles"
task :install do
  puts "Just starting"

  DOTFILES.each_pair do |file, directory|
    symlink_dotfiles(file, directory)
  end

  #powerline modifcation
  powerline_loc = `pip3 show powerline-status | grep Location | awk '{print $2}'`.strip
  if powerline_loc != ""
    File.open("#{Dir.home}/.zshrc", 'a') do |zshrc|
      zshrc.puts "export POWERLINE_LOC=\"#{powerline_loc}\""
      zshrc.puts "export PATH=\"$PATH:$POWERLINE_LOC/../../../bin/\""
    end

    `ln -nfs #{DOTFILES_DIR}/settings/powerline-default.json #{powerline_loc}/powerline/config_files/themes/tmux/default.json`
  else
    puts "powerline-status not found"
  end

  install_fonts

  puts "Install vundle"
  `mkdir -p ~/.vim/bundle`
  `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  puts "====================="

  puts "Install vim color scheme"
  `mkdir -p ~/.vim/colors`
  `cp -f #{DOTFILES_DIR}/vim/kolor.vim ~/.vim/colors/kolor.vim`
  puts "====================="

  puts "import iterm2 settings"
  `cp -f #{DOTFILES_DIR}/settings/com.googlecode.iterm2.plist ~/Library/Preferences/`
  `defaults read com.googlecode.iterm2`
  puts "===================="

  puts "import terminal.app settings"
  `open #{DOTFILES_DIR}/settings/solarized-custom.terminal`
  puts "===================="

  puts "===================="
  puts "===== Finished ====="
  puts "===================="
end

def symlink_dotfiles(file, directory)
  puts "Processing #{file}"
  source = "#{DOTFILES_DIR}/#{file}"
  target = "#{directory}/#{file}"

  puts "Source: #{source}"
  puts "Target: #{target}"

  if File.exists?(target) && (!File.symlink?(target) ||
                              (File.symlink?(target) && File.readlink(target) != source))
    puts "[Overwriting] #{target}...backing up at #{target}.bak..."
    `mv "#{directory}/#{file}" "#{directory}/#{file}.bak"`
  end

  `ln -nfs "#{source}" "#{target}"`

  puts "=========================================================="
  puts
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for tmux Powerline."
  puts "======================================================"
  `cp -f #{DOTFILES_DIR}/fonts/* $HOME/Library/Fonts ` if RUBY_PLATFORM.downcase.include?("darwin")
  puts
end
