#!/usr/bin/env python3

import serial
import pynmea2
import datetime

# local              GPS 
# 12:09:33.171015 == 12:09:32.935000

def parse_line(line_bytes):
  try:
    #print("line: %s" % line_bytes)
    parsed_data = pynmea2.parse(line_bytes.decode())
    #print("parsed: %s" % parsed_data)
    combined_gps_time = datetime.datetime.combine(parsed_data.datestamp, parsed_data.timestamp)

    return combined_gps_time

    #if (timeNow < timeGPS):
    #  print("clock is behind")
    #if (timeNow > timeGPS):
    #  print("clock is ahead")
    #print(parsed_data.__dict__)
  except Exception as e:
    print("bad line: %s" % e)


def test_perf():
  parse_line(b'$GPRMC,124120.000,V,,,,,,,111218,,,N*43')


print("testing performance of function")
import timeit
ts = timeit.timeit(test_perf, number=1000)
print(ts)
print("conversion time: %s" % (ts/1000))

with serial.Serial('/dev/ttyUSB0', 4800, timeout=60) as ser:
  while True: 
    while ser.inWaiting():
      line = ser.readline()
      #print(line)
      if line[0:6] == b'$GPRMC':
        os_time_utc = datetime.datetime.utcnow()
        results = parse_line(line[:-2])
        print("%s == %s == %s" % (os_time_utc, results, ""))

      else:
        pass
        #print("skip: %s" % line[0:6])


