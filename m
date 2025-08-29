Return-Path: <bpf+bounces-66988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03828B3BF1F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0851A02517
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6969322761;
	Fri, 29 Aug 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp8YMsnZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26B2765D7
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480995; cv=none; b=aynTWexJoVgF7uxGCIRywg34+lHpxrVm+rcnOOgCT2yXjhdx4o8xIXOtjpiCwfBf3jkuRV0Pvi8E//kiuuqvXPTSBMp+5JfIC/AqprM+yiYV3xGCyrek2Z5JlLYp/WKOFVmf5jNQF4wRIz6rOq53Gi1pS5dF1RvvZxNDq/3ZpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480995; c=relaxed/simple;
	bh=Ydui2G7A1kKQ5zlCMho8YFl1ywgz8moic3cIjMUmpr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne0fDjlxyuz1NMqHaA5j3jIipON5jMYekiT5UjRJDIkQ8CPVyiwMczGCFR/gDDPiryK3vfOqzx/YxdYfjnzJJE3eMpHRkNbF/LybZBd+ExoA0AYGglxVri182P7tjJFicbZXtnJ4Q256ZzLAUHrwkyrZMaXHzys2HHzrqsBSLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp8YMsnZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afe9358fe77so295043366b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756480991; x=1757085791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCGO7sk5eNBjjd6QFO1QMGY+4oW4c3pdxRlL/5+WJw0=;
        b=kp8YMsnZh37hF0bmPoM3544tsdcWySrxgmhYnekVddz/vB2E/g8zQ4FE8gUBInalPj
         /TQuIfL9TiiDuZSzALlI8vlHyVbyVDNxYb9+DFBSuGdB1T85DINnSe8o5/hAG/IsizGp
         mkdh1CzlDgj5oHWpSNG1+ddW5mEmAwygFzLScv1KEFou+CShCX17vYReIR9oOxdsc2wZ
         t/060f3w7bnGRUL1KIQIKEM/tApi7vNK0dml+aSObXIU1t1ZQaenrQhearlCL9T5ZHqP
         1PYLuwBwN/oxyqlysoAnGg+CrMhghdAdz21d6r9ud9PlC0J0ULpVDyMWzm98Yj4X8ukT
         zwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480991; x=1757085791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCGO7sk5eNBjjd6QFO1QMGY+4oW4c3pdxRlL/5+WJw0=;
        b=QWlvkq2r+xj6Q+WrA75Qd/30NJtsuA2+Irn5XxV3hpwvVbuVOPLhiUDgXoMW9/TNwS
         5OW2Ydyih8Xazxj1rq6n30QCD+427Ix5xOcvUyXb1xql6at3bBX+KluaRp58V1IWuoDG
         2qRTEn58dLuA9Un/4BC5ZksnPLplk8HqT8YdC4CNgCdYMMXUtsBMBKYt8DeSes6vB0TU
         PqIWaBDQUO5w7+tJlVWty/dMcp+xRnZFG41n02xm1wUJzlJJUQfKZOpW60uYcAgF2TMJ
         XD0ALTeMRYzClh4raErfpYE4/ehFDNOVq1xe06ib+2aS9jHQyMZxSB/2squLHBcSwJBo
         Yx/w==
X-Forwarded-Encrypted: i=1; AJvYcCUB+VlQs1hSGz9oau4+HyH8e87/m+6You3SPYZzCkGtZ6h3EhS0O8q0tLE9AE+to21klx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlqU8MVI6BvvV5h6PrsD8LwskIb+mA6V4e3m4myhevdy+YDX/
	kSADpBqZ6zS+yVb+2+3ibYOILcU869pKQ09RsHIUaays0leAzopuKJr7bZAs0g==
X-Gm-Gg: ASbGncudjv4D2L3dN3kmp8QzxB14Fp7KRpckU5wQk0P1xRoqSko1QSGc3HbJ1aPq1xM
	9Zw1TWQ7lfQGUxFjiTWdk3CZlS3A//HDpC1bk8wDgfsIPU+PZSzkDnbDAWVJ7lt+R+1KNkDRyaE
	P/IdjYOYg2XTdu7VCSYO0iFrW2uRW71rOzWBLXbXrcfCAG6sHzYOmccgosDXmMpLGpKexkg5Qps
	eJnJu1bV6J6TtkEQnvopWJAmQljPyIfhnhbBYV7L0TtRrps7QqoMhyprvLSjacP6cz/5lMgbiV2
	nDe8vXMjXixTOyVUaDwvnYRiIMv6cP47qkkg9GtsTdDGVew4aoktPONiMHzpst/RC76VCr3M4YS
	QBcY+rsgE4frPMws02KhBIEN+vQENdds4CQvW3qPIWHd7gXMH8VxSGZDp7OCXK3ifUOzTbg==
X-Google-Smtp-Source: AGHT+IErWQEFymaI9UNQRYKKWq9x5xud6AbFT8kDfhdMVnK8b3l6u4tQg/i5yJ1o7uf8wsan34QcKA==
X-Received: by 2002:a17:907:2d2c:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-afe29031d11mr2425679966b.22.1756480990563;
        Fri, 29 Aug 2025 08:23:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:3d26:18e2:66bb:3a54? ([2620:10d:c092:500::5:4e0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5572afsm1878833a12.50.2025.08.29.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:23:09 -0700 (PDT)
Message-ID: <13fb00d0-2913-44a4-bcd9-b2a63ab3bae9@gmail.com>
Date: Fri, 29 Aug 2025 16:23:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf: bpf task work plumbing
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-2-mykyta.yatsenko5@gmail.com>
 <5be3791aa3fe268a8da6ef2e4691a13e7947f805.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5be3791aa3fe268a8da6ef2e4691a13e7947f805.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 02:34, Eduard Zingerman wrote:
> On Fri, 2025-08-15 at 20:21 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> This patch adds necessary plumbing in verifier, syscall and maps to
>> support handling new kfunc bpf_task_work_schedule and kernel structure
>> bpf_task_work. The idea is similar to how we already handle bpf_wq and
>> bpf_timer.
>> verifier changes validate calls to bpf_task_work_schedule to make sure
>> it is safe and expected invariants hold.
>> btf part is required to detect bpf_task_work structure inside map value
>> and store its offset, which will be used in the next patch to calculate
>> key and value addresses.
>> arraymap and hashtab changes are needed to handle freeing of the
>> bpf_task_work: run code needed to deinitialize it, for example cancel
>> task_work callback if possible.
>> The use of bpf_task_work and proper implementation for kfuncs are
>> introduced in the next patch.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Amount of copy-paste necessary for dealing with objects btf is saddening.
> This patch follows current approach and seem to do it correctly.
>
> [...]
>
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -431,7 +431,7 @@ static void *array_map_vmalloc_addr(struct bpf_array *array)
>>   	return (void *)round_down((unsigned long)array, PAGE_SIZE);
>>   }
>>   
>> -static void array_map_free_timers_wq(struct bpf_map *map)
>> +static void array_map_free_internal_structs(struct bpf_map *map)
>>   {
>>   	struct bpf_array *array = container_of(map, struct bpf_array, map);
>>   	int i;
>> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
>>   	/* We don't reset or free fields other than timer and workqueue
>>   	 * on uref dropping to zero.
>>   	 */
>> -	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
>> +	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
> Is there a way to share this code between array map and hash map?
I don't see any common library used by both arraymap and hashtab (it's 
likely I'm missing something).
Although this code looks similar, there are some differences, for 
example use of array_map_elem_ptr/htab_elem_value, which currently runs 
only when value has special field, if we to extract below code into a 
separate function, we'll have to run it unconditionally, which will add 
some small cost. All this combined makes it not very appealing to go 
after reusing that code. I agree that having a more centralized place to 
deal with these special structs would make things better.
>
>>   		for (i = 0; i < array->map.max_entries; i++) {
>>   			if (btf_record_has_field(map->record, BPF_TIMER))
>>   				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>>   			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>>   				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
>> +			if (btf_record_has_field(map->record, BPF_TASK_WORK))
>> +				bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>>   		}
>>   	}
>>   }
> [...]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64739308902f..378f260235dd 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3527,6 +3527,15 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
>>   			goto end;
>>   		}
>>   	}
>> +	if (field_mask & BPF_TASK_WORK) {
>> +		if (!strcmp(name, "bpf_task_work")) {
>> +			if (*seen_mask & BPF_TASK_WORK)
>> +				return -E2BIG;
>> +			*seen_mask |= BPF_TASK_WORK;
>> +			type = BPF_TASK_WORK;
>> +			goto end;
>> +		}
>> +	}
> Nit: extract this and ifs before it as a loop over array
>       of name/flag pairs?
Makes sense, though, I guess it'll require a separate refactoring patch.
>
>>   	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
>>   	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
>>   	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
> [...]
>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 71f9931ac64c..207ad4823b5b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> [...]
>
>> @@ -233,6 +233,9 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
>>   		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>>   			bpf_obj_free_workqueue(htab->map.record,
>>   					       htab_elem_value(elem, htab->map.key_size));
>> +		if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
>> +			bpf_obj_free_task_work(htab->map.record,
>> +					       htab_elem_value(elem, htab->map.key_size));
> If there is no generic way to share this code with array maps,
> please, at-least within the hashmap.c extract these "if (btf_record_has_field(...)) {...}"
> groups so that there is no duplication between
> htab_free_{malloced,preallocated}_internal_structs(htab).
>
>>   		cond_resched();
>>   	}
>>   }
> [...]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0fbfa8532c39..108d86f7eeaf 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> [...]
>
>> @@ -1309,6 +1322,14 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>   					goto free_map_tab;
>>   				}
>>   				break;
>> +			case BPF_TASK_WORK:
> This can be added to the group with BPF_TIMER and BPF_WORKQUEUE just above.
Ack.
>
>> +				if (map->map_type != BPF_MAP_TYPE_HASH &&
>> +				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
>> +				    map->map_type != BPF_MAP_TYPE_ARRAY) {
>> +					ret = -EOPNOTSUPP;
>> +					goto free_map_tab;
>> +				}
>> +				break;
>>   			default:
>>   				/* Fail if map_type checks are missing for a field type */
>>   				ret = -EOPNOTSUPP;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a61d57996692..be7a744c7917 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [...]
>
> This function repeats process_timer_func() almost verbatim.
Right, I'll extract into a generic function.
>
>> +{
>> +	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>> +	struct bpf_map *map = reg->map_ptr;
>> +	bool is_const = tnum_is_const(reg->var_off);
>> +	u64 val = reg->var_off.value;
>> +
>> +	if (!map->btf) {
>> +		verbose(env, "map '%s' has to have BTF in order to use bpf_task_work\n",
>> +			map->name);
>> +		return -EINVAL;
>> +	}
>> +	if (!btf_record_has_field(map->record, BPF_TASK_WORK)) {
>> +		verbose(env, "map '%s' has no valid bpf_task_work\n", map->name);
>> +		return -EINVAL;
>> +	}
>> +	if (!is_const) {
>> +		verbose(env,
>> +			"bpf_task_work has to be at the constant offset\n");
>> +		return -EINVAL;
>> +	}
>> +	if (map->record->task_work_off != val + reg->off) {
>> +		verbose(env,
>> +			"off %lld doesn't point to 'struct bpf_task_work' that is at %d\n",
>> +			val + reg->off, map->record->task_work_off);
>> +		return -EINVAL;
>> +	}
>> +	if (meta->map.ptr) {
>> +		verifier_bug(env, "Two map pointers in a bpf_task_work kfunc");
>> +		return -EFAULT;
>> +	}
>> +
>> +	meta->map.uid = reg->map_uid;
>> +	meta->map.ptr = map;
>> +	return 0;
>> +}
>> +
>>   static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>>   			     struct bpf_call_arg_meta *meta)
>>   {
> [...]


