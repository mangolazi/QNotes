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

#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include <QtCore>
#include "exportfile.h"
#include "sqlquerymodel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    // Expose CppExportFile and Sqlquerymodel types to QML
    qmlRegisterType<CppExportFile>("ExportFile", 1,0, "ExportFile");
    qmlRegisterType<SqlQueryModel>("SqlQueryModel", 1,0, "SqlQueryModel");

    QmlApplicationViewer viewer;
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    viewer.setMainQmlFile("qml/qNotes/main.qml");
    viewer.showExpanded();
    return app->exec();
}
