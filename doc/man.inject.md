% INJECT(1) Bashism Inject User Manuals
% Jiri Kozlovsky
% August 7, 2017

# NAME

inject - BASH dependecy injection solution

# SYNOPSIS

. inject [*module*]...

# DESCRIPTION

Inject helps you maintain readability of your scripts by enabling you to split
reusable code into minor functions, which can be loaded into anywhere.

It looks for injectables into predefined set of directories in this order:

* *~/.bashism/injectable* (user's local injectables)
* */usr/local/lib/bashism/injectable* (global injectables)
* */usr/lib/bashism/injectable* (package included)

These scripts should always export only functions to your scope and should
have multi import protection.

Function names being exported are up to you, but it is a good practice to
export functions named under exactly the same name as the module.

To get a good example, how to write injectables, please see one of the included
in directory */usr/lib/bashism/injectable*.

Multiple modules can be specified to import:

    . inject getSudo isBashScript

# OPTIONS

No options supported yet.

# BUILT-IN MODULES

## getSudo

Imports function named "getSudo", which asks user for sudo with default message, unless there is any argument provided to it. In that case, all the arguments are used to build a string for the sudo prompt.

This is best usable when you are using *sudo* in your script after some period of time, so that the program gets the sudo at the start of the script & doesn't asks again in the middle.

## isBashScript

Imports function named "isBashScript", which can be used to determine, if a file exists and has one of the following bash headers:

* <span>#!/bin/bash</span>
* <span>#!/usr/bin/env bash</span>

Can be used as follows:

    #!/bin/bash
    . inject isBashScript

    if isBashScript "$0"; then
        echo "I'm a BASH script ! :)"
    else
        echo "I'm not a BASH script :("
    fi

## hostnamePingable

Imports function named "hostnamePingable", which can be used to determine, if an destination host is online or visible by the client:

    #!/bin/bash
    . inject hostnamePingable

    if hostnamePingable "www.google.com"; then
        echo "Google is online !"
    else
        echo "Google is down :("
    fi

## commandExists

Imports function named "commandExists", which can be used to determine, if there exists any runnable command given as argument (may be an alias, function or executable file in PATH):

    #!/bin/bash
    . inject commandExists

    if commandExists "jq"; then
        echo "Nice one, you have already tried parsing JSON in BASH!"
    else
        echo "Hey man, try installing 'jq' ;) It's great !"
    fi

# SEE ALSO

`bash` (1).

The Bashism source code and all documentation may be downloaded from
<https://www.github.com/jirislav/bashism>.
