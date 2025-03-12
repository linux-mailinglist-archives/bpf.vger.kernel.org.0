Return-Path: <bpf+bounces-53925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFFA5E550
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 21:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687777A44E4
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0941EDA20;
	Wed, 12 Mar 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cAHnyM9U"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43041EB192
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811347; cv=none; b=VqYHeP+RyCQI/wTH9hQO2KXqRxKY1OPEI4eOmWdh5XzfDCfpY+iMLXP/Giq3JLYaPLU7NYhN9P+OOeYg0XWkVX9GAZpmKnghU2Rs//Wbdl6Eq7e2vcKhKyC508AhUS2G0O63BtGplGROobe6CYBF5dUAwK/luYodGXpGMbiIlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811347; c=relaxed/simple;
	bh=cR8IrSw67SXN9xOiC53rHR0ldNCJXWdzziBEdQWdEOE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=af+MautQpuvPnYe3J1CFOcXxgc8GO5Yf5Ia7unnbE29bXIG/rMzP8Cm1AxOA4fyLjGtueQbXmKnr/7kRCT83jJ5qrh9DQd5qRAUcuDxUCC4ceqOXMgBegjPzfADDpSe+Ndm+GBtKsTMQuLf8bvhVG2Km8e8cZdOR959sWF02Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cAHnyM9U; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741811331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6f8GF2sVPqeMstiCMo7kvP+EpG8CY9A6KPK0u46BgA=;
	b=cAHnyM9UsA8XvSdjp9pTQSqC3uHmKoQruPALvM2IcMbN9pYuc9VKUsDebDhbEdnT35wQMi
	Pc+DwdwEdNlJUaAzB7pmLcWEiqOMNJAVbfWqrsHM1CZyVw9ZXtCp3GUNpSleUg2q5/80ty
	lYLgD5GGp+307kOpp8oYuOdbLgD0jHo=
Date: Wed, 12 Mar 2025 20:28:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <41e06a415837a8ae59b61e653527331a63a8d9ba@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves 1/2] dwarves: Add github actions to build, test
To: "Alan Maguire" <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, song@kernel.org,
 eddyz87@gmail.com, olsajiri@gmail.com, "Alan Maguire"
 <alan.maguire@oracle.com>
In-Reply-To: <20250306170455.2957229-2-alan.maguire@oracle.com>
References: <20250306170455.2957229-1-alan.maguire@oracle.com>
 <20250306170455.2957229-2-alan.maguire@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 3/6/25 9:04 AM, Alan Maguire wrote:
> Borrowing heavily from libbpf github actions, add workflows to
>
> - build dwarves for gcc, LLVM
>
> - build dwarves for x86_64/aarch64 and use it to build a Linux
>   kernel including BTF generation; then run dwarves selftests
>   using generated vmlinux
>
> These workflows trigger on all pushes.  This will alow both
> developers working on dwarves to push a branch to their github
> repo and test, and also for maintainer pushes from git.kernel.org
> pahole repo to trigger tests.
>
> And similar to libbpf, additional workflows for coverity etc
> are triggered for pushes to master/next.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .github/actions/debian/action.yml | 16 ++++++
>  .github/actions/setup/action.yml  | 23 ++++++++
>  .github/workflows/build.yml       | 37 ++++++++++++
>  .github/workflows/codeql.yml      | 53 +++++++++++++++++
>  .github/workflows/coverity.yml    | 33 +++++++++++
>  .github/workflows/lint.yml        | 20 +++++++
>  .github/workflows/ondemand.yml    | 31 ++++++++++
>  .github/workflows/test.yml        | 36 ++++++++++++
>  .github/workflows/vmtest.yml      | 94 +++++++++++++++++++++++++++++++
>  ci/managers/debian.sh             | 88 +++++++++++++++++++++++++++++
>  ci/managers/travis_wait.bash      | 61 ++++++++++++++++++++
>  11 files changed, 492 insertions(+)
>  create mode 100644 .github/actions/debian/action.yml
>  create mode 100644 .github/actions/setup/action.yml
>  create mode 100644 .github/workflows/build.yml
>  create mode 100644 .github/workflows/codeql.yml
>  create mode 100644 .github/workflows/coverity.yml
>  create mode 100644 .github/workflows/lint.yml
>  create mode 100644 .github/workflows/ondemand.yml
>  create mode 100644 .github/workflows/test.yml
>  create mode 100644 .github/workflows/vmtest.yml
>  create mode 100755 ci/managers/debian.sh
>  create mode 100644 ci/managers/travis_wait.bash

Hi Alan. See comments below.

>
> diff --git a/.github/actions/debian/action.yml b/.github/actions/debian=
/action.yml
> new file mode 100644
> index 0000000..23d48ec
> --- /dev/null
> +++ b/.github/actions/debian/action.yml
> @@ -0,0 +1,16 @@
> +name: 'debian'
> +description: 'Build'
> +inputs:
> +  target:
> +    description: 'Run target'
> +    required: true
> +runs:
> +  using: "composite"
> +  steps:
> +    - run: |
> +        source /tmp/ci_setup
> +        bash -x $CI_ROOT/managers/debian.sh SETUP
> +        bash -x $CI_ROOT/managers/debian.sh ${{ inputs.target }}
> +        bash -x $CI_ROOT/managers/debian.sh CLEANUP
> +      shell: bash
> +
> diff --git a/.github/actions/setup/action.yml b/.github/actions/setup/a=
ction.yml
> new file mode 100644
> index 0000000..ae6eb78
> --- /dev/null
> +++ b/.github/actions/setup/action.yml
> @@ -0,0 +1,23 @@
> +name: 'setup'
> +description: 'setup env, create /tmp/ci_setup'
> +runs:
> +  using: "composite"
> +  steps:
> +    - id: variables
> +      run: |
> +        export REPO_ROOT=3D$GITHUB_WORKSPACE
> +        export CI_ROOT=3D$REPO_ROOT/ci
> +        # this is somewhat ugly, but that is the easiest way to share =
this code with
> +        # arch specific docker
> +        echo 'echo ::group::Env setup' > /tmp/ci_setup
> +        echo export DEBIAN_FRONTEND=3Dnoninteractive >> /tmp/ci_setup
> +        echo sudo apt-get update >> /tmp/ci_setup
> +        echo sudo apt-get install -y aptitude qemu-kvm zstd binutils-d=
ev elfutils libcap-dev libelf-dev libdw-dev libguestfs-tools >> /tmp/ci_s=
etup
> +        echo export PROJECT_NAME=3D'dwarves' >> /tmp/ci_setup
> +        echo export AUTHOR_EMAIL=3D"$(git log -1 --pretty=3D\"%aE\")" =
>> /tmp/ci_setup
> +        echo export REPO_ROOT=3D$GITHUB_WORKSPACE >> /tmp/ci_setup
> +        echo export CI_ROOT=3D$REPO_ROOT/ci >> /tmp/ci_setup
> +        echo export VMTEST_ROOT=3D$CI_ROOT/vmtest >> /tmp/ci_setup
> +        echo 'echo ::endgroup::' >> /tmp/ci_setup
> +      shell: bash
> +

I strongly suggest getting rid of local actions (`.github/actions`
directory) and moving this into an independent shell script.

Generally, it is much easier to develop and debug CI code if you can
run it locally (say in a fresh docker container). From this follows
that it is better to write most of it in separately executable scripts
(in bash or python, like in bpftrace [1]), as opposed to inlining in
yaml.

For an example of how this might be done see very recently set up
libbpf/usdt CI [2].

In this particular case, I'd put inlined code into ./ci/setup.sh and
source it directly from bash when necesary.

It's a little hypocritical of me to point this out, as libbpf still
has all this mess. But I'd like you to avoid it while it's relatively
simple.

[1] https://github.com/bpftrace/bpftrace/blob/master/.github/include/ci.p=
y
[2] https://github.com/libbpf/usdt/tree/main/.github

> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> new file mode 100644
> index 0000000..a95f71f
> --- /dev/null
> +++ b/.github/workflows/build.yml
> @@ -0,0 +1,37 @@
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
> +      - uses: ./.github/actions/setup
> +        name: Setup
> +      - uses: ./.github/actions/debian
> +        name: Build
> +        with:
> +          target: ${{ matrix.target }}
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

Supported codeql-action version is v3:
https://github.com/github/codeql-action?tab=3Dreadme-ov-file#supported-ve=
rsions-of-the-codeql-action

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

Same: v3 here.

> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverit=
y.yml
> new file mode 100644
> index 0000000..c672a7d
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

Assuming you're intentionally want to run coverity scans, you will
have to set up COVERITY_SCAN_TOKEN secret variable in settings of the
github repository.

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
> +          COVERITY_SCAN_PROJECT_NAME: dwarves=20
>=20+          COVERITY_SCAN_BUILD_COMMAND_PREPEND: 'cmake .'
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

The usefullness of ondemand is dubious, tbh. Usually you want to run
CI against a change in the code, which can be achieved by enabling
testing workflows on pull_request. IMO ondemand workflow is not
necessary.

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
> +      llvm-version: ${{ inputs.llvm-version }}
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

llvm-version and pahole inputs don't make any sense for dwarves
testing. These are inputs of the libbpf/ci/setup-build-env, because
selftests/bpf need LLVM, and BPF CI also builds kernel with LLVM (do
you want to do that too for pahole testing?).

My point is, you may be able to avoid the dependency on
libbpf/ci/setup-build-env and simply install required packages
directly. It'll be less work for a job, and these inputs won't be
necessary.

> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.ym=
l
> new file mode 100644
> index 0000000..aef5f0a
> --- /dev/null
> +++ b/.github/workflows/vmtest.yml
> @@ -0,0 +1,94 @@
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
> +
> +      - name: Build,install current pahole
> +        shell: bash
> +        run: |
> +          git config --global --add safe.directory ${{ github.workspac=
e }}
> +          git submodule update --init
> +          mkdir build
> +          cd build
> +          cmake -DGIT_SUBMODULE=3DOFF -DBUILD_SHARED_LIBS=3DOFF ..
> +          make -j$((4*$(nproc))) all
> +          make DESTDIR=3D../install install
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
> +        run: |
> +          export PATH=3D${{ github.workspace }}/install/usr/local/bin:=
${PATH}
> +          export PAHOLE=3D${{ github.workspace }}/install/usr/local/bi=
n/pahole
> +          which pahole
> +          $PAHOLE --version
> +          cd .kernel
> +          cat tools/testing/selftests/bpf/config \
> +              tools/testing/selftests/bpf/config.${{ inputs.arch }} > =
.config
> +          # this file might or might not exist depending on kernel ver=
sion
> +          cat tools/testing/selftests/bpf/config.vm >> .config || :
> +          make olddefconfig && make prepare
> +          grep PAHOLE .config
> +          grep _BTF .config
> +          make -j $((4*$(nproc))) all
> +          cp vmlinux ${{ github.workspace }}
> +          cd -
> +
> +      - name: Run selftests

nit: probably worth giving this step a different name.

> +        env:
> +          VMLINUX: ${{ github.workspace }}/vmlinux
> +          LLVM_VERSION: ${{ inputs.llvm-version }}
> +          SELFTESTS: ${{ github.workspace }}/tests
> +        shell: bash
> +        run: |
> +           cd $SELFTESTS
> +           export PATH=3D${{ github.workspace }}/install/usr/local/bin=
:${PATH}
> +           which pahole
> +           pahole --version
> +           vmlinux=3D$VMLINUX ./tests
> +           cd -
> +
> diff --git a/ci/managers/debian.sh b/ci/managers/debian.sh

This script is too complicated for my taste. I would replace it with
something like docker run step + build-in-docker.sh combination in
libbpf for ubuntu:
* https://github.com/libbpf/libbpf/blob/master/.github/workflows/build.ym=
l#L85-L91
* https://github.com/libbpf/libbpf/blob/master/ci/build-in-docker.sh

There are more potential parameters here, but all this logic with
phases is just redundant IMO. For example, apt packages installation
can be covered by a single shared script (that assumes ubuntu/debian).

> new file mode 100755
> index 0000000..8316b02
> --- /dev/null
> +++ b/ci/managers/debian.sh
> @@ -0,0 +1,88 @@
> +#!/bin/bash
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
> diff --git a/ci/managers/travis_wait.bash b/ci/managers/travis_wait.bas=
h
> new file mode 100644
> index 0000000..acf6ad1
> --- /dev/null
> +++ b/ci/managers/travis_wait.bash

I am not sure you need this script. I see it's used in
ci/managers/debian.sh, but I don't know it's purpose.

> @@ -0,0 +1,61 @@
> +# This was borrowed from https://github.com/travis-ci/travis-build/tre=
e/master/lib/travis/build/bash
> +# to get around https://github.com/travis-ci/travis-ci/issues/9979. It=
 should probably be removed
> +# as soon as Travis CI has started to provide an easy way to export th=
e functions to bash scripts.
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

