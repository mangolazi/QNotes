import QtQuick 1.1
import com.nokia.symbian 1.1
import "globalvars.js" as Globalvars
import "dbcore.js" as DBcore
import SqlQueryModel 1.0

// add new category
Item {

CommonDialog {
    id: addCategoryDialog
    titleText: "Enter new category"
    buttonTexts: ["OK", "Cancel"]
    content: TextField {
        id: textCategory
        width: parent.width
        anchors.fill: parent
        anchors.margins: 10
        maximumLength: 50
        font.bold: true
        font.pixelSize: 24
        placeholderText: "New category..."
    }

    Component.onCompleted: open()

    onButtonClicked: {
        if (!index) { // OK button pressed
            if (textCategory.text == "" || textCategory.text == " ") { // empty input
                emptyInputDialog.open()
                close()
            }
            else { // valid input, insert category and reload category list
                sqlCategory.insertCategory(textCategory.text);
                notesPage.prop_sqlCategory.setQuery(DBcore.readCategoryList());
                close()
            }
        }
        else { // cancel button pressed
            close()
        }
    }

    // empty dialog, for empty text
    QueryDialog {
        id: emptyInputDialog
        titleText: "Empty input"
        message: "Please enter a value.\n"
        acceptButtonText: "OK"
        onAccepted: {
            close()
        }
    }

    // SQL model
    SqlQueryModel {
        id: sqlCategory
    }

}// end component

} // end item
