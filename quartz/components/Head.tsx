import { i18n } from "../i18n"
import { FullSlug, getFileExtension, joinSegments, pathToRoot } from "../util/path"
import { CSSResourceToStyleElement, JSResourceToScriptElement } from "../util/resources"
import { googleFontHref, googleFontSubsetHref } from "../util/theme"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { unescapeHTML } from "../util/escape"
import { CustomOgImagesEmitterName } from "../plugins/emitters/ogImage"

// Schema.org JSON-LD structured data generators
function buildWebSiteSchema(baseUrl: string, siteTitle: string) {
  return {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: siteTitle,
    url: `https://${baseUrl}`,
    description:
      "Systems-based approach exploring the connection between oral health, brain function, and whole-body wellness through peer-reviewed research.",
    inLanguage: ["en", "ko"],
    publisher: {
      "@type": "Organization",
      name: "Somatic Dentistry",
      url: `https://${baseUrl}`,
      logo: {
        "@type": "ImageObject",
        url: `https://${baseUrl}/static/icon.png`,
      },
      founder: {
        "@type": "Person",
        name: "KyungA Oh",
        jobTitle: "Founder, Somatic Dentistry",
        url: `https://${baseUrl}/en/about`,
      },
    },
  }
}

function buildArticleSchema(
  baseUrl: string,
  slug: string,
  title: string,
  description: string,
  tags: string[],
  dates?: { created?: Date; modified?: Date; published?: Date },
  ogImageUrl?: string,
) {
  const isScholarly = tags.some((t) =>
    ["논문", "메타분석", "리뷰", "주요연구", "research", "paper"].includes(t),
  )
  const pageUrl = `https://${baseUrl}/${slug}`
  const schema: Record<string, unknown> = {
    "@context": "https://schema.org",
    "@type": isScholarly ? "ScholarlyArticle" : "Article",
    headline: title,
    description: description,
    url: pageUrl,
    mainEntityOfPage: { "@type": "WebPage", "@id": pageUrl },
    author: {
      "@type": "Person",
      name: "KyungA Oh",
      url: `https://${baseUrl}/en/about`,
    },
    publisher: {
      "@type": "Organization",
      name: "Somatic Dentistry",
      url: `https://${baseUrl}`,
      logo: {
        "@type": "ImageObject",
        url: `https://${baseUrl}/static/icon.png`,
      },
    },
    inLanguage: slug.startsWith("ko/") ? "ko" : "en",
  }

  if (ogImageUrl) {
    schema.image = ogImageUrl
  }

  // Date handling
  const created = dates?.created ?? dates?.published
  const modified = dates?.modified
  if (created) {
    schema.datePublished = created.toISOString()
  }
  if (modified) {
    schema.dateModified = modified.toISOString()
  }

  // Keywords from tags
  if (tags.length > 0) {
    schema.keywords = tags.join(", ")
  }

  // Scholarly-specific fields
  if (isScholarly) {
    schema.about = [
      { "@type": "Thing", name: "Somatic Dentistry" },
      { "@type": "Thing", name: "DentoNeural Connection" },
    ]
  }

  return schema
}

function buildBreadcrumbSchema(baseUrl: string, slug: string, title: string) {
  const parts = slug.split("/").filter(Boolean)
  if (parts.length <= 1) return null

  const items = parts.map((part, idx) => ({
    "@type": "ListItem" as const,
    position: idx + 1,
    name: idx === parts.length - 1 ? title : part.charAt(0).toUpperCase() + part.slice(1),
    item: `https://${baseUrl}/${parts.slice(0, idx + 1).join("/")}`,
  }))

  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items,
  }
}

export default (() => {
  const Head: QuartzComponent = ({
    cfg,
    fileData,
    externalResources,
    ctx,
  }: QuartzComponentProps) => {
    const titleSuffix = cfg.pageTitleSuffix ?? ""
    const title =
      (fileData.frontmatter?.title ?? i18n(cfg.locale).propertyDefaults.title) + titleSuffix
    const description =
      fileData.frontmatter?.socialDescription ??
      fileData.frontmatter?.description ??
      unescapeHTML(fileData.description?.trim() ?? i18n(cfg.locale).propertyDefaults.description)

    const { css, js, additionalHead } = externalResources

    const url = new URL(`https://${cfg.baseUrl ?? "example.com"}`)
    const path = url.pathname as FullSlug
    const baseDir = fileData.slug === "404" ? path : pathToRoot(fileData.slug!)
    const iconPath = joinSegments(baseDir, "static/icon.png")

    // Url of current page
    const socialUrl =
      fileData.slug === "404" ? url.toString() : joinSegments(url.toString(), fileData.slug!)

    const usesCustomOgImage = ctx.cfg.plugins.emitters.some(
      (e) => e.name === CustomOgImagesEmitterName,
    )
    const ogImageDefaultPath = `https://${cfg.baseUrl}/static/og-image.png`

    return (
      <head>
        <title>{title}</title>
        <meta charSet="utf-8" />
        {cfg.theme.cdnCaching && cfg.theme.fontOrigin === "googleFonts" && (
          <>
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" />
            <link rel="stylesheet" href={googleFontHref(cfg.theme)} />
            {cfg.theme.typography.title && (
              <link rel="stylesheet" href={googleFontSubsetHref(cfg.theme, cfg.pageTitle)} />
            )}
          </>
        )}
        <link rel="preconnect" href="https://cdnjs.cloudflare.com" crossOrigin="anonymous" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <meta name="og:site_name" content={cfg.pageTitle}></meta>
        <meta property="og:title" content={title} />
        <meta property="og:type" content="website" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content={title} />
        <meta name="twitter:description" content={description} />
        <meta property="og:description" content={description} />
        <meta property="og:image:alt" content={description} />

        {!usesCustomOgImage && (
          <>
            <meta property="og:image" content={ogImageDefaultPath} />
            <meta property="og:image:url" content={ogImageDefaultPath} />
            <meta name="twitter:image" content={ogImageDefaultPath} />
            <meta
              property="og:image:type"
              content={`image/${getFileExtension(ogImageDefaultPath) ?? "png"}`}
            />
          </>
        )}

        {cfg.baseUrl && (
          <>
            <meta property="twitter:domain" content={cfg.baseUrl}></meta>
            <meta property="og:url" content={socialUrl}></meta>
            <meta property="twitter:url" content={socialUrl}></meta>
          </>
        )}

        <link rel="icon" href={iconPath} />
        <meta name="description" content={description} />
        <meta name="generator" content="Quartz" />
        <meta name="google-site-verification" content="Y4i9TcyEns9QzZw-9ngAFuSDUJPhLS38ZxayLwAZrAk" />

        {css.map((resource) => CSSResourceToStyleElement(resource, true))}
        {js
          .filter((resource) => resource.loadTime === "beforeDOMReady")
          .map((res) => JSResourceToScriptElement(res, true))}
        {additionalHead.map((resource) => {
          if (typeof resource === "function") {
            return resource(fileData)
          } else {
            return resource
          }
        })}

        {/* Schema.org JSON-LD Structured Data */}
        {cfg.baseUrl && (
          <script
            type="application/ld+json"
            dangerouslySetInnerHTML={{
              __html: JSON.stringify(buildWebSiteSchema(cfg.baseUrl, cfg.pageTitle)),
            }}
          />
        )}
        {cfg.baseUrl && fileData.slug && fileData.slug !== "index" && fileData.slug !== "404" && (
          <script
            type="application/ld+json"
            dangerouslySetInnerHTML={{
              __html: JSON.stringify(
                buildArticleSchema(
                  cfg.baseUrl,
                  fileData.slug,
                  fileData.frontmatter?.title ?? title,
                  description,
                  (fileData.frontmatter?.tags as string[]) ?? [],
                  fileData.dates,
                  usesCustomOgImage ? undefined : ogImageDefaultPath,
                ),
              ),
            }}
          />
        )}
        {cfg.baseUrl &&
          fileData.slug &&
          (() => {
            const breadcrumb = buildBreadcrumbSchema(
              cfg.baseUrl!,
              fileData.slug!,
              fileData.frontmatter?.title ?? title,
            )
            return breadcrumb ? (
              <script
                type="application/ld+json"
                dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumb) }}
              />
            ) : null
          })()}
      </head>
    )
  }

  return Head
}) satisfies QuartzComponentConstructor
