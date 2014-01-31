import QtQuick 1.1
import com.nokia.symbian 1.1
import ExportFile 1.0

// export note to file
Item {

    // Text file object
    ExportFile {
        id: exportObj
        intID: 0
    }

    // export dialog
    QueryDialog {
        id: exportDialog
        titleText: "Export note to text file?"
        message: "Note will be exported and existing file will be overwritten.\n"
        acceptButtonText: "Export"
        rejectButtonText: "Cancel"
        Component.onCompleted: open()
        onAccepted: {
            var datesaved = new Date();
            exportObj.fileName = "E:/QNOTESDB/" + notesPage.prop_title + ".txt"
            console.log(exportObj.fileName)
            console.log(exportObj.noteText)
            exportObj.noteText = notesPage.prop_title + "\n\n" + notesPage.prop_category + "\n" + Qt.formatDate(datesaved, Qt.SystemLocaleShortDate) + "\n\n" + notesPage.prop_notetext;
            if (exportObj.saveFile() == true)
            {
                savefileDialog.titleText = "Note exported successfully"
                savefileDialog.message = "Saved to " + exportObj.fileName + "\n"
            }
            else
            {
                savefileDialog.titleText = "Cannot export note"
                savefileDialog.message = "Sorry, note cannot be exported due to some problem..."
            }
            savefileDialog.open()
        }
        onRejected: {
            close()
        }
    }

    // export file saved dialog, sucessful or failed
    QueryDialog {
        id: savefileDialog
        titleText: ""
        message: ""
        acceptButtonText: "OK"
        onAccepted: {
            close()
            exportDialog.close()
        }
    }

} // end item
