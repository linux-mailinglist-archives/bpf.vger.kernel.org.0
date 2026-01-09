Return-Path: <bpf+bounces-78413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E5D0C716
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A0923019E16
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290F3451D7;
	Fri,  9 Jan 2026 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9vMamee"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028652ED846
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997158; cv=none; b=ifxCi/Wvf3KHFqDgFlfohxYJmGu4VluscLlqYeMqklL0O2WatpU9hFXjv/iI8dLAJR4viY8OwuuPYaRyXsb84MvgEYmygGX2gBr1Yn0N9Wvjp4tD2pVRYum/3KRiAaV7KjqnL+03KAUswsmyqDa58yO/4W8lp/5Zn0TdlsZJ7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997158; c=relaxed/simple;
	bh=8DO1EFmFF1TQehzD7MpATHrwT15DiWM7zKle9y932vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ5k52cpo4fqvkPT5sbaVzZdA3rZHECjSU9BtuklsYFfqWQURDpYQFSj6R0vQLMiqSMS8NwW+BR2SZUmo/f96gJfpIMB8kyzVTUBZiXM9OeK4dsFNix726L+OFppVPpRlIETqhwNsG40yZZZEdtm6gNXZ016QcnQl9d74ejnvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9vMamee; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c718c5481so2725243a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997156; x=1768601956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eiFdDLlwQL+LJT2fkzsFyZMQsHjIIKNfsQ5VS8w6lM=;
        b=V9vMameeA9hyk1f1LXm+ruzzAqsUUYz3lUm9VyFadtLp1nuxfL9WvlE7lCHxntrYi6
         DxCd7+LoyRhJSQa6v6BgQ6MIqI8krHvD332f+cb0ag0ZIlkN+g8MjnuJoLOqvlZScGu5
         Tw9ELXxZWbb3c+IxwEW70LNBu/8IikW1R+0I/UPrzhMMdHSGkgpiSmHPyb0O9P0hzJ2/
         cypjmX9z2hPGSga3evbnJeWnFt0DGE6N3SEh4H7sTm6JShumuoWpLfbshzrjoP/wvD43
         59h304PyFXlLovzUIHoo8v5CBIJkTmAsg7VpGRhsopTqes8QaWMxIUpkHp3FgmUBzOW1
         OrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997156; x=1768601956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eiFdDLlwQL+LJT2fkzsFyZMQsHjIIKNfsQ5VS8w6lM=;
        b=oe/AL+yrnXDJvFo9uXFSJ8iEgU5Q79lQWEW9xotjDJfDhfvffS2cNsfUtKHQbAItmc
         lgd4BSkAKm3Owfuh82hrBRWa+qjAWJZ/6NH7l5Wqx4mLYygbLnw95DfVUetd1/rDQrov
         xSmSmyrlTS1Dp4jFuR9DR2yIdPW3Wulj+3449dniu36KmttlxQA+MgaywaV2ENlP1DVb
         ggfTL7jnTsEtqe0m945yZM3zKbjVGkbR7fNJXC2UV1/HxGpx4TXE+vChHPbABEmIWLUg
         T1HKHtW54nZ8ua6toxEYKCUXTY5fB+ikmp6gJ7y1MtLa/RLRKH6gcW1pt2VSx+GdtEPo
         HMmA==
X-Forwarded-Encrypted: i=1; AJvYcCXpb/sfTQknMjhfUrb++LScAvMdtshJl6ZepIV2dUM3TBZC84Jg/8i37epBl1+wBJEjT64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoLi0md/viIgwEhkmD/Ble9LLUqlGtKcqRs6ozo3kVCy8eGhJ
	g704q79W6lZgMyNCbiTODRBoMmqEEN9hb1kF+AyS4oCxSwaldUvA+StHmKpXNfGwZfieIPgyHJw
	HfuB9Xyye6NJTA1+jF+1Mkhudx2KsyuU=
X-Gm-Gg: AY/fxX4s/wj6yDbXAPxOsvlkGvS9KLsgpCqpvYY0TyFoQ0Zp/wtw6B+FUjAKcNqA0k8
	VexWTerhjuDcWcwm9qStjVo5fbUSfJwzz/Cn9Dz/kN2V3phevoVJ5/NMDqTtYG7wAvaXlvm59In
	VSppXMPC2fgPJvl6xC5CQTLex/iTfGn4BVPOpt9cx8ST8ZChFL9ZUwjtX8nlfGWsjIcwLnSm5JH
	Y7Jg+WEzGIQe2fDtvRRwclwbo2ypCTQGlKA+CFTPSu+O7hcx5uu8Mzs9jhigCCHuEr1Tz5GKn2W
	+2R98GV5
X-Google-Smtp-Source: AGHT+IHCFVNYy8DpvZ629mWqEn/uV1yBK0KAqP85uZUl6ujMGsGpsIaokrhsqfsh2oFJTRvsThn5m9+0bo7kMKj58hE=
X-Received: by 2002:a17:90b:1e05:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-34f68c00a7fmr11091886a91.24.1767997156191; Fri, 09 Jan 2026
 14:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-3-740d3ec3e5f9@meta.com> <de0af4dceddabe72f6a329980dc36e0bd045024eca617b489c6634afab7b85cd@mail.kernel.org>
In-Reply-To: <de0af4dceddabe72f6a329980dc36e0bd045024eca617b489c6634afab7b85cd@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:02 -0800
X-Gm-Features: AQt7F2rejwZYZKI_Q985RDpIeVk5XWFp0P2eZi5n0LOBs9HITcsu8D0nHj128TE
Message-ID: <CAEf4BzZNuh+czPmgC2-UmAuKobWe2__rR_ZbmZHx9D4a97Nhqw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 03/10] bpf: Simplify bpf_timer_cancel()
To: bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, eddyz87@gmail.com, yatsenko@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index ff3c1e1160db..dc8ed948321e 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [ ... ]
>
> > @@ -1454,13 +1454,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_k=
ern *, timer)
> >
> >       if (in_nmi())
> >               return -EOPNOTSUPP;
> > -     rcu_read_lock();
> > -     __bpf_spin_lock_irqsave(&timer->lock);
> > -     t =3D timer->timer;
> > -     if (!t) {
> > -             ret =3D -EINVAL;
> > -             goto out;
> > -     }
> > +
> > +     guard(rcu)();
> > +
> > +     t =3D async->timer;

this should be READ_ONCE() now, no?

> > +     if (!t)
> > +             return -EINVAL;
>
> [ ... ]
>
> > @@ -1492,20 +1490,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_k=
ern *, timer)
> >                * cancelling and waiting for it synchronously, since it =
might
> >                * do the same. Bail!
> >                */
> > -             ret =3D -EDEADLK;
> > -             goto out;
> > +             atomic_dec(&t->cancelling);
> > +             return -EDEADLK;
> >       }
> > +
> >  drop:
> > -     drop_prog_refcnt(&t->cb);
> > -out:
> > -     __bpf_spin_unlock_irqrestore(&timer->lock);
> > +     __bpf_async_set_callback(async, NULL, NULL);
>
> With the lock removed here, can bpf_timer_cancel() race with
> __bpf_async_cancel_and_free()? The concern is that both paths can
> attempt to drop the prog reference:
>
>   bpf_timer_cancel():
>     __bpf_async_set_callback(async, NULL, NULL)
>       -> prev =3D xchg(&cb->prog, NULL)
>       -> bpf_prog_put(prev)
>
>   __bpf_async_cancel_and_free():
>     -> drop_prog_refcnt(cb)
>       -> prog =3D cb->prog  (plain read)
>       -> bpf_prog_put(prog)
>
> The xchg in __bpf_async_set_callback() is atomic, but drop_prog_refcnt()
> uses a plain read of cb->prog. If drop_prog_refcnt() reads cb->prog
> before the xchg sets it to NULL, both paths would call bpf_prog_put() on
> the same program, leading to a double put of the reference count.
>
> Note: This appears to be addressed later in the series by commit
> 0035985a0a23 ("bpf: Enable bpf timer and workqueue use in NMI") which
> moves bpf_prog_put() to the RCU callback, but the race window exists in
> this intermediate commit.

fair point, do we need to do this early on?


>
> >       /* Cancel the timer and wait for associated callback to finish
> >        * if it was running.
> >        */
> > -     ret =3D ret ?: hrtimer_cancel(&t->timer);
> > +     ret =3D hrtimer_cancel(&t->timer);
> > +
> >       if (inc)
> >               atomic_dec(&t->cancelling);
> > -     rcu_read_unlock();
> >       return ret;
> >  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/207913=
45842

