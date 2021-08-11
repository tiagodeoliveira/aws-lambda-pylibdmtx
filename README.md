Runs [pylibdmtx](https://pypi.org/project/pylibdmtx/) on AWS Lambda, using [AWS Serverless Application Model](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started.html).


The [py_dmtx_layer](./py_dmtx_layer) contains the binaries for [libdmtx](https://github.com/dmtx/libdmtx) and the necessary [binutils](https://www.gnu.org/software/binutils/) binaries to load the [shared library on python](https://github.com/python/cpython/blob/7f88aeadc19b1d3ece4723efb240e6d6753570b9/Lib/ctypes/util.py#L327)

To generate the necessary binaries run [download_binaries.sh](./download_binaries.sh). This script will start a docker container with [amazonlinux:2](https://hub.docker.com/_/amazonlinux), then it will compile `libdmtx` and download the necessary binaries for `ld & objdump`, those binaries will be copied to [py_dmtx_layer/lib](./py_dmtx_layer/lib) and [py_dmtx_layer/bin](./py_dmtx_layer/bin).

With the binaries in place you can build the project and test locally
```
$ sam build
$ sam local invoke # the expected result from the lambda below
{"statusCode": 200, "body": "[{\"content\": \"Stegosaurus\", \"rect\": [5, 6, 96, 95]}, {\"content\": \"Plesiosaurus\", \"rect\": [298, 6, 95, 95]}]"}
```

Now you can create your stack on AWS:
```
$ sam deploy --guided

CloudFormation outputs from deployed stack
-------------------------------------------------------------------
Outputs
-------------------------------------------------------------------
Key                 LambdaName
Description         -
Value               mystack-DecoderFunction-93934828asdj
-------------------------------------------------------------------
```

This will create a lambda function which name is represented on the output above, you can navigate to your AWS Console and test your function.