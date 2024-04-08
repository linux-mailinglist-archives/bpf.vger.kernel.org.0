Return-Path: <bpf+bounces-26203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7A89CA25
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 18:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C181B2854CE
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD282142E93;
	Mon,  8 Apr 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R60fP6gx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3431E4AF
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595349; cv=none; b=Hg1w+QYQFRVrIaNOto1i7UzXxspnfpxISCflUVMdsxfJB10cDKz9Xh7HlczIGEhwpshMGm3pgEKym8fsi60nrGPzkLZdA71LoiwvtAlmYFofySdza8anOlR8poTI9SSjsHraC8KeFYLlQUJG63rBwOkDPnjDaGrOi9tz6oewoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595349; c=relaxed/simple;
	bh=MmfVzB3Hhj5t5pp3o593xd2INQht5ScTH9v0s8790RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWqvh38Ftuv7iDqyYNPl7d2wyP3uAzZLEnJ7GPB3Jg1FRmeVx5fRHWa4EWgo36HNQYCn46P1d7Pysc8csGDHN8wErg1bDJu73Q7PMNq7RFYzOXOiyIVVeDPckreyrRrh/ESKcBzSxhxhHhXReDSXgrzBKxb1qTAEmlvx9XlaHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R60fP6gx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a03bf80-de12-4207-80a1-a18a5788d6d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712595344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujQ6y7OJOXRqftSgEUyPNGqjhLCmRGyvA0XEUKez4Lc=;
	b=R60fP6gxwnoeH3+NdRIfYDwL4l++HcVTzBbWCq7yVEAyTeuv16UGzot8osjzIIGMbqkVU0
	E9PsOY0YUlv7mJfgocQ45Bkuf347tOrfYsQR197VUEMfBBANFMF91OQYeQyfueZHB96zSp
	aFx47c5sMMCh+muVLI3+4pGD/IVPmP8=
Date: Mon, 8 Apr 2024 09:55:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, elena.zannoni@oracle.com
References: <20240405220817.100451-1-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240405220817.100451-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/5/24 3:08 PM, Cupertino Miranda wrote:
> Hi everyone,
>
> This email is a follow up on the problem identified in
> https://github.com/systemd/systemd/issues/31888.
> This problem first shown as a result of a GCC compilation for BPF that ends
> converting a condition based decision tree, into a logic based one (making use
> of XOR), in order to compute expected return value for the function.
>
> This issue was also reported in
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114523 and contains both
> the original reproducer pattern and some other that also fails within clang.
>
> I have included a patch that contains a possible fix (I wonder) and a test case
> that reproduces the issue in attach.
> The execution of the test without the included fix results in:
>
>    VERIFIER LOG:
>    =============
>    Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only those are supported.
>    0: R1=ctx() R10=fp0
>    ; asm volatile ("                                       \ @ verifier_bounds.c:755
>    0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
>    1: (bf) r6 = r0                       ; R0_w=scalar(id=1) R6_w=scalar(id=1)
>    2: (b7) r1 = 0                        ; R1_w=0
>    3: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
>    4: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
>    5: (07) r2 += -8                      ; R2_w=fp-8
>    6: (18) r1 = 0xffff8e8ec3b99000       ; R1_w=map_ptr(map=map_hash_8b,ks=8,vs=8)
>    8: (85) call bpf_map_lookup_elem#1    ; R0=map_value_or_null(id=2,map=map_hash_8b,ks=8,vs=8)
>    9: (55) if r0 != 0x0 goto pc+1 11: R0=map_value(map=map_hash_8b,ks=8,vs=8) R6=scalar(id=1) R10=fp0 fp-8=mmmmmmmm
>    11: (b4) w1 = 0                       ; R1_w=0
>    12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>    13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>    14: (16) if w1 == 0x0 goto pc+2       ; R1_w=scalar(smin=0x8000000000000001,umin=umin32=1)
>    15: (16) if w1 == 0x1 goto pc+1       ; R1_w=scalar(smin=0x8000000000000002,umin=umin32=2)
>    16: (79) r0 = *(u64 *)(r0 +8)
>    invalid access to map value, value_size=8 off=8 size=8
>    R0 min value is outside of the allowed memory range
>    processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>    =============
>
> The test collects a random number and shifts it right by 63 bits to reduce its
> range to (0,1), which will then xor to compute the value of w1, checking
> if the value is either 0 or 1 after.
> By analysing the code and the ranges computations, one can easily deduce
> that the result of the XOR is also within the range (0,1), however:
>
>    11: (b4) w1 = 0                       ; R1_w=0
>    12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>    13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>                                              ^
>                                              |___ No range is computed for R1
>
> The verifier seems to act pessimistically and will only compute a range for
> dst_reg, if the src_reg is a known value.
> This happens in:
>
>    -- verifier.c:13700 --
>    if (!src_known &&
>        opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
>            __mark_reg_unknown(env, dst_reg);
>            return 0;
>    }
>
> Is this really a requirement for XOR (and OR) ?

Not really. The earlier verifier is a little bit conservative
and it is not improved since we didn't hit an issue until now.

> Unless I am missing some corner case and based on the logic presented in
> tnum_xor (and even in tnum_or), it seems to me that it is safe to compute a new
> range for both XOR (and OR) in case both operands are not known.

Please send a formal patch to bpf-next. This way proper review can be done.

>
> Looking forward to your comments.
>
> Regards,
> Cupertino
>
> ---
>   kernel/bpf/verifier.c                         |  3 +-
>   .../selftests/bpf/progs/verifier_bounds.c     | 33 +++++++++++++++++++
>   2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c34b91b9583..850a2950e740 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13698,7 +13698,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   	}
>   
>   	if (!src_known &&
> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
> +	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND
> +	    && opcode != BPF_XOR) {
>   		__mark_reg_unknown(env, dst_reg);
>   		return 0;
>   	}

There are some other operators as well, e.g. BPF_OR, could you also help take a look?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 960998f16306..b0f9aa9203f6 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -745,6 +745,39 @@ l1_%=:	r0 = 0;						\
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("bounds check for reg32_0 = 0, reg32_1 = (0,1), reg32_1 xor reg32_2")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void reg32_0_reg32_xor_reg_01(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];                    \
> +	r6 = r0;                                        \
> +	r1 = 0;						\
> +	*(u64*)(r10 - 8) = r1;				\
> +	r2 = r10;					\
> +	r2 += -8;					\
> +	r1 = %[map_hash_8b] ll;				\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 != 0 goto l0_%=;				\
> +	exit;						\
> +l0_%=:	w1 = 0;						\
> +	r6 >>= 63;					\
> +	w1 ^= w6;					\
> +	if w1 == 0 goto l1_%=;				\
> +	if w1 == 1 goto l1_%=;				\
> +	r0 = *(u64*)(r0 + 8);				\
> +l1_%=:	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>   SEC("socket")
>   __description("bounds check for reg = 2, reg xor 3")
>   __success __failure_unpriv

