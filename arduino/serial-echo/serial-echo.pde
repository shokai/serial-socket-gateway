// serial echo

char serial_recv;
int led_pin = 13;
boolean led_stat = true;

void setup(){
    pinMode(led_pin, OUTPUT);
    Serial.begin(9600);
    digitalWrite(led_pin, led_stat);
}

void loop(){

    if(Serial.available() > 0){
        serial_recv = Serial.read();
        Serial.println(serial_recv); // echo
        if(serial_recv == 'a'){
            led_stat = !led_stat;
            digitalWrite(led_pin, led_stat);
        }
    }
}

