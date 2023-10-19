Return-Path: <bpf+bounces-12708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D47CFF98
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6891282167
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42632C6B;
	Thu, 19 Oct 2023 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Zctofb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276A321B5
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 16:29:59 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B61114
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:29:58 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a82f176860so78852607b3.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732998; x=1698337798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElDxFFcmq7nA7rtH/zXT4+tZe1jSloi7/cfcCMS0OvA=;
        b=A1ZctofbheqyKXOR5XU5PoQXQMKo1PawuJomoKVk2vcscdDgObloPlKZ0SrtxIk/cJ
         NxxpBSl0q3kGi6UovIhABwoI+nkmpmniw5v3LinMeT6J3+dtX83PFVTFNMxKP278ymin
         Fw1M/m+BL32h75ULKKSMtCjRRXm1BAIAA1a7DdcCkkZP4QmbciwupOJpSatky+FH9w9n
         /k0p0133KABiPHBqm1zIjNx2MIj7eVt4t0x6mSsEbl+8nVkVi88fJxT0983Z9oOE7vE0
         pFW1Q8/9zLJmChAyJJ8e27RCro7KdCWV+T9weRUzW+Y6AS3mim8u+puE9fZgwSbgxtsE
         y3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732998; x=1698337798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElDxFFcmq7nA7rtH/zXT4+tZe1jSloi7/cfcCMS0OvA=;
        b=w63grl0l1Ukfdz/ZY0rF59sm91qlZVGdcBEvv6wpn/sX/gCKXrZwXSQSAU00MdvB1j
         Q8mN0tHZDhfoDKGdR7Hk20fXnmHaTmJqXEFSFOfahqpgRLNjERLp3xMdzsmZTLw6e2Gj
         lFgv5S0w/B3VnUo3zZuegfVzYpt+SBGubYZbaDRV8O2Nc/dY+QrDcPhwt0dDTickIdmb
         bMZL38zZf2JhNU7Prrj51qv70L2WHggR2u3I/Z41EUTfQyUW8RwbgEi7t7z0wqa4tZxi
         ukhDvgKGlk7w2P9aadXYkeaMru2mwMKpmRdFfXJ5SknTTnd0++AWk6/4VU0nWJeEbHnM
         C9gw==
X-Gm-Message-State: AOJu0YyFwcOqy8K1WuYB9xjjO9DjoA6IRG2895YLC+6E9xqtpri2p8Qg
	D7M5KoDH/Chf/pGniBAkgm0=
X-Google-Smtp-Source: AGHT+IHm7RK7zMdQk3xSOHo7xiBmUjbMadrbJj6yAEp54R1CFoZZEmmTEhI02IDJETLL+sq4fD4oLQ==
X-Received: by 2002:a25:e689:0:b0:d9b:dae4:63fa with SMTP id d131-20020a25e689000000b00d9bdae463famr2906146ybh.34.1697732997740;
        Thu, 19 Oct 2023 09:29:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c? ([2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c])
        by smtp.gmail.com with ESMTPSA id x17-20020a5b0f11000000b00d9abce6acf2sm2110433ybr.59.2023.10.19.09.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:29:57 -0700 (PDT)
Message-ID: <7ea8ebf7-3349-4461-b204-be106e3b547a@gmail.com>
Date: Thu, 19 Oct 2023 09:29:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/9] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-4-thinker.li@gmail.com>
 <a245d4c4-6eb0-ce54-41aa-4f8c8acf3051@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a245d4c4-6eb0-ce54-41aa-4f8c8acf3051@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 17:36, Martin KaFai Lau wrote:
> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> To ensure that a module remains accessible whenever a struct_ops 
>> object of
>> a struct_ops type provided by the module is still in use.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         |  1 +
>>   kernel/bpf/bpf_struct_ops.c | 21 ++++++++++++++++++---
>>   2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index e6a648af2daa..1e1647c8b0ce 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
>>       int (*update)(void *kdata, void *old_kdata);
>>       int (*validate)(void *kdata);
>>       struct btf *btf;
>> +    struct module *owner;
>>       const struct btf_type *type;
>>       const struct btf_type *value_type;
>>       const char *name;
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 7758f66ad734..b561245fe235 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -112,6 +112,7 @@ static const struct btf_type *module_type;
>>   static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>>                       struct btf *btf,
>> +                    struct module *owner,
>>                       struct bpf_verifier_log *log)
>>   {
>>       const struct btf_member *member;
>> @@ -186,6 +187,7 @@ static void bpf_struct_ops_init_one(struct 
>> bpf_struct_ops *st_ops,
>>                   st_ops->name);
>>           } else {
>>               st_ops->btf = btf;
>> +            st_ops->owner = owner;
> 
> I suspect it will turn out to be just "st_ops->owner = st_ops->owner;" 
> in a latter patch. st_ops->owner should have already been initialized 
> (with THIS_MODULE?).


Yes, you are correct.  It ends up st_ops->owner passing from the caller.
I will remove this line and the argument.

> 
>>               st_ops->type_id = type_id;
>>               st_ops->type = t;
>>               st_ops->value_id = value_id;
>> @@ -193,6 +195,7 @@ static void bpf_struct_ops_init_one(struct 
>> bpf_struct_ops *st_ops,
>>                                   value_id);
>>           }
>>       }
>> +
> 
> nit. extra newline.

got it!

> 
>>   }
>>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>> @@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, struct 
>> bpf_verifier_log *log)
>>       for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>>           st_ops = bpf_struct_ops[i];
>> -        bpf_struct_ops_init_one(st_ops, btf, log);
>> +        bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>>       }
>>   }
>> @@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>       }
>>       bpf_map_area_free(st_map->uvalue);
>> +    module_put(st_map->st_ops->owner);
>>       bpf_map_area_free(st_map);
>>   }
>> @@ -676,9 +680,18 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       if (!st_ops)
>>           return ERR_PTR(-ENOTSUPP);
>> +    /* If st_ops->owner is NULL, it means the struct_ops is
>> +     * statically defined in the kernel.  We don't need to
>> +     * take a refcount on it.
>> +     */
>> +    if (st_ops->owner && !btf_try_get_module(st_ops->btf))
> 
> This just came to my mind. Is the module refcnt needed during map 
> alloc/free or it could be done during the reg/unreg instead?


Sure, I can move it to reg/unreg.

> 
> 
>> +        return ERR_PTR(-EINVAL);
>> +
>>       vt = st_ops->value_type;
>> -    if (attr->value_size != vt->size)
>> +    if (attr->value_size != vt->size) {
>> +        module_put(st_ops->owner);
>>           return ERR_PTR(-EINVAL);
>> +    }
>>       t = st_ops->type;
>> @@ -689,8 +702,10 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>           (vt->size - sizeof(struct bpf_struct_ops_value));
>>       st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>> -    if (!st_map)
>> +    if (!st_map) {
>> +        module_put(st_ops->owner);
>>           return ERR_PTR(-ENOMEM);
>> +    }
>>       st_map->st_ops = st_ops;
>>       map = &st_map->map;
> 

