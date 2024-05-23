Return-Path: <bpf+bounces-30426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F818CD9F9
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBEB21206
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7982492;
	Thu, 23 May 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5AqMrE7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB682488
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488910; cv=none; b=o2NJ1k2s0vjaCVJId264nS6lOOxeje+6DLmbjTu/qm6kl9pQdx6a4sXh4YCksIZuwNTBR9MwJocf1TVJcxE0zV0lQjZ406IkzMraNZCSJzWTyrolLjUFmZiX1nFL6MRy6t3LroximJ0GB0ANq4OECbdmJY6DwciQqhqHDhblC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488910; c=relaxed/simple;
	bh=5YHfC8nLOExTbkcgJxMuqqA50SKTtEU4VPgwhR5P43c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwAR02ypTJXsD5XAuS4ytFGpz5QER1zrFQZgINYhFbM1ddhLmY5My1fdDbiwSg+8xNq10yWWspP0WsPMonkeJPg1UDOp1b8P+FavAAbUANUS6GR1oS9vLQUjyS08e0u0+ngsycNizcASZLBqi6OvWp3m5zqJrtTpYdKp6Mn7eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5AqMrE7; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df4e5b89e49so2059733276.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716488908; x=1717093708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf4U3u3oUtZTNTOvhW0iBEb854PNGTdGD9EVsXmO6UM=;
        b=D5AqMrE72Aga86GVcLT1fFzczZdqcxGqVVByOzIFhwHsTYY0t/CsCcziOTu2TtFgE5
         SZwa2K4LcCysf6WC4ss9H7E+k3EFHUjBxLO38IpfbLRtJsugkrfkb6p6qP2P3mC9naNs
         yxr6HrCaILmVuLcCh5R17fkrddgMtpAZabIGgMpE9h5TQcyM56f/fqcHIiBcU65RB3JA
         hdAqlhigYe4WgpfynYguqPEfUiMNr2TCFJTi6xqdxC3cgghozW+9ycYe6r/1R4zVx4nN
         CUBtdKm3bIEKsXzxQsBKjhC1R5QnsCGMaSVcV7pIDrSubOy0z3bH81Ugu0HG+B0SnQ5Y
         tdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488908; x=1717093708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf4U3u3oUtZTNTOvhW0iBEb854PNGTdGD9EVsXmO6UM=;
        b=PuD5P3f9FJ9wDwAMC/3hy+b5J2JJ+sLc39JXzKA8Ghl3rTS6VV1ps5GYeF9v/VpkHa
         2imm5c7CucCBJ6H0bLisB0+sjKvFOOkPIzZcwilpumnt64G3gXrtGhqOanOfACc6NNDm
         HZ1E1RHncmqgF7YX+wawhUJK01xITvn5UFfFvPDkaBmTRg0UkRA+FssOMdU6pt8wijb5
         aoO9lxOY2R7uaI5jUbpcqAO4efBpvRl7MVuoSGDHn3SdFwGKKPmchKZqWeB1NYygZ7yK
         gXy15evBqUOFItQObyKk5OD9yGIBTieonh4eHyHlzegY6kS4BkJNslZsaWMq5hUnGQcJ
         0lEA==
X-Gm-Message-State: AOJu0Yxnq5rtKkD+v2E67pGxjXsGUO8Q+vlpOqy1zHoCmu9cfAcuJICt
	r0JBKAVCtrRkXBbPPMWFeqp4z/ldeuU11RyNRKkFAKugHqRgE8Es2TB9fA==
X-Google-Smtp-Source: AGHT+IHoiJ+KIP2fnYM2spEY0SUYmCXKH5tyU7nkL9CvXBFbta1q64O2qpk+t5xLwJ0FC8LsuiK32g==
X-Received: by 2002:a25:fc1c:0:b0:df4:dd6c:16f with SMTP id 3f1490d57ef6-df77218e261mr37967276.19.1716488907909;
        Thu, 23 May 2024 11:28:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a2b5:fcfb:857c:2908? ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-df4e623de6fsm632367276.23.2024.05.23.11.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:28:27 -0700 (PDT)
Message-ID: <ab7ee230-4c13-4daf-ba32-7bcda1342fb9@gmail.com>
Date: Thu, 23 May 2024 11:28:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/7] bpf: enable detaching links of struct_ops
 objects.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-3-thinker.li@gmail.com>
 <025ebd13-fcd1-4abe-b5c1-d845c057200d@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <025ebd13-fcd1-4abe-b5c1-d845c057200d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/23/24 11:09, Martin KaFai Lau wrote:
> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>> Implement the detach callback in bpf_link_ops for struct_ops so that user
>> programs can detach a struct_ops link. The subsystems that struct_ops
>> objects are registered to can also use this callback to detach the links
>> being passed to them.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 63 +++++++++++++++++++++++++++++++++----
>>   1 file changed, 57 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 1542dded7489..fb6e8a3190ef 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -1057,9 +1057,6 @@ static void 
>> bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>       st_map = (struct bpf_struct_ops_map *)
>>           rcu_dereference_protected(st_link->map, true);
>>       if (st_map) {
>> -        /* st_link->map can be NULL if
>> -         * bpf_struct_ops_link_create() fails to register.
>> -         */
>>           st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>>           bpf_map_put(&st_map->map);
>>       }
>> @@ -1075,7 +1072,8 @@ static void 
>> bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>       rcu_read_lock();
>>       map = rcu_dereference(st_link->map);
>> -    seq_printf(seq, "map_id:\t%d\n", map->id);
>> +    if (map)
>> +        seq_printf(seq, "map_id:\t%d\n", map->id);
>>       rcu_read_unlock();
>>   }
>> @@ -1088,7 +1086,8 @@ static int 
>> bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>       st_link = container_of(link, struct bpf_struct_ops_link, link);
>>       rcu_read_lock();
>>       map = rcu_dereference(st_link->map);
>> -    info->struct_ops.map_id = map->id;
>> +    if (map)
>> +        info->struct_ops.map_id = map->id;
>>       rcu_read_unlock();
>>       return 0;
>>   }
>> @@ -1113,6 +1112,10 @@ static int 
>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>       mutex_lock(&update_mutex);
>>       old_map = rcu_dereference_protected(st_link->map, 
>> lockdep_is_held(&update_mutex));
>> +    if (!old_map) {
>> +        err = -EINVAL;
> 
> Just noticed this while checking the return value in patch 3.
> 
> This should be -ENOLINK such that it is consistent to the other links' 
> .update_prog (e.g. cgroup, tcx, net_namespace...).

Sure

> 
>> +        goto err_out;
>> +    }
>>       if (expected_old_map && old_map != expected_old_map) {
>>           err = -EPERM;
>>           goto err_out;
>> @@ -1139,8 +1142,37 @@ static int 
>> bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>       return err;
>>   }
>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>> +{
>> +    struct bpf_struct_ops_link *st_link = container_of(link, struct 
>> bpf_struct_ops_link, link);
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
>> +
>> +    mutex_lock(&update_mutex);
>> +
>> +    map = rcu_dereference_protected(st_link->map, 
>> lockdep_is_held(&update_mutex));
>> +    if (!map) {
>> +        mutex_unlock(&update_mutex);
>> +        return -EINVAL;
> 
> Same here but should be always 0 (detach always succeeds).

Got it.

> 
>> +    }
>> +    st_map = container_of(map, struct bpf_struct_ops_map, map);
>> +
>> +    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>> +
>> +    rcu_assign_pointer(st_link->map, NULL);
>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>> +     */
>> +    bpf_map_put(&st_map->map);
>> +
>> +    mutex_unlock(&update_mutex);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>> +    .detach = bpf_struct_ops_map_link_detach,
>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>       .update_map = bpf_struct_ops_map_link_update,
>> @@ -1176,13 +1208,32 @@ int bpf_struct_ops_link_create(union bpf_attr 
>> *attr)
>>       if (err)
>>           goto err_out;
>> +    /* Init link->map before calling reg() in case being detached
>> +     * immediately.
>> +     */
>> +    RCU_INIT_POINTER(link->map, map);
>> +
>> +    /* Once reg() is called, the object and link is already available
>> +     * to the subsystem, and it can call
>> +     * bpf_struct_ops_map_link_detach() to unreg() it. However, it is
>> +     * sfae not holding update_mutex here.
>> +     *
>> +     * In the case of failure in reg(), the subsystem has no reason to
>> +     * call bpf_struct_ops_map_link_detach() since the object is not
>> +     * accepted by it. In the case of success, the subsystem may call
>> +     * bpf_struct_ops_map_link_detach() to unreg() it, but we don't
>> +     * change the content of the link anymore except changing link->id
>> +     * in bpf_link_settle(). So, it is safe to not hold update_mutex
>> +     * here.
> 
> After sleeping on the RCU_INIT_POINTER dance and re-reading this 
> comment, I need to walk back my early reply.
> 
> Instead of having comment to explain the RCU_INIT_POINTER dance 
> (resetting it to NULL on reg() err because 
> bpf_struct_ops_map_link_dealloc is not supposed to unreg when the reg 
> did fail), how about simplifying it and just take the update_mutex here 
> such that the subsystem cannot detach until the 
> RCU_INIT_POINTER(link->map, map) is done. Performance is not a concern 
> here, so I would prefer simplicity.

sure!

> 
>> +     */
>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, 
>> &link->link);
>>       if (err) {
>> +        RCU_INIT_POINTER(link->map, NULL);
>>           bpf_link_cleanup(&link_primer);
>> +        /* The link has been free by bpf_link_cleanup() */
>>           link = NULL;
>>           goto err_out;
>>       }
>> -    RCU_INIT_POINTER(link->map, map);
>>       return bpf_link_settle(&link_primer);
> 

