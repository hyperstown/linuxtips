#/bin/sh

FILE=~/.full_bash_history
if [ -f "$FILE" ]; then
    diff -u ~/.full_bash_history <(tail -n 500  ~/.bash_history) | grep -E "^\+[^+++]" | sed -E 's/^\+//' >> ~/.full_bash_history
else 
    touch .full_bash_history
    diff -u ~/.full_bash_history ~/.bash_history | grep -E "^\+[^+++]" | sed -E 's/^\+//' >> ~/.full_bash_history
fi

#to run this script on startup put it in /etc/profile.d/
#sudo cp ~/sync_bash_history.sh /etc/profile.d/
