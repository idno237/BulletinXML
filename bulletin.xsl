<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <!-- Requêtes XPath pour extraire les informations -->
    
    <!-- Liste des classes -->
    <xsl:variable name="classes" select="/ecole/classes/classe"/>
    
    <!-- Template pour la racine -->
    <xsl:template match="/">
        <!-- Contenu de la page PDF -->
        <fo:root>
            <!-- Mise en page de la page -->
            <fo:layout-master-set>
                <!-- Définition du modèle de page -->
                <fo:simple-page-master master-name="page" page-height="11in" page-width="8.5in">
                    <!-- Définition de la région de corps -->
                    <fo:region-body margin="1in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!-- Séquence de page -->
            <fo:page-sequence master-reference="page">
                <!-- Flux de la page -->
                <fo:flow flow-name="xsl-region-body">
                    <!-- Titre du bulletin -->
                    <fo:block font-size="18pt" font-weight="bold" text-align="center">Bulletin Scolaire</fo:block>
                    
                    <!-- Pour chaque classe -->
                    <xsl:for-each select="$classes">
                        <!-- En-tête du tableau -->
                        <fo:block font-size="14pt" font-weight="bold" margin-top="20pt">
                            <xsl:text>Classe : </xsl:text>
                            <xsl:value-of select="nom"/>
                            <xsl:text> - Enseignant Principal : </xsl:text>
                            <xsl:value-of select="professeur_principal"/>
                        </fo:block>
                        
                        <!-- Tableau -->
                        <fo:table border-collapse="collapse" margin-top="10pt">
                            <!-- Colonnes -->
                            <fo:table-column column-width="auto"/>
                            <!-- Colonnes pour les matières -->
                            <xsl:for-each select="eleves/eleve[1]/matieres/matiere">
                                <fo:table-column column-width="auto"/>
                            </xsl:for-each>
                            <!-- Colonnes pour la moyenne et la décision -->
                            <fo:table-column column-width="auto"/>
                            <fo:table-column column-width="auto"/>
                            <!-- En-têtes -->
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                        <fo:block font-weight="bold">Nom élève</fo:block>
                                    </fo:table-cell>
                                    <!-- En-têtes des matières -->
                                    <xsl:for-each select="eleves/eleve[1]/matieres/matiere">
                                        <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                            <fo:block font-weight="bold">
                                                <xsl:value-of select="nom"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </xsl:for-each>
                                    <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                        <fo:block font-weight="bold">Moyenne</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                        <fo:block font-weight="bold">Décision</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <!-- Lignes pour chaque élève -->
                            <xsl:for-each select="eleves/eleve">
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell border="1pt solid black" padding="3pt">
                                            <fo:block>
                                                <xsl:value-of select="nom"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <!-- Cellules pour les notes -->
                                        <xsl:for-each select="matieres/matiere">
                                            <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                                <fo:block>
                                                    <xsl:value-of select="notes/note"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:for-each>
                                        <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="moyenne"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell border="1pt solid black" padding="3pt" text-align="center">
                                            <fo:block>
                                                <!-- Logique pour déterminer la décision (admis ou refusé) -->
                                                <!-- Ici, par exemple, je suppose que la moyenne doit être supérieure ou égale à 10 pour être admis -->
                                                <xsl:choose>
                                                    <xsl:when test="moyenne &gt;= 10">
                                                        <xsl:text>Admis</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:text>Refusé</xsl:text>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </xsl:for-each>
                        </fo:table>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
</xsl:stylesheet>
