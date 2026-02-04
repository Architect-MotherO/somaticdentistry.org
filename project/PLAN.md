# SomaticDentistry.org Website Build Plan

## Context

### Original Request
> somaticdentistry.org 홈페이지를 만들고 싶어. 논문 인용논문들을 갖고 홈페이지를 만들어 놓고 계속 포스팅을 하면 어떨까 해.

**Goal**: DentoNeural Axis 논문 투고 전, 인용 논문들 기반으로 SEO + LLM seeding을 위한 학술 블로그 구축

### Interview Summary

**Key Discussions**:
- **Platform**: Quartz v4 + GitHub Pages (무료, Obsidian 네이티브, SEO 커스터마이징 가능)
- **Content**: MVP 10페이지 (Landing, About, 3 Topics, 5 Paper Nodes) x 2 languages = 20 files
- **Languages**: 이중언어 (EN/KO) 동시 런칭
- **Zotero**: Full automation (Quartz Plugin.Citations() + BibTeX)
- **Domain**: somaticdentistry.org (보유, DNS 접근 가능)

**Research Findings**:
- Quartz v4는 네이티브 Citation 지원 (Pandoc 불필요)
- Node.js v22.20.0 설치됨 (요구사항 충족)
- Better-BibTeX Zotero 플러그인 설치됨
- 46개 DOI 논문 모두 Zotero 라이브러리에 있음

### Metis Review

**Identified Gaps** (addressed):
- MVP 페이지 명확화 → 10페이지로 확정
- 이중언어 전략 → EN/KO 동시 런칭으로 확정
- DNS 접근 확인 → 가능
- Zotero 상태 확인 → 46개 모두 있음

---

## Work Objectives

### Core Objective
Quartz v4 기반 학술 블로그를 구축하여 somaticdentistry.org에 배포. SEO 최적화 및 LLM seeding을 위한 구조화된 콘텐츠 제공.

### Concrete Deliverables
1. somaticdentistry.org 라이브 웹사이트
2. 10페이지 x 2언어 = 20개 콘텐츠 파일
3. Quartz 그래프 뷰로 논문 관계 시각화
4. Zotero 연동 자동 인용 시스템
5. GitHub Actions 자동 배포 파이프라인
6. **Worklog 문서** (각 TODO 완료 기록, `docs/WORKLOG.md`)

### Definition of Done
- [ ] `https://somaticdentistry.org` 접속 시 Landing 페이지 표시
- [ ] 모든 20개 콘텐츠 파일 렌더링 확인
- [ ] 그래프 뷰에서 논문-주제 관계 표시
- [ ] `git push` → 자동 배포 작동 확인
- [ ] Google Search Console에 사이트 등록 완료

### Must Have
- 10페이지 영어 콘텐츠
- 10페이지 한국어 콘텐츠
- Quartz 기본 그래프 뷰
- GitHub Actions CI/CD
- Custom domain 연결
- 기본 SEO 메타 태그
- **하이브리드 브랜드 컬러 적용** (공식 로고 컬러 + 브랜드 본질 컬러 조합)
- **로고 파일 포함** (헤더, 파비콘)
- **InfraNodus SEO 키워드 분석** (46개 논문 abstract 기반, 콘텐츠 작성 전)
- **Worklog 문서** (각 TODO 완료 후 진행상황 기록)

### Must NOT Have (Guardrails)
- ❌ 미발표 논문(DentoNeural Axis)의 가설/결론 공개 금지
- ❌ Schema.org ScholarlyArticle (Phase 2로 연기)
- ❌ 애널리틱스/트래킹 (Phase 2)
- ❌ 46개 전체 논문 (MVP는 5개만)
- ❌ InfraNodus 웹사이트 임베드 (Phase 2)
- ❌ 복잡한 커스텀 그래프 (Quartz 기본 사용)

---

## Verification Strategy (MANDATORY)

### Test Decision
- **Infrastructure exists**: NO (새 프로젝트)
- **User wants tests**: Manual QA (웹사이트)
- **Framework**: Playwright browser verification

### Manual QA Procedure

각 TODO 완료 후:
1. **로컬 확인**: `npx quartz build --serve` → localhost:8080 확인
2. **배포 확인**: GitHub Pages 배포 후 실제 도메인 확인
3. **브라우저 검증**: Playwright로 스크린샷 캡처
4. **Worklog 작성**: `docs/WORKLOG.md`에 완료 내용 기록

### Worklog Format

각 TODO 완료 후 `docs/WORKLOG.md`에 추가:

```markdown
## [Task N] - [Task Title] - YYYY-MM-DD HH:MM

### What was done
- [구체적인 작업 내용]
- [생성/수정된 파일 목록]

### Verification Results
- [실행한 검증 명령어 및 결과]
- [스크린샷 경로 (있는 경우)]

### Issues Encountered
- [발생한 문제 및 해결 방법]
- [없으면 "None"]

### Next Steps
- [다음 TODO 번호 및 제목]

---
```

---

## Task Flow

```
Phase 1: Infrastructure
[0. Prerequisites] → [1. Project Setup] → [2. Quartz Install] → [3. GitHub Setup]

Phase 2: Configuration + SEO
[4. Zotero BibTeX] → [5. InfraNodus Analysis] → [6. Quartz Config] → [7. Brand Colors] → [8. Citations Plugin]

Phase 3: Content (SEO keywords from Task 5 applied)
[9. Landing EN/KO] → [10. About EN/KO] → [11-13. Topics EN/KO] → [14-18. Papers EN/KO]

Phase 4: Deployment
[19. GitHub Actions] → [20. DNS Config] → [21. Custom Domain] → [22. Verification]
```

## Parallelization

| Group | Tasks | Reason |
|-------|-------|--------|
| A | 4, 5, 6 | Configuration 작업 독립적 |
| B | 9, 10, 11, 12, 13 | 콘텐츠 작성은 독립적 |
| C | 14, 15, 16, 17, 18 | 논문 노드 작성은 독립적 |
| D | 19, 20 | Actions와 DNS 동시 진행 가능 |

| Task | Depends On | Reason |
|------|------------|--------|
| 3 | 2 | Quartz 설치 후 GitHub 설정 |
| 7 | 6 | Quartz 설정 후 테마 적용 |
| 8 | 4, 6 | BibTeX + Quartz 설정 후 Citations 설정 |
| 9-13 | 5, 7, 8 | SEO 키워드 + 브랜드 컬러 + Citations 준비 후 콘텐츠 작성 |
| 19 | 18 | 모든 콘텐츠 완료 후 배포 |
| 21 | 19, 20 | Actions + DNS 설정 후 도메인 연결 |

---

## TODOs

**CRITICAL: Worklog Requirement (모든 TODO 공통)**

각 TODO 완료 후 **반드시** `docs/WORKLOG.md`에 기록:

```markdown
## [Task N] - [Task Title] - YYYY-MM-DD HH:MM

### What was done
- [구체적인 작업 내용]
- [생성/수정된 파일 목록]

### Verification Results
- [실행한 검증 명령어 및 결과]
- [스크린샷 경로 (있는 경우)]

### Issues Encountered
- [발생한 문제 및 해결 방법]
- [없으면 "None"]

### Next Steps
- [다음 TODO 번호 및 제목]

---
```

**Workflow**: TODO 완료 → Worklog 작성 → Commit → 다음 TODO 시작

---

### Phase 1: Infrastructure Setup

- [ ] 0. Prerequisites Check

  **What to do**:
  - Node.js 버전 확인 (v18+ 필요)
  - npm 설치 확인
  - Git 설치 확인
  - `/Users/ohkyunga/Projects/` 디렉토리 생성

  **Must NOT do**:
  - 기존 시스템 설정 변경

  **Parallelizable**: NO (첫 번째 작업)

  **References**:
  - Quartz docs: https://quartz.jzhao.xyz/

  **Acceptance Criteria**:
  - [ ] `node --version` → v18+ 출력
  - [ ] `npm --version` → 출력 확인
  - [ ] `git --version` → 출력 확인
  - [ ] `ls /Users/ohkyunga/Projects/` → 디렉토리 존재

  **Commit**: NO

---

- [ ] 1. Create Project Directory & Copy Assets

  **What to do**:
  - `/Users/ohkyunga/Projects/somaticdentistry.org/` 생성
  - 기본 디렉토리 구조 설정: `docs/`, `assets/`
  - Planning 문서 복사:
    - `.sisyphus/docs/PROJECT_DECISIONS.md` → `docs/PROJECT_DECISIONS.md`
    - `.sisyphus/docs/FOUNDER_PROFILE.md` → `docs/FOUNDER_PROFILE.md`
    - `.sisyphus/docs/BRAND_COLORS_HYBRID.md` → `docs/BRAND_COLORS_HYBRID.md`
  - 로고 파일 복사:
    - `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Somatic Dentistry/상표출원/Logo/로고및배경.png` → `assets/logo.png`
  - Worklog 초기화: `docs/WORKLOG.md` 생성 (헤더만)

  **Must NOT do**:
  - Dropbox 내 생성 금지 (Git 충돌 방지)
  - .ai 파일 복사 금지 (Git에 불필요)

  **Parallelizable**: NO (depends on 0)

  **References**:
  - Quartz directory structure: https://quartz.jzhao.xyz/configuration
  - Logo source: `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Somatic Dentistry/상표출원/Logo/`

  **Acceptance Criteria**:
  - [ ] `ls /Users/ohkyunga/Projects/somaticdentistry.org/` → 디렉토리 존재
  - [ ] `ls assets/logo.png` → 로고 파일 존재
  - [ ] `ls docs/WORKLOG.md` → Worklog 파일 존재

  **Commit**: NO (아직 git init 전)

---

- [ ] 2. Install Quartz v4

  **What to do**:
  - Quartz v4 클론
  - npm dependencies 설치
  - 로컬 빌드 테스트

  **Must NOT do**:
  - 테마 커스터마이징
  - 불필요한 플러그인 추가

  **Parallelizable**: NO (depends on 1)

  **References**:
  - Quartz installation: https://quartz.jzhao.xyz/
  - `git clone https://github.com/jackyzha0/quartz.git`

  **Acceptance Criteria**:
  - [ ] `npx quartz build --serve` → localhost:8080에서 기본 페이지 표시
  - [ ] 터미널에 에러 없음

  **Commit**: YES
  - Message: `chore: initial Quartz v4 setup`
  - Files: 전체 프로젝트
  - Pre-commit: `npx quartz build`

---

- [ ] 3. Initialize GitHub Repository

  **What to do**:
  - GitHub에 `somaticdentistry.org` 레포 생성
  - Remote 연결
  - 초기 커밋 push

  **Must NOT do**:
  - Private 레포 (GitHub Pages 무료는 public만)

  **Parallelizable**: NO (depends on 2)

  **References**:
  - GitHub CLI: `gh repo create Architect-MotherO/somaticdentistry.org --public`
  - Quartz hosting guide: https://quartz.jzhao.xyz/hosting

  **Acceptance Criteria**:
  - [ ] `gh repo view Architect-MotherO/somaticdentistry.org` → 레포 정보 표시
  - [ ] `git remote -v` → origin이 GitHub 레포 가리킴
  - [ ] GitHub 웹에서 코드 확인 가능

  **Commit**: YES (이미 2에서 커밋됨, 여기서는 push만)
  - Message: N/A (push only)

---

### Phase 2: Configuration

- [ ] 4. Export Zotero BibTeX

  **What to do**:
  - Zotero에서 DentoNeural Axis 컬렉션 선택
  - Better-BibTeX로 "Keep updated" 내보내기
  - `content/references.bib` 경로로 설정

  **Must NOT do**:
  - 수동 복사 (자동 동기화 설정해야 함)

  **Parallelizable**: YES (with 5)

  **References**:
  - Better-BibTeX docs: https://retorque.re/zotero-better-bibtex/
  - Zotero 설치 경로: `/Applications/Zotero.app`

  **Acceptance Criteria**:
  - [ ] `/Users/ohkyunga/Projects/somaticdentistry.org/content/references.bib` 파일 존재
  - [ ] 파일 내용에 46개 논문 엔트리 포함 (grep으로 @article 카운트)
  - [ ] Zotero에서 논문 수정 시 .bib 자동 업데이트 확인

  **Commit**: YES
  - Message: `feat: add Zotero BibTeX export configuration`
  - Files: `content/references.bib`, `.gitignore` (Zotero 캐시 제외)

---

- [ ] 5. InfraNodus SEO Keyword Analysis

  **What to do**:
  - 46개 논문의 abstract 추출 (Zotero에서)
  - `/ontology-generator` 스킬 사용하여 키워드 네트워크 생성
  - InfraNodus.com에 붙여넣기하여 분석
  - 핵심 키워드 클러스터 도출
  - SEO 키워드 리스트 작성 → `docs/SEO_KEYWORDS.md`

  **Must NOT do**:
  - 웹사이트에 InfraNodus 임베드 (Phase 2)

  **Parallelizable**: YES (with 4, 6)

  **References**:
  - ontology-generator 스킬: `/ontology-generator`
  - InfraNodus: https://infranodus.com
  - 논문 위치: `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Articles/DentoNeural_Axis_논문/`

  **Acceptance Criteria**:
  - [ ] `docs/SEO_KEYWORDS.md` 파일 생성
  - [ ] 파일에 20-30개 핵심 키워드 포함
  - [ ] 키워드를 5-7개 클러스터로 그룹화
  - [ ] InfraNodus 스크린샷 저장 (`docs/infranodus-analysis.png`)

  **Commit**: YES
  - Message: `docs: add InfraNodus SEO keyword analysis`
  - Files: `docs/SEO_KEYWORDS.md`, `docs/infranodus-analysis.png`

---

- [ ] 6. Configure Quartz for Bilingual

  **What to do**:
  - `quartz.config.ts` 수정
  - 사이트 메타데이터 설정 (title, description)
  - 기본 언어 설정 (defaultLang: "en")
  - 폴더 구조: `content/en/`, `content/ko/`

  **Must NOT do**:
  - 폰트 변경 (Phase 2)

  **Parallelizable**: YES (with 4, 5)

  **References**:
  - Quartz config: https://quartz.jzhao.xyz/configuration
  - 파일: `quartz.config.ts`

  **Acceptance Criteria**:
  - [ ] `quartz.config.ts`에 siteTitle, siteDescription 설정됨
  - [ ] `content/en/`, `content/ko/` 폴더 존재
  - [ ] 로컬 빌드 성공: `npx quartz build`

  **Commit**: YES
  - Message: `feat: configure Quartz for bilingual content structure`
  - Files: `quartz.config.ts`, `content/en/.gitkeep`, `content/ko/.gitkeep`

---

- [ ] 7. Apply Hybrid Brand Color System

  **What to do**:
  - `quartz/styles/custom.scss` 생성 (또는 수정)
  - **하이브리드 컬러 변수 정의**:
    ```scss
    /* Official Logo Colors */
    --logo-charcoal: #282627;      /* Logo text, headers */
    --logo-orange: #EE7337;        /* Logo accent, CTA buttons */
    --logo-gray: #D9D9D9;          /* Logo secondary */
    
    /* Brand Essence Colors (UI accents) */
    --accent-blue: #2E5984;        /* Links, interactive elements */
    --accent-green: #4A7C59;       /* Highlights, success states */
    --bg-warm: #E8B4A0;            /* Section backgrounds */
    ```
  - 적용 규칙:
    - Logo & Header: 공식 컬러 (#282627, #EE7337)
    - Links: Systems Blue (#2E5984)
    - Highlights: Bio Green (#4A7C59)
    - Section BG: Warm Earth (#E8B4A0)

  **Must NOT do**:
  - 레이아웃 구조 변경
  - 복잡한 CSS 애니메이션

  **Parallelizable**: NO (depends on 6)

  **References**:
  - Quartz theming: https://quartz.jzhao.xyz/configuration#custom-css
  - Official logo colors: `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Somatic Dentistry/상표출원/Logo/SomaticDentistry-로고설명서-상표출원용.docx`
  - Brand essence colors: `.sisyphus/docs/FOUNDER_PROFILE.md`

  **Acceptance Criteria**:
  - [ ] `custom.scss`에 6가지 컬러 변수 정의됨
  - [ ] 로컬 빌드 후 로고가 차콜 블랙 + 오렌지로 표시
  - [ ] 링크가 Systems Blue로 표시
  - [ ] 강조 요소가 Bio Green으로 표시

  **Commit**: YES
  - Message: `style: apply hybrid brand color system (official logo + UI accents)`
  - Files: `quartz/styles/custom.scss`

---

- [ ] 8. Enable Citations Plugin

  **What to do**:
  - `quartz.config.ts`에 `Plugin.Citations()` 추가
  - BibTeX 파일 경로 설정
  - 인용 스타일 설정 (APA or Vancouver)

  **Must NOT do**:
  - Pandoc 설치/사용 (Quartz 네이티브 사용)

  **Parallelizable**: NO (depends on 4, 6)

  **References**:
  - Quartz Citations: https://quartz.jzhao.xyz/plugins/Citations
  - 파일: `quartz.config.ts`

  **Acceptance Criteria**:
  - [ ] 테스트 마크다운에 `[@citation-key]` 삽입 시 렌더링 확인
  - [ ] 페이지 하단에 References 섹션 자동 생성
  - [ ] 인용 스타일 올바르게 적용

  **Commit**: YES
  - Message: `feat: enable Quartz citations plugin with BibTeX`
  - Files: `quartz.config.ts`

---

### Phase 3: Content Creation

- [ ] 9. Create Landing Page (EN/KO)

  **What to do**:
  - `content/en/index.md` 작성: "The DentoNeural Connection"
  - `content/ko/index.md` 작성: "치아와 뇌의 연결"
  - YAML frontmatter 설정 (title, description, lang)
  - 내부 링크 설정 (About, Topics)
  - SEO 키워드 Task 5 결과 반영

  **Must NOT do**:
  - DentoNeural Axis 논문 가설/결론 언급 금지
  - 과도한 학술적 언어 사용 (일반인 접근성 유지)

  **Parallelizable**: YES (with 10-13)

  **References**:
  - Somatic Dentistry 브랜드 본질: `/Users/ohkyunga/OKA2Brain/0/선한영향력/000-오경아/10-브랜드오경아/⭐비전&철학/⭐오경아브랜드본질.md`
  - 3단계 깊이 모델: "동적 공간 → Systems Medicine → Systems Spirituality"
  - SEO 키워드: `docs/SEO_KEYWORDS.md` (Task 5 결과)

  **Acceptance Criteria**:
  - [ ] 로컬 빌드 후 Landing 페이지 표시
  - [ ] EN/KO 각각 접근 가능
  - [ ] 내부 링크 작동 확인
  - [ ] 브랜드 컬러 적용 확인

  **Commit**: YES
  - Message: `content: add landing pages (EN/KO)`
  - Files: `content/en/index.md`, `content/ko/index.md`

---

- [ ] 10. Create About Page (EN/KO)

  **What to do**:
  - `content/en/about.md`: "About Somatic Dentistry"
  - `content/ko/about.md`: "Somatic Dentistry 소개"
  - 브랜드 철학, 창시자 소개, 3단계 깊이 모델 설명

  **Must NOT do**:
  - 개인 연락처 공개 (문의 폼 대신 일반적 소개만)

  **Parallelizable**: YES (with 9, 11-13)

  **References**:
  - 브랜드 본질 문서: `/Users/ohkyunga/OKA2Brain/0/선한영향력/000-오경아/10-브랜드오경아/⭐비전&철학/⭐오경아브랜드본질.md`
  - 핵심 메시지 3가지: "동적 공간이 건강을 결정", "치아에서 시작, 전신으로 확장", "시스템 사고로 통합 치료"

  **Acceptance Criteria**:
  - [ ] About 페이지 EN/KO 렌더링 확인
  - [ ] Landing에서 About 링크 작동

  **Commit**: YES
  - Message: `content: add about pages (EN/KO)`
  - Files: `content/en/about.md`, `content/ko/about.md`

---

- [ ] 11. Create Topic: Tooth Loss & Cognition (EN/KO)

  **What to do**:
  - `content/en/topics/tooth-loss-cognition.md`
  - `content/ko/topics/tooth-loss-cognition.md`
  - 치아 상실과 인지 기능 저하 연구 요약
  - 관련 논문 인용 (Qi 2021 등)

  **Must NOT do**:
  - DentoNeural Axis 가설 직접 언급

  **Parallelizable**: YES (with 9-10, 12-13)

  **References**:
  - DOI: 10.1016/j.jamda.2021.05.009 (Qi et al. meta-analysis)
  - Zotero BibTeX 참조

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 확인
  - [ ] Citation 작동 확인 (References 섹션 표시)
  - [ ] 그래프 뷰에서 논문 노드 연결 표시

  **Commit**: YES
  - Message: `content: add tooth loss & cognition topic (EN/KO)`
  - Files: `content/en/topics/tooth-loss-cognition.md`, `content/ko/topics/tooth-loss-cognition.md`

---

- [ ] 12. Create Topic: Periodontal & Brain (EN/KO)

  **What to do**:
  - `content/en/topics/periodontal-brain.md`
  - `content/ko/topics/periodontal-brain.md`
  - 치주질환과 뇌 염증 연구 요약

  **Must NOT do**:
  - 과도한 의학적 주장 (evidence-based만)

  **Parallelizable**: YES (with 9-11, 13)

  **References**:
  - 관련 DOI들 (Zotero에서 확인)

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 Citation 작동

  **Commit**: YES
  - Message: `content: add periodontal & brain topic (EN/KO)`
  - Files: `content/en/topics/periodontal-brain.md`, `content/ko/topics/periodontal-brain.md`

---

- [ ] 13. Create Topic: Mechanosensation (EN/KO)

  **What to do**:
  - `content/en/topics/mechanosensation.md`
  - `content/ko/topics/mechanosensation.md`
  - 교합 기계감각과 뇌 신호 연구 요약
  - Piezo 채널 관련 연구 인용

  **Must NOT do**:
  - DentoNeural Axis 핵심 가설 공개

  **Parallelizable**: YES (with 9-12)

  **References**:
  - DOI: 10.1152/physrev.00018.2018 (Coste & Bhalla Piezo review)

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 Citation 작동

  **Commit**: YES
  - Message: `content: add mechanosensation topic (EN/KO)`
  - Files: `content/en/topics/mechanosensation.md`, `content/ko/topics/mechanosensation.md`

---

- [ ] 14. Create Paper Node: Livingston 2020 (EN/KO)

  **What to do**:
  - `content/en/papers/livingston-2020-dementia.md`
  - `content/ko/papers/livingston-2020-dementia.md`
  - Lancet Commission 치매 예방 리포트 요약
  - 치아 건강이 치매 위험 요인임을 강조

  **Must NOT do**:
  - 전체 논문 번역 (요약만)

  **Parallelizable**: YES (with 15-18)

  **References**:
  - DOI: 10.1016/S0140-6736(20)30367-6
  - Zotero citation key 사용

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링
  - [ ] Topic 페이지에서 이 논문으로 링크 확인
  - [ ] 그래프 뷰에서 연결 확인

  **Commit**: YES
  - Message: `content: add Livingston 2020 paper node (EN/KO)`
  - Files: `content/en/papers/livingston-2020-dementia.md`, `content/ko/papers/livingston-2020-dementia.md`

---

- [ ] 15. Create Paper Node: Coste 2018 (EN/KO)

  **What to do**:
  - `content/en/papers/coste-2018-piezo.md`
  - `content/ko/papers/coste-2018-piezo.md`
  - Piezo 채널 생리학 리뷰 요약

  **Parallelizable**: YES (with 14, 16-18)

  **References**:
  - DOI: 10.1152/physrev.00018.2018

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 그래프 연결

  **Commit**: YES
  - Message: `content: add Coste 2018 paper node (EN/KO)`
  - Files: `content/en/papers/coste-2018-piezo.md`, `content/ko/papers/coste-2018-piezo.md`

---

- [ ] 16. Create Paper Node: Qi 2021 (EN/KO)

  **What to do**:
  - `content/en/papers/qi-2021-meta.md`
  - `content/ko/papers/qi-2021-meta.md`
  - 치아 상실-인지 저하 메타분석 요약

  **Parallelizable**: YES (with 14-15, 17-18)

  **References**:
  - DOI: 10.1016/j.jamda.2021.05.009

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 그래프 연결

  **Commit**: YES
  - Message: `content: add Qi 2021 paper node (EN/KO)`
  - Files: `content/en/papers/qi-2021-meta.md`, `content/ko/papers/qi-2021-meta.md`

---

- [ ] 17. Create Paper Node: [High-impact #4] (EN/KO)

  **What to do**:
  - 46개 DOI 중 high-impact 논문 선정 (Nature/Science/Cell 우선)
  - 요약 페이지 작성

  **Must NOT do**:
  - 저임팩트 논문 선정

  **Parallelizable**: YES (with 14-16, 18)

  **References**:
  - Zotero DOI list: `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Articles/DentoNeural_Axis_논문/Zotero_DOI_List_DentoNeural_Axis.md`
  - 선정 기준: Nature/Science/Cell > Impact Factor > Citation count

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 그래프 연결

  **Commit**: YES
  - Message: `content: add [paper name] node (EN/KO)`
  - Files: `content/en/papers/[slug].md`, `content/ko/papers/[slug].md`

---

- [ ] 18. Create Paper Node: [High-impact #5] (EN/KO)

  **What to do**:
  - 위와 동일 (Task 17 참조)

  **Parallelizable**: YES (with 14-17)

  **References**:
  - Zotero DOI list: `/Users/ohkyunga/Library/CloudStorage/Dropbox/Claude/OhKyungA/Articles/DentoNeural_Axis_논문/Zotero_DOI_List_DentoNeural_Axis.md`

  **Acceptance Criteria**:
  - [ ] 페이지 렌더링 및 그래프 연결

  **Commit**: YES
  - Message: `content: add [paper name] node (EN/KO)`
  - Files: `content/en/papers/[slug].md`, `content/ko/papers/[slug].md`

---

### Phase 4: Deployment

- [ ] 19. Configure GitHub Actions

  **What to do**:
  - `.github/workflows/deploy.yml` 생성
  - Quartz build → GitHub Pages 배포 워크플로우
  - main branch push 시 자동 트리거

  **Must NOT do**:
  - 복잡한 CI 파이프라인 (기본만)

  **Parallelizable**: NO (depends on all content tasks 9-18)

  **References**:
  - Quartz GitHub Actions: https://quartz.jzhao.xyz/hosting#github-pages
  - Example workflow: Quartz repository `.github/workflows/` 참조

  **Acceptance Criteria**:
  - [ ] `git push` 후 Actions 탭에서 워크플로우 실행 확인
  - [ ] 워크플로우 성공 (녹색 체크)
  - [ ] `gh-pages` 브랜치에 빌드 결과물 존재

  **Commit**: YES
  - Message: `ci: add GitHub Actions workflow for Pages deployment`
  - Files: `.github/workflows/deploy.yml`

---

- [ ] 20. Configure DNS Records

  **What to do**:
  - 도메인 등록업체 DNS 설정 접속
  - CNAME 또는 A 레코드 설정
    - CNAME: `www` → `architect-mothero.github.io`
    - A: `@` → GitHub Pages IP 주소들

  **Must NOT do**:
  - 기존 DNS 레코드 삭제 (추가만)

  **Parallelizable**: YES (with 19)

  **References**:
  - GitHub Pages custom domain: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site
  - GitHub Pages IPs: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153

  **Acceptance Criteria**:
  - [ ] `dig somaticdentistry.org` → GitHub Pages IP 또는 CNAME 확인
  - [ ] DNS propagation 완료 (최대 24-48시간 대기 가능)

  **Commit**: NO (DNS는 외부 설정)

---

- [ ] 21. Enable Custom Domain in GitHub Pages

  **What to do**:
  - GitHub repo Settings → Pages → Custom domain
  - `somaticdentistry.org` 입력
  - "Enforce HTTPS" 활성화
  - `CNAME` 파일 확인 (자동 생성됨)

  **Must NOT do**:
  - HTTPS 비활성화

  **Parallelizable**: NO (depends on 19, 20)

  **References**:
  - GitHub Pages settings: repo → Settings → Pages

  **Acceptance Criteria**:
  - [ ] `https://somaticdentistry.org` 접속 시 사이트 표시
  - [ ] HTTPS 자물쇠 표시 (SSL 활성화)
  - [ ] HTTP → HTTPS 리다이렉트 작동

  **Commit**: YES (CNAME 파일)
  - Message: `chore: add CNAME for custom domain`
  - Files: `CNAME`

---

- [ ] 22. Final Verification & SEO Setup

  **What to do**:
  - 전체 사이트 기능 테스트
  - Google Search Console 등록
  - 사이트맵 제출 (`/sitemap.xml`)
  - robots.txt 확인

  **Must NOT do**:
  - 애널리틱스 설치 (Phase 2)

  **Parallelizable**: NO (final task)

  **References**:
  - Google Search Console: https://search.google.com/search-console

  **Acceptance Criteria**:
  - [ ] 모든 20개 페이지 접근 가능
  - [ ] 그래프 뷰 작동
  - [ ] Citations 작동
  - [ ] Google Search Console에서 사이트맵 인식
  - [ ] robots.txt가 크롤링 허용

  **Commit**: NO (외부 설정)

---

## Commit Strategy

| After Task | Message | Files | Verification |
|------------|---------|-------|--------------|
| 2 | `chore: initial Quartz v4 setup` | 전체 | `npx quartz build` |
| 4 | `feat: add Zotero BibTeX export` | `.bib`, `.gitignore` | grep @article |
| 5 | `docs: add InfraNodus SEO analysis` | `docs/SEO_KEYWORDS.md` | 키워드 확인 |
| 6 | `feat: configure bilingual structure` | `quartz.config.ts` | build |
| 7 | `style: apply brand colors` | `custom.scss` | 색상 확인 |
| 8 | `feat: enable citations plugin` | `quartz.config.ts` | citation test |
| 9-10 | `content: add landing and about` | `content/**/*.md` | build |
| 11-13 | `content: add topic pages` | `content/**/topics/*.md` | build |
| 14-18 | `content: add paper nodes` | `content/**/papers/*.md` | build |
| 19 | `ci: add GitHub Actions workflow` | `.github/workflows/*` | Actions run |
| 21 | `chore: add CNAME` | `CNAME` | domain access |

---

## Success Criteria

### Verification Commands

```bash
# 로컬 빌드 테스트
npx quartz build --serve
# Expected: localhost:8080에서 사이트 표시

# 페이지 카운트
find content -name "*.md" | wc -l
# Expected: 20 (10 pages x 2 languages)

# BibTeX 엔트리 카운트
grep -c "@article\|@book\|@inproceedings" content/references.bib
# Expected: 46

# DNS 확인
dig somaticdentistry.org
# Expected: GitHub Pages IP 또는 CNAME

# SSL 확인
curl -I https://somaticdentistry.org
# Expected: HTTP/2 200
```

### Final Checklist

- [ ] All "Must Have" present
- [ ] All "Must NOT Have" absent
- [ ] 10 EN pages published
- [ ] 10 KO pages published
- [ ] Graph view shows relationships
- [ ] Citations work correctly
- [ ] HTTPS enabled
- [ ] Google Search Console registered
