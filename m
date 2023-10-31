Return-Path: <bpf+bounces-13726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C17DD38C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F3281875
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC62031B;
	Tue, 31 Oct 2023 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW6xcz/D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DE200D4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:58:36 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF60C9ECE
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:57:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5407858276.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698771472; x=1699376272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZlMOxoSpXGE5jSFR5sHr/f7ixBVcbbkGQKfZSsF8es=;
        b=nW6xcz/Dd1/M0EPTN3AH5+dw2Y+uxsP0+zV/dV4nQGMMnDqhERJcB5kCVMAmf0e1aW
         iElSlbm2UeKgBlR2Fh1jl7GrjKU9WVo2csrh4bjbqpgZs20+DD5mmLlcTAPcGzAL73LO
         xAv9slKvUzA/GwLQsNC4cKF0bqfnB0KePlDxq03hyzzATuITfiJZ/9EWPlRFJzRXsc+W
         zb/K0JXjO3BAojtgOLq8NelYCr55OizewM8OG1KioVo8FH9nBjNuNeuuhFtTkUgNu8wN
         SFAySYqZMVk8OMeBNWwb6vxA/OKE9FDRNBDYBQ5DiH0QX72er2cJshEr2ceOtrj0dCK9
         056w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771472; x=1699376272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZlMOxoSpXGE5jSFR5sHr/f7ixBVcbbkGQKfZSsF8es=;
        b=klOuy7egOpzuKwGrCbdnYNrdwMGcqL9DVKiNxl2BzomMcmgWCdxK1xJBgBMb8VWsx1
         avCAANZ+3FVvXUEe/anBDIetiI2h3Isd1C8l1cToazttT78an2lCuqSwK/jjis0LQPhY
         PslTnWHb0cJU20e7d/0YclrhXgzGhfmXFEXZ+/YI7Aih8GwAhkwI0NA343jxQvEErxf1
         moITgv3wfTV4Oy5L4RT5j0Krng3ZSxNznfi3MoldLSkRC2Mfpo1VOWZFkIYEAD+3Snfc
         vh2JAhpgWGm5gH6MK7uLcvWu9u1ITXcri0BYDJ16os+TMmCMAVIembC89Tb7/kLugmVl
         i21Q==
X-Gm-Message-State: AOJu0Yxxgni9KlihZbmjCyL7u29s3iUH2XD6mknPY/oOr2eOvjJMhdAy
	TNLbI4AadgG0dRMFLelDzmY=
X-Google-Smtp-Source: AGHT+IF9Rn9FfD/OjcL1dFvY/W9lNNxj4xj0KRT9hiLhJlQ7Vmj3xN1CZHw2Dd358it8Z4MqaZ+nOA==
X-Received: by 2002:a25:cecd:0:b0:d9a:bfe4:d827 with SMTP id x196-20020a25cecd000000b00d9abfe4d827mr13651579ybe.19.1698771472353;
        Tue, 31 Oct 2023 09:57:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id f14-20020a056902038e00b00d9a36ded1besm987004ybs.6.2023.10.31.09.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:57:52 -0700 (PDT)
Message-ID: <ff7221ad-210e-4a43-8e71-8574240079b7@gmail.com>
Date: Tue, 31 Oct 2023 09:57:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 03/10] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-4-thinker.li@gmail.com>
 <736a8485-c9c0-fd75-6e8b-3207df8dda6a@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <736a8485-c9c0-fd75-6e8b-3207df8dda6a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/23 18:09, Martin KaFai Lau wrote:
> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Maintain a registry of registered struct_ops types in the per-btf 
>> (module)
>> struct_ops_tab. This registry allows for easy lookup of struct_ops types
>> that are registered by a specific module.
>>
>> Every struct_ops type should have an associated module BTF to provide 
>> type
>> information since we are going to allow modules to define and register 
>> new
>> struct_ops types. Once this change is made, the bpf_struct_ops subsystem
>> knows where to look up type info with just a bpf_struct_ops.
> 
> I think this part needs better description. I found it hard to parse. In 
> particular:
> 
> ...
>    the "bpf_struct_ops" subsystem
>         knows where to look up type info with just
>      a "bpf_struct_ops"
> ...
> 
> May be something like:
> 
> It is a preparation work for supporting kernel module struct_ops in a 
> latter patch. Each struct_ops will be registered under its own kernel 
> module btf and will be stored in the newly added btf->struct_ops_tab. 
> The bpf verifier and bpf syscall (e.g. prog and map cmd) can find the 
> struct_ops and its btf type/size/id... information from 
> btf->struct_ops_tab.


Got it!

> 
>>
>> The subsystem looks up struct_ops types from a given module BTF 
>> although it
>> is always btf_vmlinux now. Once start using struct_ops_tab, btfs other 
>> than
>> btf_vmlinux can be used as well.
> 
> I think this describes about the "struct btf *btf" argument change in 
> this patch. This seems unrelated to the "add struct_ops_tab to btf" 
> change. Can it be in its own preparation patch?
> 

Sure!

> [ ... ]
> 
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index e35d6321a2f8..0bc21a39257d 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -186,6 +186,7 @@ static void bpf_struct_ops_init_one(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>               pr_warn("Error in init bpf_struct_ops %s\n",
>>                   st_ops->name);
>>           } else {
>> +            st_ops_desc->btf = btf;
>>               st_ops_desc->type_id = type_id;
>>               st_ops_desc->type = t;
>>               st_ops_desc->value_id = value_id;
>> @@ -222,7 +223,7 @@ void bpf_struct_ops_init(struct btf *btf, struct 
>> bpf_verifier_log *log)
>>   extern struct btf *btf_vmlinux;
>>   static const struct bpf_struct_ops_desc *
>> -bpf_struct_ops_find_value(u32 value_id)
>> +bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
> 
> The "!btf_vmlinux" check a few lines below should also be changed to 
> "!btf". I think I had commented on a similar point in v5.

At this patch, btf is still always btf_vmlinux until the patch 6 and 7.
I will move these changes from the patch 6 and 7 to here or
the new patch mentioned above.

> 
>>   {
>>       unsigned int i;
>> @@ -237,7 +238,8 @@ bpf_struct_ops_find_value(u32 value_id)
>>       return NULL;
>>   }
>> -const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
>> +const struct bpf_struct_ops_desc *
>> +bpf_struct_ops_find(struct btf *btf, u32 type_id)
> 
> same here.
>

Got it!

>>   {
>>       unsigned int i;
> 
> [ ... ]
> 
>> +static struct bpf_struct_ops_desc *
>> +btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
>> +{
>> +    struct btf_struct_ops_tab *tab, *new_tab;
>> +    int i;
>> +
>> +    if (!btf)
>> +        return ERR_PTR(-ENOENT);
>> +
>> +    /* Assume this function is called for a module when the module is
>> +     * loading.
>> +     */
>> +
>> +    tab = btf->struct_ops_tab;
>> +    if (!tab) {
>> +        tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
>> +                  GFP_KERNEL);
>> +        if (!tab)
>> +            return ERR_PTR(-ENOMEM);
>> +        tab->capacity = 4;
>> +        btf->struct_ops_tab = tab;
>> +    }
>> +
>> +    for (i = 0; i < tab->cnt; i++)
>> +        if (tab->ops[i].st_ops == st_ops)
>> +            return ERR_PTR(-EEXIST);
>> +
>> +    if (tab->cnt == tab->capacity) {
>> +        new_tab = krealloc(tab, sizeof(*tab) +
>> +                   sizeof(struct bpf_struct_ops *) *
>> +                   tab->capacity * 2, GFP_KERNEL);
> 
> nit. Use a similar offsetof() like a few lines above.
Sure!
> 
>> +        if (!new_tab)
>> +            return ERR_PTR(-ENOMEM);
>> +        tab = new_tab;
>> +        tab->capacity *= 2;
>> +        btf->struct_ops_tab = tab;
>> +    }
>> +
>> +    btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
> 
> nit. s/btf->struct_ops_tab/tab/
> 

Sure!

>> +
>> +    return &btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++];
>> +}
> 

