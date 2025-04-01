Return-Path: <bpf+bounces-55059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD009A777A4
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683F5166FC3
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111EF1EE7C6;
	Tue,  1 Apr 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oiQ11p5G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726321EE02A;
	Tue,  1 Apr 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499513; cv=none; b=MmR18lTxxd9i4ubFmwGbUwy+uQ8rruEpuljQVPq87KR1GCvf2E78k7OqZAs5a8eaV9qAGzSntJlHb+r8uHDONksbXQBmc9r5rBezeU2DtSRHWFnegRFCzC5sTw1AQb/rxQ4X58jtkBIVp+sLtwsdf8x7fUspY4snHhdjtQtsq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499513; c=relaxed/simple;
	bh=Ee+3/vv6YNLjTsRLFzFQWXb8E6VicH4prpMykF4AtaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRJQgTeF5VpfyX7ejvM0mV5GZ2KneyooWB+6HyIPYtgmrjBBw4/sn4c+3A86jwPZNT+mU7VfCdhACTAQmXEUxW52pAjBPoCuvOTd98a2LfJhBEVgi41ZJMDQRssoBso4LasllrpSH7H3VXu44DASVEr4q2P1cHgU9e9PGuNgnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oiQ11p5G; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318BuC0029401;
	Tue, 1 Apr 2025 09:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ZTtvM
	Te6IxDhLDTVoxyTFSukX5JM6F8D7UBy2mZ/zc8=; b=oiQ11p5GOEubet6kdfCP5
	IgTQBTmLag/V3susH1Vfo3PDkQYYCVBdwFPhFPQJL+Tx/4FY8fX6fb0OIb2vCEO+
	xdY5Y9awQ9SxT/RZzu8c0kq7b44B7f15BsGzWSQwV0dW8nigRdKYrB2pMyIMNqYE
	uo4rtqwjvSHsj4dRVpT8rXCb36VI72wPBFwkSGDW4ImjpwPCKU9Zdeg6yRZ6XSuL
	NS5Jvm01DHzRryzpy/dk1e/7IMc58H7yTkPWKxXblVzI08IDAIaFA+PIfAIg7/bW
	0y4OSYxiDgYGZY0Hd7SvOJyWCn7jg40xT0DXvMp6UTAl0rhhcX5zYC4FUrQJ8OVc
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n26kt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5317c01j032694;
	Tue, 1 Apr 2025 09:24:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a9363v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5319OcHd008831;
	Tue, 1 Apr 2025 09:24:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-231.vpn.oracle.com [10.154.53.231])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45p7a93603-2;
	Tue, 01 Apr 2025 09:24:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, dwarves@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 1/2] dwarves: Add github actions to build, test
Date: Tue,  1 Apr 2025 10:24:34 +0100
Message-ID: <20250401092435.1619617-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250401092435.1619617-1-alan.maguire@oracle.com>
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010061
X-Proofpoint-ORIG-GUID: Ad1aOsTczmug29Wc7P2RpY4xMVD-XCYI
X-Proofpoint-GUID: Ad1aOsTczmug29Wc7P2RpY4xMVD-XCYI

Borrowing heavily from libbpf github actions, add workflows to

- build dwarves for gcc, LLVM

- build dwarves for x86_64/aarch64 and use it to build a Linux
  kernel including BTF generation; then run dwarves selftests
  using generated vmlinux

These workflows trigger on all pushes.  This will allow both
developers working on dwarves to push a branch to their github
repo and test, and also for maintainer pushes from git.kernel.org
pahole repo to trigger tests.

The build/test workflows can also be run as bash scripts locally,
as is described in the toplevel README.

Similar to libbpf, additional workflows for coverity etc
are triggered for pushes to master/next.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-debian.sh  | 92 ++++++++++++++++++++++++++++++++
 .github/scripts/build-kernel.sh  | 35 ++++++++++++
 .github/scripts/build-pahole.sh  | 17 ++++++
 .github/scripts/run-selftests.sh | 15 ++++++
 .github/scripts/travis_wait.bash | 61 +++++++++++++++++++++
 .github/workflows/build.yml      | 34 ++++++++++++
 .github/workflows/codeql.yml     | 53 ++++++++++++++++++
 .github/workflows/coverity.yml   | 33 ++++++++++++
 .github/workflows/lint.yml       | 20 +++++++
 .github/workflows/ondemand.yml   | 31 +++++++++++
 .github/workflows/test.yml       | 36 +++++++++++++
 .github/workflows/vmtest.yml     | 62 +++++++++++++++++++++
 README                           | 18 +++++++
 13 files changed, 507 insertions(+)
 create mode 100755 .github/scripts/build-debian.sh
 create mode 100755 .github/scripts/build-kernel.sh
 create mode 100755 .github/scripts/build-pahole.sh
 create mode 100755 .github/scripts/run-selftests.sh
 create mode 100755 .github/scripts/travis_wait.bash
 create mode 100644 .github/workflows/build.yml
 create mode 100644 .github/workflows/codeql.yml
 create mode 100644 .github/workflows/coverity.yml
 create mode 100644 .github/workflows/lint.yml
 create mode 100644 .github/workflows/ondemand.yml
 create mode 100644 .github/workflows/test.yml
 create mode 100644 .github/workflows/vmtest.yml

diff --git a/.github/scripts/build-debian.sh b/.github/scripts/build-debian.sh
new file mode 100755
index 0000000..5a0789a
--- /dev/null
+++ b/.github/scripts/build-debian.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
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
diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
new file mode 100755
index 0000000..41a3cf8
--- /dev/null
+++ b/.github/scripts/build-kernel.sh
@@ -0,0 +1,35 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+
+GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
+INPUTS_ARCH=${INPUTS_ARCH:-$(uname -m)}
+REPO=${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git}
+REPO_BRANCH=${REPO_BRANCH:-master}
+REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
+
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
+
+which pahole
+$PAHOLE --version
+
+if [[ ! -d $REPO_TARGET ]]; then
+	git clone $REPO $REPO_TARGET
+fi
+cd $REPO_TARGET
+git checkout $REPO_BRANCH
+
+cat tools/testing/selftests/bpf/config \
+    tools/testing/selftests/bpf/config.${INPUTS_ARCH} > .config
+# this file might or might not exist depending on kernel version
+if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
+	cat tools/testing/selftests/bpf/config.vm >> .config
+fi
+make olddefconfig && make prepare
+grep PAHOLE .config
+grep _BTF .config
+make -j $((4*$(nproc))) all
+
diff --git a/.github/scripts/build-pahole.sh b/.github/scripts/build-pahole.sh
new file mode 100755
index 0000000..64f9eea
--- /dev/null
+++ b/.github/scripts/build-pahole.sh
@@ -0,0 +1,17 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+
+GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
+cd $GITHUB_WORKSPACE
+git config --global --add safe.directory $GITHUB_WORKSPACE
+git submodule update --init
+mkdir -p build
+cd build
+pwd
+cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
+make -j$((4*$(nproc))) all
+make DESTDIR=../install install
+
diff --git a/.github/scripts/run-selftests.sh b/.github/scripts/run-selftests.sh
new file mode 100755
index 0000000..f9ba24e
--- /dev/null
+++ b/.github/scripts/run-selftests.sh
@@ -0,0 +1,15 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+
+GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
+VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
+SELFTESTS=${GITHUB_WORKSPACE}/tests
+cd $SELFTESTS
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+which pahole
+pahole --version
+vmlinux=$VMLINUX ./tests
+
diff --git a/.github/scripts/travis_wait.bash b/.github/scripts/travis_wait.bash
new file mode 100755
index 0000000..acf6ad1
--- /dev/null
+++ b/.github/scripts/travis_wait.bash
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
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
new file mode 100644
index 0000000..25a395f
--- /dev/null
+++ b/.github/workflows/build.yml
@@ -0,0 +1,34 @@
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
+      - name: setup
+        shell: bash
+        run: ./.github/scripts/build-debian.sh SETUP ${{ matrix.target }}
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
index 0000000..97a04d4
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
index 0000000..0f66eed
--- /dev/null
+++ b/.github/workflows/vmtest.yml
@@ -0,0 +1,62 @@
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
+        run: .github/scripts/build-pahole.sh
+
+      - name: Get kernel source
+        uses: libbpf/ci/get-linux-source@v3
+        with:
+          repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git'
+          dest: '${{ github.workspace }}/.kernel'
+
+      - name: Configure, build kernel with current pahole
+        shell: bash
+        run: .github/scripts/build-kernel.sh
+
+      - name: Run selftests
+        shell: bash
+        run: .github/scripts/run-selftests.sh
+
diff --git a/README b/README
index 7ee3b87..a938266 100644
--- a/README
+++ b/README
@@ -21,3 +21,21 @@ cmake Options:
 You may need to update the libbpf git submodule:
 
 git submodule update --init --recursive
+
+Testing:
+
+Tests are available in the tests subdirectory and should be run prior to
+submitting patches.  Patches that add functionality should add to tests
+here also.  Tests can be run by
+
+- running the scripts directly using a pre-existing vmlinux binary; i.e.
+	cd tests ; vmlinux=/path/2/vmlinux ./tests
+  (the vmlinux binary must contain DWARF to be converted to BTF)
+
+- running the tests via local scripts in .github/scripts; i.e.
+	bash .github/scripts/build-pahole.sh; \
+	bash .github/scripts/build-kernel.sh; \
+	bash .github/scripts/run-selftests.sh
+- via GitHub actions: push a branch to a GitHub repo; actions will be
+  triggered for build and test matching the above steps.  See the "Actions"
+  tab in the github repo for info on job pass/fail and logs.
-- 
2.43.5


