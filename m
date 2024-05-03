Return-Path: <bpf+bounces-28527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015A8BB204
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37025B23032
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1544524BE;
	Fri,  3 May 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+UY2s6y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083415533D
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759363; cv=none; b=jNCDS2zBfA+vGXOvVvVR3merknb+UFtbnrySfNhUScJJvmRZSg/U4LcAhsVvfjfMy1y5xg+IPTQyjlKJEuolYvpiBKOpxzbgXbVjJ5ofiOei85AoHe7xVIP00jy3KoqDoIQK46BehNstLtCGNXboN+H313pgy2B372Uc+QunbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759363; c=relaxed/simple;
	bh=LZ1Jo0eUy5YsXgZTMw6OJGp79REUNkeonvSdvgHcIKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX6LjPY4nGPafzGv8P7oxxD9ZITFs0CLMlrENvCnmfyYEVko5kWfeKwpr5D1AZ1dWUAPSMVNRHTrptIKR8G7/qDJ+IPMhPAyCoXNsiG+7kNgGMyxIGF6XQvBcL3v+831Fd7GXbZmcT7dt5E/9D09opUat5pA0YaJ8ZnmCUWNQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+UY2s6y; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c751bf249cso5293690b6e.2
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759361; x=1715364161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+1MyupIH9+mVYVx0tDNdpatNSjES4f9vH0sXDNzI+I=;
        b=H+UY2s6yjE4wxjdFctP3ORF7iZKO+qte7KOtWmy+drGJBNueqbQ+VT4WJg+KMFbJGl
         IHZjmuQZE8JjK8dRtPVyNyXuxsm8pZalC43vrTTH8sejMmqxfs4qyMBHfjrB1uttZO8b
         RhD18FNeuj+bafYkJAxKVwGhMCfQ+8P8M0+PyI3LFq3twiRigRAkGEAl+PI9Q2OKt13+
         Q0lWcS5IvhOxiquWw0nLsm7tt07QZt1txIL5FycXu92AIp2hXFiDgynEqQT6O/3TkXU+
         G568DTHV+AaSCWJlW8kJM78av6A5XRIz+Pp+FK8AjWs18XHh65mKalHu1pEy1KLd4bIN
         3YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759361; x=1715364161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+1MyupIH9+mVYVx0tDNdpatNSjES4f9vH0sXDNzI+I=;
        b=qsTK8Tbqb/Ce6H604dgf3l8IxXQUnYAVSJH2vxuKYN6A9Xb2+4YjBxRJRfztzTPKuT
         fFla8Qqgc2I7Z6xoy8Rcxys2azAuX52C3ZdzrFObyglfKFL3YrmiG7bFlkJsvnoUYCDn
         kw9bxDnfwK2fy5fTeLt1PvLVHqSJMbp4yzzIzcKxiwfmr80GLsN0ODMpfrTTNQa831ru
         8mrJUhstCONABCTwvgzySt4XBW82Wo0pBCbMCD6ruAtlbAqOa+k7wcLwQIaNGwnxfGC0
         Dp4zLBcbQzef1QqQmauQQwHYUI//zmhDIsAYRxIB5Ye1kglkAsHgoelw8ZjAGNJ2EStp
         9O7w==
X-Forwarded-Encrypted: i=1; AJvYcCXWXjKa9g2r4gjtYlro6NXcwhbXynDj/TKpwHjl7JTZ5GrcIo80DpL/yOloFQ8lS+ZXOSmSPHbQfFuCLJRcBjkvTgcd
X-Gm-Message-State: AOJu0Yyk4xR26h8WAGNTgipgOU9iPkr9qWoNeH3MCqdeEQgpbu9Wetco
	ic0jddUxIxCRsmGe+MfQ9GwQRjlm/HBtUGp6dXSv+MxvInn+woKP
X-Google-Smtp-Source: AGHT+IFyDDncBosGWpyyTzNYjPs1l2qkjqHI6iYfN2n0GQbZHN7M9FmhSVJ4gGyLzCs3PQkrMQ96NA==
X-Received: by 2002:a05:6808:11c8:b0:3c5:e23c:cf3c with SMTP id p8-20020a05680811c800b003c5e23ccf3cmr4690993oiv.42.1714759360807;
        Fri, 03 May 2024 11:02:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:248:d6ee:f0ae:bd46? ([2600:1700:6cf8:1240:248:d6ee:f0ae:bd46])
        by smtp.gmail.com with ESMTPSA id a4-20020aca1a04000000b003c874e9f943sm583889oia.38.2024.05.03.11.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:02:40 -0700 (PDT)
Message-ID: <0fba228d-ee81-4aee-901f-c60dfd53c102@gmail.com>
Date: Fri, 3 May 2024 11:02:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/7] bpf: create repeated fields for arrays.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240501204729.484085-1-thinker.li@gmail.com>
 <20240501204729.484085-4-thinker.li@gmail.com>
 <017ecee002197526aa5d91d856c25510d36b57ce.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <017ecee002197526aa5d91d856c25510d36b57ce.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/24 10:20, Eduard Zingerman wrote:
> On Wed, 2024-05-01 at 13:47 -0700, Kui-Feng Lee wrote:
> 
> I think this looks good for repeating fields of nested arrays
> (w/o visiting nested structures), two nits below.
> 
>> @@ -3575,6 +3628,19 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>>   	for_each_vsi(i, t, vsi) {
>>   		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
>>   		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
>> +		const struct btf_array *array;
>> +		u32 j, nelems = 1;
>> +
>> +		/* Walk into array types to find the element type and the
>> +		 * number of elements in the (flattened) array.
>> +		 */
>> +		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); j++) {
>> +			array = btf_array(var_type);
>> +			nelems *= array->nelems;
>> +			var_type = btf_type_by_id(btf, array->type);
>> +		}
>> +		if (nelems == 0)
>> +			continue;
> 
> Nit: Should this return an error if j == MAX_RESOLVE_DEPTH after the loop?

agree


> 
>>   
>>   		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
>>   						field_mask, &seen_mask, &align, &sz);
>> @@ -3584,7 +3650,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>>   			return field_type;
>>   
>>   		off = vsi->offset;
>> -		if (vsi->size != sz)
>> +		if (vsi->size != sz * nelems)
>>   			continue;
>>   		if (off % align)
>>   			continue;
>> @@ -3624,9 +3690,14 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>>   
>>   		if (ret == BTF_FIELD_IGNORE)
>>   			continue;
>> -		if (idx >= info_cnt)
>> +		if (idx + nelems > info_cnt)
>>   			return -E2BIG;
> 
> Nit: This is bounded by BTF_FIELDS_MAX which has value of 11,
>       would that be enough?

So far, no one has complained it yet!
But, some one will reach the limit in future.
If people want a flexible length, I will solve it in a follow-up.
WDYT?

> 
>> -		++idx;
>> +		if (nelems > 1) {
>> +			ret = btf_repeat_field(info, idx, nelems - 1, sz);
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>> +		idx += nelems;
>>   	}
>>   	return idx;
>>   }
> 
> 

