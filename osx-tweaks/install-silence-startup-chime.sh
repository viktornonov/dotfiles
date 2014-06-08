#works on OSX 10.9.5
#silence on logout
sudo chown root silence.sh
sudo chmod u+s silence.sh
sudo chmod o+x silence.sh
sudo cp silence.sh /Library/Scripts/
sudo defaults write com.apple.loginwindow LogoutHook /Library/Scripts/silence.sh
#back to normal on login
sudo chown root turn-vol-up.sh
sudo chmod u+s turn-vol-up.sh
sudo chmod o+x turn-vol-up.sh
sudo cp turn-vol-up.sh /Library/Scripts/
sudo defaults write com.apple.loginwindow LoginHook /Library/Scripts/turn-vol-up.sh
