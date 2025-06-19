Return-Path: <bpf+bounces-61101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56699AE0BC1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E876D3AF537
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2C28C853;
	Thu, 19 Jun 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aRZEh33L"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C12F9DA
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750353007; cv=none; b=JlY43ERAMFGNGLGp/zLBylUmIrnX8GymwEKsoFNNBSiiLQwZRHtQfYE2VkvcmxdeltPkfkwllKqEmnA1hW6c3KasaDtHcm/65RAmdnNDypwE+rQCXyquvFMaE6IE0IoHkggbWYG3VHDr31Dv0hfY6etiZYUScnbXq++g7DSOuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750353007; c=relaxed/simple;
	bh=sqe2/y6TkwBIXslgZX1wcLqMWq85/LP7CbGUoJpLwnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea0KC1bfOsezrNd0zQAY6iWSOIAmjyoYiJjpW2Or6+D3YQR+NmUKa8bB/89lY6le9KNVLfoAkDrx18LsFjCmvpUg49QrWKaFfKnRyqfV/0ET3QHfYyh1dejJypITAtLwhqk3WLmoZ7HDmHls3nUXVJSTHOtb+vu8YUBGvNJ3tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aRZEh33L; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750353001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHehyvKPDg/6emjdfUVvvTqp6qSXwvzWjfGbb3kw3u4=;
	b=aRZEh33LUPapiL+ONc5swfbVKCDZ638V+b/+rK3LpxQgQWCKOdjILmzJ6Xw55m4A2R1qjz
	rC5A942TtOWL5OhPVfeHujXFvuf85SjkVc2YLpUpfjRl6E7gwUHRYWurNS7OG7swRtIFFU
	CKGx9xPDnByG54mNaaLLHA1vZlfdXKE=
Date: Thu, 19 Jun 2025 10:09:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250618223310.3684760-1-isolodrai@meta.com>
 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/18/25 4:44 PM, Mykyta Yatsenko wrote:
> On 6/18/25 23:33, Ihor Solodrai wrote:
>> Currently there is no straightforward way to fill dynptr memory with a
>> value (most commonly zero). One can do it with bpf_dynptr_write(), but
>> a temporary buffer is necessary for that.
>>
>> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b71e428ad936..dfd04628a522 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2906,6 +2906,33 @@ __bpf_kfunc int bpf_dynptr_copy(struct 
>> bpf_dynptr *dst_ptr, u32 dst_off,
>>       return 0;
>>   }
>> +/**
>> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
>> + * @ptr: Destination dynptr - where data will be filled
>> + * @val: Constant byte to fill the memory with
>> + * @n: Number of bytes to fill
>> + *
>> + * Fills the first n bytes of the memory area pointed to by ptr
>> + * with the constant byte val.
>> + * Returns 0 on success; negative error, otherwise.
>> + */
>> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u8 val, 
>> u32 n)
>> + {
>> +    struct bpf_dynptr_kern *p = (struct bpf_dynptr_kern *)ptr;
>> +    int err;
>> +
>> +    if (__bpf_dynptr_is_rdonly(p))
>> +        return -EINVAL;
>> +
>> +    err = bpf_dynptr_check_off_len(p, 0, n);
>> +    if (err)
>> +        return err;
>> +
>> +    memset(p->data + p->offset, val, n);
> Do we need to handle non-contiguous buffers, similarly to 
> bpf_dynptr_write (BPF_DYNPTR_TYPE_XDP case)?

It appears so, yes. I am a little lost on how exactly to do it though.

Looking at bpf_xdp_store_bytes [1]:

   BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *, xdp, u32, offset,
   	   void *, buf, u32, len)
   {
   	void *ptr;

   	ptr = bpf_xdp_pointer(xdp, offset, len);
   	if (IS_ERR(ptr))
   		return PTR_ERR(ptr);

   	if (!ptr)
   		bpf_xdp_copy_buf(xdp, offset, buf, len, true);
   	else
   		memcpy(ptr, buf, len);

   	return 0;
   }

   ...

   int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void 
*buf, u32 len)
   {
   	return ____bpf_xdp_store_bytes(xdp, offset, buf, len);
   }

It looks like I'd need to implement similar logic for memset.

But then, does memset even make sense for xdp/skb buffers?
Maybe -ENOTSUPP is more appropriate?

I'd appreciate any hints.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/net/core/filter.c#n4084

>> +
>> +    return 0;
>> +}
>> +
>>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>>   {
>>       return obj;
>> @@ -3364,6 +3391,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>>   BTF_ID_FLAGS(func, bpf_dynptr_copy)
>> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>>   #ifdef CONFIG_NET
>>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>>   #endif
> 


