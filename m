Return-Path: <bpf+bounces-55258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB68A7A968
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AC61896CFE
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B01252908;
	Thu,  3 Apr 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgxm7gBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBF18BC1D;
	Thu,  3 Apr 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705057; cv=none; b=KHp1WCXSzG+EMfDNl3Jdjt0UQ6iIMcgMnGTsE0ZQrjL9XxIVY6KUXIFGbB0WmGOvwnDDj0OpuZPKLtLdjd3cuHfknQ6PAP1WPkrPli0gnBE8NwqrSEqn3RhmplWoJBKA/FZatQA9YGdpjMth9YdLKv5msCtMHpWF3Vvk1CGAxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705057; c=relaxed/simple;
	bh=pTXRHDZut6BiauTObf1HmfWdawjo1n4+6THjTd6Jzzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1hV5TkyBqgG1G8ERQssmNGq2OI/QHaNeQayKD5RViXOTcmoPkXP7jlxodmd34drfHXv8hOfd7CNCsGqAsRzlC1Wch/xDZt0aVdG7cryx8G2eLgrHOgUYAH0OBUmedHOhVNSsGzl1t3q1jgNl5M8HAEzBGZjpWvNxntcJ9ExKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgxm7gBt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227a8cdd241so15289595ad.3;
        Thu, 03 Apr 2025 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743705055; x=1744309855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XQ5bzpPWGMno9H+d92L40wcGAI7ZaJD+7IW9W+Ughk=;
        b=Sgxm7gBtWoAkBojTlLTi8/lR8NbviTk/afC18/QWVFFQHGw1XBS0TX5MptZmOyxeE/
         s4s/CvJFYt5xEFJq4LkRySzbWAgDstkFpfKDvGcwQfufHUq28iy6sq03ZZNHscrUEjsV
         VbSMS0bTRE4Q0wuc0jbGHg1WhvR3kpafUGp5BLuy/GNMLecq/nnU3EMwGvWAwitDwvJ9
         wuyj0wToatqzPnFO1nFMN+OIsJ4MehkMlhv3u5sGLVHM+E01uK6bvTguUg8P98+9BAR5
         9GYunHvBtq3dbGDjcK9u37l0A+fp6pRDHGL/PZYfPk2AK7VBADf8biQqMWQ6uXjBKkBL
         jLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743705055; x=1744309855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XQ5bzpPWGMno9H+d92L40wcGAI7ZaJD+7IW9W+Ughk=;
        b=t+iosDyWrDEzfrxPCVRuFai+zrG+X56xb6r/ScL1Qr0q1IUZlrCa1CKpAfTtY7l74Y
         l5w/U0YY0iVm7lmJxVPAZakS4GHUGHMeAGjNAubgoZVQlfe6y0I17d2tPpI1vLSa3vD5
         evrGeW0W1qm5O2ZWpMIXG+kyJl8xXVBcepzbaFrxxeOfReV46GTb1vuhVHwmEmPUh443
         rEtWPCn9MaEtvLZcwVMt1H76IZpmWnsWylA6f07oYuhPuboRmTMzQzTNSp0j+Lx0qarW
         EJQlgXGHBdjhGVIgmz0/w+iRBPwrKQvhlhcyxMXaa0A5/3LK1EKzzC4X86MwSN1PHWnV
         c2dw==
X-Forwarded-Encrypted: i=1; AJvYcCVPxSQ+j7r/O1YW33FO3MflyrldElbH34fH8fQEGuJAcdg1q/temZCZ1jD+pBCBhporwOkRo1f4m+9C+fvqiRv/Ee+e@vger.kernel.org, AJvYcCW/HFcCjoS3MB5JKgZDFu5+hIB2b53K/f0Bz2J5MGhIKkpM+HMZjBo7+bZ2+KKT210LPY/EcTOQ5cjQBkGG@vger.kernel.org, AJvYcCXQ4y0Spz6gj3cpCd/YM4W8fCht6XfqNRhUxRIrJJHdS1IhpR1huOJ5qmNkMXggpc+P+tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcilm68nkP5MJrBoPEdqtafIQX0u4u1Iqc05SmlR9QMe1oQJ6I
	YGZe5wOiqMxzYIgXW10rX3ntsXMrNKjHaMttQTwGOS6zJkV7kxCelCo6NKPokaa5vC2/25YR20K
	pZqgX+SMR6zycMMWNhmIt7gk+5aQ=
X-Gm-Gg: ASbGnctfmEHU50N/a2v9WzfJvhg5TexTHaYmdEHMYFKYSQDMgIfNQuXSggcDHI0VBu/
	3yI8eNvoL3NINV4+xvoLgBIPn7Nh5YyyP1/OkuU8kAQL/EHOZYpVllml/NtjQykzwYd1G4DBk2Q
	hFyx6cdFiuLExXt4mp+dLh7EsBzmMNrXw668bpy3K2Xg==
X-Google-Smtp-Source: AGHT+IEAgBRhTJ2RoXuCvnO1B3Vh8Ne3y2Ag74MVg9aDQbB2SvvU6B27qseJuhIqC2kFrmiB57Ut/e4y6DgfJ+3Q56U=
X-Received: by 2002:a17:902:f642:b0:220:e896:54e1 with SMTP id
 d9443c01a7336-22a8a06af6amr2437155ad.26.1743705054733; Thu, 03 Apr 2025
 11:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403171831.3803479-1-andrii@kernel.org> <20250403174917.OLHfwBp-@linutronix.de>
In-Reply-To: <20250403174917.OLHfwBp-@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 3 Apr 2025 11:30:42 -0700
X-Gm-Features: AQ5f1JpgARnocJIWAqdQmnruOiRITZ2QEWNn6_YQ6W5fcMcbnt9xaWvAxvTpFN4
Message-ID: <CAEf4BzasxUn+Ywi-=TtP+S+i4VBLnKvYCkxPCz63o4zEXT9QZw@mail.gmail.com>
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	oleg@redhat.com, mhiramat@kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:49=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-04-03 10:18:31 [-0700], Andrii Nakryiko wrote:
> > Avoid a false-positive lockdep warning in PREEMPT_RT configuration when
> > using write_seqcount_begin() in uprobe timer callback by using
> > raw_write_* APIs. Uprobe's use of timer callback is guaranteed to not
> > race with itself, and as such seqcount's insistence on having hardirqs
> preemption, not hardirqs
>
> > disabled on the writer side is irrelevant. So switch to raw_ variants o=
f
> > seqcount API instead of disabling hardirqs unnecessarily.
> >
> > Also, point out in the comments more explicitly why we use seqcount
> > despite our reader side being rather simple and never retrying. We favo=
r
> > well-maintained kernel primitive in favor of open-coding our own memory
> > barriers.
>
> Thank you.
>
> > Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUq=
QDhLFYL3D6xPxg@mail.gmail.com/
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Suggested-by: Sebastian Sewior <bigeasy@linutronix.de>
> > Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple =
uretprobes within task")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 70c84b9d7be3..6d7e7da0fbbc 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1944,6 +1944,9 @@ static void free_ret_instance(struct uprobe_task =
*utask,
> >        * to-be-reused return instances for future uretprobes. If ri_tim=
er()
> >        * happens to be running right now, though, we fallback to safety=
 and
> >        * just perform RCU-delated freeing of ri.
> > +      * Admittedly, this is a rather simple use of seqcount, but it ni=
cely
> > +      * abstracts away all the necessary memory barriers, so we use
> > +      * a well-supported kernel primitive here.
> >        */
> >       if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
> >               /* immediate reuse of ri without RCU GP is OK */
> > @@ -2004,12 +2007,18 @@ static void ri_timer(struct timer_list *timer)
> >       /* RCU protects return_instance from freeing. */
> >       guard(rcu)();
> >
> > -     write_seqcount_begin(&utask->ri_seqcount);
>
> > +     /* See free_ret_instance() for notes on seqcount use.
>
> This is not a proper multi line comment.

yep, will fix; no, uprobe is not networking, this style is just
ingrained in my brain from working in BPF code base for a while

>
> > +      * We also employ raw API variants to avoid lockdep false-positiv=
e
> > +      * warning complaining about hardirqs not being disabled. We have
>
> s/hardirqs/preemption. The warning is about missing disabled preemption.

Right, sorry, the `this_cpu_read(hardirqs_enabled)` part of the check
in lockdep_assert_preemption_disabled() made too strong an impression
on me :) Will fix.

>
> > +      * a guarantee that this timer callback won't race with itself, s=
o no
> > +      * need to disable hardirqs.
>
> The timer can only be invoked once for a uprobe_task. Therefore there
> can only be one writer. The reader does not require an even sequence
> count so it is okay to remain preemptible on PREEMPT_RT.
>
> > +      */
> > +     raw_write_seqcount_begin(&utask->ri_seqcount);
> >
> >       for_each_ret_instance_rcu(ri, utask->return_instances)
> >               hprobe_expire(&ri->hprobe, false);
> >
> > -     write_seqcount_end(&utask->ri_seqcount);
> > +     raw_write_seqcount_end(&utask->ri_seqcount);
> >  }
> >
> >  static struct uprobe_task *alloc_utask(void)
>
> Sebastian

