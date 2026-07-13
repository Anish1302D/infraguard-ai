import sys
import os

# Append the parent directory (ig2 root) to the system path so imports resolve correctly
sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

from main import app
