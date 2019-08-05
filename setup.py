from setuptools import setup

setup(
   name='afide',
   version='0.1',
   description='A Fittest Ide',
   author='Benny Daon',
   author_email='benny@tuzig.com',
   license = 'Apache',
   packages=['afide'],
   install_requires=['click'],
   entry_points = {
        'console_scripts': ['afide=afide:cli'],
    }
)
