#!/usr/bin/bash

echo "==========Parse result for test.t:=========="
./parse test.t
echo " "

for i in {1..7}
do
	echo "==========Parse result for test$i.t:=========="
	echo " "
	./parse test$i.t
	echo " "
done

