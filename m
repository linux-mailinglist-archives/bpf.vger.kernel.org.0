Return-Path: <bpf+bounces-70564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66858BC3134
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 02:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B050189B53B
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 00:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4462853E9;
	Wed,  8 Oct 2025 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8bqKGXj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0D2745E
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759883734; cv=none; b=o/q+wqVCb3BOBzn/T/MnTvRvHGjltD2eTAJa/6M3CV5z6OjpP1tjBIe59N0oSrucrDRdebM7JCm2AkHxHy7wN2tbW0S3/TQzZ64CuT3Igj+WXOF05x7soeDWlyJK5ErdBBf8+RkuVTjQqmfqM5Rz+M5XvUb2rvwMITGuKapOy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759883734; c=relaxed/simple;
	bh=F2jho/yqub7n7u2qeSzfzD3JUvFjel/H8LN+wDoobaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDlvF3IYtbV1SJLiaY9sVqt3fgTn2d8eGy6VFWot7CS6xLaFUL5ZlU1LhwcrOusLGH/nwFQARB3S60Ll3TGp1lynOVh0M19W4kZzn2HbcMuWsCjc/1Xf3+bPPSVPzluxT9K4y6NerLOaq+X7T3gJZbxIIjvQHMwm8MPRHsx97ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8bqKGXj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso55155795e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759883730; x=1760488530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpkxKVD0yZRLWSK1FqnKOB4Ws/bJ/e0vK8MOhyInDnY=;
        b=R8bqKGXj4MXW8oJZoB5kII1gxGOQ4Mng8/WEfXabbOUQNBL/hOpzQBjJIyCku5t00l
         9b5SY8bAhDejmJ2ROiPRT5oQsVXh/Hdjy3+SscWYt5oQq73y371It+Bj5d11DMgeOnuT
         RTIdzzh97jsNKuw0OCte30xUZ02dkr9NrZOV7VPMnrQDPkQLZdslYCgbdb0/BcfJ2oTX
         ueq1KJbEgYZuTxRpY+9F1Boh514uxE1ZlS6w01Bislljn79P6B1tLlljrn9QR2K8wlvM
         BPcZxw1voYcPr7rNh24riraKcGqWb5mdokVX77mmequQTskt6U7UULWl2w/0qqYg2hvN
         Sahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759883730; x=1760488530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpkxKVD0yZRLWSK1FqnKOB4Ws/bJ/e0vK8MOhyInDnY=;
        b=QphDvltIUWnXIbYKEjk+4UcCvhcew0rJG7VcpiaCDhEqNvvC42c4dMHydYNsBBaS4e
         dEYgnLxaN+dcUnt2sbUVsIluOs502uVAMFkN5+nkmGIkMawEHCmBLN7JtyDVV5q6xEo0
         SxjLtUTn0jBrJ9qvVj6mmdEdGBqRidg1+Lwh1UiJFif4oXS+ikhEy0pqGB/U+i6NQbps
         +pFMS8MMIkCwPjT3+sMOHKnqAFUdEQYjUjmNgMA0S6Bc+GgxPf0/suCSyVeAP1aKJBaz
         SFLvtKJu7Lwplk2mBc73mw8us4Ia6bMexdEoG9Q+L1zaVrriyiKGlsgkof27+OnHdMQq
         g9fA==
X-Forwarded-Encrypted: i=1; AJvYcCU2zSpNZ8sCIO6moYRT4WpEatOuGKp+koJvhcDFY20eoznUgmwWO/uZYm2ZpYHlQookGuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpTFiYhvZ/f3OHAMFmZ5lbtuLU+8oF0xqQfKkc8DzavZYdWlU
	Z53wcsXTS7kedtBjRNRsWzXiK02Yw4IxuXKAXBFPKUe4yoNcFkjMqRiC
X-Gm-Gg: ASbGncu2fQi2eG+oEhEfkLUHEs4eUbFLmhuX6PFla9wmqJMWaQq0xMuFAtWYi/Pv4Gr
	wSEVwr7QtXMrKL3WRbseddi+NPjaUoo0+QID1OQ4UvRWteVy2LGhYsMSC+S90ar9Pzqkup6+zqg
	iCtVek+sSTJbsDw7RID5N1aKXn07kA06hl5uu83DKMXik4hRu9lpZvXcORbAWAIh6ufIG1n0yB2
	VZAF23ZcktBVlWKCVtAoAPrmRCG2qLP59/s5bCUqkf+ebe3/2pH1CVuPo/hCYYgPXgDSg+H8NNk
	3CBto88OlmtOyGRQnJK1eBW14fIw0m2hvktb3RaPIxtxmVkt26xn5y7G3vXIobyVL9HpvwvZxNR
	Zu5b1c6Ij04BYtZkJxjRlxKncHq4fD9E2SrFCWiFqeRAZdBqaBdMWUnHCCIgPO2Llv4jKDWvGlu
	OdSqd7p3BLtqV9VTHMXzOtXzeXqxg1uy8=
X-Google-Smtp-Source: AGHT+IEfP7hSGTLw2bmbm6OwXdxBaqSOgiqV6Mg2lBzsbb5jEOlh8gpZq9RtkM9gyWf3oxrFDF0hNw==
X-Received: by 2002:a05:6000:230e:b0:3ee:15c6:9a6b with SMTP id ffacd0b85a97d-4266e8db295mr655218f8f.48.1759883730379;
        Tue, 07 Oct 2025 17:35:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d869d50sm28253112f8f.0.2025.10.07.17.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 17:35:29 -0700 (PDT)
Message-ID: <34d977bf-657b-41ca-a150-fbaa596810f6@gmail.com>
Date: Wed, 8 Oct 2025 01:35:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 08/10] bpf: verifier: refactor kfunc specialization
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-9-mykyta.yatsenko5@gmail.com>
 <bf0c87d7c378f033dd2efc193c86789cfd2604f3.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <bf0c87d7c378f033dd2efc193c86789cfd2604f3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 23:08, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> @@ -3354,18 +3344,29 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>   			return err;
>>   	}
>>   
>> +	err = btf_distill_func_proto(&env->log, desc_btf,
>> +				     func_proto, func_name,
>> +				     &func_model);
>> +	if (err)
>> +		return err;
>> +
>> +	call_imm = kfunc_call_imm(addr, func_id);
>> +	/* Check whether the relative offset overflows desc->imm */
>> +	if ((unsigned long)(s32)call_imm != call_imm) {
> This error was previously reported only when !bpf_jit_supports_far_kfunc_call().
>
>> +		verbose(env, "address of kernel function %s is out of range\n",
>> +			func_name);
>> +		return -EINVAL;
>> +	}
>> +
>>   	desc = &tab->descs[tab->nr_descs++];
>>   	desc->func_id = func_id;
>> -	desc->imm = call_imm;
> Nit: no need to move this assignment.
>
>>   	desc->offset = offset;
>>   	desc->addr = addr;
>> -	err = btf_distill_func_proto(&env->log, desc_btf,
>> -				     func_proto, func_name,
>> -				     &desc->func_model);
>> -	if (!err)
>> -		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>> -		     kfunc_desc_cmp_by_id_off, NULL);
>> -	return err;
>> +	desc->imm = call_imm;
>> +	desc->func_model = func_model;
>> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>> +	     kfunc_desc_cmp_by_id_off, NULL);
>> +	return 0;
>>   }
>>   
>>   static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
>> @@ -21822,21 +21823,32 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>>   	return err;
>>   }
>>   
>> +static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id)
>> +{
>> +	if (bpf_jit_supports_far_kfunc_call())
>> +		return func_id;
>> +
>> +	return BPF_CALL_IMM(func_addr);
>> +}
>> +
>>   /* replace a generic kfunc with a specialized version if necessary */
>> -static void specialize_kfunc(struct bpf_verifier_env *env,
>> -			     u32 func_id, u16 offset, unsigned long *addr)
>> +static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
>>   {
>> +	struct bpf_prog_aux *prog_aux = env->prog->aux;
>> +	struct bpf_kfunc_desc_tab *tab = prog_aux->kfunc_tab;
>>   	struct bpf_prog *prog = env->prog;
>>   	bool seen_direct_write;
>>   	void *xdp_kfunc;
>>   	bool is_rdonly;
>> +	u32 func_id = desc->func_id;
>> +	u16 offset = desc->offset;
>> +	unsigned long call_imm;
>> +	unsigned long addr = 0;
>>   
>>   	if (bpf_dev_bound_kfunc_id(func_id)) {
>>   		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
>> -		if (xdp_kfunc) {
>> -			*addr = (unsigned long)xdp_kfunc;
>> -			return;
>> -		}
>> +		if (xdp_kfunc)
>> +			addr = (unsigned long)xdp_kfunc;
>>   		/* fallback to default kfunc when not supported by netdev */
>>   	}
> Note: right after this line there is:
>
> 	if (offset)      // this checks if kernel or module BTF is used
> 		return;
>
> The refactoring changes behavior at this point:
> previously if `offset != 0` the `addr` computed for dev bound kfunc
> would be assigned to `desc->addr`, after the refactoring this is not
> the case.
>
> On the other hand, bpf_dev_bound_kfunc_id() looks up func_id in set8
> xdp_metadata_kfunc_ids, that contains functions only defined for
> kernel BTF.
>
> Hence, I suggest moving this `if (offset) return` as the first check
> in the function, to avoid confusion.
Thanks for checking, your suggestion makes sense.
>
>>   
>> @@ -21848,21 +21860,28 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>>   		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
>>   
>>   		if (is_rdonly)
>> -			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>> +			addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>>   
>>   		/* restore env->seen_direct_write to its original value, since
>>   		 * may_access_direct_pkt_data mutates it
>>   		 */
>>   		env->seen_direct_write = seen_direct_write;
>> +	} else if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr]) {
>> +		if (bpf_lsm_has_d_inode_locked(prog))
>> +			addr = (unsigned long)bpf_set_dentry_xattr_locked;
>> +	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
>> +		if (bpf_lsm_has_d_inode_locked(prog))
>> +			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
>>   	}
>>   
>> -	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
>> -	    bpf_lsm_has_d_inode_locked(prog))
>> -		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
>> +	if (!addr) /* Nothing to patch with */
>> +		return;
>>   
>> -	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
>> -	    bpf_lsm_has_d_inode_locked(prog))
>> -		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
>> +	call_imm = kfunc_call_imm(addr, func_id);
>> +	desc->imm = call_imm;
> Nit:	desc->imm = kfunc_call_imm(addr, func_id);
>
>> +	desc->addr = addr;
>> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>> +	     kfunc_desc_cmp_by_id_off, NULL);
> Why sorting again?
> Neither `func_id` nor `offset` fields change.
yes, this is a mistake.
>
>>   }
>>   
>>   static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
>> @@ -21885,7 +21904,7 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
>>   static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>>   {
>> -	const struct bpf_kfunc_desc *desc;
>> +	struct bpf_kfunc_desc *desc;
>>   
>>   	if (!insn->imm) {
>>   		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
>> @@ -21905,6 +21924,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		return -EFAULT;
>>   	}
>>   
>> +	specialize_kfunc(env, desc);
>> +
>>   	if (!bpf_jit_supports_far_kfunc_call())
>>   		insn->imm = BPF_CALL_IMM(desc->addr);
>>   	if (insn->off)


