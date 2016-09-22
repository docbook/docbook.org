<s:schema xmlns:s="http://purl.oclc.org/dsdl/schematron"
          xmlns:db="http://docbook.org/ns/docbook"
          xmlns:xs="http://www.w3.org/2001/XMLSchema"
          xmlns:xlink="http://www.w3.org/1999/xlink">
   <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
   <s:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
   <s:pattern name="Only one kind of linking per element">
      <s:rule context="db:*[@linkend and @xlink:*]">
         <s:assert test="not(@linkend) or not(@xlink:*)">@linkend cannot be combined with XLink.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on orderedlist</s:title>
      <s:rule context="db:orderedlist">
         <s:assert test="not(@startingnumber and @continuation)">List numeration can only be specified with @startingnumber or @continuation, not both</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on simplelist</s:title>
      <s:rule context="db:simplelist">
         <s:assert test="not(@columns) or not(@type) or (@type != 'inline')">Inline simple lists cannot have @columns</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on example</s:title>
      <s:rule context="db:example">
         <s:assert test="not(@width and @pgwide)">Only one of @width or @pgwide may be specified.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on informalexample</s:title>
      <s:rule context="db:informalexample">
         <s:assert test="not(@width and @pgwide)">Only one of @width or @pgwide may be specified.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on literallayout</s:title>
      <s:rule context="db:literallayout">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In literallayout, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on screen</s:title>
      <s:rule context="db:screen">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In screen, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on programlisting</s:title>
      <s:rule context="db:programlisting">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In programlisting, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on videodata</s:title>
      <s:rule context="db:videodata">
         <s:assert test="@fileref or @entityref and not(@fileref and @entityref)">Only one of @fileref or @entityref may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on audiodata</s:title>
      <s:rule context="db:audiodata">
         <s:assert test="@fileref or @entityref and not(@fileref and @entityref)">Only one of @fileref or @entityref may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on imagedata</s:title>
      <s:rule context="db:imagedata">
         <s:assert test="(@fileref or @entityref and not(@fileref and @entityref))                        or (not(@fileref) and not(@entityref))">Only one of @fileref or @entityref may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on textdata</s:title>
      <s:rule context="db:textdata">
         <s:assert test="@fileref or @entityref and not(@fileref and @entityref)">Only one of @fileref or @entityref may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on areaspec</s:title>
      <s:rule context="db:areaspec">
         <s:assert test="(not(@units eq 'other') and not(@otherunits))                        or (@units='other' and @otherunits)">The @units/@otherunits attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on area</s:title>
      <s:rule context="db:area">
         <s:assert test="(not(@units eq 'other') and not(@otherunits))                        or (@units='other' and @otherunits)">The @units/@otherunits attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on area</s:title>
      <s:rule context="db:area">
         <s:assert test="not(@linkends) or not(@xlink:href)">Only one of @linkends/@xlink:href may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on areaset</s:title>
      <s:rule context="db:areaset">
         <s:assert test="(not(@units eq 'other') and not(@otherunits))                              or (@units='other' and @otherunits)">The @units/@otherunits attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on areaset</s:title>
      <s:rule context="db:areaset">
         <s:assert test="(not(@units eq 'other') and not(@otherunits))                        or (@units='other' and @otherunits)">The @units/@otherunits attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on areaset</s:title>
      <s:rule context="db:areaset">
         <s:assert test="not(@linkends) or not(@xlink:href)">Only one of @linkends/@xlink:href may be specified</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on address</s:title>
      <s:rule context="db:address">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In address, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on orgname</s:title>
      <s:rule context="db:orgname">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on personname</s:title>
      <s:rule context="db:personname">
         <s:assert test="normalize-space(string-join(text(),'')) = ''                        or (not(db:honorific) and not(db:firstname) and not(db:surname)                            and not(db:lineage) and not(db:othername))">A personname must be text or honorific/firstname/surname/lineage/othername, not both</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on biblioid</s:title>
      <s:rule context="db:biblioid">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on citebiblioid</s:title>
      <s:rule context="db:citebiblioid">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on bibliosource</s:title>
      <s:rule context="db:bibliosource">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on bibliorelation</s:title>
      <s:rule context="db:bibliorelation">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on bibliorelation</s:title>
      <s:rule context="db:bibliorelation">
         <s:assert test="(not(@type eq 'other') and not(@othertype))                            or (@type='other' and @othertype)">The @type/@othertype attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on bibliocoverage</s:title>
      <s:rule context="db:bibliocoverage">
         <s:assert test="(not(@spatial eq 'other') and not(@otherspatial))                             or (@spatial='other' and @otherspatial)">The @spatial/@otherspatial attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on bibliocoverage</s:title>
      <s:rule context="db:bibliocoverage">
         <s:assert test="(not(@temporal eq 'other') and not(@othertemporal))                             or (@temporal='other' and @othertemporal)">The @temporal/@othertemporal attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on othercredit</s:title>
      <s:rule context="db:othercredit">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                        or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on refmiscinfo</s:title>
      <s:rule context="db:refmiscinfo">
         <s:assert test="(not(@class eq 'other') and not(@otherclass))                            or (@class='other' and @otherclass)">The @class/@otherclass attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on indexterm</s:title>
      <s:rule context="db:indexterm">
         <s:assert test="@class='endofrange' or not(@startref)">Only end-of-range indexterms may have @startref</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on indexterm</s:title>
      <s:rule context="db:indexterm">
         <s:assert test="not(@class='endofrange')                        or (@startref and not(@significance) and not(@zone) and not(@pagenum)                            and not(@scope) and not(@type))">End-of-range indexterms must have @startref and must not have @significance, @zone, @pagenum, @scope, or @type</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on indexterm</s:title>
      <s:rule context="db:indexterm">
         <s:assert test="not(@class='endofrange') or not(*)">End-of-range indexterms must be empty</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on index</s:title>
      <s:rule context="db:index">
         <s:assert test="(not(db:indexdiv) and not(db:indexentry))                        or (db:indexdiv and not(db:indexentry))                        or (db:indexentry and not(db:indexdiv))">Indexes must contain entries or divisions, not both.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on index</s:title>
      <s:rule context="db:index">
         <s:assert test="not(db:indexdiv)                        or not(db:indexdiv/following-sibling::*[not(self::db:indexdiv)])">Nothing may follow an indexdiv except another indexdiv.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on index</s:title>
      <s:rule context="db:index">
         <s:assert test="not(db:indexentry)                        or not(db:indexentry/following-sibling::*[not(self::db:indexentry)])">Nothing may follow an indexentry except another indexentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on indexdiv</s:title>
      <s:rule context="db:indexdiv">
         <s:assert test="not(db:indexentry)                        or not(db:indexentry/following-sibling::*[not(self::db:indexentry)])">Nothing may follow an indexentry except another indexentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on constraint</s:title>
      <s:rule context="db:constraint">
         <s:assert test="@linkend or @xlink:href">A link must be specified with @linkend or @xlink:href</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on productionrecap</s:title>
      <s:rule context="db:productionrecap">
         <s:assert test="@linkend or @xlink:href">A link must be specified with @linkend or @xlink:href</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on keycap</s:title>
      <s:rule context="db:keycap">
         <s:assert test="(not(@function eq 'other') and not(@otherfunction))                            or (@function='other' and @otherfunction)">The @function/@otherfunction attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on keycombo</s:title>
      <s:rule context="db:keycombo">
         <s:assert test="(not(@action eq 'other') and not(@otheraction))                        or (@action='other' and @otheraction)">The @action/@otheraction attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on shortcut</s:title>
      <s:rule context="db:shortcut">
         <s:assert test="(not(@action eq 'other') and not(@otheraction))                        or (@action='other' and @otheraction)">The @action/@otheraction attributes must be consistent</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on synopsis</s:title>
      <s:rule context="db:synopsis">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In synopsis, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on funcsynopsisinfo</s:title>
      <s:rule context="db:funcsynopsisinfo">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In funcsynopsisinfo, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern>
      <s:title>Assertion on classsynopsisinfo</s:title>
      <s:rule context="db:classsynopsisinfo">
         <s:assert test="not(@xml:space) or @xml:space='preserve'">In classsynopsisinfo, @xml:space must be 'preserve'</s:assert>
      </s:rule>
   </s:pattern>
</s:schema>
