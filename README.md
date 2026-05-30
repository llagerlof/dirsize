# dirsize

`dirsize` lists the top-level files and directories in the current directory, sorted by disk usage from smallest to largest, and prints the total size of the listed items.

## Installation

Preferred setup: clone the project into `~/repos/` and expose the script through `~/.local/bin/`.

1. Clone the repository into `~/repos/`:
   ```bash
   mkdir -p ~/repos
   git clone https://github.com/llagerlof/dirsize ~/repos/dirsize
   ```

2. Make sure the script is executable:
   ```bash
   chmod +x ~/repos/dirsize/dirsize
   ```

3. Create `~/.local/bin/` if needed and symlink the script there:
   ```bash
   mkdir -p ~/.local/bin
   ln -sf ~/repos/dirsize/dirsize ~/.local/bin/dirsize
   ```

4. Ensure `~/.local/bin` is in your `PATH`.

5. Run it from any directory:
   ```bash
   dirsize
   ```

## Usage

1. Run the script in the directory you want to analyze:
   ```bash
   dirsize
   ```

2. To exclude hidden files and directories from the analysis, use the `-h` option:
   ```bash
   dirsize -h
   ```

## Output

- The script lists all files and directories in the current directory along with their sizes.
- Directories are marked with a trailing `/`.
- The output is sorted by size in ascending order.
- At the end, the script displays the total size of all top-level items.

### Example

Given the following directory structure:
```
.
├── .hidden_file (5K)
├── file1.txt (10K)
├── file2.txt (2.1MB)
└── subdir/
    ├── file3.txt (5K)
    └── file4.txt (15K)
```

Running the script without `-h`:
```bash
dirsize
```

Output:
```
5K - .hidden_file
10K - file1.txt
20K - subdir/
2.1MB - file2.txt
TOTAL: 2.1MiB
```

Running the script with `-h`:
```bash
dirsize -h
```

Output:
```
10K - file1.txt
20K - subdir/
2.1MB - file2.txt
TOTAL: 2.1MiB
```

## Testing

Run the regression test suite with:

```bash
bash tests/test_dirsize.sh
```

The test creates a temporary directory structure, verifies that hidden items are included by default, verifies that `-h` excludes them, and checks the reported sizes and totals against `du`.

## Notes

- Hidden files and directories (those starting with `.`) are included by default.
- Passing `-h` excludes hidden files and directories from both the listing and the total.
- The script uses `du` to calculate sizes, so ensure it is available on your system.
- The script and tests expect GNU `du` and `numfmt`.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
