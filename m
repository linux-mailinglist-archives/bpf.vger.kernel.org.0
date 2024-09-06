Return-Path: <bpf+bounces-39150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47A96F88E
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8CA1F21F1C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF001D3192;
	Fri,  6 Sep 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Voszv5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0B1D318E;
	Fri,  6 Sep 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637505; cv=none; b=QbOTeYA7ZcUD+v0jT8CJuddOputWEvU9VOe9+htM5C0toldiLCO9OLS4Dv0V8pO8G3fqqJu2x8nVvfIYQI3eUQpcbKFcMKzy3RUYlkmVC9jlUdj9OSHupQ7EoJz6G5zFtTdlGylgZGeGi3UtHrYrbxK8EtXRF/ABZulTn3fu20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637505; c=relaxed/simple;
	bh=v+6PmdptN06I4wNjTeXRkYbKX2jdmJq46oAeXHd9CjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opjBYkJJ2+YwYFjw9B1kBGVE7UFwgJSjG0LarzEvxb2gxBViRLNA5W9om45nGEmDyEYYKi/D1cBkvOCPkWoAFdg0oelNZJfwDYSSI9cOg3aOOIAkNo6/Jz1IQMeppPO1LH4Nkup2t3SxOgBEnQq/Y1C3BJY6Cm0YmOEvAw6ht4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Voszv5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d6ad6050so678152b3a.0;
        Fri, 06 Sep 2024 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725637503; x=1726242303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qJt3dWuSS/7B+CarKMiwXcxl0tVTC+pGimSt0Bqmgk=;
        b=P5Voszv5BetaZTHJ1HDct8VKhVYh4sTCDfmR/zQ4m8q1aepy0zwIpdaIwM728/pQs7
         Bdi4hgSPzGmQjK8E3Ym3Wan7rSV+phuloqcdVOXL5Y78KelXGwQ7pAG026caifxQKPG0
         EOEt++D8D95gCgk9veg4SpvxEv8Y5MLc8zRKPHfEv9D9LPsp6KJz3sn4P1A/EsNinqq5
         pkeD8OB6DdZEJtByZpaowdga8V7r6cD0a05YIu5YsAaChRqgJf0RFTpMeS+xFhs/pDwQ
         zXgwJ6hgRSrA+RQUEflBHxUIun+vOOVKSFmolsQ9lWRyKKE+daoIPx/wOBhck/Hk2Bpc
         nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637503; x=1726242303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qJt3dWuSS/7B+CarKMiwXcxl0tVTC+pGimSt0Bqmgk=;
        b=RvZYLFIlOVvtaEntvO/92GuedyMA7pEs85UxIEiGIoMeAE9HNUZm0tnQX+c90qNXlY
         zlaqk8yurQiHSMyFnLqeiToacfH+6UVakHs2O0QqFBmhRyysGfGyNdXUQ88N5FqAR9jk
         F3fu1IT5SbD9+k/hucpWMHPD7k0avXx+OuBZiOxKwujQ1iM/kKkITok8ClhfuG7Zxx05
         ghg34vWobpgQqPvstZ/vbWVVkbIhfyRJXGHEX5ZuFjJzCeQ0pVEJfWKlRI4ytUuI5SSx
         abkNdSXQCbJimGgLQaOn4EYL0fIVKGYsqytdrsqojm1y19zSDQ5ao5d9whB9xPNDlLhA
         O/bg==
X-Forwarded-Encrypted: i=1; AJvYcCWCQ/OPwqpXfe/s+ZXowmiiQ6dW+cldPpcLykznxSHQLAUOLZtAIkQn/bx+nLEf22JzM24mCYRMkBhhutM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGbjFQt63Nv6YrAPMUs4ZtR6pRFvMIbaCPkgXqRvgxwVCAKwp
	I0G0NnFs/qfPWCWDnwrtDSaykSZLARe3piprtgYJSu7B1ocPe0aw
X-Google-Smtp-Source: AGHT+IFDHfgU9JbVYBlq+aSvZ5zwRSimx0Dro3dTyFgId2njIwo5aE1ZzLA7cptKc9zGvd0qPQf5Rg==
X-Received: by 2002:a05:6a00:1303:b0:70d:323f:d0c6 with SMTP id d2e1a72fcca58-718d5f542b1mr3597391b3a.24.1725637502877;
        Fri, 06 Sep 2024 08:45:02 -0700 (PDT)
Received: from [192.168.0.106] ([183.247.1.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178df6b01esm2941047b3a.75.2024.09.06.08.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 08:45:02 -0700 (PDT)
Message-ID: <8195c890-d862-4427-9a5c-e59cf11009e3@gmail.com>
Date: Fri, 6 Sep 2024 23:44:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next] bpf: Check percpu map value size first
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20240905171406.832962-1-chen.dylane@gmail.com>
 <fab1c1c1-a973-a32c-8936-d0d885d4b5af@huaweicloud.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <fab1c1c1-a973-a32c-8936-d0d885d4b5af@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/6 11:20, Hou Tao 写道:
> Hi,
> 
> On 9/6/2024 1:14 AM, Tao Chen wrote:
>> Percpu map is often used, but the map value size limit often ignored,
>> like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
>> percpu map value size is bound by PCPU_MIN_UNIT_SZIE, so we
> 
> s/SZIE/SIZE

Hi Hou, thank you for your reply!
My bad, i will fix it in v2.

>> can check the value size whether it exceeds PCPU_MIN_UNIT_SZIE first,
> 
> The same typo here.
>> like percpu map of local_storage. Maybe the error message seems clearer
>> compared with "cannot allocate memory".
>>
>> the test case we create a percpu map with large value like:
>> struct test_t {
>>          int a[100000];
>> };
>> struct {
>>          __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>          __uint(max_entries, 1);
>>          __type(key, u32);
>>          __type(value, struct test_t);
>> } start SEC(".maps");
>>
>> test on ubuntu24.04 vm:
>> libbpf: Error in bpf_create_map_xattr(start):Argument list too long(-7).
>> Retrying without BTF.
> 
> Could you please convert it into a separated bpf selftest patch ?

No problem, i will add test case in v2.

>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   kernel/bpf/arraymap.c | 3 +++
>>   kernel/bpf/hashtab.c  | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index a43e62e2a8bb..7c3c32f156ff 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
>>   	/* avoid overflow on round_up(map->value_size) */
>>   	if (attr->value_size > INT_MAX)
>>   		return -E2BIG;
>> +	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>> +	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
>> +		return -E2BIG;
>>   
>>   	return 0;
>>   }
> 
> Make sense. However because the map passes round_up(attr->value_size, 8)

Yeah, you are right, it seems better, i will add it in v2.

> to bpf_map_alloc_percpu(). Is it more reasonable to check
> round_up(value_size) > PCPU_MIN_UNIT_SIZE instead ?
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 45c7195b65ba..16d590fe1ffb 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>>   		 * kmalloc-able later in htab_map_update_elem()
>>   		 */
>>   		return -E2BIG;
>> +	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>> +	if (percpu && attr->value_size > PCPU_MIN_UNIT_SIZE)
>> +		return -E2BIG;
>>   
> 
> The percpu allocation logic is the same as the array map:
> round_up(value_size, 8) is used.

ok.

>>   	return 0;
>>   }
> 


-- 
Best Regards
Dylane Chen

