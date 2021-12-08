int buttonPin1 = 2;
int buttonPin2 = 3;
const int touchPin = 4;
const int pin1 = 5;
const int news = 6;
const int lock = 7;
const int kid = 8;
const int slide = A0;
int slideReading; 
int killer;
int last_stage;


//int capacitance =0;
int pbt1 = LOW;
int pbt2 = LOW;
int button1=false;
int button2=false;
int capacitance = 0;
int pin1R = 0;
int newsR = 0;
int lockR = 0;
int kidR = 0;

void setup() {
  // set pin modes
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
 
  Serial.begin(9600);

  Serial.println("0,0"); 
 slideReading = 0;
  killer = 0;
}


void loop() {

  
 
  
 

  while (Serial.available()) {
    
 if (Serial.read() == '\n') {
  slideReading = analogRead(slide);
   int bt1 = digitalRead(buttonPin1);
  int bt2 = digitalRead(buttonPin2);
  pin1R = digitalRead(pin1);
  newsR = digitalRead(news);
  lockR = digitalRead(lock);
  kidR = digitalRead(kid);
  if(slideReading <= 620){
    killer = 1;
  }
  else if(slideReading <= 680){
    killer = 2;
  }
  else if(slideReading <= 740){
    killer = 3;
  }
  else if(slideReading <= 800){
    killer = 4;
  }
  else if(slideReading <= 860){
    killer = 5;
  }
  else if(slideReading <= 920){
    killer = 6;
  }
  else if(slideReading <= 980){
    killer = 7;
  }
  else{
    killer = 8;
  }

  capacitance = readCapacitivePin(touchPin);
  
      Serial.print(bt1);
      Serial.print(',');
      Serial.print(pbt1);
      Serial.print(',');
      Serial.print(bt2);
      Serial.print(',');
      Serial.print(pbt2);
      Serial.print(',');
      Serial.print(capacitance);
      Serial.print(',');
      Serial.print(pin1R);
      Serial.print(',');
      Serial.print(newsR);
      Serial.print(',');
      Serial.print(lockR);
      Serial.print(',');
      Serial.print(kidR);
      Serial.print(',');
      Serial.println(killer);
       
 
  //delay(0.01);
  pbt1 = bt1;
  pbt2 = bt2;
  }
}

  
 
 

}


// readCapacitivePin
//  Input: Arduino pin number
//  Output: A number, from 0 to 17 expressing
//  how much capacitance is on the pin
//  When you touch the pin, or whatever you have
//  attached to it, the number will get higher
#include "pins_arduino.h" // Arduino pre-1.0 needs this
uint8_t readCapacitivePin(int pinToMeasure) {
  // Variables used to translate from Arduino to AVR pin naming
  volatile uint8_t* port;
  volatile uint8_t* ddr;
  volatile uint8_t* pin;
  // Here we translate the input pin number from
  //  Arduino pin number to the AVR PORT, PIN, DDR,
  //  and which bit of those registers we care about.
  byte bitmask;
  port = portOutputRegister(digitalPinToPort(pinToMeasure));
  ddr = portModeRegister(digitalPinToPort(pinToMeasure));
  bitmask = digitalPinToBitMask(pinToMeasure);
  pin = portInputRegister(digitalPinToPort(pinToMeasure));
  // Discharge the pin first by setting it low and output
  *port &= ~(bitmask);
  *ddr  |= bitmask;
  delay(1);
  uint8_t SREG_old = SREG; //back up the AVR Status Register
  // Prevent the timer IRQ from disturbing our measurement
  noInterrupts();
  // Make the pin an input with the internal pull-up on
  *ddr &= ~(bitmask);
  *port |= bitmask;

  // Now see how long the pin to get pulled up. This manual unrolling of the loop
  // decreases the number of hardware cycles between each read of the pin,
  // thus increasing sensitivity.
  uint8_t cycles = 17;
  if (*pin & bitmask) {
    cycles =  0;
  }
  else if (*pin & bitmask) {
    cycles =  1;
  }
  else if (*pin & bitmask) {
    cycles =  2;
  }
  else if (*pin & bitmask) {
    cycles =  3;
  }
  else if (*pin & bitmask) {
    cycles =  4;
  }
  else if (*pin & bitmask) {
    cycles =  5;
  }
  else if (*pin & bitmask) {
    cycles =  6;
  }
  else if (*pin & bitmask) {
    cycles =  7;
  }
  else if (*pin & bitmask) {
    cycles =  8;
  }
  else if (*pin & bitmask) {
    cycles =  9;
  }
  else if (*pin & bitmask) {
    cycles = 10;
  }
  else if (*pin & bitmask) {
    cycles = 11;
  }
  else if (*pin & bitmask) {
    cycles = 12;
  }
  else if (*pin & bitmask) {
    cycles = 13;
  }
  else if (*pin & bitmask) {
    cycles = 14;
  }
  else if (*pin & bitmask) {
    cycles = 15;
  }
  else if (*pin & bitmask) {
    cycles = 16;
  }

  // End of timing-critical section; turn interrupts back on if they were on before, or leave them off if they were off before
  SREG = SREG_old;

  // Discharge the pin again by setting it low and output
  //  It's important to leave the pins low if you want to
  //  be able to touch more than 1 sensor at a time - if
  //  the sensor is left pulled high, when you touch
  //  two sensors, your body will transfer the charge between
  //  sensors.
  *port &= ~(bitmask);
  *ddr  |= bitmask;

  return cycles;
}
