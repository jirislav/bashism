# Bashism

This debian package serves to enhance BASH scripting.

For now, there is only an `inject` script.

## /usr/bin/inject

Inject is a bash dependency injector, which handles injecting/importing/using another library with desired functionality into currently running code to reduce duplicate code across all your scripts.

You may create your own injectable library easily!

It is similar to `source`, but there is no need to specify a path to a script. Injected dependency is instead looked up in a series of directories in this order:
- ~/.bashism/injectable/
- /usr/local/lib/bashism/injectable/
- /usr/lib/bashism/injectable/

Example for global injectable:
```
sudo tee -a /usr/local/lib/bashism/injectable/joke <<EOF
#!/bin/bash

joke() {
	curl -s https://api.icndb.com/jokes/random | jq -r ".value.joke"
}
EOF
```

Then just launch:
```
. inject joke
```

And you may use your imported command !
```
$ joke
Chuck Norris sheds his skin twice a year.
```

Example for user only injectable:
```
mkdir ~/.bashism/injectable -p
tee -a ~/.bashism/injectable/secret-weapon <<EOF
#!/bin/bash

iwonttellyou() {
	echo "------------------------"
	echo " My top secret weapon ! "
	echo "------------------------"
	sleep 2
	ps faux | grep "ssh" -A15 --color
}
EOF
```

Afterwards it may be injected into any BASH only under current user:
```
. inject secret-weapon
```

And used:
```
iwonttellyou
```

### Built in injectables

- getSudo
- isBashScript
- commandExists

#### getSudo

Example usage in a script:

```
#!/bin/bash

. inject getSudo

getSudo "Now you will be prompted for sudo, we need it to mount nfs4"

echo ...
echo "Providing some time expensive operations"
sleep 3

echo "It's always better to ask for sudo at the start of the script!"
sleep 1

echo "Imagine you start some time expensive script and after 3-4 minutes it prompts sudo pass, will you notice ?"
sleep 1

echo "I wouldn't notice, because I'm not wasting time on watching non-interactive jobs ..."
sleep 120

sudo mount | egrep -o "/boot"

echo Script done !
```

#### isBashScript

Example:

```
#!/bin/bash

. inject isBashScript

if isBashScript /usr/lib/bashism/injectable/getSudo; then
	echo "Wow! getSudo injectable is a BASH script !"
else
	echo "Hmm, this is not a bash script, sorry !"
fi
```


#### commandExists

Example:

```
#!/bin/bash

. inject commandExists

if commandExists curl; then
	echo "Whoa! Let's curl some pages!"
else
	echo "Hmm, how about this?:"
	echo "sudo apt-get install curl -y"
fi
```

## Installation

### Build from sources
Install only debian building package
```
sudo apt-get install dpkg-dev
```

Run the build
```
make deb
```

The package can be found in `build` directory.

Or install the package right after it's build
```
make localtest
```


### Download builded package

Visit [releases page](https://github.com/jirislav/bashism/releases)
