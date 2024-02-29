Return-Path: <bpf+bounces-22980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA986BCF6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C521B287BA2
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0F208A9;
	Thu, 29 Feb 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msD52to5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924A125CA
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167492; cv=none; b=eyz38umOKToll/GcR5D+DTuN5Mt5vnz0uiVQOQI43gA5WpWZt8VgEQ9dmlhO/gPCrUxHUIoiD1RMuo7LIyDRGhvOTvOoJU5A4xJF5GgsAiBZLaPNP7qjFp8WyHzbhwzsIwyAaYlDWQA4HShk3jP44Xn+MnNKqV457t3J4/rKbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167492; c=relaxed/simple;
	bh=YnnaWDK4QqI6fVu9tXFhfIRwJpTCQz6EWcpGEdwUq5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkoPhI3GdeYSgtAoMaMDhfVzKJQyTurtqq92tgtG6NircN4v9KUblK78aR4gJW9/qyoJ5cGP5OH6WHjFoaan/4h+YDZ9zXY70BTYgtOpH6j8/o6Q5gxmGocWxbaCUtRuLVXXSBNdHUvBdr59qdPfweyOrARfIS5001J1lZfaEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msD52to5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso423382276.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167489; x=1709772289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWyA40Gnd1OdwxWxdIJ02tCWENZPaqYb/tjW157oKM0=;
        b=msD52to5WQCVm69t86ssIwMlQfn/4R7b8M2EtSIC4ZCT9bbPSTQBaXEjSG7QyCaChM
         zdYUAmBI546uIYy87qJqIy/ygoUD2vgjycZjDn3FjIQ8fg8cJ9cEvwuSp8e+8Zd4EhNY
         PFJ7cX55ramunnp4lRQkEqjvDgRe8GHySFzEg6n5MeD6cm0Gs4ZqZv3Lq0qiSKyvMJEF
         JMBrPG7aNZdKdC31noVfm1RtCWEfBathwwM0VWP7PqMwjZ3s8UzDz2+hLsF3d8vuIlJt
         5ncamFLH45Yr0qhg7hTUBAnF8fZ9ixLrJGqZqlSzjmlv+E7kX2e++ec6TlbvvKw8wvzT
         Vahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167489; x=1709772289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWyA40Gnd1OdwxWxdIJ02tCWENZPaqYb/tjW157oKM0=;
        b=iduHE4qTNOr4Bmgb0gKqWRk/mhZoetrWQEeP6dUrwY0AAckTb77asGUasyDu6kNkdz
         bJ84z43ZtOoM1klZ157fQzqbw64TyZjw2Q2wqyLLKRizFugpoU0EaHpwpMGKjh2lIjC1
         ArWgiTTQCSF99CmDib5cCWMt8MalWoQ1mHcovsTjDZ8bo2YJeF0MOHAlzI70cOoU7cmf
         CA6DVVGF7UwSvOs0YWCw13FHEVr+smmmeRTnM1HJ1iestH45IpYQ+ZtjFajp3zAjr1mH
         lUHVKsPCt3s6H+TQFV61Zjyw2Skn5ce59mb4TC6jQCdA3nr8niMUKENXZPznvWhE5UX4
         49Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWcmqB1NyG8eyYV52n5m3zogrU7GpNq1PP7U84MMasF4ka5+Efhpf9wLWPDWajah9tHmqJMfE2MeLghGybOVqIEogww
X-Gm-Message-State: AOJu0YzTK1oM92h0LPpkiejHPBBF4aCYuDWs8BjhuL2/sUv2zckM5bJ+
	HIAayZBr1k+NttRuzTUolZtOLt5XCE+J2IsMDZWp60IWg2Rax3AZ
X-Google-Smtp-Source: AGHT+IH6dADCxnimnXKioGMUyXxA6BZx3mq+tWf4LeBXaXSeKWwLogdv+6UumKaGlsMR/GL9w3lnyw==
X-Received: by 2002:a25:b78d:0:b0:dc7:2e:7646 with SMTP id n13-20020a25b78d000000b00dc7002e7646mr878278ybh.25.1709167489478;
        Wed, 28 Feb 2024 16:44:49 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id x5-20020a25acc5000000b00dc74efa1bb4sm49397ybd.13.2024.02.28.16.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:44:49 -0800 (PST)
Message-ID: <63fb7cb7-e884-472f-a81f-182d5867d1d4@gmail.com>
Date: Wed, 28 Feb 2024 16:44:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
 <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com>
 <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
 <CAEf4BzZSx7XJ4gmq=omjuw0u=CZpQFS=u1iHipOHg+PQN899Xw@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZSx7XJ4gmq=omjuw0u=CZpQFS=u1iHipOHg+PQN899Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 16:09, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 2:28 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 2/28/24 13:21, Kui-Feng Lee wrote:
>>> Will fix most of issues.
>>>
>>> On 2/28/24 10:25, Andrii Nakryiko wrote:
>>>> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com>
>>>> wrote:
>>>>>
>>>>> + * type. Accessing them through the generated names may unintentionally
>>>>> + * corrupt data.
>>>>> + */
>>>>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
>>>>> +                                 const struct bpf_map *map)
>>>>> +{
>>>>> +       int err;
>>>>> +
>>>>> +       printf("\t\tstruct {\n");
>>>>
>>>> would it be useful to still name this type? E.g., if it is `struct
>>>> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
>>>> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
>>>> similar pattern for bss/data/rodata sections, having names is useful.
>>>
>>> If a user defines several struct_ops maps with the same name and type in
>>> different files, it can cause name conflicts. Unless we also prefix the
>>> name with the name of the skeleton. I am not sure if it is a good idea
>>> to generate such long names. If a user want to refer to the type, he
>>> still can use typeof(). WDYT?
>>
>> I misread your words. So, you were saying to prefix the skeleton name,
>> not map names. It is doable.
> 
> I did say to prefix with skeleton name, but *that* actually can lead
> to a conflict if you have two struct_ops maps that use the same BTF
> type. On the other hand, map names are unique, they are forced to be
> global symbols, so there is no way for them to conflict (it would be
> link-time error).

I avoided conflicts by checking if the definition of a type is already
generated.

For example, if there are two maps with the same type, they would looks 
like.
struct XXXSekelton {
     ...
     struct {
         struct struct_ops_type {
              ....
         } *map1;
         struct struct_ops_type *map2;
     } struct_ops;
   ...
};

WDYT?

> 
> How about we append both skeleton name, map name, and map's underlying
> BTF type? So:
> 
> <skel>__<map>__bpf_struct_ops_tcp_congestion_ops
> 
> ?
> 
> Is there any problem with having a long name?

No a big problem! Just not convenient to use.

> 
>>
>>>
>>>>
>>>>> +
>>>>> +       err = walk_st_ops_shadow_vars(btf, ident, map);
>>>>> +       if (err)
>>>>> +               return err;
>>>>> +
>>>>> +       printf("\t\t} *%s;\n", ident);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +

