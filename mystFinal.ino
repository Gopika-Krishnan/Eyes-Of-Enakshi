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
const int force1 = A1;
const int force2 = A2;


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

const int led = 8;
int dotDelay = 300;
bool button_pushed;
bool prevButtonState;

unsigned long startMillis;
unsigned long currentMillis;
int unsigned long period = dotDelay * 7;
int introOver = 0;


void setup() {
  // set pin modes
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
   pinMode(led, OUTPUT);
   button_pushed = false;
 startMillis = millis();

  Serial.begin(9600);

  Serial.println("0,0"); 
 slideReading = 0;
  killer = 0;
  prevButtonState = LOW;

}


void loop() {

  
 
  
 

 while (Serial.available()) {
 introOver = Serial.parseInt();

 if (Serial.read() == '\n') {
   bool currentState = digitalRead(buttonPin2);
   if (currentState == HIGH && currentState != prevButtonState) {
      button_pushed = true;
      digitalWrite(led, LOW);
    }
    prevButtonState = currentState;

   
   (void)analogRead(force1);
   int forceValue1 = analogRead(force1);
   forceValue1 = analogRead(force1);
   
    if(forceValue1 > 40){
      kidR = 1;
      
    }
    else{
      kidR=0;
    }
   (void)analogRead(force2);
    int forceValue2 = analogRead(force2);
   forceValue2 = analogRead(force2);
    if(forceValue2 > 40){
      pin1R = 1;
      
    }
    else{
     pin1R = 0;
    }
(void)analogRead(slide);
  slideReading = analogRead(slide);
  
   int bt1 = digitalRead(buttonPin1);
  int bt2 = digitalRead(buttonPin2);
  //pin1R = digitalRead(pin1);
  //pin1R = analogRead(force2);
  newsR = digitalRead(news);
  lockR = digitalRead(lock);
  //kidR = digitalRead(kid);
  slideReading = analogRead(slide);
  if(slideReading <= 128){
    killer = 1;
  }
  else if(slideReading <= 255){
    killer = 2;
  }
  else if(slideReading <= 383){
    killer = 3;
  }
  else if(slideReading <= 511){
    killer = 4;
  }
  else if(slideReading <= 640){
    killer = 5;
  }
  else if(slideReading <= 767){
    killer = 6;
  }
  else if(slideReading <= 896){
    killer = 7;
  }
  else{
    killer = 8;
  }

  capacitance = readCapacitivePin(touchPin);
//      Serial.print(forceValue1);
//      Serial.print(',');
//      Serial.print(forceValue2);
//      Serial.print(',');



      
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
      Serial.print(killer);
       Serial.print(',');
 
  //delay(0.01);
  pbt1 = bt1;
  pbt2 = bt2;

   if (button_pushed == false && introOver) {
      //Serial.println("1");
      currentMillis = millis();

      if (currentMillis - startMillis <= period) {
        digitalWrite(led, LOW);
        Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 3) {
        digitalWrite(led, HIGH);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 4) {
        digitalWrite(led, LOW);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 7) {
        digitalWrite(led, HIGH);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 8) {
        digitalWrite(led, LOW);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 11) {
        digitalWrite(led, HIGH);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 12) {
        digitalWrite(led, LOW);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 13) {
        digitalWrite(led, HIGH);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 14) {
        digitalWrite(led, LOW);
         Serial.println("0");

      }
      else if (currentMillis - startMillis <= period + dotDelay * 15) {
        digitalWrite(led, HIGH);
         Serial.println("0");

      }

      else {
        startMillis = currentMillis;
        Serial.println("1");
      }

  }
  else{
    Serial.println("0");
  }
}

  
 
 

}}


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
