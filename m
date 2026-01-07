Return-Path: <bpf+bounces-78149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 550EBCFF747
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31817300EA37
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820E33291D;
	Wed,  7 Jan 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFvISZUo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AED1B4223
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810156; cv=none; b=qNNiICf5om1co3n2vCJ/c7M26nhGXkiqK493hHjm8Ti3lYxOC+iyGFPKLVYBe7l3SUQu2hfEQXay8Y6C7/mvRvLP1Q6lmbmKCmnRbCEk7700FfrtRNJ+72zyV+qiKYG1d8PR/DbzYCu8L3AQFvb2Pj/rkWoKnUJXj7kTJ601oSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810156; c=relaxed/simple;
	bh=m1iTDFWznU2Cys2Jealkw99qbGi/W0CBA9H2wry137c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NOKS0762zpA8Kn5+7AYUiEJe45sTW95m1Vs69KCExe087u+r3tSzgQ63gxSmLnst4D7F6MMqB1dm/ZFc3uEpagXKo7OlKQeBP5BIpWQOjMT/NHlqdyTeqjJkeZ4EWxzL1PpxZyqVf9oMcdWpfavMKUAF9CHgEsTFgDZwWUEecMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFvISZUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB842C4CEF1;
	Wed,  7 Jan 2026 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810156;
	bh=m1iTDFWznU2Cys2Jealkw99qbGi/W0CBA9H2wry137c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UFvISZUoZAQicoa458YPxeZmObQ2B94nW9xTSa8OJytSOCCJ6tGZv5U6sQTZ7gHcR
	 xyOV51Sssg3FeUwPxmOuSpwKRuSuc4/LQBCqMQsGQlo8O6ziTwf1fn1+yk7kyRZsNC
	 DA6AADL4VCuU4j5VPEsipfQNoNX91nu4YsaksDbIB44H1P0F+4PncDeLnX28y43il0
	 rBzKDg692veaIDsZpjwBco8dMAyym9a10IHKtT7MZ+BYiLDkCiYZ+PzFJypUKQoNFJ
	 sEXPoT7xllWRQ43KQgJHkmPTSRGBiRdjtIb9oPEREamfre7CH6s0PvrNARzKCzHCwc
	 O2u6xWG0N2p8w==
Content-Type: multipart/mixed; boundary="===============7542137245249880390=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5d511079216cec4be7e3f87ffac426bf4b6b757ed667527d41451aebc73336a@mail.kernel.org>
In-Reply-To: <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
Subject: Re: [PATCH RFC v3 05/10] bpf: Enable bpf timer and workqueue use in NMI
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 18:22:35 +0000 (UTC)

--===============7542137245249880390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dc8ed948321e..b90b005a17e1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, u32 op, u64 nsec, u32 timer_mode)
> +{
> +	struct bpf_mpmc_cell_ctl *ctl = &cb->ctl;
> +	struct bpf_async_cmd *cmd;
> +
> +	cmd = bpf_mpmc_cell_write_begin(ctl);
> +	if (!cmd)
> +		return -EBUSY;
> +
> +	cmd->nsec = nsec;
> +	cmd->mode = timer_mode;
> +	cmd->op = op;
> +
> +	bpf_mpmc_cell_write_commit(ctl);
> +
> +	if (!refcount_inc_not_zero(&cb->refcnt))
> +		return -EBUSY;
> +
> +	irq_work_queue(&cb->worker);
> +
> +	return 0;
> +}

[ ... ]

> -BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
> +BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
>  {
>  	struct bpf_hrtimer *t;
> -	int ret = 0;
> -	enum hrtimer_mode mode;
> +	u32 mode;
>
> -	if (in_nmi())
> -		return -EOPNOTSUPP;
>  	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>  		return -EINVAL;
>
> +	guard(rcu)();
> +
> +	t = async->timer;
> +	if (!t || !t->cb.prog)
> +		return -EINVAL;

[ ... ]

> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> -out:
> -	__bpf_spin_unlock_irqrestore(&timer->lock);
> -	return ret;
> +	return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
>  }

[ ... ]

> @@ -3093,15 +3188,14 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
>  	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
>  	struct bpf_work *w;
>
> -	if (in_nmi())
> -		return -EOPNOTSUPP;
>  	if (flags)
>  		return -EINVAL;
>  	w = READ_ONCE(async->work);
>  	if (!w || !READ_ONCE(w->cb.prog))
>  		return -EINVAL;
>
> -	schedule_work(&w->work);
> +	bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
> +
>  	return 0;
>  }

Should this return the result of bpf_async_schedule_op() instead of
unconditionally returning 0? The new bpf_async_schedule_op() can fail
with -EBUSY (when the mpmc cell write fails or when refcount_inc_not_zero
fails), but this error is silently dropped.

For comparison, bpf_timer_start() does return the result of
bpf_async_schedule_op(). This inconsistency could cause bpf_wq_start()
callers to believe work was successfully scheduled when it was not.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791345842

--===============7542137245249880390==--

