Return-Path: <bpf+bounces-66410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFDEB348A7
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BF52060DD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE3301006;
	Mon, 25 Aug 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="iiXl1Lo9"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DB30276D
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143006; cv=none; b=bSmwiVEej8cw+mf83stGlhEj10wkmDLKO0y6/F1DPTmu/bQksrW+TU2ZUSyuFJ48DkT1PXDRdljiUOOnvPfpZxT1O1coARR8kVQnEKQCyaxUbj3VgrVBWzl73oxhGTRpUz1c/UfxmgyXqDDYHv5UKr1M4jzG8aqsi+ahXEkQz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143006; c=relaxed/simple;
	bh=HZCnUN6ybVZzbvlIkuzw2l487lxeydV8sJXeAl1R31Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbCYr+2LU2DTqNqaJT5jva5s4CW+LN39LbbQ0lBb4aRKPhJbC4+E5iGgS9cbIHaH2sT09fIKMpnS7xeZr1lsqNgEzvx/jW5inXyPPXJpwBh0xW5/R1dOELjzrH+uEiWBGs/LhUn1hTntMZh3TwtfZ/saYH4JoZjMBF74jifzb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=iiXl1Lo9; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.192.16])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id B85E843FF4;
	Mon, 25 Aug 2025 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756143000;
	bh=HZCnUN6ybVZzbvlIkuzw2l487lxeydV8sJXeAl1R31Q=;
	h=From:To:Cc:Subject:Date:From;
	b=iiXl1Lo9dysW+3k3etI6fn4FphLPDb055Rxjdn2N0DbcKhExSS8SA2aFKbbXW4m+k
	 8ZJHFzKlWst0oHnT6HlaYSgFxvytE+O9kYkcxJr4jQnBXzfJolU1VIBpZToObtOA61
	 uqxUk/1Rdy8lzMFLSeahpkuDXywQuFM53FRBdX1FiLKLTl62iieYWb+i99ux9vlWBa
	 fiNzxXrJFBHgwBlWNAE0HfmFsAsibIvhERzYKuTESZvDoUhbJ/nM/lIRd8M25Wrq2M
	 RoaPrEcyMoTbJwjxoaf1rWgQcEVcQKXSsJgGCWvf6IXad72Qt5lb+Udc6OauF4bss6
	 O2w1gKz+x7+tQ==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of tnum_mul
Date: Mon, 25 Aug 2025 22:59:45 +0530
Message-Id: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

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
 include/linux/tnum.h |  3 +++
 kernel/bpf/tnum.c    | 55 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 13 deletions(-)

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
index fa353c5d550f..c98aa148e666 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -116,31 +116,47 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
-/* Generate partial products by multiplying each bit in the multiplier (tnum a)
- * with the multiplicand (tnum b), and add the partial products after
- * appropriately bit-shifting them. Instead of directly performing tnum addition
- * on the generated partial products, equivalenty, decompose each partial
- * product into two tnums, consisting of the value-sum (acc_v) and the
- * mask-sum (acc_m) and then perform tnum addition on them. The following paper
- * explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
+/* Perform long multiplication, iterating through the trits in a:
+ * - if LSB(a) is a known 0, keep current accumulator
+ * - if LSB(a) is a known 1, add b to current accumulator
+ * - if LSB(a) is unknown, take a union of the above cases.
+ *
+ * For example:
+ *
+ *               acc_0:        acc_1:
+ *
+ *     11 *  ->      11 *  ->      11 *  -> union(0011, 1001) == x0x1
+ *     x1            01            11
+ * ------        ------        ------
+ *     11            11            11
+ *    xx            00            11
+ * ------        ------        ------
+ *   ????          0011          1001
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
@@ -155,6 +171,19 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
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
-- 
2.39.5


