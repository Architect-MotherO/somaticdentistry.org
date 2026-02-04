# SomaticDentistry.org Project Decisions

**Document Created**: 2026-02-04
**Planning Session**: Prometheus consultation for website build
**Status**: MVP Planning Complete

---

## 1. Project Overview

### Goal
DentoNeural Axis 논문 투고 전, 인용 논문들 기반으로 학술 블로그를 구축하여:
- SEO 최적화로 검색 노출 확보
- LLM seeding으로 AI 시스템에 Somatic Dentistry 개념 학습시키기
- 논문 발표 전 학술적 기반 마련

### Constraints
- **MUST NOT**: 미발표 논문(DentoNeural Axis)의 가설/결론 공개 금지
- **ONLY**: 공개된 인용 논문들만 다룸

---

## 2. Platform Selection

### Decision: **Quartz v4 + GitHub Pages**

| 고려 옵션 | 결정 | 이유 |
|-----------|------|------|
| WordPress | ❌ | SEO 최강이나 유지보수 부담, 호스팅 비용 발생 |
| Obsidian Publish | ❌ | 가장 쉬우나 SEO 제한적, Schema.org 미지원 |
| passeth/MY-BLOG_OBSI | ❌ | 커뮤니티 지원 부족, Quartz 대비 기능 열세 |
| **Quartz v4 + GitHub Pages** | ✅ | 무료, Obsidian 네이티브, SEO 커스터마이징 가능, 활발한 커뮤니티 |

### Key Benefits of Quartz
- Native Obsidian workflow (wikilinks, backlinks)
- Built-in graph view (논문 관계 시각화)
- Native citation support (`Plugin.Citations()`)
- Static site = fast loading = better SEO/LLM indexing
- Free hosting on GitHub Pages

---

## 3. Technical Stack

| Component | Choice | Rationale |
|-----------|--------|-----------|
| **SSG** | Quartz v4 | Obsidian-first, citation support |
| **Hosting** | GitHub Pages | Free, reliable, SSL included |
| **CI/CD** | GitHub Actions | Auto-deploy on push |
| **Domain** | somaticdentistry.org | Already owned |
| **Citations** | Quartz Plugin.Citations() | Native, no Pandoc needed |
| **Bibliography** | Zotero + Better-BibTeX | Auto-export .bib file |
| **Version Control** | Git + GitHub | Standard, backup included |
| **GitHub Account** | Architect-MotherO | Authenticated via gh CLI |

### Verified Prerequisites
- Node.js v22.20.0 (requirement: v18+) ✅
- npm v10.9.3 ✅
- GitHub CLI authenticated (Architect-MotherO) ✅
- Better-BibTeX Zotero plugin installed ✅
- 46 DOIs in Zotero library ✅
- DNS access available ✅

---

## 4. Content Strategy

### MVP Scope: 10 Pages x 2 Languages = 20 Content Files

**Hub Pages (2)**:
1. Landing: "The DentoNeural Connection" (EN/KO)
2. About: "About Somatic Dentistry" (EN/KO)

**Topic Review Pages (3)**:
3. "Tooth Loss and Cognitive Decline"
4. "Periodontal Disease and Brain Inflammation"
5. "Mechanosensation: How Your Jaw Talks to Your Brain"

**Paper Node Pages (5)**:
6. Livingston et al. (2020) - Lancet Dementia Risk Factors
7. Coste & Bhalla (2018) - Piezo Channel Physiology Review
8. Qi et al. (2021) - Tooth Loss Meta-analysis
9. [High-impact paper #4 - TBD]
10. [High-impact paper #5 - TBD]

### Content Structure (Quartz Graph View)
```
                    [Somatic Dentistry]
                           │
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
    [Tooth Loss]    [Periodontal]   [Mechanosensation]
         │               │               │
    ┌────┼────┐     ┌────┼────┐     ┌────┼────┐
    ▼    ▼    ▼     ▼    ▼    ▼     ▼    ▼    ▼
  Paper Paper Paper  ...  ...  ...  Piezo  ...  ...
```

### Language Strategy
- **Primary**: English first (학술 SEO, 국제 도달)
- **Secondary**: Korean translation
- **Structure**: Folder-based (`content/en/`, `content/ko/`)
- **MVP**: Both languages at launch (사용자 선택)

---

## 5. Zotero Integration

### Configuration
- **Source**: DentoNeural Axis collection (46 DOIs)
- **Export**: Better-BibTeX "Keep updated" auto-export
- **Path**: `content/references.bib`
- **Integration**: Quartz `Plugin.Citations()`

### Citation Workflow
```
Zotero Library
     │
     ▼ (Better-BibTeX auto-export)
references.bib
     │
     ▼ (Quartz build)
HTML with formatted citations + References section
```

### Available DOIs (46 total)
```
10.1016/S0140-6736(20)30367-6  # Livingston - Lancet Dementia
10.1152/physrev.00018.2018     # Coste - Piezo Review
10.1016/j.jamda.2021.05.009    # Qi - Meta-analysis
... (43 more in Zotero)
```

---

## 6. Directory Structure

```
/Users/ohkyunga/Projects/somaticdentistry.org/
├── content/
│   ├── en/                    # English content
│   │   ├── index.md          # Landing page
│   │   ├── about.md          # About page
│   │   ├── topics/           # Topic review pages
│   │   │   ├── tooth-loss-cognition.md
│   │   │   ├── periodontal-brain.md
│   │   │   └── mechanosensation.md
│   │   └── papers/           # Paper node pages
│   │       ├── livingston-2020-dementia.md
│   │       ├── coste-2018-piezo.md
│   │       └── ...
│   ├── ko/                    # Korean content (parallel structure)
│   │   └── ...
│   └── references.bib         # Zotero auto-export
├── quartz/                    # Quartz framework
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Actions
├── docs/                      # Project documentation
│   ├── PROJECT_DECISIONS.md   # This file
│   └── FOUNDER_PROFILE.md     # Founder profile
├── quartz.config.ts           # Quartz configuration
├── CNAME                      # Custom domain
└── .gitignore
```

---

## 7. Scope Boundaries (Guardrails)

### MVP Includes
- ✅ 10 English pages
- ✅ 10 Korean pages
- ✅ Quartz default graph view
- ✅ GitHub Actions auto-deploy
- ✅ Custom domain (somaticdentistry.org)
- ✅ Basic SEO meta tags
- ✅ Zotero citation integration

### MVP Excludes (Phase 2)
- ❌ Custom theme (colors, fonts)
- ❌ Schema.org ScholarlyArticle markup
- ❌ Analytics/tracking
- ❌ All 46 papers (only 5 for MVP)
- ❌ Custom graph visualization
- ❌ Contact form

### Content Guardrails
- ❌ DentoNeural Axis 핵심 가설 공개 금지
- ❌ 미발표 연구 결론 언급 금지
- ✅ 공개된 인용 논문만 다룸
- ✅ 각 페이지에 disclaimer 포함

---

## 8. Key Decisions Timeline

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-02-04 | Platform: Quartz + GitHub Pages | Free, SEO-capable, Obsidian-native |
| 2026-02-04 | Language: Bilingual MVP | User preference, broader reach |
| 2026-02-04 | Content: 10 pages x 2 lang | Comprehensive MVP, manageable scope |
| 2026-02-04 | Zotero: Full automation | User requirement for efficiency |
| 2026-02-04 | Vault: Local folder | Git conflict prevention (not Dropbox) |
| 2026-02-04 | Path: /Users/ohkyunga/Projects/somaticdentistry.org/ | Movable later if needed |
| 2026-02-04 | InfraNodus: SEO keyword analysis | User request for SEO optimization |
| 2026-02-04 | Brand Colors: Apply in MVP | User request for customization |
| 2026-02-04 | Worklog: Required per TODO | User request for progress tracking |
| 2026-02-04 | shadcn MCP: NOT used | Unnecessary for static academic blog |

---

## 9. Success Metrics

### Launch Criteria
- [ ] Site live at https://somaticdentistry.org
- [ ] All 20 content files accessible
- [ ] Graph view functional
- [ ] Citations rendering correctly
- [ ] HTTPS enabled
- [ ] Google Search Console registered

### Post-Launch Goals (Phase 2)
- Schema.org structured data for ScholarlyArticle
- Google Analytics integration
- Additional paper nodes (up to 46)
- Korean SEO optimization
- Custom theme matching brand colors
- YouTube/Book cross-promotion

---

## 10. Related Documents

- **Work Plan**: `.sisyphus/plans/somaticdentistry-website.md`
- **Founder Profile**: `.sisyphus/docs/FOUNDER_PROFILE.md`
- **Draft Notes**: `.sisyphus/drafts/somaticdentistry-website.md`
- **Brand Essence**: `OKA2Brain/0/선한영향력/000-오경아/10-브랜드오경아/⭐비전&철학/⭐오경아브랜드본질.md`

---

## 11. Interview Q&A Summary

### Platform Selection
**Q**: WordPress vs Obsidian Publish vs GitHub-based?
**A**: Quartz + GitHub Pages - SEO 커스터마이징 가능, 자동화 후 유지보수 최소

### Technical Effort
**Q**: 기술적 작업에 시간 투자 가능?
**A**: 초기 셋업 OK, 최종적으로 자동화 원함. 기술 작업으로 더 나은 결과 얻을 수 있다면 진행.

### Zotero Integration
**Q**: Zotero 통합 중요도?
**A**: 매우 중요 - 자동화의 핵심 요소

### Content Strategy
**Q**: 개별 논문 vs 주제별 통합?
**A**: 둘 다 - 주제별 허브 + 개별 논문 노드 (그래프 뷰 활용)

### MVP Scope
**Q**: 초기 콘텐츠 범위?
**A**: 10페이지 (Comprehensive) - Landing + About + 3 Topics + 5 Papers

### Language
**Q**: 주요 언어?
**A**: 이중언어 (EN/KO) - 영어 먼저 작성, 한글 번역 추가, MVP에서 동시 런칭

---

*Document generated during Prometheus planning session - 2026-02-04*
*Location: /Users/ohkyunga/.sisyphus/docs/PROJECT_DECISIONS.md*
*To copy to project folder, run /start-work*
