Return-Path: <bpf+bounces-78519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10439D10BDB
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D932530119EE
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136A3195FD;
	Mon, 12 Jan 2026 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5srX00C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C513191D3
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200502; cv=none; b=CvprBiPZ0bWDpQZx7up8YBW63Gxf6NqhKxC8c3TXfoUYneeXOol+APtEJMHBn1l3dVjDN1BgMTn1/nlUGZmpUs1xzYqC0Wj+BGd6JMDeo0efFiBwBvj2L/YAljEl59xwupHsbtJ48FUGxjSb6vcQ7+vtHVbO5APE6NpH8F01E34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200502; c=relaxed/simple;
	bh=rpUMG7VCejDbORClQkt0L6wApaMWxdJ2USHhfDb3EfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqetL6jERcO/0juwzW5KOtN/QrIVwM3UWh/tysfxKz1L4N/LxtIYjQCZBS8hoojUwXYAEaIiD8L437sboZMgcIHnGsBOqe+s07JYCzNgNWklshsxWR5/+f0O+kfNd7lk/NTata+ojKhkc5t3bLn5Yh+BTi8p5TgMTRkICNLChMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5srX00C; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso53267935e9.2
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200500; x=1768805300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGywwOftAtIOE9Ma0M+1p0gAOjyGugzA0x5uDVxtlE=;
        b=A5srX00CzsnAXu2dgdhAVNCSSfgysV5gsMl2HtYmVlMFRHWdD83MdK18e+iRAp+X6F
         uMYaeKJ+9Uk+PGghiXC4DEe5bUnu4gfdTu2joNVvmmLiDwBc+iyDjs44f4fGJE4AS4E4
         Y7Zc1Je3KBlg+2uGK10qgV08kSL4c0UoGmbHm95UL6jE+krVRYAIzARw1kRF9cT0n2kK
         z1R7vZDVhapTt2ZU5ibJuRGNeAERvAF+wxjU1NCr1Et2YJtO5rA1M3Hn6aQHmxNG7YmN
         3GC7iw+1F3W7twG3cYyUOyfPzgbVk2kh8Ij16ZGTstvQjbUQeDfT9HHIqc3K9lJYNAYU
         CxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200500; x=1768805300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMGywwOftAtIOE9Ma0M+1p0gAOjyGugzA0x5uDVxtlE=;
        b=I6ceXMSv2YU5C9kA7xUw+xlOfhEN+FkFj54cV8cuC2LmmeG/J9F8oDjluf8efeXNVK
         vNnhR3mvuHPUlFKUXV8sdvm9yZyEz/ITA+0xJgGl64kXwQEw9Rk6ps8vdJrCLe51XTDD
         PEOOLPtlxFoNaEIZl17HAHJzF1av2Bu+LkM9UVqRoupvLjO0zW66E4dfRZErxOEf74YN
         rRcqPGJmlf3Ddv6mHZKG/xt+JpPGewURIJSPXh9KqUiFmNMYajVwoefuU9XjJ+Lp8Gx/
         ymwld2qGhc4Y3mqoCzYA11C9Un3MhwbNNdy+PGSFjNoWFOsFCcr4sfuoZCyAVI6AUPIa
         Nekg==
X-Gm-Message-State: AOJu0Yw6gvq8MshZdG25lNWH9SWq9guLhpBoETH9TlAtP7BenkORkTET
	LQwJB9CAIYAwjgwZ8jktqfny6xQKZ0r8QSyFx3+cAPQq1HPxa7prTkNKSRA0cy4292Oh1XjE2n0
	QgCTAR2gZHv1ReGllSCUQEkDhYZH57MI=
X-Gm-Gg: AY/fxX5W/Z2XzD4sgJnllRZYYARmFBIzTGyyG2EwM/ED34bThrgnv2C0WvaqVDzGUOx
	zo6yXjy3FhaRF+eMAsmNFiEXtwajUMZdkTeZxma0yxRPQ1dW5PJYOaefcObc0BW+sxVhlRtXDqe
	meA63zzxciW+M6UOMZP7E02cpvNVtYD/Wf9RYULfjN2ysUMrxUbvVsu13o74FweZzPioYPawsei
	c1iVOZEbpAKpWBMIN7Q778Wt3lcEexKZ9+voYl/9XAoK12FKiIVqwBsvZsh4c9KX82qbIucq6SX
	/bzMm2XZ9hx7xyLormabfAQB8L1+QA==
X-Google-Smtp-Source: AGHT+IEhlXyXqtRW9jYjXtqtbcxsdidMM6tcgJbc7HTEps9KImsYI840348wv9y6tglmEJK7qiM9fXyo1mMyAlpgFmM=
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr178040655e9.11.1768200499456; Sun, 11 Jan 2026
 22:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 07:47:43 +0100
X-Gm-Features: AZwV_Qg29P_sOJq55zOYM8D-5QrItk4nN_QfUqhXjRxV-aswWqTSpvjIbiawtZo
Message-ID: <CAP01T74v_m7X6Osd=WndWbQaBnsifkT8j2mKDVCaWKX269gKKg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor __bpf_async_set_callback() getting rid of locks. The idea of the
> algorithm is to store both callback_fn and prog in struct bpf_async_cb
> and verify that both pointers are stored, if any pointer does not
> match (because of the concurrent update), retry until complete match.
> On each iteration, increment refcnt of the prog that is going to
> be set and decrement the one that is evicted, ensuring that get/put are
> balanced, as each iteration has both inc/dec.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 61 ++++++++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a79b903c6fc2ccb310f521a4b14a1d..954bd61310a6ad3a0d540c1b1ebe8c35a9c0119c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
>  };
>
>  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
> -                                   struct bpf_prog_aux *aux, unsigned int flags,
> -                                   enum bpf_async_type type)
> +                                   struct bpf_prog *prog)
>  {
> -       struct bpf_prog *prev, *prog = aux->prog;
> -       struct bpf_async_cb *cb;
> -       int ret = 0;
> +       struct bpf_prog *prev;
> +       struct bpf_async_cb *cb = async->cb;
>
> -       if (in_nmi())
> -               return -EOPNOTSUPP;

I'm just nitpicking, but it may be cleaner to drop this hunk in the
commit which marks both NMI-safe, and keep this commit topical to
making this function lockless and ensuring nothing breaks.

> -       __bpf_spin_lock_irqsave(&async->lock);
> -       cb = async->cb;
> -       if (!cb) {
> -               ret = -EINVAL;
> -               goto out;
> -       }
> -       if (!atomic64_read(&cb->map->usercnt)) {
> -               /* maps with timers must be either held by user space
> -                * or pinned in bpffs. Otherwise timer might still be
> -                * running even when bpf prog is detached and user space
> -                * is gone, since map_release_uref won't ever be called.
> -                */
> -               ret = -EPERM;
> -               goto out;
> -       }
> -       prev = cb->prog;
> -       if (prev != prog) {
> -               /* Bump prog refcnt once. Every bpf_timer_set_callback()
> -                * can pick different callback_fn-s within the same prog.
> -                */
> -               prog = bpf_prog_inc_not_zero(prog);
> -               if (IS_ERR(prog)) {
> -                       ret = PTR_ERR(prog);
> -                       goto out;
> +       if (!cb)
> +               return -EPERM;
> +
> +       do {
> +               if (prog) {
> +                       prog = bpf_prog_inc_not_zero(prog);
> +                       if (IS_ERR(prog))
> +                               return PTR_ERR(prog);
>                 }
> +
> +               prev = xchg(&cb->prog, prog);
> +               rcu_assign_pointer(cb->callback_fn, callback_fn);
> +
>                 if (prev)
> -                       /* Drop prev prog refcnt when swapping with new prog */
>                         bpf_prog_put(prev);

I was wondering whether bpf_prog_put needs adjustment when done in NMI context.
At this point I forgot what my conclusion was when looking at it for
task_work, but there are two things that may require care:
1) whether in_hardirq() || irqs_disabled() is enough to detect NMI
context too. This seems to be fine on x86, but I am not sure it will
be the same across architectures.
2) whether schedule_work() can deadlock when invoked from NMI while
its locks are held in some lower context.

Once this function is opened up to be called in NMI context you can
have a reentrant async_set_callback on the same CPU. This will require
both dec_and_test() to drop to 0 on the same CPU somehow. Thus, we may
need to defer to irq_work for bpf_prog_put. queue_work() et. al. have
local_irq_save() so hardirq/task reentrancy should be prevented for them
(they are already supposed to work fine in such cases), even after we
lose our own irqsave through the spin lock.



> -               cb->prog = prog;
> -       }
> -       rcu_assign_pointer(cb->callback_fn, callback_fn);
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return ret;
> +
> +       } while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
> +
> +       return 0;
>  }
>
>  BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
>            struct bpf_prog_aux *, aux)
>  {
> -       return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
> +       return __bpf_async_set_callback(timer, callback_fn, aux->prog);
>  }
>
>  static const struct bpf_func_proto bpf_timer_set_callback_proto = {
> @@ -3131,7 +3112,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>         if (flags)
>                 return -EINVAL;
>
> -       return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
> +       return __bpf_async_set_callback(async, callback_fn, aux->prog);
>  }
>
>  __bpf_kfunc void bpf_preempt_disable(void)
>
> --
> 2.52.0
>

