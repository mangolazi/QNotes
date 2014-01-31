#ifndef NOTESTEXT_H
#define NOTESTEXT_H

#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeComponent>
#include <QDateTime>
#include <QTextDocumentWriter>
#include <QTextDocument>
#include <QTextCursor>
#include <QFile>

// This class is intended to handle note file loading and saving
class NotesText : public QObject
{
     Q_OBJECT
     Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
     Q_PROPERTY(QString strTitle READ strTitle WRITE setStrTitle NOTIFY strTitleChanged)
     Q_PROPERTY(QString strnewTitle READ strnewTitle WRITE setStrnewTitle NOTIFY strnewTitleChanged)
     Q_PROPERTY(QString strText READ strText WRITE setStrText NOTIFY strTextChanged)
     //Q_PROPERTY(bool textChanged READ textChanged WRITE setTextChanged NOTIFY )

 public:
     // default constructor
     NotesText(QObject *parent = 0);

     // file name for note
     QString fileName() const;
     void setFileName(const QString &filename);

     // title for note
     QString strTitle() const;
     void setStrTitle(const QString &strtitle);

     // new title for note, for overwrite
     QString strnewTitle() const;
     void setStrnewTitle(const QString &strnewtitle);

     // note text
     QString strText() const;
     void setStrText(const QString &strtext);
     //Q_INVOKABLE void updateDataLog();

     // note loaded from file
     Q_INVOKABLE bool loadNote();

     // note saved to file
     Q_INVOKABLE bool saveNote();

/*
public slots:
     void slotDuration() {
         findDuration();
     }
     void slotInterval() {
         findInterval();
     }
*/


 signals:     
     void fileNameChanged();     
     void strTitleChanged();
     void strnewTitleChanged();
     void strTextChanged();


 private:
     //QTextDocument * const p_document;     
     QString p_strtext;     // note text
     QString p_strtitle;     // note title
     QString p_strnewtitle;     // new note title, for overwrite
     QString p_filename;    // filename to save to
     QTextDocument * const p_document;  // document for note
     QTextCursor p_cursor;  // cursor for document

};

#endif // NOTESTEXT_H
