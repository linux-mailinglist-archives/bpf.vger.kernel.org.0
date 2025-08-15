Return-Path: <bpf+bounces-65774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10111B2813D
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80BDB60970
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2D1A9B53;
	Fri, 15 Aug 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="hxSy9XNx"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD061C8631
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266761; cv=none; b=StlTmP4fhbUwZAagcDHGRsw7mqiPoVmIJ/4OJE2bhy/fUuROYZ8MuV6CRfM6ngsVaxcp71eLXsqqbrPQ1CuaqIKI+4la7QJtNNw6pJuzPaaG/pbsC0rc2Ky1F8r3N/GKZwr+gCetFhcwv9zFQvm3lImJiYq4Vhs6d0drgO+fvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266761; c=relaxed/simple;
	bh=5GSj/3dJGaWd1F8Q4JLpeIoz8Ux76AjCWx8VwZLllm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGYTPCIMDCythBkxP8cJIGJzExDzujs00kDKU8hfyvOhbKz014j6u/FiAxpZ40jo34XfinvOt6HY0+FwS95zEPI9qQUB4R67BwSq67e+HSOO5zsk7jNXGPjJHbua9lRlrhUyIDIbSQ4vp4LrrcRv8i0uZTH3zRrAFO+k9pyTSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=hxSy9XNx; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [120.61.162.151])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 3C41344BAD;
	Fri, 15 Aug 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755266748;
	bh=5GSj/3dJGaWd1F8Q4JLpeIoz8Ux76AjCWx8VwZLllm0=;
	h=From:To:Cc:Subject:Date:From;
	b=hxSy9XNx84w4qvpgbiY/5PsF0G+FhpY0A6/HCrUKopHYOG0xQZK8jZt4r6aDFgxuE
	 Zqx5KIr0q6tc+OnoGlpn0c4knsGeMHx1eYw06XfpOm6RoDeldmApsxA2JMvByHW22K
	 juqfj3kTZuSBfJMYmhzOPpIQ0a9a2w7st9zAKHty80LgLM4PCaNV1TUwqhrgj1S7lC
	 h29KX830fp+8GoVx2j90yYkIE0eQX1vKn7ExcPGzBFMAiIT2Xg4DMgIcIamu9mWpqd
	 XSLm0F8qjqW8QdYDkaHF0wqygRhgVmrG80xh+CIaUC1+ik2hjQCtzIY3c4w5qsPCBR
	 hkoY7tli1zIwg==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH v2 bpf-next] bpf: improve the general precision of tnum_mul
Date: Fri, 15 Aug 2025 19:35:10 +0530
Message-Id: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
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
 kernel/bpf/tnum.c    | 42 +++++++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

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
index fa353c5d550f..a9894711786a 100644
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
+			/* acc += tnum_union(acc_0, acc_1), where acc_0 and
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
@@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
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


