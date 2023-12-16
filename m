Return-Path: <bpf+bounces-18086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52D8157F3
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 07:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1BB1F234DF
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E912B79;
	Sat, 16 Dec 2023 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHe/yu0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB112B6B
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-203965f2da4so19757fac.3
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702706836; x=1703311636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NgA4WStLDgBriVIIz7c82UeMlZD0QR/ftt8MloP+Yw=;
        b=eHe/yu0JXv50i13E4giWiQFFnErDJD+47OuqjVYQbv6DAJ51GpVLIS13eHGgbS52Hb
         N0CEUcSZEcX0zXCe21UgoI6dIbLfJKgINKQdV3Aixe2O5KZ/XqJMe+vT4rF6qHLePhFv
         Xfgq9cA/NV53OawpvPa0E58p8m8xMwr4qYlw4uGeDfrPzZgwc4PyOvyZsQp62Dal2GkK
         sh9obDPv074NVWrjSuXIxEGRu7eZqOyi5Ci43drLio1jmrb68ssO/temRMtrjJ4FsIev
         xiauQZ43r/J+krvJ/W2NReHSqDKguojlG4deyU6sm56w1jPQxGSb8KiW1c400s9xdoJz
         6qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702706836; x=1703311636;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NgA4WStLDgBriVIIz7c82UeMlZD0QR/ftt8MloP+Yw=;
        b=lhKTl7erNbTxTHztBPhQSF4VizMBJ0VTQShDZepLp/Tm7UYqDxAMRCVPHswAvFDYaL
         /TZXZAQi1ujhqik7F3HQnquuU22lT6fbakgEItlr3YCXMEREvjd8uovyOQh1UWV75oXA
         mPPvQ+UMYc9D3/yr5KVUEk3R4piuUJ6E7GMeOPeASsrIP+uVaC8Qx45u2g4QMg1Qm8ao
         qbet7wXqQalnclFmSbsCMy40u2Kwul+bpAbaJklJ6hdY2LVRSEJlQtGkGymF1uKsJecJ
         gkfaJOaL6OFI9SoglwQOtKXtnfyMfk76FA16f6oK0VIzoxrC4PF5/gidXHMfUKX/AG9m
         igPg==
X-Gm-Message-State: AOJu0YyljGgqGMTzM5kNOEQHTxkWEWjE6Qj3ccV75xuCYXIoA3fiYXyP
	oRAE6ms36guKP5ee9a/0HBjmQgpSIf4=
X-Google-Smtp-Source: AGHT+IGHa5aYkk4IX4025yfM3PtKqm82Zwb4pzjhfUuB7L1Jl3WM4UuskTDX3VEUUMv2wFXCrLzufA==
X-Received: by 2002:a05:6870:d1c1:b0:203:4d5f:9143 with SMTP id b1-20020a056870d1c100b002034d5f9143mr3671751oac.31.1702706836049;
        Fri, 15 Dec 2023 22:07:16 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:d12f:74e4:d58f:4cec? ([2600:1700:6cf8:1240:d12f:74e4:d58f:4cec])
        by smtp.gmail.com with ESMTPSA id f190-20020a0ddcc7000000b00577269ba9e9sm6889522ywe.86.2023.12.15.22.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 22:07:15 -0800 (PST)
Message-ID: <390f3c92-2df6-4cea-aa78-ecc92a9fe8aa@gmail.com>
Date: Fri, 15 Dec 2023 22:07:14 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-8-thinker.li@gmail.com>
 <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
 <e2222287-6438-4de7-a747-9e04c5fd3f55@gmail.com>
 <3fd164b6-622e-499e-9fa4-6d56442b086f@linux.dev>
 <a3ab56ff-ca03-4f28-b2e7-4f0b50bfaaae@gmail.com>
In-Reply-To: <a3ab56ff-ca03-4f28-b2e7-4f0b50bfaaae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/15/23 21:55, Kui-Feng Lee wrote:
> 
> 
> On 12/15/23 16:19, Martin KaFai Lau wrote:
>> On 12/15/23 2:10 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 12/14/23 18:44, Martin KaFai Lau wrote:
>>>> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>>>>> @@ -681,15 +682,30 @@ static struct bpf_map 
>>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>>       struct bpf_struct_ops_map *st_map;
>>>>>       const struct btf_type *t, *vt;
>>>>>       struct bpf_map *map;
>>>>> +    struct btf *btf;
>>>>>       int ret;
>>>>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>>>>> attr->btf_vmlinux_value_type_id);
>>>>> -    if (!st_ops_desc)
>>>>> -        return ERR_PTR(-ENOTSUPP);
>>>>> +    if (attr->value_type_btf_obj_fd) {
>>>>> +        /* The map holds btf for its whole life time. */
>>>>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>>>> +        if (IS_ERR(btf))
>>>>> +            return ERR_PTR(PTR_ERR(btf));
>>>>
>>>>              return ERR_CAST(btf);
>>>>
>>>> It needs to check for btf_is_module:
>>>>
>>>>          if (!btf_is_module(btf)) {
>>>>              btf_put(btf);
>>>>              return ERR_PTR(-EINVAL);
>>>>          }
>>>
>>> Even btf is btf_vmlinux the kernel's btf, it still works.
>>
>> btf could be a bpf program's btf. It needs to ensure it is a kernel 
>> module btf here.
> 
> Got it!

Isn't btf_is_kernel() better here?
User space may pass a fd to btf_vmlinux.

> 
>>
>>> Although libbpf pass 0 as the value of value_type_btf_obj_fd for
>>> btf_vmlinux now, it should be OK for a user space loader to
>>> pass a fd of btf_vmlinux.
>>>
>>> WDYT?
>>

