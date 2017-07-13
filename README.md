# gremote
### Open the remote for the current repository directly from the terminal.

## What and why?
gremote is a Linux tool, allowing you to quickly access the online repository set as the remote on a local git repository. 

The great thing is - it's agnostic about provider and protocol. Whether your remote is configured via SSH or HTTPS, it will form a valid URL from the remote url.

## How do I use it? 
* Download the script. Store it where you please.
* Give your user execute permissions on it: `chmod u+x gremote.sh`
* Run the script with the path to wherever you stored it from within a valid local Git repository (eg. `~/gremote.sh`)

### Options
* `gremote.sh [ -h | --help ]`    : display the help message
* `gremote.sh [ -i | --info ]` 	  : display the information message
* `gremote.sh [ -v | --version ]` : display the current version
