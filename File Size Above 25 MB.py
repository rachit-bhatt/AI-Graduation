import os

def get_files_above_size(directory='.', size_limit_mb=25):
    file_count = 0

    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            # Get file size in bytes
            file_size_bytes = os.path.getsize(file_path)
            # Convert bytes to megabytes
            file_size_mb = file_size_bytes / (1024 * 1024)

            if file_size_mb > size_limit_mb:
                file_count += 1
                print(f"{file_path} - {file_size_mb:.2f} MB")

    return file_count

if __name__ == "__main__":
    directory = '.'  # You can specify the directory here or leave it as the current directory
    size_limit_mb = 25

    print(f"Files above {size_limit_mb} MB in size:")
    count = get_files_above_size(directory, size_limit_mb)
    
    print(f"\nTotal number of files above {size_limit_mb} MB: {count}")
