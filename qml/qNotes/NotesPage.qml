/* Copyright © mangolazi 2012.
This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore
import SqlQueryModel 1.0

Page {
    id: notesPage
    tools: mainToolbar
    property int noteId
    property bool newNote : false
    property bool edited : false
    property alias prop_sqlCategory : sqlCategory
    property alias prop_title : textTitle.text
    property alias prop_category : categoryList.title
    property alias prop_notetext : textNote.text

    // SQL objects
    SqlQueryModel {
        id: sqlNoteItem
    }
    SqlQueryModel {
        id: sqlCategory
    }

    // Dialog loaders for non-quitting dialogs
    Loader { id: addCategoryDialogLoader  }
    Loader { id: exportDialogLoader  }

    // Default toolbar
    ToolBarLayout {
        id: mainToolbar

        ToolButton {
            id: toolbarbtnBack
            flat: true
            iconSource: "toolbar-back"
            onClicked: {
                if (textTitle.text == "" || textNote.text == "" || categoryList.title == "") {
                    emptyDialog.open()
                }
                else if (newNote == true) {
                    saveNewNote()
                    window.pageStack.pop()
                }
                else if (edited == true) {
                    saveDialog.open()
                }
                else {
                    window.pageStack.pop()
                }
            }
        }

        // Delete note
        ToolButton {
            id: toolbarbtnDelete
            flat: true
            checkable: false
            iconSource: "toolbar-delete"
            onClicked: delDialog.open()
        }

        // Main menu button
        ToolButton {
            id: toolbarbtnMenu
            flat: true
            checkable: false
            iconSource: "toolbar-menu"
            onClicked: actionMenu.open()
        }
    }  

    // Main menu
    Menu {
         id: actionMenu
         MenuLayout {
             MenuItem {
                 text: "Export to file"
                 onClicked: {
                     exportDialogLoader.source = ""
                     exportDialogLoader.source = "ExportFileDialog.qml"
                 }
             }
             MenuItem {
                 text: "Add category"
                 onClicked: {
                     addCategoryDialogLoader.source = ""
                     addCategoryDialogLoader.source = "AddCategory.qml"
                 }
             }
         }
     }

    // save dialog, new 3 options
    CommonDialog {
        id: saveDialog
        titleText: "Save changes and close?"
        buttonTexts: ["Save", "Edit...", "Close"]
        content: Text {
            width: parent.width
            height: 60
            anchors.fill: parent
            anchors.margins: 10
            font.pixelSize: 18
            color: "white"
            text: "Save changes and close, continue editing or close without saving."
            wrapMode: Text.Wrap
        }
        onButtonClicked: {
            if (index == 0) { // save
                saveExistingNote()
                close()
                window.pageStack.pop()
            }
            else if (index == 1) { // keep editing
                close()
            }
            else if (index == 2) { // close without saving
                close()
                window.pageStack.pop()
            }
        }
    }

    // delete dialog
    QueryDialog {
        id: delDialog
        titleText: "Delete note?"
        message: "Note \"" + textTitle.text + "\" will be deleted.\n"
        acceptButtonText: "Delete"
        rejectButtonText: "Cancel"
        onAccepted: {
            sqlNoteItem.deleteNotes(noteId)
            close()
            window.pageStack.pop()
        }
        onRejected: {
            close()
        }
    }

    // empty dialog, for empty text
    QueryDialog {
        id: emptyDialog
        titleText: "Continue editing?"
        message: "Title, category or note text are empty. Continue editing or close note without saving.\n"
        acceptButtonText: "Edit..."
        rejectButtonText: "Close"
        onAccepted: {
            close()
        }
        onRejected: {
            close()
            window.pageStack.pop()
        }
    }

    // MAIN TEXT FIELDS
    // note title loaded here
    TextField {
        id: textTitle
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width * 0.6
        anchors.bottom: textNote.top
        maximumLength: 50
        font.bold: true
        font.pixelSize: 22
        placeholderText: "Title..."
        onActiveFocusChanged: edited = true
    }

    // category list loaded here
    SelectionListItem {
             id: categoryList
             anchors.top: parent.top
             anchors.left: textTitle.right
             anchors.right: parent.right             
             enabled: true
             title: "Category..."
             onClicked: {
                 selectionDialog.open()
                 edited = true
             }
             SelectionDialog {
                 id: selectionDialog
                 titleText: "Select a note category"
                 delegate: selectionDialogDelegate
             }
    }

    Component {
            id: selectionDialogDelegate
            MenuItem {
                text: category
                onClicked: {
                    selectedIndex = index
                    categoryList.title = category
                    root.accept()
                }
            }
        }

    // main note text
    TextArea {
        id: textNote
        anchors.top: categoryList.bottom
        anchors.bottom: splitViewInput.top
        anchors.left: parent.left
        anchors.right: parent.right
        textFormat: TextEdit.PlainText
        font.pixelSize: 24
        font.bold: true
        placeholderText: "Enter note text..."
        onActiveFocusChanged: edited = true
    }

    // handle split input changing textarea
    Item {
        id: splitViewInput
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        height: inputContext.visible ? inputContext.height-50 : 0

        states: [
            State {
                name: "VisiblePortrait"; when: (inputContext.visible && textNote.focus && screen.currentOrientation == Screen.Portrait )
                PropertyChanges { target: splitViewInput; height: inputContext.height-50 }
                PropertyChanges { target: textTitle; height: 0}
                PropertyChanges { target: categoryList; height: 0}
            },
            State {
                name: "VisibleLandscape"; when: (inputContext.visible && textNote.focus && screen.currentOrientation == Screen.Landscape )
                PropertyChanges { target: splitViewInput; height: inputContext.height }
                PropertyChanges { target: textTitle; height: 0}
                PropertyChanges { target: categoryList; height: 0}
            },
            State {
                name: "Hidden"; when: !inputContext.visible               
                PropertyChanges { target: splitViewInput; height: 0 }
                PropertyChanges { target: textTitle; height: 60}
                PropertyChanges { target: categoryList; height: 60}
            }
        ]
    }

    onStatusChanged: {
        if ( status == PageStatus.Activating  ) {
            sqlCategory.setQuery(DBcore.readCategoryList());
            selectionDialog.model = sqlCategory;
            if (newNote == true) {
                // new note setup
                toolbarbtnDelete.visible = false
                categoryList.title = "Category..."
            }
            else {
                // existing note loading
                sqlNoteItem.setQuery(DBcore.readNotesItem(noteId));
                textTitle.text = sqlNoteItem.datasingle("title");
                textNote.text = sqlNoteItem.datasingle("note");
                categoryList.title = sqlNoteItem.datasingle("category");
            }
        }
    }

    // Function to save new note
    function saveNewNote() {
        var datesave = new Date();
        sqlNoteItem.insertNotes(textTitle.text, categoryList.title, textNote.text, datesave, Qt.formatDate(datesave, Qt.SystemLocaleShortDate));
    }

    // Function to save existing note
    function saveExistingNote() {
        var datesave = new Date();
        sqlNoteItem.updateNotes(textTitle.text, categoryList.title, textNote.text, datesave, Qt.formatDate(datesave, Qt.SystemLocaleShortDate), noteId);
    }

} // End page
