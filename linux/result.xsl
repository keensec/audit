<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<body>
<xsl:for-each select="result/item[@flag != 'id']">
<div style="background-color:#e3e9f2;width:1000px;padding:30px;margin:0 auto">
    <h3>ID:<xsl:value-of select="@flag" /></h3>
    <p><strong>command:</strong><br />
    <xsl:value-of select="command" /></p>
    <p><strong>value:</strong><br />
    <xsl:value-of select="value" /></p>
</div>
</xsl:for-each>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
