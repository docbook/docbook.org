<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:rel="http://nwalsh.com/ns/releases"
                xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="h db f rel t xlink xs"
                version="2.0">

<xsl:output method="html"
            doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
            doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:variable name="menu" select="document('../menus/tools.html')/div"/>

<xsl:variable name="specs" select="document('../etc/specs.xml')/*"
              as="element()"/>

<xsl:template match="/">
  <xsl:apply-templates select="/rel:releases/rel:dir[@dir!='release']"/>
  <xsl:apply-templates select="/rel:releases/rel:dir[@dir='release']" mode="releases"/>
</xsl:template>

<xsl:template match="rel:dir">
  <xsl:variable name="basedir"
                select="resolve-uri(concat('../', @path), base-uri(.))"/>
  <xsl:variable name="index.html" select="concat($basedir,'/index.html')"/>

  <xsl:variable name="title">
    <xsl:if test="@module = 'simple' or @dir = 'simple'
                  or contains(@path,'/simple/')">
      <xsl:text>Simplified </xsl:text>
    </xsl:if>

    <xsl:text>DocBook</xsl:text>

    <xsl:if test="@module = 'website'">
      <xsl:text> Website</xsl:text>
    </xsl:if>

    <xsl:if test="@module = 'publishers' or @dir = 'publishers'
                  or contains(@path,'/publishers/')">
      <xsl:text> Publishers</xsl:text>
    </xsl:if>

    <xsl:if test="contains(@path,'docbook-ng')">
      <xsl:text> NG</xsl:text>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="@module = 'mathml'"> MathML module </xsl:when>
      <xsl:when test="@module = 'svg'">  SVG module </xsl:when>
      <xsl:when test="@module = 'ebnf'">  EBNF module </xsl:when>
      <xsl:when test="@module = 'htmlforms'">  HTML forms module </xsl:when>
      <xsl:when test="@module = 'publishers'"> </xsl:when>
    </xsl:choose>

    <xsl:if test="@release">
      <xsl:text> V</xsl:text>
      <xsl:value-of select="@release"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="@module='publishers'">
        <!-- nop -->
      </xsl:when>

      <xsl:when test="@type = 'xml'"> XML DTD</xsl:when>
      <xsl:when test="@type = 'dtd'"> XML DTD</xsl:when>
      <xsl:when test="@type = 'sgml'"> SGML DTD</xsl:when>
      <xsl:when test="@type = 'rng'"> RELAX NG</xsl:when>
      <xsl:when test="@type = 'xsd'"> W3C XML Schema</xsl:when>
      <xsl:when test="@type = 'sch'"> Schematron Rules</xsl:when>
      <xsl:when test="@dir = 'tools'">
        <xsl:text> Tools</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'xml'">
        <xsl:text> Releases</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'ent'">
        <xsl:text> ISO character entities</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'mathml'">
        <xsl:text> MathML modules</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'publishers'">
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'simple'">
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'slides'">
        <xsl:text> Slides</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'website'">
        <xsl:text> Website</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'svg'">
        <xsl:text> SVG modules</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'htmlforms'">
        <xsl:text> HTML forms modules</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'ebnf'">
        <xsl:text> EBNF modules</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'dbrdfalite'">
        <xsl:text> RDFa Lite</xsl:text>
      </xsl:when>

      <xsl:when test="@dir = 'absinthe'">
        <xsl:text> “Absinthe”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'bourbon'">
        <xsl:text> “Bourbon”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'cachaca'">
        <xsl:text> “Cachaça”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'drambuie'">
        <xsl:text> “Drambuie”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'eaux-de-vie'">
        <xsl:text> “Eaux-de-vie”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'frangelico'">
        <xsl:text> “Frangelico”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'gin'">
        <xsl:text> “Gin”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'hardcider'">
        <xsl:text> “Hard Cider”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'ipa'">
        <xsl:text> “IPA”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'jagermeister'">
        <xsl:text> “Jägermeister”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'kahlua'">
        <xsl:text> “Kahlúa”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'lillet'">
        <xsl:text> “Lillet”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'mezcal'">
        <xsl:text> “Mezcal”</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'pto'">
        <xsl:text> “PTO”</xsl:text>
      </xsl:when>

      <xsl:when test="@dir = 'rng'">
        <xsl:text> RELAX NG</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'sgml'">
        <xsl:text> SGML</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'xsd'">
        <xsl:text> W3C XML Schema</xsl:text>
      </xsl:when>
      <xsl:when test="@dir = 'docbook-ng'">
        <xsl:text></xsl:text>
      </xsl:when>

      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Unknown type: </xsl:text>
          <xsl:value-of select="@type"/>
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@path"/>
          <xsl:text>)</xsl:text>
        </xsl:message>
        <xsl:text> ???</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:result-document href="{$index.html}">
    <html>
      <head>
        <title>DocBook Release</title>
        <meta charset="utf-8"/>
        <link rel="stylesheet" type="text/css" href="/css/tabs.css" />
        <link rel="stylesheet" type="text/css" href="/css/docbook.css" />
        <link rel="stylesheet" type="text/css" href="/css/website.css" />
        <link rel="icon" href="http://docbook.org/graphics/docbook-icon16.png"
              type="image/png"/>
      </head>
      <body class="listing">
        <xsl:variable name="header" select="doc('../include/header.html')"/>
        <xsl:apply-templates select="$header" mode="to-xhtml"/>

        <xsl:apply-templates select="$menu" mode="patchMenu">
          <xsl:with-param name="title" select="$title"/>
        </xsl:apply-templates>

        <div class="article">
          <h1>
            <xsl:value-of select="$title"/>
          </h1>

          <xsl:variable name="specid">
            <xsl:if test="@module">
              <xsl:value-of select="@module"/>
              <xsl:text>-</xsl:text>
            </xsl:if>
            <xsl:value-of select="@release"/>
          </xsl:variable>

          <xsl:variable name="spec" select="$specs/rel:spec[@release=$specid]"/>

          <xsl:if test="$spec">
            <p>
              <xsl:text>There is a </xsl:text>
              <a href="/specs/{$spec}">specification</a>
              <xsl:text> for this release.</xsl:text>
            </p>
          </xsl:if>

          <ul>
            <xsl:if test="../rel:dir">
              <li><a href="..">Parent Directory</a></li>
            </xsl:if>
            <xsl:for-each select="rel:file">
              <xsl:sort select="."/>
              <li>
                <a href="{.}"><xsl:value-of select="."/></a>
              </li>
            </xsl:for-each>
            <xsl:for-each select="rel:dir">
              <xsl:sort select="@dir"/>
              <li>
                <a href="{@dir}"><xsl:value-of select="@dir"/>/</a>
              </li>
            </xsl:for-each>
          </ul>
        </div>
      </body>
    </html>
  </xsl:result-document>

  <xsl:apply-templates select="rel:dir"/>
</xsl:template>

<xsl:template match="rel:dir" mode="releases">
  <xsl:variable name="basedir"
                select="resolve-uri(concat('../', @path), base-uri(.))"/>
  <xsl:variable name="index.html" select="concat($basedir,'/index.html')"/>

  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="@dir = 'release'">
        <xsl:text>DocBook Stylesheet Releases</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('DocBook XSLT Stylesheets V', @dir)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:result-document href="{$index.html}">
    <html>
      <head>
        <title>DocBook Stylesheet Releases</title>
        <meta charset="utf-8"/>
        <link rel="stylesheet" type="text/css" href="/css/tabs.css" />
        <link rel="stylesheet" type="text/css" href="/css/docbook.css" />
        <link rel="stylesheet" type="text/css" href="/css/website.css" />
        <link rel="icon" href="http://docbook.org/graphics/docbook-icon16.png"
              type="image/png"/>
      </head>
      <body class="listing">
        <xsl:variable name="header" select="doc('../include/header.html')"/>
        <xsl:apply-templates select="$header" mode="to-xhtml"/>

        <xsl:apply-templates select="$menu" mode="patchMenu">
          <xsl:with-param name="title" select="$title"/>
        </xsl:apply-templates>

        <div class="article">
          <h1>
            <xsl:value-of select="$title"/>
          </h1>

          <ul>
            <xsl:if test="../rel:dir">
              <li><a href="..">Parent Directory</a></li>
            </xsl:if>
            <xsl:for-each select="rel:file">
              <xsl:sort select="."/>
              <li>
                <a href="{.}"><xsl:value-of select="."/></a>
              </li>
            </xsl:for-each>
            <xsl:for-each select="rel:dir">
              <xsl:sort select="f:sort-key(@dir)" order="descending"/>
              <li>
                <a href="{@dir}"><xsl:value-of select="@dir"/>/</a>
              </li>
            </xsl:for-each>
          </ul>
        </div>
      </body>
    </html>
  </xsl:result-document>

  <xsl:apply-templates select="rel:dir" mode="releases"/>
</xsl:template>

<xsl:function name="f:sort-key" as="xs:string">
  <xsl:param name="key"/>

  <xsl:variable name="value" as="xs:string">
    <xsl:choose>
      <xsl:when test="contains($key,'.')">
        <xsl:variable name="parts" as="xs:string+">
          <xsl:for-each select="tokenize($key, '\.')">
            <xsl:value-of select="if (. castable as xs:integer)
                                  then format-number(. cast as xs:integer, '0000')
                                  else ."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="string-join($parts, '')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$key"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$value"/>
</xsl:function>

<!-- ============================================================ -->

<xsl:template match="li[contains(@class,'first')]" mode="patchMenu" priority="10">
  <xsl:param name="title"/>
  <li>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="class" select="'first'"/>
    <xsl:apply-templates mode="patchMenu">
      <xsl:with-param name="title" select="$title"/>
    </xsl:apply-templates>
  </li>
</xsl:template>

<xsl:template match="li[contains(@class,'last')]" mode="patchMenu">
  <xsl:param name="title"/>
  <li>
    <xsl:copy-of select="@*[not(name(.) = 'class')]"/>
    <xsl:apply-templates mode="patchMenu">
      <xsl:with-param name="title" select="$title"/>
    </xsl:apply-templates>
  </li>
  <li id="dirlist" class="on last">
    <a href="#">
      <xsl:value-of select="$title"/>
    </a>
  </li>
</xsl:template>

<xsl:template match="*" mode="patchMenu">
  <xsl:param name="title"/>
  <xsl:element name="{local-name(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates mode="patchMenu">
      <xsl:with-param name="title" select="$title"/>
    </xsl:apply-templates>
  </xsl:element>
</xsl:template>

<xsl:template match="element()" mode="to-xhtml">
  <xsl:element name="{local-name(.)}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates select="@*,node()" mode="to-xhtml"/>
  </xsl:element>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()" mode="to-xhtml">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
