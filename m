Return-Path: <bpf+bounces-69700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936A4B9EA5E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816557A406A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC722F069A;
	Thu, 25 Sep 2025 10:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA22F0695;
	Thu, 25 Sep 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796027; cv=none; b=pHYmwlNB9iYOvJfgOWoSEkyimQw7CZZ9QjaSiZvx0tTV5y8Uykmubci0I9+oVaCQesvyv+KQYoQks7NG4F3ZVwTHagN7q0pIjmBTkSEGCGGevefm2QqqyiOs8r6i8zIs6PyP3plUdp0uWLtrDvfgA9hmdWI1AtYH2cD1/d1XmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796027; c=relaxed/simple;
	bh=5UZyU3hxeDBbAHG0CubbPqBnd7XvqG1P7r9nmzVZ0gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rq745ty12LVe1sVA8s3/4gcDBg6FCp8Qtc5dPhpoHKlirqFjZKvHo84krBvK1s8mjklwbsmfVXbkDOgrmGiWwF2pcdXEEl29MhZVwURoY/U62A5YUhqMwZrZ1LhZQqCykM6rJxLJRvn9OG3XVVn+oqjBBxRhnszzFAkjVwlE1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF44B1E5E;
	Thu, 25 Sep 2025 03:26:57 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3E63F694;
	Thu, 25 Sep 2025 03:27:02 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:32 +0100
Subject: [PATCH 8/8] perf docs: Document building with Clang
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-8-8b35aadde3dc@arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=5681;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5UZyU3hxeDBbAHG0CubbPqBnd7XvqG1P7r9nmzVZ0gM=;
 b=tb2pRMEyB50eTQUvsjIlbJYI8uoKFNV+gIcIdopK8J4jF2gGE8v3xAL8Z805ADNRREKqhULWe
 CpAunfuKYA1DNx9vwkFzpLn2NNS1JjLPorZinSCrPgpBthZ45B2/Hul
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add example commands for building perf with Clang.

Since recent Android NDK releases use Clang as the default compiler, a
separate Android specific document is no longer needed; point to the
general build documentation instead.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/Build.txt   | 18 ++++++++
 tools/perf/Documentation/android.txt | 82 ++++--------------------------------
 2 files changed, 26 insertions(+), 74 deletions(-)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index 83dc87c662b63ecc17553a15cc15a6b8d6f01d83..3e4104e605ac0d7d30b4408ef413cf1f90b034c1 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -99,3 +99,21 @@ configuration paths for cross building:
 In this case, the variable PKG_CONFIG_SYSROOT_DIR can be used alongside the
 variable PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH to prepend the sysroot path to
 the library paths for cross compilation.
+
+5) Build with clang
+===================
+By default, the makefile uses GCC as compiler. With specifying environment
+variables HOSTCC, CC and CXX, it allows to build perf with clang.
+
+Using clang for native build:
+
+  $ HOSTCC=clang CC=clang CXX=clang++ make -C tools/perf
+
+Using clang for cross compilation:
+
+  $ HOSTCC=clang CC=clang CXX=clang++ \
+    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf \
+    NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_JEVENTS=1
+
+In the example above, due to lack libelf, python and libtraceevent for
+cross comiplation, disable the features accordingly.
diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
index 24a59998fc91e814ad96f658d3481d88d798b60c..e65204cf2921f6bd8a79875784c5b3d5487ce05d 100644
--- a/tools/perf/Documentation/android.txt
+++ b/tools/perf/Documentation/android.txt
@@ -1,78 +1,12 @@
 How to compile perf for Android
-=========================================
+===============================
 
-I. Set the Android NDK environment
-------------------------------------------------
+There have two ways to build perf and run it on Android.
 
-(a). Use the Android NDK
-------------------------------------------------
-1. You need to download and install the Android Native Development Kit (NDK).
-Set the NDK variable to point to the path where you installed the NDK:
-  export NDK=/path/to/android-ndk
+- The first method is to build perf with static linking, please refer to
+  Build.txt, section "4) Cross compilation" for how to build a static
+  perf binary.
 
-2. Set cross-compiling environment variables for NDK toolchain and sysroot.
-For arm:
-  export NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
-  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
-For x86:
-  export NDK_TOOLCHAIN=${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-
-  export NDK_SYSROOT=${NDK}/platforms/android-24/arch-x86
-
-This method is only tested for Android NDK versions Revision 11b and later.
-perf uses some bionic enhancements that are not included in prior NDK versions.
-You can use method (b) described below instead.
-
-(b). Use the Android source tree
------------------------------------------------
-1. Download the master branch of the Android source tree.
-Set the environment for the target you want using:
-  source build/envsetup.sh
-  lunch
-
-2. Build your own NDK sysroot to contain latest bionic changes and set the
-NDK sysroot environment variable.
-  cd ${ANDROID_BUILD_TOP}/ndk
-For arm:
-  ./build/tools/build-ndk-sysroot.sh --abi=arm
-  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-arm
-For x86:
-  ./build/tools/build-ndk-sysroot.sh --abi=x86
-  export NDK_SYSROOT=${ANDROID_BUILD_TOP}/ndk/build/platforms/android-3/arch-x86
-
-3. Set the NDK toolchain environment variable.
-For arm:
-  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
-For x86:
-  export NDK_TOOLCHAIN=${ANDROID_TOOLCHAIN}/i686-linux-android-
-
-II. Compile perf for Android
-------------------------------------------------
-You need to run make with the NDK toolchain and sysroot defined above:
-For arm:
-  make WERROR=0 ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
-For x86:
-  make WERROR=0 ARCH=x86 CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
-
-III. Install perf
------------------------------------------------
-You need to connect to your Android device/emulator using adb.
-Install perf using:
-  adb push perf /data/perf
-
-If you also want to use perf-archive you need busybox tools for Android.
-For installing perf-archive, you first need to replace #!/bin/bash with #!/system/bin/sh:
-  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/perf-archive
-  chmod +x /tmp/perf-archive
-  adb push /tmp/perf-archive /data/perf-archive
-
-IV. Environment settings for running perf
-------------------------------------------------
-Some perf features need environment variables to run properly.
-You need to set these before running perf on the target:
-  adb shell
-  # PERF_PAGER=cat
-
-IV. Run perf
-------------------------------------------------
-Run perf on your device/emulator to which you previously connected using adb:
-  # ./data/perf
+- The second method is to download Android NDK, then use the contained
+  clang compiler for building perf. Please refer to Build.txt, section
+  "5) Build with clang" for details.

-- 
2.34.1


