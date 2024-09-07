Return-Path: <bpf+bounces-39187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477296FF04
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 03:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16CF1F241AD
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CEA95E;
	Sat,  7 Sep 2024 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ahk9hvik"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA594DDA1
	for <bpf@vger.kernel.org>; Sat,  7 Sep 2024 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672762; cv=none; b=cG4EmhgjCJD9kwEjaQ+ER7npDjVAjpQuQixexJcDKDhQP3i0Tvc4GPThCicqC3h/BH4oaEEEGYa0ZJPZsrYfNlYsu9HplcqNfWlDj5wWDfzz9k99y+l6KsX+6OZczGXAOGrQ5kg7GnFw15ljGKqfLGXYcvXbgJg8wC1oQIC+gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672762; c=relaxed/simple;
	bh=/w6yYFPTDRwVchSRTs9IqQ3RMnZgNSozbDzaZkgkVfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MK0OtYvT9mGErSRD2/ATkTobl46qUfu0gDXfzLqo8mnnUvM/AX95HCCKZWpsLSW+sfkjclg8sJAYOFGsb/xcq4LrsiVfXJKKuMfjlwMgfYmvYdGG/6pPGwocR1/RV4oaydDqrK49Ldb/ExkwQqQc3AoZEd32MonqywPj/FB7nNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ahk9hvik; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b61f093-a6a6-4f99-91f8-20f2a7235d76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725672753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYzKAnd9omi958b/3GtTF043/RrnCzAxquLlADIrGW8=;
	b=Ahk9hvikwIGZrJz/kyFqSEQE2HKP1rdET/PhJ4QUvLIHyjBitMQ1yyS8TutzJo/g/FOjo5
	fzYku0l+ffe88lqsH0nrMQWEdE3sWr6G50w6+Sly5UArPqhmDCUlzUR8xOqvtXV1ouq8Oy
	6piP3ZY2mOS3iOGipCTNiXXFOIDgvKs=
Date: Fri, 6 Sep 2024 18:32:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from
 syscalls.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <sinquersw@gmail.com>, linux-mm <linux-mm@kvack.org>
References: <20240816191213.35573-1-thinker.li@gmail.com>
 <20240816191213.35573-5-thinker.li@gmail.com>
 <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
 <70a1b24f-84cd-464c-8fb6-a2c52fd3d703@linux.dev>
 <f84e4a86-976a-4fd2-94e7-8026dc3ae56e@linux.dev>
 <CAADnVQLzFDb8Hi9jnW46f2UFYZUre6UpLg-3g=xcEvfv=wkFxA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQLzFDb8Hi9jnW46f2UFYZUre6UpLg-3g=xcEvfv=wkFxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/6/24 4:44 PM, Alexei Starovoitov wrote:
> On Fri, Sep 6, 2024 at 1:11 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 9/4/24 3:21 PM, Martin KaFai Lau wrote:
>>> On 8/28/24 4:24 PM, Alexei Starovoitov wrote:
>>>>> @@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *rec,
>>>>> void *obj)
>>>>>                                   field->kptr.dtor(xchgd_field);
>>>>>                           }
>>>>>                           break;
>>>>> +               case BPF_UPTR:
>>>>> +                       if (*(void **)field_ptr)
>>>>> +                               bpf_obj_unpin_uptr(field, *(void **)field_ptr);
>>>>> +                       *(void **)field_ptr = NULL;
>>>> This one will be called from
>>>>    task_storage_delete->bpf_selem_free->bpf_obj_free_fields
>>>>
>>>> and even if upin was safe to do from that context
>>>> we cannot just do:
>>>> *(void **)field_ptr = NULL;
>>>>
>>>> since bpf prog might be running in parallel,
>>>> it could have just read that addr and now is using it.
>>>>
>>>> The first thought of a way to fix this was to split
>>>> bpf_obj_free_fields() into the current one plus
>>>> bpf_obj_free_fields_after_gp()
>>>> that will do the above unpin bit.
>>>> and call the later one from bpf_selem_free_rcu()
>>>> while bpf_obj_free_fields() from bpf_selem_free()
>>>> will not touch uptr.
>>>>
>>>> But after digging further I realized that task_storage
>>>> already switched to use bpf_ma, so the above won't work.
>>>>
>>>> So we need something similar to BPF_KPTR_REF logic:
>>>> xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>>>> and then delay of uptr unpin for that address into call_rcu.
>>>>
>>>> Any better ideas?
>>>
>>
>> I think the existing reuse_now arg in the bpf_selem_free can be used. reuse_now
>> (renamed from the earlier use_trace_rcu) was added to avoid call_rcu_tasks_trace
>> for the common case.
>>
>> selem (in type "struct bpf_local_storage_elem") is the one exposed to the bpf prog.
>>
>> bpf_selem_free knows whether a selem can be reused immediately based on the
>> caller. It is currently flagged in the reuse_now arg: "bpf_selem_free(...., bool
>> reuse_now)".
>>
>> If a selem cannot be reuse_now (i.e. == false), it is currently going through
>> "call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu)". We can do
>> unpin_user_page() in the rcu callback.
>>
>> A selem can be reuse_now (i.e. == true) if the selem is no longer needed because
>> either its owner (i.e. the task_struct here) is going away in free_task() or the
>> bpf map is being destructed in bpf_local_storage_map_free(). No bpf prog should
>> have a hold on the selem at this point. I think for these two cases, the
>> unpin_user_page() can be directly called in bpf_selem_free().
> 
> but there is also this path:
> bpf_task_storage_delete -> task_storage_delete -> bpf_selem_free
>   -> bpf_obj_free_fields
> 
> In this case bpf prog may still be looking at uptr address
> and we cannot do unpin right away in bpf_obj_free_fields.

cannot unpin immediately in the bpf_task_storage_delete() path is understood. 
task_storage can be used in sleepable. It needs to wait for the tasks_trace and 
the regular rcu gp before unpin.

I forgot to mention earlier that bpf_task_storage_delete() will have the 
bpf_selem_free(..., reuse_now == false). It will then do the 
"call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);". The unpin could 
happen in bpf_selem_free_trace_rcu() in this case. I am suggesting to unpin in 
bpf_selem_free_trace_rcu together with the selem free.

I just noticed the map and its btf_record are gone in 
bpf_selem_free_trace_rcu()... so won't work. :(

> All other special fields in map value are ok,
> since they are either relying on bpf_mem_alloc and
> have rcu/rcu_tasks_trace gp
> or extra indirection like timer/wq.
> 
>> One existing bug is, from looking at patch 6, I don't think the free_task() case
>> can be "reuse_now == true" anymore because of the bpf_task_release kfunc did not
>> mark the previously obtained task_storage to be invalid:
>>
>> data_task = bpf_task_from_pid(parent_pid);
>> ptr = bpf_task_storage_get(&datamap, data_task, 0, ...);
>> bpf_task_release(data_task);
>> if (!ptr)
>>          return 0;
>> /* The prog still holds a valid task storage ptr. */
>> udata = ptr->udata;
>>
>> It can be fixed by marking the ref_obj_id of the "ptr". Although it is more
>> correct to make the task storage "ptr" invalid after task_release, it may break
>> the existing progs.
> 
> Are you suggesting that bpf_task_release should invalidate all pointers
> fetched from map value?

I was thinking at least the map value ptr itself needs to be invalidated.

> That will work, but it's not an issue for other special fields in there
> like kptr.
> So this invalidation would be need only for uptr which feels
> weird to special case it and probably will be confusing to users writing
> such programs.

hmm... I haven't thought about the other pointer fields that read before the 
task_release().

Agreed, it is hard to use if only marks uptr invalid. Thinking about it. Even 
marking the map value ptr invalid while other previously read fields keep 
working is also the same weirdness.

> Above bpf prog example should be ok to use.
> We only need to delay unpin after rcu/rcu_task_trace gp.
> Hence my proposal in bpf_obj_free_fields() do:
>   case UPTR:
>     xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>     call_rcu(...) to unpin.

Agree that call_rcu() here is the only option. It probably needs to go through 
the tasks_trace gp also.

Can the page->rcu_head be used here?

