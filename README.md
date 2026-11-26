# My-skill

Claude Code에서 쓰는 개인 작업 방식 스킬 모음입니다. 지금은 **dev-way** 하나에 모든 것을 합쳐 두었습니다.

## dev-way 한눈에

프로젝트와 언어에 상관없이, 코드를 쓰고 고치고 리뷰하고 릴리스하고 현장 문제를 푸는 방식을 한 스킬에 담았습니다.

- **본문(`dev-way/SKILL.md`)**: 늘 지키는 8가지 규칙, 명령 없이 자동으로 할 때의 선, 레벨(lite / full / ultra), 일의 종류별 길 안내.
- **세부 문서(`dev-way/references/`)**: 일의 종류가 정해지면 그 문서 하나만 읽습니다(토큰 절약).
- **스크립트(`dev-way/scripts/`)**: 반복되는 일을 도구로.

### 늘 지키는 것 (요약)
1. 사용자 언어로 짧게. 첫 답에 목표와 "가장 작은 변경" 한 줄, 끝에 안 한 것·위험 한 줄.
2. 가장 작은 **완전한** 변경: 새 코드는 최소로, 일은 끝까지(호출처·시험·설정까지).
3. 실물로 확인: 실제로 돌려 보고, 값을 읽고, 화면을 찍는다. "빌드됨"은 확인이 아님.
4. 원인을 고친다: 재현부터, 가드·재시도로 덮지 않음.
5. 주장마다 확인함 / 추정 / 모름.
6. 되돌릴 수 있는 일은 묻지 않고 하고, 되돌릴 수 없는 일(릴리스, 강제 푸시, 삭제, 외부 메시지)은 분명히 말했을 때만.
7. 일 하나 = 커밋 하나 + 변경 기록 한 항목. 결정은 CLAUDE.md에.
8. 같은 지적을 두 번 받으면 글이 아니라 구조(검사·스크립트·시험)로 고친다.

### 명령 없이 자동으로 할 때
| 구분 | 일 |
|---|---|
| 그냥 한다 | 읽기, 검색, 시험·빌드, 재현, 캡처, 그림, 기록·커밋, 리뷰 보고서, 기존 그래프에 질문, 읽기만 하는 분석 |
| 한 줄 알리고 한다 | 버그 수정, 실패 지점 로그 추가 |
| 먼저 한 번 묻는다 | 프로그램 설치·설정 변경, 큰 그래프 새로 만들기, UI 변경(예시 먼저), 의존성 추가, 큰 리팩터링 |
| 분명히 말했을 때만 | 릴리스·배포, 강제 푸시, 데이터 삭제, 외부 메시지, 분석 대상 실행·변조 |

### 세부 문서
| 문서 | 언제 |
|---|---|
| `code.md` | 코드 쓰기·고치기 (최소 변경, 데이터 모양 먼저, 빼기 먼저, 읽는 부담 줄이기, 경계에서만 검사, 멱등, 시험, 막혔을 때 전제 의심) |
| `playbooks.md` | 버그 수정 / 기능 / 리팩터링 / 성능 / 조사의 단계 |
| `review.md` | 변경 리뷰 (+ 다른 데를 깨나: 안전한 이유를 실행으로 증명) |
| `audit.md` | 저장소 전체 점검, 미룬 일(`shortcut:`) 목록 |
| `release.md` | 릴리스 순서 (빌드와 시험을 동시에, 결과물 확인) |
| `field-debug.md`, `linux-commands.md` | 현장·원격 문제: 증거 → 재현 → 수정, 보낼 명령 모음 |
| `ui-preview.md` | UI를 바꾸기 전 실제 화면으로 A/B/C 예시 |
| `explain-figure.md` | 동작·선택지를 그림으로 설명 |
| `memory.md` | 커밋·변경 기록·CLAUDE.md·결정 기록 |
| `writing.md` | 답·문서·PR·커밋 문장 (AI 티 빼기) |
| `design.md` | 화면 디자인 품질 (impeccable 요약) |
| `binary-analysis.md` | 빌드된 프로그램 분석 (craft-anything / REA) |
| `knowledge-graph.md` | 코드 그래프 (graphify): 구성이 잡히면 한 번 전체 생성, 이후 갱신(`graphify update`, 약 1분)과 검색만, 명령어로 직접 써서 토큰 절약 |

### 스크립트
| 스크립트 | 하는 일 |
|---|---|
| `setup_tools.sh [--install]` | impeccable·graphify·rea·craft-anything 상태와 설치 계획(기본은 계획만) |
| `wait_release.sh owner/repo tag [초]` | GitHub 릴리스 결과물이 올라올 때까지 확인 |
| `xvfb_app.sh N WxH -- 명령`, `x.sh N click/type/key/shot` | 가상 화면에서 앱 실행·조작·캡처 (리눅스) |
| `render.js in.html out.png 폭 높이` | HTML/SVG 그림 → PNG (Playwright) |
| `geom.py` | 설명 그림용 오프셋·교점 계산 |

## 설치

**Claude Code (내 PC)**
```bash
git clone https://github.com/CH1215-Z/My-skill.git
```
```bash
mkdir -p ~/.claude/skills && cp -r My-skill/dev-way ~/.claude/skills/dev-way
```
프로젝트 하나에만 쓰려면 그 저장소의 `.claude/skills/dev-way`에 복사합니다.

**claude.ai 계정 (모든 세션)**: `dev-way` 폴더를 zip으로 묶어(확장자 `.skill`) 업로드하거나 Save skill로 저장합니다.

**같이 쓰는 프로그램(선택)**: 디자인·코드 그래프·프로그램 분석까지 쓰려면
```bash
sh ~/.claude/skills/dev-way/scripts/setup_tools.sh
```
로 계획을 보고 `--install`. impeccable 스킬은 이 저장소에 포함하지 않으니 따로 설치합니다.

**겹치는 스킬**: ponytail 계열과 같은 규칙을 담고 있으니, dev-way를 쓰면 ponytail·ponytail-review·ponytail-audit·ponytail-debt는 꺼 두는 게 깔끔합니다.

## 라이선스
MIT (`LICENSE`). 참고한 원 저작물의 라이선스는 `dev-way/NOTICE.md`.

## 출처
ponytail(MIT), pstack/poteto(MIT, Lauren Tan), impeccable(Apache 2.0), REA(MIT), craft-anything, graphify(Apache-2.0/MIT)의 생각을 한국어로 요약·재구성했습니다. 자세한 내용은 `dev-way/NOTICE.md`.
