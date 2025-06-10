<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"/>
    
    <!--
    Small transformation, move tei:diploDesc/tei:origDate and tei:diploDesc/tei:origPlace into
    tei:diploDesco/tei:issued/tei:date and tei:diploDesco/tei:issued/tei:placeName
    
    added: Translate tei:div/@type = Sachkommentar to commentary
    -->
    
    <xsl:template match="tei:diploDesc">
        <xsl:copy>
            
            <xsl:apply-templates select="node()|@*"/>
            <xsl:element name="issued" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="./tei:origPlace"/>
            </xsl:element>
                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:if test="./tei:origDate/@notBefore">
                        <xsl:attribute name="notBefore" select="./tei:origDate/@notBefore"/>
                    </xsl:if>
                    <xsl:if test="./tei:origDate/@notAfter">
                        <xsl:attribute name="notAfter" select="./tei:origDate/@notAfter"/>
                    </xsl:if>
                    <xsl:if test="./tei:origDate/@when">
                        <xsl:attribute name="when" select="./tei:origDate/@when"/>
                    </xsl:if>
                    <xsl:value-of select="./tei:origDate"/>
                </xsl:element>
        </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:div/@type[. = 'Sachkommentar']">
        <xsl:attribute name="type">commentary</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="tei:diploDesc/tei:origPlace"/>
    <xsl:template match="tei:diploDesc/tei:origDate"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>