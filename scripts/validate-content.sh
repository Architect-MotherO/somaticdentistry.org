#!/bin/bash
# validate-content.sh — 발행 전 자동 검증 스크립트
# 사용법: ./scripts/validate-content.sh [content_dir]
#
# 검사 항목:
# 1. 깨진 내부 링크 ([[path|text]] 형식)
# 2. Citation 누락 (본문의 [@citekey]가 references.bib에 있는지)
# 3. Frontmatter 필수 필드 확인

set -euo pipefail

CONTENT_DIR="${1:-$(dirname "$0")/../content}"
CONTENT_DIR="$(cd "$CONTENT_DIR" && pwd)"
BIB_FILE="$CONTENT_DIR/references.bib"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo "=================================================="
echo "  somaticdentistry.org Content Validator"
echo "=================================================="
echo "Content dir: $CONTENT_DIR"
echo "Bib file:    $BIB_FILE"
echo ""

# ---------------------------------------------------
# 1. Citation 누락 검사
# ---------------------------------------------------
echo "📖 [1/3] Citation 검사..."

if [ ! -f "$BIB_FILE" ]; then
    echo -e "${RED}  ✗ references.bib not found at $BIB_FILE${NC}"
    ERRORS=$((ERRORS + 1))
else
    # references.bib에서 모든 citekey 추출
    BIB_KEYS=$(grep "^@" "$BIB_FILE" | sed 's/@[a-zA-Z]*{//' | sed 's/,$//' | sort)
    BIB_COUNT=$(echo "$BIB_KEYS" | wc -l | tr -d ' ')
    echo "  references.bib: $BIB_COUNT entries"

    # 모든 md 파일에서 [@citekey] 추출
    CITED_KEYS=$(grep -roh '\[@[a-zA-Z0-9_-]*\]' "$CONTENT_DIR" --include='*.md' 2>/dev/null | \
        sed 's/\[@//' | sed 's/\]//' | sort -u)

    if [ -n "$CITED_KEYS" ]; then
        MISSING_COUNT=0
        while IFS= read -r key; do
            if ! echo "$BIB_KEYS" | grep -q "^${key}$"; then
                echo -e "${RED}  ✗ Missing in bib: [@${key}]${NC}"
                # 어떤 파일에서 사용되는지 표시
                grep -rn "\[@${key}\]" "$CONTENT_DIR" --include='*.md' | while read -r line; do
                    echo "    → $line"
                done
                MISSING_COUNT=$((MISSING_COUNT + 1))
                ERRORS=$((ERRORS + 1))
            fi
        done <<< "$CITED_KEYS"

        TOTAL_CITED=$(echo "$CITED_KEYS" | wc -l | tr -d ' ')
        VALID=$((TOTAL_CITED - MISSING_COUNT))
        echo -e "  ${GREEN}✓ $VALID/$TOTAL_CITED citations validated${NC}"
    else
        echo "  No citations found in content files"
    fi
fi
echo ""

# ---------------------------------------------------
# 2. 내부 링크 검사
# ---------------------------------------------------
echo "🔗 [2/3] 내부 링크 검사..."

BROKEN_LINKS=0
# [[path|text]] 또는 [[path]] 형식의 링크 추출
find "$CONTENT_DIR" -name '*.md' -type f | while read -r mdfile; do
    # wikilinks 추출: [[path|text]] → path 부분만
    grep -oP '\[\[([^\]|]+)' "$mdfile" 2>/dev/null | sed 's/\[\[//' | while read -r link; do
        # 외부 링크(http) 건너뛰기
        if [[ "$link" == http* ]]; then continue; fi

        # 앵커(#) 제거
        link_path="${link%%#*}"
        if [ -z "$link_path" ]; then continue; fi

        # 상대 경로 → 절대 경로
        dir=$(dirname "$mdfile")

        # .md 확장자 추가 (없으면)
        if [[ "$link_path" != *.md ]]; then
            target_md="$link_path.md"
        else
            target_md="$link_path"
        fi

        # content 디렉토리 기준으로 탐색
        found=0
        # 1) 같은 디렉토리에서 탐색
        if [ -f "$dir/$target_md" ]; then found=1; fi
        # 2) content 루트에서 탐색
        if [ -f "$CONTENT_DIR/$target_md" ]; then found=1; fi
        # 3) en/ 또는 ko/ 접두사 추가
        if [ -f "$CONTENT_DIR/en/$target_md" ]; then found=1; fi
        if [ -f "$CONTENT_DIR/ko/$target_md" ]; then found=1; fi

        if [ "$found" -eq 0 ]; then
            relfile="${mdfile#$CONTENT_DIR/}"
            echo -e "${YELLOW}  ⚠ Broken link in $relfile: [[$link]]${NC}"
            BROKEN_LINKS=$((BROKEN_LINKS + 1))
        fi
    done
done

if [ "$BROKEN_LINKS" -eq 0 ]; then
    echo -e "  ${GREEN}✓ No broken internal links found${NC}"
fi
echo ""

# ---------------------------------------------------
# 3. Frontmatter 필수 필드 검사
# ---------------------------------------------------
echo "📝 [3/3] Frontmatter 검사..."

FM_ISSUES=0
find "$CONTENT_DIR" -name '*.md' -path '*/papers/*' -o -name '*.md' -path '*/topics/*' | while read -r mdfile; do
    relfile="${mdfile#$CONTENT_DIR/}"

    # title 필드 확인
    if ! head -20 "$mdfile" | grep -q "^title:"; then
        echo -e "${RED}  ✗ Missing 'title' in $relfile${NC}"
        FM_ISSUES=$((FM_ISSUES + 1))
        ERRORS=$((ERRORS + 1))
    fi

    # description 필드 확인
    if ! head -20 "$mdfile" | grep -q "^description:"; then
        echo -e "${YELLOW}  ⚠ Missing 'description' in $relfile${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi

    # tags 필드 확인
    if ! head -20 "$mdfile" | grep -q "^tags:"; then
        echo -e "${YELLOW}  ⚠ Missing 'tags' in $relfile${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
done

echo ""

# ---------------------------------------------------
# 결과 요약
# ---------------------------------------------------
echo "=================================================="
echo "  검증 결과 요약"
echo "=================================================="

TOTAL_MD=$(find "$CONTENT_DIR" -name '*.md' -type f | wc -l | tr -d ' ')
PAPER_COUNT=$(find "$CONTENT_DIR" -name '*.md' -path '*/papers/*' | wc -l | tr -d ' ')
TOPIC_COUNT=$(find "$CONTENT_DIR" -name '*.md' -path '*/topics/*' | wc -l | tr -d ' ')

echo "  총 파일: $TOTAL_MD개 (papers: $PAPER_COUNT, topics: $TOPIC_COUNT)"

if [ "$ERRORS" -gt 0 ]; then
    echo -e "  ${RED}✗ 오류: $ERRORS개${NC}"
else
    echo -e "  ${GREEN}✓ 오류 없음${NC}"
fi

if [ "$WARNINGS" -gt 0 ]; then
    echo -e "  ${YELLOW}⚠ 경고: $WARNINGS개${NC}"
fi

echo ""
exit $ERRORS
