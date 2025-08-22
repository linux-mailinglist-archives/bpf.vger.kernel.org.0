Return-Path: <bpf+bounces-66296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF66B3212C
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF87642212
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91131CA78;
	Fri, 22 Aug 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="Y9uXMI21"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8131CA68
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882522; cv=none; b=deukzobGQVGzxU2aYuXMsFaowDuZIhMzOC6/eE0h5VbfmV/t7HS/c0pGytMuxn4VyUdicTr5Vpb9TACabl0G6NaiTYDoJKZjGNgTyFRaOy7u+GOtS1B4tn7ShhyWP6LXz527wXqYnoGjNrcwS/VQYPhBCTw79nkqG/8a7qbonno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882522; c=relaxed/simple;
	bh=nQj6i4H9eR+p4aihvBOjbJ2gsiDJiKH/1QkfpCn+jKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJx9bBYlvGAIRG/cWd/0iFSgUro7WB23ag5Hh4tXnBhsD3u9sGSKH+hst1RfmpSG/QkEOK06yhzL9blth8Ws48CnIz2Yk4aXU1h17jOQkV0diBbRiLk1erO4eOo321H3GJn7rAaK3mR73wN0umat8HcwHtH46/NhRv3Ct9xZtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=Y9uXMI21; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.192.36])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 718FC44C9C;
	Fri, 22 Aug 2025 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755882518;
	bh=nQj6i4H9eR+p4aihvBOjbJ2gsiDJiKH/1QkfpCn+jKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9uXMI21i5Mp4EPZdbfjKnTovXIkCTJtjLyIKtJFlaK7OnNJazEDODT24fFanJe4v
	 /aX4ipbriv0fwhGyUJ/JAj2AcGRfKfkX+U2qJuFOF3LU4SlT5DjwuL2ca8sxfRpK3V
	 OK5OZAcTST7PoVwa6gjA89B6A3+hvjTpz8/Iw1o5nP55lcXt81SNuoJRXX+vTFBzIX
	 Dtb008TMByzoq/1IWRVPImVV/HPQJ81W1j37/596JMOaHLsCHX39mgA+c81Nub04+g
	 Y/kTCPmm3NPrRP8Z5DJXa/G40QBVVftL7gZ6NoIUrO5crR9UOPrJhX0kliWWg2l1EX
	 pNzwDph4POuvw==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v4 bpf-next 2/2] bpf: add selftest to check the verifier's abstract multiplication
Date: Fri, 22 Aug 2025 22:38:21 +0530
Message-Id: <20250822170821.2053848-2-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
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
 .../selftests/bpf/progs/verifier_mul.c        | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
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
index 000000000000..e7ccf19c7461
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mul.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Nandakumar Edamana */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+/* The programs here are meant to test the abstract multiplication
+ * technique(s) used by the verifier. Using assembly to prevent
+ * compiler optimizations.
+ */
+
+SEC("fentry/bpf_fentry_test1")
+void BPF_PROG(mul_0, int x)
+{
+	asm volatile ("\
+	call %[bpf_get_prandom_u32];\
+	r0 *= 0;\
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
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("At program exit the register R0 has smin=1 smax=1 should have been in [0, 0]")
+void BPF_PROG(mul_uncertain, int x)
+{
+	asm volatile ("\
+	call %[bpf_get_prandom_u32];\
+	r0 *= 0x3;\
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
+
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


