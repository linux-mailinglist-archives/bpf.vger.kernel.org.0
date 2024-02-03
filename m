Return-Path: <bpf+bounces-21123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C2C847E07
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 02:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C31C22446
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86CA3D;
	Sat,  3 Feb 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apUiHlJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C5137B
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922216; cv=none; b=kakVbW2eQB+jAXgeqS2ID99g0P7pnOCO3dM6J5xoOxbQwcAVAYVK89jFY4IeyhqjY3+Ikp3zqNVVzVfYdCIHwQpEP2deq/p2CjvHdyiq4rxRfOmT6tdLFT7n7M+yCjirf/VSykchrTgCQCujr7EHry9fFLxEVPUplbFD41JnFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922216; c=relaxed/simple;
	bh=1U7mN4c5aWk1UzQn705HTsn8dy9k43AfsP+wtR6/Sww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nswj5d/rvAINIQt2BwnOHueYHsRY+vRDgLfLARGQv+jvePxrKdLH3O9TWBr6IVwFnXCJqOyqNO/eccHVLTzdlVwYFuMN22nGVdUnBWSmmSFOoOHcTVMLa4Ynr1lM3EJyAYOUtKG/Gd2DyueVwFeyWWX+V4F1znio+7ZREgZjzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apUiHlJd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so2466659276.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 17:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706922214; x=1707527014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrC+3A71BZKr25Bu2lpXABM6wxYTONB8wbVh8gowdm8=;
        b=apUiHlJdO8WENGH45mRhLzslNfRCw1JPgi6ti228iAehxijB06U7V9w+MGk1jLBoJQ
         9lB+En6ek4KIIwAqfd51Bjx0zEv1zParK5C2ys4n/oikiUCwZp4NftOXHWiH+6lt5dvq
         8A84WRT3GKGx0olXu14TNPp4tv/bJE7Zb9eEf78u5bDyDUcDxhkdp3De4nXIBztLswxJ
         DlGrPp+R3byCYMnbXWviexens/Yt4/VcfVWT+7TNRo80cnsvfJBckoByQzBiv7aCgxnx
         ROW/JPo0ZCssOZQ1PiQzeP1Bqm7uMjWM0nvgsSac28bZac3LxXIJNNkp/b3AkQOuawSo
         Uwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706922214; x=1707527014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrC+3A71BZKr25Bu2lpXABM6wxYTONB8wbVh8gowdm8=;
        b=SGtVtXOm8A2oNJKX7qzT02gk28VcWgzAtBRh2yphtdOFYGwWYjh/kkUdeB0VoH6+rG
         wI17n7JOU3Xh2DCOhB/N9OMU+B+oIGOQYxXO7eADtZF7QkF0kr2pL5lLKClftFstPvB6
         3kkioGDpqFH1BdaGQU9IPK8RlvGnwwcDb4Fw7F4GZYfRUJhP0W7uu66a9r0OQzoMGvYM
         rKBhihOBoePJwrJxeazRunJrwOeLrorWGu5A+nACd+UCWsDGECFXE/lo9wQxuRr7O1lH
         1UNl2crCWnMLtTSoN9k8001I/DgNp3G+dWgTJZy01n4JHyxLGKkNNt81BWCqKFfWK5R8
         FBbA==
X-Gm-Message-State: AOJu0YxHvKsZCCuZJ7ehKLfcdH7LVBybye+MUQtZg58USwaaO+nnidMy
	2qFbVx69HcTAbIhjw6iY4hA/ipHLh+34F++WVVLKgHCZeu2bq3TP
X-Google-Smtp-Source: AGHT+IEERsLyJ0/ou8IQDCRBq65CbuNdqAXfLTEj586Nvi8aTKbLA8X1OJSsktqxUFpXfth7q9cO5A==
X-Received: by 2002:a25:2e08:0:b0:dc2:392e:3ce8 with SMTP id u8-20020a252e08000000b00dc2392e3ce8mr3947943ybu.1.1706922214244;
        Fri, 02 Feb 2024 17:03:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxMuSpZNleZWR50lTnA/0NNMv4oJjPUzB4At/ld/ct8VEQmwaLX7UafwaVX42krhpYdt/CX/u70pklCpUa/iwBIoYQVTguefs9iDS5WJTBipKFWMlOta4wRfups+Y+jqhqOPIlapipPQjDn/CfMr6sY/a4wb0sqP26pNW7svauHPtRjWuQb/p+BGOlio5WJjB+uAy4RBbfH133p0N3Wq0RYnMQg+o/0dX9Gob616FQcIs5YQWrt/F4RK/F/MoQ9E5cLOW3z7UvPulwXut4Gw==
Received: from ?IPV6:2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f? ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id c5-20020a25a2c5000000b00dc26a4ee68asm686722ybn.47.2024.02.02.17.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 17:03:33 -0800 (PST)
Message-ID: <25428377-88f9-4f54-a042-44911bf1a77b@gmail.com>
Date: Fri, 2 Feb 2024 17:03:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v4 3/6] bpf: Remove an unnecessary check.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-4-thinker.li@gmail.com>
 <4a63f6cd-2b0b-4a2b-827b-75bee67b8757@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4a63f6cd-2b0b-4a2b-827b-75bee67b8757@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/2/24 16:46, Martin KaFai Lau wrote:
> On 2/2/24 2:05 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The "i" here is always equal to "btf_type_vlen(t)" since
>> the "for_each_member()" loop never breaks.
> 
> It can be separated from the PTR_MAYBE_NULL support set. Please post 
> this as its own patch without the RFC.

Sure!

>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 0decd862dfe0..f98f580de77a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -189,20 +189,17 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>           }
>>       }
>> -    if (i == btf_type_vlen(t)) {
>> -        if (st_ops->init(btf)) {
>> -            pr_warn("Error in init bpf_struct_ops %s\n",
>> -                st_ops->name);
>> -            return -EINVAL;
>> -        } else {
>> -            st_ops_desc->type_id = type_id;
>> -            st_ops_desc->type = t;
>> -            st_ops_desc->value_id = value_id;
>> -            st_ops_desc->value_type = btf_type_by_id(btf,
>> -                                 value_id);
>> -        }
>> +    if (st_ops->init(btf)) {
>> +        pr_warn("Error in init bpf_struct_ops %s\n",
>> +            st_ops->name);
>> +        return -EINVAL;
>>       }
>> +    st_ops_desc->type_id = type_id;
>> +    st_ops_desc->type = t;
>> +    st_ops_desc->value_id = value_id;
>> +    st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>> +
>>       return 0;
>>   }
> 

