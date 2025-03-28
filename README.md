# dirsize

Identify the biggest directory and file sizes in the current directory.

## Usage

1. Make the script executable:
   ```bash
   chmod +x dirsize
   ```

2. Run the script in the directory you want to analyze:
   ```bash
   ./dirsize
   ```

3. To include hidden files and directories in the analysis, use the `-h` option:
   ```bash
   ./dirsize -h
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
├── file2.txt (20K)
└── subdir/
    ├── file3.txt (5K)
    └── file4.txt (15K)
```

Running the script without `-h`:
```bash
./dirsize
```

Output:
```
5K - subdir/
10K - file1.txt
20K - file2.txt
TOTAL: 35K
```

Running the script with `-h`:
```bash
./dirsize -h
```

Output:
```
5K - .hidden_file
5K - subdir/
10K - file1.txt
20K - file2.txt
TOTAL: 40K
```

## Notes

- Hidden files and directories (those starting with `.`) are excluded by default unless the `-h` option is used.
- The script uses `du` to calculate sizes, so ensure it is available on your system.
