Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A86AEE37
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 19:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjCGSK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjCGSKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 13:10:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937EA4029
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 10:04:38 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d10so8105404pgt.12
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMUoIkXZYgDNlxpNSwc33IZRA6X8AmU7uKXZjCE8Yww=;
        b=Y3pxJy8YdHvInbURX08mTGg7i2slrmaxQnrzWXc4qDsC/Kxke9P7YnuxghX8xBTVu5
         7an9k0haafez3MG4eeBBaEPg9Qw9YT9Gi1b6MGEQI1OqXabDof/ExPBA/zHPOlv2OKVO
         aDzgd4vF07gKFstbO4vi/HwQwrz0Re62AYs3JLlHRKukpA/qOe9V2NAZuGmjCjDdnEzi
         dyvi0MVlRE+o7OsIzd2uM8tgjBAI/GYAvEjkjsSZRp+NuxU9ZgLphKU/nx+Ybom04ZEW
         +v45Ld6SwdURv9oFSJcXj1LACjQJXrloTw1QrOVGn8cZpMZwyS63UmzrKI3Ur84nXyyb
         gW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMUoIkXZYgDNlxpNSwc33IZRA6X8AmU7uKXZjCE8Yww=;
        b=oq9Nh6M8319ByQf3C/KuqbYR76fK+JugJK+qyCy8yS5em3Z4k5TZymVGbIkoM1hCL+
         QLV+YSpDu9T1ikb2NqZi7kK+QEFZAKhC1r3ZBsHmBf2QRgYNbngjYLJ5X/pJL7Iucnwa
         yfIvGg7xtihC5R4VZ8sKgwwt8kJNqkh6/7e+SSrStIhcUDxJ0xhcdYSWasQ2alENDxRg
         kT/oz5nslBy1cc6Gwxd/XYmvcif+Bldgf45ZBvz06ChHZ5gn1N8smWqQ5a2JuOyFGOIS
         zmUic8G429t5h74EaYIIEAJOtMOUQO/zoKUGdeh75KXs+eSXebxdtKilvHJA1JnWKGyV
         q5Wg==
X-Gm-Message-State: AO0yUKUQGmK8FV3jcjuCAjFJKOgr8Xr9GjyA4hBGBlOGFruru3vxauYX
        UPsN9p66kznbVcAbvmUDbpw=
X-Google-Smtp-Source: AK7set99Hfa1Aijo0cgYMise8q6iBALj9NuRE51bMCzwikFk6e0z2KUCi7DHyHkxOmg3eemI/nMi0A==
X-Received: by 2002:aa7:98de:0:b0:5df:3aa1:10c5 with SMTP id e30-20020aa798de000000b005df3aa110c5mr13021068pfm.14.1678212277457;
        Tue, 07 Mar 2023 10:04:37 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1402? ([2620:10d:c090:400::5:173])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b0059416691b64sm8479044pfn.19.2023.03.07.10.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:04:37 -0800 (PST)
Message-ID: <854d0d60-d637-f892-dd93-227f1cafbfd0@gmail.com>
Date:   Tue, 7 Mar 2023 10:04:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v3 2/8] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-3-kuifeng@meta.com>
 <1e7a3b7b-7693-14d9-9eb4-7a516badba95@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <1e7a3b7b-7693-14d9-9eb4-7a516badba95@linux.dev>
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



On 3/6/23 18:11, Martin KaFai Lau wrote:
> On 3/2/23 5:21 PM, Kui-Feng Lee wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cb837f42b99d..b845be719422 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1396,6 +1396,11 @@ struct bpf_link {
>>       struct work_struct work;
>>   };
>> +struct bpf_struct_ops_link {
>> +    struct bpf_link link;
>> +    struct bpf_map __rcu *map;
> 
> __rcu is only needed after the link_update change in patch 5?
> It is fine to keep it in this patch but please leave a comment in the 
> commit message.
> 
> Does 'struct bpf_struct_ops_link' have to be in bpf.h?
> 
>> +};
>> +
>>   struct bpf_link_ops {
>>       void (*release)(struct bpf_link *link);
>>       void (*dealloc)(struct bpf_link *link);
>> @@ -1964,6 +1969,7 @@ int bpf_link_new_fd(struct bpf_link *link);
>>   struct file *bpf_link_new_file(struct bpf_link *link, int 
>> *reserved_fd);
>>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>>   struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>> +int bpf_struct_ops_link_create(union bpf_attr *attr);
>>   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>>   int bpf_obj_get_user(const char __user *pathname, int flags);
>> @@ -2308,6 +2314,11 @@ static inline void bpf_link_put(struct bpf_link 
>> *link)
>>   {
>>   }
>> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
> 
> Is this currently under '#ifdef CONFIG_BPF_SYSCALL' alone?
> 
> Not sure if it is correct. Please double check.
> 
> ifeq ($(CONFIG_BPF_JIT),y)
> obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
> obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
> obj-${CONFIG_BPF_LSM} += bpf_lsm.o
> endif
> 
> obj-$(CONFIG_BPF_SYSCALL) += syscall.o ...

You are right! Should be under CONFIG_BPF_JIT.

> 
>> +
>>   static inline int bpf_obj_get_user(const char __user *pathname, int 
>> flags)
>>   {
>>       return -EOPNOTSUPP;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17afd2b35ee5..cd0ff39981e8 100644
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
>> +            __u32        map_fd;        /* eBPF struct_ops to attach */
> 
> nit. Remove eBPF. "struct_ops to attach"
> 
>> +        };
>>           union {
>>               __u32        target_fd;    /* object to attach to */
>>               __u32        target_ifindex; /* target ifindex */
>> @@ -6354,6 +6361,9 @@ struct bpf_link_info {
>>           struct {
>>               __u32 ifindex;
>>           } xdp;
>> +        struct {
>> +            __u32 map_id;
>> +        } struct_ops;
>>       };
>>   } __attribute__((aligned(8)));
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index bba03b6b010b..9ec675576d97 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -14,6 +14,7 @@
>>   enum bpf_struct_ops_state {
>>       BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_READY,
> 
> Please add it to the end. Although it is not in uapi, try not to disrupt 
> the userspace introspection tool if it does not have to.
> 

Got it!

>>       BPF_STRUCT_OPS_STATE_INUSE,
>>       BPF_STRUCT_OPS_STATE_TOBEFREE,
>>   };
>> @@ -494,11 +495,19 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    bpf_map_inc(map);
>> -
>>       set_memory_rox((long)st_map->image, 1);
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
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
>> @@ -514,7 +523,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>        */
>>       set_memory_nx((long)st_map->image, 1);
>>       set_memory_rw((long)st_map->image, 1);
>> -    bpf_map_put(map);
>>   reset_unlock:
>>       bpf_struct_ops_map_put_progs(st_map);
>> @@ -532,10 +540,15 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>       struct bpf_struct_ops_map *st_map;
>>       st_map = (struct bpf_struct_ops_map *)map;
>> +    if (st_map->map.map_flags & BPF_F_LINK)
>> +        return -EOPNOTSUPP;
>> +
>>       prev_state = cmpxchg(&st_map->kvalue.state,
>>                    BPF_STRUCT_OPS_STATE_INUSE,
>>                    BPF_STRUCT_OPS_STATE_TOBEFREE);
>>       switch (prev_state) {
>> +    case BPF_STRUCT_OPS_STATE_READY:
>> +        return -EOPNOTSUPP;
> 
> If this case never happens, this case should be removed. The WARN in the 
> default case at the end is a better handling

No, it never happens.  I will remove it.

> 
>>       case BPF_STRUCT_OPS_STATE_INUSE:
>>           st_map->st_ops->unreg(&st_map->kvalue.data);
>>           bpf_map_put(map);
>> @@ -618,7 +631,7 @@ static void bpf_struct_ops_map_free_rcu(struct 
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
>> @@ -714,3 +727,100 @@ void bpf_struct_ops_put(const void *kdata)
>>       bpf_map_put(&st_map->map);
>>   }
>> +
>> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>> +{
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_struct_ops_map *st_map;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    if (st_link->map) {
> 
> Will map ever be NULL

No, it is never NULL after removing the detach feature.

> 
>> +        st_map = (struct bpf_struct_ops_map *)st_link->map;
>> +        st_map->st_ops->unreg(&st_map->kvalue.data);
>> +        bpf_map_put(st_link->map);
>> +    }
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
>> +    rcu_read_lock_trace();
> 
> Should it be rcu_read_lock()?

Got it!

> 
>> +    map = rcu_dereference(st_link->map);
>> +    if (map)
>> +        seq_printf(seq, "map_id:\t%d\n", map->id);
>> +    rcu_read_unlock_trace();
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
>> +    rcu_read_lock_trace();
>> +    map = rcu_dereference(st_link->map);
>> +    if (map)
>> +        info->struct_ops.map_id = map->id;
>> +    rcu_read_unlock_trace();
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
>> +    link->map = map;
> 
> RCU_INIT_POINTER().

Got it!

> 
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
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 358a0e40555e..3db4938212d6 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2743,10 +2743,11 @@ void bpf_link_inc(struct bpf_link *link)
>>   static void bpf_link_free(struct bpf_link *link)
>>   {
>>       bpf_link_free_id(link->id);
>> +    /* detach BPF program, clean up used resources */
>>       if (link->prog) {
>> -        /* detach BPF program, clean up used resources */
> 
> This comment move seems unnecessary.
> 
>>           link->ops->release(link);
>>           bpf_prog_put(link->prog);
>> +        /* The struct_ops links clean up map by them-selves. */
> 
> This also seems unnecessary to only spell out for struct_ops link. Each 
> specific link type does its cleanup in ->dealloc.
> 

Got it!

> 
