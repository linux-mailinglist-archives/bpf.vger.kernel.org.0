Return-Path: <bpf+bounces-70615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD9BC64A7
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 20:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 900564E138E
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D72C0294;
	Wed,  8 Oct 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdjzIMZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B128504F
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948042; cv=none; b=OT/aWFfbFzTXqwARBGhr5hFvKY6b5PXLjWNuh9PwRFmHRWtFbApFO/BObeadnSTvLB0cPmCTwhVMD0GmxLMFlkvZBenJmbLCzFfspu2XUXZx+3B+9IxunOMtLMGwD9ZoqqQ9u39nWkhdoKmubtNC5gpU8QgKk0EU9tFWz7GRM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948042; c=relaxed/simple;
	bh=5kipz1u5jAGIpDeRwTOusX73sqlNTD1ija8uMjGlIzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IesR4aHmuZLGPhSoc/2OUJy5mcIQ3sUMPF0o1LktRVSq/5CdoCejzZa0Nd/UjE17o9hferFSJIwjhE64d34UX7sHWTBa9WL93j0M9mVdBQS02/U77ZMBnuKcD2ccH7u7uABt8gLbb/glo5Eor7mIeE8VQ1xdhJm1gWD3MIrYNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdjzIMZt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee130237a8so233568f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759948039; x=1760552839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeECzwpw9IdOxCcB5VeqcoOix8jUd/JN0HvMrOkC2+4=;
        b=UdjzIMZtFpqcZt60AQz1Mvync3XMA5Vlu2isTSLuEUyVYrPi0vEI3Va8kCnj65sd8k
         BNJFNWMmnSYGtt3ScimrlnvsCFciGHt/DTRwl9T4a029z/Bch8t1AlifUJen8RhNtEGn
         K+iZMgonRU3rvJ0yRvW9PjAPtsZJRhSrPd0TwYdLUKYqcM43PrqTS5gRxOtguEsI2pow
         zWarJMRgBqgEzgSBLcI98rpd6XFoa8ZvY/bzFYwQsd1E4itcvOvBWddoloSii+5Cmuhf
         rwUoWeqJY8kTNTNpEzFW2Sb2+t/Cipou4fFZjOiO81YzSqXiIdGgPRYGlDkdmY66jG5G
         gjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948039; x=1760552839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeECzwpw9IdOxCcB5VeqcoOix8jUd/JN0HvMrOkC2+4=;
        b=u+iwb41SFlbmUqu3FtFMDEnscugq6na5laaqQ7PverUlAV+KpQj8ZLm4KvRsbmCHjQ
         RP7oTxNpV8CnSfI9q9aspUa16tGuP1JLFeOpl/9Eue5MN2TNR7eBrBtaPpyxPet/2AYF
         2RVXscvkzxYc3r9xUS6yfpBEP0pVdICSRqPYHOKDeJxq/IfwnNkFC3vB5jG8KdFq+OrU
         J0HLDtNzwSjD5GlHq6QMNmXQhlmck0070S8+auG1zm2mtVjnNVDqgfB0inIAZEXK5iwU
         rIz4OOlp+3MD/ETiykCfom/c6AL5hNVerJzFsleE3jXM5NNjz/MHo+k5LJ2GTf9G7EDI
         PBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVAxPWXNsvErd73cvOmzbL0Yxct34FyYZXv6aripOsBRXTZIT10xZXWbPN+6Jb077NI40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pNxP94T9ZrTz60UwJi6WllPDTBGVyNHHOSsdXOKbnMkvXjHV
	3thR/433gqG/CcVVbLqscoMERXTJhAKcvP8P8Vju6ptPOnx0Mfn1n1s6
X-Gm-Gg: ASbGnctDCu2AVqEcSbTczOQS+h+OSjYJn/atvQIxk6Bia8sLBCZf7vkDpvtiLrMO3wX
	F5YCH+lnjoklTARIkqhPe3QdChb2R4Zk0NQtPwCrsBfbBGbo2/wwvyKOzAzLwyCkb6ZFM0C1blt
	7a1QWagqKAAdmMoY0BheGvCUylWpxLA0TitoKZ4JHiebvq66liqE5bdsPYmgW3Um0SDffFgHLbz
	mHAgbasTHSeBieklKdg2K+i9QrTQvdw8Iq5Y9qT8EzEble8XbRsMzOAxracCfLbpWmz/h75ctdb
	/9RfITLrUDM0uFCOiZzji+rxMA3C6g+HGeNRB0pjyOKcMf8ZGwAlj95Ct//UDBGGnOqqeDCil8V
	oo0vQWdT5j1X2V3dj54i5ed+h7sCpPyZTB5X/s2FDHTrPk5i14lyxDi1MP93xXKnx9NM=
X-Google-Smtp-Source: AGHT+IGgZvRiVoRrS6j5mGKGu8h5lWC6nSYuLqE0C4QEQxexGzGp0UEVrxqTaHmmHtQQ9R8Z5GURdg==
X-Received: by 2002:a05:6000:603:b0:401:41a9:524f with SMTP id ffacd0b85a97d-4266e7d452bmr3035612f8f.29.1759948038834;
        Wed, 08 Oct 2025 11:27:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::122e? ([2620:10d:c092:400::5:6a7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm30864788f8f.12.2025.10.08.11.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:27:18 -0700 (PDT)
Message-ID: <bb2eac7d-fe07-4e44-bd21-74115fed02bb@gmail.com>
Date: Wed, 8 Oct 2025 19:27:17 +0100
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
Sorry for the delayed response.
This condition can only be true if call_imm is a 64 bit address. But if
bpf_jit_supports_far_kfunc_call() is true, call_imm holds func_id which 
is u32,
anyway, so we can't hit this error.
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


