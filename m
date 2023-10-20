Return-Path: <bpf+bounces-12874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228557D1916
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 00:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61E82826EB
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23DE354F4;
	Fri, 20 Oct 2023 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL98YF7F"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B4354E1
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 22:28:48 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD3D6A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 15:28:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a87ac9d245so14318697b3.3
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697840908; x=1698445708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0Qo39YRMmyJmEkuIftXZiQllQDEjPz9JwlukAelkeo=;
        b=GL98YF7F9g0tuOcY0HnZctkc2G+dUABMFKKthakAmCCbzwJRnCMRjOv3wrrHgDO1m1
         7bfXIPlsihOfrgZC0mswC8noWU0oy7aR3+iQU2dkaqQys2/rLm0KYlrHpYMlHkdwAgpF
         M4HpglkZNFwhutvbDDSyNa+75K6BGjOJzdPNhKMOpp3Srw5HvFByrXxF66y3RCDIh/86
         nJ+LnIUA/vDYTXeupm32fStjZi/0IKx01TvMl+NlmlLKUlZJOVpZaJJl/Q7IGkDY1Vzp
         3nPU4omhX0iSe/A6n488k8gFTaRxuY8hd3WfF4N5rziGSbD1HWn85x5i14PCeTCymp6b
         42Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697840908; x=1698445708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0Qo39YRMmyJmEkuIftXZiQllQDEjPz9JwlukAelkeo=;
        b=PkJb/d8bJL/bJIa7Y9QkVDNa1FEcFaWMKCCsuj/V2g57xOYf8cXxk7zMoXkUVX0eL3
         TW4d0lWhMQgPUAm5mLKgNDh3dD5jd3qFYX9ErCQwVvtp1MVYX0WgfaEXEO6SO6AyjhH8
         5yKvp5iGZA975Neyr6dJ/uRIEFMLGW58LE5JILyeXrHAoZmkTXGsbv+GtH+21oyL6tRi
         cPVdND2wtqDvIzLs9en5HEmip46NTOv0bZmI+JyBFXCLTewHVN2pOk5Sj+r8jEZc/Jrx
         H2cwsjUcOUSW3m2kcKuN1KeckxooM9onu2ToL7Cj3eO4UV8mlcaIDi65JTEqXLbtY1xX
         QU9g==
X-Gm-Message-State: AOJu0YxJeggIE2Jg0IqXZX0yHMhif7Ji/egE7Q6Vp3k1vO4F9mwYo4cX
	IBAkBHK+nF/9M8AVaQ+PBAA=
X-Google-Smtp-Source: AGHT+IHAucR2E1eW4fw82DW0ahzspfeQji1YfiQSwdg3djR4SSp24kRmsrD/AynQVwlbsH821cUw0A==
X-Received: by 2002:a0d:f3c7:0:b0:5a8:205e:1f1f with SMTP id c190-20020a0df3c7000000b005a8205e1f1fmr3098290ywf.17.1697840907702;
        Fri, 20 Oct 2023 15:28:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b156:9f79:af30:f168? ([2600:1700:6cf8:1240:b156:9f79:af30:f168])
        by smtp.gmail.com with ESMTPSA id x184-20020a817cc1000000b0059935151fa1sm1014927ywc.126.2023.10.20.15.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 15:28:27 -0700 (PDT)
Message-ID: <2e07e20b-cb1a-409e-a0fc-4b5ee55e0cbe@gmail.com>
Date: Fri, 20 Oct 2023 15:28:26 -0700
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
 <7ea8ebf7-3349-4461-b204-be106e3b547a@gmail.com>
 <02e2a704-4939-4f8c-b465-473c3a2eae1c@gmail.com>
 <047bbde0-eb9c-7785-349a-d241c1623fab@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <047bbde0-eb9c-7785-349a-d241c1623fab@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/23 14:37, Martin KaFai Lau wrote:
> On 10/19/23 10:07 PM, Kui-Feng Lee wrote:
>>
>>
>> On 10/19/23 09:29, Kui-Feng Lee wrote:
>>>
>>>
>>> On 10/18/23 17:36, Martin KaFai Lau wrote:
>>>> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>>>
>>>>
>>>>>   }
>>>>>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log 
>>>>> *log)
>>>>> @@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, 
>>>>> struct bpf_verifier_log *log)
>>>>>       for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>>>>>           st_ops = bpf_struct_ops[i];
>>>>> -        bpf_struct_ops_init_one(st_ops, btf, log);
>>>>> +        bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>>>>>       }
>>>>>   }
>>>>> @@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct 
>>>>> bpf_map *map)
>>>>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>>       }
>>>>>       bpf_map_area_free(st_map->uvalue);
>>>>> +    module_put(st_map->st_ops->owner);
>>>>>       bpf_map_area_free(st_map);
>>>>>   }
>>>>> @@ -676,9 +680,18 @@ static struct bpf_map 
>>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>>       if (!st_ops)
>>>>>           return ERR_PTR(-ENOTSUPP);
>>>>> +    /* If st_ops->owner is NULL, it means the struct_ops is
>>>>> +     * statically defined in the kernel.  We don't need to
>>>>> +     * take a refcount on it.
>>>>> +     */
>>>>> +    if (st_ops->owner && !btf_try_get_module(st_ops->btf))
> 
> While replying and looking at it again, I don't think the 
> btf_try_get_module(st_ops->btf) is safe. The module's owned st_ops 
> itself could have been gone with the module. The same goes with the 
> "st_ops->owner" test, so btf_is_module(btf) should be used instead.

I have change it locally. Here, it calls btf_try_get_module() after
calling btf_struct_ops_find_value(). The new code will call
btf_try_get_module() against the btf from attr->value_type_btf_obj_fd
before btf_struct_ops_find_value(). Just like I mentioned earlier to
ensure the callers of btf_struct_ops_find_value() and
btf_struct_ops_find() hold a refcount to the module.

> 
> I am risking to act like a broken clock to repeat this question, does it 
> really need to store btf back into the st_ops which may accidentally get 
> into the above btf_try_get_module(st_ops->btf) usage?



> 
>>>>
>>>> This just came to my mind. Is the module refcnt needed during map 
>>>> alloc/free or it could be done during the reg/unreg instead?
>>>
>>>
>>> Sure, I can move it to reg/unreg.
>>
>> Just found that we relies type information in st_ops to update element 
>> and clean up maps.
>> We can not move get/put modules to reg/unreg except keeping a 
>> redundant copy in
>> st_map or somewhere. It make the code much more complicated by
>> introducing get/put module here and there.
>>
>> I prefer to keep as it is now. WDYT?
> 
> Yeah, sure. I was asking after seeing a longer wait time for the module 
> to go away in patch 11 selftest and requires an explicit waiting for the 
> tasks_trace period. Releasing the module refcnt earlier will help.
> 
> Regardless of the module refcnt hold/free location, I think storing the 
> type* and value* in the module's owned st_ops does not look correct now. 
> It was fine and convenient to piggy back them into bpf_struct_ops when 
> everything was built-in the kernel and no lifetime concern. It makes 
> sense now to separate them out from the module's owned st_ops. Something 
> like:
> 
> struct btf_struct_ops_desc {
>      struct bpf_struct_ops *ops;
>          const struct btf_type *type;
>          const struct btf_type *value_type;
>          u32 type_id;
>          u32 value_id;
> };
> 
> struct btf_struct_ops_tab {
>          u32 cnt;
>      u32 capacity;
>      struct btf_struct_ops_desc *st_ops_desc[];
> };
> 
> wdyt?

So, st_map should hold a pointer to a bpf_struct_ops_desc instead of
st_ops, right? It would work!

