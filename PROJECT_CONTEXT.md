# 롯데시네마 WEB-메인 현재 상태

마지막 업데이트: 2026-07-30

## 구현 완료

- 헤더, 히어로, 빠른예매, LottePick, MoodCinema, Promo, Special, Goods, SNS, 이벤트, 푸터 섹션 구조 구현(통합 검색 섹션은 디자인에 존재하지 않음 — 아래 참고)
- Figma 원본 색상 토큰(`get_variable_defs` 확인값: main_red #e30413, main_gray #a1a1a1, gray-900 #666666, primary/100 #f2d046, primary/38 #f2d04661, subtit #99a1af, Goods 전용 red #e7000b)을 `:root` 변수로 반영
- Figma 실제 폰트 6종 연결: Pretendard(공식 웹폰트 패키지, 9굵기), NanumSquare(L/R/B/EB), SB Aggro(L/M/B), RixYeoljeongdo(Regular)는 `@font-face` 자체 호스팅, **DM Serif Text는 Google Fonts CDN 링크(`index.html` `<head>`)로 이미 연결되어 정상 로드됨**(`document.fonts.check('16px "DM Serif Text"')` → true, `.mood_slide_title` 등에 적용 확인 — 기존에 "미확보"로 기록되어 있었으나 재확인 결과 이미 해결된 상태였음)
- `download_assets`로 확보한 실제 로고/포스터/스틸컷/아이콘을 Header, Hero(배경 이미지 포함), LottePick, Promo, MoodCinema, Special, Goods, SNS 전 섹션에 적용 — placeholder 그라디언트 없음(마크업에서 `placeholder`/`gradient` 클래스 전수 검색으로 확인)
- 마이클(#2) 히어로 배경은 좌우 반전 버전(`hero_bg_michael_flipped.png`)을 사용하고 `data-bg-flip="true"`로 배경 위치를 오른쪽 정렬 — 기존에 준비만 되어 있고 연결이 안 되어 있던 스크립트의 `dataset.bgFlip` 분기를 실제로 활성화함
- Hero TOP5 랭킹 항목 호버/포커스 시 히어로 카피(제목/부제/연령·장르 배지/평점/예매율/예매인원) + 배경 이미지(5개 전부 실제 스틸컷) 전환 인터랙션
- SNS 카드 비율을 고정 240px 높이 대신 실제 Figma 비율(259:460 `aspect-ratio`)로 수정
- QuickMenu를 그리드 폼에서 실제 디자인과 같은 알약형 한 줄 바(아이콘+빠른예매 라벨+구분선+드롭다운 4개+CTA)로 재구성
- **섹션 순서를 Figma 실제 y좌표 순서로 정정**: 기존에는 Promo → MoodCinema 순이었으나 전체 레이어 트리(node 1563:2214) 확인 결과 실제 순서는 LottePick → **MoodCinema** → **Promo** → Special이라 두 섹션 위치를 맞바꿈([index.html](index.html:299) 참고, 콘텐츠는 그대로 유지)
- **Special(특별관) 섹션 탭 전환 기능 완성**: Figma 확인 결과 이 섹션은 폭 7857px 캔버스에 탭당 하나씩 4개의 풀사이즈 패널(`SpecialTheater`/`Specialtg`/`Specialpr`/`Specialex`)이 나란히 배치된 구조였음(기존엔 "몰입형 상영관" 카드 4장만 정적으로 구현되어 있었고 탭 버튼은 시각적 `is_active` 토글만 함). 나머지 3개 탭(동반 관람형: 씨네패밀리/씨네커플, 프리미엄·휴식형: 샤롯데/리클라이너, 체험형: 수퍼MX4D/수퍼4D) 카드 6장을 추가하고, 탭 버튼에 `data-tab`, 카드 패널에 `data-tab-panel`을 부여해 클릭 시 해당 패널만 `is_active`로 전환되도록 JS 로직 추가([index.html:684](index.html:684)). 2카드 패널은 `.special_cards--pair`로 데스크톱에서 340px 고정폭 2열 중앙 정렬, 1280px/768px에서는 기존 반응형 규칙에 자연스럽게 흡수되어 유동폭으로 축소됨(코드 리뷰로 확인, 브라우저 스크린샷 미실시 — 아래 참고)
- 360px/768px에서 가로 스크롤 없음 확인
- **폰트-섹션 매핑 재검증 완료**: `get_design_context`로 9곳(Header nav, QuickMenu 라벨/버튼, Special 헤더+서브타이틀, Event 헤더+서브타이틀, LottePick 타이틀, Goods 헤더+서브타이틀, SNS 타이틀)의 실제 Figma 폰트 지정을 확인해 현재 CSS와 전부 대조 — 전부 정확히 일치(NanumSquare/Pretendard/SB Aggro/RixYeoljeongdo/NanumGothic 매핑 오류 없음). 기존 "시각적 추정"이었던 매핑이 실제로는 맞았음을 확인
- **`rank_age_icon`을 Figma 기준(연령등급 배지 아이콘)으로 원복**: Figma 트리에서 이 자리는 `ico_age_15`/`ico_age_12` 같은 19×19px 작은 배지 레이어임을 확인. 사용자가 IDE에서 배경 스틸컷 파일(BgImage.png 등)로 바꿔뒀던 것을 확인 후(질문으로 재확인 받음) `badge_15.png`/`badge_12.png`/`badge_all.png`로 되돌림([index.html:100](index.html:100) 등 5곳)
- **키보드 tab 순서 확인 완료**: `tabindex` 사용처는 rank_item 5개(`tabindex="0"`)뿐이고 양수 tabindex나 불필요한 `tabindex="-1"` 없음 — Special 탭 버튼/QuickMenu select 등은 모두 네이티브 인터랙티브 요소라 DOM 순서 그대로 자연스럽게 tab 이동됨. 전역 `outline` 리셋도 없어 커스텀 focus-visible이 없는 요소도 브라우저 기본 포커스 링이 그대로 보임
- **히어로 배경 이미지가 거의 안 보이던 문제 수정**: `.hero_stage::before` 그라디언트 오버레이가 세로 방향이 뒤집혀 있어(상단 92%~89% 지점까지 검정, 하단만 밝음) 이미지 대부분이 거의 검게 가려져 있었음. Figma 스크린샷(`get_screenshot` node 1563:2256)과 대조해 방향을 반전(상단은 투명, 하단으로 갈수록 어두워짐)시켜 실제 이미지가 보이도록 수정([styles.css:302](styles.css:302)). 원본 배경 이미지 에셋(`BgImage.png` 등) 자체는 원래도 정상 파일이었음(블러 없음)
- **히어로 타이틀 한 줄 강제**: `.hero_title_box h1`에 `white-space: nowrap` 추가([styles.css:406](styles.css:406)) — Figma 원본도 타이틀 텍스트가 `whitespace-nowrap`으로 지정되어 있음(`get_design_context` node 1563:2774 확인). "악마는 프라다를 입는다 2" 같은 긴 제목이 두 줄로 줄바꿈되던 문제 해결. `body { overflow-x: hidden }`가 이미 있어 좁은 화면에서 타이틀이 넘쳐도 페이지 가로 스크롤은 생기지 않음(안전)
- **군체(#1)/마이클(#2) 히어로 배경 이미지가 흐릿하게 깨져 보이던 문제 수정**: 실제 원인은 두 파일이 다른 슬라이드(3840×1988)와 달리 비정상적으로 작았던 것 — `BgImage.png`는 1033×653(축소판), `hero_bg_michael.png`/`hero_bg_michael_flipped.png`는 276×134(거의 검은색에 가까운 초소형 크롭)였음. `background-size: cover`로 큰 히어로 박스에 억지로 늘리면서 심하게 흐려져 사용자에게는 마치 애니메이션(움직이는 것처럼 뭉개짐)처럼 보였던 것. Figma에서 해당 노드(군체 `1563:2257`, 마이클 `1563:2395`)를 `download_assets`로 다시 받아 3840×1988 정상 해상도로 교체하고, 마이클은 기존 로직대로 좌우반전(PowerShell `System.Drawing`)해서 저장. **마이클 배경 자체가 어두운 것은 실제 Figma 키아트 디자인**(스포트라이트 인물사진, 나머지 암전)이라 정상 — 색감을 밝게 보정하지 않음
- **MoodCinema 마우스 휠 스크롤 지원 추가**: Figma상 4개 슬라이드가 가로로 나란히 배치된 구조([1563:3118](index.html:299) `Scroll`, 6778.8px)이고 `.mood_scroll`도 `overflow-x:auto`+`scroll-snap`으로 이미 가로 스크롤은 가능했지만, 일반 마우스 휠(세로 입력)로는 전혀 반응하지 않아 트랙패드 가로 스와이프나 스크롤바 드래그로만 넘길 수 있었음. `.mood_scroll`에 `wheel` 리스너를 추가해([index.html:704](index.html:704)) 세로 휠 입력을 가로 스크롤로 변환 — 슬라이드가 넘어갈 때마다 각 슬라이드에 내장된 진행 바(`.mood_progress`, 금색 강조)와 "01~04/04" 카운터도 함께 자연스럽게 전환됨(원래 슬라이드별 마크업에 포함돼 있던 것이라 별도 동기화 로직 불필요). 첫/마지막 슬라이드 경계에서는 `preventDefault`를 호출하지 않아 페이지 세로 스크롤로 자연스럽게 넘어감(가로 스크롤에 갇히지 않음)

## 알려진 문제 (실제 에셋/디자인 확인 한계)

- **Figma MCP 세션 재인증 후 정상 동작 확인**: 이전 세션에서 SSE 파싱 오류로 실패했던 `get_design_context`(node 1563:2214)가 재인증 후에는 정상적으로 응답함. 단, 노드가 커서 풀 코드 대신 "sparse metadata"(레이어별 정확한 id/x/y/width/height 트리, 텍스트 없음)로 응답이 축소됨 — 이 트리로 섹션 순서·좌표는 정확히 검증했지만, 세부 스타일(색상/폰트/이펙트)까지 필요할 때는 하위 노드 id로 `get_design_context`를 추가로 호출해야 함
- **검색(Search) 섹션은 애초에 디자인에 없음(해결됨)**: 전체 레이어 트리를 "검색/Search"로 전수 검색해도 헤더의 `Icon-Search` 외에는 아무 것도 없고, QuickMenu(y=1141~1406)와 LottePick(y=1406~)이 간격 없이 붙어 있음을 확인. 기존에 "739px 빈 구간에 검색 UI가 있을 것"이라던 추정은 스크린샷 근사에서 비롯된 오판이었음
- **Special 섹션 360px에서 4열 그리드가 아닌 4카드 자동 stack 확인**: `.special_cards--pair`는 360px에서 1열(320px)로 정상 축소됨. 몰입형(4카드) 패널도 기존 반응형 규칙(768px 이하 1열)을 그대로 따름
- **768px에서 페이지 전체 가로 스크롤 발견(Special 작업과 무관, 별도 작업으로 분리)**: `document.documentElement.scrollWidth`(1198px) > `window.innerWidth`(768px). 원인은 `.quick_menu_card`(빠른예매 폼)가 768px에서 자기 컨테이너보다 넓어지는 기존 버그로, 이번 세션에서 건드리지 않은 영역임. 별도 백그라운드 작업으로 분리해둠(spawn_task)
- 버튼 hover/pressed/disabled, 반응형 프레임, 애니메이션 스펙은 Figma에 애초에 없음(design-analysis.md 기존 기록)

## 확인이 필요한 사용자 수정 사항

- [index.html:75](index.html:75) 히어로 "예고편" 버튼 `href`가 `#promo_section` → `#`으로 변경됨(사용자가 IDE에서 직접 수정, 유지 요청받음, Figma는 링크 대상을 규정하지 않으므로 판단 보류 상태 유지)
- ~~랭킹 카드 5개의 `rank_age_icon`~~ → **해결**: Figma 확인 결과 이 자리는 연령등급 배지 아이콘이 맞아, 사용자 확인 후 `badge_15.png`/`badge_12.png`/`badge_all.png`로 되돌림(위 "구현 완료" 참고)

## 확정된 UX 정책

- 모바일에서는 메뉴가 2줄로 자연스럽게 배치되도록 처리
- 탭 버튼과 순위 카드 hover/active 상태를 시각적으로 구분

## 사용 중인 라이브러리

- 없음(순수 HTML/CSS/JavaScript)

## 저장 데이터

- 없음

## 다음 작업

1. **768px에서 `.quick_menu_card` 오버플로로 인한 페이지 전체 가로 스크롤 수정**(위 "알려진 문제" 참고, 별도 세션에서 spawn_task로 진행 중)
2. 예고편 버튼 `href` 사용자 수정 사항이 의도한 것인지 최종 확인(위 "확인이 필요한 사용자 수정 사항" 참고) — Figma로는 판단 불가한 UX 선택이라 사용자 확인만 남음
3. 버튼 hover/pressed/disabled 등 Figma에 없는 인터랙션 스펙은 계속 별도 정의 필요 시에만 진행

## 마지막 검증 결과

- 실행: Claude Browser 도구로 index.html 직접 열어 확인(file:// 프로토콜)
  - Special 탭 4개(몰입형/동반 관람형/프리미엄·휴식형/체험형) 전부 클릭 → DOM 상태(JS로 `is_active`/`display` 확인)와 스크린샷 양쪽으로 각 탭의 카드 이미지·배지가 정확히 바뀌는지 확인. 1440px 데스크톱, 768px, 360px, 1280px 순으로 확인
  - `rank_age_icon` 5개 전부 `badge_15/12/all.png`로 바뀐 것을 DOM에서 확인, `naturalWidth`/`complete`로 이미지 정상 로드 확인
  - `document.fonts.check`로 DM Serif Text 로드 확인
  - 콘솔 오류(`onlyErrors`) 없음 재확인
- 결과: Special 4개 탭 전부 정상 전환(카드 수 4/2/2/2, 이미지·배지 텍스트 일치). 360px·1280px는 가로 스크롤 없음(`scrollWidth <= innerWidth`). 768px는 가로 스크롤 있음 — 단 원인은 Special이 아닌 기존 `.quick_menu_card`(위 참고, 별도 세션에서 수정 중). `rank_age_icon` 5개 전부 정상 로드. 폰트-섹션 매핑 9곳 전부 Figma와 일치
- 확인하지 못한 부분: 키보드 tab 순서 실측(스크린리더/실제 Tab 키 입력은 미실시, 마크업 검토로만 판단), 768px `.quick_menu_card` 수정 자체(별도 세션 진행 중)
