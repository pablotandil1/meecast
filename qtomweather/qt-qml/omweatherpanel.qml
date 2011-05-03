import Qt 4.7
import MeeGo.Components 0.1
import MeeGo.Panels 0.1
import MeeGo.Sharing 0.1
import MeeGo.Media 0.1

FlipPanel {
    id: container

    Translator {
        catalog: "meego-ux-panels-omweather"
    }

    front: SimplePanel {
        id: frontPanel
        panelTitle: qsTr("OMWeather")
        panelComponent: frontPanelContent
        leftIconSource: "image://theme/panels/pnl_icn_photos"
    }

    back: BackPanelGeneric {
        id: backPanel
        panelTitle: qsTr("OMWeather back")
        bpContent: backPanelContent
        isBackPanel: true
        leftIconSource: "image://theme/panels/pnl_icn_photos"
    }
    Component {
        id: frontPanelContent
        Item {
            id: frontItemOmweather
            anchors.fill: parent

            Loader {
                id: uiloader

                function handleGoBack()
                {
                    source = "";
                    list.visible = true;
                }
                onItemChanged: {
                    if (item && item.goBack)
                        item.goBack.connect(handleGoBack);
                }
            }

            XmlListModel {
                id: currentxmlModel
                source: "datanew.xml"
                query: "/data/item[@current='true']"

                XmlRole {name: "dayname"; query: "dayname/string()"}
                XmlRole {name: "temperature_low"; query: "temperature_low/string()"}
                XmlRole {name: "temperature_high"; query: "temperature_hi/string()"}
                XmlRole {name: "temperature"; query: "temperature/string()"}
                XmlRole {name: "icon"; query: "icon/string()"}
                XmlRole {name: "wind_speed"; query: "wind_speed/string()"}
                XmlRole {name: "wind_direction"; query: "wind_direction/string()"}
                XmlRole {name: "humidity"; query: "humidity/string()"}
                XmlRole {name: "description"; query: "description/string()"}
                XmlRole {name: "id_item"; query: "@id/number()"}
                XmlRole {name: "current"; query:  "@current/boolean()"}
            }
            Item {
                Text {text:  count(currentxmlModel)}
            }

            XmlListModel {
                id: xmlModel
                source: "datanew.xml"
                query: "/data/item"

                XmlRole {name: "dayname"; query: "dayname/string()"}
                XmlRole {name: "temperature_low"; query: "temperature_low/string()"}
                XmlRole {name: "temperature_high"; query: "temperature_hi/string()"}
                XmlRole {name: "temperature"; query: "temperature/string()"}
                XmlRole {name: "icon"; query: "icon/string()"}
                XmlRole {name: "wind_speed"; query: "wind_speed/string()"}
                XmlRole {name: "wind_direction"; query: "wind_direction/string()"}
                XmlRole {name: "humidity"; query: "humidity/string()"}
                XmlRole {name: "description"; query: "description/string()"}
                XmlRole {name: "id_item"; query: "@id/number()"}
                XmlRole {name: "current"; query:  "@current/boolean()"}
            }
            Component {
                id: itemDelegate
                Item {
                    id: day

                    width: list.cellWidth
                    height: list.cellHeight

                    Rectangle {
                        id: background_part
                        anchors.fill: parent
                        color: "#008080"


                    }
                    Text {text:  id_item}
                    Text {
                        id: day_name
                        text: dayname
                        color: "white"
                        font.pointSize: 14
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        //anchors.centerIn: parent
                        //anchors.top: parent.top
                    }

                    Image {
                        id: forecast_icon
                        source: icon
                        width: 80
                        height: 80
                        anchors.top: day_name.bottom
                        //anchors.topMargin: 20
                        //anchors.leftMargin: 5
                        anchors.left: parent.left
                    }
                    Text {
                        id: temp
                        text: (temperature) ? temperature : (temperature_low + " : " + temperature_high)
                        anchors.top: forecast_icon.top; anchors.topMargin: 10
                        anchors.left: forecast_icon.right; anchors.leftMargin: 10
                        color: "white"
                        font.pointSize: 14
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            uiloader.source = "Details.qml";
                            list.visible = false;
                            uiloader.item.item_id = id_item;
                        }
                        hoverEnabled: true

                    }

                }

            }

            GridView {
                id: list
                anchors.fill: parent
                cellWidth: parent.width/2; cellHeight: 120
                model: xmlModel
                delegate: itemDelegate

            }
        }
    }
    Component {
        id: backPanelContent
        Text {
            anchors.fill: parent
            text: "back omweather"
        }
    }
}
