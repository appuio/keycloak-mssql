<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:domain="urn:jboss:domain:4.0"
                xmlns:undertow="urn:jboss:domain:undertow:3.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//undertow:subsystem/undertow:server/undertow:host/undertow:filter-ref[@name='x-powered-by-header']" />

    <xsl:template match="//undertow:subsystem/undertow:server/undertow:host/undertow:filter-ref[@name='server-header']" />

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
