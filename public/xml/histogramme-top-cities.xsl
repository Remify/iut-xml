<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>

                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Top cities</title>
                <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
                <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
                      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
                      crossorigin="anonymous"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
                        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
                        crossorigin="anonymous"></script>
            </head>
            <body>
                <div class="container">

                    <div class="row">

                        <div class="col-md-9">

                            <xsl:apply-templates>

                            </xsl:apply-templates>

                        </div>



                        <div class="col-md-3" style="margin: 5% 0; position: fixed; right: 0px;">
                            <ul>
                                <li><a href="../xml">XML Recherche</a></li>
                                <li><a href="../xml/countries.xml">XML Trie</a></li>
                                <li><a href="../xml/countries-2.xml">Top Pays</a></li>
                                <li><a href="../xml/countries-3.xml">Top Villes</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="*">


        <xsl:variable name="maxPopCity">
            <xsl:for-each select="country/city">
                <xsl:sort select="population" data-type="number" order="descending"/>
                <xsl:if test="position()=1">
                    <xsl:value-of select="population"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>


        <svg width="100%" height="330px" version="1.1" xmlns="http://www.w3.org/2000/svg">

            <xsl:for-each select="country/city">

                <xsl:sort select="population" data-type="number" order="descending"/>


                <xsl:if test="position() &lt; 11">


                    <xsl:variable name="ratioWidth">
                        <xsl:value-of select="population div $maxPopCity * 100 * 5"/>
                    </xsl:variable>

                    <rect stroke="#000" height="25" x="0" stroke-opacity="null" stroke-width="1.5"
                          fill="#5ad7d2">

                        <xsl:attribute name="y">
                            <xsl:value-of select="(position() * 30)"/>
                        </xsl:attribute>

                        <xsl:attribute name="width">
                            <xsl:value-of select="$ratioWidth"/>
                        </xsl:attribute>
                    </rect>


                    <text text-anchor="start" font-size="10"  x="5" fill-opacity="null"
                          stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">


                        <xsl:attribute name="y">
                            <xsl:value-of select="position() * 30  + 15"/>
                        </xsl:attribute>

                        <xsl:value-of select="name"/> -
                        <xsl:value-of select="population"/> d'habitants

                    </text>


                </xsl:if>
            </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>