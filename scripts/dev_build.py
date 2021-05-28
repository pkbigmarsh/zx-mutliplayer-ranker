#!/usr/bin/python
"""
Python 3

This script copies the mod from the project directory to the steam directory
for testing purposes.
"""

import shutil
import os
import sys
from pathlib import Path
from platform import uname
from enum import Enum

class SYSTEM(Enum):
	"""Enum representing supported system types"""
	WINDOWS = 1
	WSL 	= 2

	@staticmethod
	def get_system():
		"""
		returns the current system if supported
			None if not supported
		"""
		if 'Microsoft' in uname().release and os.name == 'posix':
			return SYSTEM.WSL
		elif os.name == 'nt':
			return SYSTEM.WINDOWS
		else:
			return None


def get_user_mod_path():
	system = SYSTEM.get_system()
	user_home = None
	if system == SYSTEM.WINDOWS:
		user_home = Path(os.environ['USERPROFILE'])
	elif system == SYSTEM.WSL:
		fpipe = os.popen('cmd.exe /c "echo %USERNAME%"')
		windows_username = fpipe.readline().strip()
		fpipe.close()
		user_home = Path('/mnt/c/Users/' + windows_username)

	if user_home is None:
		sys.exit("Unsupported system. Platform={} OS={}".format(uname().release,os.name))

	return user_home.joinpath('Documents/My Games/Sid Meier\'s Civilization VI/Mods/ZXMultiplayerRanker')

def build_mod(project_path, game_path):
	if game_path.exists():
		shutil.rmtree(game_path)	

	try:
		shutil.copytree(project_path, game_path)
	except Exception as e:
		err_name = type(e).__name__
		print("[×] copy failed\n    > {}: {}".format(err_name, e.args))
	else:
		print('[√] copy complete')


if __name__ == "__main__":
	project_path = Path(__file__).resolve().parents[1].joinpath('mod')
	game_path = get_user_mod_path()
	build_mod(project_path, game_path)
