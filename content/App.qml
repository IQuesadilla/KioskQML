// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.4
import KioskQML

Window {
    width: Constants.width
    height: Constants.height

    visible: true
    title: "KioskQML"

    AppForm {
        id: mainScreen
        anchors.fill: parent
    }

}

