#!/bin/bash

cd /home/te/factoryScript
echo "" > dut_test.log
line="\r\n----------reServer factory testing[20210901-v1.1]-----------\r\n"
echo $line >> dut_test.log
echo -e $line

#./auto_disk
#r1=$?
./auto_sram
r2=$?
#./auto_eth
./auto_iperf $(cat /home/te/Desktop/iperf_server)
r3=$?
if [ $r3 -ne 0 ]; then
	./auto_iperf $(cat /home/te/Desktop/iperf_server)
	r3=$?
fi

./auto_disk
r1=$?


./auto_usb_n
r4=$?
if [ $r4 -ne 0 ]; then
	./auto_usb_n
	r4=$?
fi
./auto_wifi
r5=$?
./auto_samd21
r6=$?
./tty_pairs ttyS0,ttyS1
r7=$?
if [ $r7 -eq 0 ]; then
	echo "COM1&2 test OK" >> dut_test.log
fi

((result=$r1+$r2+$r3+$r4+$r5+$r6+$r7))
#echo $result
if [ $result -eq 0 ]; then
	logName1=$(cat eth1_address)_$(date +%Y%m%d-%H-%M-%s)_pass.log
	logName2=$(cat eth2_address)_$(date +%Y%m%d-%H-%M-%s)_pass.log
	echo "----------------------------------"
	echo "-                                -"
	echo "-           P A S S              -"
	echo "-                                -"
	echo "----------------------------------"
else
        logName1=$(cat eth1_address)_$(date +%Y%m%d-%H-%M-%s)_fail.log
        logName2=$(cat eth2_address)_$(date +%Y%m%d-%H-%M-%s)_fail.log
        echo "----------------------------------"
        echo "-                                -"
        echo "-     !!! F A I L !!!            -"
        echo "-                                -"
        echo "----------------------------------"

fi

Name1=$(echo $logName1 | sed 's/-//g' | sed 's/ //g' | sed 's/://g')
Name2=$(echo $logName2 | sed 's/-//g' | sed 's/ //g' | sed 's/://g')
echo $Name1
echo $Name2
cat dut_test.log > $Name1
cat dut_test.log > $Name2

python3 alicloud_upload.py $Name1 $Name1
python3 alicloud_upload.py $Name2 $Name2 
sleep 2
mv $Name1 log
mv $Name2 log
