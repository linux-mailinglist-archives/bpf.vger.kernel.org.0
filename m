Return-Path: <bpf+bounces-75257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 229AFC7BBF7
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B961C35F138
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7211307AC2;
	Fri, 21 Nov 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw/AcWrK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46399533D6;
	Fri, 21 Nov 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760466; cv=none; b=VbcE07WXXM3+nV1EkNoqmjxlqvY2a4s6bN9A2sQXI/Xa/ZEG+bQUaBO2DptH2FtKxYCtbJbPfX+76CQc5I25nzsAUxqUeYhhbo5daEEmp/6HlElVgdb2xRjKt+/F8IXEq01MDDlxG4gPXM5YQ0lNLEE1oORs9WZPYKk1meh62GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760466; c=relaxed/simple;
	bh=HfH2F0h59eoZQ5tjmd4HRor9ZCg51HobUAnM7algTbw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hNdIhvEqRf3uC6OMBsok0GQd/BDQOZnXzIqXyZlAkd/XnymaXEV6MXLbmA1C1FX48vlgVeA8UgVRzmNE9i6WYDPZjKt21PjAZbpnb/QvykhH8bjJpR1V53M13H1EcfpuitLqHKzue5hNAdslsQVsnppsxgh5joowCjOKQ++SI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw/AcWrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF067C4CEF1;
	Fri, 21 Nov 2025 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763760466;
	bh=HfH2F0h59eoZQ5tjmd4HRor9ZCg51HobUAnM7algTbw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Rw/AcWrKnZ/qvQlIfYkp11nHDLkTb00zgKyD6NZHO327FnITRfDO323bumWqcDdtT
	 PAGPSIC6NwtelOuGLZMqJ2IlgzvA4vWclE89hhyKnW4FUz8BOo/Dm7tcDFv+1B6ltg
	 uCx6Zi2+RDfAIi9k+SgSBTJGXlIckVCFF4asvN7tMGLPklvQcc+h/4CXignm8VIwCl
	 Q45ggw4Wus8BiHoowZ/Tst/WxscflxW/sXuBAOzyM06g/zBBXggrEpH5Sa+7X0eAFj
	 rGkrSYy/+edHIGmbttLwb1MEl3cM3WnanriKP9ZcodNRgvD0N2fChpJxyaQeUsxPDf
	 KSfmwZg4/EuMw==
Content-Type: multipart/mixed; boundary="===============2450436810576955457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7c311bb305d985c1a9ea19aef3fcd4094c7e03c600dfba9fc83438b285f5946@mail.kernel.org>
In-Reply-To: <20251121205724.2934650-1-ameryhung@gmail.com>
References: <20251121205724.2934650-1-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] rqspinlock: Annotate rqspinlock lock acquiring functions with __must_check
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,david.laight.linux@gmail.com,dave@stgolabs.net,paulmck@kernel.org,josh@joshtriplett.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Nov 2025 21:27:45 +0000 (UTC)

--===============2450436810576955457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 6d4244d64..855c09435 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h

[ ... ]

> @@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
>   * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
>   * * -ETIMEDOUT - Lock acquisition failed because of timeout.
>   */
> -static __always_inline int res_spin_lock(rqspinlock_t *lock)
> +static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
>  {
>  	int val = 0;
>
> @@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
>  #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
>  #endif
>
> -#define raw_res_spin_lock(lock)                    \
> -	({                                         \
> -		int __ret;                         \
> -		preempt_disable();                 \
> -		__ret = res_spin_lock(lock);	   \
> -		if (__ret)                         \
> -			preempt_enable();          \
> -		__ret;                             \
> -	})
> +static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
> +{
> +	int ret;
> +
> +	preempt_disable();
> +	ret = res_spin_lock(lock);
> +	if (ret)
> +		preempt_enable();
> +
> +	return ret;
> +}
>
>  #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
>
> -#define raw_res_spin_lock_irqsave(lock, flags)    \
> -	({                                        \
> -		int __ret;                        \
> -		local_irq_save(flags);            \
> -		__ret = raw_res_spin_lock(lock);  \
> -		if (__ret)                        \
> -			local_irq_restore(flags); \
> -		__ret;                            \
> -	})
> +static __always_inline __must_check int
> +__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
> +{
> +	unsigned long __flags;
> +	int ret;
> +
> +	local_irq_save(__flags);
> +	ret = raw_res_spin_lock(lock);
> +	if (ret)
> +		local_irq_restore(__flags);
> +
> +	*flags = __flags;
> +	return ret;
> +}
> +
> +#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)

The __must_check annotations will cause compiler warnings in
kernel/locking/locktorture.c where torture_raw_res_spin_write_lock()
and torture_raw_res_spin_write_lock_irq() ignore lock acquisition
failures.

When raw_res_spin_lock() returns an error (deadlock or timeout), the
torture test functions still return 0 to indicate success. The torture
framework then calls the unlock functions, but the lock was never
acquired. In res_spin_unlock(), this causes an out-of-bounds array
access when computing locks[cnt - 1] with cnt=0, potentially corrupting
per-CPU memory.

Should the torture test handle lock acquisition failures, or use
different lock types that cannot fail?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19583558278

--===============2450436810576955457==--

