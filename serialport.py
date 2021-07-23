import serial 
from time import sleep 
import time

s0= serial.Serial(port="/dev/ttyS0",baudrate=115200,bytesize=8,stopbits=1,timeout=1) 
s1= serial.Serial(port="/dev/ttyS1",baudrate=115200,bytesize=8,stopbits=1,timeout=1) 


s0.write("helloworld\r\n"); 
sleep(0.2) 
s=s1.readline().strip() 
print(s) 
if s=="helloworld":
	exit(0)
exit(1)
