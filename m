Return-Path: <bpf+bounces-78150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06DCFF732
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F145300CCFC
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199C344026;
	Wed,  7 Jan 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkGxOE5r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40A28134C
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810158; cv=none; b=R+2caEuLVOic7M0Yhg/bfCflZHnb2gGpMs2Ig1yFPwlKzJh6dnNcR5dsI3m+JdvdrZQlt3WpedfLN2pPuWXcFvFgg1tfSgQfbfW/5GypCXITTHNMZ5kLJo5IoeLGLZTTPk4ICCiErESAKe2vXvzrLw+UuV73oVEwevyk3fHeNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810158; c=relaxed/simple;
	bh=QiswS6jPmY0/wqvpoU2JHohNeXutpxKwr4R+O2GGgyo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AlwPIhdw7zWGrAD/5hYoC8WgVEH2EjDQtHv3neOEMEEDu1fpmah6Y9MPmsO8Vg1qjvfb5ZLDAFNhwfaYRFjt6D8i2PDMnWRavGvMSXgb9A7s3ObO5mOhFoCgqQcyo0MJzsLqeIbRkzPfuC+tcYLz1Wo+/Jxb8Egz1gG+OPogAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkGxOE5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83176C4CEF1;
	Wed,  7 Jan 2026 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810157;
	bh=QiswS6jPmY0/wqvpoU2JHohNeXutpxKwr4R+O2GGgyo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HkGxOE5rUhSFP3YPGlThKLGSN6cZJ+Q4la5zimMqZtsRMLAOKZF8akfAVVH4SLSwF
	 u5AIuhmlu7LlJf4RpeuCG25C2QGs0NnUffQ4jHqjkUmSmAs0DHUqreGhcJesp+dxjk
	 fkz6pP2syHws25RETYFhnz743wxO2aL6UOJzin+iibIKYdYo0xUxyw4ar7jMVoMUYf
	 jiJEMYPa0jP0tSTqQgSm1GpUZEKrgPulLvEXNYuc+Kp0GS1nXFgdSUPDPPUObD2piT
	 srspFmesCDuMR+lEoZaafnD5uh/SmrBmuMKc3qlIaRfAXrJFCoP3thwQ7rMnFX4hnd
	 H6dxUxBF+/sTQ==
Content-Type: multipart/mixed; boundary="===============0284102991959556445=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de0af4dceddabe72f6a329980dc36e0bd045024eca617b489c6634afab7b85cd@mail.kernel.org>
In-Reply-To: <20260107-timer_nolock-v3-3-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-3-740d3ec3e5f9@meta.com>
Subject: Re: [PATCH RFC v3 03/10] bpf: Simplify bpf_timer_cancel()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 18:22:37 +0000 (UTC)

--===============0284102991959556445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index ff3c1e1160db..dc8ed948321e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -1454,13 +1454,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
>
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	rcu_read_lock();
> -	__bpf_spin_lock_irqsave(&timer->lock);
> -	t = timer->timer;
> -	if (!t) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +
> +	guard(rcu)();
> +
> +	t = async->timer;
> +	if (!t)
> +		return -EINVAL;

[ ... ]

> @@ -1492,20 +1490,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
>  		 * cancelling and waiting for it synchronously, since it might
>  		 * do the same. Bail!
>  		 */
> -		ret = -EDEADLK;
> -		goto out;
> +		atomic_dec(&t->cancelling);
> +		return -EDEADLK;
>  	}
> +
>  drop:
> -	drop_prog_refcnt(&t->cb);
> -out:
> -	__bpf_spin_unlock_irqrestore(&timer->lock);
> +	__bpf_async_set_callback(async, NULL, NULL);

With the lock removed here, can bpf_timer_cancel() race with
__bpf_async_cancel_and_free()? The concern is that both paths can
attempt to drop the prog reference:

  bpf_timer_cancel():
    __bpf_async_set_callback(async, NULL, NULL)
      -> prev = xchg(&cb->prog, NULL)
      -> bpf_prog_put(prev)

  __bpf_async_cancel_and_free():
    -> drop_prog_refcnt(cb)
      -> prog = cb->prog  (plain read)
      -> bpf_prog_put(prog)

The xchg in __bpf_async_set_callback() is atomic, but drop_prog_refcnt()
uses a plain read of cb->prog. If drop_prog_refcnt() reads cb->prog
before the xchg sets it to NULL, both paths would call bpf_prog_put() on
the same program, leading to a double put of the reference count.

Note: This appears to be addressed later in the series by commit
0035985a0a23 ("bpf: Enable bpf timer and workqueue use in NMI") which
moves bpf_prog_put() to the RCU callback, but the race window exists in
this intermediate commit.

>  	/* Cancel the timer and wait for associated callback to finish
>  	 * if it was running.
>  	 */
> -	ret = ret ?: hrtimer_cancel(&t->timer);
> +	ret = hrtimer_cancel(&t->timer);
> +
>  	if (inc)
>  		atomic_dec(&t->cancelling);
> -	rcu_read_unlock();
>  	return ret;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791345842

--===============0284102991959556445==--

