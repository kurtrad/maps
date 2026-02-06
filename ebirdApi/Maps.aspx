<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Maps.aspx.cs" Inherits="BirdingTheCloudDotCom.Maps" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 474px;
            height: 277px;
            float: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>eBird Maps</h1>
    <p>These maps are still in development, if you have any suggestions for features or additional maps email me and let me know.</p>
    <p><a href="ebirdApi/ebirdABASpecies.html" target="_blank">ABA Bird Species Locator</a> - Find Recent Sightings of species in the ABA Area</p>
    <p><a href="ebirdApi/ebirdAllStates.html" target="_blank">Bird Species by State Locator</a> Every state - Find Recent Sightings of Species in all 50 US States</p>
    <p>
        <a href="ebirdApi/ebirdSelectWithDropdown.html" target="_blank">Arizona Notables</a> - map of current Arizona Rarities<img alt="" class="auto-style1" src="ebirdApi/images/map.png" /></p>
    <p>
        <a href="ebirdApi/ebirdSelectCAWithDropdown.html" target="_blank">California Notables </a>- map of current California Rarities</p>
    <p>
        <a href="ebirdApi/ebirdHotspotCompare.html" target="_blank">Compare eBird Counties and Hotspots</p>
    <p>
        <a href="ebirdApi/ebirdHotspotCompare_excludeExotics.html" target="_blank">Compare eBird Counties and Hotspots Excluding Exotics</a></p>
    <p>
        <a href="ebirdApi/ebirdWorld.html" target="_blank">World Notables</a> - Sigtings by Country</p>
    <p>
        <a href="ebirdApi/ebirdSelectABA.html" target="_blank">ABA Notables</a> - ABA Rarities by ABA Code</p>
    <p>
        <a href="ebirdApi/ebirdUnitedStatesWithDropdown.html" target="_blank">Notable for all 50 states</a><a href="ebirdApi/ebirdHotspots.html" target="_blank"> </a>- map of U.S. sightings by state</p>
    <p>
        <a href="ebirdApi/ebirdMexicoStates.html" target="_blank">Notable for all Mexico states</a><a href="ebirdApi/ebirdHotspots.html" target="_blank"> </a>- map of Mexico sightings by state</p>
    <p>
        <a href="ebirdApi/ebirdNotablesByCounty.html" target="_blank">Notable by County all 50 states</a><a href="ebirdApi/ebirdHotspots.html" target="_blank"> </a>- map of U.S. notables by county</p>
    <p>
        <a href="ebirdApi/ebirdHotspotsCounty.html" target="_blank">AZ Hotspots by County</a> - hotspots by county in az</p>
    <p>
        <a href="ebirdApi/ebirdHotspots.html" target="_blank">Hotspots for all 50 states </a>- map of U.S. Hotspots by state</p>
    <p>
        <a href="ebirdApi/ebirdHotspotsWorld.html" target="_blank">World Hotspots </a>- Hotspots of the world</p>
    <p>
        <a href="ebirdApi/ebirdWorldSpecies.html" target="_blank">World Species</a> - Sightings by species</p>
    <p>
        <a href="ebirdApi/AZIBAMap.html" target="_blank">Arizona IBAs</a> - map of current Arizona IBAs</p>
    <p>
        <a href="ebirdApi/USAIBAMap.html" target="_blank">USA IBAs</a> - map of current USA IBAs</p>
    <p>
        <a href="http://kurtrad.maps.arcgis.com/apps/View/index.html?appid=ce5cd85610274acbb5ec8bfb9b16077c" target="_blank">Elegant Trogon</a> - range map</p>
    <p>
        <a href="http://kurtrad.maps.arcgis.com/apps/View/index.html?appid=ebcab2bffd3f4015a97930308721379b" target="_blank">Tufted Flycatcher </a>- range map</p>
    <p>
        <a href="http://kurtrad.maps.arcgis.com/apps/View/index.html?appid=5ae2cf471d564477849399fa1e10735e" target="_blank">Painted Redstart</a> - range map</p>
    <p>
        <a href="ebirdApi/worldSatellitesMapExpression.html">World Satellites </a>- world satellites map</p>
    <p>
        <a href="ebirdApi/worldSatellites3D.html">World Satellites 3D </a>- world satellites map</p>
    <p dir="ltr">
        <a href="http://kurtrad.maps.arcgis.com/home/index.html">ESRI Maps project</a> - ESRI Online Maps</p>
    <p>
        &nbsp;</p>
    </asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
