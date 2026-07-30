# 롯데시네마 WEB-메인 현재 상태

마지막 업데이트: 2026-07-29

## 구현 완료

- 헤더, 히어로, 빠른예매, 통합 검색, LottePick, Promo, MoodCinema, Special, Goods, SNS, 이벤트, 푸터 섹션 구조 구현
- Figma 원본 색상 토큰(`get_variable_defs` 확인값: main_red #e30413, main_gray #a1a1a1, gray-900 #666666, primary/100 #f2d046, primary/38 #f2d04661, subtit #99a1af, Goods 전용 red #e7000b)을 `:root` 변수로 반영
- Figma 실제 폰트 5종 연결: Pretendard(공식 웹폰트 패키지, 9굵기), NanumSquare(L/R/B/EB), SB Aggro(L/M/B), RixYeoljeongdo(Regular). DM Serif Text만 아직 미확보(폴백 렌더링)
- `download_assets`로 확보한 실제 로고/포스터/스틸컷/아이콘을 Header, Hero(배경 이미지 포함), LottePick, Promo, Special, SNS 일부에 적용
- 이후 추가로 확보된 자산까지 반영: 5개 영화 전부의 히어로 배경 이미지(`img_box1~5.png` 포스터, `BgImage.png`/`Bgimg2~5.png` 배경 스틸컷), 정식 로고(`Logo.png`, 301×49), 실제 검색 아이콘(`search.svg`) — 헤더 검색 버튼의 손그림 SVG를 실제 아이콘으로 교체
- 마이클(#2) 히어로 배경은 좌우 반전 버전(`hero_bg_michael_flipped.png`)을 사용하고 `data-bg-flip="true"`로 배경 위치를 오른쪽 정렬 — 기존에 준비만 되어 있고 연결이 안 되어 있던 스크립트의 `dataset.bgFlip` 분기를 실제로 활성화함
- Hero TOP5 랭킹 항목 호버/포커스 시 히어로 카피(제목/부제/연령·장르 배지/평점/예매율/예매인원) + 배경 이미지(5개 전부 실제 스틸컷) 전환 인터랙션
- SNS 카드 비율을 고정 240px 높이 대신 실제 Figma 비율(259:460 `aspect-ratio`)로 수정
- QuickMenu를 그리드 폼에서 실제 디자인과 같은 알약형 한 줄 바(아이콘+빠른예매 라벨+구분선+드롭다운 4개+CTA)로 재구성
- Special 섹션을 4카드(수퍼 LED/수퍼플렉스/광음시네마/광음 LED) 글래스모피즘 스타일(반투명 rgba(255,255,255,0.11)+보더+radius 10px)로 재구성, 실제 이미지 2장 적용
- 360px/768px에서 가로 스크롤 없음 확인

## 알려진 문제 (실제 에셋/디자인 확인 한계)

- **Figma MCP 세션 제약**: node-id 1563:2214가 너무 커서 `get_design_context`/`get_metadata`가 이 세션 내내 SSE 파싱 오류로 실패함. `get_screenshot`(최대 9600px 원본 해상도)과 `download_assets`, `get_variable_defs`만 정상 동작해서, 이 세 가지로만 레이아웃을 역추적함 — 정확한 레이어별 좌표/간격 수치(px 단위 auto-layout 값)는 가져오지 못하고 스크린샷 실측으로 근사함
- **에셋 20개 캡**: `download_assets`가 이미지 20개/SVG 20개까지만 반환해서, 실제 페이지에 있는 전체 이미지 중 일부만 확보함. 확보하지 못한 자리(MoodCinema 카드, Goods 상품 3종, SNS 카드 2~4번, Special 카드 2종)는 그라디언트 placeholder 유지 — 영화 포스터를 억지로 재사용하지 않고 정직하게 placeholder로 남김
- **검색(Search) 섹션 보류**: 스크린샷상 QuickMenu~LottePick 사이 739px 구간이 시각적으로 완전히 비어있어(3배 밝기 확대 확인) 검색 UI 재구현을 보류함. 사용자가 검색 섹션 node-id를 제공하면 재확인 후 진행 예정
- **폰트 매핑은 추정치**: 어떤 섹션이 정확히 어떤 폰트(NanumSquare vs Pretendard vs SB Aggro)를 쓰는지는 메타데이터로 확인하지 못해 시각적 판단으로 배치함 — design-analysis.md에 이미 "7개 폰트 혼용, 실사용 매핑 불명"으로 기록되어 있던 제약
- 버튼 hover/pressed/disabled, 반응형 프레임, 애니메이션 스펙은 Figma에 애초에 없음(design-analysis.md 기존 기록)

## 확정된 UX 정책

- 모바일에서는 메뉴가 2줄로 자연스럽게 배치되도록 처리
- 탭 버튼과 순위 카드 hover/active 상태를 시각적으로 구분

## 사용 중인 라이브러리

- 없음(순수 HTML/CSS/JavaScript)

## 저장 데이터

- 없음

## 다음 작업

1. 검색 섹션(통합검색 UI) node-id 확인 후 실제 구현 — 히어로 검색 아이콘은 실제 아이콘으로 교체 완료했지만, 검색 섹션 자체는 여전히 보류 상태
2. MoodCinema 카드, Goods 상품 3종, SNS 카드 2~4번, Special 카드 2종(수퍼플렉스/광음시네마) — 20개 캡을 넘는 자산은 섹션별 Figma node-id를 추가로 받아 개별 확보
3. DM Serif Text 폰트 파일 확보 후 연결
4. 폰트-섹션 매핑을 실제 Figma 데이터로 재검증 (현재는 시각적 추정)
5. 1280px 브레이크포인트 단독 재검증, Special/QuickMenu 등 신규 마크업의 키보드 tab 순서 재확인

## 마지막 검증 결과

- 실행: Claude Browser 도구로 index.html 직접 열어 확인 (file:// 프로토콜), 1440px/768px/360px 순으로 확인
- 결과: 콘솔 오류 없음. 360px/768px 모두 `document.documentElement.scrollWidth <= window.innerWidth` 확인(가로 스크롤 없음)
- Hero 인터랙션: rank_item 5개 전체 mouseenter 디스패치로 카피 전환 확인, 배경 이미지 전환(군체/마이클/슈퍼마리오)도 함께 확인
- 확인하지 못한 부분: 1280px 단독 확인, Special/QuickMenu 등 새로 바뀐 마크업의 키보드 tab 순서 재점검, 실제 사람 마우스 호버(자동화 도구는 이벤트 디스패치로 대체 검증)
