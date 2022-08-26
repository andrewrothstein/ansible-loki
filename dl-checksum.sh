#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/grafana/loki/releases/download

dl()
{
    local ver=$1
    local lchecksums=$2
    local app=$3
    local os=$4
    local arch=$5
    local suffix=${6-}
    local platform="${os}-${arch}"
    local file="${app}-${platform}${suffix}.zip"
    local url=$MIRROR/v${ver}/$file

    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(egrep -e "$file\$" $lchecksums | awk '{print $1}')
}

dl_app() {
    local ver=$1
    local lchecksums=$2
    local app=$3
    printf "    %s:\n" $app
    dl $ver $lchecksums $app linux amd64
    dl $ver $lchecksums $app linux arm
    dl $ver $lchecksums $app linux arm64
    dl $ver $lchecksums $app darwin amd64
    dl $ver $lchecksums $app darwin arm64
    dl $ver $lchecksums $app windows amd64 .exe
}

dl_ver () {
    local ver=$1
    local lchecksums=$DIR/loki-checksums-${ver}.txt
    if [ ! -e $lchecksums ]
    then
        # https://github.com/grafana/loki/releases/download/v2.6.1/SHA256SUMS
        curl -sSLf -o $lchecksums $MIRROR/v${ver}/SHA256SUMS
    fi

    printf "  '%s':\n" $ver
    dl_app $ver $lchecksums loki
    dl_app $ver $lchecksums loki-canary
    dl_app $ver $lchecksums promtail
    dl_app $ver $lchecksums logcli
}

dl_ver ${1:-2.6.1}
