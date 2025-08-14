Return-Path: <bpf+bounces-65599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0BB25B72
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 08:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DD88838F3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4001D90AD;
	Thu, 14 Aug 2025 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="AEI1JF1w"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7F21FF5E
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151248; cv=none; b=tdJd3pHTCdg9aFGlRIQQ46ENTy/LbhBlyS+sXP/vofTGIev8kDSCJ+rZMqcIUAsKVOfGaFh75XUiUK52Lu3NDBJ8T3TkufN1I5b1xArEbJ8Epbcq0KeEf1pY6RIDe96BKPFHSEdgfkeYpNNByIrfqXuqxi74ghFyAIB/MJHlIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151248; c=relaxed/simple;
	bh=l63tudJfJujte34u/7/OZZwJ6ASdE00KC3lDVsws2V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pufkl9NpuFFwp66bmBLL01pnYMKrLPsYmnTMQ6CkTRQv7wl7qtgY8rpTxeUMg5LiQ7rtl5cxcpZn+nCc1aPDwi7rs7AkNsAKwZjLaD88SNyG2xJMTyXR4H4ATaJbic7eYSGdBPURMybIB9mYknlWIpWILm7q569hvdt0aHGLrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=AEI1JF1w; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 86E8D44BCD;
	Thu, 14 Aug 2025 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755150668;
	bh=l63tudJfJujte34u/7/OZZwJ6ASdE00KC3lDVsws2V0=;
	h=From:To:Cc:Subject:Date:From;
	b=AEI1JF1wlUrn3pRCm4ShbS5B1s+6ZmKQQp1gppD4HqQ5FX10Q5fl54/l6tKPwgD48
	 k3Bqq+ve9djw66IH+5q2aQrZVsFRAjDH9KaWDqCb5QLH6njt1fqk/2MXhYQRisZM0W
	 Ob/9a/G34Eu7gbURC6O/25oJfvSwBommWf6z/8cnXnkoLw7tjpERhtWi92R5pNY406
	 w5ydA5sStk3z/5ZlYtMFd2mMX25pfBqIWN19YIrAlhVjUp9yhg3BFpDc3ZlJede8Qe
	 wmQbWfpujTMuAir+ubGQJtqryVrC7yK6iDo9c9NOzrM6rFM+/32DzgZ9cxFst4vp5b
	 RLYf17j0kGSOA==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH bpf-next] bpf: improve the general precision of tnum_mul
Date: Thu, 14 Aug 2025 11:20:55 +0530
Message-Id: <20250814055055.1199797-1-nandakumar@nandakumar.co.in>
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
 include/linux/tnum.h |  3 +++
 kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 14 deletions(-)

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
index fa353c5d550f..1ae00dbc8b0e 100644
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
+/* Perform long multiplication, iterating through the trits in a. A small trick
+ * inside the loop finds two possible partial products and takes their union,
+ * improving the precision significantly.
+ * A comment inside refers to a paper by Harishankar et al.:
+ * https://arxiv.org/abs/2105.05398
  */
 struct tnum tnum_mul(struct tnum a, struct tnum b)
 {
-	u64 acc_v = a.value * b.value;
-	struct tnum acc_m = TNUM(0, 0);
+	struct tnum acc = TNUM(0, 0);
 
 	while (a.value || a.mask) {
 		/* LSB of tnum a is a certain 1 */
-		if (a.value & 1)
-			acc_m = tnum_add(acc_m, TNUM(0, b.mask));
+		if (a.value & 1) {
+			acc = tnum_add(acc, b);
+		}
 		/* LSB of tnum a is uncertain */
-		else if (a.mask & 1)
-			acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
+		else if (a.mask & 1) {
+			/* Simply multiplying b with LSB(a)'s uncertainty results in decreased
+			 * precision, as explained in an open question ("How can we incorporate
+			 * correlation in unknown bits across partial products?") left by
+			 * Harishankar et al. However, we know for sure that LSB(a) is either
+			 * 0 or 1, from which we could find two possible partial products and
+			 * take a union. This improves the precision in a significant number of
+			 * cases.
+			 *
+			 * The first partial product (acc_0) is for the case LSB(a) = 0;
+			 * but acc_0 = acc + 0 * b = acc.
+			 */
+
+			/* In case LSB(a) is 1 */
+			u64 itermask = b.value | b.mask;
+			struct tnum iterprod = TNUM(b.value & ~itermask, itermask);
+			struct tnum acc_1 = tnum_add(acc, iterprod);
+
+			acc = tnum_union(acc, acc_1);
+		}
 		/* Note: no case for LSB is certain 0 */
 		a = tnum_rshift(a, 1);
 		b = tnum_lshift(b, 1);
 	}
-	return tnum_add(TNUM(acc_v, 0), acc_m);
+	return acc;
 }
 
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
@@ -155,6 +171,14 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
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


