Return-Path: <bpf+bounces-39481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4D973CC9
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB71C24861
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFE1A00C5;
	Tue, 10 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4/GvzsM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8C14F12C;
	Tue, 10 Sep 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983787; cv=none; b=HUkNd1UCXnfoxfSyuKF3r/taUAx+hXwwvuQKUb4NLHWkCr24d5dRuDwiYpBI46Ig+HHNejsjanZKrUh3fppWqjidkQ0J4yWV9M3fxA8D16N/m57GMo9aD3vrUgtA88Ni1mqwstXyJqlM44VuomCB2/evMr5KDyzkJKn5SPjUTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983787; c=relaxed/simple;
	bh=RmjvCuPJxR1h7+htFpSDFvemsvqOLZ0jJXC9aMgghLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoCI3wYn79dkt6Z4tNQskBLzNgEp1Mx4IZB68/zkY6NCmew1wmzsPBPGTIIuvqSrNsDc54WX25IaEnsN35QwqMM8/g9yuHve3QbXKPsGpPqDp1nTgjMwhO9mbymKrZ+BP3FfuFesnPJXekAEQiP4WHK0SNJbtkpxzzXg4l15lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4/GvzsM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c5bab490so4260647f8f.1;
        Tue, 10 Sep 2024 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725983784; x=1726588584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJaBuk9O8XTeUn+tXdjD8n8fSiu133fBeIfYRY7Bi8E=;
        b=F4/GvzsMqv16UblS13ZoDMyx3aPb7HogfAe4TXUDnDKRZ51j/vr5Qb+kFAiQkxDlGB
         R7H5/UmeFvW06k1N9qM2GYtcSXvs3N+wRtduwZufSB7vSrXSULdbHfzgqnjNdJgQnRfp
         MSUQpXMPvVMtyNcmlb9OqkmN/GMiRlr5Z+ykXGqcc/ysgbraukIZOgjwswfExnrCglhj
         iaBStooQivzDv8Ga+jf9uV6r2ABx31jswApmvom2gf9kjdeAylFcvZIRXwsGJP7No/e4
         cPYOvnR66pM8SqZrkIM66pnR4h2UoTfpLVmm6DGCpOwdxd/IFo8mSSarjHxsLQHir2Mh
         Bfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983784; x=1726588584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJaBuk9O8XTeUn+tXdjD8n8fSiu133fBeIfYRY7Bi8E=;
        b=d4IlM4JlnIbCkJ3qsu5rR4Tn9FMt0Iim8RrZukJscW03u2WnLI+iQlw9RSTmyePX2I
         nmhtiSAYN3h5HfgByH7sMURL/z35cnyS6au50bUiqC4vTtrJIoTA/D9bekwdoWL0ER82
         yAw0VbjeEOe06+luazENecAnFQHRvRKhaD7W4KT4TvWqJFvrVwVMb8xSb1geWWWQ3LCt
         9CewY5w3Wwjy8Or958MBgjwIgvVYJFsWPZFctMsbGatBIDNojDgQcb+w7zz+rZIBYc39
         R9ACA6PRneAAGba0hyzZRzMUxtB29LNKQHCSxGVwXPa5dVyA8Z8WDaXNBFv2XMUrD1uB
         e5ew==
X-Forwarded-Encrypted: i=1; AJvYcCUoOUdrnIOeeqe3acGZjxEsphep6osDikV8tCnOAIkUJl1SFb78MJen4+6CA42tCw+EkHcPMX3wFfFekZq/SLPieak5@vger.kernel.org, AJvYcCV3v0/p8xSVyBR6/G6LwlBDUHF+R96qOaKFPdn8Cp8re3uYjwYoqH2ZirWYNtK2/qW3QwU=@vger.kernel.org, AJvYcCWyh/KlYYYCAc3Ux+e12izPnUH1Di+ftI2CJd8fVKJwE3HoCCjxnRrEA9yT3ucGWZYF9srckEPQW1zityFW@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9XGtta1l8LI9GtnaKnK2JcWYfmQANvPKyWNsxEc01wr0wUXl
	DVq1ePp2iivNZrTtpeSOCslE2pgnftzCGnofid+GGWwD2br2i7Ab2Flg+iQDPljkULhOdAhZZN/
	+tSM58LDezNXcxBOyN7X+M0zET8w=
X-Google-Smtp-Source: AGHT+IE4X4eyk/q1xl+//vS/ZQL+Hjg0B9t+SUyldVyNCcpm+SBgpHzZIZChEdvXKzArZSo8NFhjma/7C1UTyUKoLoQ=
X-Received: by 2002:a05:6000:1ac7:b0:374:c6b6:c656 with SMTP id
 ffacd0b85a97d-378a8a3de4cmr2838167f8f.21.1725983784086; Tue, 10 Sep 2024
 08:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
 <CAADnVQLB2b5Uh-qthnCOfJk+v+ty1nQh6LjMDkzjt1BPtGOVZA@mail.gmail.com> <CAEf4Bzap+_fpXjfcnnqz7EH9=bGokpFbnoK==_YDWH855qx7=g@mail.gmail.com>
In-Reply-To: <CAEf4Bzap+_fpXjfcnnqz7EH9=bGokpFbnoK==_YDWH855qx7=g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 08:56:13 -0700
Message-ID: <CAADnVQ+v2PXWurcpt7xGiKf32HqaBWmFiZgjb2TGJg-rJGWjSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:13=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 7:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 3:49=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), whi=
ch
> > > makes it unsuitable to be called from more restricted context like so=
ftirq.
> > >
> > > Let's make put_uprobe() agnostic to the context in which it is called=
,
> > > and use work queue to defer the mutex-protected clean up steps.
> > >
> > > To avoid unnecessarily increasing the size of struct uprobe, we coloc=
ate
> > > work_struct in parallel with rb_node and rcu, both of which are unuse=
d
> > > by the time we get to schedule clean up work.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 30 +++++++++++++++++++++++++++---
> > >  1 file changed, 27 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index a2e6a57f79f2..377bd524bc8b 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/shmem_fs.h>
> > >  #include <linux/khugepaged.h>
> > >  #include <linux/rcupdate_trace.h>
> > > +#include <linux/workqueue.h>
> > >
> > >  #include <linux/uprobes.h>
> > >
> > > @@ -54,14 +55,20 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
> > >  #define UPROBE_COPY_INSN       0
> > >
> > >  struct uprobe {
> > > -       struct rb_node          rb_node;        /* node in the rb tre=
e */
> > > +       union {
> > > +               struct {
> > > +                       struct rb_node          rb_node;        /* no=
de in the rb tree */
> > > +                       struct rcu_head         rcu;
> > > +               };
> > > +               /* work is used only during freeing, rcu and rb_node =
are unused at that point */
> > > +               struct work_struct work;
> > > +       };
> > >         refcount_t              ref;
> > >         struct rw_semaphore     register_rwsem;
> > >         struct rw_semaphore     consumer_rwsem;
> > >         struct list_head        pending_list;
> > >         struct list_head        consumers;
> > >         struct inode            *inode;         /* Also hold a ref to=
 inode */
> > > -       struct rcu_head         rcu;
> > >         loff_t                  offset;
> > >         loff_t                  ref_ctr_offset;
> > >         unsigned long           flags;
> > > @@ -620,11 +627,28 @@ static inline bool uprobe_is_active(struct upro=
be *uprobe)
> > >         return !RB_EMPTY_NODE(&uprobe->rb_node);
> > >  }
> > >
> > > +static void uprobe_free_deferred(struct work_struct *work)
> > > +{
> > > +       struct uprobe *uprobe =3D container_of(work, struct uprobe, w=
ork);
> > > +
> > > +       /*
> > > +        * If application munmap(exec_vma) before uprobe_unregister()
> > > +        * gets called, we don't get a chance to remove uprobe from
> > > +        * delayed_uprobe_list from remove_breakpoint(). Do it here.
> > > +        */
> > > +       mutex_lock(&delayed_uprobe_lock);
> > > +       delayed_uprobe_remove(uprobe, NULL);
> > > +       mutex_unlock(&delayed_uprobe_lock);
> > > +
> > > +       kfree(uprobe);
> > > +}
> > > +
> > >  static void uprobe_free_rcu(struct rcu_head *rcu)
> > >  {
> > >         struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rc=
u);
> > >
> > > -       kfree(uprobe);
> > > +       INIT_WORK(&uprobe->work, uprobe_free_deferred);
> > > +       schedule_work(&uprobe->work);
> > >  }
> > >
> > >  static void put_uprobe(struct uprobe *uprobe)
> >
> > It seems put_uprobe hunk was lost, since the patch is not doing
> > what commit log describes.
>
>
> Hmm, put_uprobe() has:
>
> call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
>
> at the end (see [0], which added that), so we do schedule_work() in
> RCU callback, similarly to what we do with bpf_map freeing in the BPF
> subsystem.
>
> This patch set is based on the latest tip/perf/core (and also assuming
> the RCU Tasks Trace patch that mysteriously disappeared is actually
> there, hopefully it will just as magically be restored).
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/=
?h=3Dperf/core&id=3D8617408f7a01e94ce1f73e40a7704530e5dfb25c

I'm still not following.
put_uprobe() did delayed_uprobe_remove() and this patch is doing it again.

The commit log implies that mutex+delayed_uprobe_remove should be removed
from put_uprobe(), but that's not what the patch is doing.

