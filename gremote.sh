#!/bin/bash

case $1 in
 -[h] | --help)
    cat <<-helpDoc
    usage: gremote.sh [ --help ] [ --info ] [ --version ]
        
         This script runs in non-interactive mode, with no arguments. 
         Simply ensure your current directory is a git initialised directory.

         -h | --help 	: Display this help message.
         -i | --info 	: Display important information about this script.
         -v | --version : Display the version number of this script.
	helpDoc
        exit 0;;
esac
case $1 in
 -[i] | --info)
    cat <<-infoDoc
------------------------------------ gremote ------------------------------------
         Open the configured remote url for your current repo, whether 
         it be SSH or HTTPS, directly from the terminal.
         
		 Licensed under the MIT License (MIT)
         Copyright (c) 2017 cognophile (https://github.com/cognophile)

         To display help, use the '-h' or '--help' option.
------------------------------------ gremote ------------------------------------
	infoDoc
        exit 0;;
esac
case $1 in
 -[v] | --version)
    cat <<-versionDoc
    gremote version: 1.1.0
	versionDoc
        exit 0;;
esac


getRemote ()
{
    local remote=$(git config --get remote.origin.url)
    
	if [[ -z $remote ]]; then
		echo "ERROR: Your remote appears to be invalid or unset."
		exit 1
	else 
		if [[ $remote == *"@"* ]]; then
			convertToHttps $remote
		else
			openUrl $remote
		fi
	fi
}

stripSsh ()
{
    local remote=$1
    
	local trimGitSuffix=${remote%.git}
    local trimSshPrefix=${trimGitSuffix#*@}
	
    local urlFormat=${trimSshPrefix//:/\/}
    echo $urlFormat
}

openUrl ()
{
	local url=$1
    local os=$(uname)

	if [[ -z $url ]]; then
		echo "ERROR: The URL cannot be opened."
		exit 1
	else 
		if [[ $os == "Darwin" ]]; then
            open $url
        else 
            xdg-open $url
        fi
	fi
}

convertToHttps ()
{
    local remote=$1
    local httpsPrefix="https://"

    local urlNoSsh=$(stripSsh $remote)	
	
    local url="${httpsPrefix}${urlNoSsh}"
    
    openUrl $url
}

# Entry point after function declarations 
if [[ ! -d .git ]]; then
	echo "ERROR: You appear not to be in a git directory."
	exit 1
else
	getRemote
fi