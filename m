Return-Path: <bpf+bounces-22907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4886B71F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F6F285FA0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA84085C;
	Wed, 28 Feb 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOuNtRnP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757220DD5
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144862; cv=none; b=YTzeMYKtLvvt2a0VYZGV3hJjPJ8Hwh0Lz9qVK5E/hwDZEbUzaclAdrLpTm6qQd15hZ4LuoSv38yrx/pldJR95tBsF6hSVcfdes/MoQW4JlsVzqu+kJD7HSX4y3ZRYA9QOGSQX0rWz6fXpHOKzQ/SPxTHIX14KvqDV78b8E52RnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144862; c=relaxed/simple;
	bh=0E+8tNMHquZQzMRoweJxBxHCoZHVxMiuTVBUFed8lsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnZ/Wdkj2IVG9Oo/xaS8si1gmPFoRcQkh/jPaMzlMBxxjAXAcz3aka4B/3tOIt5t4WLLTkwp/9ef1yuJcXu3aAMpKgQgpHEx/3BMVJd2dMKbmX8Fr0EokS2MpHWJjGIgmFaSB3uw/o1oOHISRD7PO0FpqkMqHVmt20SfvwhdqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOuNtRnP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607bfa4c913so440837b3.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709144859; x=1709749659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pettmes3VCu1G7/UcLp7rVA+ZEzwi3UOlqlH6DfZTXE=;
        b=VOuNtRnPaK0fh5QopRP8jwsuy8vpwBtMUWdkcbLWK5o0ap8UIUObCOBblSf7/1ho47
         6OpHfI4BDVZTlHUP0bYjIks6HjxPo13r8AbkxlYrwp7aFhsPb+PgxWkKY51IrAeCE7ne
         08lJDANhJZu4nwfYsd/iGQRUXcxPyYjXylM2rtUxLCCfRhcNqjRTnzAArAEADLhfeQ6g
         iy1t9TX4UvkplbPjl94AXRfonAwcbblu7q2HvMQW4xm+nSiW5zlLkih/ARM27d3THPLD
         3KJzpoJJDqMVhM7sux6oXAhJfxTRVady9S1KqdTuUUnBNHmX8eHD8Y2Htp7YN3Br8t6f
         OQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144859; x=1709749659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pettmes3VCu1G7/UcLp7rVA+ZEzwi3UOlqlH6DfZTXE=;
        b=IYKnBLXapYtqLKXTmuTUfTUDHy1j0dFgfdRpcXDyP2cTdBrC8YhjLi21pxVoRykA64
         bsShISOAmcHb8iTBirOUByhJT/He4xIS2OM/htJf0EBeO8F98Nc8l5J/svaSvkBabnUc
         U3fggBGdNCeSfHb9p5kM3xMFFzvRQERSK9rR3xgi5prGGGafCR4t9X1B2xkzZIbU3cl/
         PMhvRZefsKn/NErte9CiOut58p7LJxF9iw/S5E8EMjYWQMe2uVuFbrYbTItOLV9SHbbd
         dyVHbftKU+bKUAOH8nrdJM0jJ/VJkxJuL5UY/Be5tAosBHJRiMmhHKacrcM+bGt0rywx
         NhlA==
X-Gm-Message-State: AOJu0YxHAguAysJIQgR/A97zlBn1/qKvEthNC/pdqLipt1Lk475mZ8ti
	m2n34ZFbZAJB0yKkAqIxhFRyiLYR08XOJH/tIqoL/Xsw3wwMQ0Gy
X-Google-Smtp-Source: AGHT+IHrvB9RnSDQevfyPaOrnsKe+uMpoqgoMo3Banm/pEC4z+5c3L8ujz203LOZbP646djhKkWrCQ==
X-Received: by 2002:a0d:cb8f:0:b0:609:4736:b05d with SMTP id n137-20020a0dcb8f000000b006094736b05dmr1870371ywd.1.1709144859522;
        Wed, 28 Feb 2024 10:27:39 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id o131-20020a0dcc89000000b006092cc38381sm962110ywd.106.2024.02.28.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 10:27:39 -0800 (PST)
Message-ID: <d875651e-cc1a-4053-b6c7-760dccb1e9cc@gmail.com>
Date: Wed, 28 Feb 2024 10:27:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/6] libbpf: expose resolve_func_ptr() through
 libbpf_internal.h.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-2-thinker.li@gmail.com>
 <CAEf4BzY5dytoYwfZw3UV60fRtw_yh2LakDJHBFt2KWq0C189ow@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzY5dytoYwfZw3UV60fRtw_yh2LakDJHBFt2KWq0C189ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 09:45, Andrii Nakryiko wrote:
> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> bpftool is going to reuse this helper function to support shadow types of
>> struct_ops maps.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c          | 2 +-
>>   tools/lib/bpf/libbpf_internal.h | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 01f407591a92..ef8fd20f33ca 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
>>          return t;
>>   }
>>
>> -static const struct btf_type *
>> +const struct btf_type *
>>   resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
>>   {
>>          const struct btf_type *t;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index ad936ac5e639..17e6d381da6a 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -234,6 +234,8 @@ struct btf_type;
>>   struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>>   const char *btf_kind_str(const struct btf_type *t);
>>   const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
>> +/* This function is exposed to bpftool */
>> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
> 
> it's trivial helper, there is no need for bpftool to reuse it, let's
> just implement a local helper for bpftool. We should have done the
> same with skip_mods_and_typedefs() in gen.c, but oh well, we can fix
> that later.
> 
> Generally speaking, I'd like to minimize amount of internal functions
> exposed from libbpf to bpftool. It's justified if the logic is
> non-trivial, but resolve_func_ptr() is not such case.

Ok! I will add an implementation in gen.c

> 
>>
>>   static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
>>   {
>> --
>> 2.34.1
>>

