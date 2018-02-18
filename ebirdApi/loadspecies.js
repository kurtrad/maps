/*************************
* Create a point graphic
*************************/

define([
    "esri/geometry/Point"
],function (
    point
) {
            loadspecies= function () {
                for (i = 0; i < data.length; ++i) {
                    review = "";
                    var point = new Point(data[i].lng, data[i].lat);

                    $(ABCdata).find('Species').each(function () {
                        var species = $(this).attr('EnglishName');

                        if (data[i].comName == species) {

                            review = $(this).attr('Review');
                        }

                        switch (review) {
                            case "Y":
                                reviewSpecies = "Y"
                                break;
                            case "N":
                                sketchSpecies = "Y"
                                break;
                            default:
                                notableSpecies = "Y"
                        }
                    })


                    // Create a symbol for drawing the point
                    var markerSymbol = {
                        type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
                        color: [0, 128, 0], //green
                        outline: { // autocasts as new SimpleLineSymbol()
                            color: [0, 100, 0],
                            width: 2
                        }
                    };

                    if (review == "Y") {
                        // Create a symbol for drawing the point
                        var markerSymbol = {
                            type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
                            color: [255, 0, 0], //red
                            outline: { // autocasts as new SimpleLineSymbol()
                                color: [128, 0, 0],
                                width: 2
                            }
                        };

                        review = " "
                    }
                    if (review == "N") {
                        // Create a symbol for drawing the point
                        var markerSymbol = {
                            type: "simple-marker", // autocasts as new SimpleMarkerSymbol()
                            color: [0, 0, 255], //blue
                            outline: { // autocasts as new SimpleLineSymbol()
                                color: [65, 105, 255],
                                width: 2
                            }
                        };

                        review = " "
                    }


                    // Create an object for storing attributes related to the line
                    var pointAtt = {
                        Name: data[i].comName,
                        Date: data[i].obsDt,
                        Location: data[i].locName,
                        Nunmber: data[i].howMany,
                        Observer: data[i].firstName + ' ' + data[i].lastName
                    };

                    /*******************************************
                     * Create a new graphic and add the geometry,
                     * symbol, and attributes to it. You may also
                     * add a simple PopupTemplate to the graphic.
                     * This allows users to view the graphic's
                     * attributes when it is clicked.
                     ******************************************/

                    var pointGraphic = new Graphic({
                        geometry: point,
                        symbol: markerSymbol,
                        attributes: pointAtt,
                        popupTemplate: {  // autocasts as new PopupTemplate()
                            title: "{Name}",
                            content: [{
                                type: "fields",
                                fieldInfos: [{
                                    fieldName: "Name"
                                }, {
                                    fieldName: "Date"
                                }, {
                                    fieldName: "Location"
                                }, {
                                    fieldName: "Number"
                                }, {
                                    fieldName: "Observer"
                                }]
                            }]
                        }
                    });

                    switch (selection) {
                        case "Review Species":
                            if (reviewSpecies == "Y") {
                                show = "Y"
                            }
                            break;
                        case "Sketch Species":
                            if (sketchSpecies == "Y") {
                                show = "Y"
                            }
                            break;
                        case "Notable Species":
                            if (notableSpecies == "Y") {
                                show = "Y"
                            }
                            break;
                        default:
                            show = "Y"
                    }

                    if (show == "Y") {
                        // Add the line graphic to the view's GraphicsLayer
                        view.graphics.add(pointGraphic);
                    }

                }
            }
}
    
        );

