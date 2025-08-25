Return-Path: <bpf+bounces-66411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57808B348A8
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A73B09D5
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D49302CDF;
	Mon, 25 Aug 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="geK0iRYj"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A42F99BE
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143009; cv=none; b=e9eB8R+vzMLwG6alemXQclm5W/Ycogx28ykzyCEvFVZ61QHA+MaVaLvcEd77oEGq9Do7QT/pTmtTVQLoIL8DLsrCMWUwuNWP9jiRR1C75nvoSpr4GtPsWT6DEV5zqmRpyEnF8pkknk/o2dt6kTFhASfiy2g/Jc7Ti1Ctea3dJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143009; c=relaxed/simple;
	bh=4dmOCH/NPGn7ilvdGySMPrqPjNfzWnll+18itgLHN5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQ4xYJZq+UZ6jH11s27xKVUTDYhhrR+trY+mWY7PbQyOPx6K/UQ88loBGtJv9GMEqXM/k47Canhz4DkFIRkUtcZJFmHcSHjN2SxSfG308tZMQsSPtHGM2hYDOxW7jE8ZSUguFofzCmcAF/vSXqcOw6Gg1FmRkqeaB8Zoo7wruUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=geK0iRYj; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.192.16])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 1772F44CCC;
	Mon, 25 Aug 2025 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756143004;
	bh=4dmOCH/NPGn7ilvdGySMPrqPjNfzWnll+18itgLHN5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=geK0iRYjm98jeYDWEzNShaRFpZcTHumscDUw0XUQvpWoTa9tBtM4Xhbh9QErGkn8/
	 UT50FrFf8M2dNbV9NC3HvbwRljM472T5hJEokJRxyinefHns6GOKVi/kcwfDbLtDO+
	 DhzeeLKEmRjb1UJMJoFSK6nobnLVcCVM4C0yzcyQhPJ1+n+DfyTUyImYFyfech3Tpi
	 T7UQ3KkiGrUt22m0vXVlRSuoXPY+IlxQVwVOSnjupO5rliCwhoGKS+R5eY5bwE99IR
	 mtCjr07sboUGsOf4Tm2fiVRL7BWKpMTz10TjJYj+zKPKPEPDBk9d/InCAfiDBecxkJ
	 SGMfgWF+aj0vw==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v5 bpf-next 2/2] bpf: add selftest to check the verifier's abstract multiplication
Date: Mon, 25 Aug 2025 22:59:46 +0530
Message-Id: <20250825172946.2141497-2-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

This commit adds selftest to test the abstract multiplication
technique(s) used by the verifier, following the recent improvement in
tnum multiplication (tnum_mul). One of the newly added programs,
verifier_mul/mul_precise, results in a false positive with the old
tnum_mul, while the program passes with the latest one.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_mul.c        | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mul.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 77ec95d4ffaa..e35c216dbaf2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -59,6 +59,7 @@
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
+#include "verifier_mul.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
@@ -194,6 +195,7 @@ void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
+void test_verifier_mul(void)                  { RUN(verifier_mul); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mul.c b/tools/testing/selftests/bpf/progs/verifier_mul.c
new file mode 100644
index 000000000000..7145fe3351d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mul.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Nandakumar Edamana */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+/* Intended to test the abstract multiplication technique(s) used by
+ * the verifier. Using assembly to avoid compiler optimizations.
+ */
+SEC("fentry/bpf_fentry_test1")
+void BPF_PROG(mul_precise, int x)
+{
+	/* First, force the verifier to be uncertain about the value:
+	 *     unsigned int a = (bpf_get_prandom_u32() & 0x2) | 0x1;
+	 *
+	 * Assuming the verifier is using tnum, a must be tnum{.v=0x1, .m=0x2}.
+	 * Then a * 0x3 would be m0m1 (m for uncertain). Added imprecision
+	 * would cause the following to fail, because the required return value
+	 * is 0:
+	 *     return (a * 0x3) & 0x4);
+	 */
+	asm volatile ("\
+	call %[bpf_get_prandom_u32];\
+	r0 &= 0x2;\
+	r0 |= 0x1;\
+	r0 *= 0x3;\
+	r0 &= 0x4;\
+	if r0 != 0 goto l0_%=;\
+	r0 = 0;\
+	goto l1_%=;\
+l0_%=:\
+	r0 = 1;\
+l1_%=:\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
-- 
2.39.5


