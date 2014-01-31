# Add more folders to ship with the application, here
folder_01.source = qml/qNotes
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

VERSION = 0.5.7

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE2A2FE74

# Allow network access on Symbian? Nope!
# Also read/write user data, needed for external database access
# symbian:TARGET.CAPABILITY += NetworkServices ReadUserData WriteUserData
symbian:TARGET.CAPABILITY += ReadUserData WriteUserData
vendorinfo += "%{\"mangolazi\"}" ":\"mangolazi\""
my_deployment.pkg_prerules = vendorinfo
DEPLOYMENT += my_deployment

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    exportfile.cpp \
    sqlquerymodel.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

ICON = nqml.svg

HEADERS += \
    exportfile.h \
    sqlquerymodel.h

QT += sql
