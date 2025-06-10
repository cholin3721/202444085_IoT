10주차 배운 내용 복습
텔레그램 계정 가입 -> 텔레그램 계정 Botfather 팔로우 -> 나만의 봇 생성(닉네임 정하기 빡셈) -> 파이썬으로 api(Telegram-python) 연결 후 -> Bot 팔로우 후 bot으로 센서 데이터(카메라)를 보내는 과정
먼저 openCV를 설치해서 카메라 테스트함
하지만 그냥 설치하면 실습실 환경상 엄청나게 오래 걸리기 때문에 파이썬으로 일부만 설치한 느낌이었음 
(칩을 복사하는 모듈? 기능이 라즈베리 파이에 탑재되어 있단 사실을 깨달음, 정확히는 외부 디바이스에 현재 운영체제나 필수 파일들을 복사해준 느낌)
cv2를 설치한 후, python에 import 후 캡쳐 화면이 뜨는지 확인함.
그 후, 그 데이터를 api에 전달해 연결해주는 코드들이 있음 첨부해서 공부해볼 예정


라즈베리파이5 TinyOS , NesC , Oscilloscope.py(미들웨어) 설치
사전 설치
sudo apt-get install emacs gperf bison flex git build-essential automake avarice avr-libc avrdude binutils-avr gcc-avr gdb-avr subversion graphviz checkinstall openjdk-17-jdk git
사전 설정
1
$ vim ~/tinyos.env

export TOSROOT=/opt/tinyos-2.x
export TOSDIR=$TOSROOT/tos
export CLASSPATH=$TOSROOT/support/sdk/java/tinyos.jar:$CLASSPATH
export CLASSPATH=$TOSROOT/support/sdk/java:$CLASSPATH
export CLASSPATH=.:$CLASSPATH
export MAKERULES=$TOSROOT/support/make/Makerules
export PYTHONPATH=$PYTHONPATH:$TOSROOT/support/sdk/python

echo "setting up TinyOS on source path $TOSROOT"
2
$ vim ~/.bashrc
  끝줄에 추가
  source ~/tinyos.env
3 실행
$ source ~/.bashrc
JNI 파일 복사
$ git clone https://github.com/sonnonet/jni.git
$ cd jni/tinyos/
$ sudo mv libtoscomm.so /usr/lib
$ sudo mv libgetenv.so /usr/lib
NesC 설치
$ mv ~/sonnonet/jni/tinyos/nesc-1.3.4.tar.gz ~/
$ tar –xvzf nesc-1.3.4.tar.gz
$ cd nesc-1.3.4
$ ./configure --build=aarch64-unknown-linux-gnu
$ make
$ sudo make install
TinyOS-Tools 설치
$ cd /home/pi
$ git clone --branch release_tinyos_2_1_2 https://github.com/tinyos/tinyos-release.git
$ mv tinyos-release tinyos-2.x && sudo mv tinyos-2.x /opt/
$ cd /opt/tinyos-2.x/tools/
$ ./Bootstrap
$ ./configure --build=aarch64-unknown-linux-gnu
$ make
$ sudo make install
테스트
$ motelist


기본 미들웨어 소스코드 다운
$ git clone https://github.com/sonnonet/2024_inhatc
$ cd 2024_inhatc/Zigbee/Oscilloscope/
실행방법 (mote 연결후)
python oscilloscope.py serial@/dev/ttyUSB0:115200
tos.py 복사
$ mv ./tos.py /opt/tinyos-2.x/support/sdk/python/tos.py
