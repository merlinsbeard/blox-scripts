#!/usr/bin/env python
import urllib2
import commands
from subprocess import Popen

ip ='127.0.0.1'
try:
	link = urllib2.urlopen('http://%s' % ip).code
	print link
except urllib2.HTTPError as e:
	print e.code
except urllib2.URLError:
	Popen(['invoke-rc.d','apache2','restart'])

