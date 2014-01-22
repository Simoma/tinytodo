# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-tinytodo

CONFIG += sailfishapp

SOURCES += src/harbour-tinytodo.cpp

OTHER_FILES += qml/harbour-tinytodo.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-tinytodo.spec \
    rpm/harbour-tinytodo.yaml \
    harbour-tinytodo.desktop \
    qml/TodoModel.qml \
    qml/pages/ListPage.qml \
    qml/pages/AddPage.qml \
    qml/pages/AboutPage.qml

TRANSLATIONS = harbour-tinytodo_fi.ts

trans.files = harbour-tinytodo_fi.qm
trans.path = /usr/share/harbour-tinytodo/locale
INSTALLS += trans

lupdate_only{
SOURCES += qml/*.qml \
    qml/cover/*.qml \
    qml/pages/*.qml
}
