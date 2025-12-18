Return-Path: <bpf+bounces-76942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFECC9E56
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC507303F81E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA922424E;
	Thu, 18 Dec 2025 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pXP3rSkd"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC122D4DC
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018098; cv=none; b=omHLKg5AZihHqTGxH/pPhGJIdKKRos4Rw51l5fLU8kViL4XR83azTqEwGhW3VrmdnXD1isIajzdNNmcXLao82rrKmd5NxWAc+UMTvAARbfrmgdivEBn4v8xLY6pHxc6Ckjr7vjrd0V0zXx5t5VaDdOugsFC958YzTrenItHcsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018098; c=relaxed/simple;
	bh=WLjB49Bv+US9iVn92oQnMFPHp8ZyZVv5Qy/cHB0piSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFKoU8VpyBJDZY/ypT8lou9J2/nkJDICy82RtxPMx8L2WwW8cYUnUyWKihewGMhNVvelKkKBnKpfkSLkMOlQU6S7Nqqkc0+JtBgSXhYN+bNqVLqS87QCbxf1KDKa0wpmm3aQzkFoIosBlZVJvw8JnHy7gV3O67CnmylIdTzsDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pXP3rSkd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3czLYeRjRlvXBbARi9TdvkmM7dkqe9ZURILhRZlVpf8=;
	b=pXP3rSkd1qRx7zFxFjsbzqZJmxqlM3+kjiqw+PtM0uQjNo0mIljMH5pzN89lZg5YudUavd
	9AwzUC5+8kBax2i127dNBYgXiGyXhBrGG/vpazxYjxsqTfBTM89KGTn11Z7jBmTXUHu+cK
	E6v+N6edGJpDAzAkG8PmMMyorTEZNVo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Vernet <void@manifault.com>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
Date: Wed, 17 Dec 2025 16:33:11 -0800
Message-ID: <20251218003314.260269-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-1-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
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


