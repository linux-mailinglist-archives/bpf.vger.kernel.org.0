Return-Path: <bpf+bounces-69699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF06FB9EA40
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD75A1672A5
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B32EFDA8;
	Thu, 25 Sep 2025 10:27:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE02EE27C;
	Thu, 25 Sep 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796024; cv=none; b=UYyDZJq0MRfB4SQxfrlOw2ImdrPwxBBy6oCbfyPb6DamW6fUENWyvWPYIHxvtf2XCiLEueMvavCobaLDt6OWNuj2Os7EENSwLzviopZD0nWvFqDyqDO4lzrjhEpv2p+3BD5wedMoo2x4JZiD7vZCODhg7gkKlaLwIPccR6jtyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796024; c=relaxed/simple;
	bh=miZL6Yzqk6/EUWPBBeudxyQE12NEiBHtXzL1MUUXC30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZaCGqOogbOunNNZHAYtSZGc0O/M1rthukAg5GuKW7TOF5k3RwA9s84fyc0nXuNuT8rPl4ewabWgwUouCsOteZu/a6mVRRFRS7J7HdMK49rQavUoRaP9xx9sCkbYidBJLh2adKmpzus5bGkZNmd8P05T5Dpr4g1OJ4hotZcmFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14541692;
	Thu, 25 Sep 2025 03:26:53 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795723F694;
	Thu, 25 Sep 2025 03:26:58 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:31 +0100
Subject: [PATCH 7/8] perf build: Support build with clang
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-7-8b35aadde3dc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=2752;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=miZL6Yzqk6/EUWPBBeudxyQE12NEiBHtXzL1MUUXC30=;
 b=Hr9emfh/TZ8Hx0PqH+HDb4IZnm7jKayCxaeqpAksyZkgzjctwlyF8b6sbr6SAHJ8znK1ey92I
 QrkFGN5YsDFC+vwgbRSY5EjPXgbIZFsDGyBbzFP9PBS+orkmHW2+6ED
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add support for building perf with clang. For cross compilation, the
Makefile dynamically selects target flag for corresponding arch.

This patch has been verified on x86_64 machine with Ubuntu distro, it
can build successfully for native target, and for cross building Arm64
and s390.

Example: native build on x86_64 / Ubuntu machine:

  $ HOSTCC=clang CC=clang CXX=clang++ make -C tools/perf

Example: cross building s390 target on x86_64 / Ubuntu machine:

  # Install x390x cross toolchain and headers
  $ sudo apt-get install gcc-s390x-linux-gnu g++-s390x-linux-gnu \
         libc6-dev-s390x-cross linux-libc-dev-s390x-cross

  # Build with clang
  $ HOSTCC=clang CC=clang CXX=clang++ \
    ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
    make -C tools/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_LIBPYTHON=1

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53c604ec0d90c5ca7e2bee5bfa6a17..a2b5c291a364cbf331c16384764520dfe330a04c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -23,8 +23,38 @@ HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 # borrowed from kernel headers depends on it, e.g. put_unaligned_*().
 CFLAGS += -fno-strict-aliasing
 
-# Enabled Wthread-safety analysis for clang builds.
+# Set target flag and options when using clang as compiler.
 ifeq ($(CC_NO_CLANG), 0)
+  CLANG_TARGET_FLAGS_arm	:= arm-linux-gnueabi
+  CLANG_TARGET_FLAGS_arm64	:= aarch64-linux-gnu
+  CLANG_TARGET_FLAGS_m68k	:= m68k-linux-gnu
+  CLANG_TARGET_FLAGS_mips	:= mipsel-linux-gnu
+  CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
+  CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
+  CLANG_TARGET_FLAGS_s390	:= s390x-linux-gnu
+  CLANG_TARGET_FLAGS_x86	:= x86_64-linux-gnu
+
+  # Default to host architecture if ARCH is not explicitly given.
+  ifeq ($(ARCH),)
+    CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
+  else
+    CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
+  endif
+
+  ifeq ($(CROSS_COMPILE),)
+    ifeq ($(CLANG_TARGET_FLAGS),)
+      $(error Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for $(ARCH))
+    else
+      CLANG_FLAGS += --target=$(CLANG_TARGET_FLAGS)
+    endif # CLANG_TARGET_FLAGS
+  else
+    CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
+  endif # CROSS_COMPILE
+
+  CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
+  CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
+
+  # Enabled Wthread-safety analysis for clang builds.
   CFLAGS += -Wthread-safety
 endif
 

-- 
2.34.1


