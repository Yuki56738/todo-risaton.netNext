import kivy

from kivy import *

from kivy.app import *
from kivy.uix import *
from kivy.uix.label import *
from kivy.uix.widget import *
from kivy.properties import *
from kivy.config import *

Config.set('graphics', 'width', '400')
Config.set('graphics', 'height', '800')


class TextWidget1(Widget):
    pass


class app1(App):
    def __init__(self, **kwargs):
        super(app1, self).__init__(**kwargs)

    def build(self):
        return TextWidget1()


if __name__ == '__main__':
    app1().run()
