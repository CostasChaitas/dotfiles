function set-jdk
    set -l jdkversion $argv[1]
    set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-$jdkversion.jdk/Contents/Home
    set -gx PATH $PATH $JAVA_HOME/bin
    java -version
end
