Return-Path: <bpf+bounces-71061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83498BE0ECE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 296E5354E9E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E0307482;
	Wed, 15 Oct 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHgKKdrO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B02566E2
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567140; cv=none; b=KNFH+gjknA1pphdJPdtSC3iUcDigWqaTCUSVWD4rYtl0OSxNuaK69u+i+DqjjeHk5EGzuZoJ76LwDB9yqCSqVotHhJRiRtyFcXkA3SGLURsTeNuf8YohQJKlIqWS9biKOiCHYxHg+Xwy/fhOjGHrTwfwaVCaZud7wbHtVEYn8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567140; c=relaxed/simple;
	bh=6OwPATQkYxsfOg6tkvlx7uK5XLzlIO5VstrY0pp/Y30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxMYchkZe7WX1C7pP7VMukj8P5ZKvGpRvlJsY+hJfNb8MngeVkjraf1giJFruPhCsacgM/K0TdsHfxObDKVZk+s6r4pDMZICZR/yQXTs/aH0XJMO99V+0W+3oX7QiJLtzizFdVfefFvnDGm9DJ0yJ7QXMnz++3cl72/w8f0srw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHgKKdrO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47109187c32so323465e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760567137; x=1761171937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8pBc5qSU2HpvwkzgYvR35tid/724EbwsKEyotIdS4A=;
        b=IHgKKdrOv7JaHix5aXpozEgaqYUYdtc3r5mkfOl/EDnObY9N/uRE8y1d8wHIah0hyu
         +VZI0hqNqOq5X5YqQDUkm9o3VGi1tvVsCo7ccIFa/CBUPkmMVRjKpUFML7hbDCEFYhmG
         4ckmUCGf3UlQn5960IUNL/tOnrjOcQBONjw+hdZFMOFzERpp+0QBWjUpz4InnGECzA+c
         q+Y9Pcbw2lOS6bfS3W+HXiaKq1ANuOgnoCnURMuvY1RlzmgVUbIRkSvJU+fK40zjLtDG
         TL84621hlLDDsq/FRcy6brH4U8WJstFCHUH7/4ygeAMKSitOUhPcYFw5vgAjJZp6aR7Z
         Uezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567137; x=1761171937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8pBc5qSU2HpvwkzgYvR35tid/724EbwsKEyotIdS4A=;
        b=EceBfI8ZhdRwRaxZ691DrSftzPgDdEt26FlCKx5+xrQgZKWnN5vX2d1VWfqT5oq5rs
         KKc9v6vLEEnRJYrQ/mbcIFi0ajRCHMJVuw63aiKe6Qri+lXnjA4fxiVCLRhB1c4jHmqr
         3WhKPvpeOuZZ5h36HWP5LChVqrtLYe0Etimr5bAwVBzye82AkPdZRjBb8YfAJgcK3Sjn
         K26mXMHF2lzddrLxdxGeseP9eCAUm7r3tW4mK9ml/yawrwWzqE4MSwPJ+YKTg3T5t5dV
         wEPFzN232MyWTg1LXG6irkG23seu3z8ab/7/VJVMvm0znoPdQWatH37aycoDbnE/WTJc
         b3CA==
X-Forwarded-Encrypted: i=1; AJvYcCWGX8SAGTllX2mL5rQ20swVH5UNXXUqP2K8PO4OjeZwQaq6s/NDfINPYKw2+8Rt0ohEkoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQspUSurxpmUzjnc5LPWZYXDJwZ+5457Ux5+TViQTWVhZVMUN
	qRynEeRjBrj/e3a9hB3t+tzouTUzsC95tPKrt5szIWifBEuOPP5fjwzZ
X-Gm-Gg: ASbGncuAz0n69oqw2vzaei60fzmY7PAb3EWHFR0iUhrac7n8ZSeonQIIftLwYmFqDNU
	LnZ0Ga9pMw/OtAa1qBtlv7ymWVCprlOZ75OdFQJA0P4OIW/Ryp7wpXdQ4dUsNmeJQc6miHPn0Aw
	GWBOZGxWCTkjjFo/oAxUZBDIa6wiSzX1tDubvgfFZQhRE/I5vPkwbS8UribAKKnHTJjMTiY1CJ6
	hgWlj6l4zSPa0LhFkYRHoPOovuKJRn6AgoyspItCLZ9Z3YxWB/PHYsTWTEy4p0jWVnc9iuX4ESS
	4rUH8KaFgQ2S0GcBW+C0AcPWXmAoawzcS7YUd3B7xxitnhgSAIB2Z+NeTvriFdp5sJ9sZqnhmQs
	K6keWeeCRtLDpqB3e+npYP/DrqDSfKnpG5ojZ0o/XgZcxwJoRr6QeJRj4ac5qyIN98LjzyhqcVI
	aSNl8X16gf8VZlEzOa1DPbE/ymYbjtxZoQfglBRv039HPQBNejjEmob3NJdAfsYXIU
X-Google-Smtp-Source: AGHT+IE0YVMfzPUJueDA9L7PX++XrtZEded4moa90c/i6Kq749gXbYQ2Cb+qjvHSyBOrTNu89YgXJQ==
X-Received: by 2002:a05:600c:8b24:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-46fb42ee497mr160369865e9.41.1760567136749;
        Wed, 15 Oct 2025 15:25:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710f2ab58bsm1539405e9.10.2025.10.15.15.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 15:25:36 -0700 (PDT)
Message-ID: <0cb5dec3-5019-4ed9-8cf5-ed2ec0d8f74c@gmail.com>
Date: Wed, 15 Oct 2025 23:25:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/11] bpf: add kfuncs and helpers support for file
 dynptrs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-9-mykyta.yatsenko5@gmail.com>
 <a2b0241a646c991c280fbc35925e0a52d01b419a.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <a2b0241a646c991c280fbc35925e0a52d01b419a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 23:16, Eduard Zingerman wrote:
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>
> Overall, lgtm.
>
> [...]
>
>> @@ -4253,13 +4308,45 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
>>   	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
>>   }
>>   
>> -__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
>> +static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
>> +			    struct bpf_dynptr_kern *ptr)
>>   {
>> +	struct bpf_dynptr_file_impl *state;
>> +
>> +	/* flags is currently unsupported */
>> +	if (flags) {
>> +		bpf_dynptr_set_null(ptr);
>> +		return -EINVAL;
>> +	}
>> +
>> +	state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
>> +	if (!state) {
>> +		bpf_dynptr_set_null(ptr);
>> +		return -ENOMEM;
>> +	}
>> +	state->offset = 0;
>> +	state->size = U64_MAX; /* Don't restrict size, as file may change anyways */
> If ->size field can't be relied upon, why tracking it at all?
> Why not just return U64_MAX from __bpf_dynptr_size()?
Good point. This is a little bit ugly part of the implementation 
bpf_dynptr_adjust()
is still implemented for the file dynptr (for the sake of supporting 
generic dynptr API),
  and it sets the size, because it makes sense that 
bpf_dynptr_adjust(start, end) leaves dynptr
with size = end - start.
>
>> +	freader_init_from_file(&state->freader, NULL, 0, file, may_sleep);
>> +	bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
>> +	bpf_dynptr_set_rdonly(ptr);
>>   	return 0;
>>   }
> [...]


