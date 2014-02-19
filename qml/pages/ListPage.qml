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

    SilicaListView {
        id: todoView
        model: todoModel
        delegate: ListItem {
            id: delegateItem
            width: parent.width
            menu: contextMenu
            onClicked: todoModel.updateStatus(index, name, !done)
            ListView.onRemove: animateRemoval()
            function deleteItem() {
                console.log("Deleting (" + index +") " + name)
                todoModel.deleteTodo(index, name);
            }
            GlassItem {
                id: delegateIndicator
                x: Theme.paddingLarge
                anchors.verticalCenter: parent.verticalCenter
                opacity: 1.0
                dimmed: done
                falloffRadius: 0.075
                Behavior on falloffRadius {
                    NumberAnimation { duration: 50; easing.type: Easing.InOutQuad }
                }
                brightness: 1.0
                Behavior on brightness {
                    NumberAnimation { duration: 50; easing.type: Easing.InOutQuad }
                }
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Label {
                id: delegateLabel
                anchors.left: delegateIndicator.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                //width: todoView.width - delegateIndicator.width - 2*Theme.paddingLarge
                text: name
                color: highlighted ? Theme.highlightColor : (done ? Theme.secondaryColor : Theme.primaryColor)
                font.strikeout: done
                truncationMode: TruncationMode.Fade
            }
            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: qsTr("Remove")
                        onClicked: remorseAction(qsTr("Removing"), delegateItem.deleteItem )
                    }
                }
            }
        }
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





