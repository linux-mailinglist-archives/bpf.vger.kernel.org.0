Return-Path: <bpf+bounces-78151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFFFCFF753
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63540300750A
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E753451C8;
	Wed,  7 Jan 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDWHHmnn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9161B4223
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810159; cv=none; b=sx8nadRNQ2gS9F/T0dqm66Xv+r750NTxDgwd+AbFgyj0BvMfFMv6bGFW+ZOqYNdcEiZ7tea4T7O0utjhRvdZJ9YU+lWkXNI5kZtWyVdDNhsw3tdLaJiRSBjUkDd90cEQyhhemZZeOwv2Uu7LqP/Tk2WCnoZ2lv9kneT8U4JJjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810159; c=relaxed/simple;
	bh=YFSNAO19OLcGvuybRg2d3pnOrcRU6lUigg5sdpXOUp4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QZvy/6f58OyL8vBaUQcbNRyljPFSOEpktaTX5goXDOjsM49zH/R1a1b1I4bFcrV6SZIZFFZ/LuiVDR6/VbhiPDciERVj8QSeGVB1c+TqEFqY7PhTwqL9opGp0EUdrfc7som41RmBom4zRYW9MpAHeoB1tiiOJBSkz0sp3rDXOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDWHHmnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D847C4CEF1;
	Wed,  7 Jan 2026 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810159;
	bh=YFSNAO19OLcGvuybRg2d3pnOrcRU6lUigg5sdpXOUp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LDWHHmnnwVyAALgUxVpDAVbd8v+qYqI5S1OEZ2lUlHSMcjeR+0yfd9J2dlTwtPKS4
	 nGcLnL9HmUb5L0eZDKf7qGJGOVHVgr9+5FNx34FoGY1APjYYXdZk8dCkK6XBq7cQ1J
	 592O2bYC+SNE1NZaA3MsASGQnso1ak30ONS5VMie6F7HrpauJpQN8gHqTq8v3K6JaU
	 Ry/DHfWwqUYuq3iaLAtGpUAoluDTMioBV6yA65sDE/iOEHc7oD2r4UUgxBIKe/5Jgi
	 DF2b0CxV/dY6HUlA/GWzyqDXkBTC8EfKrr4XaP23gg4bf2zKrYKlrG+XPCbo29idmO
	 7eiibvivo8u7Q==
Content-Type: multipart/mixed; boundary="===============1397663430468551668=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b24f940a2d2e990dc39154bc606665b36e1630fde457032d64f2a2ee5c0f4b45@mail.kernel.org>
In-Reply-To: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,memxor@gmail.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 18:22:39 +0000 (UTC)

--===============1397663430468551668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..954bd61310a6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
>  };
>
>  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
> -				    struct bpf_prog_aux *aux, unsigned int flags,
> -				    enum bpf_async_type type)
> +				    struct bpf_prog *prog)
>  {
> -	struct bpf_prog *prev, *prog = aux->prog;
> -	struct bpf_async_cb *cb;
> -	int ret = 0;
> +	struct bpf_prog *prev;
> +	struct bpf_async_cb *cb = async->cb;
>
> -	if (in_nmi())
> -		return -EOPNOTSUPP;
> -	__bpf_spin_lock_irqsave(&async->lock);
> -	cb = async->cb;
> -	if (!cb) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!cb)
> +		return -EPERM;

A small concern: the error code changed from -EINVAL to -EPERM. The verifier
comment at kernel/bpf/verifier.c mentions that non-initialized timers
"will return -EINVAL". Is the error code change intentional, and should
the verifier comment be updated?

> -	if (!atomic64_read(&cb->map->usercnt)) {
> -		/* maps with timers must be either held by user space
> -		 * or pinned in bpffs. Otherwise timer might still be
> -		 * running even when bpf prog is detached and user space
> -		 * is gone, since map_release_uref won't ever be called.
> -		 */
> -		ret = -EPERM;
> -		goto out;
> -	}

The usercnt check is removed here. The check still exists in
__bpf_async_init(), so a timer cannot be initialized when usercnt is zero.
But can there be issues if set_callback is called after usercnt drops to
zero on an already-initialized timer? The old code would fail with -EPERM,
while the new code proceeds.

> -	prev = cb->prog;
> -	if (prev != prog) {
> -		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> -		 * can pick different callback_fn-s within the same prog.
> -		 */
> -		prog = bpf_prog_inc_not_zero(prog);
> -		if (IS_ERR(prog)) {
> -			ret = PTR_ERR(prog);
> -			goto out;
> +	do {
> +		if (prog) {
> +			prog = bpf_prog_inc_not_zero(prog);
> +			if (IS_ERR(prog))
> +				return PTR_ERR(prog);
>  		}
> +
> +		prev = xchg(&cb->prog, prog);
> +		rcu_assign_pointer(cb->callback_fn, callback_fn);

Is there a potential race between these two operations? Consider two
concurrent callers (with programs P and Q) racing:

1. Thread A: xchg stores P into cb->prog
2. Thread B: xchg stores Q into cb->prog, gets P back
3. Thread B: rcu_assign_pointer stores FB (Q's callback)
4. Thread B: bpf_prog_put(P), B's check passes, B exits
5. Thread A: rcu_assign_pointer stores FA (P's callback), overwrites FB
6. Thread A: check fails (cb->prog is Q, not P), retries

After step 5, cb->prog holds Q (with Q's reference) but cb->callback_fn
points to FA (from P). If P's refcount drops to zero elsewhere and P is
freed, would the timer callback FA become a dangling pointer?

The bpf_timer_cb() function reads cb->callback_fn and calls it directly
without verifying it corresponds to cb->prog. The cb->prog field holds
the reference keeping the program alive, but if the callback pointer is
from a different program that may have been freed, this could be a problem.

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
> +	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791345842

--===============1397663430468551668==--

