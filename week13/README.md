✅ Wi-Fi
1. 구성 및 표준
IEEE 802.11 표준 기반

구성요소:

AP (Access Point): 유무선 공유기 역할

STA (Station): 노트북, 스마트폰 등 클라이언트

2. 서비스 셋 (Service Set)
BSS (Basic Service Set): 하나의 AP로 구성 (Ad hoc or Infrastructure 모드)

ESS (Extended Service Set): 여러 BSS를 묶은 구조

3. MAC 계층
PCF (Point Coordination Function): 중앙집중식 Polling (선택 사항)

DCF (Distributed Coordination Function): CSMA/CA 방식, 일반적

4. CSMA/CA 방식
CS: 채널 사용 중인지 감지

MA: 비어 있으면 누구나 접근

CA: 충돌을 피하기 위한 백오프 시간 설정

RTS/CTS: Hidden Terminal 문제 해결용

5. 전송 단계
RTS: 전송 요청

CTS: 전송 허가

DATA: 데이터 전송

ACK: 수신 확인

✅ ZigBee
1. 프로토콜 스택 구성
PHY (물리 계층): DSSS 방식, 3개 밴드에서 27채널

MAC 계층: 충돌 회피 기능

NWK 계층: 네트워크 구성

APS 계층: 응용 지원

APL 계층: 실제 응용 동작

2. PHY 계층
주파수: 2.4GHz 대역 포함

DSSS: Pseudo-random 코드를 이용한 스펙트럼 확산

3. MAC 계층 통신 방식
Non-Beacon (비콘 없음): Non-slotted CSMA-CA, 단순하지만 Sleep 기능 부족

Beacon 사용: Slotted CSMA-CA, 슈퍼프레임 활용 → 에너지 절약 가능

4. 슈퍼프레임 구조
최대 16슬롯 구성

구성요소:

Beacon

CAP (경쟁 접근 기간)

CFP (비경쟁 기간): GTS로 시간 예약

5. 프레임 종류
Beacon Frame

Data Frame

Acknowledgement Frame

MAC Command Frame

6. 주소 체계
IEEE (Extended Address): 64비트

Short Address: 16비트 (변경 가능)

MAC 주소 필드 구성: PAN ID + 주소 (2 or 8바이트)

✅ ZigBee 분산 주소 할당
1. 개요
분산 방식: 부모 노드가 자식 노드에게 주소 할당

장점: 네트워크 트래픽 감소, 제어 메시지 부담 적음

2. Cskip(d) 공식

 
​
 
Cm: 자식의 최대 수

Rm: 자식 라우터 수

Lm: 네트워크 최대 깊이

d: 현재 깊이

Cskip(d): 깊이 d에서 가질 수 있는 주소 블록 크기

✅ ZigBee 라우팅 방식
1. 라우팅 방식 종류
트리 라우팅(Tree Routing)

부모 → 자식 노드로만 통신

구조가 단순하지만 경로가 제한적이고 우회가 어려움

메시 라우팅(Mesh Routing)

다중 경로 사용 가능 (AODV, DSR 등의 라우팅 프로토콜 사용)

장애가 생긴 노드가 있어도 다른 경로로 우회 가능 → 신뢰성 높음

✅ 기타 참고사항
1. CSMA-CD (유선 이더넷에서 사용)
충돌 발생 시 즉시 감지하고 재전송

무선에서는 사용 어려움 → 대신 CSMA-CA 사용

2. Hidden Terminal Problem (숨겨진 터미널 문제)
송신자 A는 B와 C에게 모두 닿지만, B와 C는 서로 존재를 모름

RTS/CTS 프로토콜을 통해 해결

3. GTS (Guaranteed Time Slot)
CFP 구간에서 충돌 없이 데이터를 보낼 수 있도록 예약된 시간 슬롯

슬립 기능과 결합하여 에너지 효율 향상

📌 요약 정리표
Wi-Fi	IEEE 802.11, CSMA/CA, RTS/CTS, BSS/ESS
CSMA/CA	충돌 회피, 백오프 시간, 랜덤 대기
ZigBee 계층	PHY, MAC, NWK, APS, APL
PHY 계층	DSSS 방식, 2.4GHz 포함 27채널
MAC 통신방식	Non-Beacon(간단, 슬립 어려움), Beacon(복잡, 슬립 쉬움)
슈퍼프레임	16슬롯, CAP/CFP/GTS 포함, 비콘으로 시작
프레임 종류	Beacon, Data, ACK, MAC Command
주소 체계	16비트 Short, 64비트 Extended, MAC 주소: PAN ID 포함
주소할당	분산 방식(Cskip(d) 사용), 중앙 집중 대비 장점
라우팅 방식	Tree(간단), Mesh(신뢰성 높음)
