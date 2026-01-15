Return-Path: <bpf+bounces-79121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EAD27BCD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42E8E3007F0D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067903BFE37;
	Thu, 15 Jan 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6FqosJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB1225A34
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502381; cv=none; b=jfvTilHYgMX5oYZCvDVWane0RS4+fOeWXBqge/6FCB12eTJPOL2HZk6bG7RoV3WN8DjEIN1pGpqfoV61WBLHcvBoabluxhaIvYAKOc8juGbWVX3TbXgmawZIDiBrrDysV8SbwniOf9a4wlYL5wizPnBTeqWbzMui2lDxbCTBxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502381; c=relaxed/simple;
	bh=UxlceXoeIXx0JycxcVKzrNZMhAG7p5/5tNKnWCcKV2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9zXYEDzvizaV3elSsn+s/sijV5yL4qttHRRaIdcCfU0l2IJKeue7m31cdRgzAVhGWS+MyPP3hl/yvaz4bvYI9DHXi3go8NeiYtEgY/osDNRzb/7XCoCd/EjdxUy0ihyMLRM5a3d/DY2fw8VAvXCe8p2upbIy8fXx2LPwpmkmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ6FqosJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f30233d8aso8844115ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502379; x=1769107179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHDYurxMYC7Xp48xlg9+cleL+CyR6lzuXXJ/gFtSrgg=;
        b=dJ6FqosJctpHTWitE+kgHIsKqSwS7w6Z6oZbE4gcq/81S/RG8X3Zpyv269iVcKcXwF
         UegaSTts98+KfR6TPrG4J1i5x4Rhyo5xy21xfO814u98PialzMHdXhAHM+M30MjXpYhC
         pt9WpcsIvlvkdPRC0StZSPj3CRJjlxayu3ZPAeTQ3zE8JYeBo5YmXT1Qo8C2sq8Ctz2G
         TBlKeaj0F6p7TK4qMkoxnU2Ejat0dEIBO608zWrqjisBaSHdpkqTtw+Dk5739ITdpRvb
         y172Wat8jHwnMVa3ABnl4lC0hpdlcd6oyboJ/fg8m/hT7PxN4kEY3LQdxq8RKSxBSf56
         TPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502379; x=1769107179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHDYurxMYC7Xp48xlg9+cleL+CyR6lzuXXJ/gFtSrgg=;
        b=fk2vvBpCyJpoMoZ+R0BWCHmFOBdPuft8quJIzpZ8YlKsQG03IecTNf4ERBmqmEtzsq
         kREp2863LRkCBD1EZjRLULG6RX8Qs5VT1c4/lhTo39/YnQv7I2T7MSSGcXSCZYb4UHZb
         /4hNdAXV4utMZMJMGm2kj05J6WNg9aWk1mbNXPUGVYgZIKT7lC++OUnd4Oy/+uEcGyPT
         tOqCT1yKw3vx8qISb9D9kU73M17CbWsmj0FRxXaA0URPoIaHsQwfnRKSVMaFnio874sF
         VK9Co7XWbrg+ozXtyl/Vs2lliVWVYsYIY4AAS/W/jJQ8sEyCKyQxxrJ/B1eHsPR6thgQ
         y+rw==
X-Gm-Message-State: AOJu0YwWTF0G96Fwnz3ZnusaJnX3WhhY66jfQkOaiCabcJ7MW2gGKF99
	tKOhT9/xb0MhI5pMhM7S++bf4IdKQK7uHqvCYpc7uyrIvLruoNrZWuzjMTo+3z4yzGMxtXrZGhF
	3a/7lwVioAg1cmig+wibiWMCivmiych/65Q==
X-Gm-Gg: AY/fxX6IviZAg2EekYTQEJYabi7qs87TGk5xCQRsUbWGwg2fX6cH5XqnVPKWwKwRrod
	GdwS3ws662vc8dWlvz3wR1iBRND3fCPKQvE3ewQfDCmm0pSz1eeqRF+wupkqZeUGvxlvdtb3IGi
	4me7UaCScXZ2VNR6Blw9RIMjv04Ys7F6o4JSGkM6Y+qqR0mpXr15bpbTCnM2t7fqYb1OHdaryds
	bK+/KPi3RjO9V6UFYDYCnEcIJJ/9xpMkwND18lvGzmjuDciPsDZEr8XlvimlX5N+RY2AxUF8HGI
	J+/bCzgl
X-Received: by 2002:a17:90b:1c87:b0:341:88ba:bdd9 with SMTP id
 98e67ed59e1d1-3527325d1a2mr231062a91.25.1768502379215; Thu, 15 Jan 2026
 10:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com> <CAEf4BzYpZPtBFyceDfELDTg8fHFTOC+cqeTvvtWyzOtMqRc5iQ@mail.gmail.com>
 <14ef41d3-778c-4fe1-841a-9caffe8e0ec9@gmail.com>
In-Reply-To: <14ef41d3-778c-4fe1-841a-9caffe8e0ec9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:39:26 -0800
X-Gm-Features: AZwV_QjICiqdeEZh8TvH111KgasOz9JxuuFe2XQxpNw8PSXWCo9QijIF3vHbS8w
Message-ID: <CAEf4BzYDSKHjdr_tLoYgDT6s09S8s2U7vS-v67kP1ZRGDvQhTA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/10] bpf: Enable bpf timer and workqueue use in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 6:53=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/9/26 22:19, Andrii Nakryiko wrote:
> > On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Refactor bpf timer and workqueue helpers to allow calling them from NM=
I
> >> context by making all operations lock-free and deferring NMI-unsafe
> >> work to irq_work.
> >>
> >> Previously, bpf_timer_start(), and bpf_wq_start()
> >> could not be called from NMI context because they acquired
> >> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> >> patch removes these limitations.
> >>
> >> Key changes:
> >>   * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
> >>     operations with atomic cmpxchg() for initialization and xchg() for
> >>     cancel and free.
> >>   * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_sta=
rt,
> >>     hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
> >>   * Use the lock-free mpmc_cell (added in the previous commit) to pass
> >>     operation commands (start/cancel/free) along with their parameters
> >>     (nsec, mode) from NMI-safe callers to the irq_work handler.
> >>   * Add reference counting to bpf_async_cb to ensure the object stays
> >>     alive until all scheduled irq_work completes and the timer/work
> >>     callback finishes.
> >>   * Move bpf_prog_put() to RCU callback to handle races between
> >>     set_callback() and cancel_and_free().
> >>
> >> This enables BPF programs attached to NMI-context hooks (perf
> >> events) to use timers and workqueues for deferred processing.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 288 ++++++++++++++++++++++++++++++++++-------=
----------
> >>   1 file changed, 191 insertions(+), 97 deletions(-)
> >>

please trim irrelevant parts to shorten distractions in email

[...]

> >> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_as=
ync_kern *async)
> >> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
> >>   {
> >>          struct bpf_async_cb *cb;
> >>
> >> -       /* Performance optimization: read async->cb without lock first=
. */
> >> -       if (!READ_ONCE(async->cb))
> >> -               return NULL;
> >> -
> >> -       __bpf_spin_lock_irqsave(&async->lock);
> >> -       /* re-read it under lock */
> >> -       cb =3D async->cb;
> >> +       cb =3D xchg(&async->cb, NULL);
> >>          if (!cb)
> >> -               goto out;
> >> -       drop_prog_refcnt(cb);
> >> -       /* The subsequent bpf_timer_start/cancel() helpers won't be ab=
le to use
> >> -        * this timer, since it won't be initialized.
> >> -        */
> >> -       WRITE_ONCE(async->cb, NULL);
> >> -out:
> >> -       __bpf_spin_unlock_irqrestore(&async->lock);
> >> -       return cb;
> >> +               return;
> >> +
> >> +       /* Consume map's refcnt */
> >> +       irq_work_queue(&cb->worker);
> > hm... this is subtle (and maybe broken?) irq_work_queue() can be
> > ignored here, if there is already another one scheduled, so I think
> > your clever idea with CANCEL_AND_FREE being done based on this
> > refcount drop is flawed...
> >
> > CANCEL_AND_FREE has to succeed, so it's out-of-bounds signal that
> > shouldn't be going through that command cell, yes. But can't we just
> > have a simple one-way bool that will be set to true here (+ memory
> > barriers, maybe), and then irq_work_queue() scheduled. If there is irq
> > work is scheduled, it will inevitable will see this flag (even if it's
> > not our callback), and if not, then irq_work_queue() will successfully
> > schedule callback which will also clean up.
> Thanks for pointing to this issue.
> I don't think we can solve it with a simple bool, because cleanup
> should only happen once, and only after refcnt is 0, otherwise we need
> to go
> back to states to indicate cleanup initiation and cleanup entering (to
> implement
> mutual exclusion of the irq_work callbacks trying to run cleanup).

I meant bool as a command indicator of sorts, which is just part of
the solution. We do have reader's mutual exclusion with last_seq,
don't we? And the idea was that once the winning reader notices that
shutdown was requested, they can perform it and make sure that
subsequent readers (if there are any scheduled) would do nothing.
E.g., by setting last_seq to some special large value to indicate "we
are done, no more commands will be accepted".

But let me go and read the latest version and refresh what's going on
there in my mind.

> We can still solve this with the refcnt: Drop reference, if refcnt is not=
 0,
> we successfully released map reference and one of the scheduled irq_work
> callbacks
> will cleanup, otherwise we took the last reference, all we need is to
> schedule new irq_work
> (which can't fail)
>
>      if (!refcount_dec_and_test(&cb->refcnt))
>          return;
>
>      /* We took the last reference, need to schedule cleanup */
>      refcount_set(&cb->refcnt, 1);
>      irq_work_queue(&cb->worker);
>

[...]

