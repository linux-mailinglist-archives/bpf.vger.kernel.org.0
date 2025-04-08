Return-Path: <bpf+bounces-55482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A032A815AF
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 21:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C588A3E41
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF2D253F0F;
	Tue,  8 Apr 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrtqpCyH"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0572236A74;
	Tue,  8 Apr 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139369; cv=none; b=WT5wub8mIsM/hzZCi5G1LWnu6DyiVOekipk6tWY1MOV1wQ1vED4oXA+B4OS8PLJAB1loIEM6NKdu84vg4nyqC0XdrADTYR6TrH+hJpUYZzAKYPCYwAaBuaBJ97xrYyRH8x9h+D+rtf2ZNwcdtZ28zOgfJ78MgmE8TUaIYVkkMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139369; c=relaxed/simple;
	bh=GSUg5sNeSui9JMRAzL6Ok1x2MOGwlypfFoOatdXpj6Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bZA+TVxPpaAjPcyIPgY4LLhjNyWlrMaFHSLrHiD6SgxifBWObw5NJuXOONkTZ5h+sXRLDeydt1CX5oJkLHO8iOXBmYjCgMc19yAKg4svcN3PriLIXTe1yy41v8wkQqRVX5y78m5Dkb1bZdz+eST5EUwW1lYIiUEq92KLbwys4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrtqpCyH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744139361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmbLv8RPpI5n7a2CR/XZnCeWo/uMFMLdqkQHIvo8n8I=;
	b=TrtqpCyHubfQlo3tA1kOGJAo4K24xAd02Qp3cSLFr0sBENgvG/9OmtI6zh217dE9VnbIro
	DzV6QG2MMRIG/LPXtsCDfCQP0Kd3glbqPAzWXPJSGbYEcAz9oFmjUoaw9SAZbhxTJa+NiO
	zAD/G3ZGGcSXj1JqZHvHar12w8432sc=
Date: Tue, 08 Apr 2025 19:09:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <880e470b221b93882250e759e4a7334b48ec88b6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 dwarves 1/2] dwarves: Add github actions to build,
 test
To: "Alan Maguire" <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com, "Alan Maguire"
 <alan.maguire@oracle.com>
In-Reply-To: <20250401092435.1619617-2-alan.maguire@oracle.com>
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
 <20250401092435.1619617-2-alan.maguire@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 4/1/25 2:24 AM, Alan Maguire wrote:
> Borrowing heavily from libbpf github actions, add workflows to
>
> - build dwarves for gcc, LLVM
>
> - build dwarves for x86_64/aarch64 and use it to build a Linux
>   kernel including BTF generation; then run dwarves selftests
>   using generated vmlinux
>
> These workflows trigger on all pushes.  This will allow both
> developers working on dwarves to push a branch to their github
> repo and test, and also for maintainer pushes from git.kernel.org
> pahole repo to trigger tests.
>
> The build/test workflows can also be run as bash scripts locally,
> as is described in the toplevel README.
>
> Similar to libbpf, additional workflows for coverity etc
> are triggered for pushes to master/next.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Hi Alan. Thanks for addressing my comments.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Some nits and questions below.

> ---
>  .github/scripts/build-debian.sh  | 92 ++++++++++++++++++++++++++++++++
>  .github/scripts/build-kernel.sh  | 35 ++++++++++++
>  .github/scripts/build-pahole.sh  | 17 ++++++
>  .github/scripts/run-selftests.sh | 15 ++++++
>  .github/scripts/travis_wait.bash | 61 +++++++++++++++++++++
>  .github/workflows/build.yml      | 34 ++++++++++++
>  .github/workflows/codeql.yml     | 53 ++++++++++++++++++
>  .github/workflows/coverity.yml   | 33 ++++++++++++
>  .github/workflows/lint.yml       | 20 +++++++
>  .github/workflows/ondemand.yml   | 31 +++++++++++
>  .github/workflows/test.yml       | 36 +++++++++++++
>  .github/workflows/vmtest.yml     | 62 +++++++++++++++++++++
>  README                           | 18 +++++++
>  13 files changed, 507 insertions(+)
>  create mode 100755 .github/scripts/build-debian.sh
>  create mode 100755 .github/scripts/build-kernel.sh
>  create mode 100755 .github/scripts/build-pahole.sh
>  create mode 100755 .github/scripts/run-selftests.sh
>  create mode 100755 .github/scripts/travis_wait.bash
>  create mode 100644 .github/workflows/build.yml
>  create mode 100644 .github/workflows/codeql.yml
>  create mode 100644 .github/workflows/coverity.yml
>  create mode 100644 .github/workflows/lint.yml
>  create mode 100644 .github/workflows/ondemand.yml
>  create mode 100644 .github/workflows/test.yml
>  create mode 100644 .github/workflows/vmtest.yml
>
> diff --git a/.github/scripts/build-debian.sh b/.github/scripts/build-de=
bian.sh
> new file mode 100755
> index 0000000..5a0789a
> --- /dev/null
> +++ b/.github/scripts/build-debian.sh
> @@ -0,0 +1,92 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +
> +PHASES=3D(${@:-SETUP RUN CLEANUP})
> +DEBIAN_RELEASE=3D"${DEBIAN_RELEASE:-testing}"
> +CONT_NAME=3D"${CONT_NAME:-dwarves-debian-$DEBIAN_RELEASE}"
> +ENV_VARS=3D"${ENV_VARS:-}"
> +DOCKER_RUN=3D"${DOCKER_RUN:-docker run}"
> +REPO_ROOT=3D"${REPO_ROOT:-$PWD}"
> +ADDITIONAL_DEPS=3D(pkgconf)
> +EXTRA_CFLAGS=3D""
> +EXTRA_LDFLAGS=3D""
> +
> +function info() {
> +    echo -e "\033[33;1m$1\033[0m"
> +}
> +
> +function error() {
> +    echo -e "\033[31;1m$1\033[0m"
> +}
> +
> +function docker_exec() {
> +    docker exec $ENV_VARS $CONT_NAME "$@"
> +}
> +
> +set -eu
> +
> +source "$(dirname $0)/travis_wait.bash"
> +
> +for phase in "${PHASES[@]}"; do
> +    case $phase in
> +        SETUP)
> +            info "Setup phase"
> +            info "Using Debian $DEBIAN_RELEASE"
> +
> +            docker --version
> +
> +            docker pull debian:$DEBIAN_RELEASE
> +            info "Starting container $CONT_NAME"
> +            $DOCKER_RUN -v $REPO_ROOT:/build:rw \
> +                        -w /build --privileged=3Dtrue --name $CONT_NAM=
E \
> +                        -dit --net=3Dhost debian:$DEBIAN_RELEASE /bin/=
bash
> +            echo -e "::group::Build Env Setup"
> +
> +            docker_exec apt-get -y update
> +            docker_exec apt-get -y install aptitude
> +            docker_exec aptitude -y install make cmake libz-dev libelf=
-dev libdw-dev git
> +            docker_exec aptitude -y install "${ADDITIONAL_DEPS[@]}"
> +            echo -e "::endgroup::"
> +            ;;
> +        RUN|RUN_CLANG|RUN_CLANG16|RUN_GCC12)
> +            CC=3D"cc"
> +            if [[ "$phase" =3D~ "RUN_CLANG(\d+)(_ASAN)?" ]]; then
> +                ENV_VARS=3D"-e CC=3Dclang-${BASH_REMATCH[1]} -e CXX=3D=
clang++-${BASH_REMATCH[1]}"
> +                CC=3D"clang-${BASH_REMATCH[1]}"
> +            elif [[ "$phase" =3D *"CLANG"* ]]; then
> +                ENV_VARS=3D"-e CC=3Dclang -e CXX=3Dclang++"
> +                CC=3D"clang"
> +            elif [[ "$phase" =3D~ "RUN_GCC(\d+)(_ASAN)?" ]]; then
> +                ENV_VARS=3D"-e CC=3Dgcc-${BASH_REMATCH[1]} -e CXX=3Dg+=
+-${BASH_REMATCH[1]}"
> +                CC=3D"gcc-${BASH_REMATCH[1]}"
> +            fi
> +            if [[ "$CC" !=3D "cc" ]]; then
> +                docker_exec aptitude -y install "$CC"
> +            else
> +                docker_exec aptitude -y install gcc
> +            fi
> +	    git config --global --add safe.directory $REPO_ROOT
> +	    pushd $REPO_ROOT
> +	    git submodule update --init
> +	    popd
> +            docker_exec mkdir build install
> +            docker_exec ${CC} --version
> +            info "build"
> +            docker_exec cmake -DGIT_SUBMODULE=3DOFF .
> +	    docker_exec make -j$((4*$(nproc)))
> +            info "install"
> +            docker_exec make DESTDIR=3D../install install
> +            ;;
> +        CLEANUP)
> +            info "Cleanup phase"
> +            docker stop $CONT_NAME
> +            docker rm -f $CONT_NAME
> +            ;;
> +        *)
> +            echo >&2 "Unknown phase '$phase'"
> +            exit 1
> +    esac
> +done
> diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-ke=
rnel.sh
> new file mode 100755
> index 0000000..41a3cf8
> --- /dev/null
> +++ b/.github/scripts/build-kernel.sh
> @@ -0,0 +1,35 @@
> +#!/usr/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +
> +GITHUB_WORKSPACE=3D${GITHUB_WORKSPACE:-$(dirname $0)/../..}
> +INPUTS_ARCH=3D${INPUTS_ARCH:-$(uname -m)}
> +REPO=3D${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf=
-next.git}
> +REPO_BRANCH=3D${REPO_BRANCH:-master}
> +REPO_TARGET=3D${GITHUB_WORKSPACE}/.kernel
> +
> +export PATH=3D${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
> +export PAHOLE=3D${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
> +
> +which pahole
> +$PAHOLE --version
> +
> +if [[ ! -d $REPO_TARGET ]]; then
> +	git clone $REPO $REPO_TARGET
> +fi
> +cd $REPO_TARGET
> +git checkout $REPO_BRANCH
> +
> +cat tools/testing/selftests/bpf/config \
> +    tools/testing/selftests/bpf/config.${INPUTS_ARCH} > .config
> +# this file might or might not exist depending on kernel version
> +if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
> +	cat tools/testing/selftests/bpf/config.vm >> .config
> +fi
> +make olddefconfig && make prepare
> +grep PAHOLE .config
> +grep _BTF .config

This looks like debugging code, but instead of removing it I think it
is useful to dump entire config to the output (hence job log) in case
something goes wrong. How about `cat .config` before make
olddefconfig?

> +make -j $((4*$(nproc))) all
> +
> diff --git a/.github/scripts/build-pahole.sh b/.github/scripts/build-pa=
hole.sh
> new file mode 100755
> index 0000000..64f9eea
> --- /dev/null
> +++ b/.github/scripts/build-pahole.sh
> @@ -0,0 +1,17 @@
> +#!/usr/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +
> +GITHUB_WORKSPACE=3D${GITHUB_WORKSPACE:-$(dirname $0)/../..}
> +cd $GITHUB_WORKSPACE
> +git config --global --add safe.directory $GITHUB_WORKSPACE
> +git submodule update --init
> +mkdir -p build
> +cd build
> +pwd
> +cmake -DGIT_SUBMODULE=3DOFF -DBUILD_SHARED_LIBS=3DOFF ..

With these cmake options, what version of libbpf is used?

On CI a build/test of both static and shared variants should be
tested, ideally. But that doesn't have to be a part of this patchset.

> +make -j$((4*$(nproc))) all
> +make DESTDIR=3D../install install
> +
> diff --git a/.github/scripts/run-selftests.sh b/.github/scripts/run-sel=
ftests.sh
> new file mode 100755
> index 0000000..f9ba24e
> --- /dev/null
> +++ b/.github/scripts/run-selftests.sh
> @@ -0,0 +1,15 @@
> +#!/usr/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +
> +GITHUB_WORKSPACE=3D${GITHUB_WORKSPACE:-$(pwd)}
> +VMLINUX=3D${GITHUB_WORKSPACE}/.kernel/vmlinux
> +SELFTESTS=3D${GITHUB_WORKSPACE}/tests
> +cd $SELFTESTS
> +export PATH=3D${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
> +which pahole
> +pahole --version
> +vmlinux=3D$VMLINUX ./tests
> +
> diff --git a/.github/scripts/travis_wait.bash b/.github/scripts/travis_=
wait.bash
> new file mode 100755
> index 0000000..acf6ad1
> --- /dev/null
> +++ b/.github/scripts/travis_wait.bash
> @@ -0,0 +1,61 @@
> +# This was borrowed from https://github.com/travis-ci/travis-build/tre=
e/master/lib/travis/build/bash
> +# to get around https://github.com/travis-ci/travis-ci/issues/9979. It=
 should probably be removed
> +# as soon as Travis CI has started to provide an easy way to export th=
e functions to bash scripts.

This comment makes me think travis_wait.bash could be removed.
Do you know if it's actually necessary (for build-debian.sh)?

> +
> +travis_jigger() {
> +  local cmd_pid=3D"${1}"
> +  shift
> +  local timeout=3D"${1}"
> +  shift
> +  local count=3D0
> +
> +  echo -e "\\n"
> +
> +  while [[ "${count}" -lt "${timeout}" ]]; do
> +    count=3D"$((count + 1))"
> +    echo -ne "Still running (${count} of ${timeout}): ${*}\\r"
> +    sleep 60
> +  done
> +
> +  echo -e "\\n${ANSI_RED}Timeout (${timeout} minutes) reached. Termina=
ting \"${*}\"${ANSI_RESET}\\n"
> +  kill -9 "${cmd_pid}"
> +}
> +
> +travis_wait() {
> +  local timeout=3D"${1}"
> +
> +  if [[ "${timeout}" =3D~ ^[0-9]+$ ]]; then
> +    shift
> +  else
> +    timeout=3D20
> +  fi
> +
> +  local cmd=3D("${@}")
> +  local log_file=3D"travis_wait_${$}.log"
> +
> +  "${cmd[@]}" &>"${log_file}" &
> +  local cmd_pid=3D"${!}"
> +
> +  travis_jigger "${!}" "${timeout}" "${cmd[@]}" &
> +  local jigger_pid=3D"${!}"
> +  local result
> +
> +  {
> +    set +e
> +    wait "${cmd_pid}" 2>/dev/null
> +    result=3D"${?}"
> +    ps -p"${jigger_pid}" &>/dev/null && kill "${jigger_pid}"
> +    set -e
> +  }
> +
> +  if [[ "${result}" -eq 0 ]]; then
> +    echo -e "\\n${ANSI_GREEN}The command ${cmd[*]} exited with ${resul=
t}.${ANSI_RESET}"
> +  else
> +    echo -e "\\n${ANSI_RED}The command ${cmd[*]} exited with ${result}=
.${ANSI_RESET}"
> +  fi
> +
> +  echo -e "\\n${ANSI_GREEN}Log:${ANSI_RESET}\\n"
> +  cat "${log_file}"
> +
> +  return "${result}"
> +}
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> new file mode 100644
> index 0000000..25a395f
> --- /dev/null
> +++ b/.github/workflows/build.yml
> @@ -0,0 +1,34 @@
> +name: dwarves-build
> +
> +on:
> +  pull_request:
> +  push:
> +  schedule:
> +    - cron:  '0 18 * * *'
> +
> +concurrency:
> +  group: ci-build-${{ github.head_ref }}
> +  cancel-in-progress: true
> +
> +jobs:
> +
> +  debian:
> +    runs-on: ubuntu-latest
> +    name: Debian Build (${{ matrix.name }})
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        include:
> +          - name: default
> +            target: RUN
> +          - name: gcc-12
> +            target: RUN_GCC12
> +          - name: clang
> +            target: RUN_CLANG
> +    steps:
> +      - uses: actions/checkout@v4
> +        name: Checkout
> +      - name: setup
> +        shell: bash
> +        run: ./.github/scripts/build-debian.sh SETUP ${{ matrix.target=
 }}
> +
> diff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.ym=
l
> new file mode 100644
> index 0000000..a140be1
> --- /dev/null
> +++ b/.github/workflows/codeql.yml
> @@ -0,0 +1,53 @@
> +---
> +# vi: ts=3D2 sw=3D2 et:
> +
> +name: "CodeQL"
> +
> +on:
> +  push:
> +    branches:
> +      - master
> +  pull_request:
> +    branches:
> +      - master
> +      - next
> +
> +permissions:
> +  contents: read
> +
> +jobs:
> +  analyze:
> +    name: Analyze
> +    runs-on: ubuntu-latest
> +    concurrency:
> +      group: ${{ github.workflow }}-${{ matrix.language }}-${{ github.=
ref }}
> +      cancel-in-progress: true
> +    permissions:
> +      actions: read
> +      security-events: write
> +
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        language: ['cpp', 'python']
> +
> +    steps:
> +      - name: Checkout repository
> +        uses: actions/checkout@v4
> +
> +      - name: Initialize CodeQL
> +        uses: github/codeql-action/init@v2
> +        with:
> +          languages: ${{ matrix.language }}
> +          queries: +security-extended,security-and-quality
> +
> +      - name: Setup
> +        uses: ./.github/actions/setup
> +
> +      - name: Build
> +        run: |
> +          source /tmp/ci_setup
> +          make -C ./src
> +
> +      - name: Perform CodeQL Analysis
> +        uses: github/codeql-action/analyze@v2
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverit=
y.yml
> new file mode 100644
> index 0000000..97a04d4
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,33 @@
> +name: dwarves-ci-coverity
> +
> +on:
> +  push:
> +    branches:
> +      - master
> +      - next
> +  schedule:
> +    - cron:  '0 18 * * *'
> +
> +jobs:
> +  coverity:
> +    runs-on: ubuntu-latest
> +    name: Coverity
> +    env:
> +      COVERITY_SCAN_TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
> +    steps:
> +      - uses: actions/checkout@v4
> +      - uses: ./.github/actions/setup
> +      - name: Run coverity
> +        if: ${{ env.COVERITY_SCAN_TOKEN }}
> +        run: |
> +          source /tmp/ci_setup
> +          export COVERITY_SCAN_NOTIFICATION_EMAIL=3D"${AUTHOR_EMAIL}"
> +          export COVERITY_SCAN_BRANCH_PATTERN=3D${GITHUB_REF##refs/*/}
> +          export TRAVIS_BRANCH=3D${COVERITY_SCAN_BRANCH_PATTERN}
> +          scripts/coverity.sh
> +        env:
> +          COVERITY_SCAN_PROJECT_NAME: dwarves
> +          COVERITY_SCAN_BUILD_COMMAND_PREPEND: 'cmake .'
> +          COVERITY_SCAN_BUILD_COMMAND: 'make'
> +      - name: SCM log
> +        run: cat /home/runner/work/dwarves/cov-int/scm_log.txt
> diff --git a/.github/workflows/lint.yml b/.github/workflows/lint.yml
> new file mode 100644
> index 0000000..ca13052
> --- /dev/null
> +++ b/.github/workflows/lint.yml
> @@ -0,0 +1,20 @@
> +name: "lint"
> +
> +on:
> +  pull_request:
> +  push:
> +    branches:
> +      - master
> +      - next
> +
> +jobs:
> +  shellcheck:
> +    name: ShellCheck
> +    runs-on: ubuntu-latest
> +    steps:
> +      - name: Checkout repository
> +        uses: actions/checkout@v4
> +      - name: Run ShellCheck
> +        uses: ludeeus/action-shellcheck@master
> +        env:
> +          SHELLCHECK_OPTS: --severity=3Derror
> diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondeman=
d.yml
> new file mode 100644
> index 0000000..5f3034f
> --- /dev/null
> +++ b/.github/workflows/ondemand.yml
> @@ -0,0 +1,31 @@
> +name: ondemand
> +
> +on:
> +  workflow_dispatch:
> +    inputs:
> +      arch:
> +        default: 'x86_64'
> +        required: true
> +      llvm-version:
> +        default: '18'
> +        required: true
> +      kernel:
> +        default: 'LATEST'
> +        required: true
> +      pahole:
> +        default: "master"
> +        required: true
> +      runs-on:
> +        default: 'ubuntu-24.04'
> +        required: true
> +
> +jobs:
> +  vmtest:
> +    name: ${{ inputs.kernel }} kernel llvm-${{ inputs.llvm-version }} =
pahole@${{ inputs.pahole }}
> +    uses: ./.github/workflows/vmtest.yml
> +    with:
> +      runs_on: ${{ inputs.runs-on }}
> +      kernel: ${{ inputs.kernel }}
> +      arch: ${{ inputs.arch }}
> +      llvm-version: ${{=20inputs.llvm-version }}
> +      pahole: ${{ inputs.pahole }}
> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
> new file mode 100644
> index 0000000..f11ebfe
> --- /dev/null
> +++ b/.github/workflows/test.yml
> @@ -0,0 +1,36 @@
> +name: dwarves-ci
> +
> +on:
> +  pull_request:
> +  push:
> +  schedule:
> +    - cron:  '0 18 * * *'
> +
> +concurrency:
> +  group: ci-test-${{ github.head_ref }}
> +  cancel-in-progress: true
> +
> +jobs:
> +  vmtest:
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        include:
> +          - kernel: 'LATEST'
> +            runs_on: 'ubuntu-24.04'
> +            arch: 'x86_64'
> +            llvm-version: '18'
> +            pahole: 'master'
> +          - kernel: 'LATEST'
> +            runs_on: 'ubuntu-24.04-arm'
> +            arch: 'aarch64'
> +            llvm-version: '18'
> +            pahole: 'tmp.master'
> +    name: Linux ${{ matrix.kernel }}
> +    uses: ./.github/workflows/vmtest.yml
> +    with:
> +      runs_on: ${{ matrix.runs_on }}
> +      kernel: ${{ matrix.kernel }}
> +      arch: ${{ matrix.arch }}
> +      llvm-version: ${{ matrix.llvm-version }}
> +      pahole: ${{ matrix.pahole }}
> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.ym=
l
> new file mode 100644
> index 0000000..0f66eed
> --- /dev/null
> +++ b/.github/workflows/vmtest.yml
> @@ -0,0 +1,62 @@
> +name: 'Build kernel run selftests via vmtest'
> +
> +on:
> +  workflow_call:
> +    inputs:
> +      runs_on:
> +        required: true
> +        default: 'ubuntu-24.04'
> +        type: string
> +      arch:
> +        description: 'what arch to test'
> +        required: true
> +        default: 'x86_64'
> +        type: string
> +      kernel:
> +        description: 'kernel version or LATEST'
> +        required: true
> +        default: 'LATEST'
> +        type: string
> +      pahole:
> +        description: 'pahole rev or branch'
> +        required: false
> +        default: 'master'
> +        type: string
> +      llvm-version:
> +        description: 'llvm version'
> +        required: false
> +        default: '18'
> +        type: string
> +jobs:
> +  vmtest:
> +    name: pahole@${{ inputs.arch }}
> +    runs-on: ${{ inputs.runs_on }}
> +    steps:
> +
> +      - uses: actions/checkout@v4
> +
> +      - name: Setup environment
> +        uses: libbpf/ci/setup-build-env@v3
> +        with:
> +          pahole: ${{ inputs.pahole }}
> +          arch: ${{ inputs.arch }}
> +          llvm-version: ${{ inputs.llvm-version }}

I think I mentioned it before, but libbpf/ci/setup-build-env checks
out and installs pahole too, which is unnecessary here. Have you tried
removing this step from the job?

You should be able to reuse a piece of SETUP logic from
build-debian.sh to install pahole's dependencies. Although you kernel
build deps are needed too.

I could make a change in libbpf/ci/setup-build-env to accept a special
`pahole` input value or check for env variable to NOT build pahole.
What do you think?

> +
> +      - name: Build,install current pahole
> +        shell: bash
> +        run: .github/scripts/build-pahole.sh
> +
> +      - name: Get kernel source
> +        uses: libbpf/ci/get-linux-source@v3
> +        with:
> +          repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/b=
pf-next.git'
> +          dest: '${{ github.workspace }}/.kernel'
> +
> +      - name: Configure, build kernel with current pahole
> +        shell: bash
> +        run: .github/scripts/build-kernel.sh
> +
> +      - name: Run selftests
> +        shell: bash
> +        run: .github/scripts/run-selftests.sh
> +
> diff --git a/README b/README
> index 7ee3b87..a938266 100644
> --- a/README
> +++ b/README
> @@ -21,3 +21,21 @@ cmake Options:
>  You may need to update the libbpf git submodule:
>=20=20
>=20 git submodule update --init --recursive
> +
> +Testing:
> +
> +Tests are available in the tests subdirectory and should be run prior =
to
> +submitting patches.  Patches that add functionality should add to test=
s
> +here also.  Tests can be run by
> +
> +- running the scripts directly using a pre-existing vmlinux binary; i.=
e.
> +	cd tests ; vmlinux=3D/path/2/vmlinux ./tests
> +  (the vmlinux binary must contain DWARF to be converted to BTF)
> +
> +- running the tests via local scripts in .github/scripts; i.e.
> +	bash .github/scripts/build-pahole.sh; \
> +	bash .github/scripts/build-kernel.sh; \
> +	bash .github/scripts/run-selftests.sh
> +- via GitHub actions: push a branch to a GitHub repo; actions will be
> +  triggered for build and test matching the above steps.  See the "Act=
ions"
> +  tab in the github repo for info on job pass/fail and logs.

