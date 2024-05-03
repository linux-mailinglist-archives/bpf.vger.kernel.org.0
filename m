Return-Path: <bpf+bounces-28489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA08BA4A7
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5091C22A5E
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0225BA53;
	Fri,  3 May 2024 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnbc5SpV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E78BF8
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696875; cv=none; b=U9OvZpLcavmDA8yQynccQGzDf9EQcQAK29vJKr9LwV27dz2S3K1jEiJzYPO4eIBhTfbpp1omCkOAgq01fvvHHv61YtC5VVOqKWfyHnKOr3sQS6R9UjJpeXEsHzVrVFyHoMLv8qPDVa0niSzDB6Xz3r9nS/7tW2n3Fc9JRTOQ9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696875; c=relaxed/simple;
	bh=xDeIpVzeyqwfFLGAE2Qan+tDcHRREFrpMPdZ3P9gnhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DW6iEHLQgix3J1M2sjiY7pQfvxge+4cS2YLc8gVFbZ7mBvpnxihhdWFNVA/ONmmJbfuiimZv9j9MfOaLMk4KoO/Yc1pxFPmobbOU/84X0t7xygPOVN4QPwlMJd6dhZHK0ulDWoMO2pgHGuVtwttfzjmGaRnhYT9K/VvT5vZ2o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnbc5SpV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ef884f86e9so1635469a34.0
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 17:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714696873; x=1715301673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR1GYONoRMMgMqoHwy9VeF//vMk0ANRzUUxlGyQLWcA=;
        b=bnbc5SpVD6SvO0iwRoz2Net9QG49iQtiQDdj79iMI+xSQsnztYwL1WFfAeSoKLwaOk
         aAbpcxeJeEVsuUUwnKP/uCHjxk51jYqpL5JZL1K5a8VLZaY95feCDiSG1olPqy8zWHbG
         dxy0zNvi6dP2rlM239jvYCXpiOLx9F5ObU9q3DHd1kNPrH661j5Wu6gNFcsHk83fgjx8
         O+uT7AecUgqTr6VniFTwDxTxrGWTWaMEX6s491E5gcnBrxn+2lh6UYuH0XPPZ5TljHF9
         2zuW+TWVXHR0RxjuzhC9T7v5C5wFyIgfCWRtvqP7IxFS6GPbZ4e1ahzHvFoAV3EBfA9t
         dWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696873; x=1715301673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR1GYONoRMMgMqoHwy9VeF//vMk0ANRzUUxlGyQLWcA=;
        b=Asb+alHpI1VvJcNnhjv0mLsib07MoOE9wi8PjxGvoLa665NZthbiVdyRI8uAQIjgKX
         CMzNJK5ZNZcb477FPIHh52PEsaWBrTQU1CMiazFMWp+ouA1CXdUPheI0c3PaDiIYt8EQ
         P5aVqvtLSkOkOJo2gCN7LPDerB6PoXOhc/HaO6L92xmRO6UrnYt6K9fd7LflidKwnClT
         pOmHDzIHxp/xlf+VInjyRUwJgozlqhd+ZXaZ/HeJqeUWcNrSzfKSsowL7jf7/JxtuHQF
         7eNCyHrT8A5hJ7WoR3SaqZTVLO7cF8jaDEUNP5d1e0mxWUoY8wk3u2ixlTngLXJ/bZzH
         FSsg==
X-Gm-Message-State: AOJu0Ywmdx/4bKFbhdsEyvZdkOxR5+RhMdcj9pUDVxyMLtKAR2hrV9Z4
	+uJ6RlvnBju0dzw+oLXw9wJ0nJC0M/Y0z2E628NRxIpnAtUAK3Aw
X-Google-Smtp-Source: AGHT+IHnil6pmmD86Y1Fh0WeceNcNfJ3WrEChN3yEpeycNVY4shGQS6TfwRguqEuewAWNlaKj5DVtQ==
X-Received: by 2002:a9d:730b:0:b0:6ee:6741:539e with SMTP id e11-20020a9d730b000000b006ee6741539emr1551131otk.15.1714696872818;
        Thu, 02 May 2024 17:41:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8400:1987:243f:f8a5? ([2600:1700:6cf8:1240:8400:1987:243f:f8a5])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6212000000b006ef8773670dsm408072otj.64.2024.05.02.17.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 17:41:12 -0700 (PDT)
Message-ID: <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
Date: Thu, 2 May 2024 17:41:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
 <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/2/24 10:56, Martin KaFai Lau wrote:
> On 5/1/24 11:48 AM, Martin KaFai Lau wrote:
>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>> +/* Called from the subsystem that consume the struct_ops.
>>> + *
>>> + * The caller should protected this function by holding 
>>> rcu_read_lock() to
>>> + * ensure "data" is valid. However, this function may unlock rcu
>>> + * temporarily. The caller should not rely on the preceding 
>>> rcu_read_lock()
>>> + * after returning from this function.
>>
>> This temporarily losing rcu_read_lock protection is error prone. The 
>> caller should do the inc_not_zero() instead if it is needed.
>>
>> I feel the approach in patch 1 and 3 is a little box-ed in by the 
>> earlier tcp-cc usage that tried to fit into the kernel module 
>> reg/unreg paradigm and hide as much bpf details as possible from 
>> tcp-cc. This is not necessarily true now for other subsystem which has 
>> bpf struct_ops from day one.
>>
>> The epoll detach notification is link only. Can this kernel side 
>> specific unreg be limited to struct_ops link only? During reg, a rcu 
>> protected link could be passed to the subsystem. That subsystem 
>> becomes a kernel user of the bpf link and it can call 
>> link_detach(link) to detach. Pseudo code:
>>
>> struct link __rcu *link;
>>
>> rcu_read_lock();
>> ref_link = rcu_dereference(link)
>> if (ref_link)
>>      ref_link = bpf_link_inc_not_zero(ref_link);
>> rcu_read_unlock();
>>
>> if (!IS_ERR_OR_NULL(ref_link)) {
>>      bpf_struct_ops_map_link_detach(ref_link);
>>      bpf_link_put(ref_link);
>> }
> 
> [ ... ]
> 
>>
>>> + *
>>> + * Return true if unreg() success. If a call fails, it means some other
>>> + * task has unrgistered or is unregistering the same object.
>>> + */
>>> +bool bpf_struct_ops_kvalue_unreg(void *data)
>>> +{
>>> +    struct bpf_struct_ops_map *st_map =
>>> +        container_of(data, struct bpf_struct_ops_map, kvalue.data);
>>> +    enum bpf_struct_ops_state prev_state;
>>> +    struct bpf_struct_ops_link *st_link;
>>> +    bool ret = false;
>>> +
>>> +    /* The st_map and st_link should be protected by rcu_read_lock(),
>>> +     * or they may have been free when we try to increase their
>>> +     * refcount.
>>> +     */
>>> +    if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
>>> +        /* The map is already gone */
>>> +        return false;
>>> +
>>> +    prev_state = cmpxchg(&st_map->kvalue.common.state,
>>> +                 BPF_STRUCT_OPS_STATE_INUSE,
>>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);
>>> +    if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
>>> +        st_map->st_ops_desc->st_ops->unreg(data);
>>> +        /* Pair with bpf_map_inc() for reg() */
>>> +        bpf_map_put(&st_map->map);
>>> +        /* Pair with bpf_map_inc_not_zero() above */
>>> +        bpf_map_put(&st_map->map);
>>> +        return true;
>>> +    }
>>> +    if (prev_state != BPF_STRUCT_OPS_STATE_READY)
>>> +        goto fail;
>>> +
>>> +    /* With BPF_F_LINK */
>>> +
>>> +    st_link = rcu_dereference(st_map->attached);
> 
>  From looking at the change in bpf_struct_ops_map_link_dealloc() in 
> patch 1 again, I am not sure st_link is rcu gp protected either. 
> bpf_struct_ops_map_link_dealloc() is still just kfree(st_link).

I am not sure what you mean.
With the implementation of this version, st_link should be rcu
protected. The backward pointer, "attached", from st_map to st_link will
be reset before kfree(). So, if the caller hold rcu_read_lock(), a
st_link should be valid as long as it can be reached from a st_map.

> 
> I also don't think it needs to complicate it further by making st_link 
> go through rcu only for this use case. The subsystem must have its own 
> lock to protect parallel reg() and unreg(). tcp-cc has 
> tcp_cong_list_lock. From looking at scx, scx has scx_ops_enable_mutex. 
> When it tries to do unreg itself by calling 
> bpf_struct_ops_map_link_detach(link), it needs to acquire its own lock 
> to ensure a parallel unreg() has not happened. Pseudo code:
> 
> struct bpf_link *link;
> 
> static void scx_ops_detach_by_kernel(void)
> {
>      struct bpf_link *ref_link;
> 
>      mutex_lock(&scx_ops_enable_mutex);
>      ref_link = link;
>      if (ref_link)
>          ref_link = bpf_link_inc_not_zero(ref_link);
>      mutex_unlock(&scx_ops_enable_mutex);
> 
>      if (!IS_ERR_OR_NULL(ref_link)) {
>          ref_link->ops->detach(ref_link);
>          bpf_link_put(ref_link);
>      }
> }
> 
>>> +    if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
>>> +        /* The map is on the way to unregister */
>>> +        goto fail;
>>> +
>>> +    rcu_read_unlock();
>>> +    mutex_lock(&update_mutex);
>>> +
>>> +    if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
>>> +        /* The map should be unregistered already or on the way to
>>> +         * be unregistered.
>>> +         */
>>> +        goto fail_unlock;
>>> +
>>> +    st_map->st_ops_desc->st_ops->unreg(data);
>>> +
>>> +    map_attached_null(st_map);
>>> +    rcu_assign_pointer(st_link->map, NULL);
>>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>> +     */
>>> +    bpf_map_put(&st_map->map);
>>> +
>>> +    ret = true;
>>> +
>>> +fail_unlock:
>>> +    mutex_unlock(&update_mutex);
>>> +    rcu_read_lock();
>>> +    bpf_link_put(&st_link->link);
>>> +fail:
>>> +    bpf_map_put(&st_map->map);
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);
>>
>>
> 

