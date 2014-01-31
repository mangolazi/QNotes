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

#ifndef CPPEXPORTFILE_H
#define CPPEXPORTFILE_H
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeComponent>
#include <QDateTime>
#include <QTextDocumentWriter>
#include <QTextDocument>
#include <QTextCursor>


// This class saves a Sqlite database to a text file.

class CppExportFile : public QObject
{
     Q_OBJECT
     Q_PROPERTY(int intID READ intID WRITE setintID)
     Q_PROPERTY(QString noteText READ noteText WRITE setNoteText)
     Q_PROPERTY(QString dataLog READ dataLog)
     Q_PROPERTY(QString fileName READ fileName WRITE setFileName)

 public:
     // default constructor
     CppExportFile(QObject *parent = 0);

     // note ID, for batch export
     int intID() const;
     void setintID(const int &intID);

     // note text
     QString noteText() const;
     void setNoteText(const QString &noteText);

     // data log of all events
     QString dataLog() const;
     // Q_INVOKABLE void updateDataLog();

     // file name for data log
     QString fileName() const;
     void setFileName(const QString &filename);

     // data log saved to file
     Q_INVOKABLE bool saveFile();


 private:
     int p_intID;           // note ID
     QString p_csvheader;   // CSV header for data log file
     QString p_notetext;   // note text
     QString p_dataLog;     // data log for all notes
     QString p_filename;    // filename to save to
     QTextDocument * const p_document;  // document for notes export
     QTextCursor p_cursor;  // cursor for document

};

#endif // CPPEXPORTFILE_H
