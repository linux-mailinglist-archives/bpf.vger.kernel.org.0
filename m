Return-Path: <bpf+bounces-53493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EDDA55258
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFAD1896707
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB94214A61;
	Thu,  6 Mar 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcXcroiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66D2561C5;
	Thu,  6 Mar 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280711; cv=none; b=F8zxsZQ3TWx91w9qbWXozn5UkMnibLrJDopXRRnV+9iPxtTS+WmIfDxRtF0dRjWNQ7ean5OMuUCnpmdmfXY7k9pjVDsy0MVpyKz+lV0acp6Pb300RFyV3U/HocKl7r1B3tsldAafnUqZtiO0tLjYQYvWtAIPneHe5NZmrW8cbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280711; c=relaxed/simple;
	bh=HNilakJXQw8rdR2jPJWNAPmFZMQPEjU1PY+jU1ga6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL80BGR0SlM/nKseP6KT77a55wZ5jURMycRMQu6EJnJd9mqzmOkOTIAjIEGGBWDqiqId+isRfRhBV/XBiSneTjmbUfsW4oZsSKbq25A6hD1CN2izwfhfgQllPATBCdyk8ZwZ4HM1XTaT//sNldntuQ2xW+fv7e1ukYzD8QcTucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fcXcroiZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6oY028799;
	Thu, 6 Mar 2025 17:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=iVr17
	tErJsdnrosTmVEYy8yANdgw+eaqLo0ulVhC6wQ=; b=fcXcroiZnODgw7AfrfgzP
	cCVEsBvQwiMlibdaPwhaYfNqJvs+Wj/5BLTcOZizGDfvgMSLNaRehip1smaWD3YL
	yerEJivimXDiKy3hcsAOuyTD4qnuqcH23O2QLGoQ8IitoL1wAgv89XBntTNPbMcw
	zB76P1dsXtmF9MfEJNOqnRIcnTuxeM8QWuuUZKozC8wjWHeVwQC47Nj/sbGANZ81
	wNDKOboRYcMSD2uUOLZCXlWvzuNmd8MFxgMC5yH5LNC6M/drzSxQnI3FmCfk6iut
	LQi6zOSovgNueLKJFlXBMWatlzaCISRi7I1iKJ3pexmPFomNJnAonI+wJJs/U0JE
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qjpt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:05:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526FdOfk010929;
	Thu, 6 Mar 2025 17:05:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe0evg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:05:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 526H1Exg022155;
	Thu, 6 Mar 2025 17:04:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-26.vpn.oracle.com [10.154.58.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rpe0eqr-2;
	Thu, 06 Mar 2025 17:04:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, song@kernel.org,
        eddyz87@gmail.com, olsajiri@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] dwarves: Add github actions to build, test
Date: Thu,  6 Mar 2025 17:04:54 +0000
Message-ID: <20250306170455.2957229-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250306170455.2957229-1-alan.maguire@oracle.com>
References: <20250306170455.2957229-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060130
X-Proofpoint-ORIG-GUID: ZSEEYyohxZ9ga872ORCU7aFOI4M6YU8C
X-Proofpoint-GUID: ZSEEYyohxZ9ga872ORCU7aFOI4M6YU8C

Borrowing heavily from libbpf github actions, add workflows to

- build dwarves for gcc, LLVM

- build dwarves for x86_64/aarch64 and use it to build a Linux
  kernel including BTF generation; then run dwarves selftests
  using generated vmlinux

These workflows trigger on all pushes.  This will alow both
developers working on dwarves to push a branch to their github
repo and test, and also for maintainer pushes from git.kernel.org
pahole repo to trigger tests.

And similar to libbpf, additional workflows for coverity etc
are triggered for pushes to master/next.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/actions/debian/action.yml | 16 ++++++
 .github/actions/setup/action.yml  | 23 ++++++++
 .github/workflows/build.yml       | 37 ++++++++++++
 .github/workflows/codeql.yml      | 53 +++++++++++++++++
 .github/workflows/coverity.yml    | 33 +++++++++++
 .github/workflows/lint.yml        | 20 +++++++
 .github/workflows/ondemand.yml    | 31 ++++++++++
 .github/workflows/test.yml        | 36 ++++++++++++
 .github/workflows/vmtest.yml      | 94 +++++++++++++++++++++++++++++++
 ci/managers/debian.sh             | 88 +++++++++++++++++++++++++++++
 ci/managers/travis_wait.bash      | 61 ++++++++++++++++++++
 11 files changed, 492 insertions(+)
 create mode 100644 .github/actions/debian/action.yml
 create mode 100644 .github/actions/setup/action.yml
 create mode 100644 .github/workflows/build.yml
 create mode 100644 .github/workflows/codeql.yml
 create mode 100644 .github/workflows/coverity.yml
 create mode 100644 .github/workflows/lint.yml
 create mode 100644 .github/workflows/ondemand.yml
 create mode 100644 .github/workflows/test.yml
 create mode 100644 .github/workflows/vmtest.yml
 create mode 100755 ci/managers/debian.sh
 create mode 100644 ci/managers/travis_wait.bash

diff --git a/.github/actions/debian/action.yml b/.github/actions/debian/action.yml
new file mode 100644
index 0000000..23d48ec
--- /dev/null
+++ b/.github/actions/debian/action.yml
@@ -0,0 +1,16 @@
+name: 'debian'
+description: 'Build'
+inputs:
+  target:
+    description: 'Run target'
+    required: true
+runs:
+  using: "composite"
+  steps:
+    - run: |
+        source /tmp/ci_setup
+        bash -x $CI_ROOT/managers/debian.sh SETUP
+        bash -x $CI_ROOT/managers/debian.sh ${{ inputs.target }}
+        bash -x $CI_ROOT/managers/debian.sh CLEANUP
+      shell: bash
+
diff --git a/.github/actions/setup/action.yml b/.github/actions/setup/action.yml
new file mode 100644
index 0000000..ae6eb78
--- /dev/null
+++ b/.github/actions/setup/action.yml
@@ -0,0 +1,23 @@
+name: 'setup'
+description: 'setup env, create /tmp/ci_setup'
+runs:
+  using: "composite"
+  steps:
+    - id: variables
+      run: |
+        export REPO_ROOT=$GITHUB_WORKSPACE
+        export CI_ROOT=$REPO_ROOT/ci
+        # this is somewhat ugly, but that is the easiest way to share this code with
+        # arch specific docker
+        echo 'echo ::group::Env setup' > /tmp/ci_setup
+        echo export DEBIAN_FRONTEND=noninteractive >> /tmp/ci_setup
+        echo sudo apt-get update >> /tmp/ci_setup
+        echo sudo apt-get install -y aptitude qemu-kvm zstd binutils-dev elfutils libcap-dev libelf-dev libdw-dev libguestfs-tools >> /tmp/ci_setup
+        echo export PROJECT_NAME='dwarves' >> /tmp/ci_setup
+        echo export AUTHOR_EMAIL="$(git log -1 --pretty=\"%aE\")" >> /tmp/ci_setup
+        echo export REPO_ROOT=$GITHUB_WORKSPACE >> /tmp/ci_setup
+        echo export CI_ROOT=$REPO_ROOT/ci >> /tmp/ci_setup
+        echo export VMTEST_ROOT=$CI_ROOT/vmtest >> /tmp/ci_setup
+        echo 'echo ::endgroup::' >> /tmp/ci_setup
+      shell: bash
+
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
new file mode 100644
index 0000000..a95f71f
--- /dev/null
+++ b/.github/workflows/build.yml
@@ -0,0 +1,37 @@
+name: dwarves-build
+
+on:
+  pull_request:
+  push:
+  schedule:
+    - cron:  '0 18 * * *'
+
+concurrency:
+  group: ci-build-${{ github.head_ref }}
+  cancel-in-progress: true
+
+jobs:
+
+  debian:
+    runs-on: ubuntu-latest
+    name: Debian Build (${{ matrix.name }})
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+          - name: default
+            target: RUN
+          - name: gcc-12
+            target: RUN_GCC12
+          - name: clang
+            target: RUN_CLANG
+    steps:
+      - uses: actions/checkout@v4
+        name: Checkout
+      - uses: ./.github/actions/setup
+        name: Setup
+      - uses: ./.github/actions/debian
+        name: Build
+        with:
+          target: ${{ matrix.target }}
+
diff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.yml
new file mode 100644
index 0000000..a140be1
--- /dev/null
+++ b/.github/workflows/codeql.yml
@@ -0,0 +1,53 @@
+---
+# vi: ts=2 sw=2 et:
+
+name: "CodeQL"
+
+on:
+  push:
+    branches:
+      - master
+  pull_request:
+    branches:
+      - master
+      - next
+
+permissions:
+  contents: read
+
+jobs:
+  analyze:
+    name: Analyze
+    runs-on: ubuntu-latest
+    concurrency:
+      group: ${{ github.workflow }}-${{ matrix.language }}-${{ github.ref }}
+      cancel-in-progress: true
+    permissions:
+      actions: read
+      security-events: write
+
+    strategy:
+      fail-fast: false
+      matrix:
+        language: ['cpp', 'python']
+
+    steps:
+      - name: Checkout repository
+        uses: actions/checkout@v4
+
+      - name: Initialize CodeQL
+        uses: github/codeql-action/init@v2
+        with:
+          languages: ${{ matrix.language }}
+          queries: +security-extended,security-and-quality
+
+      - name: Setup
+        uses: ./.github/actions/setup
+
+      - name: Build
+        run: |
+          source /tmp/ci_setup
+          make -C ./src
+
+      - name: Perform CodeQL Analysis
+        uses: github/codeql-action/analyze@v2
diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
new file mode 100644
index 0000000..c672a7d
--- /dev/null
+++ b/.github/workflows/coverity.yml
@@ -0,0 +1,33 @@
+name: dwarves-ci-coverity
+
+on:
+  push:
+    branches:
+      - master
+      - next
+  schedule:
+    - cron:  '0 18 * * *'
+
+jobs:
+  coverity:
+    runs-on: ubuntu-latest
+    name: Coverity
+    env:
+      COVERITY_SCAN_TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
+    steps:
+      - uses: actions/checkout@v4
+      - uses: ./.github/actions/setup
+      - name: Run coverity
+        if: ${{ env.COVERITY_SCAN_TOKEN }}
+        run: |
+          source /tmp/ci_setup
+          export COVERITY_SCAN_NOTIFICATION_EMAIL="${AUTHOR_EMAIL}"
+          export COVERITY_SCAN_BRANCH_PATTERN=${GITHUB_REF##refs/*/}
+          export TRAVIS_BRANCH=${COVERITY_SCAN_BRANCH_PATTERN}
+          scripts/coverity.sh
+        env:
+          COVERITY_SCAN_PROJECT_NAME: dwarves 
+          COVERITY_SCAN_BUILD_COMMAND_PREPEND: 'cmake .'
+          COVERITY_SCAN_BUILD_COMMAND: 'make'
+      - name: SCM log
+        run: cat /home/runner/work/dwarves/cov-int/scm_log.txt
diff --git a/.github/workflows/lint.yml b/.github/workflows/lint.yml
new file mode 100644
index 0000000..ca13052
--- /dev/null
+++ b/.github/workflows/lint.yml
@@ -0,0 +1,20 @@
+name: "lint"
+
+on:
+  pull_request:
+  push:
+    branches:
+      - master
+      - next
+
+jobs:
+  shellcheck:
+    name: ShellCheck
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout repository
+        uses: actions/checkout@v4
+      - name: Run ShellCheck
+        uses: ludeeus/action-shellcheck@master
+        env:
+          SHELLCHECK_OPTS: --severity=error
diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
new file mode 100644
index 0000000..5f3034f
--- /dev/null
+++ b/.github/workflows/ondemand.yml
@@ -0,0 +1,31 @@
+name: ondemand
+
+on:
+  workflow_dispatch:
+    inputs:
+      arch:
+        default: 'x86_64'
+        required: true
+      llvm-version:
+        default: '18'
+        required: true
+      kernel:
+        default: 'LATEST'
+        required: true
+      pahole:
+        default: "master"
+        required: true
+      runs-on:
+        default: 'ubuntu-24.04'
+        required: true
+
+jobs:
+  vmtest:
+    name: ${{ inputs.kernel }} kernel llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
+    uses: ./.github/workflows/vmtest.yml
+    with:
+      runs_on: ${{ inputs.runs-on }}
+      kernel: ${{ inputs.kernel }}
+      arch: ${{ inputs.arch }}
+      llvm-version: ${{ inputs.llvm-version }}
+      pahole: ${{ inputs.pahole }}
diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
new file mode 100644
index 0000000..f11ebfe
--- /dev/null
+++ b/.github/workflows/test.yml
@@ -0,0 +1,36 @@
+name: dwarves-ci
+
+on:
+  pull_request:
+  push:
+  schedule:
+    - cron:  '0 18 * * *'
+
+concurrency:
+  group: ci-test-${{ github.head_ref }}
+  cancel-in-progress: true
+
+jobs:
+  vmtest:
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+          - kernel: 'LATEST'
+            runs_on: 'ubuntu-24.04'
+            arch: 'x86_64'
+            llvm-version: '18'
+            pahole: 'master'
+          - kernel: 'LATEST'
+            runs_on: 'ubuntu-24.04-arm'
+            arch: 'aarch64'
+            llvm-version: '18'
+            pahole: 'tmp.master'
+    name: Linux ${{ matrix.kernel }}
+    uses: ./.github/workflows/vmtest.yml
+    with:
+      runs_on: ${{ matrix.runs_on }}
+      kernel: ${{ matrix.kernel }}
+      arch: ${{ matrix.arch }}
+      llvm-version: ${{ matrix.llvm-version }}
+      pahole: ${{ matrix.pahole }}
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
new file mode 100644
index 0000000..aef5f0a
--- /dev/null
+++ b/.github/workflows/vmtest.yml
@@ -0,0 +1,94 @@
+name: 'Build kernel run selftests via vmtest'
+
+on:
+  workflow_call:
+    inputs:
+      runs_on:
+        required: true
+        default: 'ubuntu-24.04'
+        type: string
+      arch:
+        description: 'what arch to test'
+        required: true
+        default: 'x86_64'
+        type: string
+      kernel:
+        description: 'kernel version or LATEST'
+        required: true
+        default: 'LATEST'
+        type: string
+      pahole:
+        description: 'pahole rev or branch'
+        required: false
+        default: 'master'
+        type: string
+      llvm-version:
+        description: 'llvm version'
+        required: false
+        default: '18'
+        type: string
+jobs:
+  vmtest:
+    name: pahole@${{ inputs.arch }}
+    runs-on: ${{ inputs.runs_on }}
+    steps:
+
+      - uses: actions/checkout@v4
+
+      - name: Setup environment
+        uses: libbpf/ci/setup-build-env@v3
+        with:
+          pahole: ${{ inputs.pahole }}
+          arch: ${{ inputs.arch }}
+          llvm-version: ${{ inputs.llvm-version }}
+
+      - name: Build,install current pahole
+        shell: bash
+        run: |
+          git config --global --add safe.directory ${{ github.workspace }}
+          git submodule update --init
+          mkdir build
+          cd build
+          cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
+          make -j$((4*$(nproc))) all
+          make DESTDIR=../install install
+
+      - name: Get kernel source
+        uses: libbpf/ci/get-linux-source@v3
+        with:
+          repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git'
+          dest: '${{ github.workspace }}/.kernel'
+
+      - name: Configure, build kernel with current pahole
+        shell: bash
+        run: |
+          export PATH=${{ github.workspace }}/install/usr/local/bin:${PATH}
+          export PAHOLE=${{ github.workspace }}/install/usr/local/bin/pahole
+          which pahole
+          $PAHOLE --version
+          cd .kernel
+          cat tools/testing/selftests/bpf/config \
+              tools/testing/selftests/bpf/config.${{ inputs.arch }} > .config
+          # this file might or might not exist depending on kernel version
+          cat tools/testing/selftests/bpf/config.vm >> .config || :
+          make olddefconfig && make prepare
+          grep PAHOLE .config
+          grep _BTF .config
+          make -j $((4*$(nproc))) all
+          cp vmlinux ${{ github.workspace }}
+          cd -
+
+      - name: Run selftests
+        env:
+          VMLINUX: ${{ github.workspace }}/vmlinux
+          LLVM_VERSION: ${{ inputs.llvm-version }}
+          SELFTESTS: ${{ github.workspace }}/tests
+        shell: bash
+        run: |
+           cd $SELFTESTS
+           export PATH=${{ github.workspace }}/install/usr/local/bin:${PATH}
+           which pahole
+           pahole --version
+           vmlinux=$VMLINUX ./tests
+           cd -
+
diff --git a/ci/managers/debian.sh b/ci/managers/debian.sh
new file mode 100755
index 0000000..8316b02
--- /dev/null
+++ b/ci/managers/debian.sh
@@ -0,0 +1,88 @@
+#!/bin/bash
+
+PHASES=(${@:-SETUP RUN CLEANUP})
+DEBIAN_RELEASE="${DEBIAN_RELEASE:-testing}"
+CONT_NAME="${CONT_NAME:-dwarves-debian-$DEBIAN_RELEASE}"
+ENV_VARS="${ENV_VARS:-}"
+DOCKER_RUN="${DOCKER_RUN:-docker run}"
+REPO_ROOT="${REPO_ROOT:-$PWD}"
+ADDITIONAL_DEPS=(pkgconf)
+EXTRA_CFLAGS=""
+EXTRA_LDFLAGS=""
+
+function info() {
+    echo -e "\033[33;1m$1\033[0m"
+}
+
+function error() {
+    echo -e "\033[31;1m$1\033[0m"
+}
+
+function docker_exec() {
+    docker exec $ENV_VARS $CONT_NAME "$@"
+}
+
+set -eu
+
+source "$(dirname $0)/travis_wait.bash"
+
+for phase in "${PHASES[@]}"; do
+    case $phase in
+        SETUP)
+            info "Setup phase"
+            info "Using Debian $DEBIAN_RELEASE"
+
+            docker --version
+
+            docker pull debian:$DEBIAN_RELEASE
+            info "Starting container $CONT_NAME"
+            $DOCKER_RUN -v $REPO_ROOT:/build:rw \
+                        -w /build --privileged=true --name $CONT_NAME \
+                        -dit --net=host debian:$DEBIAN_RELEASE /bin/bash
+            echo -e "::group::Build Env Setup"
+
+            docker_exec apt-get -y update
+            docker_exec apt-get -y install aptitude
+            docker_exec aptitude -y install make cmake libz-dev libelf-dev libdw-dev git
+            docker_exec aptitude -y install "${ADDITIONAL_DEPS[@]}"
+            echo -e "::endgroup::"
+            ;;
+        RUN|RUN_CLANG|RUN_CLANG16|RUN_GCC12)
+            CC="cc"
+            if [[ "$phase" =~ "RUN_CLANG(\d+)(_ASAN)?" ]]; then
+                ENV_VARS="-e CC=clang-${BASH_REMATCH[1]} -e CXX=clang++-${BASH_REMATCH[1]}"
+                CC="clang-${BASH_REMATCH[1]}"
+            elif [[ "$phase" = *"CLANG"* ]]; then
+                ENV_VARS="-e CC=clang -e CXX=clang++"
+                CC="clang"
+            elif [[ "$phase" =~ "RUN_GCC(\d+)(_ASAN)?" ]]; then
+                ENV_VARS="-e CC=gcc-${BASH_REMATCH[1]} -e CXX=g++-${BASH_REMATCH[1]}"
+                CC="gcc-${BASH_REMATCH[1]}"
+            fi
+            if [[ "$CC" != "cc" ]]; then
+                docker_exec aptitude -y install "$CC"
+            else
+                docker_exec aptitude -y install gcc
+            fi
+	    git config --global --add safe.directory $REPO_ROOT
+	    pushd $REPO_ROOT
+	    git submodule update --init
+	    popd
+            docker_exec mkdir build install
+            docker_exec ${CC} --version
+            info "build"
+            docker_exec cmake -DGIT_SUBMODULE=OFF .
+	    docker_exec make -j$((4*$(nproc)))
+            info "install"
+            docker_exec make DESTDIR=../install install
+            ;;
+        CLEANUP)
+            info "Cleanup phase"
+            docker stop $CONT_NAME
+            docker rm -f $CONT_NAME
+            ;;
+        *)
+            echo >&2 "Unknown phase '$phase'"
+            exit 1
+    esac
+done
diff --git a/ci/managers/travis_wait.bash b/ci/managers/travis_wait.bash
new file mode 100644
index 0000000..acf6ad1
--- /dev/null
+++ b/ci/managers/travis_wait.bash
@@ -0,0 +1,61 @@
+# This was borrowed from https://github.com/travis-ci/travis-build/tree/master/lib/travis/build/bash
+# to get around https://github.com/travis-ci/travis-ci/issues/9979. It should probably be removed
+# as soon as Travis CI has started to provide an easy way to export the functions to bash scripts.
+
+travis_jigger() {
+  local cmd_pid="${1}"
+  shift
+  local timeout="${1}"
+  shift
+  local count=0
+
+  echo -e "\\n"
+
+  while [[ "${count}" -lt "${timeout}" ]]; do
+    count="$((count + 1))"
+    echo -ne "Still running (${count} of ${timeout}): ${*}\\r"
+    sleep 60
+  done
+
+  echo -e "\\n${ANSI_RED}Timeout (${timeout} minutes) reached. Terminating \"${*}\"${ANSI_RESET}\\n"
+  kill -9 "${cmd_pid}"
+}
+
+travis_wait() {
+  local timeout="${1}"
+
+  if [[ "${timeout}" =~ ^[0-9]+$ ]]; then
+    shift
+  else
+    timeout=20
+  fi
+
+  local cmd=("${@}")
+  local log_file="travis_wait_${$}.log"
+
+  "${cmd[@]}" &>"${log_file}" &
+  local cmd_pid="${!}"
+
+  travis_jigger "${!}" "${timeout}" "${cmd[@]}" &
+  local jigger_pid="${!}"
+  local result
+
+  {
+    set +e
+    wait "${cmd_pid}" 2>/dev/null
+    result="${?}"
+    ps -p"${jigger_pid}" &>/dev/null && kill "${jigger_pid}"
+    set -e
+  }
+
+  if [[ "${result}" -eq 0 ]]; then
+    echo -e "\\n${ANSI_GREEN}The command ${cmd[*]} exited with ${result}.${ANSI_RESET}"
+  else
+    echo -e "\\n${ANSI_RED}The command ${cmd[*]} exited with ${result}.${ANSI_RESET}"
+  fi
+
+  echo -e "\\n${ANSI_GREEN}Log:${ANSI_RESET}\\n"
+  cat "${log_file}"
+
+  return "${result}"
+}
-- 
2.43.5


