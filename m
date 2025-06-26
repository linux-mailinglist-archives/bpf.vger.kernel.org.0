Return-Path: <bpf+bounces-61670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD072AE9EDF
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955A93B09A0
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDA2E54B5;
	Thu, 26 Jun 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZhakkav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1932E1C65
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944897; cv=none; b=Vdjz6ZRt1TOuzXryy7nyKCUIUwZeyzRKH3cL6K14EgdLB+zQSqHmwH1z3kKxd1KnucF4ZeFA33oJB/PrnRWeDql2H60cR0ilKjjPhWvTEP9r/OIPzuXMmw7wdan4ZPKi/7wKYdj9oCcgbeWPhiD1chA6/Ig113wwxzeuI6v8E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944897; c=relaxed/simple;
	bh=FoVrrKfrjnXEMZJLQaxqg2owfUKkorMcbv0QhDb7PMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAgSAwpR8gEYEe3oJmvn0v6ct2x0Xhs16bz5GbyDcWnc5KZ+kOk97CPk7N+LtmqCZauS80Vr6mvo92Wx/DLYxa+3bYZ4BFjuUEHzQ01AGAvSDPuKvGpV/X31VUmEU2GuIcEIQH9mlVVFQLWRWsNxHwP1xtIPGt9OMlPUYo4rego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZhakkav; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dad3a179so98816966b.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750944894; x=1751549694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1TcxuaBy8KISa7zEFPYPqMD4NHxPfsLJfqEsRVCqNU=;
        b=cZhakkavaknWG3HmQMOFjgHFy7QTK8b8MeeySW+Q+gScC1tTzrqcyv0jv+7G9gaHKF
         UUi6J0S/ZzBtcHyGhxTFrb1BUMjfRsRDzxk/BjmVVo8o7jnLZKhCXJZtl8T1OzHlZQMN
         2k9CJ8Zt4a0CRH0g2Twe9v21BtrOrwza1Dh+BX0FOixS6FCOV9X+9pl7+dlICqetjuM2
         Fxr4LBKDsPcbal2itbIJ3eVxNaeZcbVM+ETXBL434DgTBZY77AHAn1Bo7RPNefxrwi7K
         fbMa+7xpjSdHzgVUkzPb4Wwj8QL5c27OmZjyUAXSsmyeD2NW9JXO/11QjeWWfCOFEcTH
         LysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944894; x=1751549694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1TcxuaBy8KISa7zEFPYPqMD4NHxPfsLJfqEsRVCqNU=;
        b=Xnf+97Y4rR3suag9dRw8/J2gkVA0Us/JFs+XbSI9W5HgRjDcsA67rso7TRngTnDSJ7
         IXN6/nRcqbH3p6VTQIWTtMHUWkV7Ix/+KIWf1FUpy0eyd3mn8ni9DhXj7vbKHXJgpEFc
         1ln5p6+scKjKZVIYeUGkMBoJNbhMtrRSKUvNE4ClW+/aZ2lGCTyXaA/YBwED73WGfwN7
         Mn0YakRfyN6zJ5akI/mcctLT4K3DF79D1/+2ThXS1LYZdhDiIiy1PhpQp4JMCESuNa6W
         /NZLl4iiPFvmKyrTaa8myqDSWpDP5ZlDYe0XH5FKlBtS970dkaRGBz/xPCk1sD0yJWxc
         CJXA==
X-Forwarded-Encrypted: i=1; AJvYcCWo9HdkzqHhyDgNcAZ/AotwP8gPChEzwqHczJmDGHZMQvt1d38PfUURuvLX2K0XN0VmC5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FomYix95XO0XoXCNAcIQ4jJPXQ3EpNnwqrbBuLfI76Wq0o/4
	HaY3P6KkBVu3zK38hBM+zSPMrGuBeMqpyUC85J9WubvEsKjyo8owuhpK
X-Gm-Gg: ASbGnctc01JNoGcmGJxT4UjefArXS5Bk6VWo7ezsp0CSweW3IZR/GoVUoiHsBGvXVOh
	DbH4T0nlqMfs6nfYz03sBe/9SaYnP8/CaaMxECUSaU+k1LBqQ5T/ZXEJnJjg5t0Mw1/CNY6WXMX
	j9XVPYa0zQnwqSTbnmcjwlIcYRrShqBZIYMo+HCGd8vBj6RhaN3p6WAirNTil/UplKY0P+IRHxj
	U/a3afMI/ypFQ6RjzFbDtZyFEA6K3vZ/YM1zpVE0XtISzSeSmANygC8gI4Ml2rW4dQDYNFZdFHS
	Wh0aEgUbkQrMzB4eIr+iqXF87qxRFHczbk/E9CypZdLwBCUx1cDb1w7H+5/pIl6yFneXqEd82yo
	NN5yv7Jmjn8gjnz51ocU=
X-Google-Smtp-Source: AGHT+IG7cQGOYTev56zcTpAk+GJ+18OCPmE5hhSIgPAMExJXbuz/goTo6YmywZJJmL8cOpksREmxHw==
X-Received: by 2002:a17:906:6a26:b0:ae0:ba0e:ae50 with SMTP id a640c23a62f3a-ae0be85e456mr696096266b.13.1750944893809;
        Thu, 26 Jun 2025 06:34:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5f:6905:fb7e:236? ([2620:10d:c092:500::4:2360])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae2140d2734sm1525866b.61.2025.06.26.06.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:34:53 -0700 (PDT)
Message-ID: <7ebb7fa8-f1d2-4db8-9d59-4ae586fdf060@gmail.com>
Date: Thu, 26 Jun 2025 14:34:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test cases for
 bpf_dynptr_memset()
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-3-isolodrai@meta.com>
 <5f00c508-5150-4e69-b006-d15b0e6b2d23@gmail.com>
 <a08af28b-e81f-47a8-96b9-94a67d6bd3a7@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <a08af28b-e81f-47a8-96b9-94a67d6bd3a7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/25 02:25, Ihor Solodrai wrote:
> On 6/25/25 4:45 AM, Mykyta Yatsenko wrote:
>> On 6/24/25 21:52, Ihor Solodrai wrote:
>>> Add tests to verify the behavior of bpf_dynptr_memset():
>>>    * normal memset 0
>>>    * normal memset non-0
>>>    * memset with an offset
>>>    * memset in dynptr that was adjusted
>>>    * error: size overflow
>>>    * error: offset+size overflow
>>>    * error: readonly dynptr
>>>    * memset into non-linear xdp dynptr
>>>
>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>> ---
>>>   .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
>>>   .../selftests/bpf/progs/dynptr_success.c      | 164 
>>> ++++++++++++++++++
>>>   2 files changed, 172 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c 
>>> b/tools/ testing/selftests/bpf/prog_tests/dynptr.c
>>> index 62e7ec775f24..f2b65398afce 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>>> @@ -21,6 +21,14 @@ static struct {
>>> [...]
>>> +
>>> +SEC("xdp")
>>> +int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
>>> +{
>>> +    const int max_chunks = 200;
>>> +    struct bpf_dynptr ptr_xdp;
>>> +    u32 data_sz, offset = 0;
>
> A question not directly to Mykyta.
>
> So noalu32 version of this test was failing to verify with this:
>
>     118: (85) call bpf_dynptr_read#201
>     R2 min value is negative, either use unsigned or 'var &= const'
>
> Where R2 refers to `data_sz - offset`
>
> Full log here: 
> https://github.com/kernel-patches/bpf/actions/runs/15861036149/job/44718289284
>
> I tried various conditions unsuccessfully.  But changing u32 to u64
> made it work. If handle_tail part is removed, as Mykyta suggested,
> this doesn't matter, so I will probably leave u32 in v3.
>
> However I am curious if u32->u64 change is an appropriate workaround
> in general for noalu32 problems?  AFAIU verifier might get confused by
> all the added shifts, and "noalu32" is a backward compatibility thing.
>
>
>>> +    char expected_buf[32];
>> nit: expected_buf[32] = {DYNPTR_MEMSET_VAL};
My bad, it's actually should be `char expected_buf[32] = {[0 ... 31] = 
DYNPTR_MEMSET_VAL}`;
Otherwise it initializes just the first element of the expected_buf and 
places that array into the .rodata.cst32 section.
>
> I tried that at the beginning. As it turns out, this doesn't work in
> BPF the way you'd expect:
>
> Here is a piece of llvm-objdump with explicit memset:
>
> 0000000000000968 <test_dynptr_memset_xdp_chunks>:
>      301:    18 02 00 00 2a 2a 2a 2a 00 00 00 00 2a 2a 2a 2a r2 = 
> 0x2a2a2a2a2a2a2a2a ll
>      303:    7b 2a c8 ff 00 00 00 00    *(u64 *)(r10 - 0x38) = r2
>      304:    7b 2a d0 ff 00 00 00 00    *(u64 *)(r10 - 0x30) = r2
>      305:    7b 2a d8 ff 00 00 00 00    *(u64 *)(r10 - 0x28) = r2
>      306:    7b 2a e0 ff 00 00 00 00    *(u64 *)(r10 - 0x20) = r2
>      307:    bf a7 00 00 00 00 00 00    r7 = r10
>      308:    07 07 00 00 e8 ff ff ff    r7 += -0x18
>      309:    b7 02 00 00 00 00 00 00    r2 = 0x0
>      310:    bf 73 00 00 00 00 00 00    r3 = r7
>      311:    85 10 00 00 ff ff ff ff    call -0x1
>      ...
>
> You can clearly see a piece of stack filling up with 0x2a
>
> After applying this diff:
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c 
> b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index 5120acb8b15a..5b351f6fe07c 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -809,12 +809,10 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md 
> *xdp)
>         const int max_chunks = 200;
>         struct bpf_dynptr ptr_xdp;
>         u32 data_sz, chunk_sz, offset = 0;
> -       char expected_buf[32];
> +       char expected_buf[32] = { DYNPTR_MEMSET_VAL };
>         char buf[32];
>         int i;
>
> -       __builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, 
> sizeof(expected_buf));
> -
>         /* ptr_xdp is backed by non-contiguous memory */
>         bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
>         data_sz = bpf_dynptr_size(&ptr_xdp);
>
> We get the following:
>
> 0000000000000968 <test_dynptr_memset_xdp_chunks>:
>      301:    bf a7 00 00 00 00 00 00    r7 = r10
>      302:    07 07 00 00 e8 ff ff ff    r7 += -0x18
>      303:    b7 02 00 00 00 00 00 00    r2 = 0x0
>      304:    bf 73 00 00 00 00 00 00    r3 = r7
>      305:    85 10 00 00 ff ff ff ff    call -0x1
>      ...
>
> The stack allocated array is not initialized.
> Could be an LLVM bug/incompleteness? I used LLVM 19 while developing.
>
>
>>> +    char buf[32];
>>> +    int i;
>>> +
>>> +    __builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, 
>>> sizeof(expected_buf));
>>> +
>>> +    /* ptr_xdp is backed by non-contiguous memory */
>>> +    bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
>>> +    data_sz = bpf_dynptr_size(&ptr_xdp);
>>> +
>>> +    err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
>>> +    if (err)
>>> +        goto out;
>>> +
>> Maybe we can calculate max_chunks instead of hardcoding, something like:
>> max_chunks = data_sz / sizeof(expected_buf) + (data_sz % 
>> sizeof(expected_buf) ? 1 : 0);
>
> I don't see a point of doing it for this test. max_chunks is just a
> big enough arbitrary constant that works. We do a similar thing in
> other tests.
>
>>> +    bpf_for(i, 0, max_chunks) {
>>> +        offset = i * sizeof(buf);
>>> +        err = bpf_dynptr_read(&buf, sizeof(buf), &ptr_xdp, offset, 0);
>>
>> handle_tail seems unnecessary, maybe handle tail in the main loop:
>> __u32 sz = min_t(data_sz - offset : sizeof(buf));
>> bpf_dynptr_read(&buf, sz, &ptr_xdp, offset, 0);
>>
>
> Yeah, you're right.
>
> It ended up like this because I've been fighting the verifier while
> writing the test, and this version worked eventually. The critical
> piece to uncofuse it was changing:
>     offset += sizeof(buf)
> to
>     offset = i * sizeof(buf)
>
> I will have to add min_t macro locally though.
>
>
>>> +        switch (err) {
>>> +        case 0:
>>> +            break;
>>> +        case -E2BIG:
>>> +            goto handle_tail;
>>> +        default:
>>> +            goto out;
>>> +        }
>>> +        err = bpf_memcmp(buf, expected_buf, sizeof(buf));
>>> +        if (err)
>>> +            goto out;
>>> +    }
>>> +
>>> +handle_tail:
>>> +    if (data_sz - offset < sizeof(buf)) {
>>> +        err = bpf_dynptr_read(&buf, data_sz - offset, &ptr_xdp, 
>>> offset, 0);
>>> +        if (err)
>>> +            goto out;
>>> +        err = bpf_memcmp(buf, expected_buf, data_sz - offset);
>>> +    }
>>> +out:
>>> +    return XDP_DROP;
>>> +}
>>> +
>>>   void *user_ptr;
>>>   /* Contains the copy of the data pointed by user_ptr.
>>>    * Size 384 to make it not fit into a single kernel chunk when 
>>> copying
>>
>


