Return-Path: <bpf+bounces-77109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F7CCE354
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B832F3007A86
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04D28725F;
	Fri, 19 Dec 2025 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wVjOYG2V"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF7284670;
	Fri, 19 Dec 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109682; cv=none; b=FPQHqeOYQPAVftXt/d43FnRvVCrCjPeFGmTBt+tKlYyUgx+I50rmB4w9zhxBMlQ2n53SqueJTV0E5sfAlxC4ihDY8lMXn9AuU3bA4+ngI7BSixUMSMKCwEoDCAOA7WU+ezmMJwIW0KplnsV9nl2tr8CdRHo8vsz0CmcgDedvoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109682; c=relaxed/simple;
	bh=WLjB49Bv+US9iVn92oQnMFPHp8ZyZVv5Qy/cHB0piSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8pCoojb+5lIpy30Rxt8+euZPjN9GZsfYNKFdPN/8HZeuV33Qvxbd7p3mW1NSFSFaI42lI5FyCIsH6DvLYJXXxbx4YrXTawjBllaI6UPFTyZSY8WyMmNJRjowVkwsDhyLXZayEDdHGmkBhGsZDi77QUykwu2SLGeKQ4+d8dwLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wVjOYG2V; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3czLYeRjRlvXBbARi9TdvkmM7dkqe9ZURILhRZlVpf8=;
	b=wVjOYG2VuAkk88imkm+3hxW0Zbr7+cpera3BSDPlMqs0hePlXnJEslrw3eAb1ITPv8YZQK
	Qz4d8hI2ikKabfv6C7Is8lc8/LQawyfP6uJli3JmdnF486SpuQwo/0xmAPIb0mh00oMLDQ
	OPExh6t1JhzR75tydE3lTnJZ6UNgIqA=
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
Subject: [PATCH bpf-next v6 5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
Date: Thu, 18 Dec 2025 18:00:03 -0800
Message-ID: <20251219020006.785065-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251219020006.785065-1-ihor.solodrai@linux.dev>
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
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


