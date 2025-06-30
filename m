Return-Path: <bpf+bounces-61898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE16AEE950
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C97166CA2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970F289836;
	Mon, 30 Jun 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDjBYbOI"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868C156678
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317539; cv=none; b=bQP6By+euvUnhsANd/HcSwnSkEKoc+d040xmn53BoGuPo3+VmX6sIbFJaPmyfl7sWMkC8Z6GjKX8NyDWrHxXy+HQwBa8D08IK5tzpDNEYyR+B06ISVQN0XA1cZTB7wI/gU+NuSpOEAf0lTrFDUAzFoqLHQg0kiU4r900EvDK4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317539; c=relaxed/simple;
	bh=g0bATZGxa8vt9Y1TBrDrD2ZlW3Zk5XLJ2Px+5WwRj6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6dxjpTHzKfwARusj0dftVgqxqvcROQfXhPy9LgfOZ2nmfrjfUXHZSUlsuD593UfCXVmAP1jN3huxnjtxSvqZs98G9FyacnnCuPLT2z4w8Rj4/tEKvPb4s7VZmKRvjEfJ9/aOpfi9ENRFNw1SdHIutOjijn7MvkspF32D7WRbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDjBYbOI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32a3de5b-381a-47a0-910e-ea8b02c4cf90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751317535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gji5C9C8umNi2jNWE1dAPk7HmK1Yu8YiL/PwzjJ3N9M=;
	b=fDjBYbOIVrcPOBs0V6paYa2MIZF+HftxH5pVz4WFxCMADO4qJRgdTIleRyL6Xf6pimuiOw
	KC2ZTjW2T1Jo34FqRZuilvgRgPF2gldY7MKHQY7DD94zDm44crElw6rvaPsqFNReE22hkK
	aQf+4HjlRCZYuxeFrp2ZMO84BrrPH9o=
Date: Mon, 30 Jun 2025 14:05:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-2-isolodrai@meta.com>
 <36486564-3ce7-403b-91e4-268cae1c4905@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <36486564-3ce7-403b-91e4-268cae1c4905@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/25/25 4:27 AM, Mykyta Yatsenko wrote:
> On 6/24/25 21:52, Ihor Solodrai wrote:
>> Currently there is no straightforward way to fill dynptr memory with a
>> value (most commonly zero). One can do it with bpf_dynptr_write(), but
>> a temporary buffer is necessary for that.
>>
>> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b71e428ad936..b8a7dbc971b4 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2906,6 +2906,53 @@ __bpf_kfunc int bpf_dynptr_copy(struct 
>> bpf_dynptr *dst_ptr, u32 dst_off,
>>       return 0;
>>   }
>> +/**
>> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
>> + * @ptr: Destination dynptr - where data will be filled
>> + * @ptr_off: Offset into the dynptr to start filling from
>> + * @size: Number of bytes to fill
>> + * @val: Constant byte to fill the memory with
>> + *
>> + * Fills the size bytes of the memory area pointed to by ptr
>> + * at offset ptr_off with the constant byte val.
>> + * Returns 0 on success; negative error, otherwise.
>> + */
>> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 
>> ptr_off, u32 size, u8 val)
>> + {
>> +    struct bpf_dynptr_kern *p = (struct bpf_dynptr_kern *)ptr;
>> +    char buf[256];
>> +    u32 chunk_sz;
>> +    void* slice;
>> +    u32 offset;
>> +    int err;
>> +
>> +    if (__bpf_dynptr_is_rdonly(p))
>> +        return -EINVAL;
>> +
>> +    err = bpf_dynptr_check_off_len(p, ptr_off, size);
>> +    if (err)
>> +        return err;
>> +
>> +    slice = bpf_dynptr_slice_rdwr(ptr, ptr_off, NULL, size);
>> +    if (likely(slice)) {
>> +        memset(slice, val, size);
>> +        return 0;
>> +    }
> 
> bpf_dynptr_slice_rdwr is doing rdonly and off_len checks anyways, so 
> perhaps we can
> avoid calling __bpf_dynptr_is_rdonly and bpf_dynptr_check_off_len before 
> bpf_dynptr_slice_rdwr,
> that'll make fast path a little faster.

Yes, there are quite a bit of repetitive checks.
Same in bpf_dynptr_write() in the slow path.

In case of bpf_dynptr_slice_rdwr() the issue is that it returns a
pointer, and if we only check for null pointer we lose the information
about the error cause (is it readonly or size?). So I think it's
better to leave explicit checks.

> 
>> +
>> +    /* Non-linear data under the dynptr, write from a local buffer */
>> +    chunk_sz = min_t(u32, sizeof(buf), size);
>> +    memset(buf, val, chunk_sz);
>> +
>> +    for (offset = ptr_off; offset < ptr_off + size; offset += 
>> chunk_sz) {
>> +        chunk_sz = min_t(u32, sizeof(buf), size - offset);
>> +        err = __bpf_dynptr_write(p, offset, buf, chunk_sz, 0);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>>   {
>>       return obj;
>> @@ -3364,6 +3411,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>>   BTF_ID_FLAGS(func, bpf_dynptr_copy)
>> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>>   #ifdef CONFIG_NET
>>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>>   #endif
> 


