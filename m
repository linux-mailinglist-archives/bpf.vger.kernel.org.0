Return-Path: <bpf+bounces-61903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB74AEE971
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2755417C014
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835523497B;
	Mon, 30 Jun 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSBaonnE"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264661A0BE0
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318874; cv=none; b=FZSLlUMb2h592eDrXPg6BcPpfYCqbqJ+Dhp1rpRSLgLscdfM6/ah8XivyDXx/cxkTjZuOPDjIfZ/ZXbIeja9UnhsDbPhij0IYQmIi9+vALIYZ3iMPKS3HjEgAAHYIsPA/veN042vvEhfK6RSeWAVv4vvOv3WylbUI1OIpCGHOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318874; c=relaxed/simple;
	bh=RIghVpgCkOYV78GsfyPYkya5kB0Fm8fmB6QKP1AoKJc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xf088PksX/oEcyRdTu5HYqdT8/M8Xqx2qaYWAvwbYzRmJTjC0uYeNiOLE98+Je3X0UOa72b4q5RJ234mNpt+spmczZBPZEJSlRFd4ZRZD2ykC6EfSIDAkKtXg3KMdRm8HrKXzm5OuJ5Rxm91/0ahs8QexsZ4Kd7djQlD60pNc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSBaonnE; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea6dca28-6654-4681-b610-03ea9c0b2af4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751318869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWXca6wavz67rxax53JsR8sOjq2No6y5iqrM6wbigGU=;
	b=GSBaonnE6Q2HzCb+GCdM2NMeZcWWJYTk/rGvvMbG5uUDw+sARFD1+DQDzsMP1c9nq0nKl4
	QeGTJSb561DgKFpP4ZgSoNQ57sSTesuEjjE7YoA8VnG+LxiEFIHo25wrNBzMHkBJWdW/zA
	y/UuqeGMfERRiAIApUcIZCrnEO0AAQc=
Date: Mon, 30 Jun 2025 14:27:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_dynptr_memset() kfunc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-2-isolodrai@meta.com>
 <36486564-3ce7-403b-91e4-268cae1c4905@gmail.com>
 <32a3de5b-381a-47a0-910e-ea8b02c4cf90@linux.dev>
Content-Language: en-US
In-Reply-To: <32a3de5b-381a-47a0-910e-ea8b02c4cf90@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/30/25 2:05 PM, Ihor Solodrai wrote:
> On 6/25/25 4:27 AM, Mykyta Yatsenko wrote:
>> On 6/24/25 21:52, Ihor Solodrai wrote:
>>> Currently there is no straightforward way to fill dynptr memory with a
>>> value (most commonly zero). One can do it with bpf_dynptr_write(), but
>>> a temporary buffer is necessary for that.
>>>
>>> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>>>
>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>> ---
>>>   kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index b71e428ad936..b8a7dbc971b4 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2906,6 +2906,53 @@ __bpf_kfunc int bpf_dynptr_copy(struct 
>>> bpf_dynptr *dst_ptr, u32 dst_off,
>>>       return 0;
>>>   }
>>> +/**
>>> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
>>> + * @ptr: Destination dynptr - where data will be filled
>>> + * @ptr_off: Offset into the dynptr to start filling from
>>> + * @size: Number of bytes to fill
>>> + * @val: Constant byte to fill the memory with
>>> + *
>>> + * Fills the size bytes of the memory area pointed to by ptr
>>> + * at offset ptr_off with the constant byte val.
>>> + * Returns 0 on success; negative error, otherwise.
>>> + */
>>> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 
>>> ptr_off, u32 size, u8 val)
>>> + {
>>> +    struct bpf_dynptr_kern *p = (struct bpf_dynptr_kern *)ptr;
>>> +    char buf[256];
>>> +    u32 chunk_sz;
>>> +    void* slice;
>>> +    u32 offset;
>>> +    int err;
>>> +
>>> +    if (__bpf_dynptr_is_rdonly(p))
>>> +        return -EINVAL;
>>> +
>>> +    err = bpf_dynptr_check_off_len(p, ptr_off, size);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    slice = bpf_dynptr_slice_rdwr(ptr, ptr_off, NULL, size);
>>> +    if (likely(slice)) {
>>> +        memset(slice, val, size);
>>> +        return 0;
>>> +    }
>>
>> bpf_dynptr_slice_rdwr is doing rdonly and off_len checks anyways, so 
>> perhaps we can
>> avoid calling __bpf_dynptr_is_rdonly and bpf_dynptr_check_off_len 
>> before bpf_dynptr_slice_rdwr,
>> that'll make fast path a little faster.
> 
> Yes, there are quite a bit of repetitive checks.
> Same in bpf_dynptr_write() in the slow path.
> 
> In case of bpf_dynptr_slice_rdwr() the issue is that it returns a
> pointer, and if we only check for null pointer we lose the information
> about the error cause (is it readonly or size?). So I think it's
> better to leave explicit checks.

I just realized that I might have misunderstood your comment.
Did you mean to put the checks after bpf_dynptr_slice_rdwr()
call instead of before?

> 
>>
>>> +
>>> +    /* Non-linear data under the dynptr, write from a local buffer */
>>> +    chunk_sz = min_t(u32, sizeof(buf), size);
>>> +    memset(buf, val, chunk_sz);
>>> +
>>> +    for (offset = ptr_off; offset < ptr_off + size; offset += 
>>> chunk_sz) {
>>> +        chunk_sz = min_t(u32, sizeof(buf), size - offset);
>>> +        err = __bpf_dynptr_write(p, offset, buf, chunk_sz, 0);
>>> +        if (err)
>>> +            return err;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>>>   {
>>>       return obj;
>>> @@ -3364,6 +3411,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>>>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>>>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>>>   BTF_ID_FLAGS(func, bpf_dynptr_copy)
>>> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>>>   #ifdef CONFIG_NET
>>>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>>>   #endif
>>
> 


