# CoGen-Playground
A Workspace to simplify the (f)lex and yacc/(🦬) code generation - Windows only

## Folder Structure
    ├── build.bat                   # script to create the .exe
    ├── cleanup.bat                 # script to clean all build files
    ├── src                         # folder containing the .l & .y files
    └── unit                        # folder containing all build files

## Quickstart

- Place all your `.y` & `.l` files in the `/src` folder
- adjust the paths in the `.bat` file or add flex/bison to the path
- Open the directory in a VS Comand Promt
- run `build.bat`