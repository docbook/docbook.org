<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>

<p:xslt name="dirlistings">
  <p:input port="stylesheet">
    <p:document href="dirlistings.xsl"/>
  </p:input>
</p:xslt>

<p:sink/>

<p:for-each>
  <p:iteration-source>
    <p:pipe step="dirlistings" port="secondary"/>
  </p:iteration-source>

  <p:store name="store-chunk" method="xhtml" encoding="utf-8" indent="false">
    <p:with-option name="href" select="base-uri(/)"/>
  </p:store>
</p:for-each>

</p:declare-step>
