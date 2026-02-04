import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Somatic Dentistry",
    pageTitleSuffix: " | The DentoNeural Connection",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "en-US",
    baseUrl: "somaticdentistry.org",
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Schibsted Grotesk",
        body: "Source Sans Pro",
        code: "IBM Plex Mono",
      },
      colors: {
        // Hybrid Brand Color System - Somatic Dentistry
        // Official Logo: Charcoal #282627, Orange #EE7337, Gray #D9D9D9
        // Brand Essence: Blue #2E5984, Green #4A7C59, Warm #E8B4A0
        lightMode: {
          light: "#faf8f8",           // Background (warm white)
          lightgray: "#D9D9D9",       // Logo Gray (borders, dividers)
          gray: "#b8b8b8",            // Graph links
          darkgray: "#282627",        // Logo Charcoal (body text)
          dark: "#282627",            // Logo Charcoal (headers)
          secondary: "#2E5984",       // Systems Blue (links)
          tertiary: "#4A7C59",        // Bio Green (hover, highlights)
          highlight: "rgba(232, 180, 160, 0.15)",  // Warm Earth (link bg)
          textHighlight: "#EE733788", // Logo Orange (text highlight)
        },
        darkMode: {
          light: "#1a1918",           // Dark warm background
          lightgray: "#3d3a39",       // Muted gray
          gray: "#646464",            // Graph links
          darkgray: "#e8e6e5",        // Light text
          dark: "#f5f3f2",            // Headers (light)
          secondary: "#5a8ab8",       // Systems Blue (lighter)
          tertiary: "#6b9e7d",        // Bio Green (lighter)
          highlight: "rgba(232, 180, 160, 0.12)",  // Warm Earth
          textHighlight: "#EE733766", // Logo Orange (muted)
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
      Plugin.Citations({
        bibliographyFile: "content/references.bib",
        linkCitations: true,
      }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      // Comment out CustomOgImages to speed up build time
      Plugin.CustomOgImages(),
    ],
  },
}

export default config
