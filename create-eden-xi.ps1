$ErrorActionPreference = "Stop"
$root = "eden-pip install project"
$utf8 = New-Object System.Text.UTF8Encoding($false)
New-Item -ItemType Directory -Force -Path (Join-Path $root "src\eden_xi") | Out-Null

$content = @'
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "eden-xi"
version = "0.1.0"
description = "Eden.xi curated Python stack: a core bundle plus modular AI, web, and data extras."
readme = "README.md"
requires-python = ">=3.9"
license = { text = "MIT" }
authors = [{ name = "Barika Johnbazia" }]
keywords = ["eden", "bundle", "stack", "ai", "web", "data"]
classifiers = [
    "Development Status :: 3 - Alpha",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
    "Operating System :: OS Independent",
]
dependencies = [
    "requests>=2.31.0",
    "python-dotenv>=1.0.0",
    "pydantic>=2.0.0",
    "rich>=13.0.0",
]

[project.optional-dependencies]
ai = ["groq>=0.11.0", "openai>=1.0.0"]
web = ["fastapi>=0.110.0", "uvicorn>=0.29.0"]
data = ["pandas>=2.0.0", "numpy>=1.26.0"]
all = ["eden-xi[ai,web,data]"]

[tool.hatch.build.targets.wheel]
packages = ["src/eden_xi"]
'@
[System.IO.File]::WriteAllText((Join-Path (Join-Path (Get-Location) $root) "pyproject.toml"), ($content -replace "`r?`n", "`r`n") + "`r`n", $utf8)

$content = @'
# eden-xi

A curated Python stack from **Eden.xi Tech Solutions**. Install the lightweight
core bundle, or add modular stacks for AI, web, and data work.

## Installation

Core bundle (`requests`, `python-dotenv`, `pydantic`, `rich`):

```bash
pip install eden-xi
```

Individual extras:

```bash
pip install "eden-xi[ai]"     # groq, openai
pip install "eden-xi[web]"    # fastapi, uvicorn
pip install "eden-xi[data]"   # pandas, numpy
```

Full stack:

```bash
pip install "eden-xi[all]"
```

## Usage

```python
import eden_xi

print(eden_xi.__version__)
print(eden_xi.status())
```

`status()` returns a dictionary showing which core and optional packages are
installed. Importing `eden_xi` never fails if an optional stack is missing.

## License

MIT
'@
[System.IO.File]::WriteAllText((Join-Path (Join-Path (Get-Location) $root) "README.md"), ($content -replace "`r?`n", "`r`n") + "`r`n", $utf8)

$content = @'
MIT License

Copyright (c) 2026 Barika Johnbazia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'@
[System.IO.File]::WriteAllText((Join-Path (Join-Path (Get-Location) $root) "LICENSE"), ($content -replace "`r?`n", "`r`n") + "`r`n", $utf8)

$content = @'
"""eden-xi: a curated dependency bundle from Eden.xi Tech Solutions."""

__version__ = "0.1.0"

# Core dependencies (installed with the base package).
import dotenv
import pydantic
import requests
import rich

# Optional dependencies: missing ones are set to None so that
# `import eden_xi` never fails on a base-only install.
try:
    import groq
except ImportError:
    groq = None

try:
    import openai
except ImportError:
    openai = None

try:
    import fastapi
except ImportError:
    fastapi = None

try:
    import uvicorn
except ImportError:
    uvicorn = None

try:
    import pandas
except ImportError:
    pandas = None

try:
    import numpy
except ImportError:
    numpy = None


def status():
    """Return a dict showing which core and optional stacks are installed."""
    core = {
        "requests": requests is not None,
        "dotenv": dotenv is not None,
        "pydantic": pydantic is not None,
        "rich": rich is not None,
    }
    ai = {"groq": groq is not None, "openai": openai is not None}
    web = {"fastapi": fastapi is not None, "uvicorn": uvicorn is not None}
    data = {"pandas": pandas is not None, "numpy": numpy is not None}
    return {
        "version": __version__,
        "core": core,
        "ai": ai,
        "web": web,
        "data": data,
    }


__all__ = ["__version__", "status"]
'@
[System.IO.File]::WriteAllText((Join-Path (Join-Path (Get-Location) $root) "src\eden_xi\__init__.py"), ($content -replace "`r?`n", "`r`n") + "`r`n", $utf8)

Write-Host "Created project in $root"
