Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91C6B16C4
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHXq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 18:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCHXqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 18:46:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD6C1C0C
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 15:46:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso4228835pjb.2
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 15:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678319213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnk9Q2AtdaG3WB21+5mAcGfQYOrPMRpiB9sqDNFYnYs=;
        b=lgSbLwzBivBL9tclLU0r7CxcpRki/ZlFmQHX8MhGW29QxpsmLflRnCWRE552OwgGGL
         QdeMzgNDmxl514MRgPef+tse+wPZVAizGnbYOkdOLp8hevtM7YPI+0/eBi1bUdi/MKvV
         vLvybF3iySPkr3cy02mpoJJ4FrLGBn8z/b5oirdrZjdEFL2ZMEvRp0HGnR1R//scXWJx
         UKbqTWxHU7+Vv4vIiBPNjj2eaxFpwmrpnZJcNqDLB3M3xVK0EUHokomMIzHTPpE3ud6i
         OfUyck3LvKbg2of2lFwOZHKoORcArvpZ3TUVsIxDQ1q7/jI2BAvTQygMcIzoIHl93HFy
         BMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnk9Q2AtdaG3WB21+5mAcGfQYOrPMRpiB9sqDNFYnYs=;
        b=XsxtgAJz0t+WmDljRP6k4vdN0KaPICWI54AyPUvLRNfDxMT5SPbCLxomfNGpAPv4Gb
         T1Y6Um/+wKKXQwl+eFF3GgPtt4iQVoCaRCBod/3dCFF5hEang+tNb+6G8Tcy1x1g3JI4
         Gocap5iJx7J4zUtKFI6839SJkNHitN6ZMJmRq/Te+VcBXOVgkTH85ZMTdQ8rwd07INCy
         QNcIM8dQpE95alVn68rmckBdl7RzaDjaarGKk5k8dfcpia7ssFxKxx24WADbn/F9lk16
         mH1WlLMvwRJy524JDaekB7Ym3UL5dDgOTv/BvCpi1fcioHPXEIRO9Uu4kw6aD/5JS68l
         nsWA==
X-Gm-Message-State: AO0yUKWYQc5wLhbne6v8jpYrNWJeML/olOp30dMtWCULeOIRWmZY1HNb
        PzcEFsfEr32x0aYzrYh4lVg=
X-Google-Smtp-Source: AK7set9nl/B6CCe4SJcRljDDWj3fsbbNc6CtcJIWRkERJ/bhA2lGtceXz3hlVxZXJTB/SYmulOWCwA==
X-Received: by 2002:a05:6a20:1aa8:b0:cd:ed5c:4af with SMTP id ci40-20020a056a201aa800b000cded5c04afmr17099505pzb.49.1678319213449;
        Wed, 08 Mar 2023 15:46:53 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::1660? ([2620:10d:c090:400::5:78e2])
        by smtp.gmail.com with ESMTPSA id 1-20020aa79241000000b005a7ae8b3a09sm9934982pfp.32.2023.03.08.15.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 15:46:53 -0800 (PST)
Message-ID: <0d7d92a6-1c7f-a618-de6e-f921f1df0c62@gmail.com>
Date:   Wed, 8 Mar 2023 15:46:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-4-kuifeng@meta.com>
 <0fcce83c-30f6-87d1-7ead-281fb154e589@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <0fcce83c-30f6-87d1-7ead-281fb154e589@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/8/23 12:04, Martin KaFai Lau wrote:
> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 00b6e1a2edaf..afca6c526fe4 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1548,6 +1548,7 @@ static inline void bpf_module_put(const void 
>> *data, struct module *owner)
>>       else
>>           module_put(owner);
>>   }
>> +int bpf_struct_ops_link_create(union bpf_attr *attr);
>>   #ifdef CONFIG_NET
>>   /* Define it here to avoid the use of forward declaration */
>> @@ -1588,6 +1589,11 @@ static inline int 
>> bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>>   {
>>       return -EINVAL;
>>   }
>> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   #endif
>>   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
>> @@ -2379,6 +2385,11 @@ static inline void bpf_link_put(struct bpf_link 
>> *link)
>>   {
>>   }
>> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
> 
> The inline version is double defined. It does not look right. Please 
> double check.

Removed!

> 
>> +
>>   static inline int bpf_obj_get_user(const char __user *pathname, int 
>> flags)
>>   {
>>       return -EOPNOTSUPP;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 976b194eb775..f9fc7b8af3c4 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>>       BPF_PERF_EVENT,
>>       BPF_TRACE_KPROBE_MULTI,
>>       BPF_LSM_CGROUP,
>> +    BPF_STRUCT_OPS,
>>       __MAX_BPF_ATTACH_TYPE
>>   };
>> @@ -1266,6 +1267,9 @@ enum {
>>   /* Create a map that is suitable to be an inner map with dynamic max 
>> entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
>>   /* Flags for BPF_PROG_QUERY. */
>> @@ -1507,7 +1511,10 @@ union bpf_attr {
>>       } task_fd_query;
>>       struct { /* struct used by BPF_LINK_CREATE command */
>> -        __u32        prog_fd;    /* eBPF program to attach */
>> +        union {
>> +            __u32        prog_fd;    /* eBPF program to attach */
>> +            __u32        map_fd;        /* struct_ops to attach */
>> +        };
>>           union {
>>               __u32        target_fd;    /* object to attach to */
>>               __u32        target_ifindex; /* target ifindex */
>> @@ -6379,6 +6386,9 @@ struct bpf_link_info {
>>           struct {
>>               __u32 ifindex;
>>           } xdp;
>> +        struct {
>> +            __u32 map_id;
>> +        } struct_ops;
>>       };
>>   } __attribute__((aligned(8)));
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 9e097fcc9cf4..5a7e86cf67b5 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -16,6 +16,7 @@ enum bpf_struct_ops_state {
>>       BPF_STRUCT_OPS_STATE_INIT,
>>       BPF_STRUCT_OPS_STATE_INUSE,
>>       BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>>   };
>>   #define BPF_STRUCT_OPS_COMMON_VALUE            \
>> @@ -58,6 +59,11 @@ struct bpf_struct_ops_map {
>>       struct bpf_struct_ops_value kvalue;
>>   };
>> +struct bpf_struct_ops_link {
>> +    struct bpf_link link;
>> +    struct bpf_map __rcu *map;
>> +};
>> +
>>   static DEFINE_MUTEX(update_mutex);
>>   #define VALUE_PREFIX "bpf_struct_ops_"
>> @@ -496,11 +502,24 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    bpf_map_inc(map);
>> -
>>       set_memory_rox((long)st_map->image, 1);
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
>> +        if (st_ops->validate) {
>> +            err = st_ops->validate(kdata);
>> +            if (err)
>> +                goto unlock;
> 
> This should at least be 'goto reset_unlock' to release the progs.
> 
> set_memory_rox(..., 1) should also be done after validate?

Yes, it should go to reset_unlock.  In that case, set_memory_rox()
should be called after the check.


> 
>> +        }
>> +        /* Let bpf_link handle registration & unregistration.
>> +         *
>> +         * Pair with smp_load_acquire() during lookup_elem().
>> +         */
>> +        smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
>> +        goto unlock;
>> +    }
>> +
>>       err = st_ops->reg(kdata);
>>       if (likely(!err)) {
>> +        bpf_map_inc(map);
>>           /* Pair with smp_load_acquire() during lookup_elem().
>>            * It ensures the above udata updates (e.g. prog->aux->id)
>>            * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
>> @@ -516,7 +535,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>        */
>>       set_memory_nx((long)st_map->image, 1);
>>       set_memory_rw((long)st_map->image, 1);
>> -    bpf_map_put(map);
>>   reset_unlock:
>>       bpf_struct_ops_map_put_progs(st_map);
>> @@ -534,6 +552,9 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>       struct bpf_struct_ops_map *st_map;
>>       st_map = (struct bpf_struct_ops_map *)map;
>> +    if (st_map->map.map_flags & BPF_F_LINK)
>> +        return -EOPNOTSUPP;
>> +
>>       prev_state = cmpxchg(&st_map->kvalue.state,
>>                    BPF_STRUCT_OPS_STATE_INUSE,
>>                    BPF_STRUCT_OPS_STATE_TOBEFREE);
>> @@ -601,7 +622,7 @@ static void bpf_struct_ops_map_free(struct bpf_map 
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
>> @@ -712,3 +733,98 @@ void bpf_struct_ops_put(const void *kdata)
>>       bpf_map_put(&st_map->map);
>>   }
>> +
>> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>> +{
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_struct_ops_map *st_map;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    st_map = (struct bpf_struct_ops_map *)st_link->map;
> 
> /* protected by refcnt and no one is replacing it */
> rcu_dereference_protected(st_link->map, true);
> 
> st_link->map is with __rcu. It should have warning when compile with 
> 'make C=1 ...'. Patchwork also reports this: 
> https://patchwork.kernel.org/project/netdevbpf/patch/20230308005050.255859-4-kuifeng@meta.com/. Please pay attention to patchwork for errors.
> 
>> +    st_map->st_ops->unreg(&st_map->kvalue.data);
>> +    bpf_map_put(st_link->map);
> 
> Same here. Reading __rcu pointer without rcu_dereference_xxx.

According to the discussion offline, rcu_dereference_protected() will be
called.

> 
> or simply use &st_map->map here. Otherwise, it will also have type 
> mismatch warning.
> 
>> +    kfree(st_link);
>> +}
>> +
>> +static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link 
>> *link,
>> +                        struct seq_file *seq)
>> +{
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_map *map;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    rcu_read_lock();
>> +    map = rcu_dereference(st_link->map);
>> +    if (map)
> 
> map cannot be NULL?

It should not be now after removing detach feature.

> 
>> +        seq_printf(seq, "map_id:\t%d\n", map->id);
>> +    rcu_read_unlock();
>> +}
>> +
>> +static int bpf_struct_ops_map_link_fill_link_info(const struct 
>> bpf_link *link,
>> +                           struct bpf_link_info *info)
>> +{
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_map *map;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    rcu_read_lock();
>> +    map = rcu_dereference(st_link->map);
>> +    if (map)
> 
> Same here.

Ack.

> 
>> +        info->struct_ops.map_id = map->id;
>> +    rcu_read_unlock();
>> +    return 0;
>> +}
>> +
>> +static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>> +    .dealloc = bpf_struct_ops_map_link_dealloc,
>> +    .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>> +    .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>> +};
>> +
>> +int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    struct bpf_struct_ops_link *link = NULL;
>> +    struct bpf_link_primer link_primer;
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
>> +    int err;
>> +
>> +    map = bpf_map_get(attr->link_create.map_fd);
>> +    if (!map)
>> +        return -EINVAL;
>> +
>> +    st_map = (struct bpf_struct_ops_map *)map;
>> +
>> +    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags 
>> & BPF_F_LINK) ||
>> +        /* Pair with smp_store_release() during map_update */
>> +        smp_load_acquire(&st_map->kvalue.state) != 
>> BPF_STRUCT_OPS_STATE_READY) {
>> +        err = -EINVAL;
>> +        goto err_out;
>> +    }
>> +
>> +    link = kzalloc(sizeof(*link), GFP_USER);
>> +    if (!link) {
>> +        err = -ENOMEM;
>> +        goto err_out;
>> +    }
>> +    bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, 
>> &bpf_struct_ops_map_lops, NULL);
>> +    RCU_INIT_POINTER(link->map, map);
>> +
>> +    err = bpf_link_prime(&link->link, &link_primer);
>> +    if (err)
>> +        goto err_out;
>> +
>> +    err = st_map->st_ops->reg(st_map->kvalue.data);
>> +    if (err) {
>> +        bpf_link_cleanup(&link_primer);
>> +        goto err_out;
>> +    }
>> +
>> +    return bpf_link_settle(&link_primer);
>> +
>> +err_out:
>> +    bpf_map_put(map);
>> +    kfree(link);
>> +    return err;
>> +}
>> +
> 
