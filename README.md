# mise-zls

[![mise plugin](https://img.shields.io/badge/mise-plugin-blue.svg)](https://github.com/jdx/mise)

[mise](https://github.com/jdx/mise) plugin for [ZLS](https://github.com/zigtools/zls) (Zig Language Server).

**Why this plugin?** 
The existing ZLS backend in `mise` is strictly aimed at tagged releases. The primary purpose of this plugin is to allow you to install and track the `master` version of ZLS.

## Installation

Add the plugin to `mise`:

```bash
mise plugin add zls https://github.com/mzwallow/mise-zls.git
```

## Usage

Install the `master` version of `zls` (tracked directly from the master branch):

```bash
mise install zls@master
```

*(Note: Only `zls@master` is allowed for tracking the master branch.)*

Set it as the global default:

```bash
mise use -g zls@master
```

Or set it locally for a project:

```bash
mise use zls@master
```

Standard tagged versions (e.g., `zls@0.13.0`) are also supported.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License
