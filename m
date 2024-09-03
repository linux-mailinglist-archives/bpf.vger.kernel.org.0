Return-Path: <bpf+bounces-38812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40D96A638
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BF1F24DBC
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED397190462;
	Tue,  3 Sep 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYyM+RlP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F737F9DF;
	Tue,  3 Sep 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387081; cv=none; b=gUNn1hczjlfDxBtEGKBzuKgligHRIYobi/o7j8CzoBeawEANuDUTXqchEIlTyNdAQFyY8JOzQ+5Hb8T9I0mFFIjb4GeUzXQwr5Tsn6iy8PtAkG12L12BH0K3Yheclu7wuzO6CiLJwMLORxD1kaVBc79V1ZcCEyTCWb/KiDWcOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387081; c=relaxed/simple;
	bh=dNIWIqqCiaNITfAyTH3u02L4TYfuhMMyDlxxwVMJWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbwrIGVxaSbStd+oNTOxFCUZmOvsPjgjySoHTrdzMXCwFZR1Yeo08/tjaAHb8KlaK4TCn/7GM49D82eio0fBl/USnhQcOVsZ2yDrwHuX5NJzI1v+zGpn4/eqWdThCEUW9tasea5eXb4PNiU6Kfar0r9bxJ9bIX6ueMByy7p7HJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYyM+RlP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2114545a91.0;
        Tue, 03 Sep 2024 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387079; x=1725991879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMNGBJ16BmT9ddmWcXivFCq9/4Ppyyp/mx5s0aFYEec=;
        b=kYyM+RlPcw5uVC6kG53p9tWypk/MZg6SlcDc8XzMd+Kv6a2pvLQCSULE6vsqwA2636
         ahKF3R/4p6DN43RRc9YcEXgB2gPw4KvstG68noLbNPv6ke5u4mc1PPe/rs7kDRUIvUdl
         rAtiClaAGF+zocS1kTROj7XwGLGBt9yywdUBeE2zG2G4L4UXj5ByaySkZERDlAT9Pug+
         xVjgIDWUFUIwme+P5TCId8auYbfRr74tM13Io2wydSelIxvA11di8DY/s6jxZn175mbJ
         wFWkZZWv6+Kz0IS7TgStQ0eBDFoUuxoXMRiVfXBtQyrEFR5fBqhnZqJCvkjooFsnI7Es
         5Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387079; x=1725991879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMNGBJ16BmT9ddmWcXivFCq9/4Ppyyp/mx5s0aFYEec=;
        b=esH/t8JMDfVbmZRG80ivSxyAWm6MyI4LWPhxa9TjSYjIDqZdFqzT9LgaApHTspHtUB
         oXHqs7lfzYllkBkpsfCtssLF9VYWJSBRorH+95vxahJMQhQtzR0nZqmDn2kA25up/cvU
         qqQPmT7PBA1G/kFzWrjClBhrScq/soRjOSjNj0M7VXa+l8FLbbt8yHPuq4hSE02vl8u8
         6OxCmRLVtjjAbnZOuCFU89sZAkvXTKA2VsFN9gvgxXL/UlIEDSxpIXZVNQySjBo3hOgZ
         vwLQVn6FXm6Y7P11XbiOAldzsZ4/jALwL8zT5XRcz6y1ZpQfQATHMZ/ayQZrdHavT+GM
         f6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo+oZmRb8uccU/UkuJCrYG1SIy38iPwNG6rrvPrIveoX1j881yyH1+ZgNBWIKuWjItCOsvVQGSdIjPM1//t1g4pGuX@vger.kernel.org, AJvYcCX9hSWfjvj8p5Lemy90ZQneE/8zby+wvMkYHZz3xlOvEev7dM7nibpTL1xJHt1eVbl8TLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6CfnaJZmHLGi/3CIdw9SeDhpXsU0ay26ZK5rXy3unx172oeY
	VqKNe6KQ6/lFOp8/6RukF8VEdTEQMb8P5Vdb7pLQC8wEsOv/U8k0cs2OH3NfM22HdlXEazqMztH
	OlR5pxVXYNbazYlS1Vyw96LMD1VA=
X-Google-Smtp-Source: AGHT+IGtCiSi24fOth0IU8THOgozOYSW8ttPWPA1fdO3PXT/17IzfN9vmjt0gAhoGAx8+r6/E6r2x5scSEfNjHStihc=
X-Received: by 2002:a17:90b:1e08:b0:2d8:c302:a78f with SMTP id
 98e67ed59e1d1-2da630ecbbdmr3426922a91.23.1725387079401; Tue, 03 Sep 2024
 11:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com> <ZtHKTtn7sqaLeVxV@krava>
 <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com>
 <ZtWBRgM3TyhdiwKw@krava> <CAEf4BzZJdmppN2=pt-0D+LDsfc6rW=Jg_7Q6kEJXpsuv52ATNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJdmppN2=pt-0D+LDsfc6rW=Jg_7Q6kEJXpsuv52ATNQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 11:11:06 -0700
Message-ID: <CAEf4BzazK83Lw24j-MLNZ6PYwhC6CYN11Hw00+FBRgJ9PuxW=Q@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tianyi Liu <i.pear@outlook.com>, 
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	flaniel@linux.microsoft.com, albancrequy@linux.microsoft.com, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 2, 2024 at 2:11=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Fri, Aug 30, 2024 at 08:51:12AM -0700, Andrii Nakryiko wrote:
> > > On Fri, Aug 30, 2024 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Fri, Aug 30, 2024 at 12:12:09PM +0200, Oleg Nesterov wrote:
> > > > > The whole discussion was very confusing (yes, I too contributed t=
o the
> > > > > confusion ;), let me try to summarise.
> > > > >
> > > > > > U(ret)probes are designed to be filterable using the PID, which=
 is the
> > > > > > second parameter in the perf_event_open syscall. Currently, upr=
obe works
> > > > > > well with the filtering, but uretprobe is not affected by it.
> > > > >
> > > > > And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_p=
erf_func()
> > > > > misunderstands the purpose of uprobe_perf_filter().
> > > > >
> > > > > Lets forget about BPF for the moment. It is not that uprobe_perf_=
filter()
> > > > > does the filtering by the PID, it doesn't. We can simply kill thi=
s function
> > > > > and perf will work correctly. The perf layer in __uprobe_perf_fun=
c() does
> > > > > the filtering when perf_event->hw.target !=3D NULL.
> > > > >
> > > > > So why does uprobe_perf_filter() call uprobe_perf_filter()? Not t=
o avoid
> > > > > the __uprobe_perf_func() call (as the BPF code assumes), but to t=
rigger
> > > > > unapply_uprobe() in handler_chain().
> > > > >
> > > > > Suppose you do, say,
> > > > >
> > > > >       $ perf probe -x /path/to/libc some_hot_function
> > > > > or
> > > > >       $ perf probe -x /path/to/libc some_hot_function%return
> > > > > then
> > > > >       $perf record -e ... -p 1
> > > > >
> > > > > to trace the usage of some_hot_function() in the init process. Ev=
erything
> > > > > will work just fine if we kill uprobe_perf_filter()->uprobe_perf_=
filter().
> > > > >
> > > > > But. If INIT forks a child C, dup_mm() will copy int3 installed b=
y perf.
> > > > > So the child C will hit this breakpoint and cal handle_swbp/etc f=
or no
> > > > > reason every time it calls some_hot_function(), not good.
> > > > >
> > > > > That is why uprobe_perf_func() calls uprobe_perf_filter() which r=
eturns
> > > > > UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain()=
 will
> > > > > call unapply_uprobe() which will remove this breakpoint from C->m=
m.
> > > >
> > > > thanks for the info, I wasn't aware this was the intention
> > > >
> > > > uprobe_multi does not have perf event mechanism/check, so it's usin=
g
> > > > the filter function to do the process filtering.. which is not work=
ing
> > > > properly as you pointed out earlier
> > >
> > > So this part I don't completely get. I get that using task->mm
> > > comparison is wrong due to CLONE_VM, but why same_thread_group() chec=
k
> > > is wrong? I.e., why task->signal comparison is wrong?
> >
> > the way I understand it is that we take the group leader task and
> > store it in bpf_uprobe_multi_link::task
> >
> > but it can exit while the rest of the threads is still running so
> > the uprobe_multi_link_filter won't match them (leader->mm is NULL)
>
> Aren't we conflating two things here? Yes, from what Oleg explained,
> it's clear that using task->mm is wrong. So that is what I feel is the
> main issue. We shouldn't use task->mm at all, only task->signal should
> be used instead. We should fix that (in bpf tree, please).
>
> But I don't get the concern about linux->mm or linux->signal becoming

correction, we shouldn't worry about *linux->signal* becoming NULL.
linux->mm can become NULL, but we don't care about that (once we fix
filtering logic in multi-uprobe).

> NULL because of a task existing. Look at put_task_struct(), it WILL
> NOT call __put_task_struct() (which then calls put_signal_struct()),
> so task->signal at least will be there and valid until multi-uprobe is
> detached and we call put_task().
>
> So. Can you please send fixes against the bpf tree, switching to
> task->signal? And maybe also include the fix to prevent
> UPROBE_HANDLER_REMOVE to be returned from the BPF program?
>
> This thread is almost 50 emails deep now, we should break out of it.
> We can argue on your actual fixes. :)
>
> >
> > Oleg suggested change below (in addition to same_thread_group change)
> > to take that in account
> >
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 98e395f1baae..9e6b390aa6da 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3235,9 +3235,23 @@ uprobe_multi_link_filter(struct uprobe_consumer =
*con, enum uprobe_filter_ctx ctx
> >                          struct mm_struct *mm)
> >  {
> >         struct bpf_uprobe *uprobe;
> > +       struct task_struct *task, *t;
> > +       bool ret =3D false;
> >
> >         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> > -       return uprobe->link->task->mm =3D=3D mm;
> > +       task =3D uprobe->link->task;
> > +
> > +       rcu_read_lock();
> > +       for_each_thread(task, t) {
> > +               struct mm_struct *mm =3D READ_ONCE(t->mm);
> > +               if (mm) {
> > +                       ret =3D t->mm =3D=3D mm;
> > +                       break;
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       return ret;
> >  }
> >
> >  static int

