/****************************************************************************
** Meta object code from reading C++ file 'exportfile.h'
**
** Created: Thu Oct 24 09:48:59 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../exportfile.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'exportfile.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_CppExportFile[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       4,   19, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      20,   14,   15,   14, 0x02,

 // properties: name, type, flags
      35,   31, 0x02095003,
      49,   41, 0x0a095103,
      58,   41, 0x0a095001,
      66,   41, 0x0a095103,

       0        // eod
};

static const char qt_meta_stringdata_CppExportFile[] = {
    "CppExportFile\0\0bool\0saveFile()\0int\0"
    "intID\0QString\0noteText\0dataLog\0fileName\0"
};

const QMetaObject CppExportFile::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_CppExportFile,
      qt_meta_data_CppExportFile, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &CppExportFile::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *CppExportFile::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *CppExportFile::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_CppExportFile))
        return static_cast<void*>(const_cast< CppExportFile*>(this));
    return QObject::qt_metacast(_clname);
}

int CppExportFile::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: { bool _r = saveFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 1;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = intID(); break;
        case 1: *reinterpret_cast< QString*>(_v) = noteText(); break;
        case 2: *reinterpret_cast< QString*>(_v) = dataLog(); break;
        case 3: *reinterpret_cast< QString*>(_v) = fileName(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setintID(*reinterpret_cast< int*>(_v)); break;
        case 1: setNoteText(*reinterpret_cast< QString*>(_v)); break;
        case 3: setFileName(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
