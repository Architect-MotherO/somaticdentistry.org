# Quartz 포스팅 템플릿

somaticdentistry.org의 표준 포스팅 템플릿입니다.

## 템플릿 목록

| 파일 | 용도 | 언어 |
|------|------|------|
| `paper-en.md` | 개별 논문 리뷰 포스트 (영문) | EN |
| `paper-ko.md` | 개별 논문 리뷰 포스트 (한글) | KO |
| `topic-en.md` | 주제 종합 포스트 (영문) | EN |
| `topic-ko.md` | 주제 종합 포스트 (한글) | KO |

## 표준 구조

### Paper 포스트
```
frontmatter (title, description, aliases, tags)
→ Citation ([@BBT_citekey] 형식)
→ Summary
→ Study Design / Key Findings
→ Relevance to Dental Neuroscience
→ Clinical Implications
→ Limitations
→ Related Content
→ Footer (← Return to Home)
```

### Topic 포스트
```
frontmatter (title, description, aliases, tags)
→ Overview
→ Key Evidence (다수 논문 종합)
→ Biological Mechanisms
→ Clinical Implications
→ Future Directions
→ Related Research
→ Footer (← Return to Home)
```

## Citation 규칙

### 인라인 인용
- **형식**: `[@BBT_citekey]` (Pandoc citation)
- **예시**: `[@costePiezo1Piezo2Are2010]`, `[@qiDoseResponseMetaAnalysisTooth2021]`
- **BBT citekey 패턴**: `camelCase(firstAuthor + titleWords + year)`
  - 예: `Coste 2010 Piezo1 Piezo2 Are` → `costePiezo1Piezo2Are2010`
  - 예: `Qi 2021 Dose Response Meta Analysis Tooth` → `qiDoseResponseMetaAnalysisTooth2021`

### Citation 섹션 (Paper 포스트)
```markdown
## Citation

Authors. (Year). **Title**. *Journal*, Vol(Issue), Pages. [@citekey]

DOI: [10.xxxx/xxx](https://doi.org/10.xxxx/xxx)
```

### references.bib
- 위치: `content/references.bib`
- 형식: BibTeX (BBT auto-export)
- 자동 갱신: Zotero → BBT → Keep updated → references.bib
- 현재: 99개 엔트리, 1449줄

## 내부 링크 규칙

### Paper ↔ Topic 상호 연결
```markdown
<!-- Paper에서 Topic으로 -->
- [[topics/tooth-loss-cognition|Tooth Loss & Cognitive Decline]]

<!-- Topic에서 Paper로 -->
- [[papers/qi-2021-meta|Qi 2021: Tooth Loss & Dementia Meta-Analysis]]
```

### 다국어 링크
- EN 포스트: `[[en/index|← Return to Home]]`
- KO 포스트: `[[ko/index|← 홈으로 돌아가기]]`

## 파일명 규칙

### Papers
- 형식: `{firstAuthor}-{year}-{keyword}.md`
- 예: `coste-2010-piezo.md`, `qi-2021-meta.md`

### Topics
- 형식: `{keyword1}-{keyword2}.md`
- 예: `tooth-loss-cognition.md`, `mechanosensation.md`

## 새 포스트 작성 체크리스트

- [ ] 템플릿에서 복사하여 시작
- [ ] BBT citekey가 `references.bib`에 존재하는지 확인
- [ ] 모든 `[@citekey]`가 유효한지 검증
- [ ] en/ko 양쪽 모두 작성
- [ ] Related Content에 기존 포스트와 상호 링크
- [ ] 발행 전 `scripts/validate-content.sh` 실행
