"""eden-xi: a curated dependency bundle from Eden.xi Tech Solutions."""

import importlib
import importlib.util
import sys
import warnings

__version__ = "0.2.0"

# Core dependencies (installed with the base package).
import dotenv
import pydantic
import requests
import rich

# Optional packages and the extra that provides each one.
_OPTIONAL = {
    "groq": "ai",
    "openai": "ai",
    "fastapi": "web",
    "uvicorn": "web",
    "pandas": "data",
    "numpy": "data",
}
_ALIASES = {"pd": "pandas", "np": "numpy"}


def __getattr__(name):
    """Load optional packages on first use (also powers `from eden_xi import pd`)."""
    real = _ALIASES.get(name, name)
    if real in _OPTIONAL:
        try:
            return importlib.import_module(real)
        except ImportError:
            raise ImportError(
                f"'{real}' is not installed. Run: pip install \"eden-xi[{_OPTIONAL[real]}]\""
            ) from None
    raise AttributeError(f"module 'eden_xi' has no attribute '{name}'")


def load(*names):
    """Put installed libraries into the caller's namespace.

    eden_xi.load()                # everything installed, plus pd and np
    eden_xi.load("pandas", "pd")  # only these
    """
    namespace = sys._getframe(1).f_globals
    wanted = names or tuple(_OPTIONAL) + tuple(_ALIASES)
    for name in wanted:
        try:
            namespace[name] = __getattr__(name)
        except ImportError as exc:
            if names:
                warnings.warn(str(exc), stacklevel=2)


def status():
    """Return a dict showing which core and optional stacks are installed."""
    def has(pkg):
        return importlib.util.find_spec(pkg) is not None

    return {
        "version": __version__,
        "core": {
            "requests": has("requests"),
            "dotenv": has("dotenv"),
            "pydantic": has("pydantic"),
            "rich": has("rich"),
        },
        "ai": {"groq": has("groq"), "openai": has("openai")},
        "web": {"fastapi": has("fastapi"), "uvicorn": has("uvicorn")},
        "data": {"pandas": has("pandas"), "numpy": has("numpy")},
    }


__all__ = ["__version__", "load", "status"]