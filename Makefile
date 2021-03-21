export       STACK_NAME=github-commits-crawler
export      BUCKET_NAME=github-commits-crawler
export ARTIFACTS_BUCKET=softwrdev-deploy-artifacts

build_artifacts:
	mkdir -p ./dependencies/python && \
	./venv/bin/pip install -r requirements.txt -t ./dependencies/python

package: build_artifacts
	mkdir -p ./dependencies/python && \
	./venv/bin/pip install -r requirements.txt -t ./dependencies/python && \
	aws s3api create-bucket --bucket $$BUCKET_NAME  && \
	sam package --template-file template.yaml --s3-bucket $$BUCKET_NAME --output-template-file packaged.yaml
 
deploy: package 
	sam deploy --template-file ./packaged.yaml --stack-name $$STACK_NAME --capabilities CAPABILITY_IAM --s3-bucket $$ARTIFACTS_BUCKET --s3-prefix $$BUCKET_NAME
