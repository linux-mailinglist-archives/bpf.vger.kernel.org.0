Return-Path: <bpf+bounces-29152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37698C08A4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF31F21875
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39483C684;
	Thu,  9 May 2024 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aajwPwEa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC829A2
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215582; cv=none; b=HZy9n7HzeXPISZtRDZJJJ7c/fm7BptyLoxpq/6IqWqJgmzppr3JNsOAsY4Bw2VZI5NLmpXP11WG3IHBj5vGsa89u0mdUdwC2XxYom1xibvvnITzQW4JAT/Sa0ggg7vfKA1Hya2SRE33lx8LCnd/b7rPAfUPsHPXbAicz/rZ67yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215582; c=relaxed/simple;
	bh=357ScIiH65J03k3cAdAq2B/fPraU8XwOILCwJMjP000=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u1WExqey33iZWo6ERWTVSbZawY4nmk7cuVwL9Um6/RBl++hFOoZ8QpQuj1h7eG1LgOCTwaqVDOG594YT96rKvwYYuWPlrP+NLFTHZp2ABDr3WQz/zkwmHX8iC9CzKlOjcF5L6QsXai1OV7CoDO4hUAzM8FO3NU9nMypomdzMRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aajwPwEa; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b1ffd24c58so184132eaf.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715215580; x=1715820380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQZIVwYdUkKQLML2gQ+vuKZnODM0uUX0ozPzf9AyLLk=;
        b=aajwPwEaOb+zHD3SXQvAbbBUwQsl8ZEQvxrSfDCrWa9YIq5Ja50AiB95B2meDJgXl0
         1JiVtKIGhC0HtC1Rq66LCuS4gCW5oTdH6Ki7XO0kmofqVSUhm9tGCTsxRLPtwHjaMKII
         XAqsHi+a7TNBKSP5lktUJ+56680p40MIZIFNm3O+UPK/NVO76QiJIbFukb36nRvV/5QE
         mJ47LYKwm3GT99KNC84xAuWupHgiA27gkStGr7zoxOTtDXNLQmHpUZJ0yy8MqV5C/clK
         cxliUqOOIjezh5kdG7aOtmX7/mhOvRIdVoreCfzLwWabpCt4mEG9jl9r0avmK31FYBP7
         2qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215580; x=1715820380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQZIVwYdUkKQLML2gQ+vuKZnODM0uUX0ozPzf9AyLLk=;
        b=uNFLQKvYAAAJR659Flu+0bmy/DsH8Do5NivJjFYgp5v3gn9NoohdSwkI8ctl/BbMGJ
         JlIrzpma6Akk6wnHZAviwu3mng8R7OX6hNcc8Vh6clGhLKDSroEezlimrHWtkNUslqkl
         cRPY61F5yxbshR057QUVN6KfFh3udUBkn6uLsaVApBsPUtLdyz8HHl+OSyl3HryIhAti
         i3FIatccLhxY3XaQWIlK9lcHEVIwaX/Szyl4gezjZHbIBg81GvPppgyhINGWyCGXSWEA
         R0bRp2ya97UlBIqDDj7EbsdcMwaxWncW3/ZpJuGx9XcOaeBNhpQugDTCG6lSYOWN5sLN
         lpMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRU8eP529JAjF+jVgO7DGqIbKgXn/Z7D/IULYoDwnrS0jZLmHwwk5FecsMHM233phXcHGHfw8Kpxc1paKM1DccUWj
X-Gm-Message-State: AOJu0YyJKPHo/1XzYKRipiABiILh6Qa+yghv6MD0HsAfnCwMwxy8Q4eK
	/K2awQJWQJd3fTQVdaFWb/A8Z2RLV8yMnscQKL5R6c7oq3QKwU9L
X-Google-Smtp-Source: AGHT+IGqkhxSuuLpbFpWpwI8AauKnMntngMZmHwrnhrw563w4OWnTpkdKykMNAe1NZSuV1GN9kbmzw==
X-Received: by 2002:a4a:5143:0:b0:5b2:f7c:a711 with SMTP id 006d021491bc7-5b24d68b2d0mr3887940eaf.7.1715215579720;
        Wed, 08 May 2024 17:46:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d81:68e7:6cdb:ae69? ([2600:1700:6cf8:1240:d81:68e7:6cdb:ae69])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b26dd8ea7csm59918eaf.16.2024.05.08.17.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:46:19 -0700 (PDT)
Message-ID: <9bc23027-5c7f-42e8-a3b2-169419a3d74d@gmail.com>
Date: Wed, 8 May 2024 17:46:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/6] bpf: enable detaching links of struct_ops
 objects.
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-3-thinker.li@gmail.com>
 <88fdd488-f548-4ed4-8afa-ab6a8af974e8@linux.dev>
 <7f285130-d6bf-43ea-b70a-eddc5c419d3e@gmail.com>
Content-Language: en-US
In-Reply-To: <7f285130-d6bf-43ea-b70a-eddc5c419d3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 17:14, Kui-Feng Lee wrote:
> 
> 
> On 5/8/24 16:22, Martin KaFai Lau wrote:
>> On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
>>> Implement the detach callback in bpf_link_ops for struct_ops. The
>>> subsystems that struct_ops objects are registered to can use this 
>>> callback
>>> to detach the links being passed to them.
>>
>> The user space can also use the detach. The subsystem is merely 
>> reusing the similar detach callback if it stores the link during reg().
> 
> Sure!
> 
>>
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   kernel/bpf/bpf_struct_ops.c | 50 ++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 44 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index 390f8c155135..bd2602982e4d 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -1057,9 +1057,6 @@ static void 
>>> bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>>       st_map = (struct bpf_struct_ops_map *)
>>>           rcu_dereference_protected(st_link->map, true);
>>>       if (st_map) {
>>> -        /* st_link->map can be NULL if
>>> -         * bpf_struct_ops_link_create() fails to register.
>>> -         */
>>>           st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, 
>>> st_link);
>>>           bpf_map_put(&st_map->map);
>>>       }
>>> @@ -1075,7 +1072,8 @@ static void 
>>> bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>>       rcu_read_lock();
>>>       map = rcu_dereference(st_link->map);
>>> -    seq_printf(seq, "map_id:\t%d\n", map->id);
>>> +    if (map)
>>> +        seq_printf(seq, "map_id:\t%d\n", map->id);
>>>       rcu_read_unlock();
>>>   }
>>> @@ -1088,7 +1086,8 @@ static int 
>>> bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>>       rcu_read_lock();
>>>       map = rcu_dereference(st_link->map);
>>> -    info->struct_ops.map_id = map->id;
>>> +    if (map)
>>> +        info->struct_ops.map_id = map->id;
>>>       rcu_read_unlock();
>>>       return 0;
>>>   }
>>> @@ -1113,6 +1112,10 @@ static int 
>>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>>       mutex_lock(&update_mutex);
>>>       old_map = rcu_dereference_protected(st_link->map, 
>>> lockdep_is_held(&update_mutex));
>>> +    if (!old_map) {
>>> +        err = -EINVAL;
>>> +        goto err_out;
>>> +    }
>>>       if (expected_old_map && old_map != expected_old_map) {
>>>           err = -EPERM;
>>>           goto err_out;
>>> @@ -1139,8 +1142,37 @@ static int 
>>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>>       return err;
>>>   }
>>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>>> +{
>>> +    struct bpf_struct_ops_link *st_link = container_of(link, struct 
>>> bpf_struct_ops_link, link);
>>> +    struct bpf_struct_ops_map *st_map;
>>> +    struct bpf_map *map;
>>> +
>>> +    mutex_lock(&update_mutex);
>>> +
>>> +    map = rcu_dereference_protected(st_link->map, true);
>>
>> nit. s/true/lockdep_is_held(&update_mutex)/
> 
> 
> I thought it is protected by the refcount holding by the caller.
> WDYT?
> 
> 
>>
>>> +    if (!map) {
>>> +        mutex_unlock(&update_mutex);
>>> +        return -EINVAL;
>>> +    }
>>> +    st_map = container_of(map, struct bpf_struct_ops_map, map);
>>> +
>>> +    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>>> +
>>> +    rcu_assign_pointer(st_link->map, NULL);
>>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>> +     */
>>> +    bpf_map_put(&st_map->map);
>>> +
>>> +    mutex_unlock(&update_mutex);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>>> +    .detach = bpf_struct_ops_map_link_detach,
>>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>>       .update_map = bpf_struct_ops_map_link_update,
>>> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr 
>>> *attr)
>>>       if (err)
>>>           goto err_out;
>>> +    /* Init link->map before calling reg() in case being detached
>>> +     * immediately.
>>> +     */
>>> +    RCU_INIT_POINTER(link->map, map);
>>> +
>>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, 
>>> &link->link);
>>>       if (err) {
>>> +        rcu_assign_pointer(link->map, NULL);
>>
>> nit. RCU_INIT_POINTER(link->map, NULL) is fine.
> 
> Got it!
> 
>>
>> There is a merge conflict with patch 4 also.
> 
> What do you mean here? Do you mean the patch 4 can not be applied on top
> of the patch 2?

I have seen it after rebasing my local repository.

> 
>>
>> pw-bot: cr
>>
>>>           bpf_link_cleanup(&link_primer);
>>> +        /* The link has been free by bpf_link_cleanup() */
>>>           link = NULL;
>>>           goto err_out;
>>>       }
>>> -    RCU_INIT_POINTER(link->map, map);
>>>       return bpf_link_settle(&link_primer);
>>

