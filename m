Return-Path: <bpf+bounces-55901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890FA88E90
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA51167B7D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261ED1F4CA2;
	Mon, 14 Apr 2025 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MERbp96n"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01091F463E
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667666; cv=none; b=slc96/UE+EgYlSqrJ8uEw7aAOR1Ag14g6KV1gka/tXUFlJFD/1cML9vXU1qXax9plqEBiqSBnDvrTnXCIGgvSvlqnxrWwXvnBVo0w9kZIrGl3Amz1Ke4Lhq7fUOwxmIBEix1pK2vjbRiOJeGbOLfuL9MV+XcGWa+SqkAI8nN/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667666; c=relaxed/simple;
	bh=J531gmLJ08EbaNG6kXTPyVPYehiX91zRME8RIrjrfZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJEFRch54jfI8T9WqHr1AMpUbHk887cWvYgAt5k9tAmZi7tDgbB2+T1ynf1fNw9etZkfACCuydWTeda/v0JuhFWRUh+O/mM4vAJPgwW0zN7MKIjXSoNbNl6uc1w/+4fXooH/YnBXl9Pe20qx0veYM9f5dk2k828r5OnCnMSyQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MERbp96n; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d323d417-3e8b-48af-ae94-bc28469ac0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744667651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o2nl/uZTYCTDnuGWRrjRR8P5o5/1enqeZcjycBaXgY=;
	b=MERbp96nQq7s6pkIpZ0afhXgqugbMiuBSa5VkDBKXyAEW/GkK2bwepzlM8puBoa2W8xJGY
	V53mFE2Cg35Bdq0ZhR04RPw9CsTOXQtZVNTHziBypMEhSeBawXpY4PYIh8fiYR7aed1MoV
	WK9IOdMAQvN8UIHUgx4PZOi5bHchedY=
Date: Mon, 14 Apr 2025 14:54:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from
 bpf_iter_udp_batch
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-3-jordan@jrife.io>
 <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
 <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
 <daa3f02a-c982-4a7a-afcd-41f5e9b2f79c@linux.dev> <Z_xQhm4aLW9UBykJ@t14>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z_xQhm4aLW9UBykJ@t14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/13/25 5:02 PM, Jordan Rife wrote:
>> static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> {
>>          if (iter->cur_sk < iter->end_sk) {
>>                  u64 cookie;
>>
>>                  cookie = iter->st_bucket_done ?
>>                          0 : __sock_gen_cookie(iter->batch[iter->cur_sk].sock);
>>                  sock_put(iter->batch[iter->cur_sk].sock);
>>                  iter->batch[iter->cur_sk++].cookie = cookie;
>>          }
>>
>>          /* ... */
>> }
>>
>> In bpf_iter_udp_resume(), if it cannot find the first sk from find_cookie to
>> end_cookie, then it searches backward from find_cookie to 0. If nothing found,
>> then it should start from the beginning of the resume_bucket. Would it work?
> 
> It seems like the intent here is to avoid repeating sockets that we've
> already visited?
> 
> This would work if you need to process a bucket in two batches or less,
> but it would still be possible to repeat a socket if you have to process
> a bucket in more than two batches: during the transition from batch two
> to batch three you don't have any context about what you saw in batch
> one, so in the worst case where all the cookies we remembered from batch
> two are not found, we restart from the beginning of the list where we
> might revisit sockets from batch one. I guess you can say this reduces
> the probability of repeats but doesn't eliminate it.
> 
> e.g.: socket A gets repeated in batch three after two consecutive calls
>        to bpf_iter_udp_batch() hit the resized == true case due to heavy
>        churn in the current bucket.
> 
> |               Thread 1            Thread 2   Batch State    List State
> |  -------------------------------  ---------  ------------   ----------
> |                                              [_]            A->B
> |  bpf_iter_udp_batch()                        "              "
> |    spin_lock_bh(&hslot2->lock)               "              "
> |    ...                                       [A]            "
> |    spin_unlock_bh(&hslot2->lock)             "              "
> |                                   add C,D    "              A->B->C->D
> |    bpf_iter_udp_realloc_batch(3)             "              "
> |    spin_lock_bh(&hslot2->lock)               [A,_,_]        "
> |    ...                                       [A,B,C]        "
> |    spin_unlock_bh(&hslot2->lock)             "              "
> |    resized == true                           "              "
> |    return A                                  "              "
> |                                   del B,C    "              A->D
> |                                   add E,F,G  "              A->D->E->
> t                                                             F->G
> i  bpf_iter_udp_batch()                        "              "
> m    spin_lock_bh(&hslot2->lock)               "              "
> e    ...                                       [D,E,F]        "
> |    spin_unlock_bh(&hslot2->lock)             "              "
> |                                   add H,I,J  "              A->D->E->
> |                                                             F->G->H->
> |                                                             I->J
> |    bpf_iter_udp_realloc_batch(6)             [D,E,F,_,_,_]  "
> |    spin_lock_bh(&hslot2->lock)               "              "
> |    ...                                       [D,E,F,G,H,I]  "
> |    spin_unlock_bh(&hslot2->lock)             "              "
> |    resized == true                           "              "
> |    return D                                  "              "
> |                                   del D,E,   "              A->J
> |                                       F,G,
> |                                       H,I,
> |  bpf_iter_udp_batch()                        "              "
> |    spin_lock_bh(&hslot2->lock)               "              "
> |    ...                                       [A,J,_,_,_,_]  "
> |                         !!! A IS REPEATED !!! ^
> |    spin_unlock_bh(&hslot2->lock)             "              "
> |    return A                                  "              "
> v

Agree that >1 batches on the same bucket may have a repeated-sk situation, like 
the above example you demonstrated.

> 
> There's a fundamental limitation where if we have to process a bucket in
> more than two batches, we can lose context about what we've visited
> before, so there's always some edge case like this. The choice is
> basically:
> 
> (1) Make a best-effort attempt to avoid repeating sockets, and accept
>      that repeats can still happen in rare cases. Maybe the chances are
>      close enough to zero to never actually happen, although it's hard to
>      say; it may be more probable in some scenarios.
> 
> or
> 
> (2) Guarantee that repeats can't happen by requiring that a bucket
>      completely fits into one (or two?) batches: either error out in the
>      resized == true case or prevent it altogether by holding onto the
>      lock across reallocs with GFP_ATOMIC to prevent races.
> 
> All things being equal, (2) is a nice guarantee to have, but I sense
> some hesitance to hold onto hslot2->lock any longer than we already are.
> Is there a high performance cost I'm not seeing there? I guess there's a
> higher chance of lock contention, and with GFP_ATOMIC allocation is more
> likely to fail, but reallocs should be fairly rare? Maybe we could
> reduce the chance of reallocs during iteration by "right-sizing" the
> batch from the start, e.g. on iterator init, allocate the batch size to
> be 3/2 * the maximum list length currently in the UDP table, since you
> know you'll eventually need it to be that size anyway. Of course, lists
> might grow after that point requiring a realloc somewhere along the way,
> but it would avoid any reallocs in cases where the lengths are mostly
> stable. I'm fine with (1) if that's the only viable option, but I just
> wanted to make sure I'm accurately understanding the constraints here.

I am concerned having higher unnecessary failure chance (although unlikely) for 
the current use cases that do not care for a sk repeated or not. For example, 
the bpf prog has checked the sk conditions (address/port/tcp-cc...etc) before 
doing setsockopt or doing bpf_sock_destory.

I may have over-thought here. ok to bite the bullet on GFP_ATOMIC but I will be 
more comfortable if it can retry a few times on the "resized == true" case first 
with GFP_USER before finally resort to GFP_ATOMIC. or may be another way around 
GFP_ATOMIC fist and falls back to GFP_USER. Thoughts?

For tracking the maximum list length, not sure how much it will help considering 
it may still change, so it still needs to handle the resize+realloc situation 
regardless.

