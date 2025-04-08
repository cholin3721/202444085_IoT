configuration BlinkAppC {}             // 이 파일은 구성(configuration)을 담당함. 어떤 컴포넌트를 쓸지 정의.

implementation {
  components MainC,                     // 시스템의 메인 제어 컴포넌트
             BlinkC,                   // 우리가 만든 BlinkC 모듈
             LedsC,                    // 실제 LED 제어를 담당하는 하드웨어 컴포넌트
             TimerMilliC;              // 밀리초 단위 타이머 제공 컴포넌트

  // 인터페이스 연결
  BlinkC.Boot -> MainC.Boot;           // BlinkC의 Boot 인터페이스를 MainC의 Boot에 연결 (부팅 시 동작)
  BlinkC.Timer0 -> TimerMilliC.Timer;  // BlinkC에서 쓰는 Timer0을 TimerMilliC의 Timer와 연결
  BlinkC.Leds -> LedsC;                // BlinkC의 LED 제어를 실제 하드웨어 LED 컴포넌트에 연결
}
