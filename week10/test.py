import cv2  # 오픈 CV 라이브러리, 이미지와 비디오 처리 담당
import sys  # 시스템 관련 기능 라이브러리
import time  # 시간 관련 기능 라이브러


cap = cv2.VideoCapture(0)  # 기본 카메라(웹캠)를 사용하겠다는 의미. 0은 첫 번째 카메라 장치를 의미.
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)  # 프레임의 너비 설정
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)  # 프레임의 높이 설정
if not cap.isOpened():  # 정상적으로 열렸는지 체
    print("camera open error")
    exit()


while True:
    ret, image=cap.read()  # 파이썬 식 패킹 언패킹 변수에 값 할당, ret은 boolean 성공했는가 안했는가, image는 캡쳐한 데이(numpy data 형식이라고 함!)
    if not ret:  # ret이 실패 성공 여부이니 만약 실패했으면 실패 선언후 탈출
        print("frame read error") 
        break
    cv2.imshow('CAMERA', image)  # 실제론 여기서 보여주는 듯? Camera 라는 창에다가 image 데이터를 표시하는 기능
    if cv2.waitKey(1) & 0xFF == ord('q'):  # 종료조건에 관한 설정인듯?(1ms 동안 기다리고(입력대기 시간) 'q'를 입력하면 종료
        break

    if cv2.waitKey(30)>0:  # 30ms 동안 기다리고 종료 조건인듯함.
        break
    time.sleep(10)  # 10초동안 대기!
    cv2.imwrite("image.jpg",image)  # imwrite(파일이 있다면 덮어쓰기 없다면 생성해서 저장!) 계속 image.jpg에 image 데이터를 덮어쓰기 하려는 의도, 즉 데이터 저장!

cap.release()  # cap 카메라 장치 해제
cv2.destroyAllWindows()  # cv2 관련 모든 창 닫기!
