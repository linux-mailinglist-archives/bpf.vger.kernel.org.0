Return-Path: <bpf+bounces-76185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C5CA97F0
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 715653021A8C
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5C2E8DE6;
	Fri,  5 Dec 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTPmLZjM"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9D3B8D40
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973930; cv=none; b=jT3zMT3lrCoAzA7QJVFHyTOWRpIbRTqfrBvPDnEcFgPHswZAWpXDpMffGc9DbLQo6YH7fspE4wy7JADjO5TaS0pMOaMI+KcfRkV41Zy1PygKERrM35FxA9GZFB3lr8vyiI73WiFCFvcB8/gMuo5rkuTK2K97QpeBmQPpfi1sFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973930; c=relaxed/simple;
	bh=EtZ0SNSBcb2hWeg/hT2jAj5ngQ/k+0+ZzenKRqh2KJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQqTAetXIEHyLfqW4qF2aAYtGE98WNIjgEsygqTdRr+GOT+ouHDsPijXZiGFieHH8YmGqRyfL5h3Qi794ugCz1KnHNC+vW8OkWcHt4NMb/x/qr3oZfPytHaTVTCFkNKG1v/VQ6e91uePcnR0dgTDRwzrQxVb9kdwwYo8hlqZ+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTPmLZjM; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764973921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z89/MI6wuAfZCzmI3llKFLPjB4Umm2slJ048Z+KfNg8=;
	b=dTPmLZjM3+LbJCLuZNe1Zgm+CUZphOqhCkBB6E9WO2MYaf2jldas/H64lA5vY6108ZzxHK
	ZftQc87adqbsft9S5CHf9vjv9jddXlrT3tuRBkHvn5/XpcOeXTiqlKm0KGxF6cK5wbkU7F
	yqtFrUTcBDFCsPVk39WXqCZ4pmUvl6E=
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
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum required pahole version to v1.22
Date: Fri,  5 Dec 2025 14:30:44 -0800
Message-ID: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
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

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 lib/Kconfig.debug         | 13 ++++---------
 scripts/Makefile.btf      |  9 +--------
 tools/sched_ext/README.md |  1 -
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 742b23ef0d8b..3abf3ae554b6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -389,18 +389,13 @@ config DEBUG_INFO_BTF
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
@@ -422,7 +417,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
-	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
+	depends on DEBUG_INFO_BTF && MODULES
 	help
 	  Generate compact split BTF type information for kernel modules.
 
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..7c1cd6c2ff75 100644
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
+pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= --btf_gen_floats -j$(JOBS)
 
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


