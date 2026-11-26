# 현장에 보낼 명령 모음 (리눅스)

## 서비스·로그
```bash
systemctl status <서비스> --no-pager
journalctl -u <서비스> -n 60 --no-pager
grep -h "<키워드>" $(find ~ -name "<로그파일>" 2>/dev/null) | tail -20
```

## 네트워크·필드버스
```bash
ip -br link                              # 포트 목록, UP/LOWER_UP
cat /sys/class/net/<포트>/speed          # 100 = 100Mb 장비(EtherCAT 등), 1000+ = 공유기·PC
ip -s link show <포트>                   # RX ≈ TX면 상대는 응답 중 → 받는 쪽(PC) 문제
```

## 실시간·CPU
```bash
uname -r; nproc; cat /sys/devices/system/cpu/isolated; cat /proc/cmdline
grep <포트> /proc/interrupts            # 인터럽트가 어느 CPU에 몰렸는지
echo 0 | sudo tee /proc/irq/<번호>/smp_affinity_list      # 임시로 CPU 0으로
sudo chrt -f -p 60 $(pgrep -x ksoftirqd/0)                 # 받기 처리 우선순위(임시)
```

## 화면·모니터
```bash
xrandr | grep -A3 " connected"
xrandr | sed -n '/<출력>/,/^[A-Z]/p'     # 지원 모드, * = 지금, + = 권장
xwininfo -root -tree | grep -i "<창 제목>"
xrandr --output <출력> --mode 1920x1080 --rate 60.00      # 주사율 시험(출력 없으면 성공)
```
XFCE: 디스플레이 설정 고급 탭 "디스플레이를 연결했을 때"가 배치를 덮어쓸 수 있음.

## 파일·버전
```bash
cat <설치폴더>/version.txt; ls -la <데이터폴더>
```
