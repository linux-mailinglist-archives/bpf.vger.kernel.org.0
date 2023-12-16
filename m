Return-Path: <bpf+bounces-18098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CD815B5E
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA5284DD9
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00C321AC;
	Sat, 16 Dec 2023 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG3yI3rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E932C67
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1fb9a22b4a7so1134205fac.3
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702755526; x=1703360326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hy/UjLdfoefcoK17R5p/1bEtpLttDar/sV5IdTpgb2I=;
        b=UG3yI3rkax3RnxNUuwE9moZV9z4qb2mTvDtQO7RWlsrZLG5gjsXgfzXPKD4yVZX1hd
         mfnaIE9je27acTzymPpjbO1U5rCkmGHds2feUOD9HDD1NJMy9xKW3cYvf55hmUZHrsVk
         5uSUwFDlL32fx16o7kq8BRuBXDq2k3RKsoUslikAt0Xff1bsjYens2ftseE+Vb7Bjj/I
         K9EwANLBDIDvws0D7ZgGfRdyupk+u+3l2u5q5aDLekdIO1utdFsMigIziMAkhvm0NL/X
         +MVRz2sUUhqxgxUyWI+iA1zrAxIs24nGpw3hyaMA5n6HcOdjY2YXAU5Epc8haEq5d6in
         uOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755526; x=1703360326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy/UjLdfoefcoK17R5p/1bEtpLttDar/sV5IdTpgb2I=;
        b=Jfgvtrt+U3WJYOep7/QiaAuBDwHfcpbX90S3Wx0TgZcnMvJIekLHLXaqYJLmrm2idk
         vLftxgYpsaDC6ipmKN92MzFOOheitip+X/66Y4ELp4JEUIZdBtAfTvziYeL5pZzA8OsS
         fM7hiFy5e3NqSQuwiKOtA9F/3BAzR/GsjTaWpnV7d659wNiqfh6RyDD2ImKee1t5AN92
         EhqLmolhma75XYnsPc4n0jaaGBRyn9oYBpIJ3vWcDxHJSjqaUxqGmBH5UNb5AYx+oFNX
         Qg3vz/MspM/aDzdR2iUvc16TP8XYL9BN8fV3PwqABxdIunUymfUB1M0JQRiq6YhTjC9/
         nNiQ==
X-Gm-Message-State: AOJu0YwhTJe1XwWcZTUQJ5sr1bl5ohHkugHI71C1c72VudDnu1/Pz8eg
	IEw5X4W1LDEl/WmGu0vCP+A=
X-Google-Smtp-Source: AGHT+IEgF5zKqjAIed2AUj5vxL4fclQgdvUOUI2bYMuUsBfMSgfVZ3EZS2I0ZmUSkVZNtgyfASBDGw==
X-Received: by 2002:a05:6870:9f82:b0:1fb:75b:99ad with SMTP id xm2-20020a0568709f8200b001fb075b99admr15880868oab.92.1702755526626;
        Sat, 16 Dec 2023 11:38:46 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:d437:75a2:77fa:eab8? ([2600:1700:6cf8:1240:d437:75a2:77fa:eab8])
        by smtp.gmail.com with ESMTPSA id eg46-20020a05687098ae00b002030e38887dsm2672195oab.41.2023.12.16.11.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 11:38:46 -0800 (PST)
Message-ID: <6ee71cf2-c787-4a72-97b7-ba6d4cbfbb20@gmail.com>
Date: Sat, 16 Dec 2023 11:38:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 07/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-8-thinker.li@gmail.com>
 <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
 <e2222287-6438-4de7-a747-9e04c5fd3f55@gmail.com>
 <3fd164b6-622e-499e-9fa4-6d56442b086f@linux.dev>
 <a3ab56ff-ca03-4f28-b2e7-4f0b50bfaaae@gmail.com>
 <390f3c92-2df6-4cea-aa78-ecc92a9fe8aa@gmail.com>
 <9dce9dca-f48b-4853-b1a5-a5ee0e22fc4a@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9dce9dca-f48b-4853-b1a5-a5ee0e22fc4a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/16/23 08:41, Martin KaFai Lau wrote:
> On 12/15/23 10:07 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/15/23 21:55, Kui-Feng Lee wrote:
>>>
>>>
>>> On 12/15/23 16:19, Martin KaFai Lau wrote:
>>>> On 12/15/23 2:10 PM, Kui-Feng Lee wrote:
>>>>>
>>>>>
>>>>> On 12/14/23 18:44, Martin KaFai Lau wrote:
>>>>>> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>>>>>>> @@ -681,15 +682,30 @@ static struct bpf_map 
>>>>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>>>>       struct bpf_struct_ops_map *st_map;
>>>>>>>       const struct btf_type *t, *vt;
>>>>>>>       struct bpf_map *map;
>>>>>>> +    struct btf *btf;
>>>>>>>       int ret;
>>>>>>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>>>>>>> attr->btf_vmlinux_value_type_id);
>>>>>>> -    if (!st_ops_desc)
>>>>>>> -        return ERR_PTR(-ENOTSUPP);
>>>>>>> +    if (attr->value_type_btf_obj_fd) {
>>>>>>> +        /* The map holds btf for its whole life time. */
>>>>>>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>>>>>> +        if (IS_ERR(btf))
>>>>>>> +            return ERR_PTR(PTR_ERR(btf));
>>>>>>
>>>>>>              return ERR_CAST(btf);
>>>>>>
>>>>>> It needs to check for btf_is_module:
>>>>>>
>>>>>>          if (!btf_is_module(btf)) {
>>>>>>              btf_put(btf);
>>>>>>              return ERR_PTR(-EINVAL);
>>>>>>          }
>>>>>
>>>>> Even btf is btf_vmlinux the kernel's btf, it still works.
>>>>
>>>> btf could be a bpf program's btf. It needs to ensure it is a kernel 
>>>> module btf here.
>>>
>>> Got it!
>>
>> Isn't btf_is_kernel() better here?
>> User space may pass a fd to btf_vmlinux.
> 
> Limit it to btf_is_module. What is the benefit of supporting btf_vmlinux 
> as a fd while fd 0 already means btf_vmlinux?
> 
> kfunc does not support the btf_vmlinux as fd also, supporting in 
> struct_ops alone is confusing. I don't think the major user (libbpf) 
> does this either, so really not much usage other than a confusing API to 
> have both fd == 0 and a btf_vmlinux's fd to mean btf_vmlinux.

It is fair.

> 
>>
>>>
>>>>
>>>>> Although libbpf pass 0 as the value of value_type_btf_obj_fd for
>>>>> btf_vmlinux now, it should be OK for a user space loader to
>>>>> pass a fd of btf_vmlinux.
>>>>>
>>>>> WDYT?
>>>>
> 

