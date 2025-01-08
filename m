Return-Path: <bpf+bounces-48262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE67A062BA
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18942188768E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839661FF7D2;
	Wed,  8 Jan 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZegNKif"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF51FF61B
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355367; cv=none; b=secy3nJYDBOQGD/86gUShJ1zMtIoyRFKUwi5I8pawoI+5YVu8dlub0cW27BUbx3Viwukfhetb1j3YBdnqDpW8mAZ4tsM8HlLaHWnf/ZMpMyxH0W75Z7PPSoo62rANePPnN8jyDz7gyCJjXhzXcFwIgW7UuxQTKUOiLV+TzRIkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355367; c=relaxed/simple;
	bh=gaek6/rfDNAS87zToCwYsxqHnJDE4LNF3nx/aNY5emA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SKQbYoAJQPT+67O49GrBpzqQMwgOdp3dMFwo4b+Nqnxd8DzsZts5tBLoHAzIjHgwRrZ0Sdi5Rkq0P0prCtR4VHyuW2ykzogR3N8f7f34R7P5bMt/jKTXq5zJndo/xmgEB6JKAAdOq/M2m9BP4VsoluWz+Wd3Maf+FUW8iL5Njxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZegNKif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736355363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNULg9GR+H0UN6OwRzomXs+9j51v5/waXF3w/bJmn50=;
	b=WZegNKifJJ/onfc9xBdMRgYv+X9UkiN+gAumGkT5bd9Z7m6PIJLuiqu9o+n9DFjSZ3BmLo
	/ImJvzN9566sKNz0PIb0wExvD6+o6XQYOvyzeRSmr3TkI7C+HbpfSYhhFZubKz5v7DEg1Y
	PSaZpkIs2SkjtT0p+0QcEwsGuvn0bNY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-YAlX_eOHPrGAQctD7Zg5cw-1; Wed, 08 Jan 2025 11:56:02 -0500
X-MC-Unique: YAlX_eOHPrGAQctD7Zg5cw-1
X-Mimecast-MFC-AGG-ID: YAlX_eOHPrGAQctD7Zg5cw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-468f7e0aef7so395563701cf.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 08:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355362; x=1736960162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNULg9GR+H0UN6OwRzomXs+9j51v5/waXF3w/bJmn50=;
        b=HDete09f8szqM6shC09vqO0c/xkMbCglbuNrqMJHYXES76p5bslC+qEO1z3q671gvo
         J4O8N9bdaNr8WB8dfePmd9bdgYQhCCumcMzdgdso5LhZcE+lYlQGbf/zJNOZqkK+tZzf
         ZWqOBjY0jm5CtUDmvDkZn+Ec3C4AUe5vrLY/HWnyYb9OU49WcbW+PVhaEAOXKBlYRA7f
         psM1PAXz7ko5hvDnIM6CkopmbKUmDshq9d9OBigQnEJ0Jnz73atR3mdZM10gCdiCvmEB
         0gIDhxXzZJpOWtuUC3QVbsW7JiqqF4isIQYYr1tnn/edMO1lHSb4Tg1riMkHB3dfDEIe
         jSiA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6hg91vqxkwIg8SKBOOpb3kHLir5o6B+GJdAlq4GK6NPErQ4GpCjI7QQmbv+lgu17gkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Dj4YDR4HKTJltXnCaTYo/XsSWIqhpoG0rXMz3k75SqMb51v+
	XAnrSXKcSoNw10yOLuBVP64hOHKdn0oIJ8YbgROAuLhTvrXM3JRmQHRPJNaJURJz4j9vzqe3Dwd
	XOuuJ095rmZj5vDa4G+miaR4TL1cLu7TqqfyCU2iwtUf2PX33aw==
X-Gm-Gg: ASbGncsCHKy1Y4xbkQUvnq32d8nv23/n4UGTf2vdVnqWaogBLewtYmepqafm4l2bC29
	R2uwSJ7NCs1npC5wznuEN9gD2F6l6UhPfnxOiAy2UkfeGSEDLl89R49AHr/XbJ4nlnXiRqxLtxc
	dgTmKz806Z55Gc4pExTHHzvndZFzjXSbf4uzpstg0vSZSk/cn4kvXv226H/K592RGyv/T2Ns/iN
	m1rWgK7WZFcwGcq/uCKBeJnSBBrJIhQrj5GYoJlIU6hm4m4PY7MEOCMBvUYN8SOAZRYKtijcWbE
	MLDHy9ighzBJA+Fg+0avVgHg
X-Received: by 2002:a05:6214:4890:b0:6d8:889c:54ed with SMTP id 6a1803df08f44-6df9b22e40fmr60727276d6.26.1736355361839;
        Wed, 08 Jan 2025 08:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKxlb69LJtjde+FA6k0Moyy1AEokkuD+Rdn5vPh3zgUiPBZm9f9VEsfn9fmlIKUyTYFNiiCA==
X-Received: by 2002:a05:6214:4890:b0:6d8:889c:54ed with SMTP id 6a1803df08f44-6df9b22e40fmr60726886d6.26.1736355361505;
        Wed, 08 Jan 2025 08:56:01 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18137218sm190461776d6.57.2025.01.08.08.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:56:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com>
Date: Wed, 8 Jan 2025 11:55:59 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock
 usage
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
 <20250107140004.2732830-15-memxor@gmail.com>
Content-Language: en-US
In-Reply-To: <20250107140004.2732830-15-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> Introduce helper macros that wrap around the rqspinlock slow path and
> provide an interface analogous to the raw_spin_lock API. Note that
> in case of error conditions, preemption and IRQ disabling is
> automatically unrolled before returning the error back to the caller.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/asm-generic/rqspinlock.h | 58 ++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index dc436ab01471..53be8426373c 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -12,8 +12,10 @@
>   #include <linux/types.h>
>   #include <vdso/time64.h>
>   #include <linux/percpu.h>
> +#include <asm/qspinlock.h>
>   
>   struct qspinlock;
> +typedef struct qspinlock rqspinlock_t;
>   
>   extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
>   
> @@ -82,4 +84,60 @@ static __always_inline void release_held_lock_entry(void)
>   	this_cpu_dec(rqspinlock_held_locks.cnt);
>   }
>   
> +/**
> + * res_spin_lock - acquire a queued spinlock
> + * @lock: Pointer to queued spinlock structure
> + */
> +static __always_inline int res_spin_lock(rqspinlock_t *lock)
> +{
> +	int val = 0;
> +
> +	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
> +		grab_held_lock_entry(lock);
> +		return 0;
> +	}
> +	return resilient_queued_spin_lock_slowpath(lock, val, RES_DEF_TIMEOUT);
> +}
> +
> +static __always_inline void res_spin_unlock(rqspinlock_t *lock)
> +{
> +	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> +
> +	if (unlikely(rqh->cnt > RES_NR_HELD))
> +		goto unlock;
> +	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> +	/*
> +	 * Release barrier, ensuring ordering. See release_held_lock_entry.
> +	 */
> +unlock:
> +	queued_spin_unlock(lock);
> +	this_cpu_dec(rqspinlock_held_locks.cnt);
> +}
> +
> +#define raw_res_spin_lock_init(lock) ({ *(lock) = (struct qspinlock)__ARCH_SPIN_LOCK_UNLOCKED; })
> +
> +#define raw_res_spin_lock(lock)                    \
> +	({                                         \
> +		int __ret;                         \
> +		preempt_disable();                 \
> +		__ret = res_spin_lock(lock);	   \
> +		if (__ret)                         \
> +			preempt_enable();          \
> +		__ret;                             \
> +	})
> +
> +#define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
> +
> +#define raw_res_spin_lock_irqsave(lock, flags)    \
> +	({                                        \
> +		int __ret;                        \
> +		local_irq_save(flags);            \
> +		__ret = raw_res_spin_lock(lock);  \
> +		if (__ret)                        \
> +			local_irq_restore(flags); \
> +		__ret;                            \
> +	})
> +
> +#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
> +
>   #endif /* __ASM_GENERIC_RQSPINLOCK_H */

Lockdep calls aren't included in the helper functions. That means all 
the *res_spin_lock*() calls will be outside the purview of lockdep. That 
also means a multi-CPU circular locking dependency involving a mixture 
of qspinlocks and rqspinlocks may not be detectable.

Cheers,
Longman


