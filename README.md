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

## Output

- The script lists all files and directories in the current directory along with their sizes.
- Directories are marked with a trailing `/`.
- The output is sorted by size in ascending order.
- At the end, the script displays the total size of all top-level items.

### Example

Given the following directory structure:
```
.
├── file1.txt (10K)
├── file2.txt (20K)
└── subdir/
    ├── file3.txt (5K)
    └── file4.txt (15K)
```

Running the script:
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

## Notes

- Hidden files and directories (those starting with `.`) are not included in the output.
- The script uses `du` to calculate sizes, so ensure it is available on your system.
