Runs [pylibdmtx](https://pypi.org/project/pylibdmtx/) on AWS Lambda

The [py_dmtx_layer](./py_dmtx_layer) contains the binaries for [libdmtx](https://github.com/dmtx/libdmtx) and the necessary [binutils](https://www.gnu.org/software/binutils/) binaries to load the [shared library on python](https://github.com/python/cpython/blob/7f88aeadc19b1d3ece4723efb240e6d6753570b9/Lib/ctypes/util.py#L327)

To generate the necessary binaries run [download_binaries.sh](./download_binaries.sh). This script will start a docker container with [amazonlinux:2](https://hub.docker.com/_/amazonlinux), then it will compile `libdmtx` and download the necessary binaries for `ld & objdump`, those binaries will be copied to [py_dmtx_layer/lib](./py_dmtx_layer/lib) and [py_dmtx_layer/bin](./py_dmtx_layer/bin).

With the binaries in place you can create your [Serverless Application Model](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started.html) stack:
```
sam init
sam deploy --guided
```