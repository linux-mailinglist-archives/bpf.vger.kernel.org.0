Return-Path: <bpf+bounces-22434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B8E85E36C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75021F221E2
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB182D82;
	Wed, 21 Feb 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0FrWQ+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDE7C097
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533143; cv=none; b=qnm9039uJ5s1C2L9Ckg65FBvQKhEuv+ItbSdiACrN0dIGq1Wn1y4qZCUIw6Ud/0GEoJEM+5VWlJBvybQXVvuxSfYbqJQYHkoouHvn7Z29liQcIpzCURrI1uZr2kB+4YvsuIixNMTZTx/yiQlgX3HktewACDFj3+alLbeM6zVacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533143; c=relaxed/simple;
	bh=GQFkeIWwGqIjlekC4ujQt1TpQpHwp6nEQABEN+jNJWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBOK8GCPdo9ySth0lkdo1AF63x0hX/oNhPDoTsNLyub2CzUosYvS1wORuIIWNGn1uQkjNs3zI18LF5TxJvVM/U6/kFoEaVqsX7CE61Yusj05yR3h/Sweb0tPqxBvPJSW9TP/vat+YJi+OCMlHqtZc1ReJfPVfr9UKuxFJFw9HvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0FrWQ+u; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60821136c5aso27255117b3.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708533141; x=1709137941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7JXVQFwBDndUh5fJidwUl/Gbzg8C+3RZcO5hzxgkGg=;
        b=U0FrWQ+u7EOpoobDQ/VRFfe8BVKlhxafvsRK3b+ddsH8aQmAETTmjg185499tEgDa6
         dld0anlcEsARTRf59WinQ5D/DlcWXOujfLKKoj6FD/lyx/ky75Xk0oUnZfarru5MiOdX
         UXKQuvXimS6K8iclTa69j5fIgpqOjp+DLmnav4IB9mf2PnUZD1kn4Y0/J+JX4Ezi5nSW
         OHS23QwcIgYhz3vuT8jiRydcEt/hmAg50PGzmPeknA3FtcNnG2AOhhk82fyArm2YbKdP
         VOh8l28baf5Et4/U/mx3osNX1z3NCnrfvYirpldW3L/dKcPMeguJzgizS04hnprUGYKv
         58Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533141; x=1709137941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7JXVQFwBDndUh5fJidwUl/Gbzg8C+3RZcO5hzxgkGg=;
        b=GndwmgWAvgR85/pa3vnAzt+vm+MNBt6nL6+hq9cgK9q3go/fq9kvdM7oWPLYnNQHod
         BAqJkf+oCQuyhdVX9ZQuATqrMSGh+gDjRVbZZbKXn+wZyI91tdhG2G5LtBjlNv5pax+F
         akeU6hMaLD1DdcupWDW6P9K/JrwG9KOdAK+v+XJy5Yb5htykgGBxiRhgZAj0id4vgksn
         juxVQFHSSb7gIg87k2GsSIMlWZEmFw++I8YcTchA+2uzEeyQTozlS38yGnl8soa4u5kn
         kmae+iaZnfT+NFqwsI/8awh1/ul73DDRX1bm4drvN6i1i6+4Oal8KTMEttLD2wp5Fyp1
         0jDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeFmEZVFbCscYGD1RMct9SO6W9Hkf7/1WTL+xgQyq4yNf+9+4lvvbvc3oOUODQYb4Yv+Z+Pcqs/w3ZVhl1AtCyGd8M
X-Gm-Message-State: AOJu0Yyz7nuIh2tHHs2W0MHqKPdeeiK5UkZ5L6pCQKit4Zoz1dkb7sFo
	t1Bb1iZeQCBLm0wlmKFD6/M/btw58qzNmYNS4SrUxPaJCV7AQzat
X-Google-Smtp-Source: AGHT+IFuQobJmlWxI0DveKOl9L1vVIydrk9/2hqsnH4kMVzICDtQWfl77xcI7DbCv19t0aSmR8OuOg==
X-Received: by 2002:a81:8d50:0:b0:608:4e3f:f8a with SMTP id w16-20020a818d50000000b006084e3f0f8amr6611689ywj.31.1708533139587;
        Wed, 21 Feb 2024 08:32:19 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3b:b762:a625:955f? ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id gi2-20020a05690c424200b0060893443e56sm89054ywb.75.2024.02.21.08.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 08:32:19 -0800 (PST)
Message-ID: <923db0bc-cd9c-4c67-a477-cb9b12a58eb2@gmail.com>
Date: Wed, 21 Feb 2024 08:32:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/5] libbpf: expose resolve_func_ptr() through
 libbpf_internal.h.
Content-Language: en-US
To: Quentin Monnet <quentin@isovalent.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240221012329.1387275-1-thinker.li@gmail.com>
 <20240221012329.1387275-2-thinker.li@gmail.com>
 <fc37d1cd-6fbe-4507-b496-2a2dd622934f@isovalent.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <fc37d1cd-6fbe-4507-b496-2a2dd622934f@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/24 03:49, Quentin Monnet wrote:
> 2024-02-21 01:23 UTC+0000 ~ thinker.li@gmail.com
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> bpftool is going to reuse this helper function to support shadow types of
>> struct_ops maps.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c          | 2 +-
>>   tools/lib/bpf/libbpf_internal.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 01f407591a92..ef8fd20f33ca 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
>>   	return t;
>>   }
>>   
>> -static const struct btf_type *
>> +const struct btf_type *
>>   resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
>>   {
>>   	const struct btf_type *t;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index ad936ac5e639..aec6d57fe5d1 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -234,6 +234,7 @@ struct btf_type;
>>   struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>>   const char *btf_kind_str(const struct btf_type *t);
>>   const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
>> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
> 
> If you respin, please add a comment to mention we expose it to bpftool
> (see bpf_core_add_cands() in the same file), to avoid people trying to
> remove it from the header file in a clean-up attempt.

No problem

> 
> Quentin

