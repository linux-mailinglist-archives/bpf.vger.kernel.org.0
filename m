Return-Path: <bpf+bounces-78688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F867D18136
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9409030042B1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CF32A3FD;
	Tue, 13 Jan 2026 10:36:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F672D5432
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300610; cv=none; b=G+51FrpyB9bYcKGaOYoHsSWTttSTdWgNvKJkrwfZikux1v7Qqf8rXgLA5/PA+Ke0xU5eCbCdGpnJ2G3Qvn3olXdRP1sh4F1vUdiBexNPPfrvtwQW34eksXkQwReNEc4HiB88bVaElmk9Xh9m1iMTbn97Rxb5QTIZQ+FzKc1rg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300610; c=relaxed/simple;
	bh=OpVZVMX/ThqnvW1GSfmlN/0P3WgnJv4eqWyHgX/2z1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8DM1ab1syQ1TFEhLl78bjS2div1bmXt/fjkto3HntoWfkrQn8okMTwXpzbuE7GGGhdvaXwyDGMsL4m43pYJJANAK2JoNUgdfS6r1wk5IA0EmRHRuZuV0kQX8GwPFidbRh9rgYsVIKjXM3a2Bge8QqX7C4VApLy3d28S41lfnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wAX8tocIGZpx1i6AQ--.2118S3;
	Tue, 13 Jan 2026 18:36:12 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app3 (Coremail) with SMTP id zS_KCgDX2m0XIGZpu8iSBQ--.30181S2;
	Tue, 13 Jan 2026 18:36:07 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
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
	ziye@zju.edu.cn,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
Date: Tue, 13 Jan 2026 18:35:51 +0800
Message-ID: <20260113103552.3435695-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113103552.3435695-1-tangyazhou@zju.edu.cn>
References: <20260113103552.3435695-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDX2m0XIGZpu8iSBQ--.30181S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAggFCmletwUeXgAEsE
X-CM-DELIVERINFO: =?B?u4slJwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9B+mI5GDwxuQL0PB6Ii/1Uo0fiebzxKn7yw9/KDGAk5mZUEG8gi+GiLFyqcKQuTyDrwv
	oxqLUT/52+PbzqXza8Nn3CJTIcWTEcyNoa5LWH5myaLyJodOOGcB0eJgeEaryw==
X-Coremail-Antispam: 1Uk129KBj9fXoWfGw1DCryfurWfXw4UJw4xGrX_yoW8Ar4fuo
	WFgF1IyryxKFn2gF92krn5A3WYgw1xCr1kGFW5K3Z8CF1UAr13Xa48C39rXF4Fvw10krWU
	Z3WDJ39xZFykJanxl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYp7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UNtxhUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

This patch implements range tracking (interval analysis) for BPF_DIV and
BPF_MOD operations when the divisor is a constant, covering both signed
and unsigned variants.

While LLVM typically optimizes integer division and modulo by constants
into multiplication and shift sequences, this optimization is less
effective for the BPF target when dealing with 64-bit arithmetic.

Currently, the verifier does not track bounds for scalar division or
modulo, treating the result as "unbounded". This leads to false positive
rejections for safe code patterns.

For example, the following code (compiled with -O2):

```c
int test(struct pt_regs *ctx) {
    char buffer[6] = {1};
    __u64 x = bpf_ktime_get_ns();
    __u64 res = x % sizeof(buffer);
    char value = buffer[res];
    bpf_printk("res = %llu, val = %d", res, value);
    return 0;
}
```

Generates a raw `BPF_MOD64` instruction:

```asm
;     __u64 res = x % sizeof(buffer);
       1:	97 00 00 00 06 00 00 00	r0 %= 0x6
;     char value = buffer[res];
       2:	18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r1 = 0x0 ll
       4:	0f 01 00 00 00 00 00 00	r1 += r0
       5:	91 14 00 00 00 00 00 00	r4 = *(s8 *)(r1 + 0x0)
```

Without this patch, the verifier fails with "math between map_value
pointer and register with unbounded min value is not allowed" because
it cannot deduce that `r0` is within [0, 5].

According to the BPF instruction set[1], the instruction's offset field
(`insn->off`) is used to distinguish between signed (`off == 1`) and
unsigned division (`off == 0`). Moreover, we also follow the BPF division
and modulo semantics (runtime behavior) to handle special cases, such as
division by zero and signed division overflow.

- UDIV: dst = (src != 0) ? (dst / src) : 0
- SDIV: dst = (src == 0) ? 0 : ((src == -1 && dst == LLONG_MIN) ? LLONG_MIN : (dst / src))
- UMOD: dst = (src != 0) ? (dst % src) : dst
- SMOD: dst = (src == 0) ? dst : ((src == -1 && dst == LLONG_MIN) ? 0: (dst s% src))

Here is the overview of the changes made in this patch (See the code comments
for more details and examples):

For BPF_DIV:
1. Main analysis:
   - General cases and "division by zero" case: compute the new range by
     dividing max_dividend and min_dividend by the constant divisor.
     Use helper functions `__bpf_udiv32`, `__bpf_udiv`, `__bpf_sdiv32`,
     and `__bpf_sdiv` to encapsulate the division logic, including handling
     division by zero.
   - "SIGNED_MIN / -1" case in signed division: mark the result as unbounded
     if the dividend is not a single number.
2. Post-processing:
   - Domain reset: Signed analysis resets unsigned bounds to unbounded,
     and vice versa.
   - Width reset: 32-bit analysis resets 64-bit bounds to unbounded
     (and vice versa) to maintain consistency.
   - Tnum reset: reset `var_off` to unknown since precise bitwise tracking
     for division is not implemented.

For BPF_MOD:
1. Main analysis:
   - General case: For signed modulo, the result's sign matches the
     dividend's sign. The result's absolute value is strictly bounded
     by min(abs(dividend), abs(divisor) - 1).
     Special care is taken when the divisor is SIGNED_MIN. By casting
     to unsigned before negation and subtracting 1, we avoid signed
     overflow and correctly calculate the maximum possible magnitude
     (`res_max_abs` in the code).
   - "Division by zero" case: If the divisor is zero, the destination
     register remains unchanged (matching runtime behavior).
   - "Small dividend" case: If the dividend is already within the possible
     result range (e.g., [2, 5] % 10), the operation is an identity
     function, and the register state remains unchanged.
2. Post-processing (if the result is changed compared to the dividend):
   - Domain reset: Signed analysis resets unsigned bounds to unbounded,
     and vice versa.
   - Width reset: 32-bit analysis resets 64-bit bounds to unbounded
     (and vice versa) to maintain consistency.
   - Tnum reset: reset `var_off` to unknown since precise bitwise tracking
     for division is not implemented.

Also updated existing selftests based on the expected BPF_DIV and
BPF_MOD behavior.

[1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruction-set.rst

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 kernel/bpf/verifier.c                         | 326 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
 .../testing/selftests/bpf/verifier/precise.c  |   4 +-
 3 files changed, 332 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..f3b51751d990 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15077,6 +15077,283 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 	}
 }
 
+static u32 __bpf_udiv32(u32 a, u32 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	return a / b;
+}
+
+static u64 __bpf_udiv(u64 a, u64 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	return a / b;
+}
+
+static s32 __bpf_sdiv32(s32 a, s32 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	return a / b;
+}
+
+static s64 __bpf_sdiv(s64 a, s64 b)
+{
+	/* BPF div specification: x / 0 = 0 */
+	if (unlikely(b == 0))
+		return 0;
+	return a / b;
+}
+
+static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
+				  struct bpf_reg_state *src_reg)
+{
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
+	u32 src_val = src_reg->u32_min_value; /* const divisor */
+
+	*dst_umin = __bpf_udiv32(*dst_umin, src_val);
+	*dst_umax = __bpf_udiv32(*dst_umax, src_val);
+
+	/* Reset signed range to unbounded. */
+	dst_reg->s32_min_value = S32_MIN;
+	dst_reg->s32_max_value = S32_MAX;
+}
+
+static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
+	u64 src_val = src_reg->umin_value; /* const divisor */
+
+	*dst_umin = __bpf_udiv(*dst_umin, src_val);
+	*dst_umax = __bpf_udiv(*dst_umax, src_val);
+
+	/* Reset signed range to unbounded. */
+	dst_reg->smin_value = S64_MIN;
+	dst_reg->smax_value = S64_MAX;
+}
+
+static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
+				  struct bpf_reg_state *src_reg)
+{
+	s32 *dst_smin = &dst_reg->s32_min_value;
+	s32 *dst_smax = &dst_reg->s32_max_value;
+	s32 src_val = src_reg->u32_min_value; /* const divisor */
+	s32 res1, res2;
+
+	/* BPF div specification: S32_MIN / -1 = S32_MIN */
+	if (*dst_smin == S32_MIN && src_val == -1) {
+		/* If dividend is not a single number, e.g., [S32_MIN, S32_MIN+10]/(-1),
+		 * the result = {S32_MIN} U [-(S32_MIN+10), -(S32_MIN+1)]
+		 *            = {S32_MIN} U [S32_MAX-9, S32_MAX] = [S32_MIN, S32_MAX]
+		 * which is unbounded.
+		 */
+		if (*dst_smax != S32_MIN)
+			__mark_reg32_unbounded(dst_reg);
+		return;
+	}
+
+	res1 = __bpf_sdiv32(*dst_smin, src_val);
+	res2 = __bpf_sdiv32(*dst_smax, src_val);
+	*dst_smin = min(res1, res2);
+	*dst_smax = max(res1, res2);
+
+	/* Reset unsigned range to unbounded. */
+	dst_reg->u32_min_value = 0;
+	dst_reg->u32_max_value = U32_MAX;
+}
+
+static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
+	s64 src_val = src_reg->umin_value; /* const divisor */
+	s64 res1, res2;
+
+	/* BPF div specification: S64_MIN / -1 = S64_MIN */
+	if (*dst_smin == S64_MIN && src_val == -1) {
+		/* If dividend is not a single number, e.g., [S64_MIN, S64_MIN+10]/(-1),
+		 * the result = {S64_MIN} U [-(S64_MIN+10), -(S64_MIN+1)]
+		 *            = {S64_MIN} U [S64_MAX-9, S64_MAX] = [S64_MIN, S64_MAX]
+		 * which is unbounded.
+		 */
+		if (*dst_smax != S64_MIN)
+			__mark_reg64_unbounded(dst_reg);
+		return;
+	}
+
+	res1 = __bpf_sdiv(*dst_smin, src_val);
+	res2 = __bpf_sdiv(*dst_smax, src_val);
+	*dst_smin = min(res1, res2);
+	*dst_smax = max(res1, res2);
+
+	/* Reset unsigned range to unbounded. */
+	dst_reg->umin_value = 0;
+	dst_reg->umax_value = U64_MAX;
+}
+
+static bool scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
+				  struct bpf_reg_state *src_reg)
+{
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
+	u32 src_val = src_reg->u32_min_value; /* const divisor */
+	u32 res_max = src_val - 1;
+
+	/* 1. BPF mod specification: x % 0 = x
+	 *    If src_val == 0, i.e. divisor is certainly 0,
+	 *    then the result remains unchanged, [a,b] % [0,0] = [a,b].
+	 * 2. Optimization: If dst_umax <= res_max,
+	 *    then the result remains unchanged. e.g., [2, 5] % 10 = [2, 5].
+	 */
+	if (src_val == 0 || *dst_umax <= res_max)
+		return false;
+
+	*dst_umin = 0;
+	*dst_umax = min(*dst_umax, res_max);
+
+	/* Reset signed range to unbounded. */
+	dst_reg->s32_min_value = S32_MIN;
+	dst_reg->s32_max_value = S32_MAX;
+	return true;
+}
+
+static bool scalar_min_max_umod(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
+	u64 src_val = src_reg->umin_value; /* const divisor */
+	u64 res_max = src_val - 1;
+
+	/* 1. BPF mod specification: x % 0 = x
+	 *    If src_val == 0, i.e. divisor is certainly 0,
+	 *    then the result remains unchanged, [a,b] % [0,0] = [a,b].
+	 * 2. Optimization: If dst_umax <= res_max,
+	 *    then the result remains unchanged. e.g., [2, 5] % 10 = [2, 5].
+	 */
+	if (src_val == 0 || *dst_umax <= res_max)
+		return false;
+
+	*dst_umin = 0;
+	*dst_umax = min(*dst_umax, res_max);
+
+	/* Reset signed range to unbounded. */
+	dst_reg->smin_value = S64_MIN;
+	dst_reg->smax_value = S64_MAX;
+	return true;
+}
+
+static bool scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
+				  struct bpf_reg_state *src_reg)
+{
+	s32 *dst_smin = &dst_reg->s32_min_value;
+	s32 *dst_smax = &dst_reg->s32_max_value;
+	s32 src_val = src_reg->s32_min_value; /* const divisor */
+	u32 src_abs; /* unsigned to avoid overflow */
+	s32 res_max_abs;
+
+	/* 1. BPF mod specification: x % 0 = x
+	 *    If src_val == 0, i.e. divisor is certainly 0,
+	 *    then the result remains unchanged, [a,b] % [0,0] = [a,b].
+	 */
+	if (src_val == 0)
+		return false;
+
+	/* Safe absolute value calculation:
+	 * If src_val == S32_MIN (-2147483648), src_abs becomes 2147483648.
+	 */
+	src_abs = (src_val > 0) ? (u32)src_val : -(u32)src_val;
+
+	/* Calculate the maximum possible absolute value of the result.
+	 * Even if src_abs is 2147483648 (S32_MIN), subtracting 1 gives
+	 * 2147483647 (S32_MAX), which fits perfectly in s32.
+	 */
+	res_max_abs = src_abs - 1;
+
+	/* 2. Optimization: If the dividend is already within the result range,
+	 *    then the result remains unchanged. e.g., [-2, 5] % 10 = [-2, 5].
+	 */
+	if (*dst_smin >= -res_max_abs && *dst_smax <= res_max_abs)
+		return false;
+
+	/* General case: result has the same sign as the dividend. */
+	if (*dst_smin >= 0) {
+		*dst_smin = 0;
+		*dst_smax = min(*dst_smax, res_max_abs);
+	} else if (*dst_smax <= 0) {
+		*dst_smax = 0;
+		*dst_smin = max(*dst_smin, -res_max_abs);
+	} else {
+		*dst_smin = -res_max_abs;
+		*dst_smax = res_max_abs;
+	}
+
+	/* Reset unsigned range to unbounded. */
+	dst_reg->u32_min_value = 0;
+	dst_reg->u32_max_value = U32_MAX;
+	return true;
+}
+
+static bool scalar_min_max_smod(struct bpf_reg_state *dst_reg,
+				struct bpf_reg_state *src_reg)
+{
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
+	s64 src_val = src_reg->smin_value; /* const divisor */
+	u64 src_abs; /* unsigned to avoid overflow */
+	s64 res_max_abs;
+
+	/* 1. BPF mod specification: x % 0 = x
+	 *    If src_val == 0, i.e. divisor is certainly 0,
+	 *    then the result remains unchanged, [a,b] % [0,0] = [a,b].
+	 */
+	if (src_val == 0)
+		return false;
+
+	/* Safe absolute value calculation:
+	 * If src_val == S64_MIN (-2^63), src_abs becomes 2^63.
+	 */
+	src_abs = (src_val > 0) ? (u64)src_val : -(u64)src_val;
+
+	/* Calculate the maximum possible absolute value of the result.
+	 * Even if src_abs is 2^63 (S64_MIN), subtracting 1 gives
+	 * 2^63 - 1 (S64_MAX), which fits perfectly in s64.
+	 */
+	res_max_abs = src_abs - 1;
+
+	/* Optimization: If the dividend is already within the result range,
+	 * then the result remains unchanged.
+	 * Example: [-2, 5] % 10 = [-2, 5].
+	 */
+	if (*dst_smin >= -res_max_abs && *dst_smax <= res_max_abs)
+		return false;
+
+	/* General case: result has the same sign as the dividend. */
+	if (*dst_smin >= 0) {
+		*dst_smin = 0;
+		*dst_smax = min(*dst_smax, res_max_abs);
+	} else if (*dst_smax <= 0) {
+		*dst_smax = 0;
+		*dst_smin = max(*dst_smin, -res_max_abs);
+	} else {
+		*dst_smin = -res_max_abs;
+		*dst_smax = res_max_abs;
+	}
+
+	/* Reset unsigned range to unbounded. */
+	dst_reg->umin_value = 0;
+	dst_reg->umax_value = U64_MAX;
+	return true;
+}
+
 static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
@@ -15482,6 +15759,13 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_MUL:
 		return true;
 
+	/* Division and modulo operators range is only safe to compute when the
+	 * divisor is a constant.
+	 */
+	case BPF_DIV:
+	case BPF_MOD:
+		return src_is_const;
+
 	/* Shift operators range is only computable if shift dimension operand
 	 * is a constant. Shifts greater than 31 or 63 are undefined. This
 	 * includes shifts by a negative number.
@@ -15505,6 +15789,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state src_reg)
 {
 	u8 opcode = BPF_OP(insn->code);
+	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
@@ -15556,6 +15841,47 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_mul(dst_reg, &src_reg);
 		scalar_min_max_mul(dst_reg, &src_reg);
 		break;
+	case BPF_DIV:
+		if (alu32) {
+			if (off == 1)
+				scalar32_min_max_sdiv(dst_reg, &src_reg);
+			else
+				scalar32_min_max_udiv(dst_reg, &src_reg);
+			__mark_reg64_unbounded(dst_reg);
+		} else {
+			if (off == 1)
+				scalar_min_max_sdiv(dst_reg, &src_reg);
+			else
+				scalar_min_max_udiv(dst_reg, &src_reg);
+			__mark_reg32_unbounded(dst_reg);
+		}
+		/* Since we don't have precise tnum analysis for division yet,
+		 * we must reset var_off to unknown to avoid inconsistency.
+		 * Subsequent reg_bounds_sync() will rebuild it from scalar bounds.
+		 */
+		dst_reg->var_off = tnum_unknown;
+		break;
+	case BPF_MOD:
+		bool changed = true;
+		if (alu32)
+			changed = (off == 1) ? scalar32_min_max_smod(dst_reg, &src_reg)
+						: scalar32_min_max_umod(dst_reg, &src_reg);
+		else
+			changed = (off == 1) ? scalar_min_max_smod(dst_reg, &src_reg)
+						: scalar_min_max_umod(dst_reg, &src_reg);
+		/* Similar to BPF_DIV, we need to reset var_off and 32/64 range
+		 * to unknown (unbounded). But if the result is equal to dividend
+		 * (due to special cases in BPF_MOD analysis), we can also keep
+		 * them unchanged.
+		 */
+		if (changed) {
+			if (alu32)
+				__mark_reg64_unbounded(dst_reg);
+			else
+				__mark_reg32_unbounded(dst_reg);
+			dst_reg->var_off = tnum_unknown;
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
 
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 59a020c35647..061d98f6e9bb 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -229,11 +229,11 @@
 {
 	"precise: program doesn't prematurely prune branches",
 	.insns = {
-		BPF_ALU64_IMM(BPF_MOV, BPF_REG_6, 0x400),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+		BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_0),
 		BPF_ALU64_IMM(BPF_MOV, BPF_REG_7, 0),
 		BPF_ALU64_IMM(BPF_MOV, BPF_REG_8, 0),
 		BPF_ALU64_IMM(BPF_MOV, BPF_REG_9, 0x80000000),
-		BPF_ALU64_IMM(BPF_MOD, BPF_REG_6, 0x401),
 		BPF_JMP_IMM(BPF_JA, 0, 0, 0),
 		BPF_JMP_REG(BPF_JLE, BPF_REG_6, BPF_REG_9, 2),
 		BPF_ALU64_IMM(BPF_MOD, BPF_REG_6, 1),
-- 
2.52.0


