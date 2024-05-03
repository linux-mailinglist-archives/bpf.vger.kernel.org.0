Return-Path: <bpf+bounces-28524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439878BB196
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A01F228D1
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE664157E7D;
	Fri,  3 May 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4jgoOlp"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFB157A74
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756684; cv=none; b=ccsmxvB7FHlkGF7GVimHg/aDeS+iBe9U00PZxW53zmemYebKm94+/2A1SBTGBnPbStD/7D/aDoJk5QkP4qywVVgYNBHI1x8FzaJRrTjJ9lofHj/7GcX6vUqCxuH0uR7RdycS+U7MfxRr3I2Sp/r3p6EGrQ08dNUhv5r6UaxQWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756684; c=relaxed/simple;
	bh=+YXSGA9DR04qVEF6seUzGHlY0Jkcb002FUWskB/gqlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB6DRUcjAEOEeiq+LmutNALadsurmk+qMn0uBMC+d+51e79/+KSWxvKSQsduzBu6CGSbAw6x2JyTK9dN79siLbA/DS6XM0nyaZYvHhGTryfts302OyMUxMgtNKkK0S+KxHYMvxXQW1c+K36GF6oG4mRsihcWXfWHYqyJgBkn0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4jgoOlp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19c6fe1e-9afb-440f-811d-fb6a921df677@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714756680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGOgCy3jGJleD7d+R7gLjNDA+7CUBXM0VKnDUlS7QDo=;
	b=F4jgoOlpWHboePyNiHbS+BVIFGl8gJqz1v3haFaJT6FWwdBOqrVPDnw6JQ2quTnrFmKRfS
	BqTYQ1OchApQx18L6v+ldMQNUrzBviJ3PB9PqDUniJlE35S4BanD76tQVBd2ZxkZQzi1g7
	EgEKmp6GMShb8rx90Z4UdjAmcqyHELU=
Date: Fri, 3 May 2024 10:17:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
 <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
 <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/2/24 5:41 PM, Kui-Feng Lee wrote:
> 
> 
> On 5/2/24 10:56, Martin KaFai Lau wrote:
>> On 5/1/24 11:48 AM, Martin KaFai Lau wrote:
>>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>>> +/* Called from the subsystem that consume the struct_ops.
>>>> + *
>>>> + * The caller should protected this function by holding rcu_read_lock() to
>>>> + * ensure "data" is valid. However, this function may unlock rcu
>>>> + * temporarily. The caller should not rely on the preceding rcu_read_lock()
>>>> + * after returning from this function.
>>>
>>> This temporarily losing rcu_read_lock protection is error prone. The caller 
>>> should do the inc_not_zero() instead if it is needed.
>>>
>>> I feel the approach in patch 1 and 3 is a little box-ed in by the earlier 
>>> tcp-cc usage that tried to fit into the kernel module reg/unreg paradigm and 
>>> hide as much bpf details as possible from tcp-cc. This is not necessarily 
>>> true now for other subsystem which has bpf struct_ops from day one.
>>>
>>> The epoll detach notification is link only. Can this kernel side specific 
>>> unreg be limited to struct_ops link only? During reg, a rcu protected link 
>>> could be passed to the subsystem. That subsystem becomes a kernel user of the 
>>> bpf link and it can call link_detach(link) to detach. Pseudo code:
>>>
>>> struct link __rcu *link;
>>>
>>> rcu_read_lock();
>>> ref_link = rcu_dereference(link)
>>> if (ref_link)
>>>      ref_link = bpf_link_inc_not_zero(ref_link);
>>> rcu_read_unlock();
>>>
>>> if (!IS_ERR_OR_NULL(ref_link)) {
>>>      bpf_struct_ops_map_link_detach(ref_link);
>>>      bpf_link_put(ref_link);
>>> }
>>
>> [ ... ]
>>
>>>
>>>> + *
>>>> + * Return true if unreg() success. If a call fails, it means some other
>>>> + * task has unrgistered or is unregistering the same object.
>>>> + */
>>>> +bool bpf_struct_ops_kvalue_unreg(void *data)
>>>> +{
>>>> +    struct bpf_struct_ops_map *st_map =
>>>> +        container_of(data, struct bpf_struct_ops_map, kvalue.data);
>>>> +    enum bpf_struct_ops_state prev_state;
>>>> +    struct bpf_struct_ops_link *st_link;
>>>> +    bool ret = false;
>>>> +
>>>> +    /* The st_map and st_link should be protected by rcu_read_lock(),
>>>> +     * or they may have been free when we try to increase their
>>>> +     * refcount.
>>>> +     */
>>>> +    if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
>>>> +        /* The map is already gone */
>>>> +        return false;
>>>> +
>>>> +    prev_state = cmpxchg(&st_map->kvalue.common.state,
>>>> +                 BPF_STRUCT_OPS_STATE_INUSE,
>>>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);
>>>> +    if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
>>>> +        st_map->st_ops_desc->st_ops->unreg(data);
>>>> +        /* Pair with bpf_map_inc() for reg() */
>>>> +        bpf_map_put(&st_map->map);
>>>> +        /* Pair with bpf_map_inc_not_zero() above */
>>>> +        bpf_map_put(&st_map->map);
>>>> +        return true;
>>>> +    }
>>>> +    if (prev_state != BPF_STRUCT_OPS_STATE_READY)
>>>> +        goto fail;
>>>> +
>>>> +    /* With BPF_F_LINK */
>>>> +
>>>> +    st_link = rcu_dereference(st_map->attached);
>>
>>  From looking at the change in bpf_struct_ops_map_link_dealloc() in patch 1 
>> again, I am not sure st_link is rcu gp protected either. 
>> bpf_struct_ops_map_link_dealloc() is still just kfree(st_link).
> 
> I am not sure what you mean.

I meant this should be kfree_rcu(st_link, ...) instead of kfree(st_link).

The temporarily losing rcu_read_lock and other complexities in this function are 
too subtle. It is hard to reason and should be simplified even if tradeoff is 
needed. Please consider the ideas in my earlier code snippet about using the 
subsystem existing lock during reg/unreg/detach and limit it to link only first.

> With the implementation of this version, st_link should be rcu
> protected. The backward pointer, "attached", from st_map to st_link will
> be reset before kfree(). So, if the caller hold rcu_read_lock(), a
> st_link should be valid as long as it can be reached from a st_map.
> 
>>
>> I also don't think it needs to complicate it further by making st_link go 
>> through rcu only for this use case. The subsystem must have its own lock to 
>> protect parallel reg() and unreg(). tcp-cc has tcp_cong_list_lock. From 
>> looking at scx, scx has scx_ops_enable_mutex. When it tries to do unreg itself 
>> by calling bpf_struct_ops_map_link_detach(link), it needs to acquire its own 
>> lock to ensure a parallel unreg() has not happened. Pseudo code:
>>
>> struct bpf_link *link;
>>
>> static void scx_ops_detach_by_kernel(void)
>> {
>>      struct bpf_link *ref_link;
>>
>>      mutex_lock(&scx_ops_enable_mutex);
>>      ref_link = link;
>>      if (ref_link)
>>          ref_link = bpf_link_inc_not_zero(ref_link);
>>      mutex_unlock(&scx_ops_enable_mutex);
>>
>>      if (!IS_ERR_OR_NULL(ref_link)) {
>>          ref_link->ops->detach(ref_link);
>>          bpf_link_put(ref_link);
>>      }
>> }
>>
>>>> +    if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
>>>> +        /* The map is on the way to unregister */
>>>> +        goto fail;
>>>> +
>>>> +    rcu_read_unlock();
>>>> +    mutex_lock(&update_mutex);
>>>> +
>>>> +    if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
>>>> +        /* The map should be unregistered already or on the way to
>>>> +         * be unregistered.
>>>> +         */
>>>> +        goto fail_unlock;
>>>> +
>>>> +    st_map->st_ops_desc->st_ops->unreg(data);
>>>> +
>>>> +    map_attached_null(st_map);
>>>> +    rcu_assign_pointer(st_link->map, NULL);
>>>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>>> +     */
>>>> +    bpf_map_put(&st_map->map);
>>>> +
>>>> +    ret = true;
>>>> +
>>>> +fail_unlock:
>>>> +    mutex_unlock(&update_mutex);
>>>> +    rcu_read_lock();
>>>> +    bpf_link_put(&st_link->link);
>>>> +fail:
>>>> +    bpf_map_put(&st_map->map);
>>>> +    return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);
>>>
>>>
>>


