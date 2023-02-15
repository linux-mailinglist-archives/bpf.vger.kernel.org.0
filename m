Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E069834F
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBOS3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOS3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:29:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED754302B2
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:29:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso2688804pjv.5
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVsJ39VnxDwrhik889XH3a9xOkpZaoMPt/PYHBZPPhk=;
        b=LjtI5EPHXnop/cpI6aCTW8UZTZmA7ja00nzFYG3UQMQJfmOnxDNyyeOHcF9SNTYjCR
         5U/vMJxdtCDZUW9URw9GJMQ7grOtyWzyu9i3kmAd4OPEt3H3cS+XNlAz/srECQw3Uj7P
         JzvlO1/XVQX+WygsQt11ZP08mnJF0msGbD5wSb9+yxQtBUrq/bwgICTHMG75bhnh6ltn
         D0nwEd1z4P6M1rBQvZ0QZdVpPEThQEU6TsN9Y7ysuHtz8pNF+zjNlWSkZlI3s+jzC712
         b9+QOfsQGKes0mTQNYozM9C2jyykJSI7594wr8idhZfGOajSCdlF00Tm1hJUdsJS51t8
         MRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVsJ39VnxDwrhik889XH3a9xOkpZaoMPt/PYHBZPPhk=;
        b=xO+x2gJzxsQU1C+Dfzf9J+gcNliuzDIFbVZgiDh/N9HhuzRicVn6nzQsA64ykK2zzy
         T+2hxMYRLCST5QqUYf99azm67550WcIdgXcg7k1atkqW+KmObaOHeVn3RC6DhyFCHNFu
         8byriTGCxwiVrJrzEXmwyKi68DimATk2O7u1/AQPPD6ojiiceJDTeCVv1w1X3y53dhw5
         0uJtw/monT1SORBctx8c2yyuBygunbdl026LilfxszkYVYwvfzFiEjCEgP//o0arD4BJ
         7uiDAE64toama+/0PncFf+MEnDb9GGXROBeFwSVYqyy6E1MN7bwpaAnYK+5ulk4lLjTq
         VGww==
X-Gm-Message-State: AO0yUKWl48IZtrjPT3OuFA/AmV3U+X39qjRQwREjpisIYCvZXV8tMqDk
        hWVMn2SC8vuAAJzi3CpciTQ=
X-Google-Smtp-Source: AK7set/d3J1iB6g1Kq4RNwT8+mtOSUnAVLm/5aQzFPWc1AaI+JxHY/qA3Po223PWiR1lLbAuW9gaLw==
X-Received: by 2002:a17:902:db0b:b0:19a:7622:23e5 with SMTP id m11-20020a170902db0b00b0019a762223e5mr4308901plx.4.1676485762340;
        Wed, 15 Feb 2023 10:29:22 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902d64500b00198ef76ce8dsm7019116plh.72.2023.02.15.10.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:29:21 -0800 (PST)
Message-ID: <0af75eed-8ced-8590-bc12-0b7545545fdb@gmail.com>
Date:   Wed, 15 Feb 2023 10:29:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-4-kuifeng@meta.com> <Y+xJJLAhPBzboOvo@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Y+xJJLAhPBzboOvo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/14/23 18:53, Stanislav Fomichev wrote:
> On 02/14, Kui-Feng Lee wrote:
>> Registration via bpf_links ensures a uniform behavior, just like other
>> BPF programs.  BPF struct_ops were registered/unregistered when
>> updating/deleting their values.  Only the maps of struct_ops having
>> the BPF_F_LINK flag are allowed to back a bpf_link.
>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/uapi/linux/bpf.h       |  3 ++
>>   kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h |  3 ++
>>   3 files changed, 61 insertions(+), 4 deletions(-)
>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 1e6cdd0f355d..48d8b3058aa1 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1267,6 +1267,9 @@ enum {
>
>>   /* Create a map that is suitable to be an inner map with dynamic 
>> max entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
>
>>   /* Flags for BPF_PROG_QUERY. */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 621c8e24481a..d16ca06cf09a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -390,7 +390,7 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>
>>       mutex_lock(&st_map->lock);
>
>> -    if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
>> +    if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT || 
>> refcount_read(&kvalue->refcnt)) {
>>           err = -EBUSY;
>>           goto unlock;
>>       }
>> @@ -491,6 +491,12 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
>> +        /* Let bpf_link handle registration & unregistration. */
>> +        smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
>> +        goto unlock;
>> +    }
>> +
>>       refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
>
>
> [..]
>
>> @@ -522,6 +528,7 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>       kfree(tlinks);
>>       mutex_unlock(&st_map->lock);
>>       return err;
>> +
>>   }
>
>>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void 
>> *key)
>
> Seems like a left over hunk?


You are right.  I will remove it.


>
>> @@ -535,6 +542,8 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>                    BPF_STRUCT_OPS_STATE_TOBEFREE);
>>       switch (prev_state) {
>>       case BPF_STRUCT_OPS_STATE_INUSE:
>> +        if (st_map->map.map_flags & BPF_F_LINK)
>> +            return 0;
>> st_map->st_ops->unreg(&st_map->kvalue.data);
>>           if (refcount_dec_and_test(&st_map->kvalue.refcnt))
>>               bpf_map_put(map);
>> @@ -585,7 +594,7 @@ static void bpf_struct_ops_map_free(struct 
>> bpf_map *map)
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
>
>
> [..]
>
>> +    map->map_flags |= attr->map_flags & BPF_F_LINK;
>
> You seem to have the following check above:
>
> if (.... (attr->map_flags & ~BPF_F_LINK) ...) return -EINVAL;
>
> And here you do:
>
> map->map_flags |= attr->map_flags & BPF_F_LINK;
>
> So maybe we can simplify to:
> map->map_flags |= attr->map_flags;
>
> ?

Great catch!


>
>> +
>>       return map;
>>   }
>
>> @@ -699,10 +710,25 @@ void bpf_struct_ops_put(const void *kdata)
>>       }
>>   }
>
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
>> + st_map->st_ops->unreg(&st_map->kvalue.data);
>> +        bpf_struct_ops_kvalue_put(&st_map->kvalue);
>>           link->map = NULL;
>>       }
>>   }
>> @@ -735,13 +761,15 @@ static const struct bpf_link_ops 
>> bpf_struct_ops_map_lops = {
>
>>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>>   {
>> +    struct bpf_struct_ops_map *st_map;
>>       struct bpf_link_primer link_primer;
>> +    struct bpf_struct_ops_value *kvalue;
>>       struct bpf_map *map;
>>       struct bpf_link *link = NULL;
>>       int err;
>
>>       map = bpf_map_get(attr->link_create.prog_fd);
>> -    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
>> +    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags 
>> & BPF_F_LINK))
>>           return -EINVAL;
>
>>       link = kzalloc(sizeof(*link), GFP_USER);
>> @@ -752,6 +780,29 @@ int link_create_struct_ops_map(union bpf_attr 
>> *attr, bpfptr_t uattr)
>>       bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, 
>> &bpf_struct_ops_map_lops, NULL);
>>       link->map = map;
>
>
> [..]
>
>> +    if (map->map_flags & BPF_F_LINK) {
>
> We seem to bail out above when we don't have BPF_F_LINK flags above?
>
> if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & 
> BPF_F_LINK))
>     return -EINVAL;
>
> So why check this 'if (map->map_flags & BPF_F_LINK)' condition here?


You are right! This check is not necessary anymore.


>
>
>> +        st_map = (struct bpf_struct_ops_map *)map;
>> +        kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
>> +
>> +        if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
>> +            refcount_read(&kvalue->refcnt) != 0) {
>> +            err = -EINVAL;
>> +            goto err_out;
>> +        }
>> +
>> +        refcount_set(&kvalue->refcnt, 1);
>> +
>> +        set_memory_rox((long)st_map->image, 1);
>> +        err = st_map->st_ops->reg(kvalue->data);
>> +        if (err) {
>> +            refcount_set(&kvalue->refcnt, 0);
>> +
>> +            set_memory_nx((long)st_map->image, 1);
>> +            set_memory_rw((long)st_map->image, 1);
>> +            goto err_out;
>> +        }
>> +    }
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
>
>>   /* Create a map that is suitable to be an inner map with dynamic 
>> max entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
>
>>   /* Flags for BPF_PROG_QUERY. */
>> -- 
>> 2.30.2
>
