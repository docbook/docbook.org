<s:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          xmlns:db="http://docbook.org/ns/docbook"
          xmlns:s="http://purl.oclc.org/dsdl/schematron">
   <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
   <s:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
   <s:pattern>
      <s:title>Assertion on speaker</s:title>
      <s:rule context="db:speaker">
         <s:assert test="not(db:person) or (normalize-space(text()) = '')">Content must be text or person, not both</s:assert>
      </s:rule>
   </s:pattern>
</s:schema>