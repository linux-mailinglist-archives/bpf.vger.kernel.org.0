Return-Path: <bpf+bounces-26851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F38A5990
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC93D1C2195D
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E9137757;
	Mon, 15 Apr 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eGfqCelO"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC19824B7
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204446; cv=none; b=SjYvqRKZSrr/ZLw/bN75T0OOQb4lUZ/hzyfB3+PqV8YFI1NwwjdfO7WS4184KDAtz1V2M5k6oaqP8Rhb8/HIghKnBHl1aQ9T9jBAbz1QHnrCBTOzhp80IiTzDI8ADsnIz+/6OGFEDSPpRi4ufnHpNEg7aRA4nEmlAtmTWBF7GYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204446; c=relaxed/simple;
	bh=HrC9ymxc+4+LsbbbWitz7roYQZpgFnGenJj5oY73ixQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE2nmRG4TP9tfaGp4yxSUPNoR26SHpVmjXA6w6zvDwT2GPLoEK/GBOKC25WPS5oLsq5PXhDEhAqiP8UW3vGtQM/c9TZB2WD8Ol4v6+ehLx/QAlJb2RJq/ANDYlNsGwMElWllyZeFTh2/M85pMv492zxwV8MFQ1a6YWRJ9SWE+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eGfqCelO; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8ab5c41-ee10-4b13-b23d-9aca07dd6bb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713204442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qdx/fQ1CYAphneLNRYb/SowYQv2VytqF82RU5RFMUQk=;
	b=eGfqCelOPBwDfQ4ohjKBtACREXeXrZm6vceS7ycPCjFZMhJ7z2bHbvTh59DAxMv4+ZkdVT
	6HE9qWNUZ8Qmi0UFA3XWahogoSaQ3l+EhmmS5I5Lsu6v02rHGTVm/A39w+BodBI5L34qnx
	8mRe6HAWh4biUoZjKe8+FUUnnJKGjhA=
Date: Mon, 15 Apr 2024 11:07:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: fix to XOR and OR range computation
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com,
 elena.zannoni@oracle.com, alexei.starovoitov@gmail.com
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240411173732.221881-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/11/24 10:37 AM, Cupertino Miranda wrote:
> Range for XOR and OR operators would not be attempted unless src_reg
> would resolve to a single value, i.e. a known constant value.
> This condition seems excessive, relative to how easy it is to compute a
> safe range for these operators.

Please break this patch into two patches. One for verifier and another
for selftest. This will make it easy for possible backport.

As the number of patches grows, it would be great if you can add
a cover letter for the series.

For the subject, the following seems better:
    improve XOR and OR range computation

I would not call the previous implementation as a bug. It is just
conservative.

For the following:
   This condition seems excessive, relative to how easy it is to compute a
   safe range for these operators.

You can just say:
   This condition is unnecessary, and the following XOR/OR operator handling
   could compute a possible better range.

>
> BPF self-tests were added to validate the new functionality.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>   kernel/bpf/verifier.c                         |  3 +-
>   .../selftests/bpf/progs/verifier_bounds.c     | 64 +++++++++++++++++++
>   2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2aad6d90550f..a219f601569a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13764,7 +13764,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   	}
>   
>   	if (!src_known &&
> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
> +	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND &&
> +	    opcode != BPF_XOR && opcode != BPF_OR) {
>   		__mark_reg_unknown(env, dst_reg);
>   		return 0;
>   	}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 960998f16306..2fcf46341b30 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -885,6 +885,70 @@ l1_%=:	r0 = 0;						\
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("bounds check for reg32 <= 1, 0 xor (0,1)")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void t_0_xor_01(void)
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
> +	if w1 <= 1 goto l1_%=;				\
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
> +SEC("socket")
> +__description("bounds check for reg32 <= 1, 0 or (0,1)")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void t_0_or_01(void)
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
> +	w1 |= w6;					\
> +	if w1 <= 1 goto l1_%=;				\
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
>   __description("bounds checks after 32-bit truncation. test 1")
>   __success __failure_unpriv __msg_unpriv("R0 leaks addr")

