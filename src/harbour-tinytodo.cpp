/*
    Copyright 2013 Simo Mattila
    simo.h.mattila@gmail.com

    This file is part of Tiny Todo.

    Tiny Todo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    Tiny Todo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Tiny Todo.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtQml>
#include <QTranslator>
#include <QLocale>
#include <QDebug>
#include <QGuiApplication>
#include <QQuickView>
#include <sailfishapp.h>


int main(int argc, char *argv[])
{
    QGuiApplication *app = SailfishApp::application(argc, argv);

    app->setApplicationName("harbour-tinytodo");
    app->setApplicationVersion(QString(APP_VERSION)+QString(APP_VERSION_SUFFIX));
    qDebug()<<app->applicationName()<<" version "<<app->applicationVersion();

    QTranslator translator;
    //QString translationLocation = QLibraryInfo::location(QLibraryInfo::TranslationsPath);
    QString translationLocation = "/usr/share/harbour-tinytodo/locale";
    QString translation = "harbour-tinytodo_" + QLocale::system().name();
    qDebug()<<"Translation location: "<<translationLocation;
    qDebug()<<"Translation: "<<translation;
    translator.load(translation, translationLocation);
    app->installTranslator(&translator);

    QQuickView *view = SailfishApp::createView();
    view->rootContext()->setContextProperty("appVersion", app->applicationVersion());
    view->setSource(SailfishApp::pathTo("qml/harbour-tinytodo.qml"));
    view->showFullScreen();

    return app->exec();
}
