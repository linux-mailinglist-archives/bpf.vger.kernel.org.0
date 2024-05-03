Return-Path: <bpf+bounces-28529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B38BB227
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E246B2335D
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D519158210;
	Fri,  3 May 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPwpDF9D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984823CB
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759678; cv=none; b=jS1f8GTyY/3swmyo3UYjfWPjQMMkX6Zjg1BGEwPHio2gbhSfZy4hKKDDg+RUpYrT/FPTXui/on6sH5ZNY6U7r01k7KR/n6JeRC6r97OTgVaxwEHUp4bW42Fg8Pd31lUcDctDYHRu2dPoPKsu9fs9bLo4OyHTivzqSEGFX5eEz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759678; c=relaxed/simple;
	bh=q/E7qgtkWkJTTxFq8hejy+knRfMxgYEbfVAex3gz0co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYrYrg3pR1fmhuOG3m/kFyVUHUA/Uxx1ygRukTh1XcLOxbyvBXTi2JsQSQ7anu5SwV0iou+PfbpnTYM3GfI9mqw5CyI9t8JdZdMSq5KCAc32jsgURs79QkUMARNfvY1uwxSdS9IE2ATH5WUfST00ngPEqHWKbRpPyuK/91XuKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPwpDF9D; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23df05526a5so942791fac.3
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759676; x=1715364476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvBYxPxdqOTdIYitulTZVa6VySCL7OOtOrOmeDBQm2U=;
        b=QPwpDF9D9TC9trqIcclKFCwrQPk2Sn190yy0nhDaoOKgZ2SHl3Dj0R6dIl6b7/mb77
         N1E7RplR12xYG7wkEc1NW5QdgDPrJBLGet0lY11praQONbIZwHgtubaEeIg6ctRVUe8t
         mVMVU1lvTluLFzxnMWMcRunKU95X7YlbKIfXYo3G13UPhqgl4O3AcCCmv3a4S+XA2Qxu
         v2DYQDmXjuo0M6dAA5JWSu9a4KfGqGjNIo96eVhpNG1iH258LP4EBOIrJn2PnG9NxEkw
         4AsQpx/UlJ0qnKziHFrgfLIscTjz6dHdBxRcYHcagpkyEfUHx7W57EZ2EN2pmAIW9707
         5YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759676; x=1715364476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvBYxPxdqOTdIYitulTZVa6VySCL7OOtOrOmeDBQm2U=;
        b=KuWIq6b1uepZIpOIoZS8G2tq3P2tCns2xVgoAuFNVxphYtYDq3PZuWAWMCLOkOlWdl
         6pU1iNND1eNCOGpz3GdwguAsprrMCEP+JJIoaIirTAoUSvA0VUseqWkTwOe8Invb0lek
         QxneivnzeNhwQ9U6OiqliqCj4Ko2kQiPIDNW7D9plKm4mNVORH6DgC6RywJXv+OU7EKc
         Pf7/hYF8gu0IwfjQFaYHABYc5pUOcYp8/ppI5oS6gb7pg1sOaD9+bTpwxmRlRQCqEsoU
         +CAU4IB50XVfSjeVMnFrBz4Nx+5HrXfkVrpFFG09UPkZ+Rf9IL/plCwQYD06Ig67vFPo
         OnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUjbclKaLWibZb9yMnwCipKAFXDKJU5kuh+nGHeQnIDsodroJIkOkO8o+TpbuYVcLCtC4t/aZd3XQhZjdiC7y4/GsPo
X-Gm-Message-State: AOJu0YxLEPzgesxNDrE/hGJzZy++4ICSrPzr9FW9WWWRaOpQZ447FD6K
	+ookJCzQRkC1TDDwLxL7hAmsGWN/bwXwHlDYH9aqwjVB/DIrV9wyrZerlQ==
X-Google-Smtp-Source: AGHT+IE8ftfpQ9IXguPvmSd8rQgO+5XabzJO1ooXZFuKF+7cK1jN6rBfr+3QPqmG/rWxOvcapQPowg==
X-Received: by 2002:a05:6870:f729:b0:233:4685:aea3 with SMTP id ej41-20020a056870f72900b002334685aea3mr4175300oab.41.1714759675677;
        Fri, 03 May 2024 11:07:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:248:d6ee:f0ae:bd46? ([2600:1700:6cf8:1240:248:d6ee:f0ae:bd46])
        by smtp.gmail.com with ESMTPSA id ov14-20020a056870cb8e00b0023cd1ec330csm701986oab.33.2024.05.03.11.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:07:55 -0700 (PDT)
Message-ID: <0d1fa4da-5366-4b69-a749-47562f6b4eef@gmail.com>
Date: Fri, 3 May 2024 11:07:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf: look into the types of the fields of
 a struct type recursively.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240501204729.484085-1-thinker.li@gmail.com>
 <20240501204729.484085-5-thinker.li@gmail.com>
 <ef932548808bd55dae8bccbbab63de60b86985ee.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ef932548808bd55dae8bccbbab63de60b86985ee.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/24 12:34, Eduard Zingerman wrote:
> On Wed, 2024-05-01 at 13:47 -0700, Kui-Feng Lee wrote:
>> The verifier has field information for specific special types, such as
>> kptr, rbtree root, and list head. These types are handled
>> differently. However, we did not previously examine the types of fields of
>> a struct type variable. Field information records were not generated for
>> the kptrs, rbtree roots, and linked_list heads that are not located at the
>> outermost struct type of a variable.
>>
>> For example,
>>
>>    struct A {
>>      struct task_struct __kptr * task;
>>    };
>>
>>    struct B {
>>      struct A mem_a;
>>    }
>>
>>    struct B var_b;
>>
>> It did not examine "struct A" so as not to generate field information for
>> the kptr in "struct A" for "var_b".
>>
>> This patch enables BPF programs to define fields of these special types in
>> a struct type other than the direct type of a variable or in a struct type
>> that is the type of a field in the value type of a map.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
> 
> I think that the main logic of this commit is fine.
> A few nitpicks about code organization below.
> 
>>   kernel/bpf/btf.c | 118 +++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 98 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 4a78cd28fab0..2ceff77b7e71 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3493,41 +3493,83 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
> 
> [...]
> 
>> +static int btf_find_struct_field(const struct btf *btf,
>> +				 const struct btf_type *t, u32 field_mask,
>> +				 struct btf_field_info *info, int info_cnt);
>> +
>> +/* Find special fields in the struct type of a field.
>> + *
>> + * This function is used to find fields of special types that is not a
>> + * global variable or a direct field of a struct type. It also handles the
>> + * repetition if it is the element type of an array.
>> + */
>> +static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
>> +				  u32 off, u32 nelems,
>> +				  u32 field_mask, struct btf_field_info *info,
>> +				  int info_cnt)
>> +{
>> +	int ret, err, i;
>> +
>> +	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt);
> 
> btf_find_nested_struct() and btf_find_struct_field() are mutually recursive,
> as far as I can see this is usually avoided in kernel source.
> Would it be possible to make stack explicit or limit traversal depth here?

Sure!

> The 'info_cnt' field won't work as it could be unchanged in
> btf_find_struct_field() if 'idx == 0'
> 
>> +
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	/* Shift the offsets of the nested struct fields to the offsets
>> +	 * related to the container.
>> +	 */
>> +	for (i = 0; i < ret; i++)
>> +		info[i].off += off;
>> +
>> +	if (nelems > 1) {
>> +		err = btf_repeat_fields(info, 0, ret, nelems - 1, t->size);
>> +		if (err == 0)
>> +			ret *= nelems;
>> +		else
>> +			ret = err;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int btf_find_struct_field(const struct btf *btf,
>>   				 const struct btf_type *t, u32 field_mask,
>>   				 struct btf_field_info *info, int info_cnt)
> 
> [...]
> 
>> @@ -3644,6 +3707,21 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>>   
>>   		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
>>   						field_mask, &seen_mask, &align, &sz);
> 
> Actions taken for members in btf_find_datasec_var() and
> btf_find_struct_field() are almost identical, would it be possible to
> add a refactoring commit this patch-set so that common logic is moved
> to a separate function? It looks like this function would have to be
> parameterized only by member size and offset.

Of course, it could be.

> 
>> +		/* Look into variables of struct types */
>> +		if ((field_type == BPF_KPTR_REF || !field_type) &&
>> +		    __btf_type_is_struct(var_type)) {
>> +			sz = var_type->size;
>> +			if (vsi->size != sz * nelems)
>> +				continue;
>> +			off = vsi->offset;
>> +			ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
>> +						     &info[idx], info_cnt - idx);
>> +			if (ret < 0)
>> +				return ret;
>> +			idx += ret;
>> +			continue;
>> +		}
>> +
>>   		if (field_type == 0)
>>   			continue;
>>   		if (field_type < 0)
> 
> [...]

