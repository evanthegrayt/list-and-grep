# list-and-grep
I often found myself searching for files in my current directory, and while
`find . -iname "*file*"` is great for recursive searching, and `ls | grep
[PATTERN]` works, I kept having to chain shell commands together to get the
exact bahavior I wanted. Rather than creating a bunch of aliases, I decided to
mae life easier and just create a script that handled the options for me.

## Installation
From your terminal, clone the repository where you want it.
```sh
git clone https://github.com/evanthegrayt/list-and-grep.git
```
#### Rake
If you have `rake` installed (`gem install rake`), from inside the base
repository directory, run:
```sh
rake
```
This will link the executable in your path (`/usr/local/bin`).

To uninstall, run `rake uninstall`

#### Manual
If you aren't using `rake`, you can link the executable yourself. From inside
the base repository directory, run:
```sh
ln -s $PWD/bin/lsg /usr/local/bin/lsg
```
To uninstlal, run `rm /usr/local/bin/lsg`

## Updating
From the base directory, run:
```sh
rake update
```
OR
```sh
git pull origin master
```
## Usage
Just pass the search pattern as an argument.
```sh
lsg [PATTERN]
```
To see a list of behavior-modifying
options, run `lsg -h`, or for the manual, run `lsg --man`.

