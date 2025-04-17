Return-Path: <bpf+bounces-56205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C03A92DDB
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864048E5ADB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF621E0AC;
	Thu, 17 Apr 2025 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bltAVD6Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEF21D3EE
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931593; cv=none; b=sPNeWb2dVEOIiZi08X4kwMH/wppHbGYhbWMXDaQeinOoNdlG+4HDWZvQ9AFLXv+FAGZsCPWf32GJFkX5zgzrq1aqhGJG+VENZYdZmK4eOTk3GKAXdfZIVtJB01BjxHbYFv/3dJ42uZlSou3VdRgHv9i4bp+SU+/PkXcDiJHl34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931593; c=relaxed/simple;
	bh=0D/rQR6IhUPn0TtjizCjo+zMfPUn+vWzDoKE4aDPFP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO1fD2fcIwmnkrDRgyUyMwmw5wAwhVIjVopsynPM4gi0WbbvAQw7ZSc2mDiCP2IhnyNw2ZcqeoFhWGbqnJSzaWK4gWKB4OGjrw4sQJdmEuELLyAe1I6eBNpgC2QYZ6HBPZe4jX7oK5wYNL6PsUFYrr+vTpFuTQXRB0ybqGWTYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bltAVD6Y; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42b84ea3-b3c1-4839-acfc-bd182e7af313@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744931587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12vwvfTShIFMR6Uotw1VByzGmiKPJQSKRMkHoLSjpwI=;
	b=bltAVD6Y3y7CAzSIqsFTZlpE52r0ncfFgFfo0SuAWsJZxI51OeH+jv8PEMXOZmmTcYszCW
	g+HC6s6e0vWDBnUSKlv6daOGs6clNHtJSDGkvSxVINt2ZOG1l/GWK9MRGtRzRcM9+kQL4c
	h+XiuVjcl5mARV48rDwhxWlNBrwNNxA=
Date: Thu, 17 Apr 2025 16:12:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Kuniyuki Iwashima <kuniyu@amazon.com>, jordan@jrife.io
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
References: <20250416233622.1212256-3-jordan@jrife.io>
 <20250417224219.29946-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250417224219.29946-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/25 3:41 PM, Kuniyuki Iwashima wrote:
> From: Jordan Rife <jordan@jrife.io>
> Date: Wed, 16 Apr 2025 16:36:17 -0700
>> Require that iter->batch always contains a full bucket snapshot. This
>> invariant is important to avoid skipping or repeating sockets during
>> iteration when combined with the next few patches. Before, there were
>> two cases where a call to bpf_iter_udp_batch may only capture part of a
>> bucket:
>>
>> 1. When bpf_iter_udp_realloc_batch() returns -ENOMEM [1].
>> 2. When more sockets are added to the bucket while calling
>>     bpf_iter_udp_realloc_batch(), making the updated batch size
>>     insufficient [2].
>>
>> In cases where the batch size only covers part of a bucket, it is
>> possible to forget which sockets were already visited, especially if we
>> have to process a bucket in more than two batches. This forces us to
>> choose between repeating or skipping sockets, so don't allow this:
>>
>> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>>     fails instead of continuing with a partial batch.
>> 2. Retry bpf_iter_udp_realloc_batch() up to two times if we fail to
>>     capture the full bucket. On the third attempt, hold onto the bucket
>>     lock (hslot2->lock) through bpf_iter_udp_realloc_batch() with
>>     GFP_ATOMIC to guarantee that the bucket size doesn't change before
>>     our next attempt. Try with GFP_USER first to improve the chances
>>     that memory allocation succeeds; only use GFP_ATOMIC as a last
>>     resort.
> 
> kvmalloc() tries the kmalloc path, 1. slab and 2. page allocator, and
> if both of them fails, then tries 3. vmalloc().  But, vmalloc() does not
> support GFP_ATOMIC, __kvmalloc_node_noprof() returns at
> !gfpflags_allow_blocking().
> 
> So, falling back to GFP_ATOMIC is most unlikely to work as the last resort.
> 
> GFP_ATOMIC first and falling back to GFP_USER few more times, or not using
> GFP_ATOMIC makes more sense to me.

If I read it correctly, the last retry with GFP_ATOMIC is not because of the 
earlier GFP_USER allocation failure but the size of the bucket has changed a lot 
that it is doing one final attempt to get the whole bucket and this requires to 
hold the bucket lock to ensure the size stays the same which then must use 
GFP_ATOMIC.


