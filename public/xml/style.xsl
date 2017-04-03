<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:output method="html"/>

    <xsl:template match="recette">
        <html>
            <head>
                <title>Recette -
                    <xsl:value-of select="nom"/>
                </title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="nom">
        <h1>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    <xsl:template match="description">
        <div class="description">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>


    <xsl:template match="liste_ingrédients">
        <div class="ingredients">
            <h2>Ingrédients :</h2>
            <ul>
                <xsl:for-each select="ingrédient">
                    <li>

                        <span class="mesures">
                            <xsl:value-of select="./@quantité"/>&#160;
                            <xsl:value-of select="./@unité[not(.='unité')]" /> de
                        </span>
                        <xsl:value-of select="."/>
                    </li>
                </xsl:for-each>
            </ul>

        </div>
    </xsl:template>


    <xsl:template match="préparation">
        <h2>Préparation : </h2>
        <span>Durée : <xsl:value-of select="./@durée"/></span><br/>
        <span>Cuisson : <xsl:value-of select="./@cuisson"/></span>

        <xsl:for-each select="étape">
            <div>
                <xsl:apply-templates/>
            </div><br/>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="notes">
        <div class="notes">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>

    <xsl:template match="note">
    </xsl:template>


    <xsl:template match="lien">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="./@ref"/>
            </xsl:attribute>

            <xsl:value-of select="."/>
        </a>
    </xsl:template>


    <xsl:template match="alinéa">
        <xsl:apply-templates/>
    </xsl:template>


</xsl:stylesheet>