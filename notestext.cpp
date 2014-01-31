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

#include "notestext.h"
#include <QTextDocumentWriter>
#include <QTextDocument>
#include <QTextCursor>
#include <QTextCodec>
#include <QFile>


//#include <QStringBuilder>


// INITIALIZE OBJECT, DOCUMENT POINTERS
NotesText::NotesText(QObject *parent) :
    QObject(parent),
    p_document(new QTextDocument()),
    p_cursor(p_document)  //, p_intervalStart(0)
{
    //p_dataLog = QString("");
}


// return functions

QString NotesText::strText() const
{    
    return p_strtext;
}

QString NotesText::strTitle() const
{
    return p_strtitle;
}

QString NotesText::strnewTitle() const
{
    return p_strnewtitle;
}

QString NotesText::fileName() const
{
    return p_filename;
}




// setting functions

void NotesText::setFileName(const QString &filename)
{    
    p_filename = filename;
    p_filename.remove(QString("file://"), Qt::CaseSensitive); // trim off starting file://
    //p_filename.remove(QString("file:///"), Qt::CaseSensitive); // for actual device!!!
    emit fileNameChanged();
}


void NotesText::setStrTitle(const QString &strtitle)
{
    p_strtitle = strtitle;
    p_strtitle.remove(QString(".txt"), Qt::CaseInsensitive); // trim off ending .txt
    emit strTitleChanged();
}


void NotesText::setStrnewTitle(const QString &strnewtitle)
{
    p_strnewtitle = strnewtitle;
    emit strnewTitleChanged();
}
    

void NotesText::setStrText(const QString &strtext)
{
        p_strtext = strtext;
        emit strTextChanged();
}



// Load note text from filename
bool NotesText::loadNote()
{
    // load file if it exists and is readable
    //p_filename = "/Users/riza/test/test2.txt";
    if (!QFile::exists(p_filename))
        return false;
    QFile file(p_filename);
    if (!file.open(QFile::ReadOnly))
        return false;

    // load into QTextDocument and transfer to string for display
    QByteArray doc_array = file.readAll();
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");

    p_document->setPlainText(codec->toUnicode(doc_array));
    p_strtext = p_document->toPlainText();
    //p_strtext = p_document->toHtml(); //toPlainText();
    //QString tempstring = codec->toUnicode(p_strtext);
    //p_strtext = tempstring;
    //p_strtext = QString::fromUtf8(p_strtext);
    // QString string = codec->toUnicode(encodedString);
    file.close();    

    return true;
}


// Save note to filename
bool NotesText::saveNote()
{
    // delete existing file, i'm too lazy to do a rename and rewrite
    if (!QFile::exists(p_filename))
        return false;
    QFile file(p_filename);
    file.remove();

    // insert new note text
    p_document->clear();
    p_cursor.movePosition(QTextCursor::Start);
    p_cursor.insertText(p_strtext);

    // write new document into new filename
    QTextDocumentWriter writer;

    //QString p_newfilename; // magic to remove old localname from path, add new one
    //p_newfilename = p_filename;
    p_filename.remove(QString(p_strtitle + ".txt")); // trim off old title
    p_filename.append(QString(p_strnewtitle + ".txt")); // add new title, for full path

    writer.setFormat("plaintext");
    //writer.setFormat("HTML");
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");
    writer.setCodec(codec);
    writer.setFileName(p_filename);

    bool success = writer.write(p_document);
    return success;
    //return true;
}
