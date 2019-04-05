# Side Codes --------------------------------------------------------------

rm(list=ls()) # This is a side thing: Removes all the objects from the environment window

# Better way to explicitly create equal-length vectors before we operate on them
# The rep function is very useful for this task, letting us create a vector with repeated elements:
    
    rep(1:5, 3)
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
    
    rep(1:5, each = 3)
    ##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
    
    rep(1:5, times = 1:5)
    ##  [1] 1 2 2 3 3 3 4 4 4 4 5 5 5 5 5
    
    rep(1:5, length.out = 7)
    ## [1] 1 2 3 4 5 1 2
    rep(1:5, times = 3)
    
    
# Alt + 0 folds.
# Alt + Shift + O unfolds
    
# You can load all sheets in a workbook, using the lapply()
    
    path <- "C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx"
    
    Read_all <- lapply(excel_sheets(path), read_excel, path = path) 