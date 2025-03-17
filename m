Return-Path: <bpf+bounces-54243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4BA66137
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 23:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1737AB494
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8957204C31;
	Mon, 17 Mar 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ju+jIfu1"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED31F790C
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249182; cv=none; b=EG6rxGuwVn4kddWEY7ZmPL4Z7P4cin/x/fqSc4tIqAXtYorh/8kA3P3WSN6G3pMDtwlvx4yQiuROsNowTVkYUmO0/talkwMk6aEk74b2XmovrMiavnnBgbLDplRtfCYXDYATGIiEOOa9zXHy97/zufCPLEuoHGurYZPSFfotDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249182; c=relaxed/simple;
	bh=oVB0rmiG4dBR3J2pZ4eCFv3yR6tv27ZMOoCIydoNQUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVGhS8EsMwg57hERrMD0cPWtXxl17D5TPCAgNyJCy8pS4AMxJos2xCbPDTCEwx3GJ5UjM2fP6SaDqxyjfVCs+VhtMiu8LzMacvzVVvbOZ6iY6V518ccevz9k1RdmI6Dbqgf6uR4n3BrW6M8R1MgNfJSTKK9ynD5vxD1+oFHBG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ju+jIfu1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742249177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTWtd3vKFFwilEnZ0uDohkKF8707FhnZsoHclEcQLzg=;
	b=Ju+jIfu1/bO5rHUJhoVcCYl+FL0i8agXnyDaFr9Km+9MUxfCU/fHsHlTywQrqvDSMvJ3kp
	cOm9dN9TnDLFbxpq+y+14/hWGsd9eACjKWUW/I+LK2L2WjzgU+20YYRQi9PvoPFfPDxZrt
	fbBDO6VskZMi0P9DQy0T3FTYLW0jMpc=
Date: Mon, 17 Mar 2025 15:06:11 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250313233615.2329869-1-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/13/25 4:35 PM, Jordan Rife wrote:
> I was recently looking into using BPF socket iterators in conjunction
> with the bpf_sock_destroy() kfunc as a means to forcefully destroy a
> set of UDP sockets connected to a deleted backend [1]. Aditi describes
> the scenario in [2], the patch series that introduced bpf_sock_destroy()
> for this very purpose:
> 
>> This patch set adds the capability to destroy sockets in BPF. We plan
>> to use the capability in Cilium to force client sockets to reconnect
>> when their remote load-balancing backends are deleted. The other use
>> case is on-the-fly policy enforcement where existing socket
>> connections prevented by policies need to be terminated.
> 
> One would want and expect an iterator to visit every socket that existed
> before the iterator was created, if not exactly once, then at least
> once, otherwise we could accidentally skip a socket that we intended to
> destroy. With the iterator implementation as it exists today, this is
> the behavior you would observe in the vast majority of cases.
> 
> However, in the process of reviewing [2] and some follow up fixes to
> bpf_iter_udp_batch() ([3] [4]) by Martin, it occurred to me that there
> are situations where BPF socket iterators may repeat, or worse, skip
> sockets altogether even if they existed prior to iterator creation,
> making BPF iterators as a mechanism to achieve the goal stated above
> possibly buggy.
> 
> Admittedly, this is probably an edge case of an edge case, but I had
> been pondering a few ways to to close this gap. This RFC highlights
> some of these scenarios, extending prog_tests/sock_iter_batch.c to
> illustrate conditions under which sockets can be skipped or repeated,
> and proposes a possible improvement to iterator progress tracking to
> achieve exactly-once semantics even in the face of concurrent changes
> to the iterator's current bucket.
> 
> THE PROBLEM
> ===========
> Both UDP and TCP socket iterators use iter->offset to track progress
> through a bucket, which is a measure of the number of matching sockets
> from the current bucket that have been seen or processed by the
> iterator. However, iter->offset isn't always an accurate measure of
> "things already seen" when the underlying bucket changes between reads.
> 
> Scenario 1: Skip A Socket
> +------+--------------------+--------------+---------------+
> | Time | Event              | Bucket State | Bucket Offset |
> +------+--------------------+--------------+---------------+
> | 1    | read(iter_fd) -> A | A->B->C->D   | 1             |
> | 2    | close(A)           | B->C->D      | 1             |
> | 3    | read(iter_fd) -> C | B->C->D      | 2             |
> | 4    | read(iter_fd) -> D | B->C->D      | 3             |
> | 5    | read(iter_fd) -> 0 | B->C->D      | -             |
> +------+--------------------+--------------+---------------+
> 
> Iteration sees these buckets: [A, C, D]
> B is skipped.
> 
> Scenario 2: Repeat A Socket
> +------+--------------------+---------------+---------------+
> | Time | Event              | Bucket State  | Bucket Offset |
> +------+--------------------+---------------+---------------+
> | 1    | read(iter_fd) -> A | A->B->C->D    | 1             |
> | 2    | connect(E)         | E->A->B->C->D | 1             |
> | 3    | read(iter_fd) -> A | E->A->B->C->D | 2             |
> | 3    | read(iter_fd) -> B | E->A->B->C->D | 3             |
> | 3    | read(iter_fd) -> C | E->A->B->C->D | 4             |
> | 4    | read(iter_fd) -> D | E->A->B->C->D | 5             |
> | 5    | read(iter_fd) -> 0 | E->A->B->C->D | -             |
> +------+--------------------+---------------+---------------+
> 
> Iteration sees these buckets: [A, A, B, C, D]
> A is repeated.
> 
> PROPOSAL
> ========
> If we ignore the possibility of signed 64 bit rollover*, then we can
> achieve exactly-once semantics. This series replaces the current
> offset-based scheme used for progress tracking with a scheme based on a
> monotonically increasing version number. It works as follows:
> 
> * Assign index numbers on sockets in the bucket's linked list such that
>    they are monotonically increasing as you read from the head to tail.
> 
>    * Every time a socket is added to a bucket, increment the hash
>      table's version number, ver.
>    * If the socket is being added to the head of the bucket's linked
>      list, set sk->idx to -1*ver.
>    * If the socket is being added to the tail of the bucket's linked
>      list, set sk->idx to ver.
> 
>    Ex: append_head(C), append_head(B), append_tail(D), append_head(A),
>        append_tail(E) results in the following state.
>      
>        A -> B -> C -> D -> E
>       -4   -2   -1    3    5
> * As we iterate through a bucket, keep track of the last index number
>    we've seen for that bucket, iter->prev_idx.
> * On subsequent iterations, skip ahead in the bucket until we see a
>    socket whose index, sk->idx, is greater than iter->prev_idx.
> 
> Indexes are globally and temporally unique within a table, and
> by extension each bucket, and always increase as we iterate from head
> to tail. Since the relative order of items within the linked list
> doesn't change, and we don't insert new items into the middle, we can
> be sure that any socket whose index is greater than iter->prev_idx has
> not yet been seen. Any socket whose index is less than or equal to
> iter->prev_idx has either been seen+ before or was added to the head of
> the bucket's list since we last saw that bucket. In either case, it's
> safe to skip them (any new sockets did not exist when we created the
> iterator, so skipping them doesn't create an "inconsistent view").

imo, I am not sure we should add this on top of what the bucket already has, 
spin_lock and rcu protection. It feels a bit overkill for this edge case.

 > > * Practically speaking, I'm not sure if rollover is a very real concern,
>    but we could potentially extend the version/index field to 128 bits
>    or have some rollover detection built in as well (although this
>    introduces the possibility of repeated sockets again) if there are any
>    doubts.
> + If you really wanted to, I guess you could even iterate over a sort of
>    "consistent snapshot" of the collection by remembering the initial
>    ver in the iterator state, iter->ver, and filtering out any items
>    where abs(sk->idx) > iter->ver, but this is probably of little
>    practical use and more of an interesting side effect.
> 
> SOME ALTERNATIVES
> =================
> 1. One alternative I considered was simply counting the number of
>     removals that have occurred per bucket, remembering this between
>     calls to bpf_iter_(tcp|udp)_batch() as part of the iterator state,
>     then using it to detect if it has changed. If any removals have
>     occurred, we would need to walk back iter->offset by at least that
>     much to avoid skips. This approach is simpler but may repeat sockets.
> 2. Don't allow partial batches; always make sure we capture all sockets
>     in a bucket in one batch. bpf_iter_(tcp|udp)_batch() already has some
>     logic to try one time to resize the batch, but still needs to contend
>     with the fact that bpf_iter_(tcp|udp)_realloc_batch() may not be able
>     grab more memory, and bpf_iter_(tcp|udp)_put_batch() is called
>     between reads anyway, making it necessary to seek to the previous
>     offset next time around.

The batch should have a snapshot of the bucket. Practically, it should not have 
the "repeating" or "missing" a sk issue as long as seq->stop() is not called in 
the middle of the iteration of that batch.

I think this guarantee is enough for the bpf_sock_destroy() and the 
bpf_setsockopt() use case if the bpf prog ends up not seq_write()-ing anything.

For printing/dumping, I am not sure if other iterating interface (/proc or 
sock_diag) provide better guarantee than bpf_iter_{tcp,udp} but yeah, we can 
explore if something better can be done.

> 3. Error out if a scenario is detected where skips may be possible and
>     force the application layer to restart iteration. This doesn't seem
>     great.

I don't know what may be a good interface to restart the iteration. Restarting 
from the very beginning of the hashtable sounds bad.

It has been a while, I may not recall all the details of bpf_seq_read() but some 
fruits of thoughts...

One thought is to avoid seq->stop() which will require to do batching again next 
time, in particular, when the user has provided large buf to read() to ensure it 
is large enough for one bucket. May be we can return whatever seq->buf has to 
the userspace whenever a bucket/batch is done. This will have perf tradeoff 
though and not sure how the userspace can optin.

Another random thought is in seq->stop (bpf_iter_{tcp,udp}_seq_stop). It has to 
release the sk refcnt because we don't know when will the userspace come back to 
read(). Will it be useful if it stores the cookies of the sk(s) that have not 
yet seq->show?



