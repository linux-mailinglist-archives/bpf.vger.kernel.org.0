Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7B699A5B
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBPQmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 11:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBPQmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:42:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E74ECFE
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 08:42:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x13so1626470pfu.7
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/QHmE5n2MpJ6B+BRNuVfaldfU22yAJCRLJMhu1uyp8=;
        b=B8DbPiFe93mjW5tuuepVh/XwxnxTJp6dxd1Zhu7LxCP8yXRppGk7Wypt/rG1j92Gci
         HB6t/nmyDBPbqSqFr3MO052QHK3ttnOWPgeJteeVh7Mq//QMEkwzYjcZgzgA8z+XMieS
         54Qz/g2CLKYED/QcyeyA2XBxPDkJ4s+TvYa5t/At8quIdtf/PaKQ2xBf9hEMhGp2iCjn
         ZlRw8zxrGoEF+JiTfrgZxdUcVj6IJOL04pBigahLaDEfYvfiGEmhdUPYhoflCFGU98R9
         LhlAWZznSQuk9zoFAInSuxZMBi3YlUNKqVQGCXtOZ/jm5Ut5IGqbkvcLxCcTDeUlEtaS
         qmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/QHmE5n2MpJ6B+BRNuVfaldfU22yAJCRLJMhu1uyp8=;
        b=fsV+sNGQIO+6UnHe8VK+K0oiJHld2eCmGkxX/0nxnmdH4U5HQ8vLAUebSeVsQ6LO+6
         ikzfz54usTi34qOqoCD2f8uzQ8Om486UYoHZKh2UBB6J3khsiL6R+xoTshmYELp0OxOb
         C6NKlU/c3dgqZOGoVafd081rQDXHTjALTWz4A83Rf8yJWRgmPkkzuSEGCsI1ZHClv+iT
         uJmTddlHRrA+F65OvbqWieQOYQ5ZaXFVzZDeBxglCTK4fA8gUsHdzm1wHPMaNVhgHfWE
         MMnmjg/UxHxihp7FZsjk74fpUHT0X8dqxEo+beCOue2mlOL4jLmu/7mrIzFpQ2XVZ2dI
         rgLg==
X-Gm-Message-State: AO0yUKXq9VXP+Tk6TnTHYZAkjkAfnPeUlG6zXdvPnZCcAFycn6a9EBvJ
        tK0sYCdGxdpUyn/mNR5erMvN1/vRbng=
X-Google-Smtp-Source: AK7set9N3aNSnXhlkGxlArOtytZiY4nfl++1JkcJYCNlt2nVHwISPYQ3DJL5lEcpP4/ZKzfaKeZc8g==
X-Received: by 2002:aa7:9717:0:b0:593:f191:966 with SMTP id a23-20020aa79717000000b00593f1910966mr5798119pfg.1.1676565726845;
        Thu, 16 Feb 2023 08:42:06 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::12ef? ([2620:10d:c090:400::5:962a])
        by smtp.gmail.com with ESMTPSA id e25-20020a62aa19000000b005a8a61ca0bfsm1525974pff.61.2023.02.16.08.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 08:42:06 -0800 (PST)
Message-ID: <28a01a8a-77d2-dcdc-eda4-a6ff7c7b54c0@gmail.com>
Date:   Thu, 16 Feb 2023 08:42:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-4-kuifeng@meta.com>
 <4f5012d6-e07a-2602-3526-d43244d9d978@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4f5012d6-e07a-2602-3526-d43244d9d978@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/23 16:37, Martin KaFai Lau wrote:
> On 2/14/23 2:17 PM, Kui-Feng Lee wrote:
>> Registration via bpf_links ensures a uniform behavior, just like other
>> BPF programs.  BPF struct_ops were registered/unregistered when
>> updating/deleting their values.  Only the maps of struct_ops having
>> the BPF_F_LINK flag are allowed to back a bpf_link.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/uapi/linux/bpf.h       |  3 ++
>>   kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h |  3 ++
>>   3 files changed, 61 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 1e6cdd0f355d..48d8b3058aa1 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1267,6 +1267,9 @@ enum {
>>   /* Create a map that is suitable to be an inner map with dynamic max 
>> entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
>>   /* Flags for BPF_PROG_QUERY. */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 621c8e24481a..d16ca06cf09a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -390,7 +390,7 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>       mutex_lock(&st_map->lock);
>> -    if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
>> +    if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT || 
>> refcount_read(&kvalue->refcnt)) {
> 
> Why it needs a new refcount_read(&kvalue->refcnt) check?

It prohibits updating the value once it is registered.
This refcnt is set to 1 when register it.

But, yes, it is confusing since we never reset it back to *_INIT.
The purpose of this refcount_read() will be clear once add *_UNREG, and 
reset it back to *_INIT properly.


> 
>>           err = -EBUSY;
>>           goto unlock;
>>       }
>> @@ -491,6 +491,12 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
>> +        /* Let bpf_link handle registration & unregistration. */
>> +        smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
> 
> INUSE is for registered struct_ops. It needs a new UNREG state to mean 
> initialized but not registered. The kvalue->state is not in uapi but the 
> user space can still introspect it (thanks to BTF), so having a correct 
> semantic state is useful. Try 'bpftool struct_ops dump ...':
> 
>      "bpf_struct_ops_tcp_congestion_ops": {
>          "refcnt": {
>              "refs": {
>                  "counter": 1
>              }
>          },
>          "state": "BPF_STRUCT_OPS_STATE_INUSE",

Ok! That make sense.

> 
>> +        goto unlock;
>> +    }
>> +
>>       refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
>> @@ -522,6 +528,7 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>       kfree(tlinks);
>>       mutex_unlock(&st_map->lock);
>>       return err;
>> +
> 
> Unnecessary new line.
> 
>>   }
>>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void 
>> *key)
>> @@ -535,6 +542,8 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>                    BPF_STRUCT_OPS_STATE_TOBEFREE);
>>       switch (prev_state) {
>>       case BPF_STRUCT_OPS_STATE_INUSE:
>> +        if (st_map->map.map_flags & BPF_F_LINK)
>> +            return 0;
> 
> This should be a -ENOTSUPP.
Sure!

> 
>>           st_map->st_ops->unreg(&st_map->kvalue.data);
>>           if (refcount_dec_and_test(&st_map->kvalue.refcnt))
>>               bpf_map_put(map);
>> @@ -585,7 +594,7 @@ static void bpf_struct_ops_map_free(struct bpf_map 
>> *map)
>>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>>   {
>>       if (attr->key_size != sizeof(unsigned int) || attr->max_entries 
>> != 1 ||
>> -        attr->map_flags || !attr->btf_vmlinux_value_type_id)
>> +        (attr->map_flags & ~BPF_F_LINK) || 
>> !attr->btf_vmlinux_value_type_id)
>>           return -EINVAL;
>>       return 0;
>>   }
>> @@ -638,6 +647,8 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       set_vm_flush_reset_perms(st_map->image);
>>       bpf_map_init_from_attr(map, attr);
>> +    map->map_flags |= attr->map_flags & BPF_F_LINK;
> 
> This should have already been done in bpf_map_init_from_attr().

bpf_map_init_from_attr() will filter out all flags except BPF_F_RDONLY & 
BPF_F_WRONLY.  But, I can move it to bpf_map_init_from_attr() by not 
filtering out it.

> 
>> +
>>       return map;
>>   }
>> @@ -699,10 +710,25 @@ void bpf_struct_ops_put(const void *kdata)
>>       }
>>   }
>> +static void bpf_struct_ops_kvalue_put(struct bpf_struct_ops_value 
>> *kvalue)
>> +{
>> +    struct bpf_struct_ops_map *st_map;
>> +
>> +    if (refcount_dec_and_test(&kvalue->refcnt)) {
>> +        st_map = container_of(kvalue, struct bpf_struct_ops_map,
>> +                      kvalue);
>> +        bpf_map_put(&st_map->map);
>> +    }
>> +}
>> +
>>   static void bpf_struct_ops_map_link_release(struct bpf_link *link)
>>   {
>> +    struct bpf_struct_ops_map *st_map;
>> +
>>       if (link->map) {
>> -        bpf_map_put(link->map);
>> +        st_map = (struct bpf_struct_ops_map *)link->map;
>> +        st_map->st_ops->unreg(&st_map->kvalue.data);
>> +        bpf_struct_ops_kvalue_put(&st_map->kvalue);
>>           link->map = NULL;
> 
> Does it need a lock or something to protect the link_release? or I am 
> missing something and lock is not needed?

This function will be called by bpf_link_free() following the pointer in 
bpf_link_ops.  And bpf_link_free() is called by bpf_link_put(). The 
refcnt of bpf_link is maintained by bpf_link_put(), and the function 
here indirectly only if the refcnt reachs 0.  If I don't miss anything, 
it should be safe to release a link without a lock.

> 
> The kvalue->value state should become UNREG.
> 
> After UNREG, can the struct_ops map be used in creating a new link again?
> 

It should be.

>>       }
>>   }
>> @@ -735,13 +761,15 @@ static const struct bpf_link_ops 
>> bpf_struct_ops_map_lops = {
>>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>>   {
>> +    struct bpf_struct_ops_map *st_map;
>>       struct bpf_link_primer link_primer;
>> +    struct bpf_struct_ops_value *kvalue;
>>       struct bpf_map *map;
>>       struct bpf_link *link = NULL;
>>       int err;
>>       map = bpf_map_get(attr->link_create.prog_fd);
>> -    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
>> +    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags 
>> & BPF_F_LINK))
>>           return -EINVAL;
>>       link = kzalloc(sizeof(*link), GFP_USER);
>> @@ -752,6 +780,29 @@ int link_create_struct_ops_map(union bpf_attr 
>> *attr, bpfptr_t uattr)
>>       bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, 
>> &bpf_struct_ops_map_lops, NULL);
>>       link->map = map;
>> +    if (map->map_flags & BPF_F_LINK) {
>> +        st_map = (struct bpf_struct_ops_map *)map;
>> +        kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
>> +
>> +        if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
>> +            refcount_read(&kvalue->refcnt) != 0) {
> 
> The refcount_read(&kvalue->refcnt) is to ensure it is not registered?
> It seems the UNREG state is useful here.

Yes!

> 
>> +            err = -EINVAL;
>> +            goto err_out;
>> +        }
>> +
>> +        refcount_set(&kvalue->refcnt, 1);
> 
> If a struct_ops map is used to create multiple links in parallel, is it 
> safe?
> 
>> +
>> +        set_memory_rox((long)st_map->image, 1);
>> +        err = st_map->st_ops->reg(kvalue->data);
> 
> After successful reg, the state can be changed from UNREG to INUSE.
> 
>> +        if (err) {
>> +            refcount_set(&kvalue->refcnt, 0);
>> +
>> +            set_memory_nx((long)st_map->image, 1);
>> +            set_memory_rw((long)st_map->image, 1);
>> +            goto err_out;
>> +        }
>> +    }
> 
> This patch should be combined with patch 1. Otherwise, patch 1 is quite 
> hard to understand without link_create_struct_ops_map() doing the actual 
> "attach".

Ok!

> 
>> +
>>       err = bpf_link_prime(link, &link_primer);
>>       if (err)
>>           goto err_out;
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 1e6cdd0f355d..48d8b3058aa1 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1267,6 +1267,9 @@ enum {
>>   /* Create a map that is suitable to be an inner map with dynamic max 
>> entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
>>   /* Flags for BPF_PROG_QUERY. */
> 
