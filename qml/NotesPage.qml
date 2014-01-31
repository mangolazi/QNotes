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
import "globalvars.js" as Globalvars
import "dbcore.js" as DBcore


Page {
    id: notesPage
    tools: mainToolbar
    property int noteId
    property bool createNewNote : false
    property bool edited : false


    // Default toolbar
    ToolBarLayout {
        id: mainToolbar       
        //opacity: !inputContext.visible
        //Behavior on opacity { PropertyAnimation { duration: 200 } }

        ToolButton {
            id: toolbarbtnBack
            flat: true
            iconSource: "toolbar-back"
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: {
                // save new note directly
                // 1: no title text, error dialog, can exit
                // 2: new note, save directly
                // 3: old note, ask to save
                // 4: no edit, exit immediately
                if (textTitle.text == "") {
                    emptyDialog.open()
                }
                else if (Globalvars.newNote == true) {
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

        // Enable or disable editing
        ToolButton {
            id: toolbarbtnEdit
            flat: false
            checkable: true
            checked: false
            visible: (Globalvars.newNote == true) ? false : true
            //text: "Edit"
            iconSource: (checked == true) ? "save.svg" : "edit.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            onCheckedChanged:
             {
                if (toolbarbtnEdit.checked == true) {
                    textTitle.readOnly =  false
                    textNote.readOnly = false
                    categoryList.enabled = true
                    edited = true
                }
                else {
                    textNote.readOnly = true
                    textTitle.readOnly = true
                    categoryList.enabled = false
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


    }  


    // save dialog
    QueryDialog {
        id: saveDialog
        titleText: "Save changes and exit?"
        message: "Changes to the current note will be saved.\n"
        acceptButtonText: "OK"
        rejectButtonText: "Cancel"
        onAccepted: {            
            saveExistingNote()
            close()
            window.pageStack.pop()
        }
        onRejected: {
            close()
            window.pageStack.pop()
        }
    }   

    // delete dialog
    QueryDialog {
        id: delDialog
        titleText: "Delete note?"
        message: "Current note will be deleted.\n"
        acceptButtonText: "OK"
        rejectButtonText: "Cancel"
        onAccepted: {
            //DBcore.deleteNotes(Globalvars.noteId)
            DBcore.deleteNotes(noteId)
            close()
            window.pageStack.pop()
        }
        onRejected: {
            close()
        }
    }

    QueryDialog {
        id: emptyDialog
        titleText: "Close note?"
        message: "Close current note without saving.\n"
        acceptButtonText: "OK"
        rejectButtonText: "Cancel"
        onAccepted: {
            close()
            window.pageStack.pop()
        }
        onRejected: {
            close()            
        }
    }


    // note title loaded here
    TextField {
        id: textTitle
        anchors.right: parent.right
        anchors.verticalCenter: undefined
        anchors.top: categoryList.bottom
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.rightMargin: 1
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        maximumLength: 50
        readOnly: true
        font.bold: true
        font.pixelSize: 24
        placeholderText: "Enter title..."
        states: [
            State {
                name: "Hidden";
                PropertyChanges { target: textTitle; visible: false }
            }
            ,
            State {
                name: "LANDSCAPE"; //when: (screen.currentOrientation == Screen.Landscape)
                AnchorChanges { target: textTitle; anchors.top: parent.top }
                AnchorChanges { target: textTitle; anchors.right: parent.horizontalCenter }
                AnchorChanges { target: textTitle; anchors.verticalCenter: categoryList.verticalCenter}
            },
            State {
                name: "PORTRAIT"; //when: (screen.currentOrientation == Screen.Portrait)
                AnchorChanges { target: textTitle; anchors.top: categoryList.bottom }
                AnchorChanges { target: textTitle; anchors.right: parent.right }
                AnchorChanges { target: textTitle; anchors.verticalCenter: undefined }
                //AnchorChanges { target: textTitle; anchors.right: parent.right }
            }

        ]
    }


    // category list loaded here
    SelectionListItem {
             id: categoryList
             anchors.top: parent.top
             //anchors.left: parent.horizontalCenter
             anchors.left: parent.left
             anchors.right: parent.right
             anchors.leftMargin: 1
             anchors.rightMargin: 1
             visible: true
             enabled: true
             title: selectionDialog.selectedIndex >= 0
                       ? selectionDialog.model.get(selectionDialog.selectedIndex).category
                       : "Category..."

             onClicked: selectionDialog.open()

             SelectionDialog {
                 id: selectionDialog
                 titleText: "Select a note category"
                 //selectedIndex: -1
                 model: categoryListModel
                 onAccepted: {
                     //DBcore.category = selectionDialog.model.get(selectionDialog.selectedIndex).category
                     console.log("selected " + selectionDialog.model.get(selectionDialog.selectedIndex).category)
                     // last element selected
                     if (selectionDialog.selectedIndex == categoryListModel.count - 1) {
                         console.log("Add category bub")
                         addCategoryDialog.open()
                     }
                 }
             }

             states: [
                 State {
                     name: "Hidden"
                     PropertyChanges { target: categoryList; visible: false}
                     //AnchorChanges { target: textNote; anchors.bottom: splitViewInput.top}
                 }
                 ,
                 State {
                     name: "LANDSCAPE"; //when: (screen.currentOrientation == Screen.Landscape)
                     AnchorChanges { target: categoryList; anchors.top: parent.top }
                     AnchorChanges { target: categoryList; anchors.left: parent.horizontalCenter }
                 },
                 State {
                     name: "PORTRAIT"; //when: (screen.currentOrientation == Screen.Portrait )
                     AnchorChanges { target: categoryList; anchors.top: parent.top }
                     AnchorChanges { target: categoryList; anchors.left: parent.left }
                 }
             ]
         }

    ListModel {
        id: categoryListModel
    }

    CommonDialog {
        id: dialog
        titleText: "Title text"
        titleIcon: "list4.svg"
        buttonTexts: ["OK", "Cancel"]
        content: Rectangle {
            width: 300
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#30ff0000" // this makes the margins visible on the ui
            Grid {
                id: grid

                property int itemWidth: (width - platformStyle.paddingSmall) / 2
                property int itemHeight: (height - platformStyle.paddingSmall) / 2

                anchors.fill: parent
                anchors.margins: platformStyle.paddingMedium
                spacing: platformStyle.paddingSmall
                columns: 2

                Rectangle { color: "red"; width: grid.itemWidth; height: grid.itemHeight }
                Rectangle { color: "blue"; width: grid.itemWidth; height: grid.itemHeight }
                Rectangle { color: "green"; width: grid.itemWidth; height: grid.itemHeight }
                Rectangle { color: "yellow"; width: grid.itemWidth; height: grid.itemHeight }
            }
        }

    }


    // dialog to add categories
    Dialog {
        id: addCategoryDialog
        title: Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            text: "Add new category"
            font.pixelSize: 24
            color: "lightblue"
        }
        content: TextField {
            id: newCategory
            width: parent.width
            anchors.margins: 10
            maximumLength: 50
            font.bold: true
            font.pixelSize: 24
            placeholderText: "Enter new category..."
        }
        buttons: [
            Button {
                text: "OK"
                width: 150
                anchors.right: parent.horizontalCenter
                anchors.margins: 10
                onClicked: {
                    addCategoryDialog.close()
                    categoryListModel.remove(categoryListModel.count - 1)
                    categoryListModel.append({"category": newCategory.text});
                    console.log("Adding new category " + newCategory.text)
                    categoryListModel.append({"category": "Add new category..."});
                    selectionDialog.model = categoryListModel;
                    //selectionDialog.selectedIndex = categoryListModel.count - 2
                    categoryList.title = newCategory.text
                }
            },
            Button {
                text: "Cancel"
                width: 150
                anchors.left: parent.horizontalCenter
                anchors.margins: 10
                onClicked: {
                    addCategoryDialog.close()
                    selectionDialog.selectedIndex = -1
                }
            }
        ]
    }


    // main note text
    TextArea {
        id: textNote
        anchors.top: textTitle.bottom
        //anchors.top: categoryList.bottom
        anchors.topMargin: 5
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: splitViewInput.top
        //anchors.bottom: categoryList.top
        anchors.bottomMargin: 5
        width: parent.width
        textFormat: TextEdit.PlainText
        readOnly: false
        font.pixelSize: 24
        placeholderText: "Enter note text..."
        //Behavior on height { PropertyAnimation { duration: 200 } }
        states: [
            State {
                name: "Visible"; when: (inputContext.visible && textNote.focus == true)
                AnchorChanges { target: textNote; anchors.top: parent.top}
                //AnchorChanges { target: textNote; anchors.bottom: splitViewInput.top}
            }
        ]
    }


    // handle split input changing textarea
    Item {
        id: splitViewInput
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        //Behavior on height { PropertyAnimation { duration: 200 } }
        height: inputContext.visible ? inputContext.height-40 : 0

        states: [
            State {
                name: "Visible"; when: inputContext.visible                
                PropertyChanges { target: splitViewInput; height: inputContext.height-40 }
            },
            State {
                name: "Hidden"; when: !inputContext.visible               
                PropertyChanges { target: splitViewInput; height: 0 } //mainToolbar.height }
            }
        ]
    }

    onStatusChanged: {
        if ( status === PageStatus.Activating  ) {
            DBcore.readCategoryList(categoryListModel);
            categoryListModel.append({"category": "Add new category..."});
            selectionDialog.model = categoryListModel;

            if (Globalvars.newNote == true) {
                // new note setup
                toolbarbtnEdit.checked = true
                textTitle.readOnly = false
                textNote.readOnly = false                
                categoryList.enabled = true
                toolbarbtnEdit.checked = true
            }
            else {
                // existing note loading
                loadNote()
                textTitle.readOnly = true
                textNote.readOnly = true
                categoryList.enabled = false
                edited = false
                toolbarbtnEdit.checked = false
            }
        }
    }


    // Function to load note text from db into widgets
    function loadNote() {
        console.log("Loading note")
        var noteitem;
        //noteitem =  DBcore.readNotesItem(Globalvars.noteId);
        noteitem =  DBcore.readNotesItem(noteId);
        textTitle.text = noteitem.title
        textNote.text = noteitem.note

        // find matching category
        // YES THIS WORKS! WOOHOOO!
        for (var i = 0; i < categoryListModel.count; i++) {
            //console.log("Category: " + i + " " + selectionDialog.model.get(selectionDialog.selectedIndex).category)
            if (noteitem.category == selectionDialog.model.get(i).category) {
                console.log("Found matching category at " + i)
                selectionDialog.selectedIndex = i
            }
        }
     }


    // Function to save new note
    function saveNewNote() {
        var datenew = new Date();
        var itemnew = DBcore.defaultItem();
        itemnew.title = textTitle.text;
        itemnew.category = selectionDialog.model.get(selectionDialog.selectedIndex).category;
        itemnew.note = textNote.text;
        itemnew.modified = datenew; //new Date();
        itemnew.modifiedlocale = Qt.formatDateTime(datenew, Qt.DefaultLocaleLongDate);
        DBcore.createNotes(itemnew);
    }


    // Function to save existing note
    function saveExistingNote() {
        var datesave = new Date();
        //var itemsave = DBcore.readNotesItem(Globalvars.noteId);
        var itemsave = DBcore.readNotesItem(noteId);
        itemsave.title = textTitle.text;
        itemsave.category = selectionDialog.model.get(selectionDialog.selectedIndex).category;
        itemsave.note = textNote.text;
        itemsave.modified = datesave; //new Date();
        itemsave.modifiedlocale = Qt.formatDateTime(datesave, Qt.DefaultLocaleLongDate);
        DBcore.updateNotes(itemsave);
    }


    // State machine to handle portrait/landscape orientation
    // from Smooze
    states: [
        State {
            name: "landscape"; when: (screen.currentOrientation == Screen.Landscape)
            PropertyChanges { target: textTitle; state: "LANDSCAPE" }
            PropertyChanges { target: categoryList; state: "LANDSCAPE" }
            },
        State {
            name: "portrait"; when: (screen.currentOrientation == Screen.Portrait)
            PropertyChanges { target: textTitle; state: "PORTRAIT" }
            PropertyChanges { target: categoryList; state: "PORTRAIT" }
            }
    ]


} // End page
