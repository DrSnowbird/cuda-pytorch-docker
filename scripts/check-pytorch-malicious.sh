#!/bin/bash -x

# ref: https://www.wiz.io/blog/malicious-pytorch-dependency-torchtriton-on-pypi-everything-you-need-to-know
#
python3 -c "import pathlib;import importlib.util;s=importlib.util.find_spec('triton'); affected=any(x.name == 'triton' for x in (pathlib.Path(s.submodule_search_locations[0] if s is not None else '/' ) / 'runtime').glob('*'));print('You are {}affected'.format('' if affected else 'not '))"
