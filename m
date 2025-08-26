Return-Path: <bpf+bounces-66502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25DB35252
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D8F2410C3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5D1FE44B;
	Tue, 26 Aug 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="WoRXfpvl"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C71E4BE
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179945; cv=none; b=STOKiiOAXXyKL+bov80QhpUiSVlNRDjbvL0mKlV/Igbt5j5VIlEjI7Kn9OaOmGYNSSrHxMll2cs/mylrneXgS+WAg8L4VN6+0PxH+CJHPTCoKlLzZY1L4gJgYYhlNBQji/NBRZcCWMqtFo/VjHZu7AQbOjlaWrhp/1EytODmIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179945; c=relaxed/simple;
	bh=kXFr0D7EQwjRRZmlqUbaxxP+q/WcWcdaYkxEhyLYvZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KefrdbL4lP86nrzk3o50JNuErAQxHz2+euAxQKqQyd7ssBJw4Lu4Nr4Zah7M61W8+yqdwH0WkJvUiors8ZWtp3pfmwEYHLIaM2Hr2Axo2jOmuPfWMiwEG67lGRfS5Yl9EfXEm9U5IGTtRFmY3jvNCrmUgGDUkJB7oMqMRQR6gKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=WoRXfpvl; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 7E5B444C67;
	Tue, 26 Aug 2025 03:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756179938;
	bh=kXFr0D7EQwjRRZmlqUbaxxP+q/WcWcdaYkxEhyLYvZo=;
	h=From:To:Cc:Subject:Date:From;
	b=WoRXfpvlOBLoF/X0DwTTxnqrP7cEpqxBEO8FGHr+D7+l12gm4r9Al8RPErkvgeIOK
	 3kY94NaBnZ/+Jz6HFdSKdtVcr9NsxxKtMvNlLoQxDwdB2ilmoR4jv3rITQfHau34hO
	 tOTGQ7GcykZhvb8prh2T8ys+9dgJr2HmxNUopbkXgsxufksd62yRd4ScOkL1cXCSBe
	 i2dtGUShE5KzcwAS4vd/j2N+PuRiV+x/2sjozvDKFad96yrzVb/S/1HnTZUUiSXLZX
	 EK6F358Sj3+z5Scg70GTBZ0X3EfMlE3WD/9PwYg8B0OQJ5wseU5fNfSePpF8rMBiAT
	 sBAGEVt8OAZMA==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: alexei.starovoitov@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v6 bpf-next 1/2] bpf: Improve the general precision of tnum_mul
Date: Tue, 26 Aug 2025 09:15:23 +0530
Message-Id: <20250826034524.2159515-1-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Drop the value-mask decomposition technique and adopt straightforward
long-multiplication with a twist: when LSB(a) is uncertain, find the
two partial products (for LSB(a) = known 0 and LSB(a) = known 1) and
take a union.

Experiment shows that applying this technique in long multiplication
improves the precision in a significant number of cases (at the cost
of losing precision in a relatively lower number of cases).

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
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
index fa353c5d550f..a47183ddbfdb 100644
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
+/* Perform long multiplication, iterating through the bits in a using rshift:
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


