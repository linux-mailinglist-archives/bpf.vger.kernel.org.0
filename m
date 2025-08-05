Return-Path: <bpf+bounces-65092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AFB1BCF3
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CCC7A7361
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A02BD5BF;
	Tue,  5 Aug 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VaXQDd5e"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E83291C1B
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435439; cv=none; b=Em0GiQebLdQ8foDzgKx4AogQ8bTxrJrpPg2MH7Sam2IXsogH41Qt1ilSxDTAafg9p0x1iURhCD7qh7EiobBvgcXN4Ca4PsJeurFk70RpyCyCoaYq+NAAon995vzNDSPOF3/KTfex1jPefTEnt/uOVy3DAAArTwjUhdVtXedSKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435439; c=relaxed/simple;
	bh=q+lf+wIEzhD1CnqUF9aNVgDF5NSS2wF12RZ2Vwn7SKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNgXJ3WKTBy25a6KuWELm3+e32odFUd67yowzI+8P03jXwIgWlILzaerfu8naCnaXz2VLKAOuYWv9VcORN314JxQ70Fh3IXdl9gFx+Lff782cM90oo43Eh+D+KAMfWubeNnIyKj7jXzCUNzZTAtfDPtdz/NZ32/dt7uhB7IMEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VaXQDd5e; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55ca60f3-3841-4f6a-b757-04d52ca1f1a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754435425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXS9M9tLTrOh7Vu7Aey6v9pB9TB1Oupb8W0EUzmhulY=;
	b=VaXQDd5eG/b2BT1JAh5MjQhQFZiGkMhuETUUAUWPiiwVMh5b5jlNOnuLmm+ErMTwCFDVaS
	Z3F1kjSLpNHkYPJYX7S94AQhQAGxnLFVL8aq+pjS3IE+VMkOHqeCZaq53Kv8uUydvBM/BV
	lRSZu4dGYfMXvNEGcMJwbCjqlkmsZm4=
Date: Tue, 5 Aug 2025 16:10:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Open code
 bpf_selem_unlink_storage in bpf_selem_unlink
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, kpsingh@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20250729182550.185356-1-ameryhung@gmail.com>
 <20250729182550.185356-4-ameryhung@gmail.com>
 <8e21c788-5187-4fee-baec-22b8e80be383@linux.dev>
 <CAMB2axPTU+HsJ_6nKDaq8xnGhcoXZCgy=X2wiODYNbZMdRkSHg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axPTU+HsJ_6nKDaq8xnGhcoXZCgy=X2wiODYNbZMdRkSHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 9:25 AM, Amery Hung wrote:
> On Fri, Aug 1, 2025 at 5:58 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 7/29/25 11:25 AM, Amery Hung wrote:
>>>    void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>>>    {
>>> +     struct bpf_local_storage_map *storage_smap;
>>> +     struct bpf_local_storage *local_storage = NULL;
>>> +     bool bpf_ma, free_local_storage = false;
>>> +     HLIST_HEAD(selem_free_list);
>>>        struct bpf_local_storage_map_bucket *b;
>>> -     struct bpf_local_storage_map *smap;
>>> -     unsigned long flags;
>>> +     struct bpf_local_storage_map *smap = NULL;
>>> +     unsigned long flags, b_flags;
>>>
>>>        if (likely(selem_linked_to_map_lockless(selem))) {
>>
>> Can we simplify the bpf_selem_unlink() function by skipping this map_lockless
>> check,
>>
>>>                smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
>>>                b = select_bucket(smap, selem);
>>> -             raw_spin_lock_irqsave(&b->lock, flags);
>>> +     }
>>>
>>> -             /* Always unlink from map before unlinking from local_storage
>>> -              * because selem will be freed after successfully unlinked from
>>> -              * the local_storage.
>>> -              */
>>> -             bpf_selem_unlink_map_nolock(selem);
>>> -             raw_spin_unlock_irqrestore(&b->lock, flags);
>>> +     if (likely(selem_linked_to_storage_lockless(selem))) {
>>
>> only depends on this and then proceed to take the lock_storage->lock. Then
>> recheck selem_linked_to_storage(selem), bpf_selem_unlink_map(selem) first, and
>> then bpf_selem_unlink_storage_nolock(selem) last.
> 
> Thanks for the suggestion. I think it will simplify the function. Just
> making sure I am getting you right, you mean instead of open code both
> unlink_map and unlink_storage, only open code unlink_storage. First,
> grab local_storage->lock and call bpf_selem_unlink_map(). Then, only

After grabbing the local-storage->lock, re-check selem_linked_to_storage() first 
before calling bpf_selem_unlink_map().

> proceed to unlink_storage only If bpf_selem_unlink_map() succeeds.

No strong opinion on open coding bpf_selem_unlink_map() or not. I think they are 
the same. I reuse the bpf_selem_unlink_map() because I think it can be used as 
is. The logic of bpf_selem_unlink() here should be very similar to the 
bpf_local_storage_destroy() now except it needs to recheck the 
selem_linked_to_storage():

1. grab both locks.
2. If selem_linked_to_storage() is true, the selem_linked_to_map() should also 
be true since we now need to grab both locks before moving forward to unlink. 
Meaning either a selem will not be unlinked at all or it will be unlinked from 
both local_storage and map. Am I thinking it correctly or there is hole?

> 
>>
>> Then bpf_selem_unlink_map can use selem->local_storage->owner to select_bucket().
> 
> Not sure what this part mean. Could you elaborate?

I meant to pass owner pointer to select_bucket, like
select_bucket(smap, selem->local_storage->owner). Of course, the owner pointer 
should also be used on the update side also, i.e. bpf_local_storage_update().
Then it does not need to take the second bucket lock when "if (b != old_b)" in 
the bpf_local_storage_update() in patch 1.

> 
>>
>>> +             local_storage = rcu_dereference_check(selem->local_storage,
>>> +                                                   bpf_rcu_lock_held());
>>> +             storage_smap = rcu_dereference_check(local_storage->smap,
>>> +                                                  bpf_rcu_lock_held());
>>> +             bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
>>>        }
>>>
>>> -     bpf_selem_unlink_storage(selem, reuse_now);
>>> +     if (local_storage)
>>> +             raw_spin_lock_irqsave(&local_storage->lock, flags);
>>> +     if (smap)
>>> +             raw_spin_lock_irqsave(&b->lock, b_flags);
>>> +
>>> +     /* Always unlink from map before unlinking from local_storage
>>> +      * because selem will be freed after successfully unlinked from
>>> +      * the local_storage.
>>> +      */
>>> +     if (smap)

This "if (smap)" test

>>> +             bpf_selem_unlink_map_nolock(selem);
>>> +     if (local_storage && likely(selem_linked_to_storage(selem)))

and this orthogonal "if (local_storage && 
likely(selem_linked_to_storage(selem)))" test.

Understood it is from the existing codes that unlink from map and unlink from 
local_storage can be done independently. It was there because it did not need to 
grab both locks to move forward. Since now it needs both locks, I think we can 
simplify things a bit like mentioned above.


>>> +             free_local_storage = bpf_selem_unlink_storage_nolock(
>>> +                     local_storage, selem, true, &selem_free_list);
>>> +
>>> +     if (smap)
>>> +             raw_spin_unlock_irqrestore(&b->lock, b_flags);
>>> +     if (local_storage)
>>> +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>> +
>>> +     bpf_selem_free_list(&selem_free_list, reuse_now);
>>> +
>>> +     if (free_local_storage)
>>> +             bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
>>>    }
>>>
>>>    void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
>>


