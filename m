Return-Path: <bpf+bounces-78631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D35BD15F20
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 01:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17AB730393FD
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791621257B;
	Tue, 13 Jan 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LeI67RfI"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCB1C5F1B
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263336; cv=none; b=O6aU2hjgU94tLnMuu+/3BrW1atuaRghuQPu5JI/dMCwHFkBo/x6PfOZqLXv2Y34obeq09ZMl+WOoDMqmFZZMZF95ONCKwxcjovYKjV0wWYfGlFCOxUSZfohYZ4x/nQ42+MPWZ32qapESg+Zf22ZY0773EsVECZkL0nZUViqgVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263336; c=relaxed/simple;
	bh=gvHbvF+alHW/GFmZwyIqoDQwp8tglUaEb3uXXAOyTz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUBgX26hLO8yVoqSgnuFTAHYV24Jcrg5nWNwhaCfk4lSfHXESG9fUi3LyncY6h/pos8GQgtGlXNDRQn91nisiSCaGsR7Pmixf/bRB0nBrx7wbLOQbd4CPtlX7B1+oxGSj8yX5y78rtwKvp2dAJfV8mxiKkdb4VSscaCkw/2XL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LeI67RfI; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1eb1715a-c1b0-4741-8d2d-f66adffcf91d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768263323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHAD91F192HxWa7NlcF9nJf3tRWljkeKZQty/FQBwSI=;
	b=LeI67RfIZQK6RmNFheDra64ma8/vGrHEaePeIAt/I6825Jo6bIwlaaJi5gRY94NSE4g29z
	K79TJMy0H0G6GwGZpbmpS6RRct8+SOzOv1pYSvH/YVRz862igkd7ot1w6atuBxRtg0lw33
	daxtdN86tdo1sSN3q4xV7tby6HkPU78=
Date: Mon, 12 Jan 2026 16:15:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-11-ameryhung@gmail.com>
 <337d8ebe-d3d4-4818-92d8-4937da835843@linux.dev>
 <CAMB2axNcc5yJwhXjcEcQJuLxrjB7MgVK6XXpKqO9EiFPtQH6bQ@mail.gmail.com>
 <36b3dc2d-b850-491f-bfc5-3581d5de7b82@linux.dev>
 <CAMB2axNtrFEL0x+j6M3De-ezR38cv5s7LFtpuAeN7QCf_AyHaQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axNtrFEL0x+j6M3De-ezR38cv5s7LFtpuAeN7QCf_AyHaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/12/26 2:38 PM, Amery Hung wrote:
>> [ btw, a nit, I think it can use a better function name instead of
>> "lockless". This function still takes the lock if it can. ]
> Does using _nofail suffix make it more clear?

sgtm.

> 
>>> sure how destroy() can hold b->lock in a way that causes map_free() to
>>> fail acquiring b->lock.
>> I recall ETIMEDOUT was mentioned to be the likely (only?) case here.
>> Assume the b->lock did fail in map_free here, there are >1 selem(s)
>> using the same b->lock. Is it always true that the selem that failed at
>> the b->lock in map_free() here must race with the very same selem in
>> destroy()?

This is still an open issue/question.

>>
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     /*
>>>>> +      * Only let destroy() unlink from local_storage->list and do mem_uncharge
>>>>> +      * as owner is guaranteed to be valid in destroy().
>>>>> +      */
>>>>> +     if (local_storage && caller == BPF_LOCAL_STORAGE_DESTROY) {
>>>> If I read here correctly, only bpf_local_storage_destroy() can do the
>>>> bpf_selem_free(). For example, if a bpf_sk_storage_map is going away,
>>>> the selem (which is memcg charged) will stay in the sk until the sk is
>>>> closed?
>>> You read it correctly and Yes there will be stale elements in
>>> local_storage->list.
>>>
>>> I would hope the unlink from local_storage part is doable from
>>> map_free() and destroy(), but it is hard to guarantee (1) mem_uncharge
>>> is done only once (2) while the owner is still valid in a lockless
>>> way.
>> This needs to be addressed. It cannot leave the selem lingering. At
>> least the selem should be freed for the common case (i.e., succeeds in
>> both locks). Lingering selem is ok in case of lock failure. Many sk can
>> be long-lived connections. The user space may want to recreate the map,
>> and it will be limited by the memcg.
> I think this is doable by maintaining a local memory charge in local storage.
> 
> So, remove selem->size and have a copy of total selem memory charge in
> a new local_storage->selem_size. Update will be protected by
> local_storage->lock in common paths (not in bpf_selem_unlink_nofail).
> More specifically, charge in bpf_selem_link_storage_nolock() when a
> selem is going to be publicized. uncharge in
> bpf_selem_unlink_storage_nolock() when a selem is being deleted. Then,
> in destroy() we simply get the total amount to be uncharged from the
> owner from local_storage->selem_size.

Right, I had a similar thought before. Because of the nofail/lockless 
consideration, I suspect the local_storage->selem_size will need to be 
atomic. I am not sure if it is enough though, e.g. there is a debug/warn 
on sk->sk_omem_alloc in __sk_destruct to ensure it is 0, so I stopped 
thinking on it for now, but it could be a direction to explore.

If it is the case, it is another atomic in the destruct/map_free code 
path. I am still open-minded on the nofail requirement for both locks, 
but complexity is building up. Kumar has also commented that b->lock in 
map_free should not fail. Regardless, I think lets get the nofail code 
path for map_free() sorted out first. Then we can move on to handle this 
case.


