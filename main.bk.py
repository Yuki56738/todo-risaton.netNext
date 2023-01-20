import kivy

from kivy import *

from kivy.app import *
from kivy.core.text import LabelBase
from kivy.uix import *
from kivy.uix.label import *
from kivy.uix.widget import *
from kivy.properties import *
from kivy.config import *

Config.set('graphics', 'width', '400')
Config.set('graphics', 'height', '800')

# LabelBase.register(name='font1', fn_regular="DroidSansJapanese.ttf", fn_bold="DroidSansJapanese.ttf")
LabelBase.register(name='Roboto',
                   fn_regular='./fonts/Roboto-Thin.ttf',
                   fn_bold='./fonts/Roboto-Medium.ttf')
class TextWidget1(Widget):
    # text = StringProperty()
    # label1 = StringProperty()
    text = StringProperty()
    # font_name = StringProperty()
    def __init__(self, **kwargs):
        super(TextWidget1, self).__init__(**kwargs)

    def button1Clicked(self):
        # self.font_name = 'DroidSansJapanese.ttf'
        self.text = 'こんにちは、ゆきです。'
        # TextWidget1.get_root_window(self)
        # self.text = ''
    # def button1Clicked(self):



class app1(App):
    def __init__(self, **kwargs):
        super(app1, self).__init__(**kwargs)

    def build(self):
        return TextWidget1()


if __name__ == '__main__':
    app1().run()
