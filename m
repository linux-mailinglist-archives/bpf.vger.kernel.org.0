Return-Path: <bpf+bounces-52506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B7A440E9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C583A6EE4
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC12690F8;
	Tue, 25 Feb 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6iKo4up"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986BE268C47
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490400; cv=none; b=r6t+UJHIJURVf1tQCn5QXWfw0DDMjMuDClT4cSaKi72i+uAVdUenH2EWPhgjjPKwX4mvKqsfDmm4tPkeyg83scPCVkAx9h+KrpN7mCI/rEKxa/kGXDNAEPu44JSMUceyjMwhDBMTm0VG0a0pPG/VzT7Q/PuHSPWHvvOKblruq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490400; c=relaxed/simple;
	bh=mT2/DOK/Eb0u7K2wNck5uiTgGUFxz5Szt/wJ7jslbz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0SnxOXm8IEQm8+Xj9gA0I6qMd4sQH3bLG8temi4R9fx+AOTTtIvM2J66Rj25/RPDj0Xc07XkeNrJ/NZ3m5q6WvfMQeAYvAdLpPYMi/l8r7sJnvNj9vLJu6PI1dKK8fJCJTQddEZBPS/mvBYIngTh/xff1gmOUfnc0WEBoTuztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6iKo4up; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so8086103a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490396; x=1741095196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tR7pt7rNkrUvAt8i7kqQD897c8/ePGTjtfhRAcnPHf4=;
        b=W6iKo4upLw80RjzAFPb544TfrGjoAosKq/vdum7o0cL39MxB302Nu05R0pW+wxaNm6
         MhhOkeoa5aNATfmSIii+oofxXYZ8gZye/X9H0Iey5GvrVO3fktz9584VyvsAzEN3/UZs
         qQ0eBczBp9KpF9wYQUgHvBf33PDAdB+mIB07gFhUZ7Hisya7eWssXT42XwT80R5PFaDy
         OHH8Dv3kwoc39lbx7ktL7CZEbhhEseklqKOVcvCXjr027iyvGHoHnSIXoiWLkGgyV8Hj
         YwUiidl7yExqmrlEfEyT5JSCLTZsfJf2JUaCLr/kqTCd6evBdX63PdyN1myd76Q8wKxj
         wFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490396; x=1741095196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR7pt7rNkrUvAt8i7kqQD897c8/ePGTjtfhRAcnPHf4=;
        b=wcbiUI/YF+wSbYNW+UPoZlEvqk1y3nQPgkyL9PUSeQJYRmBbFcfdLz9bi2XUPOG4Zd
         nwrxhxsBEZn9wP08Mydz/FTibVWQ/HkkFQMy9jbqFXGMCea1XHg/StLa1As9xoQ4QNrr
         g0HPRdFWdxh49gdoTaw4phoHS+DqoIky6x+Zo8I5fNWE87tWXDpgDBS22Y1/ddjbGAWV
         +/6r9EQSQc2HsIGPXrUnRLpPC6bW6nj0RcK4Gl6mvJbyRP6+V4ZLxSSypBMVnupyUHZE
         p3RrKi76NQMC84/uyWiXJ+gqNXP1WNwRfNtt/mn2KOB2SEfHA6qSdh01WSMtWZlgFqgc
         R5Ew==
X-Gm-Message-State: AOJu0YxNbNk2WHCi8JTZzKHXGVvAIvhDZ4IlsnuwLnGOt4PDCuaA42gI
	+QVroKmtZwbBKao8Wsw0Ug4K6LEVTAumNLRx8zFwGDz38y2jyUJi
X-Gm-Gg: ASbGncvWsNB6W7KSBv9CPNwcVK/LGR/skhvGluwAx4LdyFKDP5myOmvl1aSMt1gsOg5
	T7hNtE38C2i9onK1EafYaf6AE9SFYEyIqcsrYGRYZHxD8jpIMXFsYS2P26UbDS3VAxRQQ6ThiEI
	7IxqM63mHzeBlxWUuKrciUm8N9m3rrvVhrs9e/lib9V4IGyABl6uCChADu6PxA0coxeBwC/DGjS
	IX2ok4AZIccJrFCKxaZNvcgFQzX65/GeQWV9pFKgvHuvdRgaKr/zX53ETKq6kio37U2uwrHeV5j
	uB5uPqkNtME7QzZprOsIEwfAb6SE22X9jjN8QfAbL+oC8algE9ln2+hNwfRFgQw=
X-Google-Smtp-Source: AGHT+IFzr0uQVKmhcDg29xjtYqKm2ux0NHRIqiEfQSe4xMkaXsQF7dExePYTh0WvqQDjxZnhOOZUqA==
X-Received: by 2002:a17:907:d9f:b0:ab7:66d3:bc88 with SMTP id a640c23a62f3a-abc09e459famr1948918466b.52.1740490395437;
        Tue, 25 Feb 2025 05:33:15 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:9466:6ad0:4f0c:ab30? ([2620:10d:c092:500::7:2cec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2055011sm139955066b.156.2025.02.25.05.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:33:15 -0800 (PST)
Message-ID: <137a8ca2-c140-4b28-893d-0a4f528a9a83@gmail.com>
Date: Tue, 25 Feb 2025 13:33:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf/helpers: introduce bpf_dynptr_copy
 kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
 <20250221221400.672980-3-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbNs0AXncqci66XZpUsyMTTEYoa7-bfpUT8zwaMmKo5iA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbNs0AXncqci66XZpUsyMTTEYoa7-bfpUT8zwaMmKo5iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/02/2025 23:23, Andrii Nakryiko wrote:
> On Fri, Feb 21, 2025 at 2:14 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr to
>> another. This functionality is useful in scenarios such as capturing XDP
>> data to a ring buffer.
>> The implementation consists of 4 branches:
>>    * A fast branch for contiguous buffer capacity in both source and
>> destination dynptrs
>>    * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
>> data to/from non-contiguous buffer
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
> LGTM, a bit of unnecessary code I pointed out, but I like how minimal
> and clean all this looks, and completely reused pre-existing APIs.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6600aa4492ec..264afa0effb0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2770,6 +2770,60 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
>>          return 0;
>>   }
>>
>> +/**
>> + * bpf_dynptr_copy() - Copy data from one dynptr to another.
>> + * @dst_ptr: Destination dynptr - where data should be copied to
>> + * @dst_off: Offset into the destination dynptr
>> + * @src_ptr: Source dynptr - where data should be copied from
>> + * @src_off: Offset into the source dynptr
>> + * @size: Length of the data to copy from source to destination
>> + *
>> + * Copies data from source dynptr to destination dynptr
>> + */
>> +__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
>> +                               struct bpf_dynptr *src_ptr, u32 src_off, u32 size)
>> +{
>> +       struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
>> +       struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
>> +       void *src_slice, *dst_slice;
>> +       char buf[256];
>> +       u32 off;
>> +
>> +       src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
>> +       dst_slice = bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size);
>> +
>> +       if (src_slice && dst_slice) {
>> +               memmove(dst_slice, src_slice, size);
>> +               return 0;
>> +       }
>> +
>> +       if (src_slice)
>> +               return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
>> +
>> +       if (dst_slice)
>> +               return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);
>> +
>> +       if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
>> +           bpf_dynptr_check_off_len(src, src_off, size))
>
> __bpf_dynptr_read() and __bpf_dynptr_write() do these checks, so
> either it's unnecessary and we should keep all the sanity checking to
> dynptr_{read,write}, OR we ensure __bpf_dynptr_read/write don't do
> sanity checking every single time and we do full checking here, but
> then we'll need to also check !dst->data ||
> __bpf_dynptr_is_rdonly(dst)
>
> I think for now, I'd keep all the sanity checking to read/write and
> not over-optimize. So let's drop these checks?
I added this check to make the process of copying data chunk by chunk 
more transactional/atomic,
trying to make the outcome of partial data copying less likely.
Other checks I assume would equally fail/pass for the 1st and last 
chunk. Of course, we don't give
any atomicity guarantee here, but I thought size mismatch could be a 
common case to handle.
> pw-bot: cr
>
>> +               return -E2BIG;
>> +
>> +       off = 0;
>> +       while (off < size) {
>> +               u32 chunk_sz = min_t(u32, sizeof(buf), size - off);
>> +               int err = 0;
> nit: unnecessary = 0 initialization, you are overwriting it immediately below
>
>
>> +
>> +               err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
>> +               if (err)
>> +                       return err;
>> +               err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
>> +               if (err)
>> +                       return err;
>> +
>> +               off += chunk_sz;
>> +       }
>> +       return 0;
>> +}
>> +
>>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>>   {
>>          return obj;
>> @@ -3218,6 +3272,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>> +BTF_ID_FLAGS(func, bpf_dynptr_copy)
>>   #ifdef CONFIG_NET
>>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>>   #endif
>> --
>> 2.48.1
>>


