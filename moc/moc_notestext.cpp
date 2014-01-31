/****************************************************************************
** Meta object code from reading C++ file 'notestext.h'
**
** Created: Mon Oct 8 09:53:30 2012
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../notestext.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'notestext.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_NotesText[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       4,   44, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      11,   10,   10,   10, 0x05,
      29,   10,   10,   10, 0x05,
      47,   10,   10,   10, 0x05,
      68,   10,   10,   10, 0x05,

 // methods: signature, parameters, type, tag, flags
      90,   10,   85,   10, 0x02,
     101,   10,   85,   10, 0x02,

 // properties: name, type, flags
     120,  112, 0x0a495103,
     129,  112, 0x0a495103,
     138,  112, 0x0a495103,
     150,  112, 0x0a495103,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

       0        // eod
};

static const char qt_meta_stringdata_NotesText[] = {
    "NotesText\0\0fileNameChanged()\0"
    "strTitleChanged()\0strnewTitleChanged()\0"
    "strTextChanged()\0bool\0loadNote()\0"
    "saveNote()\0QString\0fileName\0strTitle\0"
    "strnewTitle\0strText\0"
};

const QMetaObject NotesText::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_NotesText,
      qt_meta_data_NotesText, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &NotesText::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *NotesText::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *NotesText::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NotesText))
        return static_cast<void*>(const_cast< NotesText*>(this));
    return QObject::qt_metacast(_clname);
}

int NotesText::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: fileNameChanged(); break;
        case 1: strTitleChanged(); break;
        case 2: strnewTitleChanged(); break;
        case 3: strTextChanged(); break;
        case 4: { bool _r = loadNote();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: { bool _r = saveNote();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = fileName(); break;
        case 1: *reinterpret_cast< QString*>(_v) = strTitle(); break;
        case 2: *reinterpret_cast< QString*>(_v) = strnewTitle(); break;
        case 3: *reinterpret_cast< QString*>(_v) = strText(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setFileName(*reinterpret_cast< QString*>(_v)); break;
        case 1: setStrTitle(*reinterpret_cast< QString*>(_v)); break;
        case 2: setStrnewTitle(*reinterpret_cast< QString*>(_v)); break;
        case 3: setStrText(*reinterpret_cast< QString*>(_v)); break;
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

// SIGNAL 0
void NotesText::fileNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void NotesText::strTitleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void NotesText::strnewTitleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void NotesText::strTextChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE
