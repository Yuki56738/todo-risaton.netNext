from kivy import *

from kivy.app import *
from kivy.uix import *
from kivy.uix.label import *
from kivy.uix.widget import *
from kivy.properties import *
import kivy


class TextWidget(Widget):
    text = StringProperty()

    def __init__(self, **kwargs):
        super(TextWidget, self).__init__(**kwargs)
        self.text = 'Hello World'

    def buttonClicked(self):
        self.text = 'Hello World1'


class app2(App):
    # def build(self):
    #     return Label(text="Hello, World!")
    def __init__(self, **kwargs):
        super(app2, self).__init__(**kwargs)
        self.title = 'greeting'

    def build(self):
        return TextWidget()


app2().run()
# app2.run(self=app2)
