Return-Path: <bpf+bounces-77384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8DCDAA34
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BB2D300A9E1
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6122EA749;
	Tue, 23 Dec 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3+Gk4Fe"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDF29ACFD
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523550; cv=none; b=CBCg99kE3u7HDH27TZ5j6WUb6TfHs9gkj4Uxq5DaljdLn1I+Nb/3nMuSPpRsLGYx9gSEEsjykP0fg+9mGxHQw2MG8ByAphPCmJnwJDJEbQ1e9hppLp4V3BxmrGckYnY3HgUlMojnBN86zXwqpqE5IFCUPsri0yjHY9cUBVxMd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523550; c=relaxed/simple;
	bh=51cx0tOtKr1sMCFwtLIjvg7QEZPb5umZlfgTwJCslso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPIHmangzAp/DXnIY+zHfLW1Xcr/S++CVquqF7lqAGZ1EgZ8d+h89qO50FcrGETAOJIpEybiU7D3fsjf5e3aceMKwGMQTh7LA8nAwBz22gTXk5FA4ZM5BdXaRwuK/aglLK8t/RvOguxT3ktJUEYTqdMSXHJunlQRYn/rKLjBLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z3+Gk4Fe; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db829499-1ad3-4d9f-8a89-6246938a45aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766523545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfZ8DAAtPuIiiGz1lcJTHPevCUlr88i3v4czgWDe0cc=;
	b=Z3+Gk4FeJnjlVcz9Lev8HhIg1aA3l4+vT+lSg+7Y0ARjPlkvPWP6YFhC4N+yxyVvqpS4jp
	ufZsC9uLg8nae9J69N/AB9rDBebttXK4N+zT52sg5wPduGUB9DgTiefYrAtgKz5sl9v9eZ
	MJGJbqElwFGj/hf5LRdm8R9Y3HUHaJ4=
Date: Tue, 23 Dec 2025 12:58:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for
 signed and unsigned BPF_DIV
Content-Language: en-GB
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20251223091120.2413435-1-tangyazhou@zju.edu.cn>
 <20251223091120.2413435-2-tangyazhou@zju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251223091120.2413435-2-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/23/25 1:10 AM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> This patch introduces interval analysis (range tracking) and tnum
> analysis (bitwise tracking) for both signed and unsigned division
> operations in the BPF verifier.
>
> The BPF verifier currently lacks support for value tracking on BPF_DIV
> instructions, which can lead to false positives during verification of
> BPF programs that utilize division instructions.
>
> According to the BPF instruction set[1], the instruction's offset field
> (`insn->off`) is used to distinguish between signed (`off == 1`) and
> unsigned division (`off == 0`). Moreover, we also follow the BPF division
> semantics to handle special cases, such as division by zero and signed
> division overflow.
>
> - UDIV: dst = (src != 0) ? (dst / src) : 0
> - SDIV: dst = (src == 0) ? 0 : ((src == -1 && dst == LLONG_MIN) ? LLONG_MIN : (dst / src))
>
> Here is the overview of the changes made in this patch:
>
> 1. For interval analysis:
>     - Added `scalar_min_max_udiv` and `scalar32_min_max_udiv` to update
>       umin/umax bounds, which is straightforward.
>     - Added `scalar_min_max_sdiv` and `scalar32_min_max_sdiv` to update
>       smin/smax bounds. It handles non-monotonic intervals by decomposing
>       the divisor range into negative, zero, and positive sub-ranges, and
>       computing the result range for each sub-range separately. Finally,
>       it combines the results to get the final smin/smax bounds.
> 2. For tnum analysis, we referred to LLVM's KnownBits implementation[2]
>     and the recent research on abstract interpretation of division[3]:
>     - Added `tnum_udiv` to compute the tnum for unsigned division. It
>       calculates the maximum possible result based on the maximum values
>       of the dividend tnum and the minimum values of the divisor tnum,
>       then constructs the resulting tnum accordingly. We have prove its
>       soundness using Rocq Prover[4].
>     - Added `tnum_sdiv` to compute the tnum for signed division. It splits
>       the operands into positive and negative components, then performs
>       calculation on absolute values using `tnum_udiv`, finally unions
>       the results to ensure soundness.
>
>       Introduced `tnum_empty` to represent the bottom element (⊥) of the
>       tnum lattice to support the split-tnum analysis for signed division.
>       Mathematically, tnum_empty represents an empty set of possible  values,
>       which is crucial when dealing with sub-tnums (e.g., the negative
>       component of a strictly positive tnum) yield no valid values.
> 3. Also updated existing selftests based on the expected BPF_DIV behavior.

In my own experience, typical division (signed or unsigned) has remainder 0.
For example, (ptr1 - ptr2)/sizeof(*ptr1).

Do you have other production examples which needs more complex div/sdiv
handling in tnum and verifier? For example see:
    https://lore.kernel.org/bpf/aRYSlGmmQM1kfF_b@mail.gmail.com/

Without digging into details, a few comments below.

>
> [1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruction-set.rst
> [2] https://llvm.org/doxygen/KnownBits_8cpp_source.html
> [3] https://dl.acm.org/doi/10.1145/3728905
> [4] https://github.com/shenghaoyuan/open-verified-artifacts/tree/main/tnum
>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
> Hello everyone,
>
> Thanks for reviewing our patch! This patch adds interval and tnum analysis
> for both signed and unsigned BPF_DIV instructions in the BPF verifier.
>
> We also have implemented interval and tnum analysis for BPF_MOD
> instruction, which is closely related to division. However, to keep the
> patch size manageable and facilitate easier review, we have decided to
> submit the BPF_MOD related changes in a separate patch following this one.
>
> Best,
>
> Yazhou Tang
>
>   include/linux/tnum.h                          |   4 +
>   kernel/bpf/tnum.c                             | 159 ++++++++++++-
>   kernel/bpf/verifier.c                         | 225 ++++++++++++++++++
>   .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
>   4 files changed, 391 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index c52b862dad45..fd00deb2cb88 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -50,6 +50,10 @@ struct tnum tnum_or(struct tnum a, struct tnum b);
>   struct tnum tnum_xor(struct tnum a, struct tnum b);
>   /* Multiply two tnums, return @a * @b */
>   struct tnum tnum_mul(struct tnum a, struct tnum b);
> +/* Unsigned division, return @a / @b */
> +struct tnum tnum_udiv(struct tnum a, struct tnum b);
> +/* Signed division, return @a / @b */
> +struct tnum tnum_sdiv(struct tnum a, struct tnum b, bool alu32);
>   
>   /* Return true if the known bits of both tnums have the same value */
>   bool tnum_overlap(struct tnum a, struct tnum b);
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index f8e70e9c3998..20cd023709bf 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -12,6 +12,13 @@
>   #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
>   /* A completely unknown value */
>   const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
> +/* Not well-formed Tnum, whose concrete value is empty set. */
> +const struct tnum tnum_empty = { .value = -1, .mask = -1 };

Maybe tnum_empty renamed to tnum_poison? This will make it
explicit that it is not well formed.

> +
> +static bool __tnum_eqb(struct tnum a, struct tnum b)
> +{
> +	return a.value == b.value && a.mask == b.mask;
> +}
>   
>   struct tnum tnum_const(u64 value)
>   {
> @@ -83,9 +90,23 @@ struct tnum tnum_sub(struct tnum a, struct tnum b)
>   	return TNUM(dv & ~mu, mu);
>   }
>   
> +/* __tnum_neg_width: tnum negation with given bit width.
> + * @a: the tnum to be negated.
> + * @width: the bit width to perform negation, 32 or 64.
> + */
> +static struct tnum __tnum_neg_width(struct tnum a, int width)
> +{
> +	if (width == 32)
> +		return tnum_subreg(tnum_sub(TNUM(0, 0), tnum_subreg(a)));
> +	else if (width == 64)
> +		return tnum_sub(TNUM(0, 0), a);
> +	else
> +		return tnum_unknown;
> +}
> +
>   struct tnum tnum_neg(struct tnum a)
>   {
> -	return tnum_sub(TNUM(0, 0), a);
> +	return __tnum_neg_width(a, 64);
>   }
>   
>   struct tnum tnum_and(struct tnum a, struct tnum b)
> @@ -167,6 +188,138 @@ bool tnum_overlap(struct tnum a, struct tnum b)
>   	return (a.value & mu) == (b.value & mu);
>   }
>   
> +/* __get_mask: get a mask that covers all bits up to the highest set bit in x.
> + * For example:
> + *   x = 0b0000...0000 -> return 0b0000...0000
> + *   x = 0b0000...0001 -> return 0b0000...0001
> + *   x = 0b0000...1001 -> return 0b0000...1111
> + *   x = 0b1111...1111 -> return 0b1111...1111
> + */
> +static u64 __get_mask(u64 x)
> +{
> +	int width = 0;
> +
> +	if (x > 0)
> +		width = 64 - __builtin_clzll(x);

Maybe 'width = fls64(x)'?

> +	if (width == 0)
> +		return 0;
> +	else if (width == 64)
> +		return U64_MAX;
> +	else
> +		return (1ULL << width) - 1;
> +}
> +
> +struct tnum tnum_udiv(struct tnum a, struct tnum b)
> +{
> +	if (tnum_is_const(b)) {
> +		/* BPF div specification: x / 0 = 0 */
> +		if (b.value == 0)
> +			return TNUM(0, 0);
> +		if (tnum_is_const(a))
> +			return TNUM(a.value / b.value, 0);
> +	}
> +
> +	if (b.value == 0)
> +		return tnum_unknown;
> +
> +	u64 a_max = a.value + a.mask;
> +	u64 b_min = b.value;
> +	u64 max_res = a_max / b_min;
> +	return TNUM(0, __get_mask(max_res));
> +}
> +
> +static u64 __msb(u64 x, int width)
> +{
> +	return x & (1ULL << (width - 1));
> +}
> +
> +static struct tnum __tnum_get_positive(struct tnum x, int width)
> +{
> +	if (__msb(x.value, width))
> +		return tnum_empty;
> +	if (__msb(x.mask, width))
> +		return TNUM(x.value, x.mask & ~(1ULL << (width - 1)));
> +	return x;
> +}
> +
> +static struct tnum __tnum_get_negative(struct tnum x, int width)
> +{
> +	if (__msb(x.value, width))
> +		return x;
> +	if (__msb(x.mask, width))
> +		return TNUM(x.value | (1ULL << (width - 1)), x.mask & ~(1ULL << (width - 1)));
> +	return tnum_empty;
> +}
> +
> +static struct tnum __tnum_abs(struct tnum x, int width)
> +{
> +	if (__msb(x.value, width))
> +		return __tnum_neg_width(x, width);
> +	else
> +		return x;
> +}
> +
> +/* __tnum_sdiv, a helper for tnum_sdiv.
> + * @a: tnum a, a's sign is fixed, __msb(a.mask) == 0
> + * @b: tnum b, b's sign is fixed, __msb(b.mask) == 0
> + *
> + * This function reuses tnum_udiv by operating on the absolute values of a and b,
> + * and then adjusting the sign of the result based on C's division rules.
> + * Here we don't need to specially handle the case of [S64_MIN / -1], because
> + * after __tnum_abs, S64_MIN becomes (S64_MAX + 1), and the behavior of
> + * unsigned [(S64_MAX + 1) / 1] is normal.
> + */
> +static struct tnum __tnum_sdiv(struct tnum a, struct tnum b, int width)
> +{
> +	if (__tnum_eqb(a, tnum_empty) || __tnum_eqb(b, tnum_empty))
> +		return tnum_empty;
> +
> +	struct tnum a_abs = __tnum_abs(a, width);
> +	struct tnum b_abs = __tnum_abs(b, width);
> +	struct tnum res_abs = tnum_udiv(a_abs, b_abs);
> +
> +	if (__msb(a.value, width) == __msb(b.value, width))
> +		return res_abs;
> +	else
> +		return __tnum_neg_width(res_abs, width);
> +}
> +
> +struct tnum tnum_sdiv(struct tnum a, struct tnum b, bool alu32)
> +{
> +	if (tnum_is_const(b)) {
> +		/* BPF div specification: x / 0 = 0 */
> +		if (b.value == 0)
> +			return TNUM(0, 0);
> +		if (tnum_is_const(a)) {
> +			/* BPF div specification: S32_MIN / -1 = S32_MIN */
> +			if (alu32 && (u32)a.value == (u32)S32_MIN && (u32)b.value == (u32)-1)
> +				return TNUM((u32)S32_MIN, 0);
> +			/* BPF div specification: S64_MIN / -1 = S64_MIN */
> +			if (!alu32 && a.value == S64_MIN && b.value == (u64)-1)
> +				return TNUM((u64)S64_MIN, 0);
> +			s64 sval = (s64)a.value / (s64)b.value;
> +			return TNUM((u64)sval, 0);
> +		}
> +	}
> +
> +	if (b.value == 0)
> +		return tnum_unknown;
> +
> +	int width = alu32 ? 32 : 64;
> +	struct tnum a_pos = __tnum_get_positive(a, width);
> +	struct tnum a_neg = __tnum_get_negative(a, width);
> +	struct tnum b_pos = __tnum_get_positive(b, width);
> +	struct tnum b_neg = __tnum_get_negative(b, width);
> +
> +	struct tnum res_pos = __tnum_sdiv(a_pos, b_pos, width);
> +	struct tnum res_neg = __tnum_sdiv(a_neg, b_neg, width);
> +	struct tnum res_mix1 = __tnum_sdiv(a_pos, b_neg, width);
> +	struct tnum res_mix2 = __tnum_sdiv(a_neg, b_pos, width);
> +
> +	return tnum_union(tnum_union(res_pos, res_neg),
> +					tnum_union(res_mix1, res_mix2));
> +}

The above is very complex. It would be great if you can have
some examples to show the logic. For example, for this tnum patch:

https://lore.kernel.org/bpf/20250826034524.2159515-1-nandakumar@nandakumar.co.in

> +
>   /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
>    * a 'known 0' - this will return a 'known 1' for that bit.
>    */
> @@ -186,6 +339,10 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
>    */
>   struct tnum tnum_union(struct tnum a, struct tnum b)
>   {
> +	if (__tnum_eqb(a, tnum_empty))
> +		return b;
> +	if (__tnum_eqb(b, tnum_empty))
> +		return a;
>   	u64 v = a.value & b.value;
>   	u64 mu = (a.value ^ b.value) | a.mask | b.mask;

[...]


