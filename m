Return-Path: <bpf+bounces-79530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F2D3BD42
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8284F304B3FF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87771E487;
	Tue, 20 Jan 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdgV4ooa"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A221CC62
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873810; cv=none; b=XN48uTpa6rUMNzIUHhUFbMyW1xr0enSwwj8NqTLHwjtNHRSbK1JKR8b/kr9p0cigJha6dddnRB8mifPjwNKJXxNrrdHxHyNlKcUn7zEbn74IyhRyFrK8rEzde4tMfhufmy4rJJFpTOpDZODrVMP/E42tgY+V4fXWNv6vSLJeOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873810; c=relaxed/simple;
	bh=8fA+p/DEXJdaqbnOjZ3SqbgCV79ygUWjN600gP4WjAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeUIyTOfyKPF+QWnoWEC1bvfDJZdU9CHP2LaAqQ80g0lffp+FGw8Iw13+REF9aAiLCrPtTrF6CwFo0yMQxPBmc82v7LXAM6DkQ5lVejDzeEfO7fFINsRxK+EkpXtTZgOihjhKq2f4t8xx3J4iKnHyVuMxH/EPQTcPqxW5M9mRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdgV4ooa; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <123a63a2-5679-4bd0-9e16-dc5c7dbe3325@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768873805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBN9dYNpcV59lPN9f96cLskaAgq0uhPL5VTZQxR1SyE=;
	b=WdgV4ooaqq4OMNi62m02mgCFSdC3pqkc6NzjlD3vaX90F/03zANPBLs90tNrDGUFL5TPHY
	EdbcsckMgG0zlwekEgXTqd4PzSlzuAwHbH14GzYQwdGWK+nj1RN9yxPyguN04EUdwCSPzN
	sXMKM3aZzhgTHh4R4Ktmm1xTyIfddEc=
Date: Tue, 20 Jan 2026 09:49:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20260119142120.28170-1-leon.hwang@linux.dev>
 <20260119142120.28170-3-leon.hwang@linux.dev>
 <d4b8843b-c5dc-4468-996a-bacc2db63f11@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <d4b8843b-c5dc-4468-996a-bacc2db63f11@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 20/1/26 03:47, Daniel Borkmann wrote:
> On 1/19/26 3:21 PM, Leon Hwang wrote:
>> Switch the free-node pop paths to raw_spin_trylock*() to avoid blocking
>> on contended LRU locks.
>>
>> If the global or per-CPU LRU lock is unavailable, refuse to refill the
>> local free list and return NULL instead. This allows callers to back
>> off safely rather than blocking or re-entering the same lock context.
>>
>> This change avoids lockdep warnings and potential deadlocks caused by
>> re-entrant LRU lock acquisition from NMI context, as shown below:
>>
>> [  418.260323] bpf_testmod: oh no, recursing into test_1,
>> recursion_misses 1
>> [  424.982207] ================================
>> [  424.982216] WARNING: inconsistent lock state
>> [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> [  424.982314]  *** DEADLOCK ***
>> [...]
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>   kernel/bpf/bpf_lru_list.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> Documentation/bpf/map_lru_hash_update.dot needs update?
> 

Yes, it needs update.

>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index c091f3232cc5..03d37f72731a 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -312,14 +312,15 @@ static void bpf_lru_list_push_free(struct
>> bpf_lru_list *l,
>>       raw_spin_unlock_irqrestore(&l->lock, flags);
>>   }
>>   -static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>> +static bool bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>>                          struct bpf_lru_locallist *loc_l)
>>   {
>>       struct bpf_lru_list *l = &lru->common_lru.lru_list;
>>       struct bpf_lru_node *node, *tmp_node;
>>       unsigned int nfree = 0;
>>   -    raw_spin_lock(&l->lock);
>> +    if (!raw_spin_trylock(&l->lock))
>> +        return false;
>>   
> 
> Could you provide some more analysis, and the effect this has on real-world
> programs? Presumably they'll unexpectedly encounter a lot more frequent
> -ENOMEM as an error on bpf_map_update_elem even though memory might be
> available just that locks are contended?
> 
> Also, have you considered rqspinlock as a potential candidate to discover
> deadlocks?

Thanks for the questions.

While I haven’t encountered this issue in production systems myself, the
deadlock has been observed repeatedly in practice, including the cases
shown in the cover letter. It can also be reproduced reliably when
running the LRU tests locally, so this is a real and recurring problem.

I agree that returning -ENOMEM when locks are contended is not ideal.
Using -EBUSY would better reflect the situation where memory is
available but forward progress is temporarily blocked by lock
contention. I can update the patch accordingly.

Regarding rqspinlock: as mentioned in the cover letter, Menglong
previously explored using rqspinlock to address these deadlocks but was
unable to arrive at a complete solution. After further off-list
discussion, we agreed that using trylock is a more practical approach
here. In most observed cases, the lock contention leading to deadlock
occurs in bpf_common_lru_pop_free(), and trylock allows callers to back
off safely rather than risking re-entrancy and deadlock.

Thanks,
Leon


