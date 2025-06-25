Return-Path: <bpf+bounces-61511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45CAE8166
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781151C23A0F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2B2D879E;
	Wed, 25 Jun 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe7CqfSr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54F2C1581
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850862; cv=none; b=tU4iA8usGeQYZmzu46xj2vWpRKq5gMumPjdVVs46zSBPNpwrteqAjFmjoRxflnsBGIW8sO/Mib/oZUizZFH/y6KX1bi7eXConWsbQQWg9bqLweV/GTv28UB+NrTsnSARw1Y3NfK7LgbGhorEYDOuL/GRsHHMjkN3D/fPmQUWEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850862; c=relaxed/simple;
	bh=UdEASrpd+keNd+2mgse4oZp/OW/fqOgf717Xih2FWKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjKZG6VTf16iM3FkWbhD6bTSSmNfJ44krmOD+rji6nduSHp2Hfoi4mms8tphTxvzoXwZpVUuU2Lo/cCzLEDD6A555wa74FIDUR1o5VT9gLDGKzR2G2EKEoiIRc0OHBcmyne3kSH646OeShMz0th5DQEcp1xzdJ4Fc8Uaw1iywm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe7CqfSr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9721235a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750850859; x=1751455659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lGKG6pE6tu2vvWhKV7zEp7t/Fr6e+vHkJn0Uz90H2E=;
        b=Xe7CqfSr0KaRWb2yovSYN1fTtWi+YgoYXH5q0Zefo6Rf0VjZ/EN1n6IbtPLu2UHcI/
         TF8PZ9j253Tmx7Z92zqwYIfxXED9UGzGHpUal3eL1XbFslY55wt+SGeRirc95mgeA6rm
         9wZIueBGgkjvQzFfHZv4rxIsap3l6Rbmh8ZA0urYYpYLra5gpQZZHjfIMFaGx/uDYwsk
         BToGjO4SAKAfmxThNgDyvwqlDhApDtZR8ezI73ILZ5c2wqjJ4PO2yMkquh02vKlB8J0K
         Ria0j4luD/Xfn3r3kU6Ecc+MnwWAif9xhK8+w98NGu4BK+YmHm64I75jdawp8yvJTsEE
         vTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750850859; x=1751455659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lGKG6pE6tu2vvWhKV7zEp7t/Fr6e+vHkJn0Uz90H2E=;
        b=ig+4kw8mGTKHoVziC0P6q+zdzi8zae5hHZFUQ9bs62WeuccICJSNkU/5jKMdqZJFcj
         wqkuRPuUEehNj1SF8N8y2CJOiYR+vcG/WSwiOjGffnvQkRy7MKVn6LIOS47ZiVUVt7AS
         QMjru9jcRs4IdNQAzlQwRcuK5io3oBSht8rcEjJ4jZTEgUH2/iBRa+xU9wg/lOnTSq7h
         RU81GbMr4oEldgq0daAtZH54ONYOvFfJHvDSGGKwuMx5K+AZV1x6Hc55/EwbfRqXYHef
         2GpDm7mfxKICgt7jVQ94pqHaRJty6qKpm3gIvwstjtINdXN+404M/LWQtNbCFtBF21B+
         qbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0aac3neeQDdeENNWQ90KOyWgWJbaclfpL1Bp1qElwvlkND7j5GEzeK7T3fXpKCv9A2Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHqv3Xiz38FUI9w4K8zjCEBlvJYiHkp8rTSuuvFlLUmhUqOVD
	lDF5wO/gg0gOD1JZuRBJlOn375Vn2ZES2gQKh4+EFlTM/YnKcsSc6GUu
X-Gm-Gg: ASbGnctHkUGXjW5z/ilW/RmYRFVbDIS1e3msReB1jqtWneHO2OF6AWqV4fME4oTqAfF
	+Ks0h8enOmtX/AHpzSf4qT7Tj5+0JmOVYHimSS/Njz5WdlxuVwCMHspwe9TH1bZ7GXRyMTVZ9uN
	Qk97TyPnRuTbbnNJ+h3UH5EvptAHR/YdhiXOQ1Beo9FPUGsLcuXudnKxsDlBFWlASmFFAumkpSU
	AyHgTOyTmTdoFDwqmV6BjU1uWnUVcKMt5wRMezTuJ+ZSdt0Y9m52jjfbMfK8Wx5axGYj1I3PMrH
	/LIYZcWoxktdf97DP8WxwU8ThxbkS5/5v3oJ/go/kVs9LVkuKHfQU22UbkxgoVMNsMrhBQUjFCW
	VjR09I23IwkNvQIp/fhMzGA==
X-Google-Smtp-Source: AGHT+IH8Hr4nTXrN164zdbZL9GUsZ5TVTJq9e5xs2qlrMBjBpgOEat/NP+xkIuxCjVQVpdoKnhHc8Q==
X-Received: by 2002:a05:6402:40c5:b0:602:36ce:d0e7 with SMTP id 4fb4d7f45d1cf-60c4dc28757mr2222100a12.14.1750850858496;
        Wed, 25 Jun 2025 04:27:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a86b:88c6:73bf:c6e4? ([2620:10d:c092:500::5:606])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1ad5f9sm2350367a12.17.2025.06.25.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:27:38 -0700 (PDT)
Message-ID: <36486564-3ce7-403b-91e4-268cae1c4905@gmail.com>
Date: Wed, 25 Jun 2025 12:27:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_dynptr_memset() kfunc
To: ihor.solodrai@linux.dev, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-2-isolodrai@meta.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250624205240.1311453-2-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 21:52, Ihor Solodrai wrote:
> Currently there is no straightforward way to fill dynptr memory with a
> value (most commonly zero). One can do it with bpf_dynptr_write(), but
> a temporary buffer is necessary for that.
>
> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>   kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b71e428ad936..b8a7dbc971b4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2906,6 +2906,53 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
>   	return 0;
>   }
>   
> +/**
> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
> + * @ptr: Destination dynptr - where data will be filled
> + * @ptr_off: Offset into the dynptr to start filling from
> + * @size: Number of bytes to fill
> + * @val: Constant byte to fill the memory with
> + *
> + * Fills the size bytes of the memory area pointed to by ptr
> + * at offset ptr_off with the constant byte val.
> + * Returns 0 on success; negative error, otherwise.
> + */
> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 ptr_off, u32 size, u8 val)
> + {
> +	struct bpf_dynptr_kern *p = (struct bpf_dynptr_kern *)ptr;
> +	char buf[256];
> +	u32 chunk_sz;
> +	void* slice;
> +	u32 offset;
> +	int err;
> +
> +	if (__bpf_dynptr_is_rdonly(p))
> +		return -EINVAL;
> +
> +	err = bpf_dynptr_check_off_len(p, ptr_off, size);
> +	if (err)
> +		return err;
> +
> +	slice = bpf_dynptr_slice_rdwr(ptr, ptr_off, NULL, size);
> +	if (likely(slice)) {
> +		memset(slice, val, size);
> +		return 0;
> +	}

bpf_dynptr_slice_rdwr is doing rdonly and off_len checks anyways, so perhaps we can
avoid calling __bpf_dynptr_is_rdonly and bpf_dynptr_check_off_len before bpf_dynptr_slice_rdwr,
that'll make fast path a little faster.

> +
> +	/* Non-linear data under the dynptr, write from a local buffer */
> +	chunk_sz = min_t(u32, sizeof(buf), size);
> +	memset(buf, val, chunk_sz);
> +
> +	for (offset = ptr_off; offset < ptr_off + size; offset += chunk_sz) {
> +		chunk_sz = min_t(u32, sizeof(buf), size - offset);
> +		err = __bpf_dynptr_write(p, offset, buf, chunk_sz, 0);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>   {
>   	return obj;
> @@ -3364,6 +3411,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>   BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>   #ifdef CONFIG_NET
>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>   #endif


