Return-Path: <bpf+bounces-48323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F7A06A1F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03E2163C81
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4FE79F5;
	Thu,  9 Jan 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXJLAqSZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FC23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736385110; cv=none; b=ZkzDtt49qx0A1asIN+marfJ3h5IIQkNbGuBhqeyPudy+QtWLpEoK2BsUYYaV+sdp1fcwfLkk3Kgi2cI32YkrXd06i/JnUrFBZ3d2/3SIVBDE9CQHG1h2NqDJkU3XTBr5i1ZQLHikEeYIpT/CGfO/0FJHO69hjjfJ/4xX3I8zL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736385110; c=relaxed/simple;
	bh=KlvBf1FrhFGCCcFrc7zOewB1sfa8xZSr9nHWHmBK5VQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FfHj6iWKmtG3e0kyPIlT3oYNg8XJBmsdLH+n7VSb50F+dP/bGIAQqVOKvdLYgufQfKMeJMcXV8reCxT5L77yqShl5G7I2b+Het6ohbOtphruRjRQ1u0J2c0ZglA6agaH/jfTywBTngA9YX26pvn2mjTtWfKNhmMaQosLNXds7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXJLAqSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736385107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQw4K3Yc9BRWZl2w8p3MZelmZaMS5AIr1exgtde5ayc=;
	b=OXJLAqSZoHZEn94kPTdTcJsTwcKJ3c7yJNnnRj1Q8ytFHPiyLgDweseQ54pceVq/SGXjd0
	OCExNgM+M1p+fXdn6FBemGIQXfEKefxRVcFmjeLOOzFcVQYoVHiJUTXbaRsa4agAkKVJuY
	3x1DZ9/ok1VVjkDSn7T83WQbHLFCaBY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-rTex4p0NOeaZ8D7_GV1tMw-1; Wed, 08 Jan 2025 20:11:46 -0500
X-MC-Unique: rTex4p0NOeaZ8D7_GV1tMw-1
X-Mimecast-MFC-AGG-ID: rTex4p0NOeaZ8D7_GV1tMw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6dcccc8b035so7044036d6.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 17:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736385106; x=1736989906;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQw4K3Yc9BRWZl2w8p3MZelmZaMS5AIr1exgtde5ayc=;
        b=fUpCdCQR/dWLjAFtNoZu5PYH9zwHK/lC6GsKZNSEodXcB00x9p+7dt2pOdbVL0OxJp
         gfKESW99Y+NLnuaELbVqgbDf8ADOZrYHtTKTy3YKefiVnALPdDKtarFDR+TWsxWDYkrN
         A6q+LRgWpIWsxF6rhvASX+ehSyfqc1fZY4vGtYfuxhBuOupM6QIms9jd8i3MEm/VDpgV
         FF/NQAcuXiNURHmdU6mdiaX2ng81nKNwhCO1r9r2Gzrf0qBHe+ouvdBA27qGkhOGCdqZ
         wWKHJxy73ugAGqOmHBXkgvpoISsne/nh1OutKM3usX1rAdtI01TeF/jPW0Cp9DeFcowS
         RT5Q==
X-Gm-Message-State: AOJu0YymPN1AOT+h4FO+BTpW9lonmNEw+QO0zFn5yzVEBeo/7Z2M5Qni
	Ju9LElOk4RwIVl0zxgbPnnja29jvsZHoDyRNcD0ayLXCAvK36NpTSO586WEFcs8/triZPBaNL42
	br/ydvCDu+7+IVN1rNIes6/e3Kn2psA4dVc5MGXlr4ToB+IN9hg==
X-Gm-Gg: ASbGnctqn0WqQCmCtFdZLnC1QTWllnxAU6Uul5yWIj/CLcgiznB9EB79TF7J3YRXvy7
	TKh866PNAoU7BDCZiIjfherTQ8aeZLPk3UanrG//B70oqvYQu2QdN4djCJ1LXYu1qRnPcu89u1Q
	qKx602OEL10ECelg7kj3Lu07gBvwMWzi7nSqSYEEvFUgNQpR8SmRpvSgQF5c6jeA8RnD8bZg04s
	Pr/yH8j3a3jTahASe2+XbaLGyOECpfVnuIpYfqaqHYJDaZaHiLBb5mVv3Vh83Rijvvx139ikGHR
	6jEqVSZKJ1k4R8WbBOxN1qAU
X-Received: by 2002:a05:6214:62c:b0:6df:9ab9:5c56 with SMTP id 6a1803df08f44-6dfa3a25394mr28209286d6.12.1736385105799;
        Wed, 08 Jan 2025 17:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe7lHCZNyrteHIdQ0Ut9KpFQ2MwjD/iKM2aJgRbZo0sHSq6uw1jKnbC5zG6fY5m0UpoS0rMA==
X-Received: by 2002:a05:6214:62c:b0:6df:9ab9:5c56 with SMTP id 6a1803df08f44-6dfa3a25394mr28208766d6.12.1736385105457;
        Wed, 08 Jan 2025 17:11:45 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d574dsm195452106d6.118.2025.01.08.17.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 17:11:44 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2ff3a68c-1328-4b47-a4aa-0365b3f1809b@redhat.com>
Date: Wed, 8 Jan 2025 20:11:43 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock
 usage
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-15-memxor@gmail.com>
 <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com>
 <CAP01T77QD_pYBVS4PfG3jDeXObKHZJkV2nQX+0njv11oKTEqRA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP01T77QD_pYBVS4PfG3jDeXObKHZJkV2nQX+0njv11oKTEqRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 3:41 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Jan 2025 at 22:26, Waiman Long <llong@redhat.com> wrote:
>> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
>>> Introduce helper macros that wrap around the rqspinlock slow path and
>>> provide an interface analogous to the raw_spin_lock API. Note that
>>> in case of error conditions, preemption and IRQ disabling is
>>> automatically unrolled before returning the error back to the caller.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---
>>>    include/asm-generic/rqspinlock.h | 58 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 58 insertions(+)
>>>
>>> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
>>> index dc436ab01471..53be8426373c 100644
>>> --- a/include/asm-generic/rqspinlock.h
>>> +++ b/include/asm-generic/rqspinlock.h
>>> @@ -12,8 +12,10 @@
>>>    #include <linux/types.h>
>>>    #include <vdso/time64.h>
>>>    #include <linux/percpu.h>
>>> +#include <asm/qspinlock.h>
>>>
>>>    struct qspinlock;
>>> +typedef struct qspinlock rqspinlock_t;
>>>
>>>    extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
>>>
>>> @@ -82,4 +84,60 @@ static __always_inline void release_held_lock_entry(void)
>>>        this_cpu_dec(rqspinlock_held_locks.cnt);
>>>    }
>>>
>>> +/**
>>> + * res_spin_lock - acquire a queued spinlock
>>> + * @lock: Pointer to queued spinlock structure
>>> + */
>>> +static __always_inline int res_spin_lock(rqspinlock_t *lock)
>>> +{
>>> +     int val = 0;
>>> +
>>> +     if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
>>> +             grab_held_lock_entry(lock);
>>> +             return 0;
>>> +     }
>>> +     return resilient_queued_spin_lock_slowpath(lock, val, RES_DEF_TIMEOUT);
>>> +}
>>> +
>>> +static __always_inline void res_spin_unlock(rqspinlock_t *lock)
>>> +{
>>> +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
>>> +
>>> +     if (unlikely(rqh->cnt > RES_NR_HELD))
>>> +             goto unlock;
>>> +     WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
>>> +     /*
>>> +      * Release barrier, ensuring ordering. See release_held_lock_entry.
>>> +      */
>>> +unlock:
>>> +     queued_spin_unlock(lock);
>>> +     this_cpu_dec(rqspinlock_held_locks.cnt);
>>> +}
>>> +
>>> +#define raw_res_spin_lock_init(lock) ({ *(lock) = (struct qspinlock)__ARCH_SPIN_LOCK_UNLOCKED; })
>>> +
>>> +#define raw_res_spin_lock(lock)                    \
>>> +     ({                                         \
>>> +             int __ret;                         \
>>> +             preempt_disable();                 \
>>> +             __ret = res_spin_lock(lock);       \
>>> +             if (__ret)                         \
>>> +                     preempt_enable();          \
>>> +             __ret;                             \
>>> +     })
>>> +
>>> +#define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
>>> +
>>> +#define raw_res_spin_lock_irqsave(lock, flags)    \
>>> +     ({                                        \
>>> +             int __ret;                        \
>>> +             local_irq_save(flags);            \
>>> +             __ret = raw_res_spin_lock(lock);  \
>>> +             if (__ret)                        \
>>> +                     local_irq_restore(flags); \
>>> +             __ret;                            \
>>> +     })
>>> +
>>> +#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
>>> +
>>>    #endif /* __ASM_GENERIC_RQSPINLOCK_H */
>> Lockdep calls aren't included in the helper functions. That means all
>> the *res_spin_lock*() calls will be outside the purview of lockdep. That
>> also means a multi-CPU circular locking dependency involving a mixture
>> of qspinlocks and rqspinlocks may not be detectable.
> Yes, this is true, but I am not sure whether lockdep fits well in this
> case, or how to map its semantics.
> Some BPF users (e.g. in patch 17) expect and rely on rqspinlock to
> return errors on AA deadlocks, as nesting is possible, so we'll get
> false alarms with it. Lockdep also needs to treat rqspinlock as a
> trylock, since it's essentially fallible, and IIUC it skips diagnosing
> in those cases.
Yes, we can certainly treat rqspinlock as a trylock.

> Most of the users use rqspinlock because it is expected a deadlock may
> be constructed at runtime (either due to BPF programs or by attaching
> programs to the kernel), so lockdep splats will not be helpful on
> debug kernels.

In most cases, lockdep will report a cyclic locking dependency 
(potential deadlock) before a real deadlock happens as it requires the 
right combination of events happening in a specific sequence. So lockdep 
can report a deadlock while the runtime check of rqspinlock may not see 
it and there is no locking stall. Also rqspinlock will not see the other 
locks held in the current context.


> Say if a mix of both qspinlock and rqspinlock were involved in an ABBA
> situation, as long as rqspinlock is being acquired on one of the
> threads, it will still timeout even if check_deadlock fails to
> establish presence of a deadlock. This will mean the qspinlock call on
> the other side will make progress as long as the kernel unwinds locks
> correctly on failures (by handling rqspinlock errors and releasing
> held locks on the way out).

That is true only if the latest lock to be acquired is a rqspinlock. If 
all the rqspinlocks in the circular path have already been acquired, no 
unwinding is possible.

That is probably not an issue with the limited rqspinlock conversion in 
this patch series. In the future when more and more locks are converted 
to use rqspinlock, this scenario may happen.

Cheers,
Longman


