Return-Path: <bpf+bounces-39400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27A9728D2
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C46B1C23CEE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66117DFF8;
	Tue, 10 Sep 2024 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL4TdmPg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47C17D355;
	Tue, 10 Sep 2024 05:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945220; cv=none; b=h0Ed0vcwg0vlx0wHXGHylwuD7q5Jymy5zGBJcC4gdNG1UxSJsfWFHCvieL5vu7zSqurv13PLEEqIbd737mL3Kqygu5vEcrzRRwDmcYwraqRizc/ph2z8SyRFwYW01vKXAa5GjLY4Qit6vtHhOyLoyvHXEp76i2BWKjpgwY1Tvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945220; c=relaxed/simple;
	bh=QaUMIR2jAIriOPWTJeTYRrlgMY/AKXUdAomsZ6SCrTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALU6fPWz2nDaGkiFMhCmksgJedRIrugN720SGxHBABy/mYQQHKYxQbO/PK0HLC/nlv9/kuUV9hAWX0IzYzxFbk5muZaM4zvfXPvAVkAJiMogdA7RckgGLACKSLzTlr2lWxGtMu2Ib2/Wi7UEoXXcM5opGC09FyTorlnbIKLkQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL4TdmPg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-205909afad3so4205445ad.2;
        Mon, 09 Sep 2024 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725945218; x=1726550018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrcFRNmr5hZbZ96slhcvo9eITicm6QaTzwg2eqphYZM=;
        b=YL4TdmPgdRd+0249puCnAXQZy3bd8WpOgzvqt1c20SeKFtRd+tuFSk2Flm3Gr02HLf
         2tTww2OG7Kw69ux1E056VtkwwE2de4PJDWPAky2DS4E1mxbnqqKdNqG+sMlaSZrRXewM
         O0RTIIXhX1p2mqL61SV38KPlWixIKFa5YD1KmC+YO1OqvZyiWOL4Sp4rBABP9JICJwBg
         zoVDnRPfaKNY9j6okoXMoni7hsEgGe6WhV7OhYAdKZuyUznSNgGjYbQ4Zbc8uC9s5jo4
         mb5nwawuIhIPyZa/gzrOEsc/srIqtG2fqkV6zZfJeD00KW/Xq4lkaoZagoMzdA++0mxG
         YucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725945218; x=1726550018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrcFRNmr5hZbZ96slhcvo9eITicm6QaTzwg2eqphYZM=;
        b=ZWTYySBcilj2G5YVu2xV+zicOgPL/eoXKd6m39PdCyWzZdzE0P6EWSfMpQk3AMGsw+
         gGrSleWkOSjHfysbtGFccKoO834VnynBwTiO0pI99i0nccOt28IEyZ4W3uH3mBjuELnw
         NiSDw0TKjZq10HZirVqgeiBTE+V7D0eli6HKOiAFErAKnf6vUfJ7t5e/ZHPpAjUXck1r
         pC1tKRjg30QA+SyF2rmuRX2vYq+Q8UFJhRD1WCwLcnDO4A3hlJXbwGczg3xYcRizprQN
         is01X7JwWFiycIUtF/rtR3tjgVkfc9m9dRB22fo37i7xsxFguvdBFTpqS0Idx/UHEtMJ
         oRkw==
X-Forwarded-Encrypted: i=1; AJvYcCVB8ky7HJIpD6nnH3IqB5FWcqj5HrwMWCoyam5HR1J0QsG+jBVHINaxeCx3s64qNGC+x+o=@vger.kernel.org, AJvYcCWZmy6PpUyoicMoiaueHyBBNHLozzIPB9+Ax9e3b5OWH5rR1EaXBpL51oeu8Y0SClzJ2AZGn0EwnN50LajCyEPiKXGX@vger.kernel.org, AJvYcCXjvTKTVjSmd4xc/1VRJ1XIadBD1d2yP5qep527p/E11xrAOj70gdC8ID8zvim1QtcKP+2Qfhdnv6pc3uAZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5f8ngGEX8hdlQk9SZUFsoXa6JGVI9vHjiGQ2792IDfbMMVD+b
	qB3ehIjWLa/9PZbDxnzqSAc62pG3+liBNHwK8gMisf+IFnQVAwlr9uh0xGfEvUjzXcyFF64lNkH
	KWnNCRWboj4KfQequwcj2MX75vsk=
X-Google-Smtp-Source: AGHT+IGWSH7k1uV54/0MBpkfCOKW4zDfjkr742eQE81GTLjm0Cxzjn2iYMp2AwESyv1OkN1JTQdZy9tVlGoFiTekoVU=
X-Received: by 2002:a17:902:d2c1:b0:206:ac4b:8157 with SMTP id
 d9443c01a7336-2070a554645mr95706965ad.31.1725945217959; Mon, 09 Sep 2024
 22:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
 <CAADnVQLB2b5Uh-qthnCOfJk+v+ty1nQh6LjMDkzjt1BPtGOVZA@mail.gmail.com>
In-Reply-To: <CAADnVQLB2b5Uh-qthnCOfJk+v+ty1nQh6LjMDkzjt1BPtGOVZA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 22:13:25 -0700
Message-ID: <CAEf4Bzap+_fpXjfcnnqz7EH9=bGokpFbnoK==_YDWH855qx7=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 3:49=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> > makes it unsuitable to be called from more restricted context like soft=
irq.
> >
> > Let's make put_uprobe() agnostic to the context in which it is called,
> > and use work queue to defer the mutex-protected clean up steps.
> >
> > To avoid unnecessarily increasing the size of struct uprobe, we colocat=
e
> > work_struct in parallel with rb_node and rcu, both of which are unused
> > by the time we get to schedule clean up work.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index a2e6a57f79f2..377bd524bc8b 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/shmem_fs.h>
> >  #include <linux/khugepaged.h>
> >  #include <linux/rcupdate_trace.h>
> > +#include <linux/workqueue.h>
> >
> >  #include <linux/uprobes.h>
> >
> > @@ -54,14 +55,20 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
> >  #define UPROBE_COPY_INSN       0
> >
> >  struct uprobe {
> > -       struct rb_node          rb_node;        /* node in the rb tree =
*/
> > +       union {
> > +               struct {
> > +                       struct rb_node          rb_node;        /* node=
 in the rb tree */
> > +                       struct rcu_head         rcu;
> > +               };
> > +               /* work is used only during freeing, rcu and rb_node ar=
e unused at that point */
> > +               struct work_struct work;
> > +       };
> >         refcount_t              ref;
> >         struct rw_semaphore     register_rwsem;
> >         struct rw_semaphore     consumer_rwsem;
> >         struct list_head        pending_list;
> >         struct list_head        consumers;
> >         struct inode            *inode;         /* Also hold a ref to i=
node */
> > -       struct rcu_head         rcu;
> >         loff_t                  offset;
> >         loff_t                  ref_ctr_offset;
> >         unsigned long           flags;
> > @@ -620,11 +627,28 @@ static inline bool uprobe_is_active(struct uprobe=
 *uprobe)
> >         return !RB_EMPTY_NODE(&uprobe->rb_node);
> >  }
> >
> > +static void uprobe_free_deferred(struct work_struct *work)
> > +{
> > +       struct uprobe *uprobe =3D container_of(work, struct uprobe, wor=
k);
> > +
> > +       /*
> > +        * If application munmap(exec_vma) before uprobe_unregister()
> > +        * gets called, we don't get a chance to remove uprobe from
> > +        * delayed_uprobe_list from remove_breakpoint(). Do it here.
> > +        */
> > +       mutex_lock(&delayed_uprobe_lock);
> > +       delayed_uprobe_remove(uprobe, NULL);
> > +       mutex_unlock(&delayed_uprobe_lock);
> > +
> > +       kfree(uprobe);
> > +}
> > +
> >  static void uprobe_free_rcu(struct rcu_head *rcu)
> >  {
> >         struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu)=
;
> >
> > -       kfree(uprobe);
> > +       INIT_WORK(&uprobe->work, uprobe_free_deferred);
> > +       schedule_work(&uprobe->work);
> >  }
> >
> >  static void put_uprobe(struct uprobe *uprobe)
>
> It seems put_uprobe hunk was lost, since the patch is not doing
> what commit log describes.


Hmm, put_uprobe() has:

call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);

at the end (see [0], which added that), so we do schedule_work() in
RCU callback, similarly to what we do with bpf_map freeing in the BPF
subsystem.

This patch set is based on the latest tip/perf/core (and also assuming
the RCU Tasks Trace patch that mysteriously disappeared is actually
there, hopefully it will just as magically be restored).

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dperf/core&id=3D8617408f7a01e94ce1f73e40a7704530e5dfb25c

