Return-Path: <bpf+bounces-29146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C548C0856
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495EF1C211D3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34130524C;
	Thu,  9 May 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx3IVHkj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09F10E9
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213649; cv=none; b=JEnXGlYQMb8oTW576eKS8JdvLM0nYIgU4de4onrYgtomM1DjovwXfckCrxP1u9y8EBu5Uerm6bLOrPzjC6tDjF3eekOLh+EWicH7TQcBJTsr/NDvLjvzvcx6FaNwA/8suNKEbzg6xSCsC3N9zC9LBADvZHgjlryiMRCcS9KG0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213649; c=relaxed/simple;
	bh=V4JHz+eD6xN9UCXyVb/2dTfhcNwXOru+iOzyo2HsdEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDfzD4y3r88Nymeoo0oeUSRykzekOpo5+Dzwb3s6uxJt+xOmRxk0FUxECZmjB27Q+sGBcsgbLHOducgkhOfCDMeW9/lL/tfKFjxQjIuhkHog/3UuN3blvZ54I109556NCFLLtzN+AO5ZLjaXwlEZ91uMLq2oXUyJQK8vrgnZV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx3IVHkj; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23f59d71d10so208436fac.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 17:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715213647; x=1715818447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJfxmCZlL6u74n0usDG0C2EXWCXmmFaX9mAsGcHNIXQ=;
        b=Sx3IVHkjZTfQ1NdhaRT3UddjJTM8DioW1ZsqF32GaXDLbo+ZdYhHgpRSn/t89EH7aI
         JslIZ5tKdBgaTXS/TyH1TDsUdG5L9lG2osew4hPXEuBC/0nQY4C4UE5wCaBPx9Aw3tWy
         exGEQosqmkzgSNwFq2H1Y3aAHPA1wae9sqtAB9buOnxdPqqHJjrgkWajA58iKVOj4ZNK
         ouC/v4iqxSTRXSvGEEEoQaRCgGU3vqaJDc4rAlH+tMQzY4UihW26JgyRc7hLiRhAcC7m
         jiq+FmoO3ans5CNPz0WCbCLMxU5p02tIaANxHVBu6w04D/nTbvXyZEh/kXYGLkd3jXLS
         H1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715213647; x=1715818447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJfxmCZlL6u74n0usDG0C2EXWCXmmFaX9mAsGcHNIXQ=;
        b=pSJpi0DQ6cVXtNQHEbm5ZK84Pa2fksyGW3ljSmoEj3goxJ4c45osJBa5RiSP6lXP2+
         pmr2Pp9Zygivt+CRnTbWJkrvyxI30QO2bcrKluGToxt9SKtJzgKgrs5eTs5b+jlvdpep
         cUQTR7qOYnz3uYxQOuKN41/xdbIkcvKVG9Q0o/QKNpSjK5JElFhd5dM/72kICYKXCH6b
         jU2FHDeoOtrM3LbIgOy32ulBQv2yrMgcCMMDt19LQ7QXeMw5NHSD06cJskrurZ+/6rc0
         FQIIwdg5OUn4PHTIw1qejSjFQ8w2GYw4CxWepFjcEUbrA6XVegphy7B+s13Z7NlhvW4Z
         FZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMh2g9udEYoj/6XUmRoUYnT1rybbqb8FPRJt+BIetpGsM0xMBO1amGWotZVrOkHlblI40tyaTz74ypmq37OZ1zVUu1
X-Gm-Message-State: AOJu0YxlpjpTjeOFRwDFg1oH/39cDAA/spCGqgt4bbPVU8qfAy522paE
	W0tvcVQw/Ws9HF4e6ck00FKbe5sXk2fbOSuHvNI1nufcpjMzpZRc
X-Google-Smtp-Source: AGHT+IFTXzBIsGdf73SpWp93fp7fjzAbSEaPV2K/2mehKuiNjqJVH5h/a+9BrGyerUZ2OwfJ3M9XVQ==
X-Received: by 2002:a05:6870:9707:b0:23e:69ae:462b with SMTP id 586e51a60fabf-24098444979mr4791982fac.35.1715213647088;
        Wed, 08 May 2024 17:14:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d81:68e7:6cdb:ae69? ([2600:1700:6cf8:1240:d81:68e7:6cdb:ae69])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a6a122bsm68668fac.33.2024.05.08.17.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:14:06 -0700 (PDT)
Message-ID: <7f285130-d6bf-43ea-b70a-eddc5c419d3e@gmail.com>
Date: Wed, 8 May 2024 17:14:05 -0700
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <88fdd488-f548-4ed4-8afa-ab6a8af974e8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 16:22, Martin KaFai Lau wrote:
> On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
>> Implement the detach callback in bpf_link_ops for struct_ops. The
>> subsystems that struct_ops objects are registered to can use this 
>> callback
>> to detach the links being passed to them.
> 
> The user space can also use the detach. The subsystem is merely reusing 
> the similar detach callback if it stores the link during reg().

Sure!

> 
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 50 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 44 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 390f8c155135..bd2602982e4d 100644
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
>>           st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, 
>> st_link);
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
>> +    map = rcu_dereference_protected(st_link->map, true);
> 
> nit. s/true/lockdep_is_held(&update_mutex)/


I thought it is protected by the refcount holding by the caller.
WDYT?


> 
>> +    if (!map) {
>> +        mutex_unlock(&update_mutex);
>> +        return -EINVAL;
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
>> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr 
>> *attr)
>>       if (err)
>>           goto err_out;
>> +    /* Init link->map before calling reg() in case being detached
>> +     * immediately.
>> +     */
>> +    RCU_INIT_POINTER(link->map, map);
>> +
>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, 
>> &link->link);
>>       if (err) {
>> +        rcu_assign_pointer(link->map, NULL);
> 
> nit. RCU_INIT_POINTER(link->map, NULL) is fine.

Got it!

> 
> There is a merge conflict with patch 4 also.

What do you mean here? Do you mean the patch 4 can not be applied on top
of the patch 2?

> 
> pw-bot: cr
> 
>>           bpf_link_cleanup(&link_primer);
>> +        /* The link has been free by bpf_link_cleanup() */
>>           link = NULL;
>>           goto err_out;
>>       }
>> -    RCU_INIT_POINTER(link->map, map);
>>       return bpf_link_settle(&link_primer);
> 

