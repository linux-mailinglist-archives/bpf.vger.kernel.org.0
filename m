Return-Path: <bpf+bounces-15720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15617F551A
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9AB20E82
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749221A00;
	Wed, 22 Nov 2023 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDp53tyv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018193
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:59:35 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cca00db7f0so3332187b3.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700697575; x=1701302375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmt5KPW0q9Bfn0yTwQvTVNcKqWmiNVxD80M2+vzdyTs=;
        b=KDp53tyvAc1NJyy8cE8SHMEvFpGORkNCM4K9l47dhkdeOH4WIEwbM9FmHYtizCg/Mf
         BOZiJExMm4oz+7mdp9UxoB4/NBl/mXS+MINxohciW4032ymR8HXw/jRZKy4ScrZE/1ed
         Bx7rEx2slDPp/j5c4A6uSTcrqqjpbuKmSLehD/dNvy8V5QuIFIfpCwFZxqvYncQ4gDRl
         N0C+ZFFnXgI3vljXckCIkX3UcUQ2xiLqhUpwyJ2TR8cMbvNGvu+y8V+mJlQbmv9Nj6L4
         /vc/qC5/biOrBTCDGctxYUcIWo7ZRN7NDsWHZI0uKNkeNM3J+oG4c/XyIMKh3Fk10bhj
         IWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697575; x=1701302375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmt5KPW0q9Bfn0yTwQvTVNcKqWmiNVxD80M2+vzdyTs=;
        b=C8KMFxYQsAANGqU9rb20lzZYRq3OLZiTbibr3oUHPkknW623ibcJuhthXC8th5UBFI
         XXVm/+kGoSi7h2TS7rgTWmVkTxZ++HGuaTsZdAoorCfmhxHbyNua3ubT216ARglwrgCz
         r5Nw11wHmpphHvf+tp8Y1NTgE8uXl05NYW4xtHssmVag4TNNOmjS/i2MZqR/NY4ECn8W
         UaMC2yfcgwi+RHs5o5MVYx2hk1hR/lk/7QZd9HZKe2DTwGkBsspODjexeIxGWZZ55o3m
         cbi4MHbbaXK39pvriqtzxoDvHGaV8r5Rag4nspocXsHgd6ixzg5GLizr/LX32eQHM1WC
         /gxQ==
X-Gm-Message-State: AOJu0YwjOy/C4yfWjb76bzyDw7nUPvulGbEhisZTn20wJSwk/luYmzyT
	6n3hjM5BoXq4oDqK+jx5RdPJ1w0xtuU=
X-Google-Smtp-Source: AGHT+IHP0m59b91NpN2Mv5+o2bOMrBYglEG/0/HOXcuJrqrE3BE38M96V0lHLaL+23SBsY2BjI7kTg==
X-Received: by 2002:a81:4810:0:b0:5ca:876c:39ad with SMTP id v16-20020a814810000000b005ca876c39admr3813748ywa.15.1700697574805;
        Wed, 22 Nov 2023 15:59:34 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5a79:4034:522e:2b90? ([2600:1700:6cf8:1240:5a79:4034:522e:2b90])
        by smtp.gmail.com with ESMTPSA id y134-20020a81a18c000000b0057a918d6644sm51480ywg.128.2023.11.22.15.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 15:59:34 -0800 (PST)
Message-ID: <736c9ced-f904-421d-b37d-4eaa995400b1@gmail.com>
Date: Wed, 22 Nov 2023 15:59:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 13/13] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-14-thinker.li@gmail.com>
 <fc7f56af-03e1-faa1-1e53-12dfe353d46e@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fc7f56af-03e1-faa1-1e53-12dfe353d46e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 18:23, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create a new struct_ops type called bpf_testmod_ops within the 
>> bpf_testmod
>> module. When a struct_ops object is registered, the bpf_testmod module 
>> will
>> invoke test_2 from the module.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++++++
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 144 ++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   |  30 ++++
>>   .../testing/selftests/bpf/progs/testmod_btf.c |  26 ++++
>>   5 files changed, 264 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/struct_ops_module.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/testmod_btf.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index a5e246f7b202..418e10311c33 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2020 Facebook */
>> +#include <linux/bpf.h>
>>   #include <linux/btf.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/error-injection.h>
>> @@ -522,11 +523,66 @@ BTF_ID_FLAGS(func, 
>> bpf_kfunc_call_test_static_unused_arg)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>>   BTF_SET8_END(bpf_testmod_check_kfunc_ids)
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> 
> I don't think it is needed. It should have been enabled 
> (directly/indirectly) by the selftests/bpf/config already.

Got it!

> 
> [ ... ]
> 

