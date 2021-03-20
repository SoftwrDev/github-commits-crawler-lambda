build_artifacts:
	mkdir -p ./dependencies/python && \
	./venv/bin/pip install -r requirements.txt -t ./dependencies/python

package: build_artifacts
	mkdir -p ./dependencies/python && \
	./venv/bin/pip install -r requirements.txt -t ./dependencies/python && \
	aws s3api create-bucket --bucket mangum-test  && \
	sam package --template-file template.yaml --s3-bucket mangum-test --output-template-file packaged.yaml
 
deploy: package 
	sam deploy --template-file ./packaged.yaml --stack-name mangum-test 
