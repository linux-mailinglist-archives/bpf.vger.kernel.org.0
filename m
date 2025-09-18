Return-Path: <bpf+bounces-68871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B7B8737D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B374D1C28611
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC822F5307;
	Thu, 18 Sep 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJT2eSi3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32B2E0937
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234056; cv=none; b=Tfyn+NNXdwrJmN5Tp+lcO5duNES3p7xDgddz1+1FVbw0i1JqYENOOWbYny7AUc5pK5O7QxcMptE2ezlz9QhxIDh8kinWeKkYdps/PFQrAvap3AJp8BnkLX9kFs1cmSpKWaxJpsIWutz1epHNdLHCKhZnOIacGFYCpHMuK2XTdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234056; c=relaxed/simple;
	bh=iHWsGMaKey4yITjX9SoaEAmv3FtLMhN6GpPo0s837mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhgLEb96MNl/9FsxdqcWTAJHiDdBiK/qGKtiNkCc6NOEarcv4MEfVtHdgQ4fHliTKvMMXyWycN2rpUtPvE1jQ1G2FynY1kJXheOh+9pDqwXjxU+kZIgR7/MK8La44ZLfUFotp7ptGP0iW+ON7aEUeL/xRFbAv8HWBFDqhlQfKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJT2eSi3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so14384475e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234053; x=1758838853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHmzFY5Rcg93iJ3UlAiBoiH+h9aCZQlhbT6KgzjfsV8=;
        b=RJT2eSi3l/7O78zCJgM+gE5zEPNW5NhFGT/yk9UIYMOCgvvxu6OFGU8wvFeU2zDS30
         GtVoPhbn25pZQx+U4O2Waul1u6+WwVY2jHAom9cLNOauY3lnT2QWjvth0skueysQSJh1
         711l40s6seoXffHXfAAexo1jOS0ZVcxfWVSA1nf088wG2G/MYkAh57TodV7fQTxLFvNc
         ak1zUMAqVr/rrPcMzABqDBnUly1KVKR3z/w4L/hvao9MV9P3JFS3re3a3RenZPTUlnoZ
         jQSQ0we0JjFwKGszKUxsMm9Z3rFJMOOIW95E6CeVtuIagdL64zBaoxNDHTMOKzAR/QY8
         axbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234053; x=1758838853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHmzFY5Rcg93iJ3UlAiBoiH+h9aCZQlhbT6KgzjfsV8=;
        b=OlMPhghPGlKjbLwqSz59cgoz+sDEBSU7m7ZiZCHvNeVySI8DO3INLFhhSzOwDEc2IM
         EOV48mia2VTZdLN8pceUO0CCAWlUecI6JbxisX3wiMOrmrEj8RGBl/i96b+EKfao4Lsf
         NLGbTBMBQnR3QPekT4jNLyszmrfhjmK6s9qLkW7ayL33Eb5Qd0Hi/Ld1P67G8H/5pjvo
         37mnOG4gc7DWuqXdu6r7gb+zeLwhODzB1+Ft96jR/HHmwuxcofr5XaTHRaLj88z6xHou
         sKRPiPRKqAXqWTnfTJRpH2g8jBmI/Z2OrVG8rAqaTViYS96G4xxutVTWtwqaMz6H6Ltl
         IEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0nY543DDYRDoHXOMy1qZKjwfuaufWgc9VoiCffzZCYTd5NLpC+UaOVHbNlzTpjZcC3yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vP3i4NDofKLl2sDeeAk/b/f+m29qaCQTmg/SI7uXXTigy4QF
	Zew044b5E9WVAhciKiSQQDmvoxjWhDrO9g+8kSwsZbT7SAFpQmHy52Tx
X-Gm-Gg: ASbGncue9c0g6CQCoYqwkQyTjWRQ9wD1isE1V34iKnNwGVbUfnU7olkkSgo3x2GVK0q
	104KfCx8W612wuEgYKzW7uTw1YS9FaR1v2+hf4xn0EAwMz/LDMC+mzl1DiVh6UqrlZvWo5JSd4C
	8Fs36vcktEW9rypmWig/0XVuN1NuV50GTyyBGR81oCWp2/5Oxip6FConkNWk+em59wLOAFlVaYJ
	HyM9qD/wXThD2d4iW0HQGmQW4ZGs6F5Ew2dXFWe+MEVrr/21/KD/Lf4gQ0yYMn47ZmOEgw1hXaw
	a9cmG+i4H0IQJXuNEimLw38cGrxSbeSaYDyzt5ssuUeiIKlI1/F5emFIqKqVi+1aJmbxZvo7SRi
	N6t1HgkpIqVDaPBlRz44E+bmnbnS10VAWnbj2nMwLSpsXKtDsJZwzWTCFK84gjw==
X-Google-Smtp-Source: AGHT+IGML5/QJCz9U+lKghBYrIzC4lGZURf7Dh+Gs22yGJT5BoqB0by7PQgqunuXGSL5naMRmTdVLg==
X-Received: by 2002:a05:600c:c162:b0:45d:e110:e673 with SMTP id 5b1f17b1804b1-467e63be4d0mr6613675e9.4.1758234052448;
        Thu, 18 Sep 2025 15:20:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::10de? ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm114319045e9.12.2025.09.18.15.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 15:20:52 -0700 (PDT)
Message-ID: <2942fd08-ad9c-42b2-b3d6-eabdd2576858@gmail.com>
Date: Thu, 18 Sep 2025 23:20:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/8] bpf: refactor special field-type
 detection
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-2-mykyta.yatsenko5@gmail.com>
 <395da6e0-15ed-47b8-88b7-93df61061e7d@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <395da6e0-15ed-47b8-88b7-93df61061e7d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/18/25 22:09, Amery Hung wrote:
>
>
> On 9/18/25 6:26 AM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Reduce code duplication in detection of the known special field types in
>> map values. This refactoring helps to avoid copying a chunk of code in
>> the next patch of the series.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   kernel/bpf/btf.c | 56 +++++++++++++++++-------------------------------
>>   1 file changed, 20 insertions(+), 36 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64739308902f..a1a9bc589518 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3488,44 +3488,28 @@ static int btf_get_field_type(const struct 
>> btf *btf, const struct btf_type *var_
>>                     u32 field_mask, u32 *seen_mask,
>>                     int *align, int *sz)
>>   {
>> -    int type = 0;
>> +    const struct {
>> +        enum btf_field_type type;
>> +        const char *const name;
>> +    } field_types[] = { { BPF_SPIN_LOCK, "bpf_spin_lock" },
>> +                { BPF_RES_SPIN_LOCK, "bpf_res_spin_lock" },
>> +                { BPF_TIMER, "bpf_timer" },
>> +                { BPF_WORKQUEUE, "bpf_wq" }};
>> +    int type = 0, i;
>>       const char *name = __btf_name_by_offset(btf, var_type->name_off);
>> +    const char *field_type_name;
>> +    enum btf_field_type field_type;
>>   -    if (field_mask & BPF_SPIN_LOCK) {
>> -        if (!strcmp(name, "bpf_spin_lock")) {
>> -            if (*seen_mask & BPF_SPIN_LOCK)
>> -                return -E2BIG;
>> -            *seen_mask |= BPF_SPIN_LOCK;
>> -            type = BPF_SPIN_LOCK;
>> -            goto end;
>> -        }
>> -    }
>> -    if (field_mask & BPF_RES_SPIN_LOCK) {
>> -        if (!strcmp(name, "bpf_res_spin_lock")) {
>> -            if (*seen_mask & BPF_RES_SPIN_LOCK)
>> -                return -E2BIG;
>> -            *seen_mask |= BPF_RES_SPIN_LOCK;
>> -            type = BPF_RES_SPIN_LOCK;
>> -            goto end;
>> -        }
>> -    }
>> -    if (field_mask & BPF_TIMER) {
>> -        if (!strcmp(name, "bpf_timer")) {
>> -            if (*seen_mask & BPF_TIMER)
>> -                return -E2BIG;
>> -            *seen_mask |= BPF_TIMER;
>> -            type = BPF_TIMER;
>> -            goto end;
>> -        }
>> -    }
>> -    if (field_mask & BPF_WORKQUEUE) {
>> -        if (!strcmp(name, "bpf_wq")) {
>> -            if (*seen_mask & BPF_WORKQUEUE)
>> -                return -E2BIG;
>> -            *seen_mask |= BPF_WORKQUEUE;
>> -            type = BPF_WORKQUEUE;
>> -            goto end;
>> -        }
>> +    for (i = 0; i < ARRAY_SIZE(field_types); ++i) {
>> +        field_type = field_types[i].type;
>> +        field_type_name = field_types[i].name;
>> +        if (!(field_mask & field_type) || strcmp(name, 
>> field_type_name))
>> +            continue;
>> +        if (*seen_mask & field_type)
>> +            return -E2BIG;
>> +        *seen_mask |= field_type;
>> +        type = field_type;
>> +        goto end;
>>       }
>>       field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
>
> How about extending the scope of the refactor by also handling 
> btf_get_field_type in the loop? For example, add a "bool is_unique" to 
> field_types and check seen_mask when is_unique == true.
sounds good, I can include it in the next version.
>
>> field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
>


