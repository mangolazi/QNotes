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

#include "exportfile.h"
#include <QTextDocumentWriter>
#include <QTextDocument>
#include <QTextCursor>
#include <QFile>

//#include <QStringBuilder>


// INITIALIZE OBJECT, DOCUMENT POINTERS
CppExportFile::CppExportFile(QObject *parent) :
    QObject(parent),
    p_document(new QTextDocument()),
    p_cursor(p_document)  //, p_intervalStart(0)
{
    p_notetext = QString("");
    p_dataLog = QString("");
}


// return functions

int CppExportFile::intID() const
{
    return p_intID;
}

QString CppExportFile::noteText() const
{
    return p_notetext;
}

QString CppExportFile::dataLog() const
{
    return p_dataLog;
}

QString CppExportFile::fileName() const
{
    return p_filename;
}

// setting functions

void CppExportFile::setintID(const int &intID)
{
        p_intID = intID;
}

void CppExportFile::setNoteText(const QString &noteText)
{
        p_notetext = noteText;
}

void CppExportFile::setFileName(const QString &filename)
{
    p_filename = filename;
}

// need to make another one for batch export
bool CppExportFile::saveFile()
{
    p_document->undo(); // remove previous info
    p_cursor.insertText(p_notetext); // insert note text

    QTextDocumentWriter writer;
    writer.setFormat("plaintext");
    writer.setFileName(p_filename);

    bool success = writer.write(p_document);

    return success;
}


/*
  batch export
bool CppExportFile::saveFile()
{
    p_csvheader = "Event,Duration,DurationSec,Interval,IntervalSec,Start,End\n";

    p_document->undo(); // remove previous info on CSV header
    p_document->undo(); // remove previous info on data log
    p_cursor.insertText(p_csvheader); // insert CSV header
    p_cursor.insertText(p_dataLog); // insert data log

    QTextDocumentWriter writer;
    writer.setFormat("plaintext");
    writer.setFileName(p_filename);

    bool success = writer.write(p_document);

    return success;
}*/
