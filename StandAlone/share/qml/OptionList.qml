/* Webcamoid, webcam capture application.
 * Copyright (C) 2015  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.7
import QtQuick.Controls 2.0

ListView {
    id: lsvOptionList
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
    clip: true

    property string filter: ""
    property string textRole: ""

    function optionValues(index)
    {
        if (index < 0 || index >= lsvOptionList.count)
            return []

        var values = []
        var option = lstOptions.get(index)

        for (var key in option)
            if (option[key] && typeof option[key] != "function")
                values.push(String(option[key]))

        return values
    }

    model: ListModel {
        id: lstOptions
    }
    delegate: MenuItem {
        text: index >= 0 && index < lsvOptionList.count?
                  lsvOptionList.model.get(index)[lsvOptionList.textRole]: ""
        anchors.right: parent.right
        anchors.left: parent.left
        visible: Webcamoid.matches(filter, optionValues(index))
        highlighted: lsvOptionList.currentItem == this

        onClicked: {
            lsvOptionList.currentIndex = index
            lsvOptionList.positionViewAtIndex(index, ListView.Contain)
        }
    }
}
