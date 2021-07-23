import os
import linecache
import time

print "DUT enp2s0 speed test"
os.system("echo "" > iperf_enp2s0.log")
#os.system("ifconfig enp1s0 down")
#os.system("ifconfig enp2s0 up")
time.sleep(1)
#os.system("dhclient enp2s0")
time.sleep(5)
os.system("iperf3 -c 192.168.235.110 > iperf_enp2s0.log")
os.system("sync")
the_line = linecache.getline('iperf_enp2s0.log',16)
print the_line
if not "Gbits/sec" in the_line:
	quit(2)
print "enp2s0 speed is: " + the_line[38:42]


print "\r\nenp1s0 speed test"
os.system("echo "" > iperf_enp1s0.log")
#os.system("ifconfig enp1s0 up")
#os.system("ifconfig enp2s0 down")
time.sleep(1)
#os.system("dhclient enp1s0")
time.sleep(5)
os.system("iperf3 -c 192.168.234.110 > iperf_enp1s0.log")
os.system("sync")
the_line = linecache.getline('iperf_enp1s0.log',16)
print the_line
if not "Gbits/sec" in the_line:
	quit(3)
print "enp1s0 speed is: " + the_line[38:42]

