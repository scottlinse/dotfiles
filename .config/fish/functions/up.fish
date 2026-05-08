function up --description 'Update system packages'
    paru -Syu $argv
end