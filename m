Return-Path: <bpf+bounces-17371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D507180C095
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 06:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963D9280C5A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 05:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3A1C6B7;
	Mon, 11 Dec 2023 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCiat+Uo"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E91C3
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 21:09:43 -0800 (PST)
Message-ID: <4457e84f-4417-4a60-a814-9288b0756d91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702271381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHbu0t6RQovwgG4UpuUModKkP5V4juUKznEMDieJw5c=;
	b=RCiat+Uo7cm2znHWbA9yCBo0bvR2PQHKM5fx4OOKc4eXxGrlfD3OgC3R3fod5AWvvSqa63
	HHGJIXbVekzu+sj1SZGpMhwMIGSZ/bH+OgZjd/RTAbQCGONJxtzvaCB0jjFjH7IjIDDxlL
	Tz4ppcnpwzRSqRgYzDVAt9KqpV8Ql1g=
Date: Sun, 10 Dec 2023 21:09:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for
 regs
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231210130001.2050847-1-menglong8.dong@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231210130001.2050847-1-menglong8.dong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/10/23 5:00 AM, Menglong Dong wrote:
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>
>    /* The type of "a" is u16 */
>    if (a > 0 && a < 100) {
>      /* the range of the register for a is [0, 99], not [1, 99],
>       * and will cause the following error:
>       *
>       *   invalid zero-sized read
>       *
>       * as a can be 0.
>       */
>      bpf_skb_store_bytes(skb, xx, xx, a, 0);
>    }

Could you have a C test to demonstrate this example?
Also, you should have a set of inline asm code (progs/verifier*.c)
to test various cases as in mark_reg32_not_equal() and
mark_reg_not_equal().

>
> In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>   kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 727a59e4a647..7b074ac93190 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
>   	reg->type = SCALAR_VALUE;
>   }
>   
> +#define CHECK_REG_MIN(value)			\
> +do {						\
> +	if ((value) == (typeof(value))imm)	\
> +		value++;			\
> +} while (0)
> +
> +#define CHECK_REG_MAX(value)			\
> +do {						\
> +	if ((value) == (typeof(value))imm)	\
> +		value--;			\
> +} while (0)
> +
> +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{

What if reg->s32_min_value == imm and reg->s32_max_value == imm?
Has this been handled in previous verifier logic?

> +		CHECK_REG_MIN(reg->s32_min_value);
> +		CHECK_REG_MAX(reg->s32_max_value);
> +		CHECK_REG_MIN(reg->u32_min_value);
> +		CHECK_REG_MAX(reg->u32_max_value);
> +}
> +
> +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{
> +		CHECK_REG_MIN(reg->smin_value);
> +		CHECK_REG_MAX(reg->smax_value);
> +
> +		CHECK_REG_MIN(reg->umin_value);
> +		CHECK_REG_MAX(reg->umax_value);
> +
> +		CHECK_REG_MIN(reg->s32_min_value);
> +		CHECK_REG_MAX(reg->s32_max_value);
> +		CHECK_REG_MIN(reg->u32_min_value);
> +		CHECK_REG_MAX(reg->u32_max_value);
> +}
> +
>   static void mark_reg_known_zero(struct bpf_verifier_env *env,
>   				struct bpf_reg_state *regs, u32 regno)
>   {
> @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   		}
>   		break;
>   	case BPF_JNE:
> -		/* we don't derive any new information for inequality yet */
> +		/* try to recompute the bound of reg1 if reg2 is a const and
> +		 * is exactly the edge of reg1.
> +		 */
> +		if (is_reg_const(reg2, is_jmp32)) {
> +			val = reg_const_value(reg2, is_jmp32);
> +			if (is_jmp32)
> +				mark_reg32_not_equal(reg1, val);
> +			else
> +				mark_reg_not_equal(reg1, val);
> +		}
>   		break;
>   	case BPF_JSET:
>   		if (!is_reg_const(reg2, is_jmp32))

