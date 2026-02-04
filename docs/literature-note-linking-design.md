# 논문 노트 ↔ Vault 기존 노트 관계 자동 연결 설계

## 개요

Zotero Integration이 생성하는 Literature Note와 Vault의 기존 노트 간 [[wikilinks]]를 자동으로 삽입하는 로직.

## 현재 상태

### Zotero Integration Literature Note
- 형식: `@citekey.md` (예: `@wang2025frontierscience.md`)
- 위치: Vault 루트 또는 지정 폴더
- 생성 방식: Obsidian Zotero Integration 플러그인 (Pandoc Citation 템플릿)
- 현재 확인된 노트: 1개

### somaticdentistry.org 포스트
- 위치: `content/{en,ko}/papers/`, `content/{en,ko}/topics/`
- 형식: `author-year-keyword.md`
- 현재: 5개 논문 포스트 × 2언어 = 10개

## 자동 연결 설계

### 1. Literature Note → Vault 노트 연결

```yaml
auto_link_logic:
  # Literature Note 생성 시 실행
  trigger: "새 @citekey.md 생성 감지"
  
  steps:
    1_keyword_extraction:
      - Literature Note의 제목, 태그, abstract에서 키워드 추출
      - Zotero 메타데이터의 tags, collections 활용
    
    2_vault_search:
      - 키워드로 Vault 전체 검색 (find + grep)
      - 관련 노트 후보 리스트 생성
      - 최소 relevance 기준: 키워드 2개 이상 매칭
    
    3_link_insertion:
      - Literature Note의 "## 🔗 Related Notes" 섹션에 wikilinks 추가
      - 관련 Vault 노트에도 역참조 추가 (양방향)
    
    4_moc_update:
      - 관련 MOC에 Literature Note 링크 추가 (moc-auto-update-design.md 참조)
```

### 2. somaticdentistry.org 포스트 ↔ Literature Note 연결

```yaml
cross_reference:
  # 같은 논문의 다른 표현
  mapping:
    literature_note: "@costePiezo1Piezo2Are2010.md"
    web_post_en: "content/en/papers/coste-2010-piezo.md"
    web_post_ko: "content/ko/papers/coste-2010-piezo.md"
  
  # 연결 방식
  in_literature_note:
    add: "🌐 Web: [[coste-2010-piezo|somaticdentistry.org 포스트]]"
  
  in_web_post:
    add: "📝 Vault: [[@costePiezo1Piezo2Are2010|Literature Note]]"
```

### 3. Wikilinks 자동 삽입 규칙

```yaml
wikilink_rules:
  # 키워드 → 노트 매핑
  concept_links:
    "Piezo2": "[[Piezo2 채널]]"
    "periodontal mechanoreceptor": "[[치주기계수용체]]"
    "trigeminal nerve": "[[삼차신경]]"
    "hippocampus": "[[해마]]"
    "BDNF": "[[BDNF]]"
    "locus coeruleus": "[[청반]]"
    
  # 삽입 위치
  insertion_point:
    - "## 🔗 Related Notes" 섹션 (없으면 생성)
    - frontmatter의 knowledge_connections 필드
    
  # 제약
  constraints:
    - 본문 내 자동 삽입 금지 (수동만 허용)
    - Related Notes 섹션에만 자동 추가
    - 중복 링크 방지
    - 최대 10개 관련 노트까지
```

### 4. 실행 타이밍

| 시점 | 동작 | 방법 |
|------|------|------|
| 논문 Zotero 추가 시 | Literature Note 자동 생성 | Obsidian Zotero Integration |
| Literature Note 생성 후 | Vault 관련 노트 탐색 + 링크 | AI 수동 트리거 또는 서브에이전트 |
| 웹 포스트 작성 시 | Literature Note와 상호 참조 | 포스팅 워크플로우에 포함 |
| 주간 유지보수 시 | 고아 노트 탐지 + 누락 링크 보완 | ontology-maintainer 배치 처리 |

## 구현 우선순위

1. **즉시 가능**: 새 포스팅 작성 시 수동으로 Related Notes 추가 (AI 지원)
2. **단기**: 포스팅 워크플로우에 자동 링크 삽입 단계 추가
3. **중기**: Vault 전체 고아 노트 해소 배치 처리
4. **장기**: Zotero 태그 변경 감지 → 자동 재연결

## 예시

### 새 논문 추가 시 흐름

```
1. DOI → Zotero import (zotero-client.py import-doi)
2. BBT auto-export → references.bib 갱신
3. Obsidian Zotero Integration → @citekey.md 생성
4. AI 분석:
   - 태그: [piezo2, mechanosensation, dental pulp]
   - Vault 검색: "piezo" → 3개 관련 노트 발견
   - MOC 매핑: → MOC_신경생리_뇌건강
5. 자동 삽입:
   - @citekey.md에 Related Notes 추가
   - 관련 노트에 역참조 추가
   - MOC에 새 논문 링크 추가
6. 웹 포스트 작성 (en/ko)
7. validate-content.sh 실행
8. publish.sh → 발행
```
