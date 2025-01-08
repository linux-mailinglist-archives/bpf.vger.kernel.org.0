Return-Path: <bpf+bounces-48258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD1A06118
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D1E1884385
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27C1FE475;
	Wed,  8 Jan 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRLf+zhE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B31F9F62
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352393; cv=none; b=HA+G/pt4kh00XYaK7e2QDLNNz8pNxsN6QNtmDKTTjecoVEjbQWl2nW36pDze0HStJaT7tS2r8MrczZBkQ6nJ548KKKXUHSNRQxxVfK7nhjAbMLew3Oyq5gmrHN76Jv+Bisj+bUWD5eRx9coG8HJN2+7Ty10KW5mlLL1USgAHptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352393; c=relaxed/simple;
	bh=FH6r4pFMQM5Wy0jEh/gM7S6YsD/UAmFaLrVtkE9RuTc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jc26K9DoeCfUuGlNAxroS2DEEV+I/tGk7mVPhmT4oXFMIUqI9DIJFWBZdIlTySdCBU/fNl4kBI/ceno6GOo/ZEnOhFRZ6pgT9tJgyL8xr7cffFWf6ESe35XIvF9eKvhkvzV7NoBW5utwgh8ovYIbrc/4HI5OK5X97Z227zi5Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRLf+zhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736352391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MyaIZ6xCFLBFfptJbV+mxyfy0bGuo+f54thxYpbNWDQ=;
	b=iRLf+zhEyMrIvaE+AYal0E30DblS4g8o8zddxvPIQf9x6ssEdOq16G8/U7tmlcV1zvyNTd
	GgcL20KRFQQrptIQRCNRkDVMag1blpPrxgR+2rjOSPm9QJFQoIfGys4SPxtxFnsHkjaq6U
	pO195NX7yputVmWGmbEX7GdySImPEDM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-HBw05m1aNUuaFRARTfcTzA-1; Wed, 08 Jan 2025 11:06:29 -0500
X-MC-Unique: HBw05m1aNUuaFRARTfcTzA-1
X-Mimecast-MFC-AGG-ID: HBw05m1aNUuaFRARTfcTzA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8860ab00dso40976d6.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 08:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352389; x=1736957189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyaIZ6xCFLBFfptJbV+mxyfy0bGuo+f54thxYpbNWDQ=;
        b=pLOboP7mlnQTEfXRep6VwcXY6AkgFJamR+hf5OHcq4jtkaCidwOXxwI81ePDefwPMm
         nmO3FMSpkW48+qRyDY6o/JTMrp3hI4dYymSSrxP7uW8Q8f3zLInAC/rJgN+pJo1mPzxO
         ziZ06Dxs4PJ2c5bsTPVvw4YTi4bg0u2orXownsdfCeVSoslg0p5+uvH49dHV9Ue3GPNm
         3w4wBl9wPH9tYPzcuqfdjeFjzhC5XZMnUljy7HxL+p74C4Jcrewb5ZZC2HCDrJT52ajL
         RN3o+AMVEQFfvyg4jBkYJaM5Ah8Tj5kUtEEPTBespGEANgm5QcjYTy+Vz1y4BU5I47H9
         MGQw==
X-Forwarded-Encrypted: i=1; AJvYcCXKh3qmvcOSRfcZ/t6fWKnit2NR1aeOi2mM43c2LZnlqQWKmFhLHWDCc1KHnFYyulIpmPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMiuz/RM9iGIJfBtFdnQj+4wAZ5CkYT+B+f+FYBYr8Z6mio5Q9
	h5qbkTERUQ382MWBFiY1Vi1QXhpYvRuxDnDTE7G8Sng9SfDcPvoRUUWO0gxqwvyG//hMjGK4Q2C
	0vGgWyINVolQpQnSR0LB0Huy/DGjOzGFoC4nkPMc4U+eAxu7Bdg==
X-Gm-Gg: ASbGncs9idSCAPF8Hnm7hVK2oABeilyV5P86DKS6nJC7g/AiOm7XxavI2C4PWe89ycQ
	CXB2AnzWKmHFCFTvtnMETUOcALIv+5rVjlS2/9E4G7BlJ5NqbF4pYjB/Zg1REtz0wnyPDPQ5gFY
	3rhG+jd9CncjGej2N+AOg4OF113WM4i+mHH0R6bmGPCuNbNdtBn+sA0qouvlC56P9FqQkaYUQMZ
	/oWxGvdYUWPNBuN31gZ4HrE4Pln7dvVt5SPPK6WxrDXyjdsDKZqAOXoOxh6yTqalw3ZalYoAmkS
	jqs8jPSv6tDFp+EIv3IiR9pa
X-Received: by 2002:a05:6214:c6c:b0:6d4:36ff:4358 with SMTP id 6a1803df08f44-6df9b27c43dmr66212316d6.25.1736352389082;
        Wed, 08 Jan 2025 08:06:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCQwJQQj1g1X6bOvCTqHRvr2yTLnAeaFpSI+90zqAZeVWi5aOW9MJ/lZfFyUDZM4L2sDZRZA==
X-Received: by 2002:a05:6214:c6c:b0:6d4:36ff:4358 with SMTP id 6a1803df08f44-6df9b27c43dmr66211746d6.25.1736352388690;
        Wed, 08 Jan 2025 08:06:28 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d432asm191421616d6.110.2025.01.08.08.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:06:28 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2402fa3e-bd43-47a5-ab8c-bd05877831ff@redhat.com>
Date: Wed, 8 Jan 2025 11:06:26 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 11/22] rqspinlock: Add deadlock detection and
 recovery
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-12-memxor@gmail.com>
Content-Language: en-US
In-Reply-To: <20250107140004.2732830-12-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> While the timeout logic provides guarantees for the waiter's forward
> progress, the time until a stalling waiter unblocks can still be long.
> The default timeout of 1/2 sec can be excessively long for some use
> cases.  Additionally, custom timeouts may exacerbate recovery time.
>
> Introduce logic to detect common cases of deadlocks and perform quicker
> recovery. This is done by dividing the time from entry into the locking
> slow path until the timeout into intervals of 1 ms. Then, after each
> interval elapses, deadlock detection is performed, while also polling
> the lock word to ensure we can quickly break out of the detection logic
> and proceed with lock acquisition.
>
> A 'held_locks' table is maintained per-CPU where the entry at the bottom
> denotes a lock being waited for or already taken. Entries coming before
> it denote locks that are already held. The current CPU's table can thus
> be looked at to detect AA deadlocks. The tables from other CPUs can be
> looked at to discover ABBA situations. Finally, when a matching entry
> for the lock being taken on the current CPU is found on some other CPU,
> a deadlock situation is detected. This function can take a long time,
> therefore the lock word is constantly polled in each loop iteration to
> ensure we can preempt detection and proceed with lock acquisition, using
> the is_lock_released check.
>
> We set 'spin' member of rqspinlock_timeout struct to 0 to trigger
> deadlock checks immediately to perform faster recovery.
>
> Note: Extending lock word size by 4 bytes to record owner CPU can allow
> faster detection for ABBA. It is typically the owner which participates
> in a ABBA situation. However, to keep compatibility with existing lock
> words in the kernel (struct qspinlock), and given deadlocks are a rare
> event triggered by bugs, we choose to favor compatibility over faster
> detection.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/asm-generic/rqspinlock.h |  56 +++++++++-
>   kernel/locking/rqspinlock.c      | 178 ++++++++++++++++++++++++++++---
>   2 files changed, 220 insertions(+), 14 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 5c996a82e75f..c7e33ccc57a6 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -11,14 +11,68 @@
>   
>   #include <linux/types.h>
>   #include <vdso/time64.h>
> +#include <linux/percpu.h>
>   
>   struct qspinlock;
>   
> +extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> +
>   /*
>    * Default timeout for waiting loops is 0.5 seconds
>    */
>   #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
>   
> -extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> +#define RES_NR_HELD 32
> +
> +struct rqspinlock_held {
> +	int cnt;
> +	void *locks[RES_NR_HELD];
> +};
> +
> +DECLARE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
> +
> +static __always_inline void grab_held_lock_entry(void *lock)
> +{
> +	int cnt = this_cpu_inc_return(rqspinlock_held_locks.cnt);
> +
> +	if (unlikely(cnt > RES_NR_HELD)) {
> +		/* Still keep the inc so we decrement later. */
> +		return;
> +	}
> +
> +	/*
> +	 * Implied compiler barrier in per-CPU operations; otherwise we can have
> +	 * the compiler reorder inc with write to table, allowing interrupts to
> +	 * overwrite and erase our write to the table (as on interrupt exit it
> +	 * will be reset to NULL).
> +	 */
> +	this_cpu_write(rqspinlock_held_locks.locks[cnt - 1], lock);
> +}
> +
> +/*
> + * It is possible to run into misdetection scenarios of AA deadlocks on the same
> + * CPU, and missed ABBA deadlocks on remote CPUs when this function pops entries
> + * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The correct
> + * logic to preserve right entries in the table would be to walk the array of
> + * held locks and swap and clear out-of-order entries, but that's too
> + * complicated and we don't have a compelling use case for out of order unlocking.
Maybe we can pass in the lock and print a warning if out-of-order unlock 
is being done.
> + *
> + * Therefore, we simply don't support such cases and keep the logic simple here.
> + */
> +static __always_inline void release_held_lock_entry(void)
> +{
> +	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> +
> +	if (unlikely(rqh->cnt > RES_NR_HELD))
> +		goto dec;
> +	smp_store_release(&rqh->locks[rqh->cnt - 1], NULL);
> +	/*
> +	 * Overwrite of NULL should appear before our decrement of the count to
> +	 * other CPUs, otherwise we have the issue of a stale non-NULL entry being
> +	 * visible in the array, leading to misdetection during deadlock detection.
> +	 */
> +dec:
> +	this_cpu_dec(rqspinlock_held_locks.cnt);
AFAIU, smp_store_release() only guarantees memory ordering before it, 
not after. That shouldn't be a problem if the decrement is observed 
before clearing the entry as that non-NULL entry won't be checked anyway.
> +}
>   
>   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
> diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> index b63f92bd43b1..b7c86127d288 100644
> --- a/kernel/locking/rqspinlock.c
> +++ b/kernel/locking/rqspinlock.c
> @@ -30,6 +30,7 @@
>    * Include queued spinlock definitions and statistics code
>    */
>   #include "qspinlock.h"
> +#include "rqspinlock.h"
>   #include "qspinlock_stat.h"
>   
>   /*
> @@ -74,16 +75,141 @@
>   struct rqspinlock_timeout {
>   	u64 timeout_end;
>   	u64 duration;
> +	u64 cur;
>   	u16 spin;
>   };
>   
>   #define RES_TIMEOUT_VAL	2
>   
> -static noinline int check_timeout(struct rqspinlock_timeout *ts)
> +DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
> +
> +static bool is_lock_released(struct qspinlock *lock, u32 mask, struct rqspinlock_timeout *ts)
> +{
> +	if (!(atomic_read_acquire(&lock->val) & (mask)))
> +		return true;
> +	return false;
> +}
> +
> +static noinline int check_deadlock_AA(struct qspinlock *lock, u32 mask,
> +				      struct rqspinlock_timeout *ts)
> +{
> +	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> +	int cnt = min(RES_NR_HELD, rqh->cnt);
> +
> +	/*
> +	 * Return an error if we hold the lock we are attempting to acquire.
> +	 * We'll iterate over max 32 locks; no need to do is_lock_released.
> +	 */
> +	for (int i = 0; i < cnt - 1; i++) {
> +		if (rqh->locks[i] == lock)
> +			return -EDEADLK;
> +	}
> +	return 0;
> +}
> +
> +static noinline int check_deadlock_ABBA(struct qspinlock *lock, u32 mask,
> +					struct rqspinlock_timeout *ts)
> +{

I think you should note that the ABBA check here is not exhaustive. It 
is just the most common case and there are corner cases that will be missed.

Cheers,
Longman


