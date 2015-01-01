# ben - for your koans and mine

tool for sharing tutorial packages (koans)

## Features

* Easy install
* Langauge independent
* Simple API to share koan packages

## Install

Copy-paste and run the following lines in your terminal

```
git clone https://github.com/HashNuke/zen.git ~/.zen
echo 'export PATH="$HOME/.asdf/bin:$PATH"' >> ~/.bash_profile
```

## Installing koan packages

```
ben
# runs koans in the current koan package
# runs the koans

#
ben install <name> <git-url>
ben uninstall <name>

# List all koan packages
ben list

ben set <name>
ben help <name>
ben show


# Create a new project to start learning*
ben new <name> <path>
```

**not all koan packages might support the `new` command*

## Writing your own koan packages

ben doesn't care about language you write the koan packages in. They must have the following files:

* `bin/ben-help`
* `bin/ben-run`


### `bin/ben-help`

Must display useful help message about the koan package. This is run when `ben help foo` is run, where foo is the name.


### `bin/ben-run`

Must run programs in the current package. Must exit with non-zero exit status on first failure, along with a useful message. This script is run when the `ben` command is run. It will be passed the current working directory as an argument.


### `bin/ben-new` (optional)

If the koan package requires creating a project dir in order for the user to work, this is a must to implement.

For example if the koan package is for nginx, then there's probably nothing that the user needs to create a new dir for. Instead the user would be using the system's nginx installation and config. And the koans could be used to test them.

But if you want to teach the user some language, then it might be useful to instead have a seperate directory for the user's work.

* The `bin/ben-new` script is run when the user runs `ben new foo ~/projects/learn-foo`
* Expected to generate a project dir at user-specified path, with whatever files required

The user would then `cd` into this path to run the `ben` command to work through the tutorial. This script could be as simple as copying template files from the koan package to the user specified dir.

**If your koan package requires the user to create a seperate project dir, then the generated project dir must contain a `ben.config` file**, with the following info

```
ben_package_name=foo
```

where `foo` is the ben package which created the project


## Copyright

Copyright Akash Manohar ([@HashNuke](http://twitter.com/HashNuke)), under the MIT License
(basically do whatever you want)
