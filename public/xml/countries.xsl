<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>

                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Countries</title>
                <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
                <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
                      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
                      crossorigin="anonymous"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
                        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
                        crossorigin="anonymous"></script>
            </head>
            <body>

                <div class="row">

                    <div class="col-md-3">
                        <a href="#alphabetic" data-toggle="collapse"
                           style="padding: 20px;font-size: 18px;text-transform: uppercase;background-color: #f5f5f5;width: 100%;display: block;text-align: center;color: #333;"
                        >Trier par Nom</a>
                        <div class="collapse" id="alphabetic">
                            
                            <ul class="list-group">
                                <xsl:apply-templates mode="menu-az">
                                    <xsl:sort data-type="number" order="descending" select="@name"/>
                                </xsl:apply-templates>
                            </ul>

                        </div>

                        <a href="#pop" data-toggle="collapse"
                           style="padding: 20px;font-size: 18px;text-transform: uppercase;background-color: #f5f5f5;width: 100%;display: block;text-align: center;color: #333;"
                        >Trier par Population</a>
                        <div class="collapse" id="pop">

                            <xsl:apply-templates mode="menu-pop">

                            </xsl:apply-templates>

                        </div>


                        <a href="#superficie" data-toggle="collapse"
                           style="padding: 20px;font-size: 18px;text-transform: uppercase;background-color: #f5f5f5;width: 100%;display: block;text-align: center;color: #333;"
                        >Trier par superficie</a>
                        <div class="collapse" id="superficie">

                            <xsl:apply-templates mode="menu-super">

                            </xsl:apply-templates>

                        </div>
                    </div>

                    <div class="col-md-6">
                        <h1>Countries</h1>

                        <div class="countries row">

                            <div class="col-md-12">

                                <xsl:apply-templates mode="panels"/>

                            </div>

                        </div>

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
            </body>
        </html>
    </xsl:template>

    <xsl:template match="country" mode="menu-az">

        <li class="list-group-item">
            <a>
                <xsl:attribute name="href">#<xsl:value-of select="generate-id()"/>
                </xsl:attribute>

                <xsl:value-of select="./@name"/>
            </a>
        </li>

    </xsl:template>

    <xsl:template match="countries" mode="menu-pop">

        <xsl:for-each select="country">

            <xsl:sort data-type="number" order="descending" select="@population"/>

            <li class="list-group-item">
                <a>
                    <xsl:attribute name="href">#<xsl:value-of select="generate-id()"/>
                    </xsl:attribute>

                    <xsl:value-of select="./@name"/>
                </a>
            </li>

        </xsl:for-each>

    </xsl:template>



    <xsl:template match="countries" mode="menu-super">

        <xsl:for-each select="country">

            <xsl:sort data-type="number" order="descending" select="@area"/>

            <li class="list-group-item">
                <a>
                    <xsl:attribute name="href">#<xsl:value-of select="generate-id()"/>
                    </xsl:attribute>

                    <xsl:value-of select="./@name"/>
                </a>
            </li>

        </xsl:for-each>

    </xsl:template>

    <xsl:template match="country" mode="panels">
        <div class="panel panel-default">
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()"/>
            </xsl:attribute>



            <div class="panel-heading">
                <xsl:value-of select="./@name"/>
            </div>

            <table class="table">
                <tr>
                    <td>Population</td>
                    <td>
                        <xsl:value-of select="./@population"/>
                    </td>
                </tr>
                <tr>
                    <td>Superficie</td>
                    <td>
                        <xsl:value-of select="./@area"/> km²
                    </td>
                </tr>
                <!-- Langues -->
                <xsl:if test="language">
                    <tr>
                        <td colspan="2" style="font-weight:bold;">Langues</td>
                    </tr>

                    <xsl:for-each select="language">

                        <xsl:sort select="@percentage" data-type="number" order="descending"/>
                        <tr>
                            <td>

                                <svg width="100" height="25" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                    <g>

                                        <rect stroke="#000" height="25" width="100" stroke-opacity="null"
                                              stroke-width="1.5" fill="#BBBBBB"/>
                                        <rect stroke="#000" height="25" stroke-opacity="null" stroke-width="1.5"
                                              fill="#A0D58A">
                                            <xsl:attribute name="width">
                                                <xsl:value-of select="./@percentage"/>
                                            </xsl:attribute>
                                        </rect>
                                        <text text-anchor="start" font-size="10" y="15" x="40" fill-opacity="null"
                                              stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">
                                            <xsl:value-of select="./@percentage"/>%
                                        </text>

                                    </g>
                                </svg>
                            </td>
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                        </tr>

                    </xsl:for-each>
                </xsl:if>

                <!-- Villes -->
                <xsl:if test="city">
                    <tr>
                        <td colspan="2" style="font-weight:bold;">
                            Villes principales
                            <small style="float:right;">% de la population totale</small>
                        </td>
                    </tr>

                    <xsl:for-each select="city">
                        <xsl:sort select="population" order="descending"/>
                        <tr>
                            <td>
                                <xsl:value-of select="./name"/>
                            </td>
                            <td>
                                <xsl:value-of select="population"/> (
                                <xsl:value-of select="format-number(population div ../@population, '##.0%')"/>)
                            </td>
                        </tr>

                    </xsl:for-each>
                    <tr>
                        <td colspan="2">

                            <xsl:variable name="maxPopCity">
                                <xsl:for-each select="city/population">
                                    <xsl:sort data-type="number" order="descending" />
                                    <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
                                </xsl:for-each>
                            </xsl:variable>

                            <svg width="100%"  version="1.1" xmlns="http://www.w3.org/2000/svg">

                                <xsl:attribute name="height">
                                    <xsl:value-of select="count(city) * 30 + 30"/>
                                </xsl:attribute>

                                <xsl:variable name="startY">
                                    <xsl:value-of select="0" />
                                </xsl:variable>


                                <xsl:for-each select="city">
                                    <xsl:sort data-type="number" select="population" order="descending" />
                                    <xsl:variable name="ratio">
                                        <xsl:value-of select="population div $maxPopCity * 100 * 3"/>
                                    </xsl:variable>




                                    <rect stroke="#000" height="25"  x="0" stroke-opacity="null" stroke-width="1.5"
                                          fill="#5ad7d2">

                                        <xsl:attribute name="y">
                                                <xsl:value-of select="(position() * 30)"/>
                                        </xsl:attribute>

                                        <xsl:attribute name="width">
                                            <xsl:value-of select="$ratio"/>
                                        </xsl:attribute>

                                    </rect>

                                    <text text-anchor="start" font-size="10"  x="5" fill-opacity="null"
                                          stroke-opacity="null" stroke-width="0" stroke="#000" fill="#000000">


                                        <xsl:attribute name="y">
                                            <xsl:value-of select="position() * 30  + 15"/>
                                        </xsl:attribute>

                                        <xsl:value-of select="name"/>
                                    </text>


                                </xsl:for-each>
                            </svg>
                        </td>
                    </tr>
                </xsl:if>

            </table>
            <br/>
        </div>
    </xsl:template>


</xsl:stylesheet>