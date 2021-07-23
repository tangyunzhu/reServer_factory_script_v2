import os
import time
import subprocess
from FileControl import fileOperate





cmd1 = "sudo ethtool enp3s0"
cmd2 = "sudo ethtool enp4s0"
SpeedTxt = "Speed: 2500Mb/s"

def subprocess_check(cmd,checkTxt):
	p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
	log = p.stdout.read()
	print log
	if checkTxt in log:
		return True
	else:
		return False

print subprocess_check(cmd1,SpeedTxt)
print subprocess_check(cmd2,SpeedTxt)
