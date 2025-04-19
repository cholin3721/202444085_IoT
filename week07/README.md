먼저 C++/Arduino 문법 몰랐던거 정리

먼저 int는 2byte(c++과 다르게) 단 와이파이와 관련있는데 esp8266 에선 4바이트
unsigned long 은 주로 밀리초 단위를 기록할때 쓰는 자료형, 42억 까지 가능
unsigned char = byte = u_int8_t 다 1byte 씩 표현 범위는 갗다.  // 1byte씩 가져 숫자를 지정하는 변수의 메모리 용량을 절약하기 위함
char 자료형은 연산 가능, 0~9의 숫자를 서로 타입변환은 간단한 연산만으로 가능하다
char a = '9';
int b = a - '0'  // 57 - 48 = 9
이렇게 변환 가능
static 으로 선언도니 변수의 초기화는 최초 한번만 수행! 그리고 전역변수는 선언과 동시에 기본 값으로 초기화가 가능하다
0과 1 뿐만 아니라 HIGH, LOW 까지 각각 true와 false로 예약되어있음
int 2byte = -32768 ~ 32767 까지
float 유효 숫자 6자리까지, 100만 이상은 힘듬. 부가루틴이 필요해서 꼭 필요할때만 사용. 더 클땐 double.

배열 선언법 float a[3] = {1.2,3.4,5.0}; 요런 식
float temp[3] = {}; 0.0으로 초기화
char 연산 가능 
char a = 'a'
print(a+1) // 'b' 출력

상수 리터럴 표시할때 0x13 >> 16진수 0b01010110; >> 2진수

문자열을 배열 형식으로 char배열 형식으로 선언할땐
char[6] hello = {'h', 'e', 'l', 'l', 'o', '\0'}; 이렇게 하나 더
char[6[ hello = "hello"; 도 가능  // 자동으로 null값 추가해줌
char* hello = "hello" 도 가능
여기서 hello 는 기호상수로 인정되어 다른 값 할당 불가능이지만
char* 은 다른 문자열의 주소를 가르켜도 상관없다.

공간에다 문자열을 만들어 글자를 집어넣는 함수엔 첫번째 인자로 배열이 필요함
strcpy(char 배열(공간이 보장되어야 함), char배열/ char포인터 상관없음)
strcat(char 배열(공간이 만들어놔야함), char배열/char포인터 상관 없음)

나머지는 상관 없음 
strlen(char배열/char포인터)
strcmp(char배열/char포인터)

위에서 다룬건 문자열 리터럴
아래에서 다룰건 문자열 클래스를 활용한 것. 즉 문자열 리터럴로 문자열 클래스를 만들어서 사용해야한다. 문자열 리터럴 그대로는 사용 불가

String(문자열 리터럴) >> 문자열 객체 만들어짐
참고로 float에서는
String(문자열리터럴, 1); >> 1에서 반올림해서 문자열 클래스 인스턴스를 만들어라

다음은 문자열 클래스 메소드
longStr.indexOf(":"); 처음부터 찾아서 젤 첫번째꺼 반환
longSTr.indexOf(":", 시작 인덱스 번호) 지정 가능

longSTr.subSTring(시작인덱스); 시작위치부터 끝까지 복사해서 반환
longSTr.subString(시작 인덱스, 끝 인덱스); 끝 인덱스 바로 전까지 잘라서 반환

longStr.toInt();
longSTr.toFloat(); 온전한 숫자가 아니면 0 반환
보는 그대로;

longStr.toCharArray(바뀐 문자열이 들어갈 char 배열, char 배열의 크기)
보통 longstr.toCharArray(buf1, sizeof(buf1)); 이런식으로
c_str() >> 반환하는게 char* 즉, 문자열에 할당된 메모리 공간을 절약할 수 있다.


잠깐 이론타임
시리얼 통신 : 직렬 통신, 두 기기간의 통신 속도를 약속하고 송 수신 회선을 각각 지정하여 데이터를 주고받음

보드에는 시리얼 통신을 지원하는 하드웨어인 uart가 기본적으로 장착, 아두이노 mcu와 연결하는 포트 안에 변환이 가능한 칩이 있어 uart 통신을 컴퓨터와 아두이노 USB 모듈로 통신
Serial.print(value, format); format에서 BIN , OCT, HEX 등으로 옵션 줘서 출력 가능. 그대로 쓰면됨
serial.write()는 메모리 내용을 그대로 보냄, 문자, 문자열의 경우 결과가 같으나 숫자로 보낼 경우 다름 (1byte 씩, 1byte 표현 범위 넘어서면 하위 8비트 만 보냄(오버플로우))
SErial 보통 입력받는 방법
while (Serial.available() == 0) {
    // 아무 것도 안하고 기다림
  }
이건 입력대기

while(Serial.available()) {
  char c = Serial.read();
  // 후속처리
}

millis() -> 아두이노 가동시간을 밀리세컨드 형식(unsigned long)형식을 ㅗ반환 

static unsigned long nextMi = millis() + 실행간격;
if(millis() > nextMil) {
next Mil = millis() + 실행간격;
//실행할 코드
이런 형식으로 많이들 쓴다.

프로그램 작성시 아두이노 장치들에 골고루 싲간을 할당해야한다.
특정 기능 수행에 로직을 묶어놓아서 다른일을 못하게 되면 프로그램이 블로킹 되었다고 한다. (delay() 함수)
void delay(unsigned long ms) {
unsigned long start = millis();
while (millis() - start < ms) {
  // 아무것도 안함
}
}
반대로 여러 기능ㅇ르 수행하는 것은 논블로킹 방식 위에 같이 millis()와 while 조건문을 활용하여 병렬처리하는 것처럼 보이게 할 수 있다.

함수 인수로 &로 주면 그 값이 실제로 들어온 매개변수가 바뀐다. 주소값도 같이 핸들링하기 때문.
int a = 2
int b = 3
int c = 0;
void sum(int a, int b, int& c) {
  c = a + b;
}

내가 배우기론 alias 같은 별명 개념으로 배우긴했다.
int a = 2 ;
int &c = a; 요런 식으로
이상 태로 sum(a, b, c) 이렇게 넣으면 a가 수정이 되어서 a가 5가 됨




  
