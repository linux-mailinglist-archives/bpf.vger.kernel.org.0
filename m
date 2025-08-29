Return-Path: <bpf+bounces-66990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4759FB3BF87
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEC58829A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C217326D49;
	Fri, 29 Aug 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P62n5vgv"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88865322A1A
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481695; cv=none; b=NGA5UlSiPGqcJwgskRhTQpZMXOIY3z8lq21zlg3v31YHS5XB/dyD/5OR+zwvMa7PLSO+3sATeIGvPyKuc6YXitZDGlOcH2bs1kkXuyIgZHEYfbUBmXRKdNVK5xJTd8ELhTWBZ9PqOoEQcfsavH8hyxRrwkjQCgei72/82IwoUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481695; c=relaxed/simple;
	bh=Q4YgVpLsGvMNxEZedETcLw/QXEISSTovzr9ZBwXrwh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgPyFQQqpJ4YI0P/BevCnolxZRqRu5izKFydyaw5KkMr27Y0ocHM3xJre7GoZh8KZKP4h0w+VYorNlidfjSg8b8xmj1yC1FX//Vf3ndmTczD2jq989lE/5+EGU6zwUYmDzSaMoiPrkBkVBv4f2hhVl2+3lDLUyD5mPlX/Q5A7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P62n5vgv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a3d321e-b8d6-4a64-a1f1-fc44d9d7848e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756481691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy0QtKBiYJ+ZRh0PGhAXjFTjhyal8GXd64ijZwBdxrs=;
	b=P62n5vgvN+dSYE5vYOQlbsUWXQXERHjkl1iMCw2NhSxqn6BbqQHeiRjN6xIAa5LOLWBl4Q
	JTUGSP1ua/Ulx5qDOVxQNJxs0jhW6Z8DuG+09UJFmPOwrHRDHis1wCuysfx7A9sumVxOkR
	ZTfdg8x6YGUWtLooGDuw+u22FHL1Vc4=
Date: Fri, 29 Aug 2025 16:34:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds dynptr write in
 bpf_crypto_crypt
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org,
 Stanislav Fort <disclosure@aisle.com>
References: <20250829143657.318524-1-daniel@iogearbox.net>
 <c4e28d41-ee1f-4167-a07d-25c499c496ea@linux.dev>
 <cacb4948-fb97-4bb4-8147-f38245ec3826@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <cacb4948-fb97-4bb4-8147-f38245ec3826@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/08/2025 16:30, Daniel Borkmann wrote:
> On 8/29/25 4:50 PM, Vadim Fedorenko wrote:
>> On 29/08/2025 15:36, Daniel Borkmann wrote:
>>> Stanislav reported that in bpf_crypto_crypt() the destination dynptr's
>>> size is not validated to be at least as large as the source dynptr's
>>> size before calling into the crypto backend with 'len = src_len'. This
>>> can result in an OOB write when the destination is smaller than the
>>> source.
>>>
>>> Concretely, in mentioned function, psrc and pdst are both linear
>>> buffers fetched from each dynptr:
>>>
>>>    psrc = __bpf_dynptr_data(src, src_len);
>>>    [...]
>>>    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>>>    [...]
>>>    err = decrypt ?
>>>          ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv) :
>>>          ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
>>>
>>> The crypto backend expects pdst to be large enough with a src_len length
>>> that can be written. Add an additional src_len > dst_len check and bail
>>> out if it's the case. Note that these kfuncs are accessible under root
>>> privileges only.
>>>
>>> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
>>> Reported-by: Stanislav Fort <disclosure@aisle.com>
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>> ---
>>>   kernel/bpf/crypto.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>>> index 94854cd9c4cc..83c4d9943084 100644
>>> --- a/kernel/bpf/crypto.c
>>> +++ b/kernel/bpf/crypto.c
>>> @@ -278,7 +278,7 @@ static int bpf_crypto_crypt(const struct 
>>> bpf_crypto_ctx *ctx,
>>>       siv_len = siv ? __bpf_dynptr_size(siv) : 0;
>>>       src_len = __bpf_dynptr_size(src);
>>>       dst_len = __bpf_dynptr_size(dst);
>>> -    if (!src_len || !dst_len)
>>> +    if (!src_len || !dst_len || src_len > dst_len)
>>
>> I think it would make sense to have less restrictive check. I mean it's
>> ok to have dst_len equal to src_len.
> 
> That scenario is/remains allowed and is also what the 'good' case is 
> testing in
> the BPF selftests (src_len 16 vs dst_len 16).

Ah, sorry, misread the code. Yeah, it makes sense.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

