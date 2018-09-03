<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:p="http://www.evolus.vn/Namespace/Pencil"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </title>
                <link rel="stylesheet" href="Resources/CustomStyle.css"/>
                <script src="Resources/CustomScript.js"/>
            </head>
            <body onload="first()">
				<div id="Prototype">
					<div id="PrototypeHeader">
		            	<div id="PrototypeTitle"><xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/></div>
					</div>
					<div id="PrototypeBody">
			            <xsl:apply-templates select="/p:Document/p:Pages/p:Page" />
					</div>
					<div id="PrototypeFooter">
		            	<div id="PrototypeMetadata">Exported at: <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='exportTime']/text()"/></div>
					</div>
				</div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="p:Page">
        <div class="Page" id="{p:Properties/p:Property[@name='fid']/text()}_page">
            <div class="PageHeader">
                <div class="PageTitle">
                    <xsl:value-of select="p:Properties/p:Property[@name='name']/text()"/>
                </div>
				<div class="PageNavigator">
					<span onclick="first();">First</span> | 
					<span onclick="previous();">Previous</span> | 
					<span onclick="next();">Next</span>
				</div>
            </div>
            <div class="PageBody">
                <div class="ImageContainer">
                    <img src="{@rasterized}"
                        width="{p:Properties/p:Property[@name='width']/text()}"
                        height="{p:Properties/p:Property[@name='height']/text()}"
                        id="img_{p:Properties/p:Property[@name='fid']/text()}"/>
                </div>
                <xsl:if test="p:Note">
                    <p class="Notes">
                        <xsl:apply-templates select="p:Note/node()" mode="processing-notes"/>
                    </p>
                </xsl:if>
                <xsl:if test="p:Links">
                    <xsl:apply-templates select="p:Links/p:Link"/>
                </xsl:if>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="p:Link">
        <div class="Link" 
            style="top: {@y - 5}px; left: {@x - 5}px; width: {@w + 10}px; height: {@h + 10}px;" 
            onclick="go('{@targetFid}_page');"
            title="{@targetName}">
        </div>
    </xsl:template>
    
    <xsl:template match="html:*" mode="processing-notes">
        <xsl:copy>
            <xsl:copy-of select="@*[local-name() != '_moz_dirty']"/>
            <xsl:apply-templates mode="processing-notes"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html:a[@page-fid]" mode="processing-notes">
        <a href="#{@page-fid}_page" title="Go tp page '{@page-name}'">
            <xsl:copy-of select="@class|@style"/>
            <xsl:apply-templates mode="processing-notes"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
