Return-Path: <bpf+bounces-28411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C98B9195
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0790BB2196C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B333165FD5;
	Wed,  1 May 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt/U6rru"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855D1C68D
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601751; cv=none; b=oS3lXWtCNaiXrOq6d0DQfMs4R2Sds8ZJWBnugyEmK4N7nKO7u+GwkqshelXbbEO/hTgYKA7KQ77il437boEn99tC9i7nxgKq4r4eLza6AVmKiA4GxGSptlwUe7xlVrh77Yi7XKCRjNxCv2D7r8bftwpv7PG2RP5DGxDqcfBzGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601751; c=relaxed/simple;
	bh=GwM8S9eG78kIORiXAR9V2ECPQFAL39/kXHS0x1I1t6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUTr1Kfxh2pqyrUy8zDnM1KecbHXQD8PxgolHLAeh3Cqmk/zKt9ZgKips11CPYa08FH/yAsOg6YiOdz1ynbK8X/AlYe7J7pHswCkp8Zwc5wHevps7zDTQcp27ZHyr1EZax+eazmCid5BAKVCAmy76Z0QT7HQWg33pbYWWinPucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt/U6rru; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ee3231d95eso651033a34.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601749; x=1715206549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmRiVTI1BZRez5DPxSKoB5F2ar4CYPKw4iUhBdWHt/o=;
        b=jt/U6rru9kA0W5sdb7KSwXAd8bd6mdH0/ZQfcTb6B5Na0CZd+FpEgWU8jWZcAJlOP3
         OUVKR+DyNo+7tFGhYnhIBGKdGa1uLhJxmwFpyet2Y8EyURo0GYHQUrY1jl8lzLPzq5Tg
         FZT0dkaacsATfJovtrsMTUj77eWGsPAueU86ncV5j56A4qdLSavnDlPvP4vpsxr0wkQS
         bJNeqpEuynAt728Kn1Nx7+TBqVjawsAarywhLH0JDIJ5njBF7HxILQjtrDhaCuiZt2ym
         JMxMj1eXIOXds09Z3LfnWnL1KPvgy43UfiiK3K/y7PRigZQrMF4WlhDqk7KQCerorF0T
         gnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601749; x=1715206549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmRiVTI1BZRez5DPxSKoB5F2ar4CYPKw4iUhBdWHt/o=;
        b=htpcgg+sbX4aRPn9x3uBopZ3brhrmJwtsOIkqRH03k8K+FjvnAhLHZjoMkHL0G/eeD
         Z6RXJzKimByvlfgPFr9En07RO2XItxt9SU8lASA/IJK2jGTw7bPibW9Vvo2Z9QH+TA3A
         rPIa6GkWcIr09IfigC2uP7iqi/l0eXHVfMWaM6AcKo4RWfpH6ZXCLa3MkzZAZN746Nw6
         zr0NV2yWfpCQ1LEPkLqgqS7SXXncsEMuWKNNFBgPwB1ebM8MkVub1wbaKu+0ALPDgGLC
         5o6UCHp7hJNugoz/motXcOLzJTJFeiBUg1Suy8HjJvcmYnm3FdePSLjtqtvDCJKaeEla
         yKXQ==
X-Gm-Message-State: AOJu0YysNq8aXn7mzeQh1Dh5ghD8vg8sd9HtWIRxZzuCMiPqMwqNrk1i
	7IsGNcUfhkAm58aTSm8mMg/Gjyjn7Zg2L611SLTld2SS80M9Oxyf
X-Google-Smtp-Source: AGHT+IHHuhJSgJeqBL346ZE5Ks38vzTjD3OAOGswxuYDq7mSxiB7hm26dXilngXYpLdwcUwV4hVHnA==
X-Received: by 2002:a9d:7a89:0:b0:6ed:a4fa:63c6 with SMTP id l9-20020a9d7a89000000b006eda4fa63c6mr497076otn.2.1714601748702;
        Wed, 01 May 2024 15:15:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:22b9:2301:860f:eff6? ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id b9-20020a056830310900b006ef950619c8sm550090ots.81.2024.05.01.15.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 15:15:48 -0700 (PDT)
Message-ID: <42d93c08-1f43-49f4-81d9-076f4e708b97@gmail.com>
Date: Wed, 1 May 2024 15:15:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/6] bpf: add a pointer of the attached link to
 bpf_struct_ops_map.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-2-thinker.li@gmail.com>
 <CAEf4Bza3YmsxD7yrK2+TJx=EWyobmgps5ySLmzU7QVQHhUigpQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4Bza3YmsxD7yrK2+TJx=EWyobmgps5ySLmzU7QVQHhUigpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/24 10:01, Andrii Nakryiko wrote:
> On Mon, Apr 29, 2024 at 2:36 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> To facilitate the upcoming unregistring struct_ops objects from the systems
>> consuming objects, a pointer of the attached link is added to allow for
>> accessing the attached link of a bpf_struct_ops_map directly from the map
>> itself.
>>
>> Previously, a st_map could be attached to multiple links. This patch now
>> enforces only one link attached at most.
> 
> I'd like to avoid this restriction, in principle. We don't enforce
> that BPF program should be attached through a single BPF link, so I
> don't think we should allow that for maps. Worst case you can keep a
> list of attached links.

Agree!

> 
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 47 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 86c7884abaf8..072e3416c987 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -20,6 +20,8 @@ struct bpf_struct_ops_value {
>>
>>   #define MAX_TRAMP_IMAGE_PAGES 8
>>
>> +struct bpf_struct_ops_link;
>> +
>>   struct bpf_struct_ops_map {
>>          struct bpf_map map;
>>          struct rcu_head rcu;
>> @@ -39,6 +41,8 @@ struct bpf_struct_ops_map {
>>          void *image_pages[MAX_TRAMP_IMAGE_PAGES];
>>          /* The owner moduler's btf. */
>>          struct btf *btf;
>> +       /* The link is attached by this map. */
>> +       struct bpf_struct_ops_link __rcu *attached;
>>          /* uvalue->data stores the kernel struct
>>           * (e.g. tcp_congestion_ops) that is more useful
>>           * to userspace than the kvalue.  For example,
>> @@ -1048,6 +1052,22 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>>                  smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
>>   }
>>
>> +/* Set the attached link of a map.
>> + *
>> + * Return the current value of the st_map->attached.
>> + */
>> +static inline struct bpf_struct_ops_link *map_attached(struct bpf_struct_ops_map *st_map,
>> +                                                      struct bpf_struct_ops_link *st_link)
>> +{
>> +       return unrcu_pointer(cmpxchg(&st_map->attached, NULL, st_link));
>> +}
>> +
>> +/* Reset the attached link of a map */
>> +static inline void map_attached_null(struct bpf_struct_ops_map *st_map)
>> +{
>> +       rcu_assign_pointer(st_map->attached, NULL);
>> +}
>> +
>>   static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>   {
>>          struct bpf_struct_ops_link *st_link;
>> @@ -1061,6 +1081,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>>                   * bpf_struct_ops_link_create() fails to register.
>>                   */
>>                  st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
>> +               map_attached_null(st_map);
>>                  bpf_map_put(&st_map->map);
>>          }
>>          kfree(st_link);
>> @@ -1125,9 +1146,21 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>>                  goto err_out;
>>          }
>>
>> +       if (likely(st_map != old_st_map) && map_attached(st_map, st_link)) {
>> +               /* The map is already in use */
>> +               err = -EBUSY;
>> +               goto err_out;
>> +       }
>> +
>>          err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
>> -       if (err)
>> +       if (err) {
>> +               if (st_map != old_st_map)
>> +                       map_attached_null(st_map);
>>                  goto err_out;
>> +       }
>> +
>> +       if (likely(st_map != old_st_map))
>> +               map_attached_null(old_st_map);
>>
>>          bpf_map_inc(new_map);
>>          rcu_assign_pointer(st_link->map, new_map);
>> @@ -1172,20 +1205,28 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>          }
>>          bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
>>
>> +       if (map_attached(st_map, link)) {
>> +               err = -EBUSY;
>> +               goto err_out;
>> +       }
>> +
>>          err = bpf_link_prime(&link->link, &link_primer);
>>          if (err)
>> -               goto err_out;
>> +               goto err_out_attached;
>>
>>          err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
>>          if (err) {
>>                  bpf_link_cleanup(&link_primer);
>> +               /* The link has been free by bpf_link_cleanup() */
>>                  link = NULL;
>> -               goto err_out;
>> +               goto err_out_attached;
>>          }
>>          RCU_INIT_POINTER(link->map, map);
>>
>>          return bpf_link_settle(&link_primer);
>>
>> +err_out_attached:
>> +       map_attached_null(st_map);
>>   err_out:
>>          bpf_map_put(map);
>>          kfree(link);
>> --
>> 2.34.1
>>

