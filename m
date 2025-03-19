Return-Path: <bpf+bounces-54353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F3A68180
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 01:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A917C19C222F
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29013AC1C;
	Wed, 19 Mar 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqcUU2eZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66ED25761
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344248; cv=none; b=EslVNuIdQ9Qq4F1mmbjhEabMyFkPaWAKVZElJfZmM4ivcc4bKhye7sh4kjcc+2VaJxPH12F4c6RixFUOrnCJREYBW6XY0/V8qiSZ/GL9l67QW0eySEdWn3zGYpTIVyrUl4+8C1OC1mNCIvv+c3Va+uZq6T39b90ER2o7GCEc2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344248; c=relaxed/simple;
	bh=luqF2jHLmKY+RLPKMJq4IPHVW4NXlzeIe2MDHG50KrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mntmEl+ygHIHuIwhLhEwn5Hlxzjq/GYinw55py5mSzi4P8vZVtS4PJxMP6hRF93Rzv63FPNVPSRuFH6dnfP/C86J30ZqB305cF/jQbr8MYR8jHDQTj80G0FankLQ/8Y51Y2rANXdIfK/9+XPpfjkgSsHTCWtByqfd3yNMozPMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqcUU2eZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742344241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdBbxEuv4+gUW7POTDlbc6n4VZ75Yi4SjW3g8RB7MsI=;
	b=XqcUU2eZwMe7spWbuYWmle2eW2p5HVyYXx0LHrnkxSTJ5ZPByYv0HIRdlmtfmkXqXYUFQs
	SiuJ+qZHlx9ET/U/9yduoVxBB3sfj9m+oSb4FZo23/9ArSe9UOS6p2ROSq/F42KBtM6mXE
	0itvpPNaXtcqXb9YThqVfJq3+b/GAvQ=
Date: Tue, 18 Mar 2025 17:30:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket
 iterators
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>,
 Aditi Ghag <aditi.ghag@isovalent.com>
References: <20250313233615.2329869-1-jrife@google.com>
 <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/17/25 6:45 PM, Jordan Rife wrote:
> Hi Martin,
> 
> Thanks a lot for taking a look.
> 
>> The batch should have a snapshot of the bucket. Practically, it should not have
>> the "repeating" or "missing" a sk issue as long as seq->stop() is not called in
>> the middle of the iteration of that batch.
>>
>> I think this guarantee is enough for the bpf_sock_destroy() and the
>> bpf_setsockopt() use case if the bpf prog ends up not seq_write()-ing anything.
> 
> Yeah, I realized shortly after sending this out that in the case that
> you're purely using the iterator to call bpf_sock_destroy() or
> bpf_setsockopt() without any seq_write()s, you would likely never have
> to process a bucket in multiple "chunks". Possibly a poor example on
> my part :). Although, I have a possibly dumb question even in this
> case. Focusing in on just bpf_iter_udp_batch for a second,
> 
>>     if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
>>         resized = true;
>>         /* After allocating a larger batch, retry one more time to grab
>>          * the whole bucket.
>>          */
>>         goto again;
>>     }
> 
> Barring the possibility that bpf_iter_udp_realloc_batch() fails to
> grab more memory (should this basically never happen?), this should
> ensure that we always grab the full contents of the bucket on the
> second go around. However, the spin lock on hslot2->lock is released
> before doing this. Would it not be more accurate to hold onto the lock
> until after the second attempt, so we know the size isn't changing
> between the time where we release the lock and the time when we
> reacquire it post-batch-resize. The bucket size would have to grow by
> more than 1.5x for the new size to be insufficient, so I may be
> splitting hairs here, but just something I noticed.

It is a very corner case.

I guess it can with GFP_ATOMIC. I just didn't think it was needed considering 
the key of the hash is addresses+ports. If we have many socks collided on the 
same addresses+ports bucket, that would be a better hashtable problem to solve 
first.

The default batch size is 16 now. On the listening hashtable + SO_REUSEPORT, 
userspace may have one listen sk binding on the same address+port for each 
thread. It is not uncommon to have hundreds of CPU cores now, so it may actually 
need to hit the realloc_batch() path once and then likely will stay at that size 
for the whole hashtable iteration.

> 
> But yeah, iterators that also print/dump are the main concern.
> 
>> One thought is to avoid seq->stop() which will require to do batching again next
>> time, in particular, when the user has provided large buf to read() to ensure it
>> is large enough for one bucket. May be we can return whatever seq->buf has to
>> the userspace whenever a bucket/batch is done. This will have perf tradeoff
>> though and not sure how the userspace can optin.
> 
> Hmmm, not sure if I understand here. As you say below, don't we have
> to use stop to deref the sk between reads?

I was thinking the case that, e.g. the userspace's buf may be large enough for 
 >1 bucket but <2 buckets. Then the 2nd bucket is only half done and requires a 
stop().

> 
>> Another random thought is in seq->stop (bpf_iter_{tcp,udp}_seq_stop). It has to
>> release the sk refcnt because we don't know when will the userspace come back to
>> read(). Will it be useful if it stores the cookies of the sk(s) that have not
>> yet seq->show?
> 
> Keeping track of all the cookies we've seen or haven't seen in the
> current bucket would indeed allow us to avoid skipping any we haven't
> seen or repeating those we have on subsequent reads. I had considered

I don't think we need to worry about the newly added sk after the iteration 
started. This chase on newly added sk may not end.

Only need to avoid iterating the same sk.

> something like this, but had initially avoided it, since I didn't want
> to dynamically allocate (and reallocate) additional memory to keep
> track of cookies. I also wasn't sure if this would be acceptable
> performance-wise, and of course the allocation can fail in which case
> you're back to square one. Although, I may be imagining a different
> implementation than you. In fact, this line of thinking led me to the
> approach proposed in the RFC which basically tries to
> accurately/efficiently track everything that's already seen without
> remembering all the cookies or allocating any additional buffers. This
> might make a good alternative if the concerns I listed aren't a big
> deal.

I don't think memory will be a concern if we are talking about another array 
(for one bucket) is needed for storing cookies. This may actually be the right 
tradeoff instead of modifying the common networking code path or adding fields 
to struct sock.

We can also consider if the same sk batch array can be reused to store cookies 
during stop(). If the array can reuse, it would be nice but not a blocker imo.

In term of slowness, the worst will be all the previous stored cookies cannot be 
found in the updated bucket? Not sure how often a socket is gone and how often 
there is a very large bucket (as mentioned at the hashtable's key earlier), so 
should not be an issue for iteration use case? I guess it may need some rough 
PoC code to judge if it is feasible.


