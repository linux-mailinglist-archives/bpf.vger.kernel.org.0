Return-Path: <bpf+bounces-78527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE50D10DF8
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C1D3014589
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46041330D24;
	Mon, 12 Jan 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzjOB/pB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCA330670
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203005; cv=none; b=S3y0IdOyuEtIojBR/Q4pKNomi1D2/YFrAZ1FJh9FSM35BoQXhZHbGr1cGXF7Jji8FNBFoVu8nMxRoQP4PPI84EGV6AlvE0jv9+Do/In0W2w6PRemFLoz4DrEi6VFZY5xFj1nFdtFgR4n0Tkive+DGypfdrh7hjxBNRd6lV+E/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203005; c=relaxed/simple;
	bh=YsyumYK6q9FW1wbc16QB4RK+Sdk5XmyKEVD9PmnGRAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hvzn+wtTcBFwT+8jtpLIRNuFKH1/WmizkJpRw4juRT3GGlxThkwOVsfXqkkwg2vpyaU1X7hdIKQm/gveg5HjWBKdgBifVn//hN5jF5QvEOVsfpZA5bNnogHAbR7Za5mUjp991Oinh6hFtZ3jVUg79ONJi8ZIUBSznbY4jxuZo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzjOB/pB; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc305552so4397569f8f.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 23:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768203002; x=1768807802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMduWzcCkGwDPW8nJYfZCxpHdqN4DrQm+8oz4ZTkEyM=;
        b=AzjOB/pBckp5otDQI53iIm3fIbiwmWYq7ZRONBFNHIYCHYKz4eDDvgo3lYPgN0pz7u
         yMFoY4ZDH7cCwjUbQnmFmVoplU5GSeRo2qizn+SQi3+O/ukzId4SaN3Ouy0ccVPG1h9N
         z0yUN/ul59xKC5BxXZtO9pmXPs2/cPk9r5nARuWNeGs/i5o0E0GpU4YDsv4SNF7JOQpE
         XcOzLEgGMZp4ValYuPgjz7sDrKj1cO7UpYrLbCyetxiTAi7OZQpML/JiT3l5vHT0fOY8
         tdh8zRh+IWsUB0hdY6lMabrQPMdfL1bZ/0lqIgSRW9sBAX7yhFRX5b60t8YHXreDSOLN
         QIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203002; x=1768807802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMduWzcCkGwDPW8nJYfZCxpHdqN4DrQm+8oz4ZTkEyM=;
        b=cYsFPi/HmO0kwLVmPE/+EOD2cxPtvfyPAkFaRzf8f0xbWiKEKFJZyjLCs6kgJzASp3
         UB5iQGnhX4y2llV8Ppe+KlVN1FpmeInFHpakfQAfFZFjMYLWUhXu1R/Qc/K3Z+UviF6u
         HzwNK/TUGk2kgSX4DdUEnNqICRKj/g/Ex3WYBes3bslx8TCLhlarocCclxXnkwVUBH06
         FJ21CUNhOJ+eP00JtCWv6x0Ik0mG0hwrF6A5TvD6RNkbTLgmvq8XNrSlPT1dyLuZWcon
         oZiaZ/mr+gfFHyJWwQMshNHtnLDWgQxG6EtPgtUUsmC+MbuE9pRrKadrOFUvQbs4CVgu
         20SA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFMdYILD94UfUGUigbYMBHrLIJSckHzkhS+JhBsBUVI9bHszT5N5E4P5yDJzkcp9IUww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SukyXaJQ8lZHRRfXgNoh5jZtMhcuWHXQybPis7Jbzkbr36q6
	iIf2fUJm/KNgyhZhi9y6gGtuU8fQfLXs7jCDoTxU2ZshIXULBrRpAFts/R18YwjVql6246CEDoF
	4WCNcSWTxkrSckL68P143+dSPmP6LCkY=
X-Gm-Gg: AY/fxX7nmcRM70fYnqZ9n+MfGAnI9mi2xT4COZvRbeYwslALSVDJWdknAuhLy3CxKnc
	stPjzyWBLe3Cbxav8Ki0NPFk1pZujFnrMP79Tw4cwoPLQYITcReR0MApYIIBGt79GGnQ4eg4lkA
	tcH1Fpzk2qR9GQ8IJ/NmbV5N/81yirx7Fa6Vzd8FOT+51HrEjamOe71+z2aA15ylGojDE3QiIFW
	0ioiBIoVNH7CZjdf2Zl0hzLVyAIQ4HbDC+RobQ+evzhBvcDqH+FV/jR1/RAHTOQXCDm3WszXsMs
	Hvg713W7TV/rd6CrEVnghwMKbUraGA==
X-Google-Smtp-Source: AGHT+IHXMctoWGWm4jqie4PJknB+5iv6PT33jE15k91twujpNssBdPQHO8VwkCjqfzyC4OlmzDTnh5MqVNOxKX1a48w=
X-Received: by 2002:a05:6000:40cd:b0:430:f7bc:4d0c with SMTP id
 ffacd0b85a97d-432c3775717mr19307983f8f.28.1768203002232; Sun, 11 Jan 2026
 23:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-3-740d3ec3e5f9@meta.com>
 <de0af4dceddabe72f6a329980dc36e0bd045024eca617b489c6634afab7b85cd@mail.kernel.org>
 <CAEf4BzZNuh+czPmgC2-UmAuKobWe2__rR_ZbmZHx9D4a97Nhqw@mail.gmail.com>
In-Reply-To: <CAEf4BzZNuh+czPmgC2-UmAuKobWe2__rR_ZbmZHx9D4a97Nhqw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Jan 2026 08:29:25 +0100
X-Gm-Features: AZwV_Qif93vCnUI6LKjOpmS6LkoJpZGTtiqT5hRfmSrRgfeAzWLSLDLY1l_u4qg
Message-ID: <CAP01T75CRs8nDj9sWkaowsyG+GXtHBZzO5_75CFPmL1=r-Dzsg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 03/10] bpf: Simplify bpf_timer_cancel()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, eddyz87@gmail.com, yatsenko@meta.com, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 at 23:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Wed, Jan 7, 2026 at 10:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index ff3c1e1160db..dc8ed948321e 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> >
> > [ ... ]
> >
> > > @@ -1454,13 +1454,12 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async=
_kern *, timer)
> > >
> > >       if (in_nmi())
> > >               return -EOPNOTSUPP;
> > > -     rcu_read_lock();
> > > -     __bpf_spin_lock_irqsave(&timer->lock);
> > > -     t =3D timer->timer;
> > > -     if (!t) {
> > > -             ret =3D -EINVAL;
> > > -             goto out;
> > > -     }
> > > +
> > > +     guard(rcu)();
> > > +
> > > +     t =3D async->timer;
>
> this should be READ_ONCE() now, no?
>
> > > +     if (!t)
> > > +             return -EINVAL;
> >
> > [ ... ]
> >
> > > @@ -1492,20 +1490,19 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async=
_kern *, timer)
> > >                * cancelling and waiting for it synchronously, since i=
t might
> > >                * do the same. Bail!
> > >                */
> > > -             ret =3D -EDEADLK;
> > > -             goto out;
> > > +             atomic_dec(&t->cancelling);
> > > +             return -EDEADLK;
> > >       }
> > > +
> > >  drop:
> > > -     drop_prog_refcnt(&t->cb);
> > > -out:
> > > -     __bpf_spin_unlock_irqrestore(&timer->lock);
> > > +     __bpf_async_set_callback(async, NULL, NULL);
> >
> > With the lock removed here, can bpf_timer_cancel() race with
> > __bpf_async_cancel_and_free()? The concern is that both paths can
> > attempt to drop the prog reference:
> >
> >   bpf_timer_cancel():
> >     __bpf_async_set_callback(async, NULL, NULL)
> >       -> prev =3D xchg(&cb->prog, NULL)
> >       -> bpf_prog_put(prev)
> >
> >   __bpf_async_cancel_and_free():
> >     -> drop_prog_refcnt(cb)
> >       -> prog =3D cb->prog  (plain read)
> >       -> bpf_prog_put(prog)
> >
> > The xchg in __bpf_async_set_callback() is atomic, but drop_prog_refcnt(=
)
> > uses a plain read of cb->prog. If drop_prog_refcnt() reads cb->prog
> > before the xchg sets it to NULL, both paths would call bpf_prog_put() o=
n
> > the same program, leading to a double put of the reference count.
> >
> > Note: This appears to be addressed later in the series by commit
> > 0035985a0a23 ("bpf: Enable bpf timer and workqueue use in NMI") which
> > moves bpf_prog_put() to the RCU callback, but the race window exists in
> > this intermediate commit.
>
> fair point, do we need to do this early on?
>

It might also make sense to just fold this patch into the later one.

>
> >
> > >       /* Cancel the timer and wait for associated callback to finish
> > >        * if it was running.
> > >        */
> > > -     ret =3D ret ?: hrtimer_cancel(&t->timer);
> > > +     ret =3D hrtimer_cancel(&t->timer);
> > > +
> > >       if (inc)
> > >               atomic_dec(&t->cancelling);
> > > -     rcu_read_unlock();
> > >       return ret;
> > >  }
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2079=
1345842

