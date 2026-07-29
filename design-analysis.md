# 롯데시네마 WEB-메인 디자인 분석표

## 확인한 자료
- 디자인 원본: [Figma] `WEB-메인` 프레임 — https://www.figma.com/design/1ZsBFGg3l3uzOV0EQUkBcC/김시현?node-id=1563-2214
- 확인한 화면: 메인페이지 1개 (Header, Hero, QuickMenu, 검색, LottePick, Promo, MoodCinema, Special, Goods, SNS, Event, Footer 총 12개 섹션)
- 실제 에셋 위치: 확인 못함 — Figma 노드에서 추출한 이미지는 임시 다운로드 URL(`figma.com/api/mcp/asset/...`, 7일 후 만료)이며, 실제 프로젝트의 assets 폴더 경로는 코드 저장소를 확인하지 못해 알 수 없음

## 화면 목록

| 화면 | 목적 | 주요 행동 | 필요한 상태 |
|---|---|---|---|
| Header | 전체 내비게이션과 핵심 액션 진입점 제공 | 메뉴 클릭, 검색/로그인/티켓 아이콘 클릭 | 기본만 확인됨 |
| Hero | TOP5 인기작 노출 및 예매 유도 | 슬라이드 전환, 예매하기/예고편 클릭 | 기본(5개 슬라이드 반복)만 확인됨 |
| QuickMenu | 조건 선택 후 빠른 예매 진입 | 드롭다운 선택, 예매하기 클릭 | 기본만 확인됨, 드롭다운 열림 상태 미확인 |
| 검색 | 통합 검색 및 인기 검색어 탐색 | 검색어 입력, 필터 탭 전환, 검색어 클릭 | 기본만 확인됨, 검색결과·빈 상태 없음 |
| LottePick | 단독 개봉작 강조 | 포스터 캐러셀 탐색 | 기본만 확인됨 |
| Promo | 개봉 예정작 소개 및 예매 유도 | 슬라이드 전환, 예매하기/상세정보 클릭 | 기본(4개 슬라이드), 페이지네이션 활성 상태만 확인 |
| MoodCinema | 취향 기반 영화 추천 | 가로 스크롤, 슬라이드 전환 | 기본(4개 테마 슬라이드)만 확인됨 |
| Special | 특별관 카테고리 비교 | 탭 전환, 카드 클릭 | 기본(4개 탭)만 확인됨, 탭 비활성/선택 상태 미확인 |
| Goods | 굿즈 노출 및 스토어 유입 | 배너 확인, 상품 스크롤, CTA 클릭 | 기본만 확인됨 |
| SNS | SNS 콘텐츠 노출 | 카드 클릭 | 기본(4개 카드)만 확인됨 |
| Event | 진행 중 이벤트 안내 | 리스트 항목 클릭 | 기본(3개 항목)만 확인됨, 종료된 이벤트 상태 없음 |
| Footer | 회사 정보·정책 링크 제공 | 링크 클릭, 맨 위로 이동 | 기본만 확인됨 |

## 공통 영역
- 헤더: 로고(Logo, 301×49) + Nav 6개 메뉴(예매/영화/영화관/이벤트/혜택/스토어, 텍스트만 확인, 밑줄·색상 등 현재 메뉴 표시 방식은 확인 안 됨) + Icons(검색/로그인/티켓, 각 32~40px)
- 푸터: CompanyInfo(로고+사업자정보+Copyright) + Links 5개(회사소개/이용약관/개인정보처리방침/채용안내/광고문의) + SNS 아이콘 3개(인스타/유튜브/페이스북, 18×18px) + Button-Top(맨 위로, 61×23px). 고정 정보(사업자등록번호 313-87-00979, 통신판매업신고 2018-서울송파-1184) 확인됨
- 공통 버튼: 예매하기/상세정보/예고편 CTA(176~225 × 49~61px), 탭 버튼(특별관 278×60px, 검색필터 97~113×45px), 드롭다운 버튼(232×59px). hover·pressed·disabled 상태는 Figma 메타데이터에서 확인 안 됨 (별도 라이브러리에 Button/Click·Button/hover·Button/Disable 스타일이 존재하나, 이 프레임에서 실제로 바인딩되어 쓰이는지는 불확실)
- 공통 카드: (1) Movie Ranking Card — 순위+포스터(91×143)+제목+평점+예매율 반복구조, (2) Special Theater Card — 340×560 이미지 풀커버+글래스모피즘 뱃지 반복구조, (3) SNS Card — 259×460 썸네일+플랫폼아이콘+캡션 반복구조, (4) Event List Row — 1480×100 인덱스+제목+마감일+태그 반복구조

## 디자인 토큰
- 배경색: 확인 안 됨 (다크모드 배경 자체 색상 변수는 텍스트/컬러 토큰에서 발견되지 않음, 이미지/그라디언트 배경 위주로 추정)
- 본문색: `Color/main_white #FFFFFF`, `ds/gray-900 #666666`, `subtit #99A1AF`
- 강조색: `Color/main_red #E30413`(랭킹뱃지·CTA), `color/primary/100 #F2D046`(골드 포인트), `color/primary/38 #F2D04661`(골드 반투명), Goods CTA 카드에서만 `#E7000B`(main_red와 미세하게 다른 값) 확인됨
- 제목 폰트: `Section/Header` = NanumGothic Bold 64px — 단, 실제로는 섹션에 따라 NanumSquare Bold/ExtraBold, Pretendard Bold/Black/ExtraBold도 대제목에 쓰이고 있어 폰트가 하나로 통일되어 있지 않음 (7개 패밀리 혼용 확인됨: NanumSquare, Pretendard, Pretendard Variable, RixYeoljeongdo, Noto Sans KR, SB Aggro, DM Serif Text, NanumGothic)
- 본문 폰트: `Section/Sub` = NanumGothic Regular 16px, `Body/Small` = NanumGothic Regular 13px — 실사용은 위와 동일하게 다폰트 혼용
- 기본 간격: 확인 안 됨 (섹션 간 padding/margin 규칙을 4px/8px 단위 그리드로 명시한 변수를 찾지 못함, 좌우 여백은 대체로 220px 또는 143px로 섹션마다 다름)
- 라운드: 글래스모피즘 요소 기준 — 검색패널 컨테이너 25px, 검색 입력창 16px, 필터탭 14px, 인기검색어 태그 10px, 특별관 카드뱃지 10px, Goods CTA 카드 16px, Goods 버튼 14px (섹션마다 값이 조금씩 달라 통일된 토큰으로 정의되어 있지 않음)
- 그림자: 확인 안 됨 (drop shadow 스타일이 명시적으로 발견되지 않음, 글래스모피즘은 그림자 대신 반투명 배경+얇은 보더로 구현됨)

## 반응형
- 360px: 확인 안 됨 — 디자인 파일에 모바일 프레임 없음
- 768px: 확인 안 됨 — 디자인 파일에 태블릿 프레임 없음
- 1280px: 확인 안 됨 — 디자인 원본은 1920px 데스크톱 고정폭 1개만 존재. 1280px 기준 최대 폭/열 구성은 별도 확인 필요

## 인터랙션
- 메뉴: 확인 안 됨 (Header Nav의 열기/닫기 동작, 현재 메뉴 표시 방식이 정적 텍스트로만 존재하고 상태값 없음)
- 버튼: 확인 안 됨 (hover·pressed·disabled 비주얼이 이 프레임 안에서 별도 variant로 존재하지 않음)
- 스크롤: MoodCinema는 가로 스크롤 슬라이드 구조(Scroll 프레임, 4개 Slide가 옆으로 나열)로 확인됨. Hero/LottePick/Promo/Special은 각 5·4·4·4개 variant가 나란히 배치된 캐러셀 구조로, 실제 스크롤인지 자동 슬라이드인지는 인터랙션 명세가 없어 불확실
- 애니메이션: 확인 안 됨 (트랜지션·모션 스펙이 Figma 메타데이터에 없음)

## 에셋
- 로고: 확인 안 됨 (Figma 벡터 노드로만 존재, 실제 파일 경로 없음)
- 이미지: 확인 안 됨 (포스터·배너 이미지는 Figma 임시 다운로드 URL만 확보됨, 프로젝트 assets 경로 매칭 안 됨)
- 아이콘: 확인 안 됨 (검색/로그인/티켓/재생/체크 등 아이콘이 개별 벡터로 존재, 사용 중인 아이콘 세트명이나 라이브러리 출처 불명)
- 폰트: 실제 로드 가능 여부 확인됨 — NanumGothic, Noto Sans KR은 Figma 표준 라이브러리에 존재해 웹폰트로 로드 가능. NanumSquare, Pretendard, RixYeoljeongdo, SB Aggro, DM Serif Text는 디자이너 로컬 환경에만 설치된 폰트로 확인되어, 웹 구현 시 별도로 실제 폰트 파일(.woff/.woff2) 또는 CDN 로드 주소를 구해야 함

## 확인된 사실
- WEB-메인 프레임은 총 12개 섹션(Header~Footer)으로 구성되며 폭 1920px, 높이 약 9938px
- 컬러 토큰 7개(main_red, main_gray, gray-900, primary/100, primary/38, main_white, subtit)가 Figma 변수로 정의되어 있음
- 폰트가 7개 패밀리로 혼용되어 있음 (NanumSquare, Pretendard, Pretendard Variable, RixYeoljeongdo, Noto Sans KR, SB Aggro, DM Serif Text, NanumGothic) — 이 중 NanumGothic, Noto Sans KR만 웹에서 즉시 사용 가능
- Special 섹션 카드(340×560)는 반투명 배경(rgba 255,255,255,0.11) + 얇은 보더(rgba 255,255,255,0.2) + radius 10px의 글래스모피즘 스타일로 8개 특별관에 반복 적용됨
- 검색 섹션은 QuickMenu와 LottePick 사이에 739px 높이의 고정 섹션으로 배치되어 있음 (이전 버전에는 없었고 최근 추가됨)
- Goods 섹션 CTA 카드는 main_red(#E30413)와 다른 레드값(#E7000B)을 사용함

## 아직 확인하지 못한 내용
- 모바일(360px)·태블릿(768px) 반응형 레이아웃 디자인 존재 여부
- 로딩·빈·오류 상태에 대한 디자인 시안
- 버튼의 hover·pressed·disabled 비주얼 스펙
- 실제 이미지·로고·아이콘·폰트 파일의 프로젝트 내 경로 (코드 저장소 미확인)
- 검색 섹션이 메인페이지 고정 섹션인지, 헤더 클릭 시 노출되는 모달/오버레이인지
- 폰트 7종 혼용이 의도된 것인지, 통일이 필요한 실수인지 (RixYeoljeongdo·DM Serif Text는 의도된 브랜딩 요소일 가능성 있음)
- 배경색·기본 간격·그림자 관련 디자인 토큰의 존재 여부
- 애니메이션·트랜지션 스펙 (모션 디자인 자료 별도 확인 필요)