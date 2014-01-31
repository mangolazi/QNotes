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
//import "dbcore.js" as DBcore

PageStackWindow {
    id: window
    initialPage: NotesList {}
    showStatusBar: true
    showToolBar: true

    StatusBar {
            id: statusBar
            anchors.top: window.top
            Text {
                id:statusBarTitle
                text:"QNotes"
                color:"white"
            }
        }
}

