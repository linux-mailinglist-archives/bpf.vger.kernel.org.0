Return-Path: <bpf+bounces-10773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA2B7AE0ED
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 234FE1C2088D
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1B24204;
	Mon, 25 Sep 2023 21:45:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011421170A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:45:50 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCFAA2
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:45:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59e88a28b98so107633007b3.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695678348; x=1696283148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAYNCiUserkcl6zZ/6ZiW1bec+SIJsx1L6aQuC5irQ4=;
        b=FGpoIVl/uro0w7WQjF3RY8tI4if8iq/5l4u/J9Gd8O49idZvkK1IvatbVoU9MZnjHD
         1oYMrjQDAvWQVbGRycrIK9nbPfP7hvGH/TO3+E89I+xW3NSxvSrFzrBLBjuN7ayia6OM
         bzAt98kim2tbyXJCZZReA4y6jaiyrGS8O1pq6l3ilPs5dVlXZhNjLrBW+PJOQmC1GRM5
         n58dDestT/tdjIHEMR5yomlpU5gJBGkFt+V51Q5qmjOecw9PbbQuT5r8RTXLNLFKKGuR
         f3BOM4BCM/HquBxlbZy8aRAGmIyB/lEDyS0EcptZ3XZJ7pc/v3F+XCrBej+A0WM5v8+t
         wG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695678348; x=1696283148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAYNCiUserkcl6zZ/6ZiW1bec+SIJsx1L6aQuC5irQ4=;
        b=ItNXB2BD9MdZsZOFO2PbzAs5IO6sJAQY3omp/6ZoqBkOXt11e5u0WExsupD89yBXEt
         oX6iyaCCxTLG4pE+4UcmyLSgr0XuTy2dWaatvINFUe5ZGW41NY0zIjf0haGagxWGKGxX
         wlKMLxca94/T3epbirPxyLd4xaPCu3mAFVRdjgPWmgPcEq0tDuRIO3ZOTfDmISr95FbI
         VH5h9TWqSVJ5taOL8lAaq6kQ2W9fehblpkmk72836COOX5R7E8KcfGpBKVLDBIR4IpMB
         UDL3N3nF39VGzQHWfBKJtgamdBUg6vfoHDd2pZNMJPCueoCtylgf0Qs1q+5BfB730nbC
         KNdg==
X-Gm-Message-State: AOJu0Yw/7Md54ECqcVV/xFmq2daQSY7Fk1fo0ckxaxK8VGhokKPGhgDe
	bf6eO/MoWAqH1nUg4pAplmZQr52TTyY=
X-Google-Smtp-Source: AGHT+IGc2iUUsGvkGny/g6qM4x8EPocc1lPImAeGHTQNLYZV9Aph0vvTItXN9R7my+4NIfNReonZ+Q==
X-Received: by 2002:a0d:e884:0:b0:59f:7caf:f2dd with SMTP id r126-20020a0de884000000b0059f7caff2ddmr627410ywe.8.1695678348598;
        Mon, 25 Sep 2023 14:45:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id y9-20020a0dd609000000b0057087e7691bsm2645940ywd.56.2023.09.25.14.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 14:45:48 -0700 (PDT)
Message-ID: <a5127fcc-d30c-3ca3-b07d-b1f963ac0a7f@gmail.com>
Date: Mon, 25 Sep 2023 14:45:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 02/11] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-3-thinker.li@gmail.com>
 <c77c5a5d-7174-4770-4ffb-ee297a28f025@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c77c5a5d-7174-4770-4ffb-ee297a28f025@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 14:10, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> struct_ops_tab will be used to restore registered struct_ops.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/btf.h |  9 +++++
>>   kernel/bpf/btf.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 928113a80a95..5fabe23aedd2 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -571,4 +571,13 @@ static inline bool btf_type_is_struct_ptr(struct 
>> btf *btf, const struct btf_type
>>       return btf_type_is_struct(t);
>>   }
>> +struct bpf_struct_ops;
>> +
>> +int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops,
>> +               struct btf *btf);
>> +int btf_add_struct_ops(struct bpf_struct_ops *st_ops,
>> +               struct module *owner);
>> +const struct bpf_struct_ops **
>> +btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>> +
>>   #endif
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index f93e835d90af..3fb9964f8672 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
>>       struct btf_id_dtor_kfunc dtors[];
>>   };
>> +struct btf_struct_ops_tab {
>> +    u32 cnt;
>> +    u32 capacity;
>> +    struct bpf_struct_ops *ops[];
>> +};
>> +
>>   struct btf {
>>       void *data;
>>       struct btf_type **types;
>> @@ -258,6 +264,7 @@ struct btf {
>>       struct btf_kfunc_set_tab *kfunc_set_tab;
>>       struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>>       struct btf_struct_metas *struct_meta_tab;
>> +    struct btf_struct_ops_tab *struct_ops_tab;
>>       /* split BTF support */
>>       struct btf *base_btf;
>> @@ -1688,11 +1695,20 @@ static void btf_free_struct_meta_tab(struct 
>> btf *btf)
>>       btf->struct_meta_tab = NULL;
>>   }
>> +static void btf_free_struct_ops_tab(struct btf *btf)
>> +{
>> +    struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
>> +
>> +    kfree(tab);
>> +    btf->struct_ops_tab = NULL;
>> +}
>> +
>>   static void btf_free(struct btf *btf)
>>   {
>>       btf_free_struct_meta_tab(btf);
>>       btf_free_dtor_kfunc_tab(btf);
>>       btf_free_kfunc_set_tab(btf);
>> +    btf_free_struct_ops_tab(btf);
>>       kvfree(btf->types);
>>       kvfree(btf->resolved_sizes);
>>       kvfree(btf->resolved_ids);
>> @@ -8601,3 +8617,71 @@ bool btf_type_ids_nocast_alias(struct 
>> bpf_verifier_log *log,
>>       return !strncmp(reg_name, arg_name, cmp_len);
>>   }
>> +
>> +int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops, struct btf 
>> *btf)
> 
> A few nits.
> 
> 'struct btf *btf' as the first argument, to be consistent with other 
> similar btf functions.

Got it!

> 
> This new function is not used outside of this file, so at least static. 
> I would just fold this into btf_add_struct_ops() below which currently 
> is mostly empty other than a btf_get/put.


Sure

> 
>> +{
>> +    struct btf_struct_ops_tab *tab;
>> +    int i;
>> +
>> +    /* Assume this function is called for a module when the module is
>> +     * loading.
>> +     */
>> +
>> +    tab = btf->struct_ops_tab;
>> +    if (!tab) {
>> +        tab = kzalloc(sizeof(*tab) +
>> +                  sizeof(struct bpf_struct_ops *) * 4,
>> +                  GFP_KERNEL);
> 
> nit. offsetof(struct bpf_struct_ops_tab, ops[4]).


Got it!

> 
>> +        if (!tab)
>> +            return -ENOMEM;
>> +        tab->capacity = 4;
>> +        btf->struct_ops_tab = tab;
>> +    }
>> +
>> +    for (i = 0; i < tab->cnt; i++)
>> +        if (tab->ops[i] == st_ops)
>> +            return -EEXIST;
>> +
>> +    if (tab->cnt == tab->capacity) {
>> +        struct btf_struct_ops_tab *new_tab;
>> +
>> +        new_tab = krealloc(tab, sizeof(*tab) +
>> +                   sizeof(struct bpf_struct_ops *) *
>> +                   tab->capacity * 2, GFP_KERNEL);
>> +        if (!new_tab)
>> +            return -ENOMEM;
>> +        tab = new_tab;
>> +        tab->capacity *= 2;
>> +        btf->struct_ops_tab = tab;
>> +    }
>> +
>> +    btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++] = st_ops;
>> +
>> +    return 0;
>> +}
>> +
>> +int btf_add_struct_ops(struct bpf_struct_ops *st_ops, struct module 
>> *owner)
>> +{
>> +    struct btf *btf = btf_get_module_btf(owner);
>> +    int ret;
>> +
>> +    if (!btf)
>> +        return -ENOENT;
>> +
>> +    ret = btf_add_struct_ops_btf(st_ops, btf);
>> +
>> +    btf_put(btf);
>> +
>> +    return ret;
>> +}
>> +
>> +const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 
>> *ret_cnt)
>> +{
>> +    if (!btf)
>> +        return NULL;
>> +    if (!btf->struct_ops_tab)
>> +        return NULL;
>> +
>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>> +    return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;
>> +}
> 

