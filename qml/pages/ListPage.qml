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
import ".."

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    function showAddDialog () {
        var dialog = pageStack.push(Qt.resolvedUrl("AddPage.qml"))
        dialog.accepted.connect(function() {
            if(dialog.itemTitle) {
                console.log("List: new item")
                todoModel.addTodo(dialog.itemTitle)
            } else {
                console.log("List: new item empty")
            }
        })
    }

    Component.onCompleted: {
        signalRelay.coverAdd.connect(showAddDialog);
    }

    RemorsePopup {
        id: deleteRemorse
        onTriggered: todoModel.clearDoneTodo();
    }

    Component {
        id: todoDelegate
        TextSwitch {
            x: Theme.paddingLarge
            width: todoView.width - Theme.paddingLarge
            text: name
            checked: done
            //color: checked ? Theme.secondaryColor : Theme.primaryColor
            onCheckedChanged: {
                if(text) {
                    console.log("List: (" + index + ")\"" + text + (checked ? "\" marked done":"\" marked not done"));
                    todoModel.updateStatus(index, text, checked);
                }
            }
        }
    }

    SilicaListView {
        id: todoView
        model: todoModel
        delegate: todoDelegate
        anchors.fill: parent

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("About Tiny Todo")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Remove done items")
                onClicked: {
                    deleteRemorse.execute(qsTr("Removing done items"));
                }
            }
            MenuItem {
                text: qsTr("Add new item")
                onClicked: {
                    showAddDialog();
                }
            }
        }

        ViewPlaceholder {
                     enabled: todoView.count === 0
                     text: qsTr("No items")
        }

        header: PageHeader {
            title: "Tiny Todo"
        }
    }
}





