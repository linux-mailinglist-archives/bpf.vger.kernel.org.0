Return-Path: <bpf+bounces-29205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939708C134D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B548BB21B2E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3AC8F49;
	Thu,  9 May 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKykTDKJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1F6FB0
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273948; cv=none; b=cOgw0ySnc5I4U0lJaxOk/XrdkIYgLlYRQF31C+r18ad1LaDsL6l/4lZ1uc1veVE+deKPyX/GDffIu4FeBziX8QyqvNT+5ADPHglNA13tTEjS9O+iTMVqV0tnK4eS8gswu9MIEOGOqIvM1Z+Ru9oIVrIuKiWXLfxHOGs+hnLpEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273948; c=relaxed/simple;
	bh=13kPysot2/c8VfDzF687+EDLv+RUJ6e9YqC0QP7pKjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL3nagx5PNH5CkrFU9P88w2krQVkW1KSgDcYZ+ODensmT8N+ilU8ao+0yRZOVWldkO00fombs+LksEnadjtSvbjdhBTV3KjzZy5gd0WUcpCXuEOMuiYwBjHKmbNZB5wjLv9ohFzShE04IIIUNz0GOGVG1bPNzw785zBQ+A8uPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKykTDKJ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0e3b45706so446774a34.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715273945; x=1715878745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce82Ypd+ByaARqMdWJVJQQ7om48DzpfFKthxO7MNkfQ=;
        b=gKykTDKJoQKgj7WLrfL7nkB3ozdxK2y4NEQX7Ypdi8EnKtQxB/uF5Dl9xfGLVuKBLo
         twB7w0omN9Q9g0KHgOziE1i2CdTKGo8wg4FK4EaDAS6PIyhDQOCd2cm51vOj0nzoqt6C
         vFrbjFavHaWbGO753ZkTTLPxzD40din8Wj6XAzWpJ2x6Mm8UPexX6bJgfNUhoJJAYgWg
         QcRNv496QMoI5RI7/6G6KPcCtUokD3IpJD0H+wyPrcwSrf+1OEp5bBctJP8V80sTsLKw
         89kXm16/b8kPNTvvdSaAJzUfaM9+M5syllbm2Ybh8IV9LO+Ca3ijNo5Z7J1mNw71N9Sd
         aHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715273945; x=1715878745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce82Ypd+ByaARqMdWJVJQQ7om48DzpfFKthxO7MNkfQ=;
        b=mdqNEv/sXpQ//6I+FvJx0BN2DMQuVxzrwCkteyvouTYTcpGdvlxgxxYRBinZlCk/32
         MNM0RDvRBuoNEbhNa99THDb33XocQCCXvJTmm9xSxtAZ+y1te6CV+JBNyefVGqw1HFgg
         2a8N14sC1Sj0ydd6ePA5V8B7+KBaRKZ7NTRvx0ScmGSmm4bp4w192sUL/KtZlje3cWkl
         jnVP5OvG8bLADMwadqiOnZHKIbmx/5aPSs3mkywYdsnmZjwvx3AXk3KcQVHFSU7YQ9+w
         k6s/H56OlJaCZIEupCFp6zXaTOLJ3mNZD4Mwr97kEGCO45AQK2hbMTmatRZPJ2306lak
         6IoA==
X-Forwarded-Encrypted: i=1; AJvYcCUz9YYrrdKEhL0fiNR865CVPdXZftWZd2A7tGcLxA2aw0KhidwtwZV+KvCGiF75hcOjvvVUAjG1D8gATI9u7bKDHCHy
X-Gm-Message-State: AOJu0YwSbMm7n6D19zxJDhMMoaXGW7xlvSzaSv+uhaAHjTDPI8OPShem
	4e3d1BswUJ+5jee5t/+KSpWHKq+/aH01L5h5ZwNYBSY++CYMAWeHOIWycw==
X-Google-Smtp-Source: AGHT+IFv3qiIG/ph7fjrm7kOLcyrYKD+M+IfccGrp8PU6eHv1sYe/EqwnGc3PJFAoKph9umJFtlVYA==
X-Received: by 2002:a05:6870:808e:b0:23c:ad86:9933 with SMTP id 586e51a60fabf-241726f5b28mr273867fac.3.1715273945449;
        Thu, 09 May 2024 09:59:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cb76:16d9:1cf9:18f8? ([2600:1700:6cf8:1240:cb76:16d9:1cf9:18f8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c79f3sm342767fac.4.2024.05.09.09.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 09:59:05 -0700 (PDT)
Message-ID: <1b03c687-9b0b-4b48-b278-1fbbe39f0ac8@gmail.com>
Date: Thu, 9 May 2024 09:59:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/6] bpf: enable detaching links of struct_ops
 objects.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-3-thinker.li@gmail.com>
 <88fdd488-f548-4ed4-8afa-ab6a8af974e8@linux.dev>
 <7f285130-d6bf-43ea-b70a-eddc5c419d3e@gmail.com>
 <799553a1-b916-4926-819f-c30aa6aa4d2a@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <799553a1-b916-4926-819f-c30aa6aa4d2a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 17:36, Martin KaFai Lau wrote:
> On 5/8/24 5:14 PM, Kui-Feng Lee wrote:
>>
>>
>> On 5/8/24 16:22, Martin KaFai Lau wrote:
>>> On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
>>>> Implement the detach callback in bpf_link_ops for struct_ops. The
>>>> subsystems that struct_ops objects are registered to can use this 
>>>> callback
>>>> to detach the links being passed to them.
>>>
>>> The user space can also use the detach. The subsystem is merely 
>>> reusing the similar detach callback if it stores the link during reg().
>>
>> Sure!
>>
>>>
>>>>
>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>> ---
>>>>   kernel/bpf/bpf_struct_ops.c | 50 
>>>> ++++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 44 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>>> index 390f8c155135..bd2602982e4d 100644
>>>> --- a/kernel/bpf/bpf_struct_ops.c
>>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>>> @@ -1057,9 +1057,6 @@ static void 
>>>> bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>>>       st_map = (struct bpf_struct_ops_map *)
>>>>           rcu_dereference_protected(st_link->map, true);
>>>>       if (st_map) {
>>>> -        /* st_link->map can be NULL if
>>>> -         * bpf_struct_ops_link_create() fails to register.
>>>> -         */
>>>>           st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, 
>>>> st_link);
>>>>           bpf_map_put(&st_map->map);
>>>>       }
>>>> @@ -1075,7 +1072,8 @@ static void 
>>>> bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>>>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>>>       rcu_read_lock();
>>>>       map = rcu_dereference(st_link->map);
>>>> -    seq_printf(seq, "map_id:\t%d\n", map->id);
>>>> +    if (map)
>>>> +        seq_printf(seq, "map_id:\t%d\n", map->id);
>>>>       rcu_read_unlock();
>>>>   }
>>>> @@ -1088,7 +1086,8 @@ static int 
>>>> bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>>>       rcu_read_lock();
>>>>       map = rcu_dereference(st_link->map);
>>>> -    info->struct_ops.map_id = map->id;
>>>> +    if (map)
>>>> +        info->struct_ops.map_id = map->id;
>>>>       rcu_read_unlock();
>>>>       return 0;
>>>>   }
>>>> @@ -1113,6 +1112,10 @@ static int 
>>>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>>>       mutex_lock(&update_mutex);
>>>>       old_map = rcu_dereference_protected(st_link->map, 
>>>> lockdep_is_held(&update_mutex));
>>>> +    if (!old_map) {
>>>> +        err = -EINVAL;
>>>> +        goto err_out;
>>>> +    }
>>>>       if (expected_old_map && old_map != expected_old_map) {
>>>>           err = -EPERM;
>>>>           goto err_out;
>>>> @@ -1139,8 +1142,37 @@ static int 
>>>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>>>       return err;
>>>>   }
>>>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>>>> +{
>>>> +    struct bpf_struct_ops_link *st_link = container_of(link, struct 
>>>> bpf_struct_ops_link, link);
>>>> +    struct bpf_struct_ops_map *st_map;
>>>> +    struct bpf_map *map;
>>>> +
>>>> +    mutex_lock(&update_mutex);
>>>> +
>>>> +    map = rcu_dereference_protected(st_link->map, true);
>>>
>>> nit. s/true/lockdep_is_held(&update_mutex)/
>>
>>
>> I thought it is protected by the refcount holding by the caller.
>> WDYT?
> 
> st_link->map is the one with __rcu tag and "!map" is tested next. I 
> don't see how these imply the map pointer is protected by refcount. Can 
> you explain?
> 
Ok! You are right. I confused links with maps.

>>
>>
>>>
>>>> +    if (!map) {
>>>> +        mutex_unlock(&update_mutex);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +    st_map = container_of(map, struct bpf_struct_ops_map, map);
>>>> +
>>>> +    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>>>> +
>>>> +    rcu_assign_pointer(st_link->map, NULL);
>>>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>>> +     */
>>>> +    bpf_map_put(&st_map->map);
>>>> +
>>>> +    mutex_unlock(&update_mutex);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>>>> +    .detach = bpf_struct_ops_map_link_detach,
>>>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>>>       .update_map = bpf_struct_ops_map_link_update,
>>>> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union 
>>>> bpf_attr *attr)
>>>>       if (err)
>>>>           goto err_out;
>>>> +    /* Init link->map before calling reg() in case being detached
>>>> +     * immediately.
>>>> +     */
>>>> +    RCU_INIT_POINTER(link->map, map);
>>>> +
>>>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, 
>>>> &link->link);
>>>>       if (err) {
>>>> +        rcu_assign_pointer(link->map, NULL);
>>>
>>> nit. RCU_INIT_POINTER(link->map, NULL) is fine.
>>
>> Got it!
>>
>>>
>>> There is a merge conflict with patch 4 also.
>>
>> What do you mean here? Do you mean the patch 4 can not be applied on top
>> of the patch 2?
> 
> Please monitor the bpf CI report.
> 
> bpf CI complains: 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240507055600.2382627-2-thinker.li@gmail.com/
> 
> snippet of the error:
> 
> Applying: bpf: enable detaching links of struct_ops objects.
> Applying: bpf: support epoll from bpf struct_ops links.
> Applying: selftests/bpf: test struct_ops with epoll
> Patch failed at 0004 selftests/bpf: test struct_ops with epoll

Yes! I found it when I rebased local repository.

> 
>>
>>>
>>> pw-bot: cr
>>>
>>>>           bpf_link_cleanup(&link_primer);
>>>> +        /* The link has been free by bpf_link_cleanup() */
>>>>           link = NULL;
>>>>           goto err_out;
>>>>       }
>>>> -    RCU_INIT_POINTER(link->map, map);
>>>>       return bpf_link_settle(&link_primer);
>>>
> 

