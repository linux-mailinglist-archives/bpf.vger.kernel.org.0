Return-Path: <bpf+bounces-77111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E5CCE363
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E213030D80
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5D2BCF4A;
	Fri, 19 Dec 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ecxo0N8T"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03629ACC5
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109703; cv=none; b=k9nWTBiMktIXcmwMbE3uipE3UumpMg97ndKJzFtPyBZtdzTwYU27pA6y3qPc/XqjlBzm5X0czOgo5hL+VsANRUgIL5ixsw1wB+qtlrYrBcAOfYpUTj3Xrv6TdrzoacqUIRfYNaTwxNLOhGqAXcAsjB76ihkNs+KVUwA6z9Z3XkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109703; c=relaxed/simple;
	bh=5XtEDfZedRFWtJQoT8WqPLnMwqu1EqFypYwbxxsUTGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0Uv/LsxpwAXieciYkyyJ0Apvins0cIRgI38St6BwquKSfKLNSs+EACIvroUDOCLrDfOjWjuca8hIW7DAt93edqDiuEiav0D6qbX83JZViQZhQFILGzAO0SvQFeLwQDb4kTIp0P22E+uNbccEn8uC2NICpcM3tn5rLc+iqlsLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ecxo0N8T; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1babkEM7oMvkXXUZTjAt8tsiOOvS9LqFpy4/GgvYek=;
	b=Ecxo0N8TIL6HmgyOI5oXhQAFTcsGt6Y9LXmxT3uibFFd0qD1vnJCUBbwGyKo4ajGkMD50t
	9+2Ts7oQhXMjo+Sc8rhtYSjGBhiSXfpFXWWLsdPPdBE9jzTokVn4Lx99ew0GMZsVCDSWOD
	b/jDaFmicrVcNaAO98LUqb+BGgB27SM=
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
Subject: [PATCH bpf-next v6 7/8] selftests/bpf: Run resolve_btfids only for relevant .test.o objects
Date: Thu, 18 Dec 2025 18:00:05 -0800
Message-ID: <20251219020006.785065-8-ihor.solodrai@linux.dev>
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

A selftest targeting resolve_btfids functionality relies on a resolved
.BTF_ids section to be available in the TRUNNER_BINARY. The underlying
BTF data is taken from a special BPF program (btf_data.c), and so
resolve_btfids is executed as a part of a TRUNNER_BINARY build recipe
on the final binary.

Subsequent patches in this series allow resolve_btfids to modify BTF
before resolving the symbols, which means that the test needs access
to that modified BTF [1]. Currently the test simply reads in
btf_data.bpf.o on the assumption that BTF hasn't changed.

Implement resolve_btfids call only for particular test objects (just
resolve_btfids.test.o for now). The test objects are linked into the
TRUNNER_BINARY, and so .BTF_ids section will be available there.

This will make it trivial for the resolve_btfids test to access BTF
modified by resolve_btfids.

[1] https://lore.kernel.org/bpf/CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4aa60e83ff19..ffd0a4c354c7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -643,6 +643,9 @@ $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
 		 ) > $$@)
 endif
 
+$(TRUNNER_OUTPUT)/resolve_btfids.test.o: $(RESOLVE_BTFIDS) $(TRUNNER_OUTPUT)/btf_data.bpf.o
+$(TRUNNER_OUTPUT)/resolve_btfids.test.o: private TEST_NEEDS_BTFIDS = 1
+
 # compile individual test files
 # Note: we cd into output directory to ensure embedded BPF object is found
 $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
@@ -650,6 +653,9 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$$(if $$(TEST_NEEDS_BTFIDS),					\
+		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)		\
+		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
@@ -695,13 +701,11 @@ $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
-			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
-	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 
-- 
2.52.0


