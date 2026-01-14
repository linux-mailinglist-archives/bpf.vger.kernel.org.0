Return-Path: <bpf+bounces-78957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D53D20DF1
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7920230390C2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB633A039;
	Wed, 14 Jan 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l66+eE7b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5523396E1
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416293; cv=none; b=XoHBDuXumZXJYEXeIowhO+SrPhYcdV+PTH90KRyF7hXBuSsRlLj7JvpXIocCDZz3cX5ATyiSdoeI/XC87o3ph1ndICu45thMc0xicEH+4uGWHVjk86ap6SnOsbap+kGqKg/1al8Cp2pswO6Y/Xx2akY4EC7kSngXSdyNap7xzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416293; c=relaxed/simple;
	bh=ZrrpT8VNTwsKeOvsCAIqyhJwjnB88We7bJWkARgEtYs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RPWyVeOe0+Jwyrb1PuajXxcshbrh2c1d2gvX02Th1our1xar1fpmWK+tE5ecYS6fQOjUuu6TmekBDnyQTpWfDbd9CzfrMw9LlCsparo2nFIjngaOQPaYcbj4+5jjpLQusu3CcQJpYBUF7shKrJobpwzO4tiV6iYxYQIWv+JJZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l66+eE7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E49C4CEF7;
	Wed, 14 Jan 2026 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768416292;
	bh=ZrrpT8VNTwsKeOvsCAIqyhJwjnB88We7bJWkARgEtYs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l66+eE7bqyHcuEhHWCH+5cfnxm39niuatsdTXGpJXz3MfdoXn8zXi/f0MC8TTWaBo
	 z2/2hzsI7p4MYcOjM4sutoBgChuJrsd7GP9igZCKn7s9zaGBpTACu/pVldDfRCMrV4
	 F/iVvmLf+HjzaHN49FBHxqsoX+59mlpccKEfPWyI4ThtmSAe4mHaa3aEeIzMNbjD8G
	 gP4DbGTLE8eIV+yd0zjydz2wMUTXNEWbWgrC1/6krPiMiQhYP/BNxK8CPP7lgVCZvu
	 hlBV66QHdnM9t9ok1DseM0MH+x9b2utv2PCFR1goWFr5yEqo6usR4NpxToI0s3VvUf
	 LDPjlMzu9BaxA==
Content-Type: multipart/mixed; boundary="===============8652057683568433552=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0dd8bb1add0c91fc23f97e81374af742c6f52752a20b78191f30aaf7a0404b3f@mail.kernel.org>
In-Reply-To: <20260114-timer_nolock-v4-2-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-2-fa6355f51fa7@meta.com>
Subject: Re: [PATCH RFC v4 2/8] bpf: Simplify bpf_timer_cancel()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 18:44:52 +0000 (UTC)

--===============8652057683568433552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cbacddc7101a..19ca6e772165 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -1511,20 +1509,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, timer)
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
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does this call __bpf_async_set_callback() with only 3 arguments when the
function signature requires 5?

Looking at __bpf_async_set_callback() defined earlier in the same file:

  static int __bpf_async_set_callback(struct bpf_async_kern *async,
                                      void *callback_fn,
                                      struct bpf_prog_aux *aux,
                                      unsigned int flags,
                                      enum bpf_async_type type)
  {
      struct bpf_prog *prev, *prog = aux->prog;
      ...
  }

The call passes (async, NULL, NULL) where aux=NULL, but the first line
of the function dereferences aux->prog which would crash. The old code
called drop_prog_refcnt(&t->cb) instead which is a 1-argument function
that safely handles the callback cleanup.

This appears to be a bisection-breaking regression. A fix appears later
in the series at commit 250c67a454a9 ("bpf: Enable bpf timer and workqueue
use in NMI") which changes __bpf_async_set_callback() to take 3 arguments,
but until that patch is applied this commit would cause a NULL pointer
dereference whenever bpf_timer_cancel() reaches the drop label.

>  	/* Cancel the timer and wait for associated callback to finish
>  	 * if it was running.
>  	 */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21005624319

--===============8652057683568433552==--

