Return-Path: <bpf+bounces-78958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A39D20EAE
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33F953002975
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195933B6C8;
	Wed, 14 Jan 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn7E5lPV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A48296BB7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416912; cv=none; b=s9G7i0Hp0PkBS4f+a90yhCRR/8b/XNhuS2PZHTVY8F/uSeiA05Mu0r2Vgl0iWxZTBLTYrL3uKCI2H66/03uCcmK4VwnyrYyWz7PfrCa2GWKQEFGmKRx8cj+ppqOR6PGvHaLpluPlk9sxtjrp6hcWDiXQJ5a8G3LxIqfUOlXJKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416912; c=relaxed/simple;
	bh=lrMuxEmEOAPml75g9l13B3IlwvfskA2PbwhA9osSBao=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hnTjNciO6GRQeWKUked/TEa57YDhESjpI3jKAK4zEB8vOrELbCXba/Rc2Qq+dIVeO+bLfKFfbB/qkfsQRwbjqvk/5NYaslOW/oGpxT6hjS/t2m29LPe91IZIGLmMgY+X2lxJj/FfRJkyyg+L6yfmmcpvjuJ2Xu/+YtP8J27sLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn7E5lPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588AFC4CEF7;
	Wed, 14 Jan 2026 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768416911;
	bh=lrMuxEmEOAPml75g9l13B3IlwvfskA2PbwhA9osSBao=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Bn7E5lPVh2OCUolDPrpDsYHu8AvkulkyFvtT9djJ0yDcL0UMnYUEleD7DwTRbg/Ql
	 4Nuw/WeeNYBoSm9BAewFJAsNivyRF9uiDjfdn4dDZKf+FZIXvM9qKBbEyEfOyC0+/w
	 7fRplWZFHKWjqsYCEPi8/8nf3D/ue+5ykJtky77wS+Zmos96TvpSX7Ag3oHYQGKFEj
	 OYnHjNztEIqKw40GjYPPkUD4dBQh844NtdrpVo55Mt6ZGReMT3E6wFvvEd8+U64J14
	 m57vqrms+bWH/S6O+9bOlsUf49VT7N70dfsvihCrvn2F7NB04hx9pZkHp4V97n++uj
	 Px/CbDm8xJAHQ==
Content-Type: multipart/mixed; boundary="===============9038223778138949013=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <119c4e576c4a9f7c4302c1f903877ad8e82e1ec7a321fcfb9763c76042ee6f5e@mail.kernel.org>
In-Reply-To: <20260114-timer_nolock-v4-3-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-3-fa6355f51fa7@meta.com>
Subject: Re: [PATCH RFC v4 3/8] bpf: Enable bpf timer and workqueue use in NMI
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 14 Jan 2026 18:55:11 +0000 (UTC)

--===============9038223778138949013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 19ca6e772165..b5d6938d2382 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
> +				    struct bpf_prog *prog)
>  {
> -	struct bpf_prog *prev, *prog = aux->prog;
> +	struct bpf_prog *prev;
>  	struct bpf_async_cb *cb;
> -	int ret = 0;
>
> -	if (in_nmi())
> -		return -EOPNOTSUPP;
> -	__bpf_spin_lock_irqsave(&async->lock);
> -	cb = async->cb;
> -	if (!cb) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -	if (!atomic64_read(&cb->map->usercnt)) {
> -		/* maps with timers must be either held by user space
> -		 * or pinned in bpffs. Otherwise timer might still be
> -		 * running even when bpf prog is detached and user space
> -		 * is gone, since map_release_uref won't ever be called.
> -		 */
> -		ret = -EPERM;
> -		goto out;
> -	}
> -	prev = cb->prog;
> -	if (prev != prog) {
> -		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> -		 * can pick different callback_fn-s within the same prog.
> -		 */
> +	/* Make sure bpf_async_cb_rcu_free() is not called while here */
> +	guard(rcu)();
> +
> +	cb = READ_ONCE(async->cb);
> +	if (!cb || !prog)
> +		return -EINVAL;
> +
> +	/* Additional prog's refcnt to make sure it is not dropped to 0 in the loop */
> +	prog = bpf_prog_inc_not_zero(prog);
> +	if (IS_ERR(prog))
> +		return PTR_ERR(prog);
> +
> +	do {
>  		prog = bpf_prog_inc_not_zero(prog);
> -		if (IS_ERR(prog)) {
> -			ret = PTR_ERR(prog);
> -			goto out;
> -		}
> +		prev = xchg(&cb->prog, prog);
> +		rcu_assign_pointer(cb->callback_fn, callback_fn);
> +
>  		if (prev)
> -			/* Drop prev prog refcnt when swapping with new prog */
>  			bpf_prog_put(prev);
> -		cb->prog = prog;
> -	}
> -	rcu_assign_pointer(cb->callback_fn, callback_fn);
> -out:
> -	__bpf_spin_unlock_irqrestore(&async->lock);
> -	return ret;
> +
> +	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
> +
> +	bpf_prog_put(prog);
> +
> +	return 0;
>  }

Can this loop leak BPF program references? If the loop iterates more
than once due to concurrent modification, each iteration calls
bpf_prog_inc_not_zero(prog) which increments the reference count. The
bpf_prog_put(prev) only releases the old cb->prog reference, not the
accumulated references on prog.

For example, if the loop runs twice:
  - iter 1: bpf_prog_inc_not_zero(prog) increments refcnt
  - iter 1: xchg stores prog in cb->prog, bpf_prog_put(prev) puts old value
  - (concurrent modification changes cb->prog)
  - iter 2: bpf_prog_inc_not_zero(prog) increments refcnt again
  - iter 2: xchg stores prog, bpf_prog_put(prev) puts concurrently stored value
  - after loop: bpf_prog_put(prog) releases only one reference

The commit message states "ensuring that get/put are balanced, as each
iteration has both inc/dec", but the dec (bpf_prog_put) operates on prev,
not on prog. When prev is a different object than prog, the reference
taken on prog in that iteration is never released.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21005624319

--===============9038223778138949013==--

