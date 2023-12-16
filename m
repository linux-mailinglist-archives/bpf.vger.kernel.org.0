Return-Path: <bpf+bounces-18085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF48157E5
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 06:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AA3287CFF
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A212B6B;
	Sat, 16 Dec 2023 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnM/lG/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9435125B7
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbd029beef4so720047276.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702706162; x=1703310962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQPxPcNdEvQfHbIPTD4ZrTVSqPo/xlrUfGf2/a+LW2Q=;
        b=fEnM/lG/RZAwAmAholdPO3/eaMfATxAjCTDAhv8MuVD7KwY0RcN9ryfuxsaKDGaqhQ
         8G+uaVC92HDdZIOz5Q5TjNfMVV47HW8dIwLtVKJG9pCP15UfHmgW4FPb7l+s8fZYhcbR
         DEiv1Tj++WHGZmMvIZKfqOitZC0WEdiO88yNOdhd8zkYoolAjE7UPs/jXY0acIIvwB0W
         0L07nvLx3eBiRqWfjAdACdbAFIHwYNem2pCYGxW+pBJ2xftK8C7/huaIMbDCav72F3by
         XhlgGG+b1ZOA7+wNvjVEB9xXVNzoVik2MRAYhoRLW5t2H2+yEAdm18AbIbOI433Fj7eg
         yftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702706162; x=1703310962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQPxPcNdEvQfHbIPTD4ZrTVSqPo/xlrUfGf2/a+LW2Q=;
        b=WRCQaXZPJPjqMN+uE04pFe3Qcw5GF+SK9qE8MI1kbvq1jwyTXH9bOcCEsfbo1LG62l
         fvHsS93DX2Er1MatoiCIKSyodCISjreRAj1pLaHNZ/XDhbgIpkUvWUaa2ZiNvipCtQNj
         xBeuHNQjRIHbHZ9LZjlkO4EBFRWPggvjPxsni0alihb8T9WOZyFqnwIBBY5iGLfvctkf
         RClcv5+YQzkYogIS4QTSyosO7V6WamvepqzhnipUUAgYqSX0pg3Y/yOqBKRQ1ozBsDkh
         WR0JZmJbCMpGv9Ga0XzWtwhJOaqkaL0sq5IFOa8VFmNmsFkaQJA2T0LLmDS3woItMFkv
         B11g==
X-Gm-Message-State: AOJu0YyeOxLsYY1v0db0rawAM1kYRzLBVDtfdzlnMDJecjGq67aoLa7j
	ikTOPgKeVyLCWG2lcLFeBaQ=
X-Google-Smtp-Source: AGHT+IGVgKCSkbFsWAUAygnXIZ3y1DJie37cstUfEqbezU2zEJ1j/cUkDjFuV/mw+96OXeMbafaxwA==
X-Received: by 2002:a25:da06:0:b0:dbc:ca37:4a5e with SMTP id n6-20020a25da06000000b00dbcca374a5emr4977056ybf.11.1702706161656;
        Fri, 15 Dec 2023 21:56:01 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:d12f:74e4:d58f:4cec? ([2600:1700:6cf8:1240:d12f:74e4:d58f:4cec])
        by smtp.gmail.com with ESMTPSA id k15-20020a5b0a0f000000b00db54cf1383esm5900096ybq.10.2023.12.15.21.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 21:56:01 -0800 (PST)
Message-ID: <a3ab56ff-ca03-4f28-b2e7-4f0b50bfaaae@gmail.com>
Date: Fri, 15 Dec 2023 21:55:59 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <3fd164b6-622e-499e-9fa4-6d56442b086f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/15/23 16:19, Martin KaFai Lau wrote:
> On 12/15/23 2:10 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/14/23 18:44, Martin KaFai Lau wrote:
>>> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>>>> @@ -681,15 +682,30 @@ static struct bpf_map 
>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>       struct bpf_struct_ops_map *st_map;
>>>>       const struct btf_type *t, *vt;
>>>>       struct bpf_map *map;
>>>> +    struct btf *btf;
>>>>       int ret;
>>>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>>>> attr->btf_vmlinux_value_type_id);
>>>> -    if (!st_ops_desc)
>>>> -        return ERR_PTR(-ENOTSUPP);
>>>> +    if (attr->value_type_btf_obj_fd) {
>>>> +        /* The map holds btf for its whole life time. */
>>>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>>> +        if (IS_ERR(btf))
>>>> +            return ERR_PTR(PTR_ERR(btf));
>>>
>>>              return ERR_CAST(btf);
>>>
>>> It needs to check for btf_is_module:
>>>
>>>          if (!btf_is_module(btf)) {
>>>              btf_put(btf);
>>>              return ERR_PTR(-EINVAL);
>>>          }
>>
>> Even btf is btf_vmlinux the kernel's btf, it still works.
> 
> btf could be a bpf program's btf. It needs to ensure it is a kernel 
> module btf here.

Got it!

> 
>> Although libbpf pass 0 as the value of value_type_btf_obj_fd for
>> btf_vmlinux now, it should be OK for a user space loader to
>> pass a fd of btf_vmlinux.
>>
>> WDYT?
> 

