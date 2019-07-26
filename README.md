# list-and-grep
I often found myself searching for files in my current directory, and while
`find . -iname "*file*"` is great for recursive searching, and `ls | grep
[PATTERN]` works, I kept having to chain shell commands together to get the
exact behavior I wanted. Rather than creating a bunch of aliases, I decided to
make life easier and just create a script that handled the options for me.

## Installation
From your terminal, clone the repository where you want it.
```sh
git clone https://github.com/evanthegrayt/list-and-grep.git
```
If you have `rake` installed (`gem install rake`), from inside the base
repository directory, run:
```sh
rake
```
This will link the executable in your path (`/usr/local/bin`).
If you aren't using `rake`, you can link the executable yourself. From inside
the base repository directory, run:
```sh
ln -s $PWD/bin/lsg /usr/local/bin/lsg
```

## Usage
Just pass the search pattern as an argument.
```sh
lsg [PATTERN]
```
To see a list of behavior-modifying
options, run `lsg -h`, or for the manual, run `lsg --man`.

## Configuration
You can create a file called `~/.lsgrc` to configure the way the script behaves.
Currently, the only configurations are for the output color.
```yaml
use_color: true        # Use colored output? (default: false)
color:     "\e[1;92m"  # The color used when showing matches (default: green)
```
Note that you are able to enable/disable colored output at runtime with the
`--[no-]color` option, which will override the boolean in the configuration
file.

