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
    id: cover
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
        anchors.fill: cover
        anchors.margins: Theme.paddingLarge
        Label {
            id: todoLabel
            width: cover.width - 2 * Theme.paddingLarge
            text: qsTr("<b>%1</b> items").arg(todoModel.nTodo)
            font.pixelSize: Theme.fontSizeLarge
            truncationMode: TruncationMode.Fade
        }
        ListView {
            id: coverListView
            anchors.top: todoLabel.bottom
            anchors.topMargin: Theme.paddingMedium
            anchors.left: parent.left
            anchors.right: parent.right
            height: 4 * (Theme.fontSizeMedium + 2 * Theme.paddingSmall)
            clip: true
            model: todoModel
            delegate:
                Label {
                    text: name
                    visible: !done
                    height: done ? 0 : Theme.fontSizeMedium + 2 * Theme.paddingSmall
                    width: cover.width - 2 * Theme.paddingLarge
                    truncationMode: TruncationMode.Fade
                }
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


