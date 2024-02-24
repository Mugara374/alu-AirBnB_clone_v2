#!/usr/bin/python3
<<<<<<< HEAD
"""create a unique FileStorage instance for your application"""
from models.engine.file_storage import FileStorage
from models.engine.db_storage import DBStorage
from models.base_model import BaseModel
from models.user import User
from models.state import State
from models.city import City
from models.amenity import Amenity
from models.place import Place
from models.review import Review
from os import getenv


if getenv("HBNB_TYPE_STORAGE") == "db":
=======
"""This module instantiates an object of class FileStorage"""
import os

if os.getenv("HBNB_TYPE_STORAGE") == "db":
    from models.engine.db_storage import DBStorage

>>>>>>> ac171749021351b8b308003ee9f5b2ec991e5fa1
    storage = DBStorage()
    storage.reload()
else:

    from models.engine.file_storage import FileStorage

    storage = FileStorage()
    storage.reload()
