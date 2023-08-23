import QtQuick 2.15

TerminalForm {
    button.onClicked: sendInput()
    textArea.text: myShell.text

    Keys.onPressed: (event)=> {
        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            sendInput();
            event.accepted = true;
        }
    }

    function sendInput()
    {
        myShell.buttonPressed(textField.text);
        textField.text = "";
        //flickable.contentY = flickable.contentHeight;
    }
}
