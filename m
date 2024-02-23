Return-Path: <bpf+bounces-22621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001D861F56
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA89BB22B96
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0F14CAAA;
	Fri, 23 Feb 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy3MZamV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44C143C63
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725974; cv=none; b=L/kiVdHcGJPO5+wXWM4Wo+JwPJx2W5t8p66Inhg0oy9iE4OUR0s7lZssNQxeTAkCHwFSTt3qpWqJSvqROo4F6cnyUd+t1kY7cgeJlqrRevH5jzlMw0eEwGo5ZE8RN7QqR8td6ZyvbF56HlBmLOyZCZ0/bACfDBv35A4s2+laQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725974; c=relaxed/simple;
	bh=1kjDi3k0ybpkP9ERfN2NSkOc+Y5LtU+D24fjfpzLNAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4T7J5sVGCxJSYeqyaEsSKYvQgFce07K+mGR6bOAOslD8x4TmuNVrOMq8kpDFaBv90vnEn5P7PyIiH95n7voMOLivMw0Xdmeq4WwwSaDN8Mr0+qDhRCQeY1OWgCtIu3LpR2KgfHYia+55WR154R2rBIvOTuTMfDWx3eShxmh95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy3MZamV; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608ceccb5f4so2066047b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 14:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708725972; x=1709330772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXC+f5hI2NPLoJRCzU43CRVeAShJ4UH6p1jS0GZYZQU=;
        b=jy3MZamVFrEQcv+4Nh5R9k+z+0P36l1v9v1TCpcf5mk39CCC2YF7q61ahWW62WPeVc
         ABckLbXzpC7iIIa6z6+7++TbHJXle4zR/C2l68rOBDqEOzjOmH6kfy1LULQtXunRj5NZ
         DQ0hT9YKpCfQ7ztIFE2osGYWyYkrqpNOgELwCSeATA+ufy5XY3lreZac5n0VVTUDoq1t
         /zdmc0sMAALJrKLRe2eLehp6utn0jhIiHAhtbNBqF2oGQ3oBrcvnIjPiwiMRhkuJslqh
         OdjGhIhxGgvkWlhLtLNeGRpnEKwBsdhIGjDv23qIekNDQ8C5ngc59PtML3XI2za2ckcI
         kvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708725972; x=1709330772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXC+f5hI2NPLoJRCzU43CRVeAShJ4UH6p1jS0GZYZQU=;
        b=dgCsFn592cf3UVaDmvRVH63mRgh4+LnIPEIZIqjezqLTFkaVuIabyvkYIFJtViPC/M
         9oj+PRDA79mxEoOTxlWMhtSCgiHJHX2SixMe/Txwv5ez16E+u54QIQ92Gjr3Od2T3hbQ
         f63/jJmY8GDCZebAiNf2CxcEWa+QBldbz+kRxXQ8/aGt23djCJGzdQ9pZUuqCWSovDOP
         +JT6oWHS5yjD3jljFvIhHw/DdpTDwf1/VKT3cQA4r5G1An2PVEUuIwhLfAjeW/ZwWE8L
         Kdx3Sfhv5njoS0CpaA6ua4UzqU6cF1/lDRNfLrgUrBWVAhwjR9vJ/9TyOarK8m09o5Wm
         V+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVffzRvfGcQPvGDzVPxD8gWYr+JKra3cCxgPmUpWccA1jWM7pSuXjUSGJRDc2OHufTG8OSD7JN1F6ywLju/AoAKmhx+
X-Gm-Message-State: AOJu0YyYOjoOhu3fzbTzDJEXBOZQl3mY3HGa25M09ZPo1Un1nvTG2rRF
	x/0V0Gar4UyrzVzUPbjOlbLipBojoqQaBgPY3uY4cReWmpxBds6Z
X-Google-Smtp-Source: AGHT+IEwTqQHqj9tV2o2uteVDjq40g/626OalDfDDc9NyVvACoDBtf2sWxnw0D8GoqWXWLkbJfzeAg==
X-Received: by 2002:a0d:d685:0:b0:608:cea7:e6ce with SMTP id y127-20020a0dd685000000b00608cea7e6cemr645762ywd.45.1708725971820;
        Fri, 23 Feb 2024 14:06:11 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:f349:a51b:edf0:db7d? ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id b66-20020a0dc045000000b00608943f865bsm1179948ywd.20.2024.02.23.14.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:06:11 -0800 (PST)
Message-ID: <da7288a2-0e3e-4f46-8d09-450a4bc3978b@gmail.com>
Date: Fri, 23 Feb 2024 14:06:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
 <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
 <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
 <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
 <30ffb867-ee0e-4573-b9e7-9fc0f4430adb@gmail.com>
 <363c4377-f668-49fd-978d-73864c293b4e@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <363c4377-f668-49fd-978d-73864c293b4e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/23/24 11:15, Martin KaFai Lau wrote:
> On 2/23/24 11:05 AM, Kui-Feng Lee wrote:
>>
>>
>>
>> On 2/23/24 10:42, Martin KaFai Lau wrote:
>>> On 2/23/24 10:29 AM, Kui-Feng Lee wrote:
>>>> One thing I forgot to mention is that bpf_dummy_ops has to call
>>>> bpf_jit_uncharge_modmem(PAGE_SIZE) as well. The other option is to move
>>>> bpf_jit_charge_modmem() out of bpf_struct_ops_prepare_trampoline(),
>>>> meaning bpf_struct_ops_map_update_elem() should handle the case that 
>>>> the
>>>> allocation in bpf_struct_ops_prepare_trampoline() successes, but
>>>> bpf_jit_charge_modmem() fails.
>>>
>>> Keep the charge/uncharge in bpf_struct_ops_prepare_trampoline().
>>>
>>> It is fine to have bpf_dummy_ops charge and then uncharge a 
>>> PAGE_SIZE. There is no need to optimize for bpf_dummy_ops. Use 
>>> bpf_struct_ops_free_trampoline() in bpf_dummy_ops to uncharge and free.
>>
>>
>> Then, I don't get the point here.
>> I agree with moving the allocation into
>> bpf_struct_ops_prepare_trampoline() to avoid duplication of the code
>> about flags and tlinks. It really simplifies the code with the fact
>> that bpf_dummy_ops is still there. So, I tried to pass a st_map to
>> bpf_struct_ops_prepare_trampoline() to keep page managements code
>> together. But, you said to simplify the code of bpf_dummy_ops by
>> allocating pages in bpf_struct_ops_prepare_trampoline(), do bookkeeping
>> in bpf_struct_ops_map_update_elem(), so bpf_dummy_ops doesn't have to
> 
> I don't think I ever mentioned to do book keeping in 
> bpf_struct_ops_map_update_elem(). Have you looked at my earlier code in 
> bpf_struct_ops_prepare_trampoline() which also does the memory charging 
> also?

The bookkeeping that I am saying is about maintaining image_pages and
image_pages_cnt.

> 
>> allocate memory. But, we have to move a bpf_jit_uncharge_modmem() to
>> bpf_dummy_ops. For me, this trade-off that include removing an
>> allocation and adding a bpf_jit_uncharge_modmem() make no sense.
> 
> Which part make no sense? Having bpf_dummy_ops charge/uncharge memory also?

Simplifying bpf_dummy_ops by removing the duty of allocation but adding
the duty of uncharge memory doesn't make sense to me in terms of
simplification. Although the lines of code would be similar, it actually
makes it more complicated than before.

> 
> The bpf_dummy_ops() uses the below bpf_struct_ops_free_trampoline() 
> which does uncharge and free. bpf_struct_ops_prepare_trampoline() does 
> charge and alloc.
> charge/alloc matches with uncharge/free.
> 
>>
>>>
>>>
>>>>>> void bpf_struct_ops_free_trampoline(void *image)
>>>>>> {
>>>>>>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>>>      arch_free_bpf_trampoline(image, PAGE_SIZE);
>>>>>> }
>>>>>>
>>>
> 

