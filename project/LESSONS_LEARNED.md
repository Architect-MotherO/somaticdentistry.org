# Lessons Learned - SomaticDentistry.org

**프로젝트**: somaticdentistry.org  
**작성일**: 2026-02-04  
**목적**: 비슷한 프로젝트 시 참고할 핵심 유의사항

---

## 🚨 Critical Issues & Solutions

### 1. GitHub OAuth Workflow Scope 문제

**증상**:
```
! [remote rejected] v4 -> v4 (refusing to allow an OAuth App to create or update workflow without `workflow` scope)
```

**원인**: `gh` CLI 토큰에 `workflow` scope가 없음

**해결**:
1. GitHub 웹 UI에서 직접 workflow 파일 추가
2. 경로: repo → Add file → Create new file → `.github/workflows/deploy.yml`

**예방**: `gh auth login`으로 재인증 시 `workflow` scope 포함 요청

---

### 2. Quartz 기본 Workflow 파일 충돌

**증상**: Quartz 클론 후 push 시 workflow 관련 오류

**원인**: Quartz 레포에 기본 workflow 파일들이 포함됨
- `build-preview.yaml`
- `ci.yaml`
- `deploy-preview.yaml`
- `docker-build-push.yaml`

**해결**:
```bash
git rm --cached .github/workflows/*.yaml
git commit -m "chore: remove Quartz workflows"
git push
```

---

### 3. Zotero BibTeX 내보내기

**증상**: Zotero GUI로 자동 내보내기 설정 불가 (CLI 환경)

**해결**: Better-BibTeX HTTP API 사용
```bash
# Zotero 앱 실행 상태에서:
curl "http://localhost:23119/better-bibtex/export/collection?/0/DentoNeural%20Axis.biblatex" > content/references.bib
```

**전제조건**: 
- Zotero 앱 실행 중
- Better-BibTeX 플러그인 설치됨

---

### 4. 프로젝트 docs 폴더 충돌

**증상**: Quartz 자체 `docs/` 폴더와 프로젝트 문서 충돌

**해결**: 프로젝트 문서는 `project/` 폴더로 이동

**구조**:
```
somaticdentistry.org/
├── docs/          # Quartz 공식 문서 (건드리지 않음)
└── project/       # 프로젝트 자체 문서
    ├── PLAN.md
    ├── WORKLOG.md
    └── ...
```

---

## ⚙️ Quartz v4 설정 팁

### Citation 설정
```typescript
// quartz.config.ts
Plugin.Citations({
  bibliographyFile: "content/references.bib",
  linkCitations: true
})
```

### 이중언어 폴더 구조
```
content/
├── index.md        # 루트 (언어 선택 페이지)
├── en/             # 영어
│   ├── index.md
│   └── ...
├── ko/             # 한국어
│   ├── index.md
│   └── ...
└── references.bib  # 공유 BibTeX
```

### 브랜드 컬러 적용
- 파일: `quartz/styles/custom.scss`
- Config: `quartz.config.ts` → `theme.colors`

---

## 📋 GitHub Pages 배포 체크리스트

1. **GitHub Actions 워크플로우** (`.github/workflows/deploy.yml`)
   - 트리거: `push` to `v4` branch
   - 빌드: `npx quartz build`
   - 배포: `actions/deploy-pages@v4`

2. **GitHub Pages 설정**
   - Settings → Pages → Source: "GitHub Actions"
   - Custom domain 입력
   - Enforce HTTPS 활성화

3. **DNS 설정** (도메인 등록업체)
   ```
   Type: A
   Host: @
   Values:
     185.199.108.153
     185.199.109.153
     185.199.110.153
     185.199.111.153
   ```

4. **CNAME 파일** (repo 루트)
   ```
   somaticdentistry.org
   ```

---

## 🛡️ 콘텐츠 가드레일

### MUST NOT
- ❌ DentoNeural Axis 미발표 가설/결론 공개
- ❌ 개인 연락처 공개
- ❌ 의학적 조언 제공

### MUST
- ✅ 공개된 인용 논문만 다룸
- ✅ 각 페이지에 disclaimer 포함
- ✅ `[@citationKey]` 문법으로 출처 명시

---

## 🔧 유용한 명령어

```bash
# 로컬 빌드 & 미리보기
npx quartz build --serve

# 콘텐츠 파일 수 확인
find content -name "*.md" | wc -l

# BibTeX 엔트리 수 확인
grep -c "^@" content/references.bib

# GitHub Pages 상태 확인
gh api repos/OWNER/REPO/pages

# DNS 확인
dig somaticdentistry.org +short
```

---

## 📚 관련 문서

| 문서 | 용도 |
|------|------|
| `PLAN.md` | 전체 TODO 상세 계획 |
| `WORKLOG.md` | 작업 기록, 상세 이슈 해결 과정 |
| `PROJECT_DECISIONS.md` | 기술 스택 선정 이유 |
| `SEO_KEYWORDS.md` | 키워드 클러스터 |
| `FOUNDER_PROFILE.md` | 브랜드 톤앤보이스 |

---

*다음 프로젝트 시 이 파일을 먼저 확인하세요!*
