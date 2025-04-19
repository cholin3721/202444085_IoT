#include <LedToggle.h>  
// #include는 사실상 복붙에 가까움, 그래서 #ifndef 를 쓸수 있는것. 만약 이곳 저곳에 ledtoggle.h가 가져와져있으면 이걸로 컴파일하고 두번은 하지마라
void setup() {

}

void loop() {
  led.toggle();
  delay(500);

}
