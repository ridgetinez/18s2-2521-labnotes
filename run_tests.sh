#!/bin/sh

# COMP2521 W9 Geodata
# Testing suite provided by Emily Chen 17s2
# Extended by Adrian Martinez 18s2

# Test 1
echo "==== ./travel Berlin Chicago ===="
./travel Berlin Chicago > /tmp/out
diff /tmp/out exp/test1
# Test 2
echo "=== ./travel Sydney Chicago ==="
./travel Sydney Chicago > /tmp/out
diff /tmp/out exp/test2
# Test 3
echo "==== ./travel Sydney London ===="
./travel Sydney London > /tmp/out
diff /tmp/out exp/test3
# Test 4
echo "==== ./travel London Sydney ===="
./travel London Sydney > /tmp/out
diff /tmp/out exp/test4
# Test 5
echo "==== ./travel Sydney 'Buenos Aires' ===="
./travel Sydney 'Buenos Aires' > /tmp/out
diff /tmp/out exp/test5
# Test 6
echo "==== ./travel Sydney London 6000 ===="
./travel Sydney London 6000 > /tmp/out
diff /tmp/out exp/test6
# Test 7
echo "==== ./travel Sydney 'Buenos Aires' 5000 ===="
./travel Sydney 'Buenos Aires' 5000 > /tmp/out
diff /tmp/out exp/test7
# Test 8
echo "==== ./travel Sydney 'Buenos Aires' 7000 ===="
./travel Sydney 'Buenos Aires' 7000 > /tmp/out
diff /tmp/out exp/test8
# Test 9
echo "==== ./travel Sydney 'Buenos Aires' 8000 ===="
./travel Sydney 'Buenos Aires' 8000 > /tmp/out
diff /tmp/out exp/test9
# Test 10
echo "==== ./travel Sydney 'Buenos Aires' 11000 ===="
./travel Sydney 'Buenos Aires' 11000 > /tmp/out
diff /tmp/out exp/test10
# Test 11
echo "==== ./travel Sydney 'Buenos Aires' 12000 ===="
./travel Sydney 'Buenos Aires' 12000 > /tmp/out
diff /tmp/out exp/test11
# Test 12
echo "==== ./travel Bombay Chicago 5000 ===="
./travel Bombay Chicago 5000 > /tmp/out
diff /tmp/out exp/test12
# Test 13
echo "==== ./travel Sydney Sydney ===="
./travel Sydney Sydney > /tmp/out
diff /tmp/out exp/test13
# Test 14
echo "==== ./travel Azores Tokyo 4988 ===="
./travel Azores Tokyo 4988 > /tmp/out
diff /tmp/out exp/test14
echo "==== ./travel Azores Tokyo 4987 ===="
./travel Azores Tokyo 4987 > /tmp/out
diff /tmp/out exp/test15
echo "==== ./travel Azores Melbourne 5310 ===="
./travel Azores Melbourne 5310 > /tmp/out
diff /tmp/out exp/test16
