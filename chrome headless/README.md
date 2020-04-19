# Chrome headless

## Operation

### Commands

Parses commands from URLs in PDFs created from headless Chrome output.

### Exfil

Headless Chrome with GET params.

## Running it

For the CNC server, run:

    pipenv install
    pipenv run python server.py

Each time "rat-chrome.bat" runs on the target, it will get the last command
queued up in the server and run it, returning the result.
