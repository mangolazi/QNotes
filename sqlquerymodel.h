#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <QObject>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeComponent>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlQueryModel>
#include <QtSql/QSqlRecord>
#include <QVariant>
#include <QModelIndex>

class SqlQueryModel : public QSqlQueryModel
{
    Q_OBJECT
    //Q_PROPERTY(QString fileName READ fileName WRITE setFileName)

    void generateRoleNames();

public:
    explicit SqlQueryModel(QObject *parent = 0);

    Q_INVOKABLE void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    Q_INVOKABLE void setQuery(const QSqlQuery &query);
    QVariant data(const QModelIndex &index, int role) const;
    Q_INVOKABLE QVariant datasingle(const QString &role) const;

    Q_INVOKABLE bool openDB();
    Q_INVOKABLE void initDB();
    Q_INVOKABLE void closeDB();
    Q_INVOKABLE bool insertNotes(const QString &title, const QString &category, const QString &note, const QString &modified, const QString &modifiedlocale);
    Q_INVOKABLE bool updateNotes(const QString &title, const QString &category, const QString &note, const QString &modified, const QString &modifiedlocale, const int &noteid);
    Q_INVOKABLE bool deleteNotes(const int &noteid);
    Q_INVOKABLE bool insertCategory(const QString &category);
    Q_INVOKABLE void syncCategory();

    QSqlDatabase mydb;

private:

signals:

public slots:

};

#endif // SQLQUERYMODEL_H
