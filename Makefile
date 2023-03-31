VERSION ?= "1"
OPENAPI_GENERATOR_CMD ?= "openapi-generator"
NAME ?= "xprizo_sdk_py"
API_CLIENT_DEST_DIR ?= "../xprizo-sdk-py"

generate-python-sdk:
	${OPENAPI_GENERATOR_CMD} generate -i spec.yaml -o ${API_CLIENT_DEST_DIR} -g python \
		--additional-properties=packageVersion=$(VERSION) \
		--additional-properties=packageName=$(NAME)

sdist-python-sdk:
	cd ${API_CLIENT_DEST_DIR} && python3 setup.py bdist_wheel

push-python-sdk:
	twine upload --config-file ${API_CLIENT_DEST_DIR}/.pypirc --repository pypi $(API_CLIENT_DEST_DIR)/dist/$(NAME)-$(VERSION)-py3-none-any.whl

all: generate-python-sdk sdist-python-sdk push-python-sdk