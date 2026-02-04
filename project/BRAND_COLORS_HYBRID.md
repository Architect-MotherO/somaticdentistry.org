# Somatic Dentistry Hybrid Color System

**Created**: 2026-02-04
**Purpose**: Reconcile official logo colors with brand essence colors

---

## Color Conflict Resolution

### Issue
Two different color systems discovered:
1. **Official Logo Guide** (2025 상표출원용) - Charcoal #282627, Orange #EE7337
2. **Brand Essence Document** - Warm Earth #E8B4A0, Systems Blue #2E5984, Bio Green #4A7C59

### Decision
**Hybrid approach** - Use BOTH systems strategically for richer visual experience.

---

## Official Logo Colors (PRIMARY)

| Color | Hex | Usage | Symbolism |
|-------|-----|-------|-----------|
| **Charcoal Black** | `#282627` | Logo text, headers, body text | 전문성, 안정감 |
| **Vivid Orange** | `#EE7337` | Logo accent, CTA buttons | 생명력, 에너지, 융합 |
| **Cool Gray** | `#D9D9D9` | Logo secondary element | 부드러움, 수용성 |

### Logo Symbolism
- **Large ring** (Charcoal): 난자, Dentistry, 포용적
- **Small ring** (Cool Gray): 정자, Somatics, 능동적
- **Intersection** (Orange): 수정 순간, 융합, 새로운 탄생

---

## Brand Essence Colors (ACCENTS)

| Color | Hex | Usage | Philosophy Connection |
|-------|-----|-------|----------------------|
| **Warm Earth** | `#E8B4A0` | Section backgrounds, hero | 동적 공간 (Level 1 - 물질) |
| **Systems Blue** | `#2E5984` | Links, buttons, interactive | Systems Medicine (Level 2 - 과학) |
| **Bio Green** | `#4A7C59` | Highlights, quotes, success | Systems Spirituality (Level 3 - 생명) |

---

## Hybrid System CSS Variables

```scss
/* quartz/styles/custom.scss */

:root {
  /* Official Logo Colors - Primary Identity */
  --logo-charcoal: #282627;
  --logo-orange: #EE7337;
  --logo-gray: #D9D9D9;
  
  /* Brand Essence Colors - UI Accents */
  --accent-blue: #2E5984;
  --accent-green: #4A7C59;
  --bg-warm: #E8B4A0;
  
  /* Semantic Mapping */
  --color-primary: var(--logo-charcoal);
  --color-accent: var(--logo-orange);
  --color-link: var(--accent-blue);
  --color-highlight: var(--accent-green);
  --color-bg-section: var(--bg-warm);
}
```

---

## Application Rules

| Element | Color | Variable | Rationale |
|---------|-------|----------|-----------|
| **Logo** | Charcoal + Orange + Gray | `--logo-*` | Brand consistency |
| **Headers (H1-H3)** | Charcoal | `--logo-charcoal` | Professional hierarchy |
| **Body Text** | Charcoal | `--logo-charcoal` | Readability |
| **Links** | Systems Blue | `--accent-blue` | Contrast with orange, complements charcoal |
| **Buttons (CTA)** | Vivid Orange | `--logo-orange` | Energy, action |
| **Highlights/Quotes** | Bio Green | `--accent-green` | Natural emphasis |
| **Section BG** | Warm Earth | `--bg-warm` | Warmth, separation |
| **Code Blocks** | Cool Gray BG | `--logo-gray` | Technical content |

---

## Color Harmony Analysis

### Complementary Pairs
- **Orange ↔ Blue**: Perfect complementary (색상환 정반대) ⭐⭐⭐⭐⭐
- **Charcoal + Warm Earth**: Elegant warm neutral ⭐⭐⭐⭐
- **Cool Gray + Bio Green**: Natural softness ⭐⭐⭐⭐

### Why This Works
1. **Logo integrity preserved**: Official colors used for branding elements
2. **Visual richness**: Additional colors prevent monotony
3. **Philosophical alignment**: 3 accent colors = 3-layer depth model
4. **Professional**: Charcoal provides stable foundation
5. **Energetic**: Orange provides life and action
6. **Balanced**: Blue/Green provide calm counterpoints

---

## Don'ts

- ❌ Don't use all 6 colors on one page (overwhelming)
- ❌ Don't change logo colors (must be #282627, #EE7337, Gray)
- ❌ Don't use Warm Earth for text (low contrast)
- ❌ Don't mix Blue + Green heavily (pick one per section)

---

## Examples

### Landing Page
```
Header: Logo (Charcoal + Orange)
Hero: Warm Earth background
CTA Button: Orange
Links: Systems Blue
Quote Box: Bio Green border
```

### Topic Page
```
Header: Logo (Charcoal + Orange)
Body Text: Charcoal
Citations: Systems Blue links
Highlight: Bio Green background
```

---

*Approved during planning session 2026-02-04*
*Implements hybrid approach combining official logo guide + brand essence*
