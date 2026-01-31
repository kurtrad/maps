# eBird API Mapping Application - Copilot Instructions

## Project Overview
eBird API Mapping is an ASP.NET web application that visualizes bird observation hotspots and species data using Esri ArcGIS mapping library. The app integrates with the eBird API to display recent notable bird sightings across US states and Mexico.

**Key Tech Stack:**
- Frontend: HTML5, jQuery 3.3.1, Esri ArcGIS JS API 4.6
- Backend: ASP.NET (.NET 4.0), IIS with local port 4704
- UI Libraries: Dojo 1.10.4 (for ComboBox widgets), SweetAlert2 (for dialogs)
- Data Sources: eBird REST API v2 + local XML files (AZ/CA species lists)

## Architecture Patterns

### Single-Page HTML Applications
Each `.html` file is a self-contained application with:
- Embedded `require()` calls for Esri/Dojo modules (AMD loader pattern)
- Direct jQuery AJAX calls to eBird API (no backend proxy)
- jQuery used for DOM manipulation and AJAX, not as a full framework
- Global variables for state (`data`, `selection`, `daysback`, `review`)

**Key Files:**
- [ebirdHotspotCompare.html](ebirdApi/ebirdHotspotCompare.html) - Main feature: compares species lists between two map-clicked points
- [index.html](ebirdApi/index.html) - Simple hotspot visualization with species filtering
- [modeSelect.html](ebirdApi/modeSelect.html) - Hotspot viewer with state selector dropdown

### Esri ArcGIS Integration
All map implementations follow this pattern:
```javascript
require(["esri/Map", "esri/views/MapView", ...], function(Map, MapView, ...) {
    var map = new Map({ basemap: "streets" });
    var view = new MapView({ center: [-112, 33], container: "viewDiv", map: map, zoom: 7 });
    // Add graphics to view.graphics layer
    view.ui.add(widget, "bottom-right");  // Position UI widgets
});
```

**Default map centers by region:**
- US-AZ: [-112, 33]
- US-CA: [-119, 37]
- US-NM: [-106, 34]
- MX-BCN: [-115, 30]

### eBird API Integration
All requests require hardcoded API key: `npobnnr5u7fo`

**AJAX Pattern:**
```javascript
var ebirdAPI = {
    "crossDomain": true,
    "url": "https://ebird.org/ws2.0/...",
    "method": "GET",
    "async": false,  // Often synchronous - blocking calls
    "headers": { "X-eBirdApiToken": "npobnnr5u7fo" }
};
$.ajax(ebirdAPI).done(function(response) { data = response; });
```

**Commonly Used Endpoints:**
- Hotspots: `https://ebird.org/ws2.0/ref/hotspot/{region-code}?fmt=json&back={days}`
- Recent observations: `https://ebird.org/ws2.0/data/obs/{region}/recent/notable?back={days}&cat=species&detail=full`
- Species lists: `https://api.ebird.org/v2/product/spplist/{hotspot-code}`
- Geo hotspots: `https://api.ebird.org/v2/ref/hotspot/geo?dist=.5&lat={lat}&lng={lng}`

### Species Data Filtering
Local XML files ([xmldata/AZListXMLFile.xml](ebirdApi/xmldata/AZListXMLFile.xml), CAListXMLFile.xml) contain ABC (Avian Biological Committee) species review status:
```javascript
$(ABCdata).find('Species').each(function() {
    var species = $(this).attr('EnglishName');
    var review = $(this).attr('Review');  // "Y" (reviewed), "N" (sketch), or default
});
```

**Point Color Coding:**
- Red: Review required (review == "Y")
- Blue: Sketch species (review == "N")
- Green: Default/notable species

## Development Patterns & Conventions

### Map Point Rendering
All hotspots create graphics using this pattern:
```javascript
var point = new Point(data[i].lng, data[i].lat);
var pointGraphic = new Graphic({
    geometry: point,
    symbol: markerSymbol,
    attributes: { Name: data[i].locName, Checklist: "https://ebird.org/hotspot/" + data[i].locId },
    popupTemplate: { title: "{Name}", content: [...] }
});
view.graphics.add(pointGraphic);
```

### State Management & Event Handling
- Dropdowns trigger `updateElevationMode()` which calls `loadSpecies()` to refresh map
- Mouse clicks register via `view.on("click", ...)` and use `view.hitTest()` for feature detection
- Multiple selection workflows use flag variables (e.g., `firstPoint`, `secondPoint`)

### Async Operations & Promises
Modern code uses promise chains for map readiness:
```javascript
view.when(() => {
    var points = data.map(item => ({type: "point", x: item.lng, y: item.lat, spatialReference: {wkid: 4326}}));
    return view.goTo(points);
}).then(() => console.log("Map ready")).catch(error => console.error(error));
```

## Key Workflows & Common Tasks

### Adding a New Feature Page
1. Create new `.html` file in `ebirdApi/` directory
2. Include: `<script src="Scripts/jquery-3.3.1.js"></script>` + Esri CSS/JS
3. Define global variables for state at top of require block
4. Use standard `require([...esri modules...])` + callback pattern
5. Add map container `<div id="viewDiv"></div>` in body
6. For dropdowns: create `<select id="modeSelect"></select>` and use `window.addEventListener("change", ...)`

### Modifying API Calls
- Update URL in `var urlAPI = "..."` lines
- Keep `"async": false` for synchronous loading (blocks until response)
- All API keys hardcoded; consider environment variable approach for production
- Test with browser DevTools Network tab for response validation

### Debugging Map Issues
- Use `console.log(response)` after every AJAX call to inspect data structure
- Check `view.extent` and `view.zoom` to verify map state
- Graphics not showing? Verify: (1) graphics added to `view.graphics`, (2) geometry coords in correct order (lng, lat), (3) symbol color is visible on current basemap

### Common Gotchas
- **Synchronous AJAX** (`"async": false`) blocks UI - used throughout for simplicity but not recommended for production
- **Global variable pollution** - `data`, `selection`, etc. shared across functions; refactoring needed for larger codebase
- **Hardcoded API key** exposed in source - security concern for public deployment
- **Many duplicate HTML files** - indicates experiment/iteration; consolidate similar pages into single template

## Important Files & Patterns

| File | Purpose |
|------|---------|
| [ebirdHotspotCompare.html](ebirdApi/ebirdHotspotCompare.html) | Click 2 map points → compare species; most complex feature |
| [loadspecies.js](ebirdApi/loadspecies.js) | Modular point rendering logic (partially used) |
| [xmldata/AZListXMLFile.xml](ebirdApi/xmldata/AZListXMLFile.xml) | ABC species review data; jQuery parsed via `$(xml).find()` |
| [packages.config](packages.config) | Dojo 1.10.4 dependency |
| [Web.config](Web.config) | ASP.NET config - minimal, no special handlers |

## Before Touching Code
- **Local API key is public** - generated calls will leak token; mention in any code review
- **No build system** - just raw HTML/JS served by IIS; changes take effect immediately in browser
- **Test map centers** - if changing regions, verify map center coords align with actual region bounds
- **Browser compatibility** - Esri JS 4.6 (2016) requires modern browser; test in IE11 if needed
- **Dojo AMD loader** - if adding new esri modules, add to `require()` array AND callback function parameters

