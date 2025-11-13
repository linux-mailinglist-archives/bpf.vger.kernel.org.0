Return-Path: <bpf+bounces-74413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1618C588AD
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E76336141A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866E2FB0AE;
	Thu, 13 Nov 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1DfFe4V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FE2FB0BA
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048051; cv=none; b=ipb7ULX2KoUDqxSlHhEdriWUvGQjK11pUgdS/6yXequ3T1mGNMwMTtPmIpZWAyDNjMKJHzY90S/YJIHvDTq1n0qp+DfjYrIDqyfYLS2To7bOrG9rwGdnmpY22qpVeagaVhVA9XfURgGY/sUv2AkNz1kVE98DmpCYW52Yq75/80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048051; c=relaxed/simple;
	bh=06gJqrdoRN1xpvaLS9HUF175HoWJJl4TeNfM2pjvtS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svq/OymQuuplCyEegyO2LEd1wc+FyUSzX7rcS1nNvbcnm8KQPfZ79ofcoIDbpScYRKXCr6zqHMs2AZNjNWjNGm/bferFsFevFBhevqvNJr54h0gBEfWgwWRrn4jQHXwbiPV0xTNdOtMiOjfz1wRGksr76XMiDOS/bhWE05hvtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1DfFe4V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c8632fcbso730044f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763048048; x=1763652848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+NklgUIyX2ApE6fA2myszEvp6adftkp/35Nkh079g0=;
        b=F1DfFe4V5UQUw/5X2CahIN4CAS51ZZVxRGBUPneza9Mk70mokwJZm2J0fp+AmNcpmZ
         IB0qiV5wcI91SF0IHKMeAyTXKXpJqPnWYwXz81fj4H2kHmzfNNW2AVpcUGTRawc3JTnM
         JOooM09ykCibWK6le4vhO9GnlM5GYWxc5f4Lvbp9DXNPoCxQ/xBy0bJwjbcH8W5DEsZc
         tAV69Ex8/Fs3mXx+4cpm5Ue/wv4+/AovYjrcde5dOsQ5ugtY4yGli2INQrsuzM9Owp4M
         QKZkjcH4R5JVG+ZSI66GphlB1GXuE8mxd/TJkFVDQsW8V9q643uwIcLpzDVbnyTMoAPv
         a4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763048048; x=1763652848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+NklgUIyX2ApE6fA2myszEvp6adftkp/35Nkh079g0=;
        b=mr/dqRHHTXuOBPXa068+cf9/FOCmKvwdcUyHccMwbBH6G+fcSGfyY+/JDQHl5vAFE+
         x7/DMm3lx+KTbeVbso8n70MismHVTBadPq4pUlT1sCsvsTow0Yaa4oXmfhpVUScYAvh2
         h0nVXUXmF0athY9sZpzGxiEfoi5PnCyZym5zV8tPBVsUtixvFZ8mkYgr6Ye99nA52Vx0
         wL7Mtl5bWntH87u8WS84xO7/LFrSkOfTmDTvSyjJoGKOfHK1x6Dhu1ZRGYyA83CUD3Mb
         2mQWckX/sls8sbcxAzIncKZTedwxkaipFiWqPCORCZdZgYZh54EiqcY9pDoOsc8huhxO
         E9wg==
X-Forwarded-Encrypted: i=1; AJvYcCWx9PJaeC6nJ6ysSOKgLDTeWSUlAVnXdDC2hNv6KA1gnx+J9NjvB2VEofIWvHvB6k7mD+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x6sE53q+4HQBy7sZdi9uDrY3jmwXJ2nY1ulBH19CilbnAWEx
	V4MZ5KfIvJw6t4jgeVUo7W546FIVE4DQUjROMH5OwWhZzLKV1u3CeGRA
X-Gm-Gg: ASbGnct0Tmf7l1VbTtrMJ1AkAP+AFKpp912MsVzrAehZgdb99zfVO0EAjziFSzxHKSG
	4rBCvjU+Toi2cDkc28CYPCLo1HfANxfqkvrh4NEOt+wsFj0Zfbcltf5RcqlFVOVayFUGbcKqsF4
	QhJxhEmsdV6rLZ9rxAFBej3zLTkVJ2kAVtXe9Mn47X2QYFo1+xnkq2CGoktc8NN52VeV8DRbvDV
	Ow5ALP9wSEOB8F1GmGBvzZGQp/mNXsqSOuE5J/4dYuaZhEffJTbvV/eXr4Jcv5ELHcMQjED+ByQ
	tpFyE3KkhWOiLqBYwkXN1tGz8IuDOB2t2UBtRK+RDdkhM7hFV8fY+rC2YWdH9dhSfZU+xCk6YKw
	Y3QQk9apY5Q+mZESOJZJnkd3848tvBZEgTuFENEn0ciYJjQRdyADW8ljKcSiK88V0dQAp+SYwtY
	SQJ9qxZ+VUvxTh6Njqx56sUbKZrx8MmOnOTrsj
X-Google-Smtp-Source: AGHT+IGTr79sZJSLWS6c5li1Z3jg83Sof5CRmYZplewzK6lxeQsWk6mvDZYA8Mzdenn67+zHsruQ+w==
X-Received: by 2002:a05:6000:24c9:b0:42b:39fb:e88f with SMTP id ffacd0b85a97d-42b4bb9363amr6570329f8f.23.1763048047454;
        Thu, 13 Nov 2025 07:34:07 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:3eff:3b9d:5bc8:816a? ([2620:10d:c092:500::6:127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm4350118f8f.9.2025.11.13.07.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:34:06 -0800 (PST)
Message-ID: <f2f02cc9-5f52-4e3d-a5a6-edba662a0c5e@gmail.com>
Date: Thu, 13 Nov 2025 15:34:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: verifier: initialize imm in kfunc_tab in
 add_kfunc_call()
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20251113104053.18107-1-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251113104053.18107-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 10:40, Puranjay Mohan wrote:
> Metadata about a kfunc call is added to the kfunc_tab in
> add_kfunc_call() but the call instruction itself could get removed by
> opt_remove_dead_code() later if it is not reachable.
>
> If the call instruction is removed, specialize_kfunc() is never called
> for it and the desc->imm in the kfunc_tab is never initialized for this
> kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> do_misc_fixups() doesn't sort the table correctly.
> This is a problem from s390 as its JIT uses this table to find the
> addresses for kfuncs, and if this table is not sorted properly, JIT can
> fail to find addresses for valid kfunc calls.
>
> This was exposed by:
>
> commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
>
> as before this commit, desc->imm was initialised in add_kfunc_call().
>
> Initialize desc->imm in add_kfunc_call(), it will be overwritten with new
> imm in specialize_kfunc() if the instruction is not removed.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>
> Changes in v1->v2:
> v1: https://lore.kernel.org/all/20251111160949.45623-1-puranjay@kernel.org/
> - Removed fixes tag as the broken commit is not upstream yet.
> - Initialize desc->imm with the correct value for both with and without
>    bpf_jit_supports_far_kfunc_call() for completeness.
> - Don't re-initialize desc->imm to func_id in specialize_kfunc() as it
>    it already have that value, it only needs to be updated in the
>    !bpf_jit_supports_far_kfunc_call() case where the imm can change.
>
> This bug is not triggered by the CI currently, I am working on another
> set for non-sleepbale arena allocations and as part of that I am adding
> a new selftest that triggers this bug.
>
> Selftest: https://github.com/kernel-patches/bpf/pull/10242/commits/1f681f022c6d685fd76695e5eafbe9d9ab4c0002
> CI run: https://github.com/kernel-patches/bpf/actions/runs/19238699806/job/54996376908
>
> ---
>
>   kernel/bpf/verifier.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1268fa075d4c..31136f9c418b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3273,7 +3273,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>   	struct bpf_kfunc_desc *desc;
>   	const char *func_name;
>   	struct btf *desc_btf;
> -	unsigned long addr;
> +	unsigned long addr, call_imm;
>   	int err;
>   
>   	prog_aux = env->prog->aux;
> @@ -3369,8 +3369,20 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>   	if (err)
>   		return err;
>   
> +	if (bpf_jit_supports_far_kfunc_call()) {
> +		call_imm = func_id;
> +	} else {
> +		call_imm = BPF_CALL_IMM(addr);
> +		/* Check whether the relative offset overflows desc->imm */
> +		if ((unsigned long)(s32)call_imm != call_imm) {
> +			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
> +			return -EINVAL;
> +		}
> +	}
> +
>   	desc = &tab->descs[tab->nr_descs++];
>   	desc->func_id = func_id;
> +	desc->imm = call_imm;
>   	desc->offset = offset;
>   	desc->addr = addr;
>   	desc->func_model = func_model;
> @@ -22353,17 +22365,15 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>   	}
>   
>   set_imm:
> -	if (bpf_jit_supports_far_kfunc_call()) {
> -		call_imm = func_id;
> -	} else {
> +	if (!bpf_jit_supports_far_kfunc_call()) {
>   		call_imm = BPF_CALL_IMM(addr);
>   		/* Check whether the relative offset overflows desc->imm */
>   		if ((unsigned long)(s32)call_imm != call_imm) {
>   			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
>   			return -EINVAL;
>   		}
Not a big deal, but maybe extracting this piece of code into a separate 
function will
make it better a little bit. It makes it easier to debug verifier when 
any concrete error
is produced only once, then you know where to put the breakpoint, less 
chances to miss something.
> +		desc->imm = call_imm;
>   	}
> -	desc->imm = call_imm;
>   	desc->addr = addr;
>   	return 0;
>   }


