.PHONY: setup data train test web

setup:
	bash setup.sh
	pip install -r requirements.txt

data:
	python src/data_gen.py

train:
	python src/models/train_model.py

test:
	pytest tests/

web:
	python src/app.py
