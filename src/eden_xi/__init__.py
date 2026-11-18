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