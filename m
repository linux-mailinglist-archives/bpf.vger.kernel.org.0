Return-Path: <bpf+bounces-66263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6158B30AF5
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 03:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993D61C859FF
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6031A316C;
	Fri, 22 Aug 2025 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="Jt7QyuVE"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769114A2D
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827308; cv=none; b=hvxH/diMZULHFA3m1tCRnwR2Vy3ZWFd4EALuqp0mt62JysC6ouEcOHQ5eGW4Ikjki7MRv4hkrovWHKiwkT5OoG208uh6YR4cNE5qTLVqqUvh47MWRlYraVPF7cY/j83Zt1QUw729s60G6dDMVMdzetZ1thP9IemZG2L3FuAODCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827308; c=relaxed/simple;
	bh=PTcdVPPrvTIMhmRoCIkJNvN3OGVdsvoNH5ITzAWAupc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADzXP9/zVJKb/zedx/Hky661b3koKUBzykr21XXrY/CpW/Se5MtopA5SX0zoZJZzzY+CmntN1HAYZLKjcRxLAMbYW74k1PMQb4A/hPVSheCPHYlyJrgT1etCjlV7QHKbqgoyuhteqFZdUK/ExFijsdfONZSVbkpFoNnvb2+UJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=Jt7QyuVE; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.194.55])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 9166C44C73;
	Fri, 22 Aug 2025 01:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755827296;
	bh=PTcdVPPrvTIMhmRoCIkJNvN3OGVdsvoNH5ITzAWAupc=;
	h=From:To:Cc:Subject:Date:From;
	b=Jt7QyuVE2pIGiD4KKg8OHwH8quF3S5jYoGYoOtYlXeB45IH/ce5TNsoiMvNcV1Mk5
	 uVeFfwfEUO5vP30InrF7UiDNs8RuhZkZFoyNwHU1mhb7+zeUVBQHokGnQ7fCtwh7wx
	 Ey9AnQoZpL5Bx2GxRq0ja0akQbb2/nVfW/O6omOY+8//hua60bvFH717EUdjpXjFsF
	 G329PGeyvUoSSIx37E3fSBk07iH1/KDHBJDa+eUE+CNr3MJnJxNchSdJxdGtkbbS04
	 Yx46y/DARO+soBzF14Nx8sWdDcH2Bf8Bp6S7aNU1ZvpUrOhI+y9kotQhaKyrTTElzJ
	 7dRc6tJnj7XvA==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v3 bpf-next] bpf: improve the general precision of tnum_mul
Date: Fri, 22 Aug 2025 07:17:54 +0530
Message-Id: <20250822014754.1962075-1-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit addresses a challenge explained in an open question ("How
can we incorporate correlation in unknown bits across partial
products?") left by Harishankar et al. in their paper:
https://arxiv.org/abs/2105.05398

When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
from which we could find two possible partial products and take a
union. Experiment shows that applying this technique in long
multiplication improves the precision in a significant number of cases
(at the cost of losing precision in a relatively lower number of
cases).

This commit also removes the value-mask decomposition technique
employed by Harishankar et al., as its direct incorporation did not
result in any improvements for the new algorithm.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
---
 include/linux/tnum.h                          |  3 +
 kernel/bpf/tnum.c                             | 47 ++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_mul.c        | 74 +++++++++++++++++++
 4 files changed, 113 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mul.c

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 57ed3035cc30..68e9cdd0a2ab 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -54,6 +54,9 @@ struct tnum tnum_mul(struct tnum a, struct tnum b);
 /* Return a tnum representing numbers satisfying both @a and @b */
 struct tnum tnum_intersect(struct tnum a, struct tnum b);
 
+/* Returns a tnum representing numbers satisfying either @a or @b */
+struct tnum tnum_union(struct tnum t1, struct tnum t2);
+
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index fa353c5d550f..50e4d34d4774 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -116,31 +116,39 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
-/* Generate partial products by multiplying each bit in the multiplier (tnum a)
- * with the multiplicand (tnum b), and add the partial products after
- * appropriately bit-shifting them. Instead of directly performing tnum addition
- * on the generated partial products, equivalenty, decompose each partial
- * product into two tnums, consisting of the value-sum (acc_v) and the
- * mask-sum (acc_m) and then perform tnum addition on them. The following paper
- * explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
+/* Perform long multiplication, iterating through the trits in a.
+ * Inside `else if (a.mask & 1)`, instead of simply multiplying b with LSB(a)'s
+ * uncertainty and accumulating directly, we find two possible partial products
+ * (one for LSB(a) = 0 and another for LSB(a) = 1), and add their union to the
+ * accumulator. This addresses an issue pointed out in an open question ("How
+ * can we incorporate correlation in unknown bits across partial products?")
+ * left by Harishankar et al. (https://arxiv.org/abs/2105.05398), improving
+ * the general precision significantly.
  */
 struct tnum tnum_mul(struct tnum a, struct tnum b)
 {
-	u64 acc_v = a.value * b.value;
-	struct tnum acc_m = TNUM(0, 0);
+	struct tnum acc = TNUM(0, 0);
 
 	while (a.value || a.mask) {
 		/* LSB of tnum a is a certain 1 */
 		if (a.value & 1)
-			acc_m = tnum_add(acc_m, TNUM(0, b.mask));
+			acc = tnum_add(acc, b);
 		/* LSB of tnum a is uncertain */
-		else if (a.mask & 1)
-			acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
+		else if (a.mask & 1) {
+			/* acc = tnum_union(acc_0, acc_1), where acc_0 and
+			 * acc_1 are partial accumulators for cases
+			 * LSB(a) = certain 0 and LSB(a) = certain 1.
+			 * acc_0 = acc + 0 * b = acc.
+			 * acc_1 = acc + 1 * b = tnum_add(acc, b).
+			 */
+
+			acc = tnum_union(acc, tnum_add(acc, b));
+		}
 		/* Note: no case for LSB is certain 0 */
 		a = tnum_rshift(a, 1);
 		b = tnum_lshift(b, 1);
 	}
-	return tnum_add(TNUM(acc_v, 0), acc_m);
+	return acc;
 }
 
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
@@ -155,6 +163,19 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
+/* Returns a tnum with the uncertainty from both a and b, and in addition, new
+ * uncertainty at any position that a and b disagree. This represents a
+ * superset of the union of the concrete sets of both a and b. Despite the
+ * overapproximation, it is optimal.
+ */
+struct tnum tnum_union(struct tnum a, struct tnum b)
+{
+	u64 v = a.value & b.value;
+	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
+
+	return TNUM(v & ~mu, mu);
+}
+
 struct tnum tnum_cast(struct tnum a, u8 size)
 {
 	a.value &= (1ULL << (size * 8)) - 1;
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
index 000000000000..1bed2a3b4728
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mul.c
@@ -0,0 +1,74 @@
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
+	asm volatile (" \
+	call %[bpf_get_prandom_u32];\
+	r0 *= 0;\
+	if r0 != 0 goto l0_%=;\
+	r0 = 0;\
+	goto l1_%=;\
+l0_%=:\
+	r0 = 1;\
+l1_%=:\
+" :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("At program exit the register R0 has smin=1 smax=1 should have been in [0, 0]")
+void BPF_PROG(mul_uncertain, int x)
+{
+	asm volatile (" \
+	call %[bpf_get_prandom_u32];\
+	r0 *= 0x3;\
+	if r0 != 0 goto l0_%=;\
+	r0 = 0;\
+	goto l1_%=;\
+l0_%=:\
+	r0 = 1;\
+l1_%=:\
+" :
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
+	 * Then a * 0x3 would be m0m1 (m for uncertain). Added imprecision would
+	 * cause the following to fail, because the required return value is 0.:
+	 *     return (a * 0x3) & 0x4);
+	 */
+
+	asm volatile ("call %[bpf_get_prandom_u32];\
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
+" :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
-- 
2.39.5


