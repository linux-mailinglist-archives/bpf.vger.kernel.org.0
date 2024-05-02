Return-Path: <bpf+bounces-28470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC78B9FDD
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76361F22044
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D417106F;
	Thu,  2 May 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQEp4KEx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1316FF3E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672586; cv=none; b=guL0SnMHHX8wYXBsAnfWt8YyunbFjoP3dV3h6CacoAkuYoJU68gbBn+2EiASdhUMkNTwJ8X948R5K1Eq3IfIkOTe4x7YoWjENo5NPsvnZaqiz6MG55PFtcVyieNKnVliFsQ4uwQ+7yit63RBy+NvLuoFeG/oWGDF3H5K4XO5MSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672586; c=relaxed/simple;
	bh=XmAPUlhpUDFS0qhkXZo+TojOo7EBTuEmM0XcdD4H0Xo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IvkOnoWtOYD46lYNGMTNR0RmCNxaFf5MlrX4MFHwfkTG6RyP3PD3Ode6KEJZ12PLoaEuEe7gia87sOLBBmbFJZSkWGXKWE6zR4Ev56EPLO1JO1v5LzjffB8WW4Ldqk637rzp3Q3+giuAPO8W/EAB3OCRZNkl+Ar8eJ8fMe23rzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQEp4KEx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714672581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HP9/XPFedRlj+IAXXQUUogWet4+vFO6q5hiMSwg7n+k=;
	b=VQEp4KExsYIb+DuGGN1w5gUWVCV1X12AXcV8odiylvDH7Po3nxGYfakLIUGw3JmUbLsub5
	WBYwFfleOXuQlOy46hWP/6tHBL7Erm6gqaH3bdVGCeGzABFZOYtE3hzIWM7ZYjM1cdKAn4
	224iWo/DXFkAoLSYetcVAznga6INFzc=
Date: Thu, 2 May 2024 10:56:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
Content-Language: en-US
In-Reply-To: <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 11:48 AM, Martin KaFai Lau wrote:
> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>> +/* Called from the subsystem that consume the struct_ops.
>> + *
>> + * The caller should protected this function by holding rcu_read_lock() to
>> + * ensure "data" is valid. However, this function may unlock rcu
>> + * temporarily. The caller should not rely on the preceding rcu_read_lock()
>> + * after returning from this function.
> 
> This temporarily losing rcu_read_lock protection is error prone. The caller 
> should do the inc_not_zero() instead if it is needed.
> 
> I feel the approach in patch 1 and 3 is a little box-ed in by the earlier tcp-cc 
> usage that tried to fit into the kernel module reg/unreg paradigm and hide as 
> much bpf details as possible from tcp-cc. This is not necessarily true now for 
> other subsystem which has bpf struct_ops from day one.
> 
> The epoll detach notification is link only. Can this kernel side specific unreg 
> be limited to struct_ops link only? During reg, a rcu protected link could be 
> passed to the subsystem. That subsystem becomes a kernel user of the bpf link 
> and it can call link_detach(link) to detach. Pseudo code:
> 
> struct link __rcu *link;
> 
> rcu_read_lock();
> ref_link = rcu_dereference(link)
> if (ref_link)
>      ref_link = bpf_link_inc_not_zero(ref_link);
> rcu_read_unlock();
> 
> if (!IS_ERR_OR_NULL(ref_link)) {
>      bpf_struct_ops_map_link_detach(ref_link);
>      bpf_link_put(ref_link);
> }

[ ... ]

> 
>> + *
>> + * Return true if unreg() success. If a call fails, it means some other
>> + * task has unrgistered or is unregistering the same object.
>> + */
>> +bool bpf_struct_ops_kvalue_unreg(void *data)
>> +{
>> +    struct bpf_struct_ops_map *st_map =
>> +        container_of(data, struct bpf_struct_ops_map, kvalue.data);
>> +    enum bpf_struct_ops_state prev_state;
>> +    struct bpf_struct_ops_link *st_link;
>> +    bool ret = false;
>> +
>> +    /* The st_map and st_link should be protected by rcu_read_lock(),
>> +     * or they may have been free when we try to increase their
>> +     * refcount.
>> +     */
>> +    if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
>> +        /* The map is already gone */
>> +        return false;
>> +
>> +    prev_state = cmpxchg(&st_map->kvalue.common.state,
>> +                 BPF_STRUCT_OPS_STATE_INUSE,
>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);
>> +    if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
>> +        st_map->st_ops_desc->st_ops->unreg(data);
>> +        /* Pair with bpf_map_inc() for reg() */
>> +        bpf_map_put(&st_map->map);
>> +        /* Pair with bpf_map_inc_not_zero() above */
>> +        bpf_map_put(&st_map->map);
>> +        return true;
>> +    }
>> +    if (prev_state != BPF_STRUCT_OPS_STATE_READY)
>> +        goto fail;
>> +
>> +    /* With BPF_F_LINK */
>> +
>> +    st_link = rcu_dereference(st_map->attached);

 From looking at the change in bpf_struct_ops_map_link_dealloc() in patch 1 
again, I am not sure st_link is rcu gp protected either. 
bpf_struct_ops_map_link_dealloc() is still just kfree(st_link).

I also don't think it needs to complicate it further by making st_link go 
through rcu only for this use case. The subsystem must have its own lock to 
protect parallel reg() and unreg(). tcp-cc has tcp_cong_list_lock. From looking 
at scx, scx has scx_ops_enable_mutex. When it tries to do unreg itself by 
calling bpf_struct_ops_map_link_detach(link), it needs to acquire its own lock 
to ensure a parallel unreg() has not happened. Pseudo code:

struct bpf_link *link;

static void scx_ops_detach_by_kernel(void)
{
	struct bpf_link *ref_link;

	mutex_lock(&scx_ops_enable_mutex);
	ref_link = link;
	if (ref_link)
		ref_link = bpf_link_inc_not_zero(ref_link);
	mutex_unlock(&scx_ops_enable_mutex);

	if (!IS_ERR_OR_NULL(ref_link)) {
		ref_link->ops->detach(ref_link);
		bpf_link_put(ref_link);
	}
}

>> +    if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
>> +        /* The map is on the way to unregister */
>> +        goto fail;
>> +
>> +    rcu_read_unlock();
>> +    mutex_lock(&update_mutex);
>> +
>> +    if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
>> +        /* The map should be unregistered already or on the way to
>> +         * be unregistered.
>> +         */
>> +        goto fail_unlock;
>> +
>> +    st_map->st_ops_desc->st_ops->unreg(data);
>> +
>> +    map_attached_null(st_map);
>> +    rcu_assign_pointer(st_link->map, NULL);
>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>> +     */
>> +    bpf_map_put(&st_map->map);
>> +
>> +    ret = true;
>> +
>> +fail_unlock:
>> +    mutex_unlock(&update_mutex);
>> +    rcu_read_lock();
>> +    bpf_link_put(&st_link->link);
>> +fail:
>> +    bpf_map_put(&st_map->map);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);
> 
> 


