/****************************************************************************
** Meta object code from reading C++ file 'sqlquerymodel.h'
**
** Created: Sat Oct 26 10:40:25 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../sqlquerymodel.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sqlquerymodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_SqlQueryModel[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      24,   15,   14,   14, 0x02,
      61,   55,   14,   14, 0x22,
      79,   55,   14,   14, 0x02,
     113,  108,   99,   14, 0x02,
     138,   14,  133,   14, 0x02,
     147,   14,   14,   14, 0x02,
     156,   14,   14,   14, 0x02,
     210,  166,  133,   14, 0x02,
     314,  263,  133,   14, 0x02,
     378,  371,  133,   14, 0x02,
     404,  395,  133,   14, 0x02,
     428,   14,   14,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_SqlQueryModel[] = {
    "SqlQueryModel\0\0query,db\0"
    "setQuery(QString,QSqlDatabase)\0query\0"
    "setQuery(QString)\0setQuery(QSqlQuery)\0"
    "QVariant\0role\0datasingle(QString)\0"
    "bool\0openDB()\0initDB()\0closeDB()\0"
    "title,category,note,modified,modifiedlocale\0"
    "insertNotes(QString,QString,QString,QString,QString)\0"
    "title,category,note,modified,modifiedlocale,noteid\0"
    "updateNotes(QString,QString,QString,QString,QString,int)\0"
    "noteid\0deleteNotes(int)\0category\0"
    "insertCategory(QString)\0syncCategory()\0"
};

const QMetaObject SqlQueryModel::staticMetaObject = {
    { &QSqlQueryModel::staticMetaObject, qt_meta_stringdata_SqlQueryModel,
      qt_meta_data_SqlQueryModel, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &SqlQueryModel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *SqlQueryModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *SqlQueryModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_SqlQueryModel))
        return static_cast<void*>(const_cast< SqlQueryModel*>(this));
    return QSqlQueryModel::qt_metacast(_clname);
}

int SqlQueryModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSqlQueryModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: setQuery((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QSqlDatabase(*)>(_a[2]))); break;
        case 1: setQuery((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: setQuery((*reinterpret_cast< const QSqlQuery(*)>(_a[1]))); break;
        case 3: { QVariant _r = datasingle((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 4: { bool _r = openDB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: initDB(); break;
        case 6: closeDB(); break;
        case 7: { bool _r = insertNotes((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 8: { bool _r = updateNotes((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5])),(*reinterpret_cast< const int(*)>(_a[6])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 9: { bool _r = deleteNotes((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 10: { bool _r = insertCategory((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 11: syncCategory(); break;
        default: ;
        }
        _id -= 12;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
