Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA66B1517
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 23:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCHWay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 17:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCHWax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 17:30:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365485354
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 14:30:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p20so3695plw.13
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678314652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pg9IvyYbFyATfRx5MT6I6cru0PrWjnNVQw8cQcBw0ng=;
        b=IyJSV7RgUyCC0tCa55DqrU0PDBq5sCN8Ml02H8Let1zMTdwv+GA9tAcG6QzPr7ZYwQ
         NkBy6AMniFfbqCxSO6g/a5d+cwqqqoaYDMuC5aGvEshWtxkkK0vOcuPYGfMkc9FMG1ad
         eu+Y7PFIm+cjx74La1TXZEkeK+tiOWw9DaRgqLnHxaiUEii+i+h3sGD775qDn/ZGEmva
         dAloAp1z8+cf2fnfINboX6o2e2ci99deXC96x8GYt+uzeXmXKyEVJTc4v+xnbQguIRuw
         4EONRp2pDOWvKklijq2gb8S65WPUcnPdg0L8uYGW/h9MVKC9lz9ChLMk1oNVd/33DzXh
         SPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678314652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pg9IvyYbFyATfRx5MT6I6cru0PrWjnNVQw8cQcBw0ng=;
        b=17ycQxWQZ3IYh9HcyxIB5s1XsDH3BBCp1fKjk8iKHEaEKFO61DFBaY+DSm0uHInWWr
         YYFIHwOgpvvLAsI7JDzPBp5/wlcb/eHwUoSpLoOljwQ0R9jfAC7fMMt7L58CMCwQ5BoC
         yIjgJgo/ug05gWujl2ZUEqgEzglbJtnD5By06wfHkwVH7lhk3retto5x16Tu3s2sRmcL
         sawWAVMS7uJ6F3zkDPS0gjJUGRcV2M0Dfai27WolPD088Az+NJ0KB0T+vrF6ajSRfTpj
         wGVIrpOucd6xtLQ4HaQsWkcagq9/E0p1m4AeSeixVomUoITwoU5CA560wOk1Wgrr1X4F
         jOxQ==
X-Gm-Message-State: AO0yUKU8JvUEsnFRarNTddaVXmGgWs96e4YX87i42X7B24I71SLAY3Ci
        s7VERh7WOb5+sgcbWv+cUGo=
X-Google-Smtp-Source: AK7set8rwxvKaIYDaeb381gPwvjPoGZapGyuFpMB2Ed+MFmGr/e0bNWXXdzZ2OTQHd51UPH5MjvUQA==
X-Received: by 2002:a17:902:ecc1:b0:19d:ee88:b4d7 with SMTP id a1-20020a170902ecc100b0019dee88b4d7mr25030294plh.25.1678314651771;
        Wed, 08 Mar 2023 14:30:51 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::1660? ([2620:10d:c090:400::5:78e2])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709028c8400b0019c33ee4730sm10235975plo.146.2023.03.08.14.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:30:51 -0800 (PST)
Message-ID: <1bea11ec-4046-67ec-8e6b-e5c9baaf3082@gmail.com>
Date:   Wed, 8 Mar 2023 14:30:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 1/8] bpf: Retire the struct_ops map
 kvalue->refcnt.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-2-kuifeng@meta.com>
 <0686c1bc-c216-6e76-a9e7-65f1c102d4ab@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <0686c1bc-c216-6e76-a9e7-65f1c102d4ab@linux.dev>
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



On 3/8/23 10:30, Martin KaFai Lau wrote:
> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 6792a7940e1e..50cfc2388cbc 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -78,6 +78,7 @@ struct bpf_map_ops {
>>       struct bpf_map *(*map_alloc)(union bpf_attr *attr);
>>       void (*map_release)(struct bpf_map *map, struct file *map_file);
>>       void (*map_free)(struct bpf_map *map);
>> +    void (*map_free_rcu)(struct bpf_map *map);
> 
> This is no longer needed...
> 
>>       int (*map_get_next_key)(struct bpf_map *map, void *key, void 
>> *next_key);
>>       void (*map_release_uref)(struct bpf_map *map);
>>       void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>> @@ -1934,6 +1935,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>>   struct bpf_map *__bpf_map_get(struct fd f);
>>   void bpf_map_inc(struct bpf_map *map);
>>   void bpf_map_inc_with_uref(struct bpf_map *map);
>> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
>>   struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map 
>> *map);
>>   void bpf_map_put_with_uref(struct bpf_map *map);
>>   void bpf_map_put(struct bpf_map *map);
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 38903fb52f98..9e097fcc9cf4 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -58,6 +58,8 @@ struct bpf_struct_ops_map {
>>       struct bpf_struct_ops_value kvalue;
>>   };
>> +static DEFINE_MUTEX(update_mutex);
> 
> Please address or reply to the earlier review comments. Stan had 
> mentioned in v3 that this mutex is unused in this patch.
> 
> This is only used in patch 5 of this set. Please move it there.

I will address this.

> 
>> +
>>   #define VALUE_PREFIX "bpf_struct_ops_"
>>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
>> @@ -249,6 +251,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>       struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>>       struct bpf_struct_ops_value *uvalue, *kvalue;
>>       enum bpf_struct_ops_state state;
>> +    s64 refcnt;
>>       if (unlikely(*(u32 *)key != 0))
>>           return -ENOENT;
>> @@ -267,7 +270,9 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>       uvalue = value;
>>       memcpy(uvalue, st_map->uvalue, map->value_size);
>>       uvalue->state = state;
>> -    refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
>> +
>> +    refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
>> +    refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
> 
> Please explain a few words that why it will work good enough and no need 
> to be very accurate (eg. it is for introspection purpose to give an idea 
> on how many refcnts are held by a subsystem, eg tcp_sock ...). This was 
> also a comment given in v3.

Sure

> 
>>       return 0;
>>   }
>> @@ -491,7 +496,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
>>       set_memory_rox((long)st_map->image, 1);
>> @@ -536,8 +540,7 @@ static int bpf_struct_ops_map_delete_elem(struct 
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
>> @@ -574,6 +577,19 @@ static void bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>   {
>>       struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +    /* The struct_ops's function may switch to another struct_ops.
>> +     *
>> +     * For example, bpf_tcp_cc_x->init() may switch to
>> +     * another tcp_cc_y by calling
>> +     * setsockopt(TCP_CONGESTION, "tcp_cc_y").
>> +     * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
>> +     * and its refcount may reach 0 which then free its
>> +     * trampoline image while tcp_cc_x is still running.
>> +     *
>> +     * Thus, a rcu grace period is needed here.
>> +     */
>> +    synchronize_rcu();
>> +
>>       if (st_map->links)
>>           bpf_struct_ops_map_put_progs(st_map);
>>       bpf_map_area_free(st_map->links);
>> @@ -676,41 +692,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
>>   bool bpf_struct_ops_get(const void *kdata)
>>   {
>>       struct bpf_struct_ops_value *kvalue;
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
>>       kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
>> +    st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
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
>>   void bpf_struct_ops_put(const void *kdata)
>>   {
>>       struct bpf_struct_ops_value *kvalue;
>> +    struct bpf_struct_ops_map *st_map;
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
>> index f406dfa13792..03273cddd6bd 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1288,7 +1288,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
>>   }
>>   /* map_idr_lock should have been held */
> 
> This comment needs to change, eg.
> map_idr_lock should have been held or the map is protected by rcu gp....
> 

Sure.

>> -static struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, 
>> bool uref)
>> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
>>   {
>>       int refold;
> 
