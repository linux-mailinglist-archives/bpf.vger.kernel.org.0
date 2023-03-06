Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C36AD102
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 23:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCFWDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 17:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCFWDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 17:03:09 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F9C15B
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 14:02:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i5so12102063pla.2
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678140178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uovi7TFxu52OxiZMH40i/ElOkuO39932LhCERlR4WyM=;
        b=irJSB7PJjlSEWMgggN4gda664SIXwA8r36+H43nOev3OrzNGC0CBsFeC2tgkfZU3Dz
         J5SMYet4KzxDnAuGviAz0vdLwz7tyi+EFIneOpBXjYZU4DriN+nlKbeolmG84nlMJFHw
         U2f0lkDci8YWwXGRCAY96PkhT2sl16mC3+QPx1WeFSelUBuWuLxrKeOn783jobdyGmdn
         dRGRUq0fB+kK/ig9eyw0esfY6MbVRKPJNplmJMfs+hi45GGw64gP2GpvfG9LP1Yf5OnH
         FUv5aFlTZDL4Y5EStWdcBdiKOtDExAASSCYEDRGC1Sjiu8XGSlNNYnrB744S7GpPZwvs
         Z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uovi7TFxu52OxiZMH40i/ElOkuO39932LhCERlR4WyM=;
        b=vc43mWz0g1sVA12bLzu2yf/Yl4x8ArjXhdcOztS3o0ZYuc6iIP/4M5H5qd8ISMQC4+
         FYfhXrfXRvICEEnKTYLUmE7Gkf/JM9G7lIABGUUMOjaco9qdFQIEPZo2X2jOdciXfxVn
         Zm1asJktNmpWzGqAceInhkCpLTUFsYnNHt2GdL7lQv+Jd2tKciG/Dk/dkucg9k/hxznE
         m04xBg1fjWUA5LvJH9xbT+59Kus5XHfabk3vVsnQsFnvi8ypLzjN15YWmNjtPmxU8Zc1
         Q2VKQ48U8Q3OYPx8oI6jhYt8P72Cr/jdRV3PvV0msfQ9Q8xXnv4H66YN48nPbyRybpAf
         P1ZQ==
X-Gm-Message-State: AO0yUKWtlKPp2PQR3VOGxVBwyVyn25CmNE4fZPDXZ2hrB5ITwU8YZvul
        iM3Kwa8oF6rXUzBE3xV2UCg=
X-Google-Smtp-Source: AK7set/JVExOBvZO62IjRDqRM/J8WNzjeE2CGgh4dTOwB3HbjgXMeW916iHjjOfq48MstKv6NwyE+w==
X-Received: by 2002:a05:6a20:a111:b0:c7:5e7a:d536 with SMTP id q17-20020a056a20a11100b000c75e7ad536mr11833779pzk.17.1678140177870;
        Mon, 06 Mar 2023 14:02:57 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e1::130d? ([2620:10d:c090:400::5:17e4])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b005abc30d9445sm6708526pfn.180.2023.03.06.14.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 14:02:57 -0800 (PST)
Message-ID: <37de8de2-2845-e430-2cdb-55c144996e0c@gmail.com>
Date:   Mon, 6 Mar 2023 14:02:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v3 2/8] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US, en-ZW
To:     Stanislav Fomichev <sdf@google.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-3-kuifeng@meta.com> <ZAZLuF/ZfbX3RTX1@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZAZLuF/ZfbX3RTX1@google.com>
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



On 3/6/23 12:23, Stanislav Fomichev wrote:
> On 03/02, Kui-Feng Lee wrote:
>> BPF struct_ops maps are employed directly to register TCP Congestion
>> Control algorithms. Unlike other BPF programs that terminate when
>> their links gone. The link of a BPF struct_ops map provides a uniform
>> experience akin to other types of BPF programs.
> 
>> bpf_links are responsible for registering their associated
>> struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
>> set to create a bpf_link, while a structs without this flag behaves in
>> the same manner as before and is registered upon updating its value.
> 
>> The BPF_LINK_TYPE_STRUCT_OPS serves a dual purpose. Not only is it
>> used to craft the links for BPF struct_ops programs, but also to
>> create links for BPF struct_ops them-self.  Since the links of BPF
>> struct_ops programs are only used to create trampolines internally,
>> they are never seen in other contexts. Thus, they can be reused for
>> struct_ops themself.
> 
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf.h            |  11 +++
>>   include/uapi/linux/bpf.h       |  12 +++-
>>   kernel/bpf/bpf_struct_ops.c    | 118 +++++++++++++++++++++++++++++++--
>>   kernel/bpf/syscall.c           |  26 +++++---
>>   tools/include/uapi/linux/bpf.h |  12 +++-
>>   5 files changed, 164 insertions(+), 15 deletions(-)
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cb837f42b99d..b845be719422 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1396,6 +1396,11 @@ struct bpf_link {
>>       struct work_struct work;
>>   };
> 
>> +struct bpf_struct_ops_link {
>> +    struct bpf_link link;
>> +    struct bpf_map __rcu *map;
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
> 
>>   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>>   int bpf_obj_get_user(const char __user *pathname, int flags);
>> @@ -2308,6 +2314,11 @@ static inline void bpf_link_put(struct bpf_link 
>> *link)
>>   {
>>   }
> 
>> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
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
> 
>> @@ -1266,6 +1267,9 @@ enum {
> 
>>   /* Create a map that is suitable to be an inner map with dynamic max 
>> entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
> 
>>   /* Flags for BPF_PROG_QUERY. */
>> @@ -1507,7 +1511,10 @@ union bpf_attr {
>>       } task_fd_query;
> 
>>       struct { /* struct used by BPF_LINK_CREATE command */
>> -        __u32        prog_fd;    /* eBPF program to attach */
>> +        union {
>> +            __u32        prog_fd;    /* eBPF program to attach */
>> +            __u32        map_fd;        /* eBPF struct_ops to attach */
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
> 
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index bba03b6b010b..9ec675576d97 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -14,6 +14,7 @@
> 
>>   enum bpf_struct_ops_state {
>>       BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_READY,
>>       BPF_STRUCT_OPS_STATE_INUSE,
>>       BPF_STRUCT_OPS_STATE_TOBEFREE,
>>   };
>> @@ -494,11 +495,19 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
> 
>> -    bpf_map_inc(map);
>> -
>>       set_memory_rox((long)st_map->image, 1);
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
>> +        /* Let bpf_link handle registration & unregistration.
>> +         *
>> +         * Pair with smp_load_acquire() during lookup_elem().
>> +         */
>> +        smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
> 
> Any reason not to create a link here and return to the user? (without
> extra link_create API)
> 

We want the ability to substitute an existing struct_ops with a 
different one. If we establish a link here, that implies we can't load 
multiple struct_ops and switch between them since the struct_ops will be 
registered instantly. Likewise, bpf_map_update_elem() is not supposed to 
generate a new FD.

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
> 
>>   reset_unlock:
>>       bpf_struct_ops_map_put_progs(st_map);
>> @@ -532,10 +540,15 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>       struct bpf_struct_ops_map *st_map;
> 
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
> 
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
>>           link->ops->release(link);
>>           bpf_prog_put(link->prog);
>> +        /* The struct_ops links clean up map by them-selves. */
>>       }
>>       /* free bpf_link and its containing memory */
>>       link->ops->dealloc(link);
>> @@ -2802,16 +2803,19 @@ static void bpf_link_show_fdinfo(struct 
>> seq_file *m, struct file *filp)
>>       const struct bpf_prog *prog = link->prog;
>>       char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
> 
>> -    bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>>       seq_printf(m,
>>              "link_type:\t%s\n"
>> -           "link_id:\t%u\n"
>> -           "prog_tag:\t%s\n"
>> -           "prog_id:\t%u\n",
>> +           "link_id:\t%u\n",
>>              bpf_link_type_strs[link->type],
>> -           link->id,
>> -           prog_tag,
>> -           prog->aux->id);
>> +           link->id);
>> +    if (prog) {
>> +        bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>> +        seq_printf(m,
>> +               "prog_tag:\t%s\n"
>> +               "prog_id:\t%u\n",
>> +               prog_tag,
>> +               prog->aux->id);
>> +    }
>>       if (link->ops->show_fdinfo)
>>           link->ops->show_fdinfo(link, m);
>>   }
>> @@ -4286,7 +4290,8 @@ static int bpf_link_get_info_by_fd(struct file 
>> *file,
> 
>>       info.type = link->type;
>>       info.id = link->id;
>> -    info.prog_id = link->prog->aux->id;
>> +    if (link->prog)
>> +        info.prog_id = link->prog->aux->id;
> 
>>       if (link->ops->fill_link_info) {
>>           err = link->ops->fill_link_info(link, &info);
>> @@ -4549,6 +4554,9 @@ static int link_create(union bpf_attr *attr, 
>> bpfptr_t uattr)
>>       if (CHECK_ATTR(BPF_LINK_CREATE))
>>           return -EINVAL;
> 
>> +    if (attr->link_create.attach_type == BPF_STRUCT_OPS)
>> +        return bpf_struct_ops_link_create(attr);
>> +
>>       prog = bpf_prog_get(attr->link_create.prog_fd);
>>       if (IS_ERR(prog))
>>           return PTR_ERR(prog);
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 17afd2b35ee5..cd0ff39981e8 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>>       BPF_PERF_EVENT,
>>       BPF_TRACE_KPROBE_MULTI,
>>       BPF_LSM_CGROUP,
>> +    BPF_STRUCT_OPS,
>>       __MAX_BPF_ATTACH_TYPE
>>   };
> 
>> @@ -1266,6 +1267,9 @@ enum {
> 
>>   /* Create a map that is suitable to be an inner map with dynamic max 
>> entries */
>>       BPF_F_INNER_MAP        = (1U << 12),
>> +
>> +/* Create a map that will be registered/unregesitered by the backed 
>> bpf_link */
>> +    BPF_F_LINK        = (1U << 13),
>>   };
> 
>>   /* Flags for BPF_PROG_QUERY. */
>> @@ -1507,7 +1511,10 @@ union bpf_attr {
>>       } task_fd_query;
> 
>>       struct { /* struct used by BPF_LINK_CREATE command */
>> -        __u32        prog_fd;    /* eBPF program to attach */
>> +        union {
>> +            __u32        prog_fd;    /* eBPF program to attach */
>> +            __u32        map_fd;        /* eBPF struct_ops to attach */
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
> 
>> -- 
>> 2.30.2
> 
