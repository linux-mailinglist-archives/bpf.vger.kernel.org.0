Return-Path: <bpf+bounces-77079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D155CCE134
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E41913078E9D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5621922FD;
	Fri, 19 Dec 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sx75MB66"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A906CA52
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104384; cv=none; b=b8Y7J6VNp2FPI89TFst5WsXPUzzTYPh17cNBvJsKgU0lwgBTHqd4/sGbF26DaKfJLG9eYrL30cewICxA+2VRDXujTMfS+btAdIX6tEqHdGCTPrsBY2NeTZeZBDwt5oXgqnxaxA7P4zqGB50W4aftLxjJKPcpGpMOTzDaTvW50oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104384; c=relaxed/simple;
	bh=lsKK08j2MW/LJDDRHVtknb/xyELx8SI06ApvRJWk1hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgUADqtsKMAC296BVzTBKHiKdlmoqGJwrfoFplWfzBIPL/ToyIHgZ7I87QZqjYWFh6dXQ4UpeB5s6erAHSYkV6Zsl9XKpPblI+BlJyc5YXNztCU0D2CB8PwaJR6jPu4cgMaxENAHBhvd6OYHmaXB7HbvP+4ebhr0S6aC/YrHgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sx75MB66; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766104376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CImlnMDb1hjacOiXsGjUxyIoHDCYLclqOoHl5Ihuy6g=;
	b=Sx75MB66AMjcsbxBRa/h8PMm1zlMGtAX75lGck9Y7TK2ZMCxUvxRLDyMe1bzdhFdowozDa
	gKNMj6QeifmG6bXweodoYopmHo56ZvBvAKyG38+bQ6ys+VSnyCGPOHK31nVUrUdTbCiVMo
	9WuWmmHGEZKxwNqwtqTSdBSYZ6LLySo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v5 5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
Date: Thu, 18 Dec 2025 16:31:44 -0800
Message-ID: <20251219003147.587098-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251219003147.587098-1-ihor.solodrai@linux.dev>
References: <20251219003147.587098-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch implements kconfig re-sync when the pahole version changes
between builds, similar to how it happens for compiler version change
via CC_VERSION_TEXT.

Define PAHOLE_VERSION in the top-level Makefile and export it for
config builds. Set CONFIG_PAHOLE_VERSION default to the exported
variable.

Kconfig records the PAHOLE_VERSION value in
include/config/auto.conf.cmd [1].

The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
between builds, make detects a dependency change and triggers
syncconfig to update the kconfig [2].

For external module builds, add a warning message in the prepare
target, similar to the existing compiler version mismatch warning.

Note that if pahole is not installed or available, PAHOLE_VERSION is
set to 0 by pahole-version.sh, so the (un)installation of pahole is
treated as a version change.

See previous discussions for context [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kconfig/preprocess.c?h=v6.18#n91
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.18#n815
[3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com/

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Makefile     | 9 ++++++++-
 init/Kconfig | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e404e4767944..9b90a2a2218e 100644
--- a/Makefile
+++ b/Makefile
@@ -713,6 +713,7 @@ endif
 # upgrade.
 CC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(CC) --version 2>/dev/null | head -n 1))
 RUSTC_VERSION_TEXT = $(subst $(pound),,$(shell $(RUSTC) --version 2>/dev/null))
+PAHOLE_VERSION = $(shell $(srctree)/scripts/pahole-version.sh $(PAHOLE))
 
 ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
 include $(srctree)/scripts/Makefile.clang
@@ -733,7 +734,7 @@ ifdef config-build
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
 include $(srctree)/arch/$(SRCARCH)/Makefile
-export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT RUSTC_VERSION_TEXT
+export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT RUSTC_VERSION_TEXT PAHOLE_VERSION
 
 config: outputmakefile scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
@@ -1921,12 +1922,18 @@ clean: private rm-files := Module.symvers modules.nsdeps compile_commands.json
 PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations
 prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
+prepare: PAHOLE_VERSION := $(PAHOLE_VERSION)
 prepare:
 	@if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ]; then \
 		echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
 		echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_TEXT)"; \
 		echo >&2 "  You are using:           $(CC_VERSION_TEXT)"; \
 	fi
+	@if [ "$(PAHOLE_VERSION)" != "$(CONFIG_PAHOLE_VERSION)" ]; then \
+		echo >&2 "warning: pahole version differs from the one used to build the kernel"; \
+		echo >&2 "  The kernel was built with: $(CONFIG_PAHOLE_VERSION)"; \
+		echo >&2 "  You are using:             $(PAHOLE_VERSION)"; \
+	fi
 
 PHONY += help
 help:
diff --git a/init/Kconfig b/init/Kconfig
index fa79feb8fe57..317f3c0b13ad 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -171,7 +171,7 @@ config RUSTC_HAS_FILE_AS_C_STR
 
 config PAHOLE_VERSION
 	int
-	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
+	default "$(PAHOLE_VERSION)"
 
 config CONSTRUCTORS
 	bool
-- 
2.52.0


