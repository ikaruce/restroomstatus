import RPi.GPIO as gpio
import time

gpio.setmode(gpio.BCM)

TRIG = 18
ECHO = 17
#TRIG = 23
#ECHO = 24

gpio.setup(TRIG, gpio.OUT)
gpio.setup(ECHO, gpio.IN)


gpio.output(TRIG, False)
time.sleep(2)

gpio.output(TRIG, True)
time.sleep(0.00001)
gpio.output(TRIG, False)

while gpio.input(ECHO)==0:
  pulse_start = time.time()

while gpio.input(ECHO)==1:
  pulse_end = time.time()

pulse_duration = pulse_end - pulse_start

distance = pulse_duration * 17150

distance = round(distance, 2)

print distance

gpio.cleanup()
