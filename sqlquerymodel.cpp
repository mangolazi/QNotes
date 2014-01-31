#include "sqlquerymodel.h"
//#include <QtDeclarative/QDeclarativeEngine>
//#include <QtDeclarative/QDeclarativeComponent>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlQueryModel>
#include <QVariant>
#include <QObject>
#include <QString>
#include <QDir>

//--------------------------------
// SQL QUERY MODEL
//--------------------------------

SqlQueryModel::SqlQueryModel(QObject *parent) :
    QSqlQueryModel(parent)
{

}

// Open DB before doing anything, set the path to custom path E:\QNOTESDB\qnotes.sqlite
bool SqlQueryModel::openDB()
{    
    mydb = QSqlDatabase::addDatabase("QSQLITE");
    QDir dir;
    QString dbPath = "E:";
    dbPath += QDir::separator();
    dbPath += "QNOTESDB";
    dbPath = (QDir::toNativeSeparators(dbPath));

    // mkpath works differently in 4.7 vs 4.8!
    if(!dir.exists(dbPath)) {
        if(dir.mkpath(dbPath)) {
            dbPath += QDir::separator();
            dbPath += "qnotes.sqlite";
            mydb.setDatabaseName(dbPath);
        }
    }
    else {
        dbPath += QDir::separator();
        dbPath += "qnotes.sqlite";
        mydb.setDatabaseName(dbPath);
    }
    return mydb.open();
}

// Init DB, create missing tables if necessary
void SqlQueryModel::initDB()
{
    if (mydb.isOpen()) {
        QSqlQuery query1;
        QSqlQuery query2;
        query1.exec("CREATE TABLE IF NOT EXISTS notes "
                         "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                         "title TEXT, "
                         "category TEXT, "
                         "note TEXT, "
                         "modified DATETIME, "
                         "modifiedlocale TEXT)");
        query2.exec("CREATE TABLE IF NOT EXISTS category "
                         "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                         "category TEXT, "
                         "desc TEXT)");
    }
}


// Close DB to end app
void SqlQueryModel::closeDB()
{
    mydb.close();
}

// Set query and run
void SqlQueryModel::setQuery(const QString &query, const QSqlDatabase &db)
{        
    QSqlQueryModel::setQuery(query,db);
    generateRoleNames();
}

// Set query and run
void SqlQueryModel::setQuery(const QSqlQuery &query)
{
    QSqlQueryModel::setQuery(query);
    generateRoleNames();    
}

// Assign role names to model's rolenames hash so it can be accessed by fields instead of numbers
void SqlQueryModel::generateRoleNames()
{
    QHash<int, QByteArray> roleNames;
    for( int i = 0; i < record().count(); i++) {
        roleNames[Qt::UserRole + i + 1] = record().fieldName(i).toAscii();
    }
    setRoleNames(roleNames);
}

// Retrieve multi-row data from model
QVariant SqlQueryModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

// Retrieve data for single row only
// Nasty hack, assumes only one row returned by query!
QVariant SqlQueryModel::datasingle(const QString &fieldName) const
{
    //int num2 = hash.value("thirteen");
    //QHash<int, QByteArray> roleNames;
    //roleNames = QSqlQueryModel::roleNames();
    //int roleKey;
    //roleNames.find(roleValue);
    //roleKey = QSqlQueryModel::roleNames.key("title");
    //QVariant value = roleKey; //QSqlQueryModel::data(QSqlQueryModel::index(0,roleKey));
    //model.setQuery("SELECT * FROM employee");
    //int salary = model.record(4).value("salary").toInt();
    QVariant value = QSqlQueryModel::record(0).value(fieldName);
    return value;
}

// Insert new note
bool SqlQueryModel::insertNotes(const QString &title,
                                    const QString &category,
                                    const QString &note,
                                    const QString &modified,
                                    const QString &modifiedlocale)
{
    bool ret = false;
    QSqlQuery query;
    ret = query.prepare("INSERT INTO notes (title, category, note, modified, modifiedlocale)"
                        "VALUES(?,?,?,?,?)");
    if (ret) {
        query.addBindValue(title);
        query.addBindValue(category);
        query.addBindValue(note);
        query.addBindValue(modified);
        query.addBindValue(modifiedlocale);
        ret = query.exec();
    }
    return ret;
}

// Update existing note
bool SqlQueryModel::updateNotes(const QString &title,
                                    const QString &category,
                                    const QString &note,
                                    const QString &modified,
                                    const QString &modifiedlocale,
                                    const int &noteid)
{
    bool ret = false;
    QSqlQuery query;
    ret = query.prepare("UPDATE notes SET title = ?, category = ?, note = ?, modified = ?, modifiedlocale = ? WHERE id = ?");
    if (ret) {
        query.addBindValue(title);
        query.addBindValue(category);
        query.addBindValue(note);
        query.addBindValue(modified);
        query.addBindValue(modifiedlocale);
        query.addBindValue(noteid);
        ret = query.exec();
    }
    return ret;
}

// Delete existing note
bool SqlQueryModel::deleteNotes(const int &noteid)
{
    bool ret = false;
    QSqlQuery query;
    ret = query.prepare("DELETE FROM notes WHERE id = ?");
    if (ret) {
        query.addBindValue(noteid);
        ret = query.exec();
    }
    return ret;
}

// Insert new category
bool SqlQueryModel::insertCategory(const QString &category)
{
    bool ret = false;
    QSqlQuery query;
    ret = query.prepare("INSERT INTO category (category)"
                        "VALUES(?)");
    if (ret) {
        query.addBindValue(category);
        ret = query.exec();
    }
    return ret;
}

// Sync old categories to new categories, for app version upgrades
void SqlQueryModel::syncCategory()
{
    QSqlQuery queryDelete;
    queryDelete.prepare("DELETE FROM category");
    queryDelete.exec();

    QSqlQueryModel::setQuery("SELECT DISTINCT category FROM notes ORDER BY category");

    QSqlQuery queryInsertCategory;
    for( int i = 0; i < rowCount(); i++) {
        queryInsertCategory.prepare("INSERT INTO category (category)"
                "VALUES(?)");
        queryInsertCategory.addBindValue(record(i).value("category"));
        queryInsertCategory.exec();
    }
}
