#!/bin/bash
# somaticdentistry.org 포스팅 발행 스크립트
# 사용법: ./scripts/publish.sh [commit message]
# 경아 (OpenClaw)가 content/ 에 파일 생성 후 이 스크립트로 발행

set -e
cd "$(dirname "$0")/.."

MSG="${1:-새 포스트 추가}"

# 변경사항 확인
if git diff --quiet && git diff --staged --quiet; then
    echo "변경사항 없음. 발행할 것이 없습니다."
    exit 0
fi

# 변경된 파일 목록
echo "📝 변경된 파일:"
git status --short

# 커밋 & 푸시
git add -A content/
git commit -m "$MSG"
git push origin v4

echo "✅ 발행 완료! GitHub Actions가 자동 빌드합니다."
echo "🌐 https://somaticdentistry.org 에서 확인하세요."
