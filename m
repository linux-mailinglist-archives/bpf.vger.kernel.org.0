Return-Path: <bpf+bounces-64817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC75B174C6
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B71D16DB92
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F52356DA;
	Thu, 31 Jul 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtxQWSDa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E917C224;
	Thu, 31 Jul 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978548; cv=none; b=sQ0U5miiWrNPCN8v56Tlygd5IaUI8fGB/qB28SbXiFcsAu5093XaaCQ7VCCPJKpWf/aDyq6Licu7eliZR69i/pJYhwEVHeq3LpwLrAa9D5uXwGwC/hDf3PXoDIAmALy0K/QcHrvaGczU6O7Zq3AyWWijMS2seIaq9r+jSxEjHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978548; c=relaxed/simple;
	bh=bwRgft/Pi/x7nBERkTEYw8jFv/Btln92ULhS/coUC5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy7FMAnsVFbNCc0p9VsNbxRL3FPEBB7TQGcKkL6WVtKTmCZC35EEhkg04Lc8Fxi83psGjzfQwBJFVgBiUl/KumY72shhBFNoA7Ui4+Qx+t8yh53JABQtVMx+4Kkpk5mmopM/nXsJFETOsfF/4+LPOr/WsPU2/vwa2pvoND8cd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtxQWSDa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b783d851e6so1214054f8f.0;
        Thu, 31 Jul 2025 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753978544; x=1754583344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNuGj941i188n74Ov7/xemI3tg0BtOVcDcI4//xk2Xs=;
        b=QtxQWSDaF17MY3NuUHdPLCJrhGwae2jRgoDMBWo6EvSPKl7FuvVLPzHNTKvnGzT35L
         6sykxlhEEQQ8ynUMFvgss+cebxoOwtc8Ac5y4u8ZhFIMlq+0Dmjutz4NMTDfh9BV/SrU
         MzMTVkCwROK/ao0tA9jQLszFemwP4tDYY2BT7jFzeyUcSiKRjyMKtq+IR2iKYuQMQj+C
         s7N0TbVK8q/1oLVrgfAFgB90xJIXXu5HJUZi/TDm5pEtYWlcLhVE78ug+fiQNO01M237
         dbSbR+uNWq3O0aRwpwbFiNzM20kYFMXjaHgndmcxwxNpwjFUb9CskK8WXvhjtwa9AROo
         yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978544; x=1754583344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNuGj941i188n74Ov7/xemI3tg0BtOVcDcI4//xk2Xs=;
        b=IHER6NVKOyl5BtkZHXiibf752a0luw196PTBo7x1godJp6RrKThIGvlNdM0YhuXAff
         YjLD4Q40w7NzevodnEbZnoYJKHzZgX2jleIiK1V13F1z6Xg0Fr4t4VcaZEJLutU/Wzk3
         IuKRfYMZmbjrSUzMMbg/vGVzCSSDp4gsJeZbwwc3EwGtaxPc4SSKus0Rf3JZUwJ375mz
         dDDTm6JUaxEQm0rzWYIkt/GrLGdkeu+I0XV8Q5VlBIzLFI9HNqO0MPkDu2z5sNkMUH0X
         /DeFmq0YaEpCi0zy9QPv8SAKWsHWqoGlCHoSPpxRzPHm2ffqhKtqGdyqrfq+gLAW6+VF
         rIaw==
X-Forwarded-Encrypted: i=1; AJvYcCU/8LjeIg+pIUKsGCRdvHzX7rTHwxTGDRiG/bLXBZtWWspCfHXxMFBJSNT7U8yB/8nHYRzjtD2igS+5k038@vger.kernel.org, AJvYcCU9NsJdysZO6A6aZP2IoQL4DDBvi7dAOt8+yuksLSccssT3ImCwfmFg2lQm6jWaC5xW0Y6HEvls@vger.kernel.org, AJvYcCWIzzlNBf9K7zAtr+2WY3+D3DuDKPUUUwFvwF34l3n4BsUqxq8mMOITBPFFoC+qOgNMPfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Kmj/I/Sf0NR40KvkMq0PqN2uCAqU9/zIcZ8mSMjbl2bcDKiG
	lJw3TN+eoNQA9FA2OJRXx0k8rMfkat6eVdTybGL0es4jfTIOCt9G9BydgMn47uFsJ/gSRjCWpOi
	KxXBqRvDtPL0ItTNAkNKlzZ0uuwrTlq0=
X-Gm-Gg: ASbGncsHcSKz70S7oJ00/rDA3sGv631QgAlGWuj/DX2MGV2wiOw8k9T11c92T5nnWqA
	K4dcX8AaFI4Y+nZx2fkypjGOEnFbktB45p2UTr/b1hBIuhi5JfThyeFBmOyQv8Ix6E1Y5TZBwQt
	8DiB4e6LaGqjxcsHiy9N0Z6RwrMKtQc+KP6pMLLJCqJW0Upr6nq8LHZaF/j7texOEahEXWWcaq3
	cGIAdyu/x37nSnGgsQdAaQ=
X-Google-Smtp-Source: AGHT+IH8gdCLh2rqCQDg7vR/GMyUKMJQzTDd+xZxIolJVnM0VwJH/SLLoNQAtJcDtj6AKFBMBGfwsru/gQZmmqcq2Rc=
X-Received: by 2002:a05:6000:200b:b0:3b7:9617:c9d6 with SMTP id
 ffacd0b85a97d-3b79617ccdbmr4582282f8f.45.1753978544146; Thu, 31 Jul 2025
 09:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com> <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
In-Reply-To: <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 09:15:32 -0700
X-Gm-Features: Ac12FXyPiHGow21qP3zvHf88riIKA6sj8Kry8D13IKq3nkEMMNOVktmjiVoCzRk
Message-ID: <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 2:20=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:
> > >
> > > > Maybe Peter has better ideas ?
> > >
> > > Is it possible to express runqueues::nr_pinned as an alias?
> > >
> > > extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) thi=
s_nr_pinned;
> > >
> > > And use:
> > >
> > >         __this_cpu_inc(&this_nr_pinned);
> > >
> > >
> > > This syntax doesn't actually seem to work; but can we construct
> > > something like that?
> >
> > Yeah. Iant is right. It's a string and not a pointer dereference.
> > It never worked.
> >
> > Few options:
> >
> > 1.
> >  struct rq {
> > +#ifdef CONFIG_SMP
> > +       unsigned int            nr_pinned;
> > +#endif
> >         /* runqueue lock: */
> >         raw_spinlock_t          __lock;
> >
> > @@ -1271,9 +1274,6 @@ struct rq {
> >         struct cpuidle_state    *idle_state;
> >  #endif
> >
> > -#ifdef CONFIG_SMP
> > -       unsigned int            nr_pinned;
> > -#endif
> >
> > but ugly...
> >
> > 2.
> > static unsigned int nr_pinned_offset __ro_after_init __used;
> > RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
> >
> > overkill for what's needed
> >
> > 3.
> > OFFSET(RQ_nr_pinned, rq, nr_pinned);
> > then
> > #include <generated/asm-offsets.h>
> >
> > imo the best.
>
> I had a try. The struct rq is not visible to asm-offsets.c, so we
> can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
> to define a similar rq-offsets.c in kernel/sched/ ? It will be more
> complex than the way 2, and I think the second way 2 is
> easier :/

2 maybe easier, but it's an overkill.
I still think asm-offset is cleaner.
arch/xx shouldn't be used, of course, since this nr_pinned should
be generic for all archs.
We can do something similar to drivers/memory/emif-asm-offsets.c
and do that within kernel/sched/.
rq-offsets.c as you said.
It will generate rq-offsets.h in a build dir that can be #include-d.

I thought about another alternative (as a derivative of 1):
split nr_pinned from 'struct rq' into its own per-cpu variable,
but I don't think that will work, since rq_has_pinned_tasks()
doesn't always operate on this_rq().
So the acceptable choices are realistically 1 and 3 and
rq-offsets.c seems cleaner.
Pls give it another try.

