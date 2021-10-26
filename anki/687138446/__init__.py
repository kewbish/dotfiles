from aqt.qt import *
from aqt.reviewer import Reviewer
from aqt import mw

from PyQt5.Qt import QStyleFactory

config = mw.addonManager.getConfig(__name__)


def my_shortcut_keys(self):
    return [
        ("e", self.mw.onEditCurrent),
        (" ", self.onEnterKey),
        (Qt.Key_Return, self.onEnterKey),
        (Qt.Key_Enter, self.onEnterKey),
        ("r", self.replayAudio),
        (Qt.Key_F5, self.replayAudio),
        ("Ctrl+1", lambda: self.setFlag(1)),
        ("Ctrl+2", lambda: self.setFlag(2)),
        ("Ctrl+3", lambda: self.setFlag(3)),
        ("Ctrl+4", lambda: self.setFlag(4)),
        ("Ctrl+0", lambda: self.setFlag(0)),
        ("*", self.onMark),
        ("=", self.onBuryNote),
        ("-", self.onBuryCard),
        ("!", self.onSuspend),
        ("@", self.onSuspendCard),
        ("Ctrl+Delete", self.onDelete),
        ("v", self.onReplayRecorded),
        ("Shift+v", self.onRecordVoice),
        ("o", self.onOptions),
        (config["1"], lambda: self._answerCard(1)),
        (config["2"], lambda: self._answerCard(2)),
        (config["3"], lambda: self._answerCard(3)),
        (config["4"], lambda: self._answerCard(4)),
    ]


Reviewer._shortcutKeys = my_shortcut_keys
mw.app.setStyle(QStyleFactory.create("gtk2"))
