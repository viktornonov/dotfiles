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
  powerline_loc = `pip3 show powerline-status | grep Location | awk '{print $2}'`.strip
  if powerline_loc != ""
    File.open("#{Dir.home}/.zshrc", 'a') do |zshrc|
      zshrc.puts "export POWERLINE_LOC=\"#{powerline_loc}\""
      zshrc.puts "export PATH=\"$PATH:$POWERLINE_LOC/../../../bin/\""
    end

    #try symlink
    `cp -f ~/github/dotfiles/powerline-default.json #{powerline_loc}/powerfile/config_files/themes/tmux/default.json`
  else
    puts "powerline-status not found"
  end

  install_fonts

  `mkdir -p ~/.vim/bundle`
  `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  `mkdir -p ~/.vim/colors`
  `cp -f ~/github/dotfiles/vim/kolor.vim ~/.vim/colors/kolor.vim`

  puts "import iterm2 settings"
  #TODO[VN] try symlink
  `cp -f ~/github/dotfiles/settings/com.googlecode.iterm2.plist ~/Library/Preferences/`
  `defaults read com.googlecode.iterm2`

  puts "import terminal.app settings"
  `open ~/github/dotfiles/settings/solarized-custom.terminal`

  puts "===================="
  puts "===== Finished ====="
  puts "===================="
end

def symlink_dotfiles(file, directory)
  puts "Processing #{file}"
  source = "#{Dir.home}/github/dotfiles/#{file}"
  target = "#{directory}/#{file}"

  puts "Source: #{source}"
  puts "Target: #{target}"

  if File.exists?(target) && (!File.symlink?(target) ||
                              (File.symlink?(target) && File.readlink(target) != source))
    puts "[Overwriting] #{target}...backing up at #{target}.bak..."
    `mv "#{directory}/.#{file}" "#{directory}/.#{file}.bak"`
  end

  `ln -nfs "#{source}" "#{target}"`

  puts "=========================================================="
  puts
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for tmux Powerline."
  puts "======================================================"
  `cp -f $HOME/github/dotfiles/fonts/* $HOME/Library/Fonts ` if RUBY_PLATFORM.downcase.include?("darwin")
  puts
end
