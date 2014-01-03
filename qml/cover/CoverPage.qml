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

CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.height / 4
        text: "Tiny\nTodo"
        font.pixelSize: 100
        font.bold: true
        opacity: 0.2

        transform: Rotation {
            origin.x: label.width / 2
            origin.y: label.height / 2
            angle:-10
        }
    }

    Column {
        anchors.centerIn: parent
        anchors.margins: Theme.paddingLarge
        Label {
            id: todoLabel
            text: qsTr("<b>%1</b> to do").arg(todoModel.nTodo)
            font.pixelSize: Theme.fontSizeLarge
        }
        Label {
            id: doneLabel
            text: qsTr("<b>%1</b> done").arg(todoModel.nDone)
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeLarge
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                console.log("Cover: Add item")
            }
            Component.onCompleted: {
                triggered.connect(signalRelay.coverAdd);
            }
        }
    }
}


