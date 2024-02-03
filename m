Return-Path: <bpf+bounces-21122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92B847E06
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 02:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA941C21AD0
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CA7EA9;
	Sat,  3 Feb 2024 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuh9fxGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63F1842
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922192; cv=none; b=jq8fK93y3E+DY6uvqWTkKsyYMlj7761F/ba2E3r1tqoqoRpZ6OPoeCnj4sShRAm/8oGcT+pXEqmKwfY853g9aREToXuuVJfS+RM9/e4oUIVeiWFubeTN8zTuiY3qv8WhRUWoUVqhfJTeLemX9re1o9h7/qu5/lOBiqqW9c5ExVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922192; c=relaxed/simple;
	bh=whiLDbCYsHOvVAmoQZbXfKegC5xUwkUEKCMnLGtI9hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qly6RChkVNlbZ1kV9qAOj1yfU7H4pbWmFxq77fS5Tnqjlgjy4++1XuEyyVQcSrFJ5BUaPniIa+K2g7zMPiTafSwfs61c/Xe+34wh8HxUKblOhZHuwvpVrdRllpqXbq+Egbc4Me87EqNuVqaqM7WlgDhp7pw64D0KNxYK+HlVVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kuh9fxGo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6df28315fso2315387276.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 17:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706922185; x=1707526985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2tTedfd1tx2n+j2fQbnHnlSOzPNzKpWpaj9bPiqNHM=;
        b=Kuh9fxGogS3/WEtR817hVYcu/GzbUcM3IpKzgrABILSTnvdMMmvtd4ig2peTAmKBs4
         H+erWZXuXOfz0haXCnlK4ksZDI9jl03jQhR260gu5jxgw3wM8coWDVaZHc/W1L6eez6D
         Ty+r30RwLMxbiZJ9nj4mLtlVGJpCrA6ncCKfBXwlC+ROX7kKD6MBRL4+E2eAk2Q3C6P+
         sbA/5ezTGN8spHGmuKyeMAWMj3xHdIRm7EPdPrLZXob3erTWmaNXI6DRBb0DrQOq3tBF
         q7kNKxpnFnxjIwyf3WO99pfr2x0mZ5hy5RI2ZCUCvV4uZNRaDSk2jWS+vmtMQblWTntB
         +41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706922185; x=1707526985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2tTedfd1tx2n+j2fQbnHnlSOzPNzKpWpaj9bPiqNHM=;
        b=HmXrNJzvkhNFqF4GaMUl0ZSK1jYAQ384zpngRBSqLfGyGR57iLTwBkOI6SMD3Y8uY5
         Oh62AlefDAfmj4x1pSc/+j7lY1Tbmdv1AXnMK37JAHmyEufTaGf2MwG0KTh3bYrs0sQ4
         CkPRB4tZ7Fc4+hMEVQmNHMgEgU1uBwOPfOWzyIW3+9SAY4rcQrlTo4wbQVdijafG8dG9
         UuuFD0vb2xChHZo7/Fqpt4dRV2g9IuPrqBSQi7rVohmOmOpzyzDRn7OgsUjm8oSDDNRx
         p786By6IHbmRI0IKjPabSCkYIwzoUSTI9HNMRroqcrH34H2qFq1RsSzJcg422hozREpv
         Digg==
X-Gm-Message-State: AOJu0YwwxKK+uNWwfBYdfxGONyHnUMKDzWgNFusF5XDV726uz6sMmXp6
	x2PYHMAc35GYEBmyLzID/UePn1Mzr23vvHhuER2qaV27ovf3VHuv
X-Google-Smtp-Source: AGHT+IFMU8cdtFmtoTwUSfljinCYBFJL6TfOAIsxP2oc1Gaow+e6RYXA5J85xIV/Z0mx+GsSO1iCig==
X-Received: by 2002:a25:8186:0:b0:dbe:3255:8ea3 with SMTP id p6-20020a258186000000b00dbe32558ea3mr3703656ybk.59.1706922184810;
        Fri, 02 Feb 2024 17:03:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXjY6itT9BJvTRFIssVzIAak+XVSlM4TqaVBdCrE0LdW8Cng9fYAVPVb/qmqkW3iKzPhmNf/ss9QNMc176rwsvXgziUm11W/lqJO/oSY/fz8Hfu0kM+1WUDclZuEAtgqK5Z0LtoS2XSnKa7lpkBcHJ3difuxWujb5AytBujrUl0Hjnd9/E+Aqj3DL5iN6WSXqfF5bTK26x/A6yMSOft5lwu50A8UKe8UP2V+L6kveO1LWNq8TSd2xGSUxBQYVLfl+6rmTdrlmqfHhhBI5tdYA==
Received: from ?IPV6:2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f? ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id c5-20020a25a2c5000000b00dc26a4ee68asm686722ybn.47.2024.02.02.17.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 17:03:03 -0800 (PST)
Message-ID: <f2dc101d-74eb-4cef-82ab-7be5acf88772@gmail.com>
Date: Fri, 2 Feb 2024 17:03:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v4 2/6] bpf: Extend PTR_TO_BTF_ID to handle
 pointers to scalar and array types.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-3-thinker.li@gmail.com>
 <190cf3fc-5c5e-4044-9cdc-4804ee49a03f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <190cf3fc-5c5e-4044-9cdc-4804ee49a03f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/2/24 16:52, Martin KaFai Lau wrote:
> On 2/2/24 2:05 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The verifier calls btf_struct_access() to check the access for
>> PTR_TO_BTF_ID. btf_struct_access() supported only pointer to struct types
>> (including union). We add the support of scalar types and array types.
>>
>> btf_reloc_array_access() is responsible for relocating the access from 
>> the
>> whole array to an element in the array. That means to adjust the offset
>> relatively to the start of an element and change the type to the type of
>> the element. With this relocation, we can check the access against the
>> element type instead of the array type itself.
>>
>> After relocation, the struct types, including union types, will continue
>> the loop of btf_struct_walk(). Other types are treated as scalar types,
>> including pointers, and return from btf_struct_access().
> 
> Unless there is an immediate use case to support PTR_MAYBE_NULL on a 
> non-struct pointer, I would suggest to separate the other pointer type 
> support from the current PTR_MAYBE_NULL feature patchset. afaik, they 
> are orthogonal.


Totally agree!


> 
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/btf.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0847035bba99..d3f94d04c69d 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6590,6 +6590,61 @@ static int btf_struct_walk(struct 
>> bpf_verifier_log *log, const struct btf *btf,
>>       return -EINVAL;
>>   }
>> +/* Relocate the access relatively to the beginning of an element in an
>> + * array.
>> + *
>> + * The offset is adjusted relatively to the beginning of the element 
>> and the
>> + * type is adjusted to the type of the element.
>> + *
>> + * Return NULL for scalar, enum, and pointer type.
>> + * Return a btf_type pointer for struct and union.
>> + */
>> +static const struct btf_type *
>> +btf_reloc_array_access(struct bpf_verifier_log *log, const struct btf 
>> *btf,
>> +               const struct btf_type *t, int *off, int size)
>> +{
>> +    const struct btf_type *rt, *elem_type;
>> +    u32 rt_size, elem_id, total_nelems, rt_id, elem_size;
>> +    u32 elem_idx;
>> +
>> +    rt = __btf_resolve_size(btf, t, &rt_size, &elem_type, &elem_id,
>> +                &total_nelems, &rt_id);
>> +    if (IS_ERR(rt))
>> +        return rt;
>> +    if (btf_type_is_array(rt)) {
>> +        if (*off >= rt_size) {
>> +            bpf_log(log, "access out of range of type %s with offset 
>> %d and size %u\n",
>> +                __btf_name_by_offset(btf, t->name_off), *off, rt_size);
>> +            return ERR_PTR(-EACCES);
>> +        }
>> +
>> +        /* Multi-dimensional arrays are flattened by
>> +         * __btf_resolve_size(). Check the comment in
>> +         * btf_struct_walk().
>> +         */
>> +        elem_size = rt_size / total_nelems;
>> +        elem_idx = *off / elem_size;
>> +        /* Relocate the offset relatively to the start of the
>> +         * element at elem_idx.
>> +         */
>> +        *off -= elem_idx * elem_size;
>> +        rt = elem_type;
>> +        rt_size = elem_size;
>> +    }
>> +
>> +    if (btf_type_is_struct(rt))
>> +        return rt;
>> +
>> +    if (*off + size > rt_size) {
>> +        bpf_log(log, "access beyond the range of type %s with offset 
>> %d and size %d\n",
>> +            __btf_name_by_offset(btf, rt->name_off), *off, size);
>> +        return ERR_PTR(-EACCES);
>> +    }
>> +
>> +    /* The access is accepted as a scalar. */
>> +    return NULL;
>> +}
>> +
>>   int btf_struct_access(struct bpf_verifier_log *log,
>>                 const struct bpf_reg_state *reg,
>>                 int off, int size, enum bpf_access_type atype 
>> __maybe_unused,
>> @@ -6625,6 +6680,12 @@ int btf_struct_access(struct bpf_verifier_log 
>> *log,
>>       }
>>       t = btf_type_by_id(btf, id);
>> +    t = btf_reloc_array_access(log, btf, t, &off, size);
>> +    if (IS_ERR(t))
>> +        return PTR_ERR(t);
>> +    if (!t)
>> +        return SCALAR_VALUE;
>> +
>>       do {
>>           err = btf_struct_walk(log, btf, t, off, size, &id, 
>> &tmp_flag, field_name);
> 

