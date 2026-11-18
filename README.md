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