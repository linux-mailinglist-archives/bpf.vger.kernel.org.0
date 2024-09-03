Return-Path: <bpf+bounces-38811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13296A635
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F22EB261CD
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FDE19005A;
	Tue,  3 Sep 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InxD+uU3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091DF9DF;
	Tue,  3 Sep 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387008; cv=none; b=fZ8rRQLI1HJbmib0d6KEOwiTKkcxF7eDX/KUi7zGQ+qVvExQrILpJ+qAwCwWm1JSIt79zO5bPdhd7MF7Mmm34hK3Pb6tkmL0WrchPyT/R3GODlqrW7Oq/xW8DAno+5A6wL0/OYPb9CBskIQ6lgT6s7DHXPVXIeRFg/ZErQ+ib3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387008; c=relaxed/simple;
	bh=ZXoC+bX2cfZcnUUvscu2M39QLcr2ukcipdwOxFgnzmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYsK1CVsc1Su+MrGEefZ8Bw7z6aamUuBvJAvMIUfrVj3yYLxElaXOC2S9/bmsUwZt84t4flSRkl9z8XUOYb1cn7POMuNxy8FChtdfp7+ipLWq/mdAFHgSI4v1HMsXyTY+KFiJnICv5imKF+iY+fQzhM2zsSdf6S9Akj89hEzTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InxD+uU3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d87176316eso2877804a91.0;
        Tue, 03 Sep 2024 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387007; x=1725991807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGDRWHzZZanqwG73iEDkeBSBBV/sGTS7q6CJLaF4NtE=;
        b=InxD+uU39feYhIApMnJZLQMGoxU7wCrYt24cCNs8OQFwH0V/n9Xvft0iIzkC3RPafW
         G+edOdgBzYTlWymrgvjaAW+Foj3jHtzG21ua5vUMroAJPHhSq2wilMNMcE8V+g3e+wjz
         ftFNZKOpnntw7r8FlRZOFk5BhsBFyB59idUiWWJsbcC/DNxyF5ZwZJ+94I297erMKhgO
         j0a+RR8vJRz6LEYszE5bKqvq4OfRRo0qhZk1HCslIRE19FaRNBrLR/eoKxIJZpazUfJE
         bJ9I41dpOsg5r6pMoD2qnxkiV4RdKflreIvIySoAhNepPcxxHPGbgdHTzu3cKuzQoIaW
         6MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387007; x=1725991807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGDRWHzZZanqwG73iEDkeBSBBV/sGTS7q6CJLaF4NtE=;
        b=jaVMjVrDPqQsS2hBBLBasyiqb7mL6ZAvE+7dlO4RodZmxfUFBzVE9DKt9vW+rL6IM/
         Dils9/v0jUbOmyvsrUNoTsVSBQeBXQ1qt1Rnukd2mOgPCJv4u09yTSdbJgAE1KILj8zG
         uO+tUo9OCQnW2RK8ajR6W+lvvlkxg3EkImoMuIGJNSnFrZgkBsf4MQRe8SM8+1GIzTVB
         f2qIL0FvF/IqyogFhVXuyboy/HcybXOHPMbBCiE0jG+6/qJ1mK6xs9jG60p2YCPwSnPa
         B6Blnv/ssuQRKfAImGjh2f0GvjUXFEqeiAOWDnjiuBxsE8dwar42KotiwElhwwS9law0
         +2jw==
X-Forwarded-Encrypted: i=1; AJvYcCUmSG2RTT41NZRK5xlbSBKwUeTea5V23UdTAWKAkGoR/P+nNPqVe2i+/fh2aR4Nmmfpy2ZXeFKPBTzVPAqcUDk9Vy86@vger.kernel.org, AJvYcCW1W0l8Ivn/UzRG0en2KmmnyaiLuyPR/98WJzTD4TOds04P1PNxE+Dmc6BqSKA/T2kzA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzELdhnQmBbGAoT8doMj56OZ8n2NUpsQ+XVc43XpeT+snmHv2C
	fvfXr39cxSboY4/b4HeBhoS5ksM5D0LNyZS/xz+7iSkn+iunmG4IQZMDwgkpQVrrminNitg4DVs
	ecEKEFL4KbhyiWDAJyurofkIfswE=
X-Google-Smtp-Source: AGHT+IE/NY7KsbAlzVkG/tUqu4Q1E1fo1gNZ8D45Y3B4+BZwiJf8ilS23j57Rnm+qOKXaJsbmvYU4KDBuT/R3CCoGbA=
X-Received: by 2002:a17:90a:e16:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2d856b047f7mr27448514a91.12.1725387006532; Tue, 03 Sep 2024
 11:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com> <ZtHKTtn7sqaLeVxV@krava>
 <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com> <ZtWBRgM3TyhdiwKw@krava>
In-Reply-To: <ZtWBRgM3TyhdiwKw@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 11:09:53 -0700
Message-ID: <CAEf4BzZJdmppN2=pt-0D+LDsfc6rW=Jg_7Q6kEJXpsuv52ATNQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tianyi Liu <i.pear@outlook.com>, 
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	flaniel@linux.microsoft.com, albancrequy@linux.microsoft.com, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:11=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Aug 30, 2024 at 08:51:12AM -0700, Andrii Nakryiko wrote:
> > On Fri, Aug 30, 2024 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Fri, Aug 30, 2024 at 12:12:09PM +0200, Oleg Nesterov wrote:
> > > > The whole discussion was very confusing (yes, I too contributed to =
the
> > > > confusion ;), let me try to summarise.
> > > >
> > > > > U(ret)probes are designed to be filterable using the PID, which i=
s the
> > > > > second parameter in the perf_event_open syscall. Currently, uprob=
e works
> > > > > well with the filtering, but uretprobe is not affected by it.
> > > >
> > > > And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_per=
f_func()
> > > > misunderstands the purpose of uprobe_perf_filter().
> > > >
> > > > Lets forget about BPF for the moment. It is not that uprobe_perf_fi=
lter()
> > > > does the filtering by the PID, it doesn't. We can simply kill this =
function
> > > > and perf will work correctly. The perf layer in __uprobe_perf_func(=
) does
> > > > the filtering when perf_event->hw.target !=3D NULL.
> > > >
> > > > So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to =
avoid
> > > > the __uprobe_perf_func() call (as the BPF code assumes), but to tri=
gger
> > > > unapply_uprobe() in handler_chain().
> > > >
> > > > Suppose you do, say,
> > > >
> > > >       $ perf probe -x /path/to/libc some_hot_function
> > > > or
> > > >       $ perf probe -x /path/to/libc some_hot_function%return
> > > > then
> > > >       $perf record -e ... -p 1
> > > >
> > > > to trace the usage of some_hot_function() in the init process. Ever=
ything
> > > > will work just fine if we kill uprobe_perf_filter()->uprobe_perf_fi=
lter().
> > > >
> > > > But. If INIT forks a child C, dup_mm() will copy int3 installed by =
perf.
> > > > So the child C will hit this breakpoint and cal handle_swbp/etc for=
 no
> > > > reason every time it calls some_hot_function(), not good.
> > > >
> > > > That is why uprobe_perf_func() calls uprobe_perf_filter() which ret=
urns
> > > > UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() w=
ill
> > > > call unapply_uprobe() which will remove this breakpoint from C->mm.
> > >
> > > thanks for the info, I wasn't aware this was the intention
> > >
> > > uprobe_multi does not have perf event mechanism/check, so it's using
> > > the filter function to do the process filtering.. which is not workin=
g
> > > properly as you pointed out earlier
> >
> > So this part I don't completely get. I get that using task->mm
> > comparison is wrong due to CLONE_VM, but why same_thread_group() check
> > is wrong? I.e., why task->signal comparison is wrong?
>
> the way I understand it is that we take the group leader task and
> store it in bpf_uprobe_multi_link::task
>
> but it can exit while the rest of the threads is still running so
> the uprobe_multi_link_filter won't match them (leader->mm is NULL)

Aren't we conflating two things here? Yes, from what Oleg explained,
it's clear that using task->mm is wrong. So that is what I feel is the
main issue. We shouldn't use task->mm at all, only task->signal should
be used instead. We should fix that (in bpf tree, please).

But I don't get the concern about linux->mm or linux->signal becoming
NULL because of a task existing. Look at put_task_struct(), it WILL
NOT call __put_task_struct() (which then calls put_signal_struct()),
so task->signal at least will be there and valid until multi-uprobe is
detached and we call put_task().

So. Can you please send fixes against the bpf tree, switching to
task->signal? And maybe also include the fix to prevent
UPROBE_HANDLER_REMOVE to be returned from the BPF program?

This thread is almost 50 emails deep now, we should break out of it.
We can argue on your actual fixes. :)

>
> Oleg suggested change below (in addition to same_thread_group change)
> to take that in account
>
> jirka
>
>
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 98e395f1baae..9e6b390aa6da 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3235,9 +3235,23 @@ uprobe_multi_link_filter(struct uprobe_consumer *c=
on, enum uprobe_filter_ctx ctx
>                          struct mm_struct *mm)
>  {
>         struct bpf_uprobe *uprobe;
> +       struct task_struct *task, *t;
> +       bool ret =3D false;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> -       return uprobe->link->task->mm =3D=3D mm;
> +       task =3D uprobe->link->task;
> +
> +       rcu_read_lock();
> +       for_each_thread(task, t) {
> +               struct mm_struct *mm =3D READ_ONCE(t->mm);
> +               if (mm) {
> +                       ret =3D t->mm =3D=3D mm;
> +                       break;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return ret;
>  }
>
>  static int

