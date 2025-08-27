FROM rust:1.86-slim-bookworm

RUN apt update && apt install -y openjdk-17-jdk wget unzip git cmake protobuf-compiler clang python3

RUN mkdir -p /usr/lib/android-sdk &&\
    cd /tmp &&\
    wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip &&\
    unzip cmdline-tools.zip &&\
    mkdir -p /usr/lib/android-sdk/cmdline-tools/latest &&\
    cp -r cmdline-tools/* /usr/lib/android-sdk/cmdline-tools/latest

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

RUN yes | sdkmanager --licenses && sdkmanager "ndk;29.0.13846066"

CMD ["bash"]
