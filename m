Return-Path: <bpf+bounces-26855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9338A59DB
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4631C211B2
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A113A895;
	Mon, 15 Apr 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iete3vDw"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10A71B50
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205562; cv=none; b=mAdW7X4Y2iLX9z6G/sTmCJnee8vj1COdRkc34Hu8xg0K/CvMJeXneS4hyNFT2qdKdh+KcKw6E5t+FpTFkLW8QrhYoRJ5nnelg2zFBPFR97QgXNAmibKpXWoBAGfcEAtXRnf34Kl7p1DhoqnxbdWZVVMrGy9hMoAXrLARcCrTvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205562; c=relaxed/simple;
	bh=6KOQ3hEEv0mUSnK0ORKKPST1sVUmTZFORGMhgzQ/yBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQp54DS7KdCo0UDlO5j3fh/4p3viFpZm4fuDiR/4TZblDQEVVL/a8+0aOe/RzXq619506Hk1r6OUpThuV2T5U9ANYcyCVb12CjX9yYLvRT+wWCWCDPxai9P4CPGaTkMr8hwCGYtNc8j7nvdvw5j+QI+3zDq5+LXxN96QoriA8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iete3vDw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72658a81-7e62-4726-9e7a-80dbc0a1ff06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713205558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lh7lnOFNs1g1CVSFZOhZU9fNezeAU0FMVnfbUljxHkc=;
	b=Iete3vDwTruZfM9i5NC6fNH7wjrRPA0I1b8I3iHy0NbSJsIheQMI4Uvnaxcz61IslQYALf
	ThoESeLBvE6OlwH2LHOKAE8piHnUOQ3v1HZakT1rzFYSSwCqcMc8zWMcvyOeLb8jzQ1EWB
	R6dGSBs0VSF4NFNoePfBe9RxaWLxFLs=
Date: Mon, 15 Apr 2024 11:25:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: refactor checks for range computation
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com,
 elena.zannoni@oracle.com, alexei.starovoitov@gmail.com
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
 <20240411173732.221881-2-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240411173732.221881-2-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/11/24 10:37 AM, Cupertino Miranda wrote:
> Split range computation checks in its own function, isolating pessimitic
> range set for dst_reg and failing return to a single point.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>   kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
>   1 file changed, 77 insertions(+), 64 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a219f601569a..7894af2e1bdb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13709,6 +13709,82 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
>   	__update_reg_bounds(dst_reg);
>   }
>   
> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
> +				   bool *valid)
> +{
> +	s64 smin_val = reg.smin_value;
> +	s64 smax_val = reg.smax_value;
> +	u64 umin_val = reg.umin_value;
> +	u64 umax_val = reg.umax_value;
> +
> +	s32 s32_min_val = reg.s32_min_value;
> +	s32 s32_max_val = reg.s32_max_value;
> +	u32 u32_min_val = reg.u32_min_value;
> +	u32 u32_max_val = reg.u32_max_value;
> +
> +	bool known = alu32 ? tnum_subreg_is_const(reg.var_off) :
> +			     tnum_is_const(reg.var_off);
> +
> +	if (alu32) {
> +		if ((known &&
> +		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
> +		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
> +			*valid &= false;

*valid = false;

> +	} else {
> +		if ((known &&
> +		     (smin_val != smax_val || umin_val != umax_val)) ||
> +		    smin_val > smax_val || umin_val > umax_val)
> +			*valid &= false;

*valid = false;

> +	}
> +
> +	return known;
> +}
> +
> +static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
> +					      struct bpf_reg_state src_reg)
> +{
> +	bool src_known;
> +	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
> +	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
> +	u8 opcode = BPF_OP(insn->code);
> +
> +	bool valid_known = true;
> +	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
> +
> +	/* Taint dst register if offset had invalid bounds
> +	 * derived from e.g. dead branches.
> +	 */
> +	if (valid_known == false)
> +		return false;
> +
> +	switch (opcode) {
> +	case BPF_ADD:
> +	case BPF_SUB:
> +	case BPF_AND:
> +	case BPF_XOR:
> +	case BPF_OR:
> +		return true;
> +
> +	/* Compute range for MUL if the src_reg is known.
> +	 */
> +	case BPF_MUL:
> +		return src_known;
> +
> +	/* Shift operators range is only computable if shift dimension operand
> +	 * is known. Also, shifts greater than 31 or 63 are undefined. This
> +	 * includes shifts by a negative number.
> +	 */
> +	case BPF_LSH:
> +	case BPF_RSH:
> +	case BPF_ARSH:
> +		return src_known && (src_reg.umax_value < insn_bitness);
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
>   /* WARNING: This function does calculations on 64-bit values, but the actual
>    * execution may occur on 32-bit values. Therefore, things like bitshifts
>    * need extra checks in the 32-bit case.
> @@ -13720,52 +13796,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   {
>   	struct bpf_reg_state *regs = cur_regs(env);
>   	u8 opcode = BPF_OP(insn->code);
> -	bool src_known;
> -	s64 smin_val, smax_val;
> -	u64 umin_val, umax_val;
> -	s32 s32_min_val, s32_max_val;
> -	u32 u32_min_val, u32_max_val;
> -	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>   	int ret;
>   
> -	smin_val = src_reg.smin_value;
> -	smax_val = src_reg.smax_value;
> -	umin_val = src_reg.umin_value;
> -	umax_val = src_reg.umax_value;
> -
> -	s32_min_val = src_reg.s32_min_value;
> -	s32_max_val = src_reg.s32_max_value;
> -	u32_min_val = src_reg.u32_min_value;
> -	u32_max_val = src_reg.u32_max_value;
> -
> -	if (alu32) {
> -		src_known = tnum_subreg_is_const(src_reg.var_off);
> -		if ((src_known &&
> -		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
> -		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
> -			/* Taint dst register if offset had invalid bounds
> -			 * derived from e.g. dead branches.
> -			 */
> -			__mark_reg_unknown(env, dst_reg);
> -			return 0;
> -		}
> -	} else {
> -		src_known = tnum_is_const(src_reg.var_off);
> -		if ((src_known &&
> -		     (smin_val != smax_val || umin_val != umax_val)) ||
> -		    smin_val > smax_val || umin_val > umax_val) {
> -			/* Taint dst register if offset had invalid bounds
> -			 * derived from e.g. dead branches.
> -			 */
> -			__mark_reg_unknown(env, dst_reg);
> -			return 0;
> -		}
> -	}
> -
> -	if (!src_known &&
> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND &&
> -	    opcode != BPF_XOR && opcode != BPF_OR) {
> +	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
>   		__mark_reg_unknown(env, dst_reg);

This is not a precise refactoring. there are some cases like below
which uses mark_reg_unknow().

Let us put the refactoring patch as the first patch in the serious and all
additional changes after that and this will make it easy to review.

>   		return 0;
>   	}
> @@ -13822,39 +13856,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   		scalar_min_max_xor(dst_reg, &src_reg);
>   		break;
>   	case BPF_LSH:
> -		if (umax_val >= insn_bitness) {
> -			/* Shifts greater than 31 or 63 are undefined.
> -			 * This includes shifts by a negative number.
> -			 */
> -			mark_reg_unknown(env, regs, insn->dst_reg);
> -			break;
> -		}
>   		if (alu32)
>   			scalar32_min_max_lsh(dst_reg, &src_reg);
>   		else
>   			scalar_min_max_lsh(dst_reg, &src_reg);
>   		break;
>   	case BPF_RSH:
> -		if (umax_val >= insn_bitness) {
> -			/* Shifts greater than 31 or 63 are undefined.
> -			 * This includes shifts by a negative number.
> -			 */
> -			mark_reg_unknown(env, regs, insn->dst_reg);
> -			break;
> -		}
>   		if (alu32)
>   			scalar32_min_max_rsh(dst_reg, &src_reg);
>   		else
>   			scalar_min_max_rsh(dst_reg, &src_reg);
>   		break;
>   	case BPF_ARSH:
> -		if (umax_val >= insn_bitness) {
> -			/* Shifts greater than 31 or 63 are undefined.
> -			 * This includes shifts by a negative number.
> -			 */
> -			mark_reg_unknown(env, regs, insn->dst_reg);
> -			break;
> -		}
>   		if (alu32)
>   			scalar32_min_max_arsh(dst_reg, &src_reg);
>   		else

