/*
Robotale Potentiometer Sample Sketch
Edited by Thomas for IMA
*/
const int potIn1 = A0;
const int potIn2 = A1;

int RawValue1 = 0;
int RawValue2 = 0;

int ActualValue1 = 0;
int ActualValue2 = 0;

void setup(){  
  pinMode(potIn1, INPUT);
  pinMode(potIn2, INPUT);
  Serial.begin(9600);
}

void loop(){  
  RawValue1 = analogRead(potIn1); 
  RawValue2 = analogRead(potIn2);
  ActualValue1 = 1023 - RawValue1;
  ActualValue2 = 1023 - RawValue2;         
  Serial.print(String(ActualValue1) + ",");                    
  Serial.print(String(ActualValue2));
  Serial.println();
  delay(500);   // 1/2 sec so your display doesnt't scroll too fast
}
