Return-Path: <bpf+bounces-77258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB4CD3521
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B233300FFA3
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C425A659;
	Sat, 20 Dec 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cvY49sZh"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DD79CD
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256205; cv=none; b=K4rA3PgzoPBl8gsib3x/BNWn5M+GhtzjGdXMW08lmvweJ0FZWokZvc986nv4m3djjcgKm1f+f6Jo410Tln4y/Bz0/V17eaD3I9VSyGGk4NNUAf6F6xRPkKlw4PRKnz/zTVQSg0Lfo4PnJ5eCw0vCRIxZ+gZh4mVF0D1/N9leVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256205; c=relaxed/simple;
	bh=qLMoCZzDHq+lpkensD//BBQka4QYKimeESFIDvZTPLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I939Bwk6sz15nHnshz9gJJbxHzPbLqNhLOTIJ63ccbAA46hftKUqDcVVQPz90eSNuLADFc08D01w/4HZbi+IzfyVihXMhv2SlU4S1HcKRTlSCGE5lSuiULgYgw+ve6zg0TdQ17ZXXBYEsEEuNuhbanFNWPuQS8GZUCqA7ZmlM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cvY49sZh; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766256196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYcEDFt+reXAq8S6HjO2WYSFnT1e9O506FR9izTfXYg=;
	b=cvY49sZhS6fWeTI911eazXNzrmFdqSxRKUzbVC0iI+/hbUFYPVRLxBYhV+omoSJ4qYGCGd
	T+J+0lOp1MAZbo63six8tvYdFFeqPoxqKxXKCktKgUNxOmiWZSya9Uh9GF3Tdw2JMpv5Ie
	jjF8ZEi7Y1sfl8nGmdDUXOqELd/STkA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chris Mason <clm@meta.com>
Cc: bot+bpf-ci@kernel.org,  bpf@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  inwardvessel@gmail.com,  ast@kernel.org,
  daniel@iogearbox.net,  shakeel.butt@linux.dev,  mhocko@kernel.org,
  hannes@cmpxchg.org,  andrii@kernel.org,  martin.lau@kernel.org,
  eddyz87@gmail.com,  yonghong.song@linux.dev,  ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access
 memory events
In-Reply-To: <dfc73fd6-9e5f-4b62-ac3f-7c9a327dd7fc@meta.com> (Chris Mason's
	message of "Sat, 20 Dec 2025 08:19:48 -0500")
References: <20251220041250.372179-6-roman.gushchin@linux.dev>
	<8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
	<87a4zdepdh.fsf@linux.dev>
	<dfc73fd6-9e5f-4b62-ac3f-7c9a327dd7fc@meta.com>
Date: Sat, 20 Dec 2025 10:43:06 -0800
Message-ID: <87zf7d6ll1.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Chris Mason <clm@meta.com> writes:

> On 12/19/25 11:41 PM, Roman Gushchin wrote:
>> bot+bpf-ci@kernel.org writes:
>> 
>>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>>> index d84fe6f3ed43..858eb43766ce 100644
>>>> --- a/mm/bpf_memcontrol.c
>>>> +++ b/mm/bpf_memcontrol.c
>>>> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>>>>  	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>>>>  }
>>>>
>>>> +/**
>>>> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
>>>> + * @memcg: memory cgroup
>>>> + * @event: memory event id
>>>> + *
>>>> + * Returns current memory event count.
>>>> + */
>>>> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
>>>> +						enum memcg_memory_event event)
>>>> +{
>>>> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
>>>> +		return (unsigned long)-1;
>>>
>>> Should this also check for negative values?  The enum type is typically
>>> signed, so a BPF program passing a negative event value would pass this
>>> check but cause an out-of-bounds read from memcg->memory_events[].
>>>
>>> The similar bpf_mem_cgroup_page_state() in this same file uses:
>>>
>>>     if (idx < 0 || idx >= MEMCG_NR_STAT)
>>>
>>> which checks both bounds.  Could the check here be changed to:
>>>
>>>     if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)
>>>
>>> to match that pattern?
>> 
>> No, the bpf verifier enforces event > 0.
>> It's a false positive.
>
> I'll add some words here to the bpf prompts, thanks Roman.

I'll try to play with it too, hopefully we can fix it.

Thanks!

