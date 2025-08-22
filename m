Return-Path: <bpf+bounces-66292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA4B32103
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79F51D617AD
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D73313539;
	Fri, 22 Aug 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="nwx2F8PV"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF03090C1
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882282; cv=none; b=Go0+5u5LMHHdp+YLPnxiA6BVDelu423YEJfXXBaGtwHevKWBo+IgHwn5Aq9Ueoa7DLByvxh3XZfrYBYhdFe4Jk3Mty5Yq7oTEblf7Y2E6ewCJih7McOEZ7lQ8aS3ryTfiC6l/S07SAi/8floEHYPtssZwU2YNoT7HWmV9yAxQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882282; c=relaxed/simple;
	bh=XfUqMT7rYSDrRd/Jd2YgaZzRUixoLuYuXauVjEud3Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1vs1nLS2xaPyBT3VRsRTX7VxmwjOKHRwiEx4wZDSN/wR4LCFm248RR3FtzfNnEdZMrmVB6JW/ChK5Dtwbzfglh+sDFENasBYIrt9Bm4R7GtsSAtiSrq04e/DeedWgrrcKfc3zHQFvVAE/SgoEV9PB7gg1j08p2/EaYKvenigFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=nwx2F8PV; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.192.36])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 1767D44C83;
	Fri, 22 Aug 2025 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755882276;
	bh=XfUqMT7rYSDrRd/Jd2YgaZzRUixoLuYuXauVjEud3Og=;
	h=From:To:Cc:Subject:Date:From;
	b=nwx2F8PVk4zPunpfcmOnsOhyI2ipQQbM4+hruXSEVkalUIrv//5FmdanAxJvLMBEQ
	 J79kqTvrc6d4YIdzFff2hjVKSyncaUuf9Gw25hAI0K5SCV+aePnfCzAU+ScIirxOWO
	 5pQJWBT3wfZL7lsP6JkpoP4QyUv7aMd6PGgo3PtGYoRv+52fjWIN7nMadIZOgUKPdK
	 p+ASD5TteaXtypQ46wW28jGazb1TQpt5g3/BHjqZrOL1Bd62+YFHwVm5IWWjDC9xRn
	 sxHfuWTwYXqqVtu7cXb9tJDvpid7xvKZ7G29iEfAdKqlVQd/3CZcadPgdD85U1dQnt
	 sbzuQ5LBHHhTQ==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH 1/2] bpf: improve the general precision of tnum_mul
Date: Fri, 22 Aug 2025 22:34:06 +0530
Message-Id: <20250822170407.2053504-1-nandakumar@nandakumar.co.in>
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
 kernel/bpf/tnum.c    | 47 ++++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 13 deletions(-)

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
-- 
2.39.5


