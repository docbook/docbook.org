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

<xsl:output method="html" omit-xml-declaration="yes"/>

<!-- DO NOT OUTPUT XHTML! -->

<xsl:template match="/">
  <!--
  <xsl:call-template name="t:menu">
    <xsl:with-param name="id" select="'home'"/>
  </xsl:call-template>
  -->

  <xsl:for-each select="//h:li[@id]">
    <xsl:variable name="menu" select="concat('../menus/',@id,'.html')"/>
    <xsl:result-document href="{resolve-uri($menu, base-uri(.))}">
      <xsl:call-template name="t:menu">
	<xsl:with-param name="id" select="@id"/>
      </xsl:call-template>
    </xsl:result-document>
  </xsl:for-each>

  <doc>Finished</doc>
</xsl:template>

<xsl:template name="t:menu">
  <xsl:param name="id" select="@xml:id"/>

  <xsl:variable name="page" select="//h:li[@id=$id]"/>

  <xsl:if test="not($page)">
    <xsl:message terminate="yes">
      <xsl:text>Did not find “</xsl:text>
      <xsl:value-of select="$id"/>
      <xsl:text>” in menu.xml</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:variable name="top" select="$page/ancestor-or-self::h:li[last()]"/>
  <xsl:variable name="l2" select="if ($top = $page)
                                  then $page/h:ul/h:li[1]
				  else $page"/>

  <div class="navset" id="nav">
    <div class="hd">
      <ul>
	<xsl:for-each select="/h:ul/h:li">
	  <li>
	    <xsl:copy-of select="@*"/>
	    <xsl:if test=". = $top">
	      <xsl:attribute name="class" select="'on'"/>
	      <xsl:attribute name="title" select="'selected'"/>
	    </xsl:if>
	    <a>
	      <xsl:copy-of select="h:a/@*"/>
	      <xsl:choose>
		<xsl:when test=". = $top">
		  <strong>
		    <em>
		      <xsl:value-of select="h:a"/>
		    </em>
		  </strong>
		</xsl:when>
		<xsl:otherwise>
		  <em>
		    <xsl:value-of select="h:a"/>
		  </em>
		</xsl:otherwise>
	      </xsl:choose>
	    </a>
	  </li>
	</xsl:for-each>
      </ul>
    </div>
    <div class="bd">
      <ul>
	<xsl:for-each select="$top/h:ul/h:li">
	  <xsl:variable name="on"
			select="if (. = $l2) then 'on' else ''"/>
	  <xsl:variable name="first"
			select="if (not(preceding-sibling::h:li))
				then 'first'
				else ''"/>
	  <xsl:variable name="last"
			select="if (not(following-sibling::h:li))
				then 'last'
				else ''"/>
	  <xsl:variable name="class">
	    <xsl:value-of select="($on, $first, $last)" separator=" "/>
	  </xsl:variable>

	  <li>
	    <xsl:copy-of select="@*"/>
	    <xsl:if test="$class != ''">
	      <xsl:attribute name="class" select="$class"/>
	    </xsl:if>
	    <a>
	      <xsl:copy-of select="h:a/@*"/>
	      <xsl:value-of select="h:a"/>
	    </a>
	  </li>
	</xsl:for-each>
      </ul>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>
