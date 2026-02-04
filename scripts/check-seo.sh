#!/bin/bash
# check-seo.sh — 발행 후 SEO 즉시 확인 스크립트
# 사용법: ./scripts/check-seo.sh [new_page_slug]
# 예시: ./scripts/check-seo.sh en/papers/new-paper-2026

set -euo pipefail

SITE_URL="https://somaticdentistry.org"
SITEMAP_URL="$SITE_URL/sitemap.xml"
NEW_SLUG="${1:-}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=================================================="
echo "  somaticdentistry.org SEO 확인"
echo "=================================================="
echo ""

# ---------------------------------------------------
# 1. Sitemap 접근성 확인
# ---------------------------------------------------
echo "🗺️ [1/4] Sitemap 접근성..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$SITEMAP_URL" 2>/dev/null || echo "000")

if [ "$HTTP_CODE" = "200" ]; then
    echo -e "  ${GREEN}✓ sitemap.xml accessible (HTTP $HTTP_CODE)${NC}"
    
    # sitemap 다운로드
    SITEMAP_CONTENT=$(curl -s "$SITEMAP_URL" 2>/dev/null)
    URL_COUNT=$(echo "$SITEMAP_CONTENT" | grep -c "<loc>" 2>/dev/null || echo "0")
    echo "  총 URL: $URL_COUNT개"
else
    echo -e "${RED}  ✗ sitemap.xml not accessible (HTTP $HTTP_CODE)${NC}"
    echo "  사이트가 아직 배포되지 않았거나 접근 불가"
fi
echo ""

# ---------------------------------------------------
# 2. 새 페이지 포함 여부 확인
# ---------------------------------------------------
if [ -n "$NEW_SLUG" ]; then
    echo "📄 [2/4] 새 페이지 확인: $NEW_SLUG"
    
    if [ "$HTTP_CODE" = "200" ]; then
        if echo "$SITEMAP_CONTENT" | grep -q "$NEW_SLUG"; then
            echo -e "  ${GREEN}✓ 새 페이지가 sitemap에 포함됨${NC}"
        else
            echo -e "${YELLOW}  ⚠ 새 페이지가 아직 sitemap에 없음 (빌드 후 반영 필요)${NC}"
        fi
    fi
    
    # 페이지 접근성 확인
    PAGE_URL="$SITE_URL/$NEW_SLUG"
    PAGE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$PAGE_URL" 2>/dev/null || echo "000")
    if [ "$PAGE_CODE" = "200" ]; then
        echo -e "  ${GREEN}✓ 페이지 접근 가능 (HTTP $PAGE_CODE)${NC}"
    else
        echo -e "${YELLOW}  ⚠ 페이지 접근 불가 (HTTP $PAGE_CODE) — 배포 대기 중${NC}"
    fi
else
    echo "📄 [2/4] 새 페이지 확인: (슬러그 미지정 — 건너뜀)"
fi
echo ""

# ---------------------------------------------------
# 3. robots.txt 확인
# ---------------------------------------------------
echo "🤖 [3/4] robots.txt 확인..."
ROBOTS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL/robots.txt" 2>/dev/null || echo "000")
if [ "$ROBOTS_CODE" = "200" ]; then
    ROBOTS=$(curl -s "$SITE_URL/robots.txt" 2>/dev/null)
    echo -e "  ${GREEN}✓ robots.txt accessible${NC}"
    
    # Sitemap 참조 확인
    if echo "$ROBOTS" | grep -qi "sitemap"; then
        echo -e "  ${GREEN}✓ Sitemap referenced in robots.txt${NC}"
    else
        echo -e "${YELLOW}  ⚠ Sitemap not referenced in robots.txt${NC}"
    fi
else
    echo -e "${YELLOW}  ⚠ robots.txt not accessible (HTTP $ROBOTS_CODE)${NC}"
fi
echo ""

# ---------------------------------------------------
# 4. 주요 페이지 메타 태그 확인
# ---------------------------------------------------
echo "🏷️ [4/4] 메타 태그 확인..."
for lang in en ko; do
    PAGE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL/$lang/" 2>/dev/null || echo "000")
    if [ "$PAGE_CODE" = "200" ]; then
        HTML=$(curl -s "$SITE_URL/$lang/" 2>/dev/null)
        
        # title 태그 확인
        TITLE=$(echo "$HTML" | grep -oP '<title>[^<]+</title>' | head -1)
        if [ -n "$TITLE" ]; then
            echo -e "  ${GREEN}✓ /$lang/ title: $TITLE${NC}"
        else
            echo -e "${YELLOW}  ⚠ /$lang/ missing <title>${NC}"
        fi
        
        # description 메타 태그 확인
        if echo "$HTML" | grep -q 'meta.*description'; then
            echo -e "  ${GREEN}✓ /$lang/ has meta description${NC}"
        else
            echo -e "${YELLOW}  ⚠ /$lang/ missing meta description${NC}"
        fi
    else
        echo -e "${YELLOW}  ⚠ /$lang/ not accessible (HTTP $PAGE_CODE)${NC}"
    fi
done
echo ""

echo "=================================================="
echo "  SEO 확인 완료"
echo "=================================================="
echo ""
echo "💡 추가 확인:"
echo "  - Google Search Console: https://search.google.com/search-console"
echo "  - PageSpeed Insights: https://pagespeed.web.dev/"
echo "  - Rich Results Test: https://search.google.com/test/rich-results"
