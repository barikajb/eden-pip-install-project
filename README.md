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

## Quick imports

```python
import eden_xi
eden_xi.load()   # makes pd, np, openai, fastapi, etc. available

df = pd.DataFrame({"a": [1, 2, 3]})
```

You can also load only what you need: `eden_xi.load("pandas", "pd")`.
If an extra isn't installed, you get a message telling you which one to install.
## License

MIT