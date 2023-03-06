Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD26AD0C3
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 22:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCFVpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 16:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCFVpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 16:45:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ACB497FB
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 13:45:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so14585610pjb.1
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678139131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eGEcFWYIwpyGAL28jJ0lCoqT4uOscdCUID+Y2/OM7g=;
        b=IAYXHxdjDy7bqTfdQYPZDgusaYEnxTykpHqLZPYoejQ3Uic3voZbRUs/w2BAiSv0QJ
         8TRGyqsd8+FBhYL9ts1Dg9INFGjw6Qw/diIscGUW1MQzLVrJ4hrA/L6aR5ygy1Uy+3ee
         EvBCdCtRGqmOXsWz026PU84dOx9ejOON1cH4+L8vSPC7MVtVTOHnF25z8aDHCsNsyXFa
         zyEbvGgdMhzMSNQWBVMGe8bYRQydk1qg4StlFXf0roQZ4nM1pVGss/K0nqixT+wk1wPf
         IV9DVl3htVim0VnsyLUwlQavfduy/PDiEMz++Ueq977mQDUv5tAuBzyy2tf/FLbyxjFq
         k0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eGEcFWYIwpyGAL28jJ0lCoqT4uOscdCUID+Y2/OM7g=;
        b=jraRzZbq73QDWESCmLZyK7p0VjEdx9adA8rIu2Q3Mtbbi6/OTdynyV9SNE72LTmMUm
         4757fNz4JGytvfsMSuZxbrcABydmssHYqFef+i/jMK+c8KvPY71zt+VhzvOukaqqQK5v
         e+iPrqXE1FqGg7RE79TVHdNS4okCImlwaLU56peLaI9IN5V1S/qNvn9Af5eTcByInnKT
         Dn4sSjcQ1C3AW/flj6Yd8qr++3wSdvGdoaG9E/56B+ypC2Kv1TxntnqRrgsptpeYeINU
         kcvsXej9OhPQcAHrwmSdPGSPNSvxXevEj7EVJkwhrcgCti7QXoSuFfnL2gpyACq7k67R
         WgFA==
X-Gm-Message-State: AO0yUKXbBe3pQ7pdeE0kqxRMbIGemUNRriv9DZRDfFjvMI2XQPfabeW2
        ACFgQrikDAFaXOyFdZHl1Pqn8fFj7xw=
X-Google-Smtp-Source: AK7set+IS87UR0YEd6sOCd3lAa90BVJEIoXp1tdQda7oTmjDz3vM7W/sfRxVcSJ79Uugp1RTNF5bMA==
X-Received: by 2002:a05:6a20:7faa:b0:c7:7afa:5016 with SMTP id d42-20020a056a207faa00b000c77afa5016mr16073236pzj.9.1678139131503;
        Mon, 06 Mar 2023 13:45:31 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e1::130d? ([2620:10d:c090:400::5:17e4])
        by smtp.gmail.com with ESMTPSA id n9-20020a654cc9000000b004fab4455748sm6758437pgt.75.2023.03.06.13.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:45:31 -0800 (PST)
Message-ID: <6b1dbf32-67ff-027e-0d57-c3273339dc97@gmail.com>
Date:   Mon, 6 Mar 2023 13:45:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Maintain the refcount of struct_ops
 maps directly.
Content-Language: en-US, en-ZW
To:     Stanislav Fomichev <sdf@google.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-2-kuifeng@meta.com> <ZAZIn9DrvvYh5/QL@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZAZIn9DrvvYh5/QL@google.com>
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



On 3/6/23 12:10, Stanislav Fomichev wrote:
> On 03/02, Kui-Feng Lee wrote:
>> The refcount of the kvalue for struct_ops was quite intricate to keep
>> track of. By no longer utilizing it and replacing it with the refcount
>> from the struct_ops map, this process became more transparent and
>> uncomplicated.
> 
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf.h         |  3 ++
>>   kernel/bpf/bpf_struct_ops.c | 84 ++++++++++++++++++++++---------------
>>   kernel/bpf/syscall.c        | 22 ++++++----
>>   3 files changed, 68 insertions(+), 41 deletions(-)
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8b5d0b4c4ada..cb837f42b99d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -78,6 +78,7 @@ struct bpf_map_ops {
>>       struct bpf_map *(*map_alloc)(union bpf_attr *attr);
>>       void (*map_release)(struct bpf_map *map, struct file *map_file);
>>       void (*map_free)(struct bpf_map *map);
>> +    void (*map_free_rcu)(struct bpf_map *map);
>>       int (*map_get_next_key)(struct bpf_map *map, void *key, void 
>> *next_key);
>>       void (*map_release_uref)(struct bpf_map *map);
>>       void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>> @@ -1869,8 +1870,10 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>>   struct bpf_map *__bpf_map_get(struct fd f);
>>   void bpf_map_inc(struct bpf_map *map);
>>   void bpf_map_inc_with_uref(struct bpf_map *map);
>> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
>>   struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map 
>> *map);
>>   void bpf_map_put_with_uref(struct bpf_map *map);
>> +void bpf_map_free_deferred(struct work_struct *work);
>>   void bpf_map_put(struct bpf_map *map);
>>   void *bpf_map_area_alloc(u64 size, int numa_node);
>>   void *bpf_map_area_mmapable_alloc(u64 size, int numa_node);
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index ece9870cab68..bba03b6b010b 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -58,6 +58,8 @@ struct bpf_struct_ops_map {
>>       struct bpf_struct_ops_value kvalue;
>>   };
> 
>> +static DEFINE_MUTEX(update_mutex);
> 
> Defined but unused?
> 
>> +
>>   #define VALUE_PREFIX "bpf_struct_ops_"
>>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
> 
>> @@ -249,6 +251,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>       struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>>       struct bpf_struct_ops_value *uvalue, *kvalue;
>>       enum bpf_struct_ops_state state;
>> +    s64 refcnt;
> 
>>       if (unlikely(*(u32 *)key != 0))
>>           return -ENOENT;
>> @@ -261,13 +264,13 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>           return 0;
>>       }
> 
>> -    /* No lock is needed.  state and refcnt do not need
>> -     * to be updated together under atomic context.
>> -     */
>>       uvalue = value;
>>       memcpy(uvalue, st_map->uvalue, map->value_size);
>>       uvalue->state = state;
>> -    refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
>> +
>> +    refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
>> +    refcount_set(&uvalue->refcnt,
>> +             refcnt > 0 ? refcnt : 0);
> 
>>       return 0;
>>   }
>> @@ -491,7 +494,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
> 
>> -    refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
> 
>>       set_memory_rox((long)st_map->image, 1);
>> @@ -536,8 +538,7 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>       switch (prev_state) {
>>       case BPF_STRUCT_OPS_STATE_INUSE:
>>           st_map->st_ops->unreg(&st_map->kvalue.data);
>> -        if (refcount_dec_and_test(&st_map->kvalue.refcnt))
>> -            bpf_map_put(map);
>> +        bpf_map_put(map);
>>           return 0;
>>       case BPF_STRUCT_OPS_STATE_TOBEFREE:
>>           return -EINPROGRESS;
>> @@ -582,6 +583,38 @@ static void bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>       bpf_map_area_free(st_map);
>>   }
> 
>> +static void bpf_struct_ops_map_free_wq(struct rcu_head *head)
>> +{
>> +    struct bpf_struct_ops_map *st_map;
>> +
>> +    st_map = container_of(head, struct bpf_struct_ops_map, rcu);
>> +
>> +    /* bpf_map_free_deferred should not be called in a RCU callback. */
>> +    INIT_WORK(&st_map->map.work, bpf_map_free_deferred);
>> +    queue_work(system_unbound_wq, &st_map->map.work);
>> +}
>> +
>> +static void bpf_struct_ops_map_free_rcu(struct bpf_map *map)
>> +{
>> +    struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +
>> +    /* Wait for a grace period of RCU. Then, post the map_free
>> +     * work to the system_unbound_wq workqueue to free resources.
>> +     *
>> +     * The struct_ops's function may switch to another struct_ops.
>> +     *
>> +     * For example, bpf_tcp_cc_x->init() may switch to
>> +     * another tcp_cc_y by calling
>> +     * setsockopt(TCP_CONGESTION, "tcp_cc_y").
>> +     * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
>> +     * and its refcount may reach 0 which then free its
>> +     * trampoline image while tcp_cc_x is still running.
> 
> "is still running" where? Why existing deferred work doesn't protect
> against this condition?

bpf_module_put() is protected by rcu_read_lock() alone. As the comment 
mentions, setsockopt() can lead to a switch to another algorithm. It is 
exposed to the BPF world as bpf_setscokopt(), so it could potentially 
call bpf_struct_ops_put() while a BPF program is running. In order to 
guarantee we don't free the trampoline while it is still running, we 
have to wait for a grace period.

> 
>> +     *
>> +     * Thus, a rcu grace period is needed here.
>> +     */
>> +    call_rcu(&st_map->rcu, bpf_struct_ops_map_free_wq);
>> +}
>> +
>>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>>   {
>>       if (attr->key_size != sizeof(unsigned int) || attr->max_entries 
>> != 1 ||
>> @@ -646,6 +679,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
>>       .map_alloc_check = bpf_struct_ops_map_alloc_check,
>>       .map_alloc = bpf_struct_ops_map_alloc,
> 
> [..]
> 
>>       .map_free = bpf_struct_ops_map_free,
> 
> Since we have map_free_rcu check in bpf_map_put, does it mean the above
> is not needed?

It will be called by bpf_map_free_deferred().

> 
>> +    .map_free_rcu = bpf_struct_ops_map_free_rcu,
>>       .map_get_next_key = bpf_struct_ops_map_get_next_key,
>>       .map_lookup_elem = bpf_struct_ops_map_lookup_elem,
>>       .map_delete_elem = bpf_struct_ops_map_delete_elem,
>> @@ -660,41 +694,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
>>   bool bpf_struct_ops_get(const void *kdata)
>>   {
>>       struct bpf_struct_ops_value *kvalue;
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
> 
>>       kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
>> +    st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> 
>> -    return refcount_inc_not_zero(&kvalue->refcnt);
>> -}
>> -
>> -static void bpf_struct_ops_put_rcu(struct rcu_head *head)
>> -{
>> -    struct bpf_struct_ops_map *st_map;
>> -
>> -    st_map = container_of(head, struct bpf_struct_ops_map, rcu);
>> -    bpf_map_put(&st_map->map);
>> +    map = __bpf_map_inc_not_zero(&st_map->map, false);
>> +    return !IS_ERR(map);
>>   }
> 
>>   void bpf_struct_ops_put(const void *kdata)
>>   {
>>       struct bpf_struct_ops_value *kvalue;
>> +    struct bpf_struct_ops_map *st_map;
> 
>>       kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
>> -    if (refcount_dec_and_test(&kvalue->refcnt)) {
>> -        struct bpf_struct_ops_map *st_map;
>> -
>> -        st_map = container_of(kvalue, struct bpf_struct_ops_map,
>> -                      kvalue);
>> -        /* The struct_ops's function may switch to another struct_ops.
>> -         *
>> -         * For example, bpf_tcp_cc_x->init() may switch to
>> -         * another tcp_cc_y by calling
>> -         * setsockopt(TCP_CONGESTION, "tcp_cc_y").
>> -         * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
>> -         * and its map->refcnt may reach 0 which then free its
>> -         * trampoline image while tcp_cc_x is still running.
>> -         *
>> -         * Thus, a rcu grace period is needed here.
>> -         */
>> -        call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
>> -    }
>> +    st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
>> +
>> +    bpf_map_put(&st_map->map);
>>   }
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index cda8d00f3762..358a0e40555e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -684,7 +684,7 @@ void bpf_obj_free_fields(const struct btf_record 
>> *rec, void *obj)
>>   }
> 
>>   /* called from workqueue */
>> -static void bpf_map_free_deferred(struct work_struct *work)
>> +void bpf_map_free_deferred(struct work_struct *work)
>>   {
>>       struct bpf_map *map = container_of(work, struct bpf_map, work);
>>       struct btf_field_offs *foffs = map->field_offs;
>> @@ -715,6 +715,15 @@ static void bpf_map_put_uref(struct bpf_map *map)
>>       }
>>   }
> 
>> +static void bpf_map_put_wq(struct bpf_map *map)
>> +{
>> +    INIT_WORK(&map->work, bpf_map_free_deferred);
>> +    /* Avoid spawning kworkers, since they all might contend
>> +     * for the same mutex like slab_mutex.
>> +     */
>> +    queue_work(system_unbound_wq, &map->work);
>> +}
>> +
>>   /* decrement map refcnt and schedule it for freeing via workqueue
>>    * (underlying map implementation ops->map_free() might sleep)
>>    */
>> @@ -724,11 +733,10 @@ void bpf_map_put(struct bpf_map *map)
>>           /* bpf_map_free_id() must be called first */
>>           bpf_map_free_id(map);
>>           btf_put(map->btf);
>> -        INIT_WORK(&map->work, bpf_map_free_deferred);
>> -        /* Avoid spawning kworkers, since they all might contend
>> -         * for the same mutex like slab_mutex.
>> -         */
>> -        queue_work(system_unbound_wq, &map->work);
>> +        if (map->ops->map_free_rcu)
>> +            map->ops->map_free_rcu(map);
>> +        else
>> +            bpf_map_put_wq(map);
>>       }
>>   }
>>   EXPORT_SYMBOL_GPL(bpf_map_put);
>> @@ -1276,7 +1284,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
>>   }
> 
>>   /* map_idr_lock should have been held */
>> -static struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, 
>> bool uref)
>> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
>>   {
>>       int refold;
> 
>> -- 
>> 2.30.2
> 
