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

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {
    id: appWindow
    initialPage: ListPage { }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    TodoModel {
        id: todoModel
    }

    Item {
        id: signalRelay
        signal coverAdd

        onCoverAdd: {
            console.log("signalRelay: coverAdd")
            appWindow.activate();
        }
    }
}
