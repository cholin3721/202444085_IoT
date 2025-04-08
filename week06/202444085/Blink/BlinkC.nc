#include "Timer.h"                    // Timer 인터페이스 사용을 위해 헤더 파일 포함
                                      // C의 #include와 동일한 역할

module BlinkC @safe() {              // 모듈 정의 (기능 구현을 포함할 블록)
                                      // @safe()는 타입 안전성 체크를 의미 (선택 사항)

    uses interface Timer<TMilli> as Timer0; // 밀리초 단위 타이머 인터페이스 사용 (별칭: Timer0)
                                            // Timer<TMilli>는 타이머의 시간 단위가 밀리초임을 명시
                                            
    uses interface Leds;             // LED 제어를 위한 인터페이스 사용
                                     // led0Toggle(), led1On() 같은 함수들이 포함됨

    uses interface Boot;             // 부팅 이벤트 감지를 위한 인터페이스 사용
                                     // 시스템이 부팅 완료되었을 때 booted() 이벤트 호출됨
}

implementation {                     // 위에서 선언한 인터페이스들을 실제로 구현하는 부분

    event void Boot.booted() {       // 시스템 부팅 완료 시 자동 호출되는 이벤트 함수
        call Timer0.startPeriodic(250); // Timer0 타이머를 250ms 주기로 반복 실행 시작
                                        // -> 이후부터 250ms마다 Timer0.fired() 이벤트 발생
    }

    event void Timer0.fired() {      // 타이머가 250ms마다 "fired"되면 호출되는 이벤트 함수
        call Leds.led0Toggle();      // LED0의 상태를 토글 (켜져 있으면 끄고, 꺼져 있으면 켬)
    }
}
