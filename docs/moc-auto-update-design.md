# MOC 자동 생성/업데이트 설계

## 개요

Vault의 논문 노트가 추가될 때 관련 MOC를 자동으로 업데이트하는 로직.

## 기존 MOC 구조

Vault에 22개의 MOC 파일 존재. 논문 포스팅과 관련 있는 핵심 MOC:

| MOC | 위치 | 역할 |
|-----|------|------|
| `⭐선한영향력-MOC-Hub.md` | `000-오경아/0-Dashboard/` | 최상위 허브 |
| `MOC_신경생리_뇌건강.md` | `200-Somatic-Dentistry/220-ALF-Therapy/ALF-지식체계/` | 삼차신경, 뇌건강 |
| `MOC_자세교합TMJ_시스템.md` | 동일 | TMJ, 교합 |
| `MOC_두개골정골의학_기초.md` | 동일 | 두개골, 정골의학 |
| `InfraNodus-Tool-Suite-MOC.md` | `R - Resources/AI 도구 가이드/` | 분석 도구 |

## 논문 노트 → MOC 연결 로직

### 1. 논문 노트 위치
- Zotero Integration 생성: `@citekey.md` 형식 (현재 `@wang2025frontierscience.md` 1개 확인)
- somaticdentistry.org 포스트: `content/en/papers/`, `content/ko/papers/`

### 2. 자동 매핑 규칙

```yaml
mapping_rules:
  # 태그 기반 매핑
  tags_to_moc:
    - tags: [trigeminal, brain, cognition, hippocampus, BDNF, mechanosensation]
      moc: "[[MOC_신경생리_뇌건강]]"
    - tags: [TMJ, occlusion, bite, jaw]
      moc: "[[MOC_자세교합TMJ_시스템]]"
    - tags: [cranial, osteopathy, CSF]
      moc: "[[MOC_두개골정골의학_기초]]"
    - tags: [ALF, orthodontic, appliance, pediatric]
      moc: "[[MOC_발달과성장_소아치료]]"
    - tags: [sleep, apnea, airway, breathing]
      moc: "[[MOC_수면호흡장애_ALF치료]]"
    - tags: [myofunctional, tongue, swallow]
      moc: "[[MOC_근기능치료_MFT]]"

  # 기본 매핑 (모든 논문 노트)
  default_mocs:
    - "[[⭐선한영향력-MOC-Hub]]"  # 최상위 허브에 논문 섹션 추가
```

### 3. MOC 업데이트 프로세스

```
새 논문 노트 생성
  ↓
1. 태그/키워드 분석 → 관련 MOC 결정
2. MOC 파일에 논문 링크 추가 (## 📚 관련 논문 섹션)
3. 논문 노트의 knowledge_connections에 MOC 추가
4. 양방향 링크 검증
```

### 4. 구현 방식

- **수동 트리거**: 새 논문 포스팅 작성 시 AI가 자동으로 관련 MOC에 링크 추가
- **배치 처리**: ontology-maintainer 스킬의 network-building 워크플로우 활용
- **검증**: 고아 노트 0개 유지

## 향후 개선

- 논문 수 증가 시 전용 `📖 논문-MOC.md` 생성 고려
- 주제별 논문 클러스터 자동 감지 (InfraNodus 활용)
- Zotero 컬렉션 구조와 MOC 구조 동기화
