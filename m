Return-Path: <bpf+bounces-77326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF8CD75F3
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638B03099456
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A534847A;
	Mon, 22 Dec 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SP2Il+Mb"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED26347FD2
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442254; cv=none; b=OX8OlTyYlAKboO5q9Z+EhjTup4V+auszDBvYorz0mD3GPg1tNP6HTphNUmP4sfh2OqFgAYGfZ6i9B+lv59Wm4TqBcMoKMwaInLwWo/iUlXQGrO++KEm384prWSb+8iBMdh00W9Kp7yVoHYQAidDeWoQlhf+EkLprk+Szte/pirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442254; c=relaxed/simple;
	bh=sDGOKjk4tQ6yPX+y9qtvLBKcCSDZi1rgahvTbPC08Ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGsn6RfhLzr86TRqTSr2/SXmh4+TIFuIH6zL9JUOlkRabYL1ny6N5m4i+5nS4AR55th1hg0q1ABhGE51F9JIWrw12ABbN6EYjR+FVBnbg0w8EqEbgXdOQBowb5nFn59mXD6oyiH9Gl97OfgiBHcU/s0pkB08RiAQxX+MNWZLsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SP2Il+Mb; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766442250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ5Rz7oks9BsiGW+7NF3TEgOyoDBKE6fPRGPHx1O1TY=;
	b=SP2Il+Mbb70Adf+Z5FyVVrTiglt2NEwPGCTriW/yeE63WhdsAFfs3dsnS6tzKSB+rR1w7C
	6QGbctyDfdEHLjbcp2ZFm4KaG309gb0sK884rQvEXGeHbRwI91iGdiZ7TsgXhAo8b0ek8q
	HSZMBZm2gA+JPqcu4x+j5E/T5qI8N+I=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chris Mason <clm@meta.com>
Cc: bot+bpf-ci@kernel.org,  bpf@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  inwardvessel@gmail.com,  ast@kernel.org,
  daniel@iogearbox.net,  shakeel.butt@linux.dev,  mhocko@kernel.org,
  hannes@cmpxchg.org,  andrii@kernel.org,  martin.lau@kernel.org,
  eddyz87@gmail.com,  yonghong.song@linux.dev,  ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access
 memory events
In-Reply-To: <93dbca4e-bd58-4b9a-a3c6-595810727121@meta.com> (Chris Mason's
	message of "Sat, 20 Dec 2025 14:59:56 -0500")
References: <20251220041250.372179-6-roman.gushchin@linux.dev>
	<8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
	<87a4zdepdh.fsf@linux.dev>
	<dfc73fd6-9e5f-4b62-ac3f-7c9a327dd7fc@meta.com>
	<87zf7d6ll1.fsf@linux.dev>
	<93dbca4e-bd58-4b9a-a3c6-595810727121@meta.com>
Date: Mon, 22 Dec 2025 14:23:59 -0800
Message-ID: <87pl862m0w.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Chris Mason <clm@meta.com> writes:

> On 12/20/25 1:43 PM, Roman Gushchin wrote:
>> Chris Mason <clm@meta.com> writes:
>> 
>>> On 12/19/25 11:41 PM, Roman Gushchin wrote:
>>>> bot+bpf-ci@kernel.org writes:
>>>>
>>>>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>>>>> index d84fe6f3ed43..858eb43766ce 100644
>>>>>> --- a/mm/bpf_memcontrol.c
>>>>>> +++ b/mm/bpf_memcontrol.c
>>>>>> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>>>>>>  	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>>>>>>  }
>>>>>>
>>>>>> +/**
>>>>>> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
>>>>>> + * @memcg: memory cgroup
>>>>>> + * @event: memory event id
>>>>>> + *
>>>>>> + * Returns current memory event count.
>>>>>> + */
>>>>>> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
>>>>>> +						enum memcg_memory_event event)
>>>>>> +{
>>>>>> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
>>>>>> +		return (unsigned long)-1;
>>>>>
>>>>> Should this also check for negative values?  The enum type is typically
>>>>> signed, so a BPF program passing a negative event value would pass this
>>>>> check but cause an out-of-bounds read from memcg->memory_events[].
>>>>>
>>>>> The similar bpf_mem_cgroup_page_state() in this same file uses:
>>>>>
>>>>>     if (idx < 0 || idx >= MEMCG_NR_STAT)
>>>>>
>>>>> which checks both bounds.  Could the check here be changed to:
>>>>>
>>>>>     if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)
>>>>>
>>>>> to match that pattern?
>>>>
>>>> No, the bpf verifier enforces event > 0.
>>>> It's a false positive.
>>>
>>> I'll add some words here to the bpf prompts, thanks Roman.
>> 
>> I'll try to play with it too, hopefully we can fix it.
>> 
>
> https://github.com/masoncl/review-prompts/commit/fcc3bf704798f6be64cbb2e28b05a5c91eee9c7b

Hi Chris!

I'm sorry, apparently I was dead wrong and overestimated the bpf
verifier  (and ai was correct, lol). Somebody told me that enums
are fully covered as a feedback to an earlier version and I didn't
check.

In reality the verifier doesn't guarantee the correctness of the value
passed as an enum, only that it's a u32. So we need to check the value.
I've added necessarily checks in v3 of my patchset. It passes the local
ai review without your latest change. Please, revert it.

Thanks and sorry for the hassle

