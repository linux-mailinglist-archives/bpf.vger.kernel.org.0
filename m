Return-Path: <bpf+bounces-22940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898F86BABD
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3161C22777
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9651361D3;
	Wed, 28 Feb 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDZuYqM/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92731361B6
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159296; cv=none; b=K+KV1D18yjEFLwypVP/bpxXDV6HI5jGMbDoZQKdFtaGMyT7VqdIlJqqbNpbgt1pxQ3L4T7I6GmxV5AmP/L5Js1AzxjPtI5hrTpucbhB3dhxkQLfb3KvqSnhyRJbBjraeE0/V+/qPO87QSBWDUlzlYaoV2DU16DuOS7BKsa5rSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159296; c=relaxed/simple;
	bh=byrgnGWisEy6BQqRWXXYcE+tWdgCVww6yoaJK9+6Rdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SESN9f/6ZdNSXPzFMxtnqert3Sy3Gvos33dFw8a7/qNq81M3tkT8suyBTrwLkf3YR01w1YGWaRGTSkBvDPv1ODweUq47ExEwFnacTYmTxxagK0KHM4bSljjq+J4ZOarPtg7dJHwTqpK3HZMdpqwu5MXHKTy2KHg6AZdUKm3FfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDZuYqM/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608ceccb5f4so2104847b3.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709159294; x=1709764094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlxsIphu/aEr9B4xrbK6Fev4ZBNUQW18OfUujP0KQXY=;
        b=eDZuYqM/3/5SmsmzPUiF3D5dFSoH+ycP86LgQEOxD8l16HtbU6kvAR+n7PUagA7Mpi
         h1UaHNHcrP2dm5K+zm+HEqWJZEzFdzg/+fR2rA8Mq4OaIuuAQwEARUhWcXN8AHCeu+o9
         SPWuqM3q/vmB+6YXH/axqvHTZGF0kpagpmpFNTdKt1jaqJHJuB7BLKSf66IR0qhyOOXh
         W1zTMp6q87J1VFDGlN19kHUSUo5sLLk6LI0/qMBNLExHQGFv5eWeq4H2l3YgOKULhES+
         qlYu9rvYjCMu5MSMCcicyXJjIbUYXqlNHCRjzI0Vue4ThpqUOUwSapzA312rvvARMeux
         WY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159294; x=1709764094;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlxsIphu/aEr9B4xrbK6Fev4ZBNUQW18OfUujP0KQXY=;
        b=eXowEGkWAPmhU0vnMFda5fEgCefJglRAVXadJO6d6fLrd5lBgJo2fp998xrXslr8C5
         YqZhN2fxEULkGIY75n0Fk6y+RR1ZVKGcLc/2wV7fG36lGzCJnq2JkpsRS8/P3YQf/DYp
         Dh+FxLL7RGtmFYLJZ6AP/su/1S+h3DraXLHy5zBAPFT7tAEshjHGouDLUU9h++eZl0Ci
         Kvmy0ZYdDfAmKnkUucctNgeULlCBsEwVfogfwySApm2T7msxc1XmB32h26L4QmnB9I9P
         +zmYO129f/r9w9h4NdSNXX6d9qaV/Kq+p/nIsc/qq/Z047b8+ojtW6fpzoYlltdjiTpm
         p3tQ==
X-Gm-Message-State: AOJu0YwKCg0iZtBGNNHmV/sh+Hsk7pCrOwJ5uWzU262OChyPzbnaBAk+
	/0p1RkBgSytggN3BsDzGKBnp79OgruF47+3OS/208e54VaptlpHK
X-Google-Smtp-Source: AGHT+IHaXDCZnCmPvyc8dyNFPZ1wqGnpNldxSpILbZtH1ROB7LObvlxplJZvyYSPbiOG/1UI16A4Kg==
X-Received: by 2002:a81:6c96:0:b0:609:4326:771d with SMTP id h144-20020a816c96000000b006094326771dmr434969ywc.16.1709159293707;
        Wed, 28 Feb 2024 14:28:13 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id i14-20020a816d0e000000b00607d0b5a46dsm6795ywc.38.2024.02.28.14.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:28:13 -0800 (PST)
Message-ID: <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
Date: Wed, 28 Feb 2024 14:28:11 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
 <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com>
In-Reply-To: <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 13:21, Kui-Feng Lee wrote:
> Will fix most of issues.
> 
> On 2/28/24 10:25, Andrii Nakryiko wrote:
>> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com> 
>> wrote:
>>>
>>> + * type. Accessing them through the generated names may unintentionally
>>> + * corrupt data.
>>> + */
>>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
>>> +                                 const struct bpf_map *map)
>>> +{
>>> +       int err;
>>> +
>>> +       printf("\t\tstruct {\n");
>>
>> would it be useful to still name this type? E.g., if it is `struct
>> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
>> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
>> similar pattern for bss/data/rodata sections, having names is useful.
> 
> If a user defines several struct_ops maps with the same name and type in
> different files, it can cause name conflicts. Unless we also prefix the
> name with the name of the skeleton. I am not sure if it is a good idea
> to generate such long names. If a user want to refer to the type, he
> still can use typeof(). WDYT?

I misread your words. So, you were saying to prefix the skeleton name, 
not map names. It is doable.

> 
>>
>>> +
>>> +       err = walk_st_ops_shadow_vars(btf, ident, map);
>>> +       if (err)
>>> +               return err;
>>> +
>>> +       printf("\t\t} *%s;\n", ident);
>>> +
>>> +       return 0;
>>> +}
>>> +

