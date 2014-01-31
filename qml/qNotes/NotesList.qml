/* Copyright Ac mangolazi 2012.
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

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.folderlistmodel 1.0
import "dbcore.js" as DBcore
import SqlQueryModel 1.0

Page {
    id: pagenotesList
    tools: mainToolbar
    property int prevIndex: -1 // previously clicked note

    // SQL object
    SqlQueryModel {
        id: sqlNotes
    }
    SqlQueryModel {
        id: sqlCategory
    }

    // Default toolbar
    ToolBarLayout {
        id: mainToolbar

        ToolButton {
            id: toolbarbtnBack
            flat: true
            iconSource: "toolbar-back"
            onClicked:
            {
                if (categoryList.title != "All") {
                    DBcore.category = "All"
                    updateNotesList()
                    selectionDialog.selectedIndex = -1
                }
                else {
                    sqlNotes.closeDB()
                    Qt.quit()
                }
            }
        }

        ToolButton {
            id: toolbarbtnNew
            flat: true
            iconSource: "toolbar-add"
            onClicked:
            {
                pageStack.push(Qt.resolvedUrl("NotesPage.qml"), {newNote: true});
            }
        }

        ToolButton {
            id: toolbarbtnMenu
            flat: true
            iconSource: "toolbar-menu"
            onClicked: mainMenu.open()
        }
    }

    // main menu
    Menu {
         id: mainMenu
         content: MenuLayout {
             MenuItem {
                 text: "About"
                 onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
             }
             MenuItem {
                 text: "Sync Categories"
                 onClicked: syncDialog.open()
             }
         }
     }

    // delete dialog
    QueryDialog {
        id: syncDialog
        titleText: "Sync categories?"
        message: "All categories will be deleted and synchronized with existing notes.\n"
        acceptButtonText: "OK"
        rejectButtonText: "Cancel"
        onAccepted: {
            sqlCategory.syncCategory()
            close()
            updateNotesList()
        }
        onRejected: {
            delDialog.close()
        }
    }


    // Search and sort rectangle
    Rectangle {
        id: searchBox
        anchors.top: parent.top
        width: parent.width
        height: 120
        color: "#111111"
        radius: 20

    // Category chooser
    SelectionListItem {             
        id: categoryList
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width/2
        title: DBcore.category
        onClicked: selectionDialog.open()

        SelectionDialog {
            id: selectionDialog
            titleText: "Select a note category"
            selectedIndex: -1
            delegate: selectionDialogDelegate
        }

        states: [
            State {
                name: "PORTRAIT";
                PropertyChanges { target: categoryList; width: parent.width/2}
            },
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: categoryList; width: parent.width/3}
            }
        ]
    }

    Component {
            id: selectionDialogDelegate
            MenuItem {
                text: category
                onClicked: {
                    selectedIndex = index
                    DBcore.category = category //modelData
                    updateNotesList()
                    root.accept()
                }
            }
        }

    // Sort chooser
    SelectionListItem {
        id: sortList
        anchors.top: parent.top
        anchors.left: categoryList.right
        width: parent.width/2
        title: sortDialog.selectedIndex >= 0
                  ? sortDialog.model.get(sortDialog.selectedIndex).name
                  : "Date"
        onClicked: sortDialog.open()

        SelectionDialog {
            id: sortDialog
            titleText: "Select sort criteria"
            selectedIndex: -1
            model: ListModel {
                ListElement { name: "Date" }
                ListElement { name: "Title" }
            }

            onAccepted: {
                DBcore.sortcriteria = sortDialog.model.get(sortDialog.selectedIndex).name
                updateNotesList()
            }
        }

        states: [
            State {
                name: "PORTRAIT";
                PropertyChanges { target: sortList; width: parent.width/2 }
            },
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: sortList; width: parent.width/3 }
            }
        ]
    }

    // Search criteria
    TextField {
        id: searchTxt
        anchors.top: sortList.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        width: parent.width
        placeholderText: "Search..."
        font.bold: true
        font.pixelSize: 22
        onTextChanged: {
            DBcore.searchcriteria = searchTxt.text
            updateNotesList()
        }

        Image {
            anchors { top: parent.top; right: parent.right; margins: platformStyle.paddingMedium }
            id: clearText
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "clear.svg"
            height: parent.height - 15
            width: parent.height - 15

            MouseArea {
                id: clear
                anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                height: searchTxt.height; width: searchTxt.height
                onClicked: {
                    searchTxt.text = ""
                    searchTxt.forceActiveFocus()
                }
            }
        }

        states: [
            State {
                name: "PORTRAIT";
                AnchorChanges { target: searchTxt; anchors.top: sortList.bottom }
                AnchorChanges { target: searchTxt; anchors.left: parent.left }
                AnchorChanges { target: searchTxt; anchors.right: parent.right }
                PropertyChanges { target: searchTxt; anchors.topMargin : 5 }
                PropertyChanges { target: searchTxt; width: parent.width }
            },
            State {
                name: "LANDSCAPE";
                AnchorChanges { target: searchTxt; anchors.top: parent.top }
                AnchorChanges { target: searchTxt; anchors.left: sortList.right }
                AnchorChanges { target: searchTxt; anchors.right: parent.right }
                PropertyChanges { target: searchTxt; anchors.topMargin : 10 }
                PropertyChanges { target: searchTxt; width: 200 }
            }
        ]
    }

        states: [
            State {
                name: "PORTRAIT";
                PropertyChanges { target: searchBox; height: 120 }
            },
            State {
                name: "LANDSCAPE";
                PropertyChanges { target: searchBox; height: 70 } //parent.width - categoryList.width - sortList.width }
            }
        ]

    }
    // end searchBox

    // Main List View, showing notes list
    ListView {
        id: notesView        
        anchors.top: searchBox.bottom
        anchors.topMargin: 2
        anchors.bottom: parent.bottom        
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        clip: true
        delegate: notesItemComponent

        ScrollBar {
            id: notesViewScrollbar
            flickableItem: notesView
            orientation: Qt.Vertical
            policy: Symbian.ScrollBarWhenNeeded
            anchors { right: notesView.right; top: notesView.top }
        }
    }

    Component {
      id: notesItemComponent

      ListItem {
          id: notesItem
          property variant myData: model
          height: 80
          Text {
              id: dateTxt
              anchors.top: parent.top
              anchors.topMargin: 2
              anchors.left: parent.left
              anchors.right: parent.right
              text: model.modifiedlocale
              color: "lightgray"
              font.pixelSize: 16
              font.bold: false
          }
          Text {
              id: titleTxt
              anchors.top: dateTxt.bottom
              anchors.topMargin: 2
              anchors.left: parent.left
              anchors.right: parent.right
              text: model.title
              elide: Text.ElideRight
              wrapMode: Text.WrapAnywhere
              maximumLineCount: 1
              color: "white"
              font.pixelSize: 24
              font.bold: true
          }
          Text {
              id: shortnoteTxt
              anchors.top: titleTxt.bottom
              anchors.topMargin: 2
              anchors.left: parent.left
              anchors.bottom: parent.bottom
              anchors.bottomMargin: 2
              text: model.shortnote
              maximumLineCount: 1
              color: "white"
              font.pixelSize: 18
          }

          onClicked: {
              prevIndex = notesView.currentIndex
              pageStack.push(Qt.resolvedUrl("NotesPage.qml"), {noteId: model.id})
          }
          onPressAndHold: {
              actionMenu.open()
          }
      }
    }

    // context menu for delete
    ContextMenu {
         id: actionMenu
         MenuLayout {
             MenuItem {
                 text: "Delete"
                 onClicked: delDialog.open()
             }
         }
     }

    // delete dialog
    QueryDialog {
        id: delDialog
        titleText: "Delete note?"
        message: "Note \"" + notesView.currentItem.myData.title + "\" will be deleted.\n"
        acceptButtonText: "OK"
        rejectButtonText: "Cancel"
        onAccepted: {            
            sqlNotes.deleteNotes(notesView.currentItem.myData.id)
            delDialog.close()
            updateNotesList()
        }
        onRejected: {
            delDialog.close()
        }
    }

    // open database
    Component.onCompleted: {
        sqlNotes.openDB();
        sqlNotes.initDB();
    }

    onStatusChanged: {
        if ( status == PageStatus.Activating  ) {
            updateNotesList()
            notesView.positionViewAtIndex(prevIndex, ListView.Top)
        }
    }


    // Functions
    // =========
    function updateNotesList()
    {
        sqlNotes.setQuery(DBcore.readNotesList());
        notesView.model = sqlNotes;
        sqlCategory.setQuery(DBcore.readCategoryList());
        selectionDialog.model = sqlCategory;
        categoryList.title = DBcore.category;
        notesView.positionViewAtIndex(prevIndex, ListView.Center)
    }

    // State machine to handle portrait/landscape orientation
    states: [
        State {
            name: "landscape"; when: (screen.currentOrientation == Screen.Landscape)
            PropertyChanges { target: categoryList; state: "LANDSCAPE" }
            PropertyChanges { target: sortList; state: "LANDSCAPE" }
            PropertyChanges { target: searchTxt; state: "LANDSCAPE" }
            PropertyChanges { target: searchBox; state: "LANDSCAPE" }
        },
        State {
            name: "portrait"; when: (screen.currentOrientation == Screen.Portrait)
            PropertyChanges { target: categoryList; state: "PORTRAIT" }
            PropertyChanges { target: sortList; state: "PORTRAIT" }
            PropertyChanges { target: searchTxt; state: "PORTRAIT" }
            PropertyChanges { target: searchBox; state: "PORTRAIT" }
        }
    ]

}
