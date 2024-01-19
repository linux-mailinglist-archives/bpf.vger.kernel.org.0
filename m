Return-Path: <bpf+bounces-19905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF3832F5D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867F02867C8
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0B5645B;
	Fri, 19 Jan 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfE7hPVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D861E520;
	Fri, 19 Jan 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692599; cv=none; b=HHECrXKfsppgqr/08bMFql0+7Ecj4p9ZT/e27E5C1oouvL5RMUC68s2xsSquwQnSKYtWVBhXs8Ywb3U/sfpnqC9e2EyCHk8j49LjvptLrZZ6Qainz7CEgXZrt1p/oyW3FR15kjMghslXGAv2Vbo1oqqPgy3ZrWXU5Lk2U5/CsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692599; c=relaxed/simple;
	bh=gTGDNxoyScrvnexMWbEqoQPkglJfmbLIx7McK8bIdN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfCLI8fS5J0BIJus5xcxIxZhmJiY3yVF6J/3rpOw+4w1bUx6bx6vLeP6pcq2x+WEAluifbIqVngzl0bS7FlOel+tIxtNCY3SWuyjso7zgppOxOTJhpC+hdYWPlaGVbW3cBHWXi08JDGqof2gKDDoVm1nU4bxt7HFGokIeOHx3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfE7hPVk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5efb0e180f0so12157137b3.1;
        Fri, 19 Jan 2024 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705692597; x=1706297397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9qd90FPpe31NArK4/uWyoqQsQ3UqaQV97k6hPltHkU=;
        b=RfE7hPVkgKBorhC4GkvZFu+HF6SdzArfkj3F0Y3xW9aFd7V8KwsKOxjW77H1AGzFrn
         T3ttNymLgXGv9ye5EYPg4afrc6jnp6NC0kVlXBsqawWqcJ82Ate27LZUbeh5Fv+ngZD9
         sAoNwcmLM9l0BxDD8AgRl45OsFyK+6yqxsikpqQ5etSRuZpw+zfhpyXuG0uMFRDSfjuz
         Ep1w6QseADVhU4yuHlVgUXIfA/+BtR9CJJI4R9ElszTZsIm6ZXaWdF2jWY0chcou6i5V
         g1zVg9KIn4MU8xR51t3Mt8EG4i3GzWSAl/ne9PcbgjyNqbMc3v3kc6fM2QfVnF4WYMIa
         GQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705692597; x=1706297397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9qd90FPpe31NArK4/uWyoqQsQ3UqaQV97k6hPltHkU=;
        b=u3B+RyOC///qkFAwqZvvVFWJTN4nyZiK0EXo+Lkem2TkOvUZsXLljhdaA1xtu6FmGs
         +7/gsAGKROblkUlETkmuvesR3Gnc6PSG/9bai/cdaTIZiwYBuLnYe3O04mQ2QpatjO1t
         F99dX1GsnWpksAeQa2AURIyBLnTxYMwYGkG9EHtUqB0cpP+6yi1NHvXTxJ+UGc4y7C3R
         u2zobjp9AtTeLUPJVvpuZ1hhaDxWfC+xdAF1jvdGoMCe4tU8V/rmZeU6mKz2rIynYCho
         19VAY6HAnOoDZ6y4s73BMViTvOjXKQpVNSlfzYpnPHZRy1yp/EaRvJjGTonReGu+uim6
         FhJw==
X-Gm-Message-State: AOJu0Yz8MIMWWH/ANXNwkk8ZNi5MzyxOYrSnoM/lXst6nfju1lji4sp+
	u8ypt/pQhHgoGqark685rpEhrAjzKzgMh8X3U8M2+EQCGvferChW
X-Google-Smtp-Source: AGHT+IH+WXnEW1MfCN+wdeesVLg1aY/GfEZvTjLejx7JA0jIT6B2Xf+Qp3Dncab44B9IdDr7w40bVA==
X-Received: by 2002:a81:4951:0:b0:5ff:aafc:32c7 with SMTP id w78-20020a814951000000b005ffaafc32c7mr160910ywa.26.1705692596722;
        Fri, 19 Jan 2024 11:29:56 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:c63b:9436:82f0:e71a? ([2600:1700:6cf8:1240:c63b:9436:82f0:e71a])
        by smtp.gmail.com with ESMTPSA id u65-20020a818444000000b005ff83ceb44fsm1594010ywf.108.2024.01.19.11.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 11:29:56 -0800 (PST)
Message-ID: <bcf6ac83-d1c7-412c-ad82-619c76375c63@gmail.com>
Date: Fri, 19 Jan 2024 11:29:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 11/14] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-12-thinker.li@gmail.com>
 <be69cc3f-0ded-4c7e-8709-1602807d1914@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <be69cc3f-0ded-4c7e-8709-1602807d1914@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 14:25, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 1cfbb89944c5..a2522fcfe57c 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1700,10 +1700,22 @@ struct bpf_struct_ops_common_value {
>>       enum bpf_struct_ops_state state;
>>   };
>> +/* This macro helps developer to register a struct_ops type and generate
>> + * type information correctly. Developers should use this macro to 
>> register
>> + * a struct_ops type instead of calling register_bpf_struct_ops() 
>> directly.
>> + */
>> +#define REGISTER_BPF_STRUCT_OPS(st_ops, type)                \
> 
> One final nit on this macro. Rename this to register_bpf_struct_ops 
> since it is the one will be used a lot, so give it an easier typing name.
> 
>> +    ({                                \
>> +        struct bpf_struct_ops_##type {                \
>> +            struct bpf_struct_ops_common_value common;    \
>> +            struct type data ____cacheline_aligned_in_smp;    \
>> +        };                            \
>> +        BTF_TYPE_EMIT(struct bpf_struct_ops_##type);        \
>> +        register_bpf_struct_ops(st_ops);            \
> 
> and rename this to __register_bpf_struct_ops. Thanks.

Sure!

> 
>> +    })
>> +
>>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + 
>> POISON_POINTER_DELTA))
>> -const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf 
>> *btf, u32 type_id);
>> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>>   bool bpf_struct_ops_get(const void *kdata);
>>   void bpf_struct_ops_put(const void *kdata);
>>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>> @@ -1745,16 +1757,11 @@ struct bpf_dummy_ops {
>>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union 
>> bpf_attr *kattr,
>>                   union bpf_attr __user *uattr);
>>   #endif
>> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>> +                 struct btf *btf,
>> +                 struct bpf_verifier_log *log);
>>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct 
>> bpf_map *map);
>>   #else
>> -static inline const struct bpf_struct_ops_desc 
>> *bpf_struct_ops_find(struct btf *btf, u32 type_id)
>> -{
>> -    return NULL;
>> -}
>> -static inline void bpf_struct_ops_init(struct btf *btf,
>> -                       struct bpf_verifier_log *log)
>> -{
>> -}
>>   static inline bool bpf_try_module_get(const void *data, struct 
>> module *owner)
>>   {
>>       return try_module_get(owner);
>> @@ -1769,6 +1776,10 @@ static inline int 
>> bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>>   {
>>       return -EINVAL;
>>   }
>> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
> 
> This is added back here which was removed in patch 3...
> 
> Others lgtm.
> 

