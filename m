Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E96BF2DB
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCQUlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 16:41:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F953280
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 13:41:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cn6so6558528pjb.2
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shCffqoUJVpPKoSOSKov6u7KzYqH56wsU723zbrKgVY=;
        b=FP2R9t8LVG6AMgX3x+H9dpWQxrBv8iMX1AjtV+HfYXO+ioOSl7qHmbSOJwrZ/wxpWW
         bueiqqxBu/K0F9hGY4nCOQx8XS8Q3BdItrGd7iCjAohn0mb4dtzhDDEbKYt7BXn08CLV
         I9tzsv9aYiZi4HNmtIdd6ktPL/tgERI6Kjz3Wj5L++qyMlypzIp7FGNTWOIepOPxJOgp
         VBkXgAbq0103g4gVlTERz/DM3gaPnvt5rLOPDUnBFI4KiKaP0s6K+tmh1BL5Wj2qK/xq
         3DVsInOR8eONKcRh4Z9Uno6xlCWQD+fkFuKBOJYajPNWEyw2JrUBeV9e700lWglwpRfz
         seZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shCffqoUJVpPKoSOSKov6u7KzYqH56wsU723zbrKgVY=;
        b=Q+yJ/KF2vQ9Mflcn0fqdSpoGh6PO08N+FjeUUCRCKbNKB2vaBWdxX+tk4bLJXxtdKN
         3YeBMxvcj2ysWxFliRrwmVZ5xU+uKwl4abAtF42DBR5Evp0vbZua0AonjqF1HZDtUKbN
         5kZgMg+D8ucBgV1dWPL6qgSfb1Kf/KEIj93Ej+aQiAA8tbIlsEl7fAwsq+qOCKoM3RoA
         W4OQpg9HTD/9/JdcOk/e7UMpFB3LcniVRcNZq5HqoAf7J4Qub83BxyBXMuohtBuJ2pN2
         vEs8rcbsJcW19JZSXFeH1VtWQr0Vllw+8XYLWacHt+MssLl5PgenbNoLnQaabQQO3LOR
         cySg==
X-Gm-Message-State: AO0yUKVYhIbGFBCaO7CYPCwXIdPNj58MHrImjtJwMw2u9b59vABDugQr
        T4Ai2Ds0XKBM6KTAhPhdlsk=
X-Google-Smtp-Source: AK7set8LlYc3vzejclSAkXqDR6Xu05kST9USqgR7qwOk/fI/dTQJYjhk1OkjrPTZM1f3HB6NdOYjXQ==
X-Received: by 2002:a17:902:da8d:b0:19e:31a3:1a87 with SMTP id j13-20020a170902da8d00b0019e31a31a87mr10690088plx.39.1679085703169;
        Fri, 17 Mar 2023 13:41:43 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id jc7-20020a17090325c700b001a0667822c8sm1954106plb.94.2023.03.17.13.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:41:42 -0700 (PDT)
Message-ID: <d5e2824d-43e2-1392-ccef-5fe27dcf444b@gmail.com>
Date:   Fri, 17 Mar 2023 13:41:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Retire the struct_ops map
 kvalue->refcnt.
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-2-kuifeng@meta.com>
 <d77e2767-f8cf-14f0-a72b-47e9343ecc75@linux.dev>
Content-Language: en-US, en-ZW
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d77e2767-f8cf-14f0-a72b-47e9343ecc75@linux.dev>
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



On 3/17/23 09:47, Martin KaFai Lau wrote:
> On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1943,6 +1943,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>>   struct bpf_map *__bpf_map_get(struct fd f);
>>   void bpf_map_inc(struct bpf_map *map);
>>   void bpf_map_inc_with_uref(struct bpf_map *map);
>> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
>>   struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map 
>> *map);
>>   void bpf_map_put_with_uref(struct bpf_map *map);
>>   void bpf_map_put(struct bpf_map *map);
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 38903fb52f98..2a854e9cee52 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -58,6 +58,8 @@ struct bpf_struct_ops_map {
>>       struct bpf_struct_ops_value kvalue;
>>   };
>> +static DEFINE_MUTEX(update_mutex);
> 
> There has been a comment on the unused "update_mutex" since v3 and v5:
> 
> "...This is only used in patch 5 of this set. Please move it there..."

Got it! Sorry about that.  I moved it to patch 5 in v6, somehow, it
appears in patch 1 again in v7. I must do something wrong during
rebasing.


> 
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
>> @@ -267,7 +270,14 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>       uvalue = value;
>>       memcpy(uvalue, st_map->uvalue, map->value_size);
>>       uvalue->state = state;
>> -    refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
>> +
>> +    /* This value offers the user space a general estimate of how
>> +     * many sockets are still utilizing this struct_ops for TCP
>> +     * congestion control. The number might not be exact, but it
>> +     * should sufficiently meet our present goals.
>> +     */
>> +    refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
>> +    refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
>>       return 0;
>>   }
>> @@ -491,7 +501,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
>>       set_memory_rox((long)st_map->image, 1);
>> @@ -536,8 +545,7 @@ static int bpf_struct_ops_map_delete_elem(struct 
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
>> @@ -570,7 +578,7 @@ static void 
>> bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
>>       kfree(value);
>>   }
>> -static void bpf_struct_ops_map_free(struct bpf_map *map)
>> +static void bpf_struct_ops_map_free_nosync(struct bpf_map *map)
> 
> nit. __bpf_struct_ops_map_free() is the usual alternative name to use in 
> this case.

Got it!

> 
>>   {
>>       struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> @@ -582,6 +590,25 @@ static void bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>       bpf_map_area_free(st_map);
>>   }
>> +static void bpf_struct_ops_map_free(struct bpf_map *map)
>> +{
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
>> +    synchronize_rcu_tasks();
> 
> synchronize_rcu_mult(call_rcu, call_rcu_tasks) to wait both in parallel 
> (credit to Paul's tip).
> 

Nice!


> 
