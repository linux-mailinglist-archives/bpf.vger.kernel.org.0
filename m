Return-Path: <bpf+bounces-39157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045196FC90
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26194289223
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05BA1D5CF2;
	Fri,  6 Sep 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dZ5j9eRh"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1751D5CDB
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653521; cv=none; b=gHEeSOQUyBzHIEwAYbPZOnR5yH4syRsMtQN5ybd0JwtbRL2HXO0a4+dhtxLqQfThey0kD0z9cQ53eYHcvvwbb33ilKxgj4HJm5vXDbYmG8g66GEs8RydwiSIk57vC1LkkBk/jkUfG/jJE+fMBnbFX06nsTMcnVxNZANcN4evdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653521; c=relaxed/simple;
	bh=8QBwHWPseHn9+R2gvNxdlsmVdJbXAJn9wHA08sxPA0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YDrPyPmh5Jy9s+UDMXyPX/Lb7+LysGyM5UMDDy59EY5O5pFgVyXKefEiiRspqMwWKfUdcgcdWqT1X0bAmf0lfG40+wvr01VmCrrfrR3w0L7tw8bTD6jW8MlfeiYFYJZ8C632JhhBL23sfWhL1h04xGsgTAY6WCzM8c4oHr2q6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dZ5j9eRh; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f84e4a86-976a-4fd2-94e7-8026dc3ae56e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725653517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhhhpzp5I00d7lFzLvbJIXA1AyZbtxT5pcsvaV59gg0=;
	b=dZ5j9eRhml/hXYrJ+CWC/TEXyOmLVGVXzbeAoAZVZC6yTch7lMKt2sD9TWkQjDtMWX/bKB
	8oJcONqKzITjVzbEPtGZ+csVqoa1JkvWqMOQ5K1UE4BDbT83sAxG7UQz3GUF9AZVKifKov
	1RfrlvTrZ6Nk2NWXWR6uhn0FXJoaUCk=
Date: Fri, 6 Sep 2024 13:11:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from
 syscalls.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <sinquersw@gmail.com>, linux-mm <linux-mm@kvack.org>
References: <20240816191213.35573-1-thinker.li@gmail.com>
 <20240816191213.35573-5-thinker.li@gmail.com>
 <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
 <70a1b24f-84cd-464c-8fb6-a2c52fd3d703@linux.dev>
Content-Language: en-US
In-Reply-To: <70a1b24f-84cd-464c-8fb6-a2c52fd3d703@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 3:21 PM, Martin KaFai Lau wrote:
> On 8/28/24 4:24 PM, Alexei Starovoitov wrote:
>>> @@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, 
>>> void *obj)
>>>                                  field->kptr.dtor(xchgd_field);
>>>                          }
>>>                          break;
>>> +               case BPF_UPTR:
>>> +                       if (*(void **)field_ptr)
>>> +                               bpf_obj_unpin_uptr(field, *(void **)field_ptr);
>>> +                       *(void **)field_ptr = NULL;
>> This one will be called from
>>   task_storage_delete->bpf_selem_free->bpf_obj_free_fields
>>
>> and even if upin was safe to do from that context
>> we cannot just do:
>> *(void **)field_ptr = NULL;
>>
>> since bpf prog might be running in parallel,
>> it could have just read that addr and now is using it.
>>
>> The first thought of a way to fix this was to split
>> bpf_obj_free_fields() into the current one plus
>> bpf_obj_free_fields_after_gp()
>> that will do the above unpin bit.
>> and call the later one from bpf_selem_free_rcu()
>> while bpf_obj_free_fields() from bpf_selem_free()
>> will not touch uptr.
>>
>> But after digging further I realized that task_storage
>> already switched to use bpf_ma, so the above won't work.
>>
>> So we need something similar to BPF_KPTR_REF logic:
>> xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>> and then delay of uptr unpin for that address into call_rcu.
>>
>> Any better ideas?
> 

I think the existing reuse_now arg in the bpf_selem_free can be used. reuse_now 
(renamed from the earlier use_trace_rcu) was added to avoid call_rcu_tasks_trace 
for the common case.

selem (in type "struct bpf_local_storage_elem") is the one exposed to the bpf prog.

bpf_selem_free knows whether a selem can be reused immediately based on the 
caller. It is currently flagged in the reuse_now arg: "bpf_selem_free(...., bool 
reuse_now)".

If a selem cannot be reuse_now (i.e. == false), it is currently going through 
"call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu)". We can do 
unpin_user_page() in the rcu callback.

A selem can be reuse_now (i.e. == true) if the selem is no longer needed because 
either its owner (i.e. the task_struct here) is going away in free_task() or the 
bpf map is being destructed in bpf_local_storage_map_free(). No bpf prog should 
have a hold on the selem at this point. I think for these two cases, the 
unpin_user_page() can be directly called in bpf_selem_free().

One existing bug is, from looking at patch 6, I don't think the free_task() case 
can be "reuse_now == true" anymore because of the bpf_task_release kfunc did not 
mark the previously obtained task_storage to be invalid:

data_task = bpf_task_from_pid(parent_pid);
ptr = bpf_task_storage_get(&datamap, data_task, 0, ...);
bpf_task_release(data_task);
if (!ptr)
	return 0;
/* The prog still holds a valid task storage ptr. */
udata = ptr->udata;

It can be fixed by marking the ref_obj_id of the "ptr". Although it is more 
correct to make the task storage "ptr" invalid after task_release, it may break 
the existing progs.

The same issue probably is true for cgroup_storage. There is no release kfunc 
for inode and sk, so inode and sk storage should be fine.


