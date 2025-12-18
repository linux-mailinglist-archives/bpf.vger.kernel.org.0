Return-Path: <bpf+bounces-76943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D2CC9E5F
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF403045CE7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835921E0BA;
	Thu, 18 Dec 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lIvSIqH4"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AC2236F0
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018110; cv=none; b=Ir9OEXe03qYFIdfGAfzJEtYWkzZ4iklav7ork8n+U85KYGW/8sO7O/6PES+zkJpkIJyf88YXGY88b/xmfRPmF1c36iDhyzQYTIDW5vH4O53pqte5tDBl2R6F2aERjWo+o8uaWCY5dR3iYoCI3bt0+6ysBdupwBPPauR4Hw3xb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018110; c=relaxed/simple;
	bh=gsZpFTi8QIwOAvmn5ydQV0Xi+hYp3QfxBo2eDqJApAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6/ZTa1ddaC7C/ynwvn7Nal8ayR/9Z8uPsk2yVZi/iyqYOyT5kVXBWbpGU7gWwfNyiJsXV6gYP+uSV/s/k8OjHDx9MNdBdkclL0YwsHs9A/eaHbTdZ9zRKwplD9LKbBOBGABvGvDnmn5vzSb/KsSmuXID9baFdyVk9DQoEWyI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lIvSIqH4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DExPuYnExZe5P0blUNN50oahe6iegvEMZ5sGMxUQSX4=;
	b=lIvSIqH4OoRvrigoajAQWT6NkE3BMn174X6ylpNPbfNETT4rM/l2iCLHCO4GXjEDrbfk93
	Mb+pvsd6UYMU7I9ZMDlq7JHRQxdAp33QkaNHC7OQ+en1G6UFEkbrV95GHM23Hzzj0Hesf2
	smaKnMZkTwOOPXzCJuDFVw/O0kBendo=
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
Subject: [PATCH bpf-next v4 6/8] lib/Kconfig.debug: Set the minimum required pahole version to v1.22
Date: Wed, 17 Dec 2025 16:33:12 -0800
Message-ID: <20251218003314.260269-7-ihor.solodrai@linux.dev>
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

Subsequent patches in the series change vmlinux linking scripts to
unconditionally pass --btf_encode_detached to pahole, which was
introduced in v1.22 [1][2].

This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
other checks of older pahole versions.

[1] https://github.com/acmel/dwarves/releases/tag/v1.22
[2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/scheduler/sched-ext.rst |  1 -
 lib/Kconfig.debug                     | 13 ++++---------
 scripts/Makefile.btf                  |  9 +--------
 tools/sched_ext/README.md             |  1 -
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a76..9e2882d937b4 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -43,7 +43,6 @@ options should be enabled to use sched_ext:
     CONFIG_DEBUG_INFO_BTF=y
     CONFIG_BPF_JIT_ALWAYS_ON=y
     CONFIG_BPF_JIT_DEFAULT_ON=y
-    CONFIG_PAHOLE_HAS_SPLIT_BTF=y
     CONFIG_PAHOLE_HAS_BTF_TAG=y
 
 sched_ext is used only when the BPF scheduler is loaded and running.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..60281c4f9e99 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -388,18 +388,13 @@ config DEBUG_INFO_BTF
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
-	depends on PAHOLE_VERSION >= 116
-	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
+	depends on PAHOLE_VERSION >= 122
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
-	  Turning this on requires pahole v1.16 or later (v1.21 or later to
-	  support DWARF 5), which will convert DWARF type info into equivalent
-	  deduplicated BTF type info.
-
-config PAHOLE_HAS_SPLIT_BTF
-	def_bool PAHOLE_VERSION >= 119
+	  Turning this on requires pahole v1.22 or later, which will convert
+	  DWARF type info into equivalent deduplicated BTF type info.
 
 config PAHOLE_HAS_BTF_TAG
 	def_bool PAHOLE_VERSION >= 123
@@ -421,7 +416,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
-	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
+	depends on DEBUG_INFO_BTF && MODULES
 	help
 	  Generate compact split BTF type information for kernel modules.
 
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..840a55de42da 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -7,14 +7,7 @@ JOBS := $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
 
 ifeq ($(call test-le, $(pahole-ver), 125),y)
 
-# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
-ifeq ($(call test-le, $(pahole-ver), 121),y)
-pahole-flags-$(call test-ge, $(pahole-ver), 118)	+= --skip_encoding_btf_vars
-endif
-
-pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
-
-pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j$(JOBS)
+pahole-flags-y                                  	+= --btf_gen_floats -j$(JOBS)
 
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 16a42e4060f6..56a9d1557ac4 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -65,7 +65,6 @@ It's also recommended that you also include the following Kconfig options:
 ```
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
-CONFIG_PAHOLE_HAS_SPLIT_BTF=y
 CONFIG_PAHOLE_HAS_BTF_TAG=y
 ```
 
-- 
2.52.0


