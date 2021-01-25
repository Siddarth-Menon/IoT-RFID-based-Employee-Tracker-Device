# IoT-RFID-based-Employee-Tracker-Device
Micro Embedded Solutions Internship Project

## Software/Apps used:

1. Code Vision AVR
2. AVR studio
3. Real Term (For testing UART communications)
4. Company based GPS tracker app

## Hardware used:

1. ATMEGA-48 Microcontroller
2. GSM Modem
3. EM-18 Reader module
4. GPS Module
5. 16x2 LCD 
6. Two channel Relay module

## Working

This device works using UART protocol and the relay is used to switch connections between the microcontroller and the EM Reader / GSM Modem / GSM module depending on the situation. The EM reader is used to read the employee ID, the GSM module is used to connect the device to the internet and to send messages to authorities, the GPS module is used to get the location of the employee. 

NOTE : This device can be easily serviced from a remote location as the device is connected to the internet using GSM modem consisting of a sim card (and not WiFi).

When a RFID based card is swiped over the EM reader

- The data (CARD ID) is first sent to the microcontroller.
- The microcontroller compares the Card ID with the employee names stored in its memory and the respective name is displayed on the LCD if the card is valid.
- If the card is not valid, then an error message is displayed on the LCD.
- The GPS module then transmits the location data to the microcontroller.
- After a few seconds the name on the LCD gets vanished and the GPS coordinate (Longitude-Latitude format) is displayed on the LCD screen.
- The GSM module then sends a message consisting of the employee name and coordinates in a particular format to the phone of the admin.
- The comapany based app which is installed on the admin's phone then reads the message and uses the GPS coordinates to pin point the location of the employee on google maps.

## Application

This device is very useful for multinational companies having offices all around the world to monitor their employees.


