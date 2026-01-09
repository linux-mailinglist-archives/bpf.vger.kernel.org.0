Return-Path: <bpf+bounces-78403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06670D0C57D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FECA304A8EB
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FD2741C0;
	Fri,  9 Jan 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqWMz75s"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E833CEB7
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994706; cv=none; b=WeXFDmDmk8SYsNhf6PPelFrIPXi82yGvb59jLc7MpUYhZgSSy4HYbnE/QjG4AC9S5GPY5zczRgMsBfl9H21E+oC5Ol+uKU6I0oWhsRw40UWDGroi71kbctvPZC4Q+Dsd2AiYkozsKLJtZsFKV6i/chD3sUI24EthP4M81C4IUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994706; c=relaxed/simple;
	bh=Zq9zJXKLJPXPWtoyiL5ECWhSa7wOxf3VJW4byl7o7UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJpLT1WihMOUPE4J4hqTDY1BctZ53yACizRDg1R+VHYXW4yqt5mHGUyzF88vmHvhAzcL7YYj0CXerhODHz/jASDmqV1zQFlIVq7nW4rOPm7qnjNBcS0o4yoDP8Bi32b7XB51S7Q4tUDN+vvn4gAt0grTBw9YlDzXU92BNNKuObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqWMz75s; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36b3dc2d-b850-491f-bfc5-3581d5de7b82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767994701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpfqvsEfjJXKuy5vrCNfclWnENU8mVeyg0n1KjAkwZw=;
	b=JqWMz75sWahNIUp4zRkHSzrYzOVG7YYBGsjT3+ypJUQMaIlLnd+m1Y5BN3Fx4mdZpRp16E
	npX+Ti+KvCMYJz8fr0Xuj96aTprXjE+vzjrHplayuovMcUUBCj5bR/m5YU61y2pBmtoR2n
	uSu/S/9cD4FvHJ2W/zoEjGS6mBvJCVE=
Date: Fri, 9 Jan 2026 13:38:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-11-ameryhung@gmail.com>
 <337d8ebe-d3d4-4818-92d8-4937da835843@linux.dev>
 <CAMB2axNcc5yJwhXjcEcQJuLxrjB7MgVK6XXpKqO9EiFPtQH6bQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNcc5yJwhXjcEcQJuLxrjB7MgVK6XXpKqO9EiFPtQH6bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/9/26 12:47 PM, Amery Hung wrote:
> On Fri, Jan 9, 2026 at 12:16 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 12/18/25 9:56 AM, Amery Hung wrote:
>>> Introduce bpf_selem_unlink_lockless() to properly handle errors returned
>>> from rqspinlock in bpf_local_storage_map_free() and
>>> bpf_local_storage_destroy() where the operation must succeeds.
>>>
>>> The idea of bpf_selem_unlink_lockless() is to allow an selem to be
>>> partially linked and use refcount to determine when and who can free the
>>> selem. An selem initially is fully linked to a map and a local storage
>>> and therefore selem->link_cnt is set to 2. Under normal circumstances,
>>> bpf_selem_unlink_lockless() will be able to grab locks and unlink
>>> an selem from map and local storage in sequeunce, just like
>>> bpf_selem_unlink(), and then add it to a local tofree list provide by
>>> the caller. However, if any of the lock attempts fails, it will
>>> only clear SDATA(selem)->smap or selem->local_storage depending on the
>>> caller and decrement link_cnt to signal that the corresponding data
>>> structure holding a reference to the selem is gone. Then, only when both
>>> map and local storage are gone, an selem can be free by the last caller
>>> that turns link_cnt to 0.
>>>
>>> To make sure bpf_obj_free_fields() is done only once and when map is
>>> still present, it is called when unlinking an selem from b->list under
>>> b->lock.
>>>
>>> To make sure uncharging memory is only done once and when owner is still
>>> present, only unlink selem from local_storage->list in
>>> bpf_local_storage_destroy() and return the amount of memory to uncharge
>>> to the caller (i.e., owner) since the map associated with an selem may
>>> already be gone and map->ops->map_local_storage_uncharge can no longer
>>> be referenced.
>>>
>>> Finally, access of selem, SDATA(selem)->smap and selem->local_storage
>>> are racy. Callers will protect these fields with RCU.
>>>
>>> Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
>>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>>> Signed-off-by: Amery Hung <ameryhung@gmail.com>
>>> ---
>>>    include/linux/bpf_local_storage.h |  2 +-
>>>    kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++++--
>>>    2 files changed, 74 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>>> index 20918c31b7e5..1fd908c44fb6 100644
>>> --- a/include/linux/bpf_local_storage.h
>>> +++ b/include/linux/bpf_local_storage.h
>>> @@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
>>>                                                 * after raw_spin_unlock
>>>                                                 */
>>>        };
>>> +     atomic_t link_cnt;
>>>        u16 size;
>>>        bool use_kmalloc_nolock;
>>> -     /* 4 bytes hole */
>>>        /* The data is stored in another cacheline to minimize
>>>         * the number of cachelines access during a cache hit.
>>>         */
>>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>>> index 62201552dca6..4c682d5aef7f 100644
>>> --- a/kernel/bpf/bpf_local_storage.c
>>> +++ b/kernel/bpf/bpf_local_storage.c
>>> @@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>>>                        if (swap_uptrs)
>>>                                bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
>>>                }
>>> +             atomic_set(&selem->link_cnt, 2);
>>>                selem->size = smap->elem_size;
>>>                selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
>>>                return selem;
>>> @@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>>>        /* The bpf_local_storage_map_free will wait for rcu_barrier */
>>>        smap = rcu_dereference_check(SDATA(selem)->smap, 1);
>>>
>>> -     migrate_disable();
>>> -     bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>> -     migrate_enable();
>>> +     if (smap) {
>>> +             migrate_disable();
>>> +             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>> +             migrate_enable();
>>> +     }
>>>        kfree_nolock(selem);
>>>    }
>>>
>>> @@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
>>>                 * is only supported in task local storage, where
>>>                 * smap->use_kmalloc_nolock == true.
>>>                 */
>>> -             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>> +             if (smap)
>>> +                     bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>>                __bpf_selem_free(selem, reuse_now);
>>>                return;
>>>        }
>>> @@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>>>        return err;
>>>    }
>>>
>>> +/* Callers of bpf_selem_unlink_lockless() */
>>> +#define BPF_LOCAL_STORAGE_MAP_FREE   0
>>> +#define BPF_LOCAL_STORAGE_DESTROY    1
>>> +
>>> +/*
>>> + * Unlink an selem from map and local storage with lockless fallback if callers
>>> + * are racing or rqspinlock returns error. It should only be called by
>>> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
>>> + */
>>> +static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem *selem,
>>> +                                   struct hlist_head *to_free, int caller)
>>> +{
>>> +     struct bpf_local_storage *local_storage;
>>> +     struct bpf_local_storage_map_bucket *b;
>>> +     struct bpf_local_storage_map *smap;
>>> +     unsigned long flags;
>>> +     int err, unlink = 0;
>>> +
>>> +     local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
>>> +     smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
>>> +
>>> +     /*
>>> +      * Free special fields immediately as SDATA(selem)->smap will be cleared.
>>> +      * No BPF program should be reading the selem.
>>> +      */
>>> +     if (smap) {
>>> +             b = select_bucket(smap, selem);
>>> +             err = raw_res_spin_lock_irqsave(&b->lock, flags);
>>> +             if (!err) {
>>> +                     if (likely(selem_linked_to_map(selem))) {
>>> +                             hlist_del_init_rcu(&selem->map_node);
>>> +                             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>> +                             RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
>>> +                             unlink++;
>>> +                     }
>>> +                     raw_res_spin_unlock_irqrestore(&b->lock, flags);
>>> +             } else if (caller == BPF_LOCAL_STORAGE_MAP_FREE) {
>>> +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
>>
>> I suspect I am missing something obvious, so it will be faster to ask here.
>>
>> I could see why init NULL can work if it could assume the map_free
>> caller always succeeds in the b->lock, the "if (!err)" path above.
>>
>> If the b->lock did fail here for the map_free caller, it reset
>> SDATA(selem)->smap to NULL here. Who can do the bpf_obj_free_fields() in
>> the future?
> 
> I think this can only mean destroy() is holding the lock, and
> destroy() should do bpf_selem_unlink_map_nolock(). Though I am not

hmm... instead of bpf_selem_unlink_map_nolock(), do you mean the "if 
(!err)" path in this bpf_selem_unlink_lockless() function? or we are 
talking different things?

[ btw, a nit, I think it can use a better function name instead of 
"lockless". This function still takes the lock if it can. ]

> sure how destroy() can hold b->lock in a way that causes map_free() to
> fail acquiring b->lock.

I recall ETIMEDOUT was mentioned to be the likely (only?) case here. 
Assume the b->lock did fail in map_free here, there are >1 selem(s) 
using the same b->lock. Is it always true that the selem that failed at 
the b->lock in map_free() here must race with the very same selem in 
destroy()?

> 
>>
>>> +             }
>>> +     }
>>> +
>>> +     /*
>>> +      * Only let destroy() unlink from local_storage->list and do mem_uncharge
>>> +      * as owner is guaranteed to be valid in destroy().
>>> +      */
>>> +     if (local_storage && caller == BPF_LOCAL_STORAGE_DESTROY) {
>>
>> If I read here correctly, only bpf_local_storage_destroy() can do the
>> bpf_selem_free(). For example, if a bpf_sk_storage_map is going away,
>> the selem (which is memcg charged) will stay in the sk until the sk is
>> closed?
> 
> You read it correctly and Yes there will be stale elements in
> local_storage->list.
> 
> I would hope the unlink from local_storage part is doable from
> map_free() and destroy(), but it is hard to guarantee (1) mem_uncharge
> is done only once (2) while the owner is still valid in a lockless
> way.

This needs to be addressed. It cannot leave the selem lingering. At 
least the selem should be freed for the common case (i.e., succeeds in 
both locks). Lingering selem is ok in case of lock failure. Many sk can 
be long-lived connections. The user space may want to recreate the map, 
and it will be limited by the memcg.

> 
>>
>>> +             err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
>>> +             if (!err) {
>>> +                     hlist_del_init_rcu(&selem->snode);
>>> +                     unlink++;
>>> +                     raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
>>> +             }
>>> +             RCU_INIT_POINTER(selem->local_storage, NULL);
>>> +     }
>>> +
>>> +     /*
>>> +      * Normally, an selem can be unlink under local_storage->lock and b->lock, and
>>> +      * then added to a local to_free list. However, if destroy() and map_free() are
>>> +      * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
>>> +      * the selem only after both map_free() and destroy() drop the refcnt.
>>> +      */
>>> +     if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
>>> +             hlist_add_head(&selem->free_node, to_free);
>>> +}
>>> +
>>>    void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
>>>                                      struct bpf_local_storage_map *smap,
>>>                                      struct bpf_local_storage_elem *selem)
>>


