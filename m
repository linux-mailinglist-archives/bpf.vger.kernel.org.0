Return-Path: <bpf+bounces-15719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185E7F550D
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C357F2816A1
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84F21A02;
	Wed, 22 Nov 2023 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSvDWi5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428E83;
	Wed, 22 Nov 2023 15:53:32 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58a6ad82b07so188338eaf.2;
        Wed, 22 Nov 2023 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700697211; x=1701302011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptSuTKQvR9JLLDZ9nZXPY/xCjnt8PeE7nphMGTE2Dq4=;
        b=SSvDWi5ewE7fJQ/ks1Sd63snWhnGyn7UlXfIPG9W5VMP+fDee2ZzinJ6SCXr7yIH4x
         nh68IexXrPuJMEv9WDdFQiaRGPnL9XsM34Ok9eh77DQL1v3KGeUNVF2MzzjDw2Rq2Phv
         ABm8gJkhAr5ajj2RU4cPkLF9+iXL/wtDzJHbNYso9HXJFmO6noPTcv7HzLYyU0nCNfvR
         /Z2ENoIzwDJKtv/cfL1b58p/aD/tVA+l3C7KBtT0tQ4j+sIs38KLMLKNryBmNsC2f5pN
         vUjDAgx0gOjK9D7O7hFsqqG7DxhIAJUHADZt8ugNkU0Mv0e/xZ4JpaX9BFBaIguUqawd
         fyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697211; x=1701302011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptSuTKQvR9JLLDZ9nZXPY/xCjnt8PeE7nphMGTE2Dq4=;
        b=Fga1AWEzKq+87vLS2emBqgJmCcCG3z8B+OtS2+Y7VtrSiAcwRs7RkqGE6nhHAHOb51
         uaBuYmep9ZalIQ6K3djlRGuz0Y+hQtmHD0m+XvxuL71NFCBbaNBCOFxGAX9Slutf95hH
         UPeFKv0BrH6FoWFr3sG8KWmp2KeiSjer0k5YgLdHpNTFQsWNoxt+twm0HUGMleX2qNcp
         FLNeMLD55e66b6pbtRy4gTD7cSlgasc5n0Xx0WYBy07HbcmNaAUxFUYZviDU9JW7ykhS
         mDt2CPNE9prPLWWp81/L3VAfR+wrkqibmaHheUSSbgayPmGiEIKFb+ubpZOEPS2ftgA1
         CsXw==
X-Gm-Message-State: AOJu0YyVx4dAOkVND0DJ9Yk6IIOwetHcUnsVWY4W6TvZAiHqmHDhjy/G
	h8NUg89Vrx/z4ga5FYhCc7w=
X-Google-Smtp-Source: AGHT+IHSOk8tvELns4MrPKu24TBAdB5OEcSmHvkF79+ccbUgXzfoSTPn1JruJ0RHC4StU9Nq8if0eA==
X-Received: by 2002:a05:6820:80d:b0:58a:231d:750e with SMTP id bg13-20020a056820080d00b0058a231d750emr4877895oob.1.1700697211305;
        Wed, 22 Nov 2023 15:53:31 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5a79:4034:522e:2b90? ([2600:1700:6cf8:1240:5a79:4034:522e:2b90])
        by smtp.gmail.com with ESMTPSA id o62-20020a4a4441000000b0058a010374e6sm4963ooa.39.2023.11.22.15.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 15:53:30 -0800 (PST)
Message-ID: <11a24655-4d13-4f37-a415-6351477f9912@gmail.com>
Date: Wed, 22 Nov 2023 15:53:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 10/13] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-11-thinker.li@gmail.com>
 <c2876de6-d726-5a6a-fe65-98c08e7f2b91@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c2876de6-d726-5a6a-fe65-98c08e7f2b91@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 18:19, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 48e97a255945..432c088d4001 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1643,7 +1643,6 @@ struct bpf_struct_ops_desc {
>>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + 
>> POISON_POINTER_DELTA))
>>   const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf 
>> *btf, u32 type_id);
>> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>>   bool bpf_struct_ops_get(const void *kdata);
>>   void bpf_struct_ops_put(const void *kdata);
>>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>> @@ -1689,10 +1688,6 @@ static inline const struct bpf_struct_ops_desc 
>> *bpf_struct_ops_find(struct btf *
>>   {
>>       return NULL;
>>   }
>> -static inline void bpf_struct_ops_init(struct btf *btf,
>> -                       struct bpf_verifier_log *log)
>> -{
>> -}
>>   static inline bool bpf_try_module_get(const void *data, struct 
>> module *owner)
>>   {
>>       return try_module_get(owner);
>> @@ -3232,6 +3227,8 @@ static inline bool bpf_is_subprog(const struct 
>> bpf_prog *prog)
>>   }
>>   #ifdef CONFIG_BPF_JIT
>> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
>> +
>>   enum bpf_struct_ops_state {
>>       BPF_STRUCT_OPS_STATE_INIT,
>>       BPF_STRUCT_OPS_STATE_INUSE,
>> @@ -3243,6 +3240,23 @@ struct bpf_struct_ops_common_value {
>>       refcount_t refcnt;
>>       enum bpf_struct_ops_state state;
>>   };
>> +
>> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
>> + * the map's value exposed to the userspace and its btf-type-id is
>> + * stored at the map->btf_vmlinux_value_type_id.
>> + *
>> + */
>> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)            \
>> +extern struct bpf_struct_ops bpf_##_name;            \
> 
> Is it still needed?

No, will remove it.

> 
>> +                                \
>> +struct bpf_struct_ops_##_name {                    \
>> +    struct bpf_struct_ops_common_value common;        \
>> +    struct _name data ____cacheline_aligned_in_smp;        \
>> +}
>> +
>> +extern int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc 
>> *st_ops_desc,
>> +                    struct btf *btf,
>> +                    struct bpf_verifier_log *log);
> 
> nit. Remove extern.

Sure!

> 
>>   #endif /* CONFIG_BPF_JIT */
>>   #endif /* _LINUX_BPF_H */
> 

