Return-Path: <bpf+bounces-78529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B87D111F3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28ABC305FC5E
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56833D4F5;
	Mon, 12 Jan 2026 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLkOuRj4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311C302147
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205613; cv=none; b=dNG+oxZkKKYFMBN2AYl2LH4n2Dn5Ap4KPQioCLDBnj2PVvZNXN0Vp+J2OCVnw8v+BsjMzntg0IGazjORh95OqW+K8Hv1XF9lekXZO50nHPHSO/L18xEqGaDnV7T8+AlLij+h6Qs6txqXb1qfw8HxtIord9zO3kf4TELT+V6Ic0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205613; c=relaxed/simple;
	bh=7tfKqyUwGhgCnAE92NNJHLiG7xAfn/8L/xm4RaDbOi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctpqZKJdo1Qt3XaDBebCVXT+F2OkMd+7MbQ5F42luZpVqxtSKNilf644ZxbLPQhgGd4UWKS5wfCcRTL5SlVw1rvIJqD1cs8BSs8eYnxMM8pe+P6T+zRE/wFfSJpHC32oXqfrl0UNdgzEUly8D/8AHFNV8YBPq9g43qC0k75zoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLkOuRj4; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43277900fb4so2042694f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 00:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768205610; x=1768810410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zUR1rqa7rpy/fhyOOXdqLhjFRqEHrx+chE7MVvCTkdc=;
        b=VLkOuRj4CyV7hwSEj7/zM9EFY98D7A9ng2K7uiHwuN+ctZHe0e5FbuOR7w+DWz54tJ
         T1q2/6v9/uih5e5AFu8jZ95hnIRPx4+fl1REZRy8zUYidOkW8gqHTwaYHO0nm+LtlD6Q
         w5OcX/ZAoJWHfkBxaewuYRslXx+gQfZiMttKTIdv//xFutFWfyau/zdAhbOpQRwxyB7p
         D7sZrLCdrVNO2pDoPRdi7Bar1QrBDHSxRwMF2DDulO5gLFM69eXi1A6KYupIKLkXy22J
         OvjcS++aCM4mLe74xR9r88oGtIxguTbmTOVc0oOxESSHF8z+YMXF9fN2vQjMTKJM7Yoc
         QCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768205610; x=1768810410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUR1rqa7rpy/fhyOOXdqLhjFRqEHrx+chE7MVvCTkdc=;
        b=Id4HkazQmChD9bYD0O9IsFdvHx6+pQd6vBMBpZQkGgQIw7kdsVp36XW3AtetD2oYyc
         P0UrB0luoB8+1SBK5Z1UiDEuk+TmUMc5J0P6RvUeRSRQXPxsTTX7PuLpAnTYvnztyZUG
         65jYWfxbQ5mCrYjY98o6gdjwGWBnFoNJhhlAVSKbIRG0I7AJsAllmf+mJKLLQKXzVXbG
         ZLFLAA1g0xi7O2Q2vTyO3KtYz/bu1H1msNmW/05uIj1var/VuWqXDGkGLskFt1qMPLla
         cULggaTUc/Unu5tNggwfj7Lodh30/MaNQxkttG1E4ViBBLI3OO4+muFXf8folDfTa+iG
         WNbw==
X-Gm-Message-State: AOJu0YyTX0CP04sOvJST+woh+bD7MhisFoXh+H3sZBowXh3HhZUQAn82
	AAn9bpL1Kx4icijS3uP4YY230rtsymdDfwp4IPJmZiZJ0EeNL2edWjFEBmJnektb4fi6OsfQ/cb
	SKZjYsiZOnUTLOuUEfY3BrjA2TbQz9oPTpTJS
X-Gm-Gg: AY/fxX4JmbohZxiBq9wLTlU7kjrMwl0pdAezl5zO0iMlZfkxwFJzh2iukrtUUvXzIx+
	gKDhM48XVcDqXynT9Ktu7ZEP4wgsvOpPEDC8d5M+kKwZHq7mv1ZCRT6xKOPyJ36wBNjLfPnrD5v
	NA+LW9W1qJl7UTGMJdoc8dx3jzfZCtU+G5kN9Z3spLzsWBHuDGTsPDYHgN9zQMn0y8+M0eXmt6A
	j/8IPYx80Hxi4ZSTPpXgGeSVVUpHCIE/lGm+m755HmcBELbGdlvwnMFOh4gnTVV7G1Grb8ltLVG
	urOMpzDX66EFn/AVqPoaAY3XfNFLuA==
X-Google-Smtp-Source: AGHT+IH0nuRu0F2/fVU1gM096C4V2rAc0dmC4gy6LljfK5cc2w83kdEWzV1EkZIEwa41p5AMrTguWr6beiFuDCcDk2E=
X-Received: by 2002:a5d:4607:0:b0:432:d9ef:3bea with SMTP id
 ffacd0b85a97d-432d9ef3ed8mr8684171f8f.5.1768205609576; Mon, 12 Jan 2026
 00:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com> <CAP01T74v_m7X6Osd=WndWbQaBnsifkT8j2mKDVCaWKX269gKKg@mail.gmail.com>
In-Reply-To: <CAP01T74v_m7X6Osd=WndWbQaBnsifkT8j2mKDVCaWKX269gKKg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 09:12:53 +0100
X-Gm-Features: AZwV_QgTSt01TzGyjbuNP-hteYyhLDfT5qOQaxgUP-OQyxT0ZJW_RpGEHy6iIgw
Message-ID: <CAP01T74VyHycWu5cyvEZmJzu90HyNRcWpbtuYtbf2W+80gQfHg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 07:47, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Refactor __bpf_async_set_callback() getting rid of locks. The idea of the
> > algorithm is to store both callback_fn and prog in struct bpf_async_cb
> > and verify that both pointers are stored, if any pointer does not
> > match (because of the concurrent update), retry until complete match.
> > On each iteration, increment refcnt of the prog that is going to
> > be set and decrement the one that is evicted, ensuring that get/put are
> > balanced, as each iteration has both inc/dec.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  kernel/bpf/helpers.c | 61 ++++++++++++++++++----------------------------------
> >  1 file changed, 21 insertions(+), 40 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9eaa4185e0a79b903c6fc2ccb310f521a4b14a1d..954bd61310a6ad3a0d540c1b1ebe8c35a9c0119c 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
> >  };
> >
> >  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
> > -                                   struct bpf_prog_aux *aux, unsigned int flags,
> > -                                   enum bpf_async_type type)
> > +                                   struct bpf_prog *prog)
> >  {
> > -       struct bpf_prog *prev, *prog = aux->prog;
> > -       struct bpf_async_cb *cb;
> > -       int ret = 0;
> > +       struct bpf_prog *prev;
> > +       struct bpf_async_cb *cb = async->cb;
> >
> > -       if (in_nmi())
> > -               return -EOPNOTSUPP;
>
> I'm just nitpicking, but it may be cleaner to drop this hunk in the
> commit which marks both NMI-safe, and keep this commit topical to
> making this function lockless and ensuring nothing breaks.
>
> > -       __bpf_spin_lock_irqsave(&async->lock);
> > -       cb = async->cb;
> > -       if (!cb) {
> > -               ret = -EINVAL;
> > -               goto out;
> > -       }
> > -       if (!atomic64_read(&cb->map->usercnt)) {
> > -               /* maps with timers must be either held by user space
> > -                * or pinned in bpffs. Otherwise timer might still be
> > -                * running even when bpf prog is detached and user space
> > -                * is gone, since map_release_uref won't ever be called.
> > -                */
> > -               ret = -EPERM;
> > -               goto out;
> > -       }
> > -       prev = cb->prog;
> > -       if (prev != prog) {
> > -               /* Bump prog refcnt once. Every bpf_timer_set_callback()
> > -                * can pick different callback_fn-s within the same prog.
> > -                */
> > -               prog = bpf_prog_inc_not_zero(prog);
> > -               if (IS_ERR(prog)) {
> > -                       ret = PTR_ERR(prog);
> > -                       goto out;
> > +       if (!cb)
> > +               return -EPERM;
> > +
> > +       do {
> > +               if (prog) {
> > +                       prog = bpf_prog_inc_not_zero(prog);
> > +                       if (IS_ERR(prog))
> > +                               return PTR_ERR(prog);
> >                 }
> > +
> > +               prev = xchg(&cb->prog, prog);
> > +               rcu_assign_pointer(cb->callback_fn, callback_fn);
> > +
> >                 if (prev)
> > -                       /* Drop prev prog refcnt when swapping with new prog */
> >                         bpf_prog_put(prev);
>
> I was wondering whether bpf_prog_put needs adjustment when done in NMI context.
> At this point I forgot what my conclusion was when looking at it for
> task_work, but there are two things that may require care:
> 1) whether in_hardirq() || irqs_disabled() is enough to detect NMI
> context too. This seems to be fine on x86, but I am not sure it will
> be the same across architectures.
> 2) whether schedule_work() can deadlock when invoked from NMI while
> its locks are held in some lower context.
>
> Once this function is opened up to be called in NMI context you can
> have a reentrant async_set_callback on the same CPU. This will require
> both dec_and_test() to drop to 0 on the same CPU somehow. Thus, we may
> need to defer to irq_work for bpf_prog_put. queue_work() et. al. have
> local_irq_save() so hardirq/task reentrancy should be prevented for them
> (they are already supposed to work fine in such cases), even after we
> lose our own irqsave through the spin lock.
>
>

I saw that you handled this for other cases in the later patch, but I
guess it's missing for async_set_callback.

>
> > -               cb->prog = prog;
> > -       }
> > -       rcu_assign_pointer(cb->callback_fn, callback_fn);
> > -out:
> > -       __bpf_spin_unlock_irqrestore(&async->lock);
> > -       return ret;
> > +
> > +       } while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
> > +
> > +       return 0;
> >  }
> >
> >  BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
> >            struct bpf_prog_aux *, aux)
> >  {
> > -       return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
> > +       return __bpf_async_set_callback(timer, callback_fn, aux->prog);
> >  }
> >
> >  static const struct bpf_func_proto bpf_timer_set_callback_proto = {
> > @@ -3131,7 +3112,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> >         if (flags)
> >                 return -EINVAL;
> >
> > -       return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
> > +       return __bpf_async_set_callback(async, callback_fn, aux->prog);
> >  }
> >
> >  __bpf_kfunc void bpf_preempt_disable(void)
> >
> > --
> > 2.52.0
> >

