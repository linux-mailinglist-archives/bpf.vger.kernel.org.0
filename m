Return-Path: <bpf+bounces-28413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE18F8B919A
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F31F23FD7
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26266165FDC;
	Wed,  1 May 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXZcK8hq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DA1C68D
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601838; cv=none; b=uRHZVSdM2Q4yO1IC4kvgJClO/NnGGxq9FkwK7rG5+DbU+cQoNzjrYBHmW4VN2tYuFt4AadwFoMDCL7DhtARK+xZ7SM9MKDBete55rDoMALeTAfRrkjxrKw7kXay3Br/kfhwEZCZ47+XabVdPk2IIxagMzVtRDUfPGRiAH4ZsIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601838; c=relaxed/simple;
	bh=9UFEIMoNeSJ5nHjM6hmwduJ2NGD7dz5HHVEvFOHXY6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMSu056j5ibpVgCakeWItSWRirANJewV/OI5Kt3Xwjqy+fPRRWdvWvek71soZn68fPwMAwnbZnIP0F1U2wvl4hJbUJtuqZyVIFZ2XJ5PkqN9xWJDBSvzGwohIPUNtwK8pxvgO+rUHULKQGrEQbIGt2p1iFX+RKRpES3npPYOfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXZcK8hq; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c865f01b2bso2286093b6e.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601836; x=1715206636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiMreNUEXV/dbLp1DkTgWgEWJT3eTgfplJtfKXHeXO0=;
        b=YXZcK8hqNcqNgloKYyjiOGTNZvZNC01lO2rDAYkNnDIy8FsAn1wZjTErUIY5jLc2JY
         4uKqU71VRkEnrbVatx03Fj6mDT7FfCHiHkVVA8CYLhc/wuC7NY5/AlsABTSRG/9U/JMr
         KKhez4B8tjfuj0Vlw0jxBvgI5t6+lfn4O2/FuCnyGupiDNvnu8VcPDo2x4U8FGlwrhVE
         vMr3Yd5n/IsIxqq0qkWdGy+luMLOLLS1x+AKL0+CefVx9P/6ev1EtJeldilI4ZvvKB0X
         WqvLbqkpKw55CZAO4OCdD+LDRATw7LH4FK1BkHmbUxxmrtniNT0RX7FLXyeoLNnBtge/
         44rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601836; x=1715206636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiMreNUEXV/dbLp1DkTgWgEWJT3eTgfplJtfKXHeXO0=;
        b=LpCXcAQPzC9LSmeqY0yarXIwpmGzOhrIx07XD3UCJmDbIDQwIyhOL+V5J7buniPGZS
         N0aOWDVedFWnyYscaHoR5f/hIccJuy+92ZmizdU+hKyypB/5W/k+QdhDeHCdiGupYYsP
         RbYs1y35DT0wv4w6/+ATxXThX24dYpJc45jXING0Uwgq5cUwKK6p2B0+wr7R7Kt5wESu
         hFygU1pp742PgbtyAn9Fl4NycnCvz69WETxHnFc9U9QEqMe5jKbeEmoIJ1hua7grvN43
         YNEM0/peb88TCVN0btvTfOr0lWcoiAfp8hVc3+iqM/SYZeIvlpLCqNENpauCmZZDl4YZ
         j4Lg==
X-Gm-Message-State: AOJu0YxCozT8qo6gTh/gYkslOVeZWizNu7nr2FAQ/w/xnlNoKKPv6QxB
	0oEXyKq7QHy7MwTbc7Q4oy36dPnzeBg3hEv1cQ77qsif1BzfNgyz
X-Google-Smtp-Source: AGHT+IHAxkaVkMYNva1dxdB3P3gYWY5/4QEO5hLexyQShKUZKMQq6dVBoicjTjc3Vs6xVmxSGZcvgQ==
X-Received: by 2002:a05:6808:1187:b0:3c8:6dd0:d13 with SMTP id j7-20020a056808118700b003c86dd00d13mr4486726oil.32.1714601836509;
        Wed, 01 May 2024 15:17:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:22b9:2301:860f:eff6? ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id ck20-20020a056808251400b003c94e008a56sm280686oib.29.2024.05.01.15.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 15:17:16 -0700 (PDT)
Message-ID: <63356785-f6e5-4afc-a9f4-7dbf7e2dd4d1@gmail.com>
Date: Wed, 1 May 2024 15:17:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops
 links.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-7-thinker.li@gmail.com>
 <CAEf4BzYha=c8_JRMHBooYX-ny5aqmNUKc0now1OkqteXVOBRGQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYha=c8_JRMHBooYX-ny5aqmNUKc0now1OkqteXVOBRGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/24 10:05, Andrii Nakryiko wrote:
> On Mon, Apr 29, 2024 at 2:36 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Verify whether a user space program is informed through epoll with EPOLLHUP
>> when a struct_ops object is detached or unregistered using the function
>> bpf_struct_ops_kvalue_unreg() or BPF_LINK_DETACH.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  18 ++-
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 104 ++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   |   7 ++
>>   4 files changed, 126 insertions(+), 4 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> index 63b065dae002..7a697a7dd0ac 100644
>> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> 
> this file is a bit overloaded with code for various subtests, it's
> quite hard already to follow what's going on, I suggest adding a
> separate .c file for this new subtest

Ok!

> 
>> @@ -81,3 +81,10 @@ struct bpf_testmod_ops___incompatible testmod_incompatible = {
>>          .test_2 = (void *)test_2,
>>          .data = 3,
>>   };
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops testmod_do_unreg = {
>> +       .test_1 = (void *)test_1,
>> +       .test_2 = (void *)test_2,
>> +       .do_unreg = true,
>> +};
>> --
>> 2.34.1
>>

