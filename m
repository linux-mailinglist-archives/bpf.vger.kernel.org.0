Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E66AD310
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 00:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCFXyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 18:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCFXyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 18:54:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67C55076
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 15:54:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y2so11547887pjg.3
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 15:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678146873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n48/nYegX7ZrbQUCY+Dv0u/fZ1JZzaZbyCBIv1zZoDI=;
        b=GGhND0fiLkhYv1w15N8ipxFBH0MpAbvEAHTUHRkbgqT7dsAbnUBTSG71LKPB+l/Ww4
         wVTrEcb4JEj0alRPtiTm6ncfcTgzFJIqsAuYr2HJK2kzcZ/AKjVxrm27QKgIar2jx0UO
         7tkVq2AxdZoxJ4/r9LekGN7jhT/TURa8zO/GphnUJwuj+ReuETU5wSMAvGBYF5w/r8s7
         z+896Sa/DC1DyNHfXJl9iY1NFXCDQQR+3kv5+bp/Mp57GvPV+Shq/VkoLGwAjRnXeiop
         afSvG953ItQsSQD7kf8Spb3uGUaHxuBe17mwkrW2uw3Djhxau5nrMt3k2owANOv/tEfo
         SViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678146873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n48/nYegX7ZrbQUCY+Dv0u/fZ1JZzaZbyCBIv1zZoDI=;
        b=tLzQ1/3ak9wuQfhC+P+7KGmOY2z5jC0xyzsxMatzsnZ+VgAqgSxBLbE9k+9lMbJZzi
         GdAcXTggb/wCFOxqX/Qbu6ww3yXGPY8BsCxeaiQ9z7xfojj0TTZOJ31xppDaJ6WUxA33
         OERt6HFqSPcHBA87Ibiw+VoYcSAvL+dr0VoOt9tggL7Eenw5FgtXaqS0cQ/S1he2zuHA
         l0SyAt5yXA7wB67ITaPLAl89diC8kz/HXhcCGc8Uu3+DHhcv6JYtdClNZi00ojBexLj8
         IJ7ycCcmX1CYhDf+bJ9tYTDvj3kxr/Z8hK3TRVfL351QjlPYCxUunCjaG2CDt4EKqYxG
         FvqA==
X-Gm-Message-State: AO0yUKUh1TUxFrpHZWInpchE7NUNmT1wdV9dL3tQDF8KnB8MHH/cqQwP
        i8PJf4+LTSmRoDfRPAkmVGU=
X-Google-Smtp-Source: AK7set/yjSMokWd4IxaWedsCFjndWmCESNee7h/McuVofeVQXVeOjz4uIWODMsLHRXPHQfNZu4TuUg==
X-Received: by 2002:a17:902:dad0:b0:19e:b6b0:6b3 with SMTP id q16-20020a170902dad000b0019eb6b006b3mr8288304plx.15.1678146873001;
        Mon, 06 Mar 2023 15:54:33 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e1::130d? ([2620:10d:c090:400::5:17e4])
        by smtp.gmail.com with ESMTPSA id kc5-20020a17090333c500b00183c67844aesm2562957plb.22.2023.03.06.15.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 15:54:32 -0800 (PST)
Message-ID: <d0001e7c-1f51-4c92-0b6d-bd92615375b8@gmail.com>
Date:   Mon, 6 Mar 2023 15:54:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Maintain the refcount of struct_ops
 maps directly.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-2-kuifeng@meta.com>
 <39ab0ec2-2e8a-2de9-9603-5c5468ee9a1a@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <39ab0ec2-2e8a-2de9-9603-5c5468ee9a1a@linux.dev>
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



On 3/6/23 15:16, Martin KaFai Lau wrote:
> On 3/2/23 5:21 PM, Kui-Feng Lee wrote:
>> The refcount of the kvalue for struct_ops was quite intricate to keep
>> track of. By no longer utilizing it and replacing it with the refcount
>> from the struct_ops map, this process became more transparent and
>> uncomplicated.
> 
> The patch's subject is not very clear. may be 'Retire the struct_ops map 
> kvalue->refcnt' better reflect what the patch is doing?
> 
> The commit message also needs details on the major change and the reason 
> for the change. eg. Why freeing the struct_ops map needs to go through 
> the rcu grace period and it is the reason on the rcu related changes in 
> this patch.
> Why retiring kvalue->refcnt is needed for (or can simplify?) the later 
> patches?

Sure!

> 
>> @@ -261,13 +264,13 @@ int bpf_struct_ops_map_sys_lookup_elem(struct 
>> bpf_map *map, void *key,
>>           return 0;
>>       }
>> -    /* No lock is needed.  state and refcnt do not need
>> -     * to be updated together under atomic context.
>> -     */
> 
> This comment is still valid in this patch?
> 
>>       uvalue = value;
>>       memcpy(uvalue, st_map->uvalue, map->value_size);
>>       uvalue->state = state;
>> -    refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
>> +
>> +    refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
>> +    refcount_set(&uvalue->refcnt,
>> +             refcnt > 0 ? refcnt : 0);
> 
> nit. max_t().
> 
> It also needs comment on why it will work or at least good enough.

Got it.

> 
>>       return 0;
>>   }
>> @@ -491,7 +494,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    refcount_set(&kvalue->refcnt, 1);
>>       bpf_map_inc(map);
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
>>       .map_free = bpf_struct_ops_map_free,
>> +    .map_free_rcu = bpf_struct_ops_map_free_rcu,
> 
> just came to my mind. Instead of having a rcu callback, 
> synchronize_rcu() can be called in bpf_struct_ops_map_free(). Then the 
> '.map_free_rcu' addition and its related change is not needed.
> 

synchronize_rcu() probably blocks other subsystem, right?

