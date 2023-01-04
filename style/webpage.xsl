<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:rel="http://nwalsh.com/ns/releases"
		xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:r="http://nwalsh.com/ns/git-repo-info"
                exclude-result-prefixes="atom m h db f r rel t xlink xs"
		version="2.0">

<xsl:import href="https://cdn.docbook.org/release/xsl20/current/xslt/base/html/final-pass.xsl"/>

<xsl:output name="final"
	    method="xhtml"
	    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="autolabel.elements">
  <db:appendix format="A"/>
  <db:chapter/>
</xsl:param>

<xsl:param name="docbook.css" select="'/css/website.css'"/>

<!-- ============================================================ -->

<xsl:variable name="sitemenu" select="document('../etc/menu.xml')/*"
	      as="element()"/>

<xsl:variable name="releases" select="document('../etc/releases.xml')/*"
	      as="element()"/>

<xsl:variable name="specs" select="document('../etc/specs.xml')/*"
	      as="element()"/>

<xsl:variable name="whatsnew" select="document('../atom/whatsnew.xml')/*"
	      as="element()"/>

<xsl:variable name="gitlog" select="document('../etc/git-log-summary.xml')/*"
	      as="element()"/>

<!-- ============================================================ -->

<xsl:template match="*" mode="m:css">
  <xsl:param name="node" select="."/>

  <link rel="stylesheet" type="text/css" href="/css/tabs.css" />
  <link rel="stylesheet" type="text/css" href="/css/website.css" />
  <link rel="icon" href="https://docbook.org/graphics/docbook-icon16.png"
	type="image/png"/>

  <xsl:if test="@xml:id='home'">
    <link rel="alternate" type="application/atom+xml" title="Atom"
          href="https://docbook.org/atom/whatsnew.xml" />
    <link rel="me" href="https://botsin.space/@docbook" />
  </xsl:if>
</xsl:template>

<xsl:template match="*" mode="m:head-content">
  <xsl:copy-of select="db:info/h:*"/>
</xsl:template>

<xsl:template match="db:toc">
  <ul>
    <xsl:for-each select="../db:section">
      <li>
        <a href="#{@xml:id}">
          <xsl:value-of select="db:info/db:title|db:title"/>
        </a>
      </li>
    </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="db:article[@xml:id]">
  <xsl:variable name="header" select="doc('../include/header.html')"/>
  <xsl:apply-templates select="$header" mode="to-xhtml"/>

  <xsl:variable name="off-menu-pages"
                select="('tdg5', 'tdg5p', 'tdg51')"/>

  <xsl:if test="not($sitemenu//h:li[@id = current()/@xml:id])
                and not(@xml:id = $off-menu-pages)">
    <xsl:message terminate="yes">
      <xsl:text>Error: page is not in the menu: </xsl:text>
      <xsl:value-of select="@xml:id"/>
    </xsl:message>
  </xsl:if>

  <xsl:if test="not(@xml:id = $off-menu-pages)">
    <xsl:variable name="menu" select="concat('../menus/', @xml:id, '.html')"/>
    <xsl:apply-templates select="doc($menu)" mode="to-xhtml"/>
  </xsl:if>

  <div class="{local-name(.)}">
    <!-- HACK! -->
    <xsl:if test="@xml:id='home'">
      <div class="google{@xml:id}">
        <script>
          (function() {
            var cx = '005330143887867289341:ay6bz2z7_we';
            var gcse = document.createElement('script');
            gcse.type = 'text/javascript';
            gcse.async = true;
            gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(gcse, s);
          })();
        </script>
        <div class="gcse-search"></div>
      </div>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="@xml:id = 'home'">
	<h1>Hello and welcome!</h1>
      </xsl:when>
      <xsl:otherwise>
	<h1>
	  <xsl:apply-templates select="db:info/db:title" mode="titlepage"/>
	</h1>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates/>

    <xsl:call-template name="t:process-footnotes"/>

    <footer>
      <xsl:variable name="gitfn" select="substring-after(base-uri(/), $gitlog/@root)"/>
      <xsl:variable name="commit" select="($gitlog/r:commit[r:file = $gitfn])[1]"/>
      <xsl:variable name="cdate" select="$commit/r:date"/>
      <xsl:variable name="committer" select="substring-before($commit/r:committer, ' &lt;')"/>

      <xsl:if test="exists($cdate)">
        <xsl:variable name="date" select="$cdate cast as xs:dateTime"/>
        <xsl:text>Last updated on </xsl:text>
        <xsl:value-of select="format-dateTime($date, '[D01] [MNn,*-3] [Y0001]')"/>
        <xsl:text> at </xsl:text>
        <xsl:value-of select="format-dateTime($date, '[h01]:[m01][P] [z]')"/>
        <xsl:text> by </xsl:text>
        <xsl:value-of select="$committer"/>
      </xsl:if>
    </footer>
  </div>
</xsl:template>

<xsl:template name="releases">
  <xsl:param name="dirs" required="yes" as="element()+"/>
  <xsl:param name="version"/>
  <xsl:param name="archive" select="0"/>

  <h3>Current releases</h3>

  <xsl:choose>
    <xsl:when test="$dirs[@kind='std']">
      <xsl:call-template name="release-list">
        <xsl:with-param name="dirs" select="$dirs[@kind='std']"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>There are no current releases.</xsl:text>
    </xsl:otherwise>
  </xsl:choose>

  <h3>Candidate releases</h3>

  <xsl:choose>
    <xsl:when test="$dirs[@kind='cr']">
      <xsl:call-template name="release-list">
        <xsl:with-param name="dirs" select="$dirs[@kind='cr']"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>There are no current candidate releases.</xsl:text>
    </xsl:otherwise>
  </xsl:choose>

  <h3>Beta releases</h3>

  <xsl:choose>
    <xsl:when test="$dirs[@kind='beta']">
      <xsl:call-template name="release-list">
        <xsl:with-param name="dirs" select="$dirs[@kind='beta']"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>There are no current beta releases.</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="release-list">
  <xsl:param name="dirs" required="yes" as="element()+"/>

  <xsl:choose>
    <xsl:when test="count(distinct-values($dirs/@type)) = 1">
      <xsl:call-template name="release-list-ul">
        <xsl:with-param name="dirs" select="$dirs"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:otherwise>
      <dl>
        <xsl:for-each select="distinct-values($dirs/@type)">
          <xsl:variable name="type" select="."/>
          <dt>
            <xsl:choose>
              <xsl:when test="$type='rng'">RELAX NG</xsl:when>
              <xsl:when test="$type='sgml'">SGML</xsl:when>
              <xsl:when test="$type='xml'">XML</xsl:when>
              <xsl:when test="$type='xsd'">XSD</xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$type"/>
                <xsl:text>???</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </dt>
          <dd>
            <xsl:call-template name="release-list-ul">
              <xsl:with-param name="dirs" select="$dirs[@type=$type]"/>
            </xsl:call-template>
          </dd>
        </xsl:for-each>
      </dl>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="release-list-ul">
  <xsl:param name="dirs" required="yes" as="element()+"/>

  <ul>
    <xsl:for-each select="$dirs">
      <xsl:sort select="@version" order="descending"/>
      <li>
        <a href="/{@path}">
          <xsl:value-of select="@version"/>
        </a>
        <xsl:if test="@date">
          <xsl:text>, </xsl:text>
          <xsl:value-of select='format-dateTime(xs:dateTime(@date[1]),
                                "[D01] [MNn,*-3] [Y0001]")'/>
        </xsl:if>

        <!-- FIXME: this doesn't work right
        <xsl:variable name="version" select="@version"/>
        <xsl:variable name="spec" select="$specs/rel:spec[@release=$version]"/>

        <xsl:if test="$spec">
          <xsl:text> [</xsl:text>
          <a href="/specs/{$spec}">Specification</a>
          <xsl:text>]</xsl:text>
        </xsl:if>
        -->

        <xsl:if test="@custom">
          <xsl:text> (a customization of </xsl:text>
          <xsl:value-of select="@custom"/>
          <xsl:text>)</xsl:text>
        </xsl:if>
      </li>
    </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="processing-instruction('schemas')">
  <xsl:variable name="release" select="string(f:pi(., 'release'))"/>
  <xsl:variable name="module" select="string(f:pi(., 'module'))"/>
  <xsl:variable name="version" select="string(f:pi(., 'version'))"/>

  <xsl:variable name="reldirs" select="$releases//rel:dir"/>

<!--
  <xsl:message>dirs: <xsl:value-of select='count($reldirs)'/></xsl:message>
-->

  <xsl:variable name="rels"
		select="if ($release = '')
                        then $reldirs
			else $reldirs[matches(@release, $release)]"/>

<!--
  <xsl:message>
    <xsl:value-of select="$release"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$module"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$version"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="count($rels)"/>
  </xsl:message>
-->

  <xsl:variable name="dirs"
		select="if ($module = '')
                        then $rels[string(@module) = '']
			else $rels[matches(@module, $module)]"/>

<!--
  <xsl:message>
    <xsl:value-of select="$module"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="count($dirs)"/>
  </xsl:message>
-->

  <xsl:call-template name="releases">
    <xsl:with-param name="version" select="$version"/>
    <xsl:with-param name="dirs" select="$dirs" as="element()+"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="processing-instruction('docbook-archives')">
  <xsl:variable name="reldirs"
		select="$releases//rel:dir[starts-with(@release,'1')
			                   and not(@module)]
			|$releases//rel:dir[starts-with(@release,'2')
			                   and not(@module)]
			|$releases//rel:dir[starts-with(@release,'3')
			                   and not(@module)]"/>

  <xsl:call-template name="releases">
    <xsl:with-param name="archive" select="1"/>
    <xsl:with-param name="dirs" select="$reldirs" as="element()+"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="processing-instruction('whatsnew')">
  <h2>
    <xsl:text>What's New</xsl:text>
    <span class="subscribe">
      <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
      <a href="/atom/whatsnew.xml">
	<img src="/graphics/feed-icon.gif" alt="[Atom Feed]" border="0"/>
      </a>
      <xsl:text>&#160;</xsl:text>
      <a href="/atom/whatsnew.xml">
	<xsl:text>Subscribe!</xsl:text>
      </a>
    </span>
  </h2>

  <dl>
    <xsl:apply-templates select="$whatsnew/atom:entry"/>
  </dl>
</xsl:template>

<xsl:template match="atom:entry">
  <xsl:variable
      name="uri"
      select="atom:link[@rel='alternate' and @type='text/html']/@href"/>

  <dt>
    <a>
      <xsl:choose>
	<xsl:when test="starts-with($uri, 'http://docbook.org/')">
	  <xsl:attribute name="href"
			 select="substring-after($uri, 'http://docbook.org')"/>
	</xsl:when>
	<xsl:when test="starts-with($uri, 'https://docbook.org/')">
	  <xsl:attribute name="href"
			 select="substring-after($uri, 'https://docbook.org')"/>
	</xsl:when>
	<xsl:when test="$uri != ''">
	  <xsl:attribute name="href" select="$uri"/>
	</xsl:when>
      </xsl:choose>
      <xsl:value-of select="atom:title"/>
    </a>
    <xsl:text> (</xsl:text>
    <xsl:value-of select='format-dateTime(xs:dateTime(atom:updated),
			                  "[D01] [MNn,*-3] [Y0001]")'/>
    <xsl:text>)</xsl:text>
  </dt>
  <dd>
    <xsl:copy-of select="atom:summary[@type='xhtml']/*"/>
  </dd>
</xsl:template>

<xsl:template match="processing-instruction('sitemap')">
  <xsl:copy-of select="$sitemenu"/>
</xsl:template>

<xsl:template match="processing-instruction('br')">
  <br>
    <xsl:if test="contains(.,'clear=')">
      <xsl:attribute name="clear" select="substring-after(., 'clear=')"/>
    </xsl:if>
  </br>
</xsl:template>

<xsl:template match="processing-instruction('releasemap')">
  <ul>
    <xsl:for-each select="$releases/rel:dir">
      <li>
	<a href="{@path}">
	  <xsl:value-of select="@path"/>
	</a>
	<ul>
	  <xsl:for-each select="rel:dir">
	    <xsl:sort select="@dir" order="descending"/>
	    <li>
	      <a href="{@path}">
		<xsl:value-of select="@dir"/>
	      </a>
	    </li>
	  </xsl:for-each>
	</ul>
      </li>
    </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="processing-instruction('google-search-results')">
  <div id="results_008085259838719972531:tqmky0g0tbo"></div>
  <script type="text/javascript">
    var googleSearchIframeName = "results_008085259838719972531:tqmky0g0tbo";
    var googleSearchFormName = "searchbox_008085259838719972531:tqmky0g0tbo";
    var googleSearchFrameWidth = 600;
    var googleSearchFrameborder = 0;
    var googleSearchDomain = "www.google.com";
    var googleSearchPath = "/cse";
  </script>
  <script type="text/javascript"
	  src="https://www.google.com/afsonline/show_afs_search.js">
  </script>
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
