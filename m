Return-Path: <bpf+bounces-74510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAFC5CE45
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A12F4EEA2D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764C313537;
	Fri, 14 Nov 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRmWDWzE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B86281356
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119968; cv=none; b=V79qv1YdKUzk/8sgWXoj8yiHJVzMWE1mI8EWDZa1EsnYi01psx/5KgZmzdXLPmoVENQ+S5Hw4TqVtQKg5zZEVTrRLKd8cURvDwT/E30JLKpZkoamIoOLNw3ez7qUi6XEbDtjsLXNlKK08WjsEMIMQ4NIMr8grZz+lAld3Agp/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119968; c=relaxed/simple;
	bh=+0R/LuYMDfeqaNYrvUexfuvVtvOvOgxqgOl8X+CknCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVDCBWYNf96+ntnpB7hCnqlTdjdu6HG3ToWEbNhB+nL+wbcNh6Cmllco6eG8GkPsBW0ymlXdyFCcGIJhROTnKy4+atb5py0MxjENDYGte/xGRU4UGyMbJiewsoGam2fM0KWOcwzWXM+/o34HucVIAXZcs7B5CxWYZUTSvQmv4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRmWDWzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C94C116D0;
	Fri, 14 Nov 2025 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119968;
	bh=+0R/LuYMDfeqaNYrvUexfuvVtvOvOgxqgOl8X+CknCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dRmWDWzEpTIbZuPxypSBFUfrhdoH/NLR7aEL9jR3912SaJNrWI7UiqYs4O3yCPzl7
	 IVXJzCngBQ3/JokHMlmd9N0johSGfoEUUF0FmuFM6/wm0CGhFP6LWVKkn58RIQSu67
	 08RzkgWfyoe4seoxje7VOb0Ddw0FbtvXQM1jTw19qF9o5tISpSak0CedEDzHTA3DeC
	 MNiPriAQ4tVIE/VCExf9Cu5lIa0xVTtFLKV7xxHB8WCd3Xu8E9miqYPOy3zvAiodsw
	 1qK0tdsZFMXG3n/RchAtnqc69soRdnj4S7222KXDAlhYI2Rv4SE5y9TAvFTuvNkXBI
	 eduswYkX/XcUw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2] bpf: verifier: initialize imm in kfunc_tab
 in add_kfunc_call()
In-Reply-To: <f3f7858c0a54c6eef670fe36f7cd15cc1f7dae16.camel@gmail.com>
References: <20251113104053.18107-1-puranjay@kernel.org>
 <f3f7858c0a54c6eef670fe36f7cd15cc1f7dae16.camel@gmail.com>
Date: Fri, 14 Nov 2025 11:32:44 +0000
Message-ID: <mb61pv7jc4zoj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Thu, 2025-11-13 at 10:40 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1268fa075d4c..31136f9c418b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3273,7 +3273,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>  	struct bpf_kfunc_desc *desc;
>>  	const char *func_name;
>>  	struct btf *desc_btf;
>> -	unsigned long addr;
>> +	unsigned long addr, call_imm;
>>  	int err;
>>  
>>  	prog_aux = env->prog->aux;
>> @@ -3369,8 +3369,20 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>  	if (err)
>>  		return err;
>>  
>> +	if (bpf_jit_supports_far_kfunc_call()) {
>> +		call_imm = func_id;
>> +	} else {
>> +		call_imm = BPF_CALL_IMM(addr);
>> +		/* Check whether the relative offset overflows desc->imm */
>> +		if ((unsigned long)(s32)call_imm != call_imm) {
>> +			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
>> +			return -EINVAL;
>> +		}
>> +	}
>
> Instead of having this logic in two places, how about moving the
> desc->imm setup down to sort_kfunc_descs_by_imm_off()?
> I think it the only consumer of desc->imm in verifier.c.
> E.g. as in the diff attached.

This seems like the best way to move ahead with fixing this. I will send
v3 with your suggested diff.

>> +
>>  	desc = &tab->descs[tab->nr_descs++];
>>  	desc->func_id = func_id;
>> +	desc->imm = call_imm;
>>  	desc->offset = offset;
>>  	desc->addr = addr;
>>  	desc->func_model = func_model;
>> @@ -22353,17 +22365,15 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>>  	}
>>  
>>  set_imm:
>> -	if (bpf_jit_supports_far_kfunc_call()) {
>> -		call_imm = func_id;
>> -	} else {
>> +	if (!bpf_jit_supports_far_kfunc_call()) {
>>  		call_imm = BPF_CALL_IMM(addr);
>>  		/* Check whether the relative offset overflows desc->imm */
>>  		if ((unsigned long)(s32)call_imm != call_imm) {
>>  			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
>>  			return -EINVAL;
>>  		}
>> +		desc->imm = call_imm;
>>  	}
>> -	desc->imm = call_imm;
>>  	desc->addr = addr;
>>  	return 0;
>>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1268fa075d4c..7ffe526c34cb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3391,16 +3391,44 @@ static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
> +static int set_kfunc_desc_imm(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
> +{
> +	unsigned long call_imm;
> +
> +	if (bpf_jit_supports_far_kfunc_call()) {
> +		call_imm = desc->func_id;
> +		return 0;
> +	} else {
> +		call_imm = BPF_CALL_IMM(desc->addr);
> +		/* Check whether the relative offset overflows desc->imm */
> +		if ((unsigned long)(s32)call_imm != call_imm) {
> +			verbose(env, "address of kernel func_id %u is out of range\n",
> +				desc->func_id);
> +			return -EINVAL;
> +		}
> +	}
> +	desc->imm = call_imm;
> +	return 0;
> +}
> +
> +static int sort_kfunc_descs_by_imm_off(struct bpf_verifier_env *env)
>  {
>  	struct bpf_kfunc_desc_tab *tab;
> +	int i, err;
>  
> -	tab = prog->aux->kfunc_tab;
> +	tab = env->prog->aux->kfunc_tab;
>  	if (!tab)
> -		return;
> +		return 0;
> +
> +	for (i = 0; i < tab->nr_descs; i++) {
> +		err = set_kfunc_desc_imm(env, &tab->descs[i]);
> +		if (err)
> +			return err;
> +	}
>  
>  	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>  	     kfunc_desc_cmp_by_imm_off, NULL);
> +	return 0;
>  }
>  
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> @@ -22320,10 +22348,10 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>  	bool is_rdonly;
>  	u32 func_id = desc->func_id;
>  	u16 offset = desc->offset;
> -	unsigned long addr = desc->addr, call_imm;
> +	unsigned long addr = desc->addr;
>  
>  	if (offset) /* return if module BTF is used */
> -		goto set_imm;
> +		return 0;
>  
>  	if (bpf_dev_bound_kfunc_id(func_id)) {
>  		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
> @@ -22351,19 +22379,6 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>  		if (!env->insn_aux_data[insn_idx].non_sleepable)
>  			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
>  	}
> -
> -set_imm:
> -	if (bpf_jit_supports_far_kfunc_call()) {
> -		call_imm = func_id;
> -	} else {
> -		call_imm = BPF_CALL_IMM(addr);
> -		/* Check whether the relative offset overflows desc->imm */
> -		if ((unsigned long)(s32)call_imm != call_imm) {
> -			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
> -			return -EINVAL;
> -		}
> -	}
> -	desc->imm = call_imm;
>  	desc->addr = addr;
>  	return 0;
>  }
> @@ -23441,7 +23456,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		}
>  	}
>  
> -	sort_kfunc_descs_by_imm_off(env->prog);
> +	ret = sort_kfunc_descs_by_imm_off(env);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }

