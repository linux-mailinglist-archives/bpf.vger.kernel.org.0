Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BC6BC257
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 01:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCPAVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 20:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCPAVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 20:21:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845699240
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:21:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id fd25so201298pfb.1
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678926096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9cnDkjp+XUS22J1p/3zWRPZvDZoSOF2QZaWCC2gpuc=;
        b=HnSidiHrLC4xtQuPD96o1rhGVAyhaKzR9pdPekeI06vLUv7vPR9fYGdkKKlg+tIr2X
         V/HzYGzR0NFDzQQH+5WMS0tERNqeJfJZipmvTEumZ39TdzSAa/02yoTu6NPJydsmmgp9
         72tlVX+05+JFbG8MWI8hgWu8uE01/9tzVQd0YW7I96YBmdkQBGVCu7peRb3wdh+tF5/j
         BUyIjLj9s2zYTd9sxpSuQBqalV9ztim7Cnp5QbuoRYBJrASiOD/SuOgoHpQXHkBK/RYc
         lCocynNAn4CVYBrj0sx4XU2JB23PZ1LRykf0m1mOI0OxTx0eapXlcJxzIaerJ9adiRbJ
         sRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9cnDkjp+XUS22J1p/3zWRPZvDZoSOF2QZaWCC2gpuc=;
        b=6Tzr5TE2LhOzGsvHtZS4r3+7N/EIX6cfj3uhrVLvMzhntYD1TQloDcGIvU6nTF1K4W
         9Aj9VljIZ4Bg5U21z8PvFD1ldGvr13M5xrOvdPAuxZPs+pQhLPCrlazt7tdM1qyIzHUk
         OJ6+1KEHlVWZ67FwS/IGsEL6QRf3mfAjrqpiwWWpizkevIlw4Yrgkofdii4ACDDMybWC
         iqr2jtUNiNCSlq7+cDlLoOxqjQRJYw0Ey5mFjgBdm5QT+2Y8BIlVGbsr5jdH3C7l1Mzs
         JAjQTcCiPSMSD20UH0P/3QITFyvnaBXGH3bA0yuoNYZoCILMHykYCA4cpq/GTlBdiOlj
         jAkA==
X-Gm-Message-State: AO0yUKWi8l3z0ih9EEA/Mie3rTfwO4+KX8GARkKe1xbB9nlX9W2XWq8k
        eWoiQ76J9aX92cClu8mPo7Yj1VA7zDA=
X-Google-Smtp-Source: AK7set8FnFGMsytl3v5WIefWvDmCEGFCCinxWFgySGu/rwvLp6F67NuRio9yNLEjgt7rwB3V3rik8g==
X-Received: by 2002:a62:1d52:0:b0:625:e8ec:4f5b with SMTP id d79-20020a621d52000000b00625e8ec4f5bmr567611pfd.6.1678926095787;
        Wed, 15 Mar 2023 17:21:35 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::110b? ([2620:10d:c090:400::5:e3ea])
        by smtp.gmail.com with ESMTPSA id j10-20020a65558a000000b00502f4c62fd3sm3941220pgs.33.2023.03.15.17.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:21:35 -0700 (PDT)
Message-ID: <4f840f92-a2ec-4b3c-b243-3b5fd3582222@gmail.com>
Date:   Wed, 15 Mar 2023 17:21:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v6 3/8] bpf: Create links for BPF struct_ops
 maps.
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230310043812.3087672-1-kuifeng@meta.com>
 <20230310043812.3087672-4-kuifeng@meta.com>
 <6586775f-079e-7c21-9747-651be221dcd1@linux.dev>
Content-Language: en-US, en-ZW
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <6586775f-079e-7c21-9747-651be221dcd1@linux.dev>
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



On 3/13/23 18:42, Martin KaFai Lau wrote:
> On 3/9/23 8:38 PM, Kui-Feng Lee wrote:
>> BPF struct_ops maps are employed directly to register TCP Congestion
>> Control algorithms. Unlike other BPF programs that terminate when
>> their links gone. The link of a BPF struct_ops map provides a uniform
>> experience akin to other types of BPF programs.
> 
> This part is a little confusing to read. I think it is trying to explain 
> how the current bpf struct_ops uses update_elem to do both "update" and 
> "register". It was done before the bpf_link was introduced. With 
> bpf_link, the prog attach is done at the link creation time and prog 
> detach is done when the link is gone. It is a more consistent experience 
> to do the same for bpf struct_ops: attach (register) bpf_struct_ops 
> during bpf_link creation and detach (unregister) when the link is gone.  
> This patch adds a new link type BPF_LINK_TYPE_STRUCT_OPS for attaching a 
> bpf struct_ops to a subsystem.

Will fix it.

> 
>>
>> bpf_links are responsible for registering their associated
>> struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
>> set to create a bpf_link, while a structs without this flag behaves in
>> the same manner as before and is registered upon updating its value.
>>
>> The BPF_LINK_TYPE_STRUCT_OPS serves a dual purpose. Not only is it
>> used to craft the links for BPF struct_ops programs, but also to
>> create links for BPF struct_ops them-self.  Since the links of BPF
>> struct_ops programs are only used to create trampolines internally,
>> they are never seen in other contexts. Thus, they can be reused for
>> struct_ops themself.
>>
>> To maintain a reference to the map supporting this link, we add
>> bpf_struct_ops_link as an additional type. The pointer of the map is
>> RCU and won't be necessary until later in the patchset.
>>
> 
> [ ... ]
> 
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 239cc0e2639c..2abb755e6a3a 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1119,6 +1119,7 @@ int tcp_register_congestion_control(struct 
>> tcp_congestion_ops *type);
>>   void tcp_unregister_congestion_control(struct tcp_congestion_ops 
>> *type);
>>   int tcp_update_congestion_control(struct tcp_congestion_ops *type,
>>                     struct tcp_congestion_ops *old_type);
>> +int tcp_validate_congestion_control(struct tcp_congestion_ops *ca);
> 
> I may not be clear in comment in v5. This is also tcp_cong.c changes and 
> belongs to patch 2.

Got it!

> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index ab7811a4c1dd..888d6aefc31a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -16,6 +16,7 @@ enum bpf_struct_ops_state {
>>       BPF_STRUCT_OPS_STATE_INIT,
>>       BPF_STRUCT_OPS_STATE_INUSE,
>>       BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>>   };
>>   #define BPF_STRUCT_OPS_COMMON_VALUE            \
>> @@ -504,11 +505,25 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>           *(unsigned long *)(udata + moff) = prog->aux->id;
>>       }
>> -    bpf_map_inc(map);
>> +    if (st_map->map.map_flags & BPF_F_LINK) {
>> +        if (st_ops->validate) {
>> +            err = st_ops->validate(kdata);
>> +            if (err)
>> +                goto reset_unlock;
>> +        }
>> +        set_memory_rox((long)st_map->image, 1);
>> +        /* Let bpf_link handle registration & unregistration.
>> +         *
>> +         * Pair with smp_load_acquire() during lookup_elem().
>> +         */
>> +        smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
>> +        goto unlock;
>> +    }
>>       set_memory_rox((long)st_map->image, 1);
>>       err = st_ops->reg(kdata);
>>       if (likely(!err)) {
>> +        bpf_map_inc(map);
> 
> The bpf_map_inc(map) line-move for the non BPF_F_LINK case has been 
> spinning in my head since v5 because the bpf_map_inc is now done after 
> publishing the map in reg(). I think it works considering only 
> delete_elem() can remove this map at this point and delete_elem() cannot 
> be run now. It is tricky, so please help to add some comments here.

Yes, we have some assumptions here to make it work.  I will put down
these assumptions in a comment.

> 
> 
>>           /* Pair with smp_load_acquire() during lookup_elem().
>>            * It ensures the above udata updates (e.g. prog->aux->id)
>>            * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
>> @@ -524,7 +539,6 @@ static int bpf_struct_ops_map_update_elem(struct 
>> bpf_map *map, void *key,
>>        */
>>       set_memory_nx((long)st_map->image, 1);
>>       set_memory_rw((long)st_map->image, 1);
>> -    bpf_map_put(map);
>>   reset_unlock:
>>       bpf_struct_ops_map_put_progs(st_map);
>> @@ -542,6 +556,9 @@ static int bpf_struct_ops_map_delete_elem(struct 
>> bpf_map *map, void *key)
>>       struct bpf_struct_ops_map *st_map;
>>       st_map = (struct bpf_struct_ops_map *)map;
>> +    if (st_map->map.map_flags & BPF_F_LINK)
>> +        return -EOPNOTSUPP;
>> +
>>       prev_state = cmpxchg(&st_map->kvalue.state,
>>                    BPF_STRUCT_OPS_STATE_INUSE,
>>                    BPF_STRUCT_OPS_STATE_TOBEFREE);
>> @@ -609,7 +626,7 @@ static void bpf_struct_ops_map_free(struct bpf_map 
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
>> @@ -720,3 +737,113 @@ void bpf_struct_ops_put(const void *kdata)
>>       bpf_map_put(&st_map->map);
>>   }
>> +
>> +static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>> +{
>> +    struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +
>> +    return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
>> +        map->map_flags & BPF_F_LINK &&
>> +        /* Pair with smp_store_release() during map_update */
>> +        smp_load_acquire(&st_map->kvalue.state) == 
>> BPF_STRUCT_OPS_STATE_READY;
>> +}
>> +
>> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>> +{
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_struct_ops_map *st_map;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    st_map = (struct bpf_struct_ops_map *)
>> +        rcu_dereference_protected(st_link->map, true);
>> +    if (st_map) {
>> +        /* st_link->map can be NULL if
>> +         * bpf_struct_ops_link_create() fails to register.
>> +         */
> 
> Thanks for the comment. This helps the review a lot.
> 
>> +        st_map->st_ops->unreg(&st_map->kvalue.data);
>> +        bpf_map_put(&st_map->map);
>> +    }
>> +    kfree(st_link);
>> +}
>> +
> 
> [ ... ]
> 
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
>> +    if (!bpf_struct_ops_valid_to_reg(map)) {
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
>> +        /* No RCU since no one has a chance to read this pointer yet. */
>> +        link->map = NULL;
> 
> RCU_INIT_POINTER(link->map, NULL). Otherwise, it will have the same 
> sparse warning.

Fixed

> 
> Others lgtm.
> 
>> +        bpf_link_cleanup(&link_primer);
>> +        link = NULL;
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
> 
