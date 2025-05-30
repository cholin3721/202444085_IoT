// TestAppC.nc는 TinyOS 애플리케이션의 구성 컴포넌트로, 하드웨어와 소프트웨어 컴포넌트를 연결(와이어링)하는 역할

includes Test;  // Test.h 헤더 파일 포함. Test.h에서 정의된 상수와 메시지 구조(test_data_msg_t)를 사용하기 위함

configuration TestAppC  // 구성 컴포넌트 정의 시작. TestAppC는 애플리케이션의 컴포넌트를 조합하는 역할
{
}
implementation  // 구현 블록 시작. 컴포넌트 선언과 와이어링 정의
{
    components TestC, MainC;  // TestC(센서 로직 모듈)와 MainC(TinyOS 부팅 관리 컴포넌트) 선언
    components LedsC, new TimerMilliC();  // LedsC(LED 제어), TimerMilliC(밀리초 단위 타이머) 선언. 'new'는 인스턴스 생성

    components ActiveMessageC as AMC;  // ActiveMessageC(무선 통신 제어) 선언. 별칭 AMC로 사용
    components new AMSenderC(AM_TEST_DATA_MSG) as ASMC;  // AMSenderC(메시지 전송 컴포넌트) 선언. AM_TEST_DATA_MSG(0xA4) 타입의 메시지 전송용. 별칭 ASMC

    TestC.Boot -> MainC;  // TestC의 Boot 인터페이스를 MainC의 Boot 인터페이스에 연결. 부팅 이벤트 처리
    TestC.Leds -> LedsC;  // TestC의 Leds 인터페이스를 LedsC에 연결. LED 제어(켜기/끄기/토글)
    TestC.MilliTimer -> TimerMilliC;  // TestC의 MilliTimer 인터페이스를 TimerMilliC에 연결. 주기적 타이머 동작

    TestC.RadioControl -> AMC;  // TestC의 RadioControl 인터페이스를 AMC에 연결. 무선 모듈 켜기/끄기 제어
    TestC.RadioSend -> ASMC;  // TestC의 RadioSend 인터페이스를 ASMC에 연결. 센서 데이터 메시지 전송

    components new SensirionSht11C() as Sht11Ch0C;  // SensirionSht11C(SHT11 온도/습도 센서) 선언. 별칭 Sht11Ch0C
    TestC.Temp -> Sht11Ch0C.Temperature;  // TestC의 Temp 인터페이스를 Sht11Ch0C의 Temperature 인터페이스에 연결. 온도 읽기
    TestC.Humi -> Sht11Ch0C.Humidity;  // TestC의 Humi 인터페이스를 Sht11Ch0C의 Humidity 인터페이스에 연결. 습도 읽기

    components new IlluAdcC() as Illu;  // IlluAdcC(조도 센서) 선언. 별칭 Illu
    TestC.Illu -> Illu;  // TestC의 Illu 인터페이스를 IlluAdcC에 연결. 조도 읽기

    components BatteryC;  // BatteryC(배터리 전압 측정 컴포넌트) 선언
    TestC.Battery -> BatteryC;  // TestC의 Battery 인터페이스를 BatteryC에 연결. 배터리 전압 읽기

// 구성 컴포넌트의 역할: TestAppC.nc는 애플리케이션의 "배선도" 같은 파일입니다. 각 컴포넌트가 제공하거나 사용하는 인터페이스를 연결(와이어링)해 시스템을 구성합니다. TestC가 실제 로직을 처리하고, 나머지 컴포넌트는 하드웨어(센서, LED, 무선 등)와의 인터페이스를 제공합니다.
// 와이어링 (->): nesC에서 ->는 인터페이스 연결을 의미합니다. 예: TestC.Boot -> MainC는 TestC가 부팅 이벤트를 MainC로부터 받도록 연결합니다.
// 컴포넌트 인스턴스 (new): new TimerMilliC()처럼 new는 컴포넌트의 새 인스턴스를 생성합니다. 동일한 컴포넌트를 여러 번 사용할 때 유용합니다.
// 별칭 (as): ActiveMessageC as AMC처럼 별칭을 사용해 컴포넌트를 구분합니다. 특히 동일 컴포넌트를 여러 용도로 사용할 때 필요합니다.
// 주요 컴포넌트와 역할
// TestC: 센서 데이터를 읽고 전송하는 핵심 로직 모듈(다음 파일 TestC.nc에서 구현).
// MainC: TinyOS의 부팅 관리. 시스템 시작 시 Boot.booted 이벤트를 발생.
// LedsC: LED 제어(보통 3개: LED0, LED1, LED2). 디버깅이나 상태 표시용.
// TimerMilliC: 밀리초 단위 타이머. 주기적 작업(예: 10.24초마다 센서 읽기) 실행.
// ActiveMessageC: 무선 통신(Active Message) 제어. 무선 모듈 켜기/끄기.
// AMSenderC: 특정 메시지 타입(0xA4)으로 데이터 전송. Test.h의 AM_TEST_DATA_MSG와 연결.
// SensirionSht11C: SHT11 센서로 온도와 습도 측정.
// IlluAdcC: 조도(빛 세기) 센서. ADC(아날로그-디지털 변환)로 값을 읽음.
// BatteryC: 배터리 전압 측정.

// nesC 구성 컴포넌트: configuration은 하드웨어와 소프트웨어를 연결하는 설계도입니다. 실제 로직은 module(예: TestC)에 있고, 여기는 연결만 담당합니다.
// 인터페이스 이해: 각 와이어링은 인터페이스를 통해 이루어집니다. 예: TestC.Temp -> Sht11Ch0C.Temperature는 TestC가 Read<uint16_t> 인터페이스를 사용해 온도 데이터를 읽도록 연결.
// TinyOS 구조: TinyOS는 하드웨어 추상화를 위해 컴포넌트를 제공합니다. SensirionSht11C 같은 컴포넌트는 특정 센서(SHT11)에 맞춰 미리 구현된 드라이버입니다.
}

