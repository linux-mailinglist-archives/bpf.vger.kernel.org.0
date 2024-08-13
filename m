Return-Path: <bpf+bounces-37003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849294FD43
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 07:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7EB1C227F6
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96462C190;
	Tue, 13 Aug 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkiAw444"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A039AD5
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527384; cv=none; b=mzM41JnkGizlKgLGPz2yWuDT0/gpQqlyFeveJtgRQ5gFbnISBd+b3iTGqXiwWmQb+ed6IA4RjnJ7RbyfQBuAmea4xW/AZIT0rQPJpnOFmwbxZSOeZQOk5eYqZqk9lpLmBsgl/glGeT+cAIlYM7An09QQZ1vW4GkQUrO3Fyyck40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527384; c=relaxed/simple;
	bh=T/mbs5Jt8FvMT0rRT/pG5xVi6KADarMrWPLZxrIYX+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3pEbOdgZ55htZwQ4OKugS2Bm7z/gdvla3MM/ehrZXxv6Yk6OkSvpGN8pSYS45xljI1svpMYAgc2oPrdTsdJDnRVXup7U1G9wJEvb9BxUMGLlOuUKzuExYsPVaY9nK9euLcnjmxN/qm2TYVzqF5SdkzrAqFRwCe7HebK8/1M6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkiAw444; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ca49adc-2c90-42ee-b1ff-bf339731ad5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723527379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzrX/MnAajMseVgfFAVp855CzZwB9Vq+QWUBXRRv8Fg=;
	b=fkiAw444oCX0Y9cUvMw/DOUsSHptRS4DrUTF3yTB4Fei0v9C5bQ/BmblEstQzYo0fXAMdJ
	sRnj7ZNZq7O1fqaZ0w6Qzb+u9hd1eJvjmPFe/WyMcyp312JmxvdOesPvC2xgc1cU8RAR8d
	QqOI3UPTw4n9kshU8tD9AZQV1tDWgaQ=
Date: Mon, 12 Aug 2024 22:36:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20240812234356.2089263-1-eddyz87@gmail.com>
 <20240812234356.2089263-2-eddyz87@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240812234356.2089263-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/12/24 4:43 PM, Eduard Zingerman wrote:
> Recognize nocsr patterns around kfunc calls.
> For example, suppose bpf_cast_to_kern_ctx() follows nocsr contract
> (which it does, it is rewritten by verifier as "r0 = r1" insn),
> in such a case, rewrite BPF program below:
>
>    r2 = 1;
>    *(u64 *)(r10 - 32) = r2;
>    call %[bpf_cast_to_kern_ctx];
>    r2 = *(u64 *)(r10 - 32);
>    r0 = r2;
>
> Removing the spill/fill pair:
>
>    r2 = 1;
>    call %[bpf_cast_to_kern_ctx];
>    r0 = r2;

I can see this indeed a good optimization esp. when there is a register
pressure for the program, and like above r2 has to be spilled.
Using nocsr for bpf_cast_to_kern_ctx() can remove those spill/fill
insns.

>
> Add a KF_NOCSR flag to mark kfuncs that follow nocsr contract.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   include/linux/btf.h   |  1 +
>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cffb43133c68..59ca37300423 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -75,6 +75,7 @@
>   #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
>   #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
>   #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
> +#define KF_NOCSR        (1 << 12) /* kfunc follows nocsr calling contract */
>   
>   /*
>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..c579f74be3f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>   	}
>   }
>   
> +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above */
> +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	const struct btf_param *params;
> +	u32 vlen, i, mask;

In helper_nocsr_clobber_mask, we have u8 mask. To be consistent, can we have 'u8 mask' here?
Are you worried that the number of arguments could be more than 7? This seems not the case
right now.

> +
> +	params = btf_params(meta->func_proto);
> +	vlen = btf_type_vlen(meta->func_proto);
> +	mask = 0;
> +	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
> +		mask |= BIT(BPF_REG_0);
> +	for (i = 0; i < vlen; ++i)
> +		mask |= BIT(BPF_REG_1 + i);
> +	return mask;
> +}
> +
> +/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
> +static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return false;
> +}
> +
>   /* GCC and LLVM define a no_caller_saved_registers function attribute.
>    * This attribute means that function scratches only some of
>    * the caller saved registers defined by ABI.
> @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
>   				  bpf_jit_inlines_helper_call(call->imm));
>   	}
>   
> +	if (bpf_pseudo_kfunc_call(call)) {
> +		struct bpf_kfunc_call_arg_meta meta;
> +		int err;
> +
> +		err = fetch_kfunc_meta(env, call, &meta, NULL);
> +		if (err < 0)
> +			/* error would be reported later */
> +			return;
> +
> +		clobbered_regs_mask = kfunc_nocsr_clobber_mask(&meta);
> +		can_be_inlined = (meta.kfunc_flags & KF_NOCSR) &&
> +				 verifier_inlines_kfunc_call(&meta);

I think we do not need both meta.kfunc_flags & KF_NOCSR and
verifier_inlines_kfunc_call(&meta). Only one of them is enough
since they test very similar thing. You do need to ensure
kfuncs with KF_NOCSR in special_kfunc_list though.
WDYT?

> +	}
> +
>   	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
>   		return;
>   

