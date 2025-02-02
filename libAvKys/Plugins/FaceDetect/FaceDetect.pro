# Webcamoid, webcam capture application.
# Copyright (C) 2016  Gonzalo Exequiel Pedone
#
# Webcamoid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Webcamoid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
#
# Web-Site: http://webcamoid.github.io/

exists(translations.qrc) {
    TRANSLATIONS = $$files(share/ts/*.ts)
    RESOURCES += translations.qrc
}

exists(akcommons.pri) {
    include(akcommons.pri)
} else {
    exists(../../akcommons.pri) {
        include(../../akcommons.pri)
    } else {
        error("akcommons.pri file not found.")
    }
}

CONFIG += plugin

HEADERS = \
    src/facedetect.h \
    src/facedetectelement.h \
    src/haar/haarcascade.h \
    src/haar/haardetector.h \
    src/haar/haarfeature.h \
    src/haar/haarstage.h \
    src/haar/haartree.h

INCLUDEPATH += \
    ../../Lib/src

QML_IMPORT_PATH += $$PWD/../../AkQml/share/qml

LIBS += -L$${OUT_PWD}/../../Lib/$${BIN_DIR} -l$${COMMONS_TARGET}

OTHER_FILES += \
    pspec.json \
    $$files(share/qml/*.qml)

QT += qml widgets concurrent

RESOURCES += \
    FaceDetect.qrc \
    haarcascades.qrc \
    masks.qrc

SOURCES = \
    src/facedetect.cpp \
    src/facedetectelement.cpp \
    src/haar/haarcascade.cpp \
    src/haar/haardetector.cpp \
    src/haar/haarfeature.cpp \
    src/haar/haarstage.cpp \
    src/haar/haartree.cpp

lupdate_only {
    SOURCES += $$files(share/qml/*.qml)
}

DESTDIR = $${OUT_PWD}/$${BIN_DIR}
android: TARGET = $${COMMONS_TARGET}_lib$${TARGET}

TEMPLATE = lib

INSTALLS += target
target.path = $${INSTALLPLUGINSDIR}
