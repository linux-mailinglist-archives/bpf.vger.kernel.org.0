Return-Path: <bpf+bounces-77267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CB3CD3DFC
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC990300B81E
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0283283FC9;
	Sun, 21 Dec 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EGB7+s6a"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434102494F0
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310033; cv=none; b=jtMqMc55PVRnvTiyFnuTxNTC9I57Tt4OnzEyz+ztTsYX8ZpdNKD6gKEEYDlMJXM9tSKUCYPkv2OaXY2o5fIiGgMK8wTtJ+qvM++zvdKXyuM5nMJPBy8aF3Dl6/Qk53qOe3h7edfDfbsGaU0LjkBJj3RqFhFVo2Q3NdWityfc3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310033; c=relaxed/simple;
	bh=pOFt2iLm2cghq73PoRZHE1J+pxQdP/fPMw58aXNIdyk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jXTmfJO+/3TTqk9Lwa6fDLwE1aYXyvqrfuazPkIBIMLSJByeMODc6TZlSaXVshmv2HuVdpe62gZzN2ZQlQgeaWXAF9cQu4ND79JHzvkUl+4vDCLC39rpVbS2Y0kD1BfMe4DKD0ThUYW7jbBl6FyLqHlfJufNa2zRfVgk2CBKoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EGB7+s6a; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766310020;
	bh=IB6OkzvUB0YjBw9gOUD9+ckiE2h/E52GswThX1KUb94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGB7+s6anhYdEvi3a7IjYWnzm1vOQuCM+4zb9fZkXpf9S7HyXyhOkaSAUxi6MHZSN
	 Snay0ahTtX1STgEYKAlg8Mg3RlTbqYqWeWGzsfmMShNVMDjd7bHH3vTva322ntf3TW
	 k5ixM+D1JzDm2MKRxKeqR4q4QEHw+umv70FilRMQ=
Received: from wolframium.tail477849.ts.net ([122.224.66.116])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A11B3AA8; Sun, 21 Dec 2025 17:40:17 +0800
X-QQ-mid: xmsmtpt1766310017t8ncn1jhk
Message-ID: <tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com>
X-QQ-XMAILINFO: Nf5UeLegKxA6LzdeN61/HrXe1gwidKUweyiagJZ+/spq7NfI2ZyDjZkrOzZKIA
	 CSBycBTaMviL565gZdvz05Z3Q589/8Kp9yBEFvnISATSei++53HY6RbhDM+FdxB9/sQNuSqSJM9s
	 gqGky0NjruKV8EMfKisqavf+TvuO+qoRH0R+N/RPdJdTEe3B897hvoD2skY+AZH/435D+aSSFpl1
	 jOpe0JBcuq22ijv502PtPJbynTiFcB3lUNrNIN6YIhnmJalN9Rt+Zd+2VVZcr94uvQ+7XVm2YsEE
	 LzRNToUURp759K94UqPP09x8NInh+1a14TAAW46VGM+OvBgAqOiYNz6ofgQLKkEhKO7tAsVOafOK
	 labJChPAtlqmLyQGZpGf9AWvo2QpBhKarwNNSrkzOmrGiL/u+htMzHOJv3t8GIpUSvV2HWoBr2dJ
	 lPr7gx7ePnRRfqPv99a952ms2j/xzmnKW1bi2103zyfDQZ0BCr0AuB3/krwxvw7h89vxbrty+hmn
	 mNPTmn8m78ycABC5v5G9nvcqcNc1LNPdbsAuWOpoFLvNwawKcyYhLdDByok2JmWEb+jsGZzNLPc1
	 hCIXx90vMkLLrDvtIHtNx+RsQPkpyoclQN//JLEqHCH/FcKkKrOXvWJJcjSkRl+1qA4U4/Cm+DE8
	 pHYnDLULWOvZzeXYsQ5HNO81YEFotzk1pgCOFuh66OCa2bMt5GEyiqgnA6Bjjc3fQ47l4vkU7v5l
	 BDRd4qz8Fy4mL2RtTtyPIM4ejZVuDCNFucCSD7w3juVnegsrvQmuK3HK7x+2HC406cRCDX0d2Wsq
	 4XuUFxMS18Nzstpf45buPm+IsHxkLx1Gl1Peu080bPVcyvNEoKL9eJkKbjjmJIlOAwvoMysNBr0C
	 UnyhALM5xHJKhjDSGG88JcmTRC4YSdRlPMaO72zDJ+Yn6qZxaQ1n8ek7m5WY31aft7FaPpJcPBPH
	 49r8SzKZOxwzHmRn004Ihr1e6HRzB7yyF43mJuexJJRTn/mhVIijQgwhbJHBzGDmOHNyJN5V8WHB
	 Kex1VIFuUV0JEql0f9DGDSb8wVvLT347zE199kV/42gHAdJRZ8+J4lF3WDqrXZuZWwpbOskfQeoo
	 jr7hinC1NaGQ499d2t+MvTFemhEmgrdIJVs1l7SYjuXqtIC8OUmj/7GYLq4k8vUE7IYuflkAHqYw
	 gcYbL7IE+2hK3YGQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yazhou Tang <yazhoutang@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
Date: Sun, 21 Dec 2025 17:39:53 +0800
X-OQ-MSGID: <20251221093955.109312-2-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251221093955.109312-1-yazhoutang@foxmail.com>
References: <20251221093955.109312-1-yazhoutang@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazhou Tang <tangyazhou518@outlook.com>

This patch introduces interval analysis (range tracking) and tnum
analysis (bitwise tracking) for both signed and unsigned division
operations in the BPF verifier.

The BPF verifier currently lacks support for value tracking on BPF_DIV
instructions, which can lead to false positives during verification of
BPF programs that utilize division instructions.

According to the BPF instruction set[1], the instruction's offset field
(`insn->off`) is used to distinguish between signed (`off == 1`) and
unsigned division (`off == 0`). Moreover, we also follow the BPF division
semantics to handle special cases, such as division by zero and signed
division overflow.

- UDIV: dst = (src != 0) ? (dst / src) : 0
- SDIV: dst = (src == 0) ? 0 : ((src == -1 && dst == LLONG_MIN) ? LLONG_MIN : (dst / src))

Here is the overview of the changes made in this patch:

1. For interval analysis:
   - Added `scalar_min_max_udiv` and `scalar32_min_max_udiv` to update
     umin/umax bounds, which is straightforward.
   - Added `scalar_min_max_sdiv` and `scalar32_min_max_sdiv` to update
     smin/smax bounds. It handles non-monotonic intervals by decomposing
     the divisor range into negative, zero, and positive sub-ranges, and
     computing the result range for each sub-range separately. Finally,
     it combines the results to get the final smin/smax bounds.
2. For tnum analysis, we referred to LLVM's KnownBits implementation[2]
   and the recent research on abstract interpretation of division[3]:
   - Added `tnum_udiv` to compute the tnum for unsigned division. It
     calculates the maximum possible result based on the maximum values
     of the dividend tnum and the minimum values of the divisor tnum,
     then constructs the resulting tnum accordingly. We have prove its
     soundness using Rocq Prover[4].
   - Added `tnum_sdiv` to compute the tnum for signed division. It splits
     the operands into positive and negative components, then performs
     calculation on absolute values using `tnum_udiv`, finally unions
     the results to ensure soundness.
3. Also updated existing selftests based on the expected BPF_DIV behavior.

[1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruction-set.rst
[2] https://llvm.org/doxygen/KnownBits_8cpp_source.html
[3] https://dl.acm.org/doi/10.1145/3728905
[4] https://github.com/shenghaoyuan/open-verified-artifacts/tree/main/tnum

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
Hello everyone,

Thanks for reviewing our patch! This patch adds interval and tnum analysis
for both signed and unsigned BPF_DIV instructions in the BPF verifier.

We also have implemented interval and tnum analysis for BPF_MOD
instruction, which is closely related to division. However, to keep the
patch size manageable and facilitate easier review, we have decided to
submit the BPF_MOD related changes in a separate patch following this one.

Best,

Yazhou Tang

 include/linux/tnum.h                          |   4 +
 kernel/bpf/tnum.c                             | 159 ++++++++++++-
 kernel/bpf/verifier.c                         | 225 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
 4 files changed, 391 insertions(+), 4 deletions(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c52b862dad45..fd00deb2cb88 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -50,6 +50,10 @@ struct tnum tnum_or(struct tnum a, struct tnum b);
 struct tnum tnum_xor(struct tnum a, struct tnum b);
 /* Multiply two tnums, return @a * @b */
 struct tnum tnum_mul(struct tnum a, struct tnum b);
+/* Unsigned division, return @a / @b */
+struct tnum tnum_udiv(struct tnum a, struct tnum b);
+/* Signed division, return @a / @b */
+struct tnum tnum_sdiv(struct tnum a, struct tnum b, bool alu32);
 
 /* Return true if the known bits of both tnums have the same value */
 bool tnum_overlap(struct tnum a, struct tnum b);
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..d115528da6a6 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -12,6 +12,13 @@
 #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
 /* A completely unknown value */
 const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
+/* Tnum bottom */
+const struct tnum tnum_bottom = { .value = -1, .mask = -1 };
+
+static bool __tnum_eqb(struct tnum a, struct tnum b)
+{
+	return a.value == b.value && a.mask == b.mask;
+}
 
 struct tnum tnum_const(u64 value)
 {
@@ -83,9 +90,23 @@ struct tnum tnum_sub(struct tnum a, struct tnum b)
 	return TNUM(dv & ~mu, mu);
 }
 
+/* __tnum_neg_width: tnum negation with given bit width.
+ * @a: the tnum to be negated.
+ * @width: the bit width to perform negation, 32 or 64.
+ */
+static struct tnum __tnum_neg_width(struct tnum a, int width)
+{
+	if (width == 32)
+		return tnum_sub(TNUM(U32_MAX, 0), a);
+	else if (width == 64)
+		return tnum_sub(TNUM(0, 0), a);
+	else
+		return tnum_unknown;
+}
+
 struct tnum tnum_neg(struct tnum a)
 {
-	return tnum_sub(TNUM(0, 0), a);
+	return __tnum_neg_width(a, 64);
 }
 
 struct tnum tnum_and(struct tnum a, struct tnum b)
@@ -167,6 +188,138 @@ bool tnum_overlap(struct tnum a, struct tnum b)
 	return (a.value & mu) == (b.value & mu);
 }
 
+/* __get_mask: get a mask that covers all bits up to the highest set bit in x.
+ * For example:
+ *   x = 0b0000...0000 -> return 0b0000...0000
+ *   x = 0b0000...0001 -> return 0b0000...0001
+ *   x = 0b0000...1001 -> return 0b0000...1111
+ *   x = 0b1111...1111 -> return 0b1111...1111
+ */
+static u64 __get_mask(u64 x)
+{
+	int width = 0;
+
+	if (x > 0)
+		width = 64 - __builtin_clzll(x);
+	if (width == 0)
+		return 0;
+	else if (width == 64)
+		return U64_MAX;
+	else
+		return (1ULL << width) - 1;
+}
+
+struct tnum tnum_udiv(struct tnum a, struct tnum b)
+{
+	if (tnum_is_const(b)) {
+		/* BPF div specification: x / 0 = 0 */
+		if (b.value == 0)
+			return TNUM(0, 0);
+		if (tnum_is_const(a))
+			return TNUM(a.value / b.value, 0);
+	}
+
+	if (b.value == 0)
+		return tnum_unknown;
+
+	u64 a_max = a.value + a.mask;
+	u64 b_min = b.value;
+	u64 max_res = a_max / b_min;
+	return TNUM(0, __get_mask(max_res));
+}
+
+static u64 __msb(u64 x, int width)
+{
+	return x & (1ULL << (width - 1));
+}
+
+static struct tnum __tnum_get_positive(struct tnum x, int width)
+{
+	if (__msb(x.value, width))
+		return tnum_bottom;
+	if (__msb(x.mask, width))
+		return TNUM(x.value, x.mask & ~(1ULL << (width - 1)));
+	return x;
+}
+
+static struct tnum __tnum_get_negative(struct tnum x, int width)
+{
+	if (__msb(x.value, width))
+		return x;
+	if (__msb(x.mask, width))
+		return TNUM(x.value | (1ULL << (width - 1)), x.mask & ~(1ULL << (width - 1)));
+	return tnum_bottom;
+}
+
+static struct tnum __tnum_abs(struct tnum x, int width)
+{
+	if (__msb(x.value, width))
+		return __tnum_neg_width(x, width);
+	else
+		return x;
+}
+
+/* __tnum_sdiv, a helper for tnum_sdiv.
+ * @a: tnum a, a's sign is fixed, __msb(a.mask) == 0
+ * @b: tnum b, b's sign is fixed, __msb(b.mask) == 0
+ *
+ * This function reuses tnum_udiv by operating on the absolute values of a and b,
+ * and then adjusting the sign of the result based on C's division rules.
+ * Here we don't need to specially handle the case of [S64_MIN / -1], because
+ * after __tnum_abs, S64_MIN becomes (S64_MAX + 1), and the behavior of
+ * unsigned [(S64_MAX + 1) / 1] is normal.
+ */
+static struct tnum __tnum_sdiv(struct tnum a, struct tnum b, int width)
+{
+	if (__tnum_eqb(a, tnum_bottom) || __tnum_eqb(b, tnum_bottom))
+		return tnum_bottom;
+
+	struct tnum a_abs = __tnum_abs(a, width);
+	struct tnum b_abs = __tnum_abs(b, width);
+	struct tnum res_abs = tnum_udiv(a_abs, b_abs);
+
+	if (__msb(a.value, width) == __msb(b.value, width))
+		return res_abs;
+	else
+		return __tnum_neg_width(res_abs, width);
+}
+
+struct tnum tnum_sdiv(struct tnum a, struct tnum b, bool alu32)
+{
+	if (tnum_is_const(b)) {
+		/* BPF div specification: x / 0 = 0 */
+		if (b.value == 0)
+			return TNUM(0, 0);
+		if (tnum_is_const(a)) {
+			/* BPF div specification: S32_MIN / -1 = S32_MIN */
+			if (alu32 && (u32)a.value == (u32)S32_MIN && (u32)b.value == (u32)-1)
+				return TNUM((u32)S32_MIN, 0);
+			/* BPF div specification: S64_MIN / -1 = S64_MIN */
+			if (!alu32 && a.value == S64_MIN && b.value == (u64)-1)
+				return TNUM((u64)S64_MIN, 0);
+			s64 sval = (s64)a.value / (s64)b.value;
+			return TNUM((u64)sval, 0);
+		}
+	}
+
+	if (b.value == 0)
+		return tnum_unknown;
+
+	int width = alu32 ? 32 : 64;
+	struct tnum a_pos = __tnum_get_positive(a, width);
+	struct tnum a_neg = __tnum_get_negative(a, width);
+	struct tnum b_pos = __tnum_get_positive(b, width);
+	struct tnum b_neg = __tnum_get_negative(b, width);
+
+	struct tnum res_pos = __tnum_sdiv(a_pos, b_pos, width);
+	struct tnum res_neg = __tnum_sdiv(a_neg, b_neg, width);
+	struct tnum res_mix1 = __tnum_sdiv(a_pos, b_neg, width);
+	struct tnum res_mix2 = __tnum_sdiv(a_neg, b_pos, width);
+
+	return tnum_union(tnum_union(res_pos, res_neg),
+					tnum_union(res_mix1, res_mix2));
+}
+
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
  * a 'known 0' - this will return a 'known 1' for that bit.
  */
@@ -186,6 +339,10 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
  */
 struct tnum tnum_union(struct tnum a, struct tnum b)
 {
+	if (__tnum_eqb(a, tnum_bottom))
+		return b;
+	if (__tnum_eqb(b, tnum_bottom))
+		return a;
 	u64 v = a.value & b.value;
 	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6b8a77fbe3b..df04a35153ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15076,6 +15076,218 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 	}
 }
 
+static void __scalar32_min_max_join(s32 *res_min, s32 *res_max, s32 x_min, s32 x_max)
+{
+	*res_min = min(*res_min, x_min);
+	*res_max = max(*res_max, x_max);
+}
+
+static void __scalar_min_max_join(s64 *res_min, s64 *res_max, s64 x_min, s64 x_max)
+{
+	*res_min = min(*res_min, x_min);
+	*res_max = max(*res_max, x_max);
+}
+
+static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
+	u32 umin_val = src_reg->u32_min_value;
+	u32 umax_val = src_reg->u32_max_value;
+
+	if (umin_val == 0) {
+		/* BPF div specification: x / 0 = 0
+		 * 1. If umin_val == umax_val == 0, i.e. divisor is certainly 0,
+		 * then the result must be 0, [a,b] / [0,0] = [0,0].
+		 * 2. If umin_val == 0 && umax_val != 0, then dst_umin = x / 0 = 0,
+		 * dst_umax = dst_umax / 1, remains unchanged, [a,b] / [0,x] = [0,b].
+		 */
+		*dst_umin = 0;
+		if (umax_val == 0)
+			*dst_umax = 0;
+	} else {
+		*dst_umin = *dst_umin / umax_val;
+		*dst_umax = *dst_umax / umin_val;
+	}
+
+	/* Reset signed interval to TOP. */
+	dst_reg->s32_min_value = S32_MIN;
+	dst_reg->s32_max_value = S32_MAX;
+}
+
+static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
+	u64 umin_val = src_reg->umin_value;
+	u64 umax_val = src_reg->umax_value;
+
+	if (umin_val == 0) {
+		/* BPF div specification: x / 0 = 0
+		 * 1. If umin_val == umax_val == 0, i.e. divisor is certainly 0,
+		 * then the result must be 0, [a,b] / [0,0] = [0,0].
+		 * 2. If umin_val == 0 && umax_val != 0, then dst_umin = x / 0 = 0,
+		 * dst_umax = dst_umax / 1, remains unchanged, [a,b] / [0,x] = [0,b].
+		 */
+		*dst_umin = 0;
+		if (umax_val == 0)
+			*dst_umax = 0;
+	} else {
+		*dst_umin = *dst_umin / umax_val;
+		*dst_umax = *dst_umax / umin_val;
+	}
+
+	/* Reset signed interval to TOP. */
+	dst_reg->smin_value = S64_MIN;
+	dst_reg->smax_value = S64_MAX;
+}
+
+static s32 __bpf_sdiv32(s32 a, s32 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	/* BPF mod specification: S32_MIN / -1 = S32_MIN */
+	if (unlikely(a == S32_MIN && b == -1))
+		return S32_MIN;
+	return a / b;
+}
+
+/* The divisor interval does not cross 0,
+ * i.e. src_min and src_max have same sign.
+ */
+static void __sdiv32_range(s32 dst_min, s32 dst_max, s32 src_min, s32 src_max,
+				s32 *res_min, s32 *res_max)
+{
+	s32 tmp_res[4] = {
+		__bpf_sdiv32(dst_min, src_min),
+		__bpf_sdiv32(dst_min, src_max),
+		__bpf_sdiv32(dst_max, src_min),
+		__bpf_sdiv32(dst_max, src_max)
+	};
+
+	*res_min = min_array(tmp_res, 4);
+	*res_max = max_array(tmp_res, 4);
+}
+
+static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	u32 *dst_smin = &dst_reg->s32_min_value;
+	u32 *dst_smax = &dst_reg->s32_max_value;
+	u32 smin_val = src_reg->s32_min_value;
+	u32 smax_val = src_reg->s32_max_value;
+	s32 res_min, res_max, tmp_min, tmp_max;
+
+	if (smin_val <= 0 && smax_val >= 0) {
+		/* BPF div specification: x / 0 = 0
+		 * Set initial result to 0, as 0 is in divisor interval.
+		 */
+		res_min = 0;
+		res_max = 0;
+		/* negative divisor interval: [a_min,a_max] / [b_min,-1] */
+		if (smin_val < 0) {
+			__sdiv32_range(*dst_smin, *dst_smax, smin_val, -1,
+					&tmp_min, &tmp_max);
+			__scalar32_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
+		}
+		/* positive divisor interval: [a_min,a_max] / [1,b_max] */
+		if (smax_val > 0) {
+			__sdiv32_range(*dst_smin, *dst_smax, 1, smax_val,
+					&tmp_min, &tmp_max);
+			__scalar32_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
+		}
+	} else {
+		__sdiv32_range(*dst_smin, *dst_smax, smin_val, smax_val,
+			&res_min, &res_max);
+	}
+
+	/* BPF mod specification: S32_MIN / -1 = S32_MIN */
+	if (*dst_smin == S32_MIN && smin_val <= -1 && smax_val >= -1)
+		res_min = S32_MIN;
+
+	*dst_smin = res_min;
+	*dst_smax = res_max;
+
+	/* Reset unsigned interval to TOP. */
+	dst_reg->u32_min_value = 0;
+	dst_reg->u32_max_value = U32_MAX;
+}
+
+static s64 __bpf_sdiv(s64 a, s64 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	/* BPF div specification: S64_MIN / -1 = S64_MIN */
+	if (unlikely(a == S64_MIN && b == -1))
+		return S64_MIN;
+	return a / b;
+}
+
+/* The divisor interval does not cross 0,
+ * i.e. src_min and src_max have same sign.
+ */
+static void __sdiv_range(s64 dst_min, s64 dst_max, s64 src_min, s64 src_max,
+				s64 *res_min, s64 *res_max)
+{
+	s64 tmp_res[4] = {
+		__bpf_sdiv(dst_min, src_min),
+		__bpf_sdiv(dst_min, src_max),
+		__bpf_sdiv(dst_max, src_min),
+		__bpf_sdiv(dst_max, src_max)
+	};
+
+	*res_min = min_array(tmp_res, 4);
+	*res_max = max_array(tmp_res, 4);
+}
+
+static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
+	s64 smin_val = src_reg->smin_value;
+	s64 smax_val = src_reg->smax_value;
+	s64 res_min, res_max, tmp_min, tmp_max;
+
+	if (smin_val <= 0 && smax_val >= 0) {
+		/* BPF div specification: x / 0 = 0
+		 * Set initial result to 0, as 0 is in divisor interval.
+		 */
+		res_min = 0;
+		res_max = 0;
+		/* negative divisor interval: [a_min,a_max] / [b_min,-1] */
+		if (smin_val < 0) {
+			__sdiv_range(*dst_smin, *dst_smax, smin_val, -1,
+					&tmp_min, &tmp_max);
+			__scalar_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
+		}
+		/* positive divisor interval: [a_min,a_max] / [1,b_max] */
+		if (smax_val > 0) {
+			__sdiv_range(*dst_smin, *dst_smax, 1, smax_val,
+					&tmp_min, &tmp_max);
+			__scalar_min_max_join(&res_min, &res_max, tmp_min, tmp_max);
+		}
+	} else {
+		__sdiv_range(*dst_smin, *dst_smax, smin_val, smax_val,
+			&res_min, &res_max);
+	}
+
+	/* BPF mod specification: S64_MIN / -1 = S64_MIN */
+	if (*dst_smin == S64_MIN && smin_val <= -1 && smax_val >= -1)
+		res_min = S64_MIN;
+
+	*dst_smin = res_min;
+	*dst_smax = res_max;
+
+	/* Reset unsigned interval to TOP. */
+	dst_reg->umin_value = 0;
+	dst_reg->umax_value = U64_MAX;
+}
+
 static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
@@ -15479,6 +15691,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_XOR:
 	case BPF_OR:
 	case BPF_MUL:
+	case BPF_DIV:
 		return true;
 
 	/* Shift operators range is only computable if shift dimension operand
@@ -15504,6 +15717,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state src_reg)
 {
 	u8 opcode = BPF_OP(insn->code);
+	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
@@ -15555,6 +15769,17 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_mul(dst_reg, &src_reg);
 		scalar_min_max_mul(dst_reg, &src_reg);
 		break;
+	case BPF_DIV:
+		if (off == 1) {
+			dst_reg->var_off = tnum_sdiv(dst_reg->var_off, src_reg.var_off, alu32);
+			scalar32_min_max_sdiv(dst_reg, &src_reg);
+			scalar_min_max_sdiv(dst_reg, &src_reg);
+		} else {
+			dst_reg->var_off = tnum_udiv(dst_reg->var_off, src_reg.var_off);
+			scalar32_min_max_udiv(dst_reg, &src_reg);
+			scalar_min_max_udiv(dst_reg, &src_reg);
+		}
+		break;
 	case BPF_AND:
 		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_and(dst_reg, &src_reg);
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 2129e4353fd9..4d8273c258d5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -173,14 +173,15 @@ __naked void flow_keys_illegal_variable_offset_alu(void)
 	asm volatile("					\
 	r6 = r1;					\
 	r7 = *(u64*)(r6 + %[flow_keys_off]);		\
-	r8 = 8;						\
-	r8 /= 1;					\
+	call %[bpf_get_prandom_u32];			\
+	r8 = r0;					\
 	r8 &= 8;					\
 	r7 += r8;					\
 	r0 = *(u64*)(r7 + 0);				\
 	exit;						\
 "	:
-	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
+	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys)),
+	  __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
 
-- 
2.52.0


