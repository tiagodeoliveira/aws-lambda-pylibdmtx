build-PyDMTXLayer:
	mkdir -p "$(ARTIFACTS_DIR)/python"
	python3.8 -m pip install -r requirements.txt -t "$(ARTIFACTS_DIR)/python"
	cp -R lib "$(ARTIFACTS_DIR)"
	cp -R bin "$(ARTIFACTS_DIR)"