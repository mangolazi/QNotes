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
.pragma library

var db;
var sortcriteria = "Date";
var searchcriteria = "";
var category = "All"

function readNotesList()
{    
    var sqlstring = "SELECT id, title, SUBSTR(title,1,1) AS firstchar, category, SUBSTR(REPLACE(note,'\n',' '), 1, 45) AS shortnote, modifiedlocale FROM notes";

    // filter by search criteria
    if (searchcriteria == "") {
        if (category != "All") {
            sqlstring += " WHERE category = '" + category + "'";
        }
    }
    else {
        sqlstring += " WHERE title LIKE '%" + searchcriteria + "%' OR note LIKE '%" + searchcriteria + "%'"
    }

    if (sortcriteria == "Title") {
        sqlstring += " ORDER BY title ASC";
    }
    else if (sortcriteria == "Date") {
        sqlstring += " ORDER BY modified DESC";
    }
    return sqlstring;
}

function readNotesItem(id) {
    var sqlstring = "SELECT * FROM notes WHERE id=" + id;
    return sqlstring;
}

function readCategoryList()
{
    var sqlstring = "SELECT category FROM category ORDER BY category";
    return sqlstring;
}
