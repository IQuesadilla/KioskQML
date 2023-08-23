

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    id: page
    property alias button: button
    property alias textArea: textArea
    property alias textField: textField
    property alias flickable: flickable

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Flickable {
            id: flickable
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            flickableDirection: Flickable.VerticalFlick
            contentHeight: textArea.height

            ScrollBar.vertical: ScrollBar {
                id: scrollbar
            }

            TextArea {
                id: textArea
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                wrapMode: Text.WrapAnywhere
                width: flickable.width - scrollbar.width
                readOnly: true
            }
        }

        Pane {
            id: pane
            padding: 0
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                TextField {
                    id: textField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: qsTr("Text Field")
                }

                Button {
                    id: button
                    text: qsTr("Enter")
                    layer.enabled: textField.length > 0
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }
        }
    }
}
