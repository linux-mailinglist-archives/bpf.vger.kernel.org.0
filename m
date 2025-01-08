Return-Path: <bpf+bounces-48221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A321AA051A8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 04:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092903A7532
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED419CC36;
	Wed,  8 Jan 2025 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcZR90a4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA532594BB
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307494; cv=none; b=TKeZqt0k5VNjL7ZtBrrREsUDiFRk200VwUBvB3RmACYsFuZi/gsz2fXGvhPFcgSLwcZfn86S5ttrRQxTBx6n9zSNKbJkuaWQ8W2BzXs7ry/iOh51tNCnWImYFKdgKXLWHMsPg4ORulqdF6wkogCiTFp3YZ1truzVd7wECNGVT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307494; c=relaxed/simple;
	bh=HuBkXU4WGAIKikDiA4v9faPr62D42N2iT3vf6U8PU7g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lv2lStSahMZy0tUgIh/RobIknqOBUaTqUO+o7WUv/m4aS+nOtVbDyn47pgWvEZ1RdajWF53ysId/M14OR1NiZ7k7sv6wik7gKzMV4ip0OV2jD1oG7kOKVbDzuZYOeV59emUblYO/W2mk5tpf5lVxQ4aC0ItYhoh9uRNxzn9MCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcZR90a4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736307491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1T2+dFg8czdV4/r0tUFcPs7edWiEyCb3Pvfi0CFBS4=;
	b=dcZR90a4hVeYVO3UTTMcqxKiOivH/EstyTodJkncY/NUrbC9J1oT5w5Ak5QGPlEpRpP/yg
	y1gbBLUdIP3AHjw0i/+J8WLvelGvYadYdBYwI01D+2BawJTYSAJjaHQvIAzQJqstUMOm5b
	b13QXGe0OaIyTFhnDLVe9KdUSf3dCJU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--hrs1_b1Ng2K2a7zfsJjVg-1; Tue, 07 Jan 2025 22:38:09 -0500
X-MC-Unique: -hrs1_b1Ng2K2a7zfsJjVg-1
X-Mimecast-MFC-AGG-ID: -hrs1_b1Ng2K2a7zfsJjVg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e9fb0436so5006798685a.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 19:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736307489; x=1736912289;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1T2+dFg8czdV4/r0tUFcPs7edWiEyCb3Pvfi0CFBS4=;
        b=w1JZon/WwuCUX//0nBHnpHEMIClkpZvWzSWS1ZjsMwR0LqKXFwqhe7QhQ8/Fxhics6
         QA20Znj5NsDOc5sHvLXrl+ATKZzpE+NDLqGNu7yxZPYuEa3bLmIDBic9hvzfkb5ZsLJG
         lXkkB7wnkkryUtlvW1IEqdIzTDRzKx+Dm/gIVERDn1P7BSLh3AI0DIv1w3J5kv01vhDP
         BYLph5QGyLmfI9pghWwiVgkdCeGAEmd9zxOooeRsXuOM9O7PmVZcGLw2wVjg7SPvjfUu
         Rp7IeIsLmh4zWGzTQq/pLJcYCs2Tx73vtBR9syyXrW8aWVxgXSUn6dV2U4/exOfpgfs3
         PD9A==
X-Forwarded-Encrypted: i=1; AJvYcCXKZL7TiyZICNlPiCOXvvTOj2O0fJwnKO+VQbDg/5VLG2j3bSYzhl7jrjlPEWgBF2oD0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotiM3cb3gRVXxjKB545Qp/jqVqNNj/saYYvxOQsrm8OSNLFOA
	IOYt4dECxD/+lsYVScXF+mboteNkCR+yRpftCyncVbD94bL9dYUPeTgleblLHwl+h1xf3iy8mxf
	dswg4xQU78xxmeR5AmUQNPNP8diyzd3kKeO0KKFH3ENq9FYIHzQ==
X-Gm-Gg: ASbGncsvEchrOMelB/bIZD5UmkVZ45KX/V1g1qthGI0RRPwRIx2umyLcg3x3lyhZeXu
	F+gvA4BGFloYpSEHW5qkT4qtzSVdh7GyZC+jsYjfgwjtfDrjBYMHy5IR8Skf6sd/jPQCNNslVm9
	fA4ESJeSWspD3YzeRtgjb0IbZKm40YpPYWGF7Tcn6IqL3A6hbRqaer87U9jhsFwEFNocWFf80oS
	uoC9JI3C2iJhf+QjriSQakEPxjoAGrabvvgVUEwNnUrxaN0rNBKgActeNxfEh0gAFuPEUndThO+
	KK+AXrTMRXAseJ0GnnwWHm3s
X-Received: by 2002:a05:620a:1aa7:b0:7b6:e20d:2b55 with SMTP id af79cd13be357-7bcd97b1aa0mr201433585a.41.1736307489227;
        Tue, 07 Jan 2025 19:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2jp1gzMsOIs/upwLQ9lfk8KRV5eRMFJzkXxfha13aTa4I5WcjU0JLvHMEgpdV7UefW2UHow==
X-Received: by 2002:a05:620a:1aa7:b0:7b6:e20d:2b55 with SMTP id af79cd13be357-7bcd97b1aa0mr201430385a.41.1736307488888;
        Tue, 07 Jan 2025 19:38:08 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478e59sm1648658485a.78.2025.01.07.19.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 19:38:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f7bc2566-20a7-41fb-ac59-5d6a8901d8fb@redhat.com>
Date: Tue, 7 Jan 2025 22:38:06 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 09/22] rqspinlock: Protect waiters in queue
 from stalls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
 kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-10-memxor@gmail.com>
Content-Language: en-US
In-Reply-To: <20250107140004.2732830-10-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> Implement the wait queue cleanup algorithm for rqspinlock. There are
> three forms of waiters in the original queued spin lock algorithm. The
> first is the waiter which acquires the pending bit and spins on the lock
> word without forming a wait queue. The second is the head waiter that is
> the first waiter heading the wait queue. The third form is of all the
> non-head waiters queued behind the head, waiting to be signalled through
> their MCS node to overtake the responsibility of the head.
>
> In this commit, we are concerned with the second and third kind. First,
> we augment the waiting loop of the head of the wait queue with a
> timeout. When this timeout happens, all waiters part of the wait queue
> will abort their lock acquisition attempts. This happens in three steps.
> First, the head breaks out of its loop waiting for pending and locked
> bits to turn to 0, and non-head waiters break out of their MCS node spin
> (more on that later). Next, every waiter (head or non-head) attempts to
> check whether they are also the tail waiter, in such a case they attempt
> to zero out the tail word and allow a new queue to be built up for this
> lock. If they succeed, they have no one to signal next in the queue to
> stop spinning. Otherwise, they signal the MCS node of the next waiter to
> break out of its spin and try resetting the tail word back to 0. This
> goes on until the tail waiter is found. In case of races, the new tail
> will be responsible for performing the same task, as the old tail will
> then fail to reset the tail word and wait for its next pointer to be
> updated before it signals the new tail to do the same.
>
> Lastly, all of these waiters release the rqnode and return to the
> caller. This patch underscores the point that rqspinlock's timeout does
> not apply to each waiter individually, and cannot be relied upon as an
> upper bound. It is possible for the rqspinlock waiters to return early
> from a failed lock acquisition attempt as soon as stalls are detected.
>
> The head waiter cannot directly WRITE_ONCE the tail to zero, as it may
> race with a concurrent xchg and a non-head waiter linking its MCS node
> to the head's MCS node through 'prev->next' assignment.
>
> Reviewed-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/locking/rqspinlock.c | 42 +++++++++++++++++++++++++++++---
>   kernel/locking/rqspinlock.h | 48 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 87 insertions(+), 3 deletions(-)
>   create mode 100644 kernel/locking/rqspinlock.h
>
> diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> index dd305573db13..f712fe4b1f38 100644
> --- a/kernel/locking/rqspinlock.c
> +++ b/kernel/locking/rqspinlock.c
> @@ -77,6 +77,8 @@ struct rqspinlock_timeout {
>   	u16 spin;
>   };
>   
> +#define RES_TIMEOUT_VAL	2
> +
>   static noinline int check_timeout(struct rqspinlock_timeout *ts)
>   {
>   	u64 time = ktime_get_mono_fast_ns();
> @@ -305,12 +307,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
>   	 * head of the waitqueue.
>   	 */
>   	if (old & _Q_TAIL_MASK) {
> +		int val;
> +
>   		prev = decode_tail(old, qnodes);
>   
>   		/* Link @node into the waitqueue. */
>   		WRITE_ONCE(prev->next, node);
>   
> -		arch_mcs_spin_lock_contended(&node->locked);
> +		val = arch_mcs_spin_lock_contended(&node->locked);
> +		if (val == RES_TIMEOUT_VAL) {
> +			ret = -EDEADLK;
> +			goto waitq_timeout;
> +		}
>   
>   		/*
>   		 * While waiting for the MCS lock, the next pointer may have
> @@ -334,7 +342,35 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
>   	 * sequentiality; this is because the set_locked() function below
>   	 * does not imply a full barrier.
>   	 */
> -	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
> +	RES_RESET_TIMEOUT(ts);
> +	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
> +				       RES_CHECK_TIMEOUT(ts, ret));

This has the same wfe problem for arm64.

Cheers,
Longman



