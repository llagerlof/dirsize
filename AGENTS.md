# AGENTS.md

## Project Summary

`dirsize` is a small Bash CLI that reports disk usage for top-level items in the current directory.

## Behavior

- `dirsize` includes hidden and non-hidden top-level items.
- `dirsize -h` excludes hidden top-level items from both the listing and the total.

## Key Files

- `dirsize` contains the command implementation.
- `tests/test_dirsize.sh` contains the regression test for hidden-item handling and totals.
- `README.md` contains installation, usage, and test instructions.

## Validation

Run:

```bash
bash tests/test_dirsize.sh
```

See `README.md` for the full command usage and test instructions.