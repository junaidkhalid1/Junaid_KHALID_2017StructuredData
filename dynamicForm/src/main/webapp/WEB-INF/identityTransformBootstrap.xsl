<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet"
                      href="css/bootstrap.min.css" />

                <script type="text/javascript" src="js/angular.min.js"/>
                <script>
                    var app = angular.module('myApp', []);

                    function MyController($scope, $http) {

                    $scope.getDataFromServer = function() {
                    $http({
                    method : 'POST',
                    url : 'identityAction'
                    }).success(function(data, status, headers, config) {
                    $scope.person = data;
                    }).error(function(data, status, headers, config) {
                    // called asynchronously if an error occurs
                    // or server returns response with an error status.
                    });

                    };
                    };
                </script>

            </head>

            <body>
                <div class="container">
                    <div>
                        <div class="jumbotron">
                            <div class="container">
                                <h1 class="text-info">Identity Creation</h1>
                            </div>
                        </div>
                        <div class="container">
                            <div xmlns="http://www.w3.org/1999/xhtml" class="bs-example">

                                <form ng-app="myApp" ng-controller="MyController" name="myForm" >
                                    <p><font color="green"><strong>{{person.message}}</strong></font></p>
                                    <xsl:apply-templates />
                                    <button type="submit" class="btn btn-default" ng-click="getDataFromServer()" ng-disabled="myForm.$invalid">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="property">
        <xsl:variable name="id" select="./@name" />
        <div class="form-group">
            <xsl:element name="label">
                <xsl:attribute name="for"><xsl:value-of select="$id"/></xsl:attribute>
                <xsl:value-of select="./label" />
            </xsl:element>

            <xsl:element name="input">

                <xsl:attribute name="ng-model"><xsl:value-of select="./@ng-model"/></xsl:attribute>
                <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
                <xsl:attribute name="type"><xsl:value-of select="./@type"/></xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
                <xsl:attribute name="required"><xsl:value-of select="./@required"/></xsl:attribute>
                <xsl:attribute name="value"><xsl:value-of select="./@defaultValue"/></xsl:attribute>
                <xsl:attribute name="placeholder"><xsl:value-of select="./hint"/></xsl:attribute>
                <xsl:attribute name="data-calculation"><xsl:value-of select="./@calculatedValue"/></xsl:attribute>
                <xsl:attribute name="class"><xsl:value-of select="./@class"/></xsl:attribute>
            </xsl:element>
        </div>
    </xsl:template>

</xsl:stylesheet>