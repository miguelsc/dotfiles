ST2="$HOME/Library/Application Support/Sublime Text 2"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p "$ST2/Installed Packages"
mkdir -p "$ST2/Packages/User"

curl http://sublime.wbond.net/Package%20Control.sublime-package > "$ST2/Installed Packages/Package Control.sublime-package"

cp $DIR/files/* "$ST2/Packages/User"