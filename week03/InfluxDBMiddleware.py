import serial
from influxdb_client import InfluxDBClient
import time

serial_port = 'COM6'
baud_rate = 9600
timeout = 2

# InfluxDB v2 설정
influxdb_url = "http://localhost:8086"
influxdb_token = "bfSXi6fhzzAvV9nnV1hG1V1gT0m5rNWSY-bCf4Kg4FYEULdEpttNnNRB58reohAqX-mSk26qFTIDD0E_R_vdoA=="
influxdb_org = "test"  # InfluxDB 조직
influxdb_bucket = "dust"  # 데이터가 저장될 bucket 이름

# InfluxDB 클라이언트 초기화
client = InfluxDBClient(url=influxdb_url, token=influxdb_token, org=influxdb_org)
write_api = client.write_api()

# 시리얼 포트 열기
try:
    ser = serial.Serial(serial_port, baud_rate, timeout=timeout)
    print(f"Connected to {serial_port} at {baud_rate} baud")
except:
    print("Failed to connect to serial port")
    exit()

try:
    while True:  # while로 수정
        if ser.in_waiting > 0:
            # 아두이노로부터 시리얼 데이터를 읽음
            line = ser.readline().decode('utf-8').strip()

            # 데이터가 유효한 경우 InfluxDB에 기록
            if "=" in line:
                key, value = line.split("=")
                try:
                    value = float(value)
                    data = f"sensor_data,device=arduino {key}={value}"  # 공백 제거
                    write_api.write(bucket=influxdb_bucket, record=data)
                    print(f"Data written to InfluxDB: {key} = {value}")
                except ValueError:
                    print("Invalid data format")
        time.sleep(1)

except KeyboardInterrupt:
    print("프로그램이 종료 되었습니다.")

finally:
    ser.close()
