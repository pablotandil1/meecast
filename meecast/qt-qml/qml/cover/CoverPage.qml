import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.meecast.meecastcover 1.0


CoverBackground {
    id: coverPage
    property bool active: status == Cover.Active || applicationActive;
    property bool isUpdate: false
    anchors.fill: parent

    function current_model(name){
        return Current.getdata(0, name);
    }
    function current_temperature(){
        if (coverPage.current_model("temp") == undefined){
            temp_text.text = ""
            return;
        }
        if (coverPage.current_model("temp") == "N/A"){
            temp_text.text = ""
            if (coverPage.current_model("temp_high") != "N/A")
               temp_text.text =  coverPage.current_model("temp_high") + '°'
            if ((coverPage.current_model("temp_low")  != "N/A") && (coverPage.current_model("temp_high") != "N/A"))
               temp_text.text =  temp_text.text + "\n"
            if (coverPage.current_model("temp_low") != "N/A")
               temp_text.text = temp_text.text + coverPage.current_model("temp_low") + '°'
            if (coverPage.current_model("temp_high") != undefined && coverPage.current_model("temp_high") != "N/A") 
                background_rect.color = getColor(coverPage.current_model("temp_high"));
            else
                if (coverPage.current_model("temp_low") != undefined && coverPage.current_model("temp_low") != "N/A") 
                    background_rect.color = getColor(coverPage.current_model("temp_low"));
        }else{
           temp_text.text = coverPage.current_model("temp") + '°'
           background_rect.color = getColor(coverPage.current_model("temp"));
        }
    }
    function getColor(t){
        var c1, c2, c3;
        if (Config.temperatureunit == "F"){
            t = (t - 32) * 5 / 9;
        }
        if (t >= 30){
            c2 = (t - 50)*(246/255-60/255)/(30-50) + 60/255;
            return Qt.rgba(1, c2, 0, 1);
        }else if (t < 30 && t >= 15){
            c1 = (t - 30)*(114/255-1)/(15-30) + 1;
            c2 = (t - 30)*(1-246/255)/(15-30) + 246/255;
            return Qt.rgba(c1, c2, 0, 1);
        }else if (t < 15 && t >= 0){
            c1 = (t - 15)*(1-114/255)/(0-15) + 144/255;
            c3 = (t - 15)*(1-0)/(0-15) + 0;
            return Qt.rgba(c1, 1, c3, 1);
        }else if (t < 0 && t >= -15){
            c1 = (t - 0)*(0-1)/(-15-0) + 1;
            c2 = (t - 0)*(216/255-1)/(-15-0) + 1;
            return Qt.rgba(c1, c2, 1, 1);
        }else if (t < -15 && t >= -30){
            c2 = (t - (-15))*(66/255-216/255)/(-30+15) + 216/255;
            //console.log(t+ " "+c2);
            return Qt.rgba(0, c2, 1, 1);
        }else if (t < -30){
            c1 = (t - (-30))*(132/255-0)/(-30+15) + 0;
            c2 = (t - (-30))*(0-66/255)/(-30+15) + 66/255;
            return Qt.rgba(c1, c2, 1, 1);
        }
    }
    function getAngle(s){
        var a;

        switch (s){
        case 'S':
            return 0;
        case 'SSW':
            return 22.5;
        case 'SW':
            return 45;
        case 'WSW':
            return (45+22.5);
        case 'W':
            return 90;
        case 'WNW':
            return (90+22.5);
        case 'NW':
            return (90+45);
        case 'NNW':
            return (180-22.5);
        case 'N':
            return 180;
        case 'NNE':
            return (180+22.5);
        case 'NE':
            return (180+45);
        case 'ENE':
            return (270-22.5);
        case 'E':
            return 270;
        case 'ESE':
            return (270+22.5);
        case 'SE':
            return (270+45);
        case 'SSE':
            return (360-22.5);

        }

    }

    MeeCastCover {
        status: coverPage.active
    }
    Connections {
        target: Config
        onConfigChanged: {
    //        Current.reload_data(Config.filename);
    //        Current.update_model(0);

            stationname.text = Config.stationname
            current_temperature()
            temp.text.bold = current_model("current")
            now.visible = current_model("current")
            icon.source = Config.iconspath + "/" + Config.iconset + "/" + coverPage.current_model("pict")
            if (coverPage.current_model("description") != undefined)
                description.text = coverPage.current_model("description")
            else
                description.text = ""
            source_image.source = Config.stationname == "Unknown" ? "" : Config.imagespath + "/" + Config.source + ".png"
            if (Config.stationname == "Unknown") {
                description.text = Config.tr("No locations are set up yet.")
            }else {
            if (Current.rowCount() == 0) {
                    description.text = Config.tr("Looks like there's no info for this location.")}
                else{
                    description.text = current_model("description")
                }
            }
            if (description.text.length < 31)
                if (description.text.length < 10)
                    description.font.pointSize = 32
                else 
                    if (description.text.length < 20)
                        description.font.pointSize = 25
                    else
                        description.font.pointSize = 20
            else
                description.font.pointSize = 16
//            lastupdate.text = current_model("lastupdate")
          //  lastupdate.text = Config.tr("Last update:") + "\n" + current_model("lastupdatetime")
            lastupdate.text = Config.tr("Last update:") + " " + current_model("lastupdatetime")
            console.log(Config.logocoverpage)
            if (Config.logocoverpage)
                source_image.visible = true
            else
                source_image.visible = false
            if (Config.windcoverpage){
                icon.width = 100
                icon.height = 100
                if (coverPage.current_model("wind_speed") != undefined && coverPage.current_model("wind_speed") != "N/A"){
                    wind_speed_text.text = (Config.windspeedunit == "Beaufort scale") ? coverPage.current_model("wind_speed") : coverPage.current_model("wind_speed") + ' ' + Config.tr(Config.windspeedunit)
                    wind_speed_text.visible = true
                    wind_speed_icon.visible = true
                    description.anchors.top = wind_speed_icon.bottom
                }else{
                    wind_speed_text.visible = false
                    wind_speed_icon.visible = false
                    description.anchors.top = icon.bottom
                }
                if (coverPage.current_model("wind_direction") != undefined && coverPage.current_model("wind_direction") != "N/A"){
                    wind_direction_background.visible = true
                    wind_direction.visible = true
                    wind_text.visible = true
                    wind_text.text = Config.tr(current_model("wind_direction"))
                    description.anchors.top = wind_text.bottom
                }else{
                    wind_direction_background.visible = false
                    wind_direction.visible = false
                    wind_text.visible = false
                }
            }else{
                icon.width = 128
                icon.height = 128
                wind_speed_text.visible = false
                wind_speed_icon.visible = false
                wind_direction_background.visible = false
                wind_direction.visible = false
                wind_text.visible = false
                description.anchors.top = icon.bottom
            }

            isUpdate = false;
        }
    }
    Rectangle {
        id: background_rect
        anchors.fill: parent
        opacity: 0.1
        color: "white"
    }
    Image {
        source: Config.imagespath + "/cover.png"
        opacity: 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }
    Label {
        id: stationname
        visible: isUpdate ? false : true
        anchors.top: parent.top
//        anchors.topMargin: Theme.paddingMedium
        anchors.horizontalCenter: parent.horizontalCenter
        text: Config.stationname == "Unknown" ? "MeeCast" : Config.stationname
        font.pixelSize: text.length > 20 ? 24 : 35 
    }
    Text {
        id: now
        width: parent.width/2  
        height: 30
        anchors.top: stationname.top
        anchors.right: parent.right
        color: "white"
        visible: current_model("current")
        text: current_model("current") == true ? Config.tr("Now") : Config.tr("Today")
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: temp_text
        visible: Config.stationname == "Unknown" || isUpdate  ? false : true
        anchors.top: stationname.bottom
        anchors.right: parent.right 
        anchors.topMargin: 5 
        anchors.rightMargin: 0 
        anchors.leftMargin: 0 
        anchors.bottomMargin: 15 
        anchors.left: icon.right
        wrapMode:  TextEdit.WordWrap
        height: 108 
        color: "white"
        text: Current.temp + '°'
        font.pointSize: 42 
        font.bold: current_model("current")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Component.onCompleted: { current_temperature()}
    }
    Image {
        id: icon
        visible: isUpdate ? false : true
        source: (Config.stationname == "Unknown" || Current.rowCount() == 0) ? Config.iconspath + "/" + Config.iconset + "/49.png" : Config.iconspath + "/" + Config.iconset + "/" + coverPage.current_model("pict") 
        width:  Config.windcoverpage ? 128 : 100
        height: Config.windcoverpage ? 128 : 100
        anchors.top: stationname.bottom
        anchors.topMargin: 5 
        smooth: true
    }
    Image {
        id: wind_speed_icon
        anchors.leftMargin: Theme.paddingSmall
        visible: Config.windcoverpage && !isUpdate && coverPage.current_model("wind_speed") != undefined && coverPage.current_model("wind_speed") != "N/A" 
        source: Config.imagespath + "/wind_speed.png"
        anchors.top: icon.bottom
        //anchors.topMargin: -20
        anchors.left: parent.left
        width: 30
        height: 30
        smooth: true
    }
    Text {
        id: wind_speed_text
        text: (Config.windspeedunit == "Beaufort scale") ? coverPage.current_model("wind_speed") : coverPage.current_model("wind_speed") + ' ' + Config.tr(Config.windspeedunit)
        visible: Config.windcoverpage && !isUpdate && coverPage.current_model("wind_speed") != undefined && coverPage.current_model("wind_speed") != "N/A"
        anchors.top: icon.bottom
       // anchors.topMargin: -20
        anchors.left: wind_speed_icon.right
        anchors.leftMargin: 3
        height: 30
        color: "white"
        font.pointSize: 14
        verticalAlignment: Text.AlignVCenter
    }
    Image {
        id: wind_direction_background
        visible: Config.windcoverpage && !isUpdate && coverPage.current_model("wind_direction") != "N/A"
        //source: Config.imagespath + "/wind_direction.png"
        source: Config.imagespath + "/wind_direction_background.png"
        anchors.top: icon.bottom
        anchors.right: wind_text.left
        anchors.rightMargin: 8
       // anchors.topMargin: -20
//        anchors.left: parent.left
 //       anchors.leftMargin: margin + main.width/2
        width: 30
        height: 30
        smooth: true
    }
    Image {
        id: wind_direction
        visible: Config.windcoverpage && !isUpdate && coverPage.current_model("wind_direction") != "N/A"
        //source: Config.imagespath + "/wind_direction.png"
        source: Config.imagespath + "/wind_direction_arrow.png"
        anchors.top: icon.bottom
        //anchors.topMargin: -20
        anchors.right: wind_text.left
        anchors.rightMargin: 8
        width: 30
        height: 30
        smooth: true
        transform: Rotation {
            id : transform
            origin.x: 15
            origin.y: 15
            angle: current_model("wind_direction") == "N/A" ? 0 : coverPage.getAngle(current_model("wind_direction"))
        }
    }
    Text {
        id: wind_text
        visible: Config.windcoverpage && !isUpdate && coverPage.current_model("wind_direction") != "N/A"
        text: Config.tr(current_model("wind_direction"))
        //anchors.left: wind_direction.right
        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingSmall
        anchors.top: icon.bottom
        //anchors.topMargin: -20
        height: 30
        color: "white"
        font.pointSize: 18
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: description
        visible: isUpdate ? false : true
        anchors.top: Config.windcoverpage ? wind_direction.bottom : icon.bottom
        width: parent.width 
        height: 135 
        elide : Text.ElideRight
        color: "white"
        wrapMode:  TextEdit.WordWrap
        text: Config.stationname == "Unknown" ? Config.tr("No locations are set up yet.") : (Current.rowCount() == 0) ? "Looks like there's no info for this location." : current_model("description")
        font.pointSize: text.length < 20 ? 25 : 16
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Label {
        id: lastupdate 
        //anchors.bottom: source_image.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        visible: isUpdate ? false : true
        anchors.horizontalCenter: parent.horizontalCenter
        text: current_model("lastupdate")
        font.pixelSize: 21 
    }

    Image {
        visible: (Config.logocoverpage && !isUpdate)  ? true : false
        id: source_image 
        source: Config.stationname == "Unknown" ? "" : Config.imagespath + "/" + Config.source + ".png"
        anchors.bottom: lastupdate.top
        anchors.top: description.bottom 
        anchors.topMargin: 15
        //anchors.bottom: parent.bottom
       // height: 40 
       width: 80
    //    anchors.top: description.bottom
        smooth: true    
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
    //    anchors.verticalCenter: parent.verticalCenter
      //  scale: 0.8
    }
    Label {
        id: title
        visible: isUpdate ? true : false
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingMedium
        anchors.horizontalCenter: parent.horizontalCenter
        text: "MeeCast" 
        font.pixelSize: 35 
    }

    Image {
        id: refresh_image
        source: "image://theme/icon-cover-refresh"
        anchors.top: parent.top 
        anchors.topMargin: 80 
        visible: isUpdate ? true : false
        anchors.horizontalCenter: parent.horizontalCenter
        width: 100
        height: 100
        RotationAnimation on rotation {
            duration: 2000; 
            loops: Animation.Infinite; 
            running : isUpdate ? active : false
            from: 0; to: 360
        }
    }

    Text {
        text: Config.tr("Updating forecast")
        horizontalAlignment: Text.AlignHLeft; 
        anchors.top: parent.top 
        anchors.topMargin: 190 
        //anchors.centerIn: parent
        visible: isUpdate ? true : false
        font.pointSize: 20; 
        NumberAnimation on x { 
            id: text_anim; 
            from: 250; to: -300; 
            duration: 7000; 
            loops: Animation.Infinite; 
            running : isUpdate ? active : false
        }  
    }

    CoverActionList {
        id: ordinary
        enabled: isUpdate ? false : true
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: { Config.changestation();}
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                Config.updatestations(); 
                isUpdate = true;  
                wind_speed_text.visible = false
                wind_speed_icon.visible = false
                wind_direction_background.visible = false
                wind_direction.visible = false
                wind_text.visible = false
            }
        }
    }
}
