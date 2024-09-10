Return-Path: <bpf+bounces-39506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC09740FD
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53711286E1E
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010041A38EF;
	Tue, 10 Sep 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsaUMZZq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BC1A257F;
	Tue, 10 Sep 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990408; cv=none; b=a1lbbuZ+2Xw0SH9w7EczPJWPft1PkhDgpnwBLkg7rgCAtSDuCLM2oxuQVMl5jDwad7iPAe6NrIJriDd0QPogErRoxZp8g9b5uSObo/6WQi9UXhETf3fdXTcf1QAFEq4lxZaAfsfFuZ1SHe2xKPrBhDQzXOS8hiJwVShaLAzJxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990408; c=relaxed/simple;
	bh=oq3TwfeUsbj6XfnpSy530AJBNf5yy04dJqQRICtmE2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO+vzgNXeScxAJ5aNGYUtlf2sXyc/58fUUspxFjS6q78CbZBMDZL6nmxHjRotMcqojXKp9Gj2a3SDxtJOjrnFtRo1j1OC3/wGxOEyolBWuGnqAtQ9mTBtMHtcynCQr4gubnbAxbzq9EDt92BwgJ2gsSROlNJiQ0pnA1f9aC+Tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsaUMZZq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso3919203a91.3;
        Tue, 10 Sep 2024 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990406; x=1726595206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrPZRqYD8vb0U0kbpXhCgO6QKzZ/J8dZQO1DZCPG1pA=;
        b=dsaUMZZq6HRa5ih8+OpSwAUG4+jySCmZ4Ck7/LkfHv3pg9jMD1Pi5dFceyy5m4X+Ut
         LpdSpqGmAw4aXrSwPE3ydRFTOgS6sKbkug0Z1NpCftpHcUMFrnpTOe7zn+LYMfADkxS1
         +ZiyPp/oPrFwly0/JxX8cyV9pDg8ks9+9VTTzvt0ojmnRijHI2s35oTYO5i8p17AcwSX
         RM+LeTgRX2kfxsFcIAE6gMQK0oTihn/ZYRc+2Nnm4W2eWxXIOpTi+PMfncmT1NeWSK8r
         adE91HldnHOX+OzsKrKF9n/u0/AG2lcwO2NoLRbAdPb96g/Lzy9kPbOG8NjA4AyXmQ6a
         2iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990406; x=1726595206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrPZRqYD8vb0U0kbpXhCgO6QKzZ/J8dZQO1DZCPG1pA=;
        b=YWiQMBSjCjriOFRyc7hmnXIBfir0GjwHqG3iggGMHXFbxyqTwXNe/u1Atdr6F6p6iu
         EZvYxD7DGJ7j9cfeCgF7apo5Suys/1ljB8p23DOWcvRN7S20E7TzsNyiiml02vBIX+oB
         gEfB449s4skZLgOzp1xJ3vIwb4eUgPu6YmurguBOELogO5dN+JZHzF0ejNxhSLUGHSEx
         bq6GTJGiWQL6zD8qvUMAWXbOpAckUqNCtp5+XPEX4IuF+05ggnhaz1iuBH7ZJ8Ur3tfJ
         1Dj6EkoWbLc7+f87JB1kHdq1UcRsmiD3l8ZUl33nVDJaIMxBMz0NQ6LHVQcQhUNF1z5D
         dqyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6UyoRD238UsEV9vn+LgQrb3S8R5xwuRk/4Vt8OPRjiFVoy6YOcqKNJnceUu83449XF0c=@vger.kernel.org, AJvYcCWCjxGoUK1fqVXILPt4qJrADuzzhwDL/BkZiHVCRuHlU4d5fkM7vgaMlgGD1BFhr4kSDv7bqaCNfHEDdNZg@vger.kernel.org, AJvYcCX1vSs9/hkk1uOzsUDdwTN890OBC4UgdHuwWsnkL18ci5t7e6FQmPLWHnKcMle5s5Uz/QEda/6ItxI2o54UIzCG/D1t@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAWHwag9pGmNEP2cX+23vLIQEWmETk8ZrcuEIXPxaryrlXT5m
	hvMkOgJ5PZ8AzeOQayRrmPSmMl9QnY9kuHud/0JeEk93fhXsj8DvUuxwjzkwsyeY2T2jTXNcXJD
	68c8xnssNHWTP8PiEYokW9LTsmms=
X-Google-Smtp-Source: AGHT+IFhJZTLetK1QTl58MXbvwDrRJGeYVXNM1W1WJjxhKO2fUTbXCSXOV85rpbYX2WdAvv6jpBsZw58z+WnX+FY8eo=
X-Received: by 2002:a17:90b:380b:b0:2d8:94d6:3499 with SMTP id
 98e67ed59e1d1-2daffe28fefmr14877509a91.37.1725990406094; Tue, 10 Sep 2024
 10:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
 <CAADnVQLB2b5Uh-qthnCOfJk+v+ty1nQh6LjMDkzjt1BPtGOVZA@mail.gmail.com>
 <CAEf4Bzap+_fpXjfcnnqz7EH9=bGokpFbnoK==_YDWH855qx7=g@mail.gmail.com> <CAADnVQ+v2PXWurcpt7xGiKf32HqaBWmFiZgjb2TGJg-rJGWjSg@mail.gmail.com>
In-Reply-To: <CAADnVQ+v2PXWurcpt7xGiKf32HqaBWmFiZgjb2TGJg-rJGWjSg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 10:46:33 -0700
Message-ID: <CAEf4BzbZOs4mRw5hHcOgc7zKrDNjd-HLHOp25KjDyy2fsfJcBw@mail.gmail.com>
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

On Tue, Sep 10, 2024 at 8:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 10:13=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 7:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 9, 2024 at 3:49=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > >
> > > > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), w=
hich
> > > > makes it unsuitable to be called from more restricted context like =
softirq.
> > > >
> > > > Let's make put_uprobe() agnostic to the context in which it is call=
ed,
> > > > and use work queue to defer the mutex-protected clean up steps.
> > > >
> > > > To avoid unnecessarily increasing the size of struct uprobe, we col=
ocate
> > > > work_struct in parallel with rb_node and rcu, both of which are unu=
sed
> > > > by the time we get to schedule clean up work.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/events/uprobes.c | 30 +++++++++++++++++++++++++++---
> > > >  1 file changed, 27 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index a2e6a57f79f2..377bd524bc8b 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/shmem_fs.h>
> > > >  #include <linux/khugepaged.h>
> > > >  #include <linux/rcupdate_trace.h>
> > > > +#include <linux/workqueue.h>
> > > >
> > > >  #include <linux/uprobes.h>
> > > >
> > > > @@ -54,14 +55,20 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
> > > >  #define UPROBE_COPY_INSN       0
> > > >
> > > >  struct uprobe {
> > > > -       struct rb_node          rb_node;        /* node in the rb t=
ree */
> > > > +       union {
> > > > +               struct {
> > > > +                       struct rb_node          rb_node;        /* =
node in the rb tree */
> > > > +                       struct rcu_head         rcu;
> > > > +               };
> > > > +               /* work is used only during freeing, rcu and rb_nod=
e are unused at that point */
> > > > +               struct work_struct work;
> > > > +       };
> > > >         refcount_t              ref;
> > > >         struct rw_semaphore     register_rwsem;
> > > >         struct rw_semaphore     consumer_rwsem;
> > > >         struct list_head        pending_list;
> > > >         struct list_head        consumers;
> > > >         struct inode            *inode;         /* Also hold a ref =
to inode */
> > > > -       struct rcu_head         rcu;
> > > >         loff_t                  offset;
> > > >         loff_t                  ref_ctr_offset;
> > > >         unsigned long           flags;
> > > > @@ -620,11 +627,28 @@ static inline bool uprobe_is_active(struct up=
robe *uprobe)
> > > >         return !RB_EMPTY_NODE(&uprobe->rb_node);
> > > >  }
> > > >
> > > > +static void uprobe_free_deferred(struct work_struct *work)
> > > > +{
> > > > +       struct uprobe *uprobe =3D container_of(work, struct uprobe,=
 work);
> > > > +
> > > > +       /*
> > > > +        * If application munmap(exec_vma) before uprobe_unregister=
()
> > > > +        * gets called, we don't get a chance to remove uprobe from
> > > > +        * delayed_uprobe_list from remove_breakpoint(). Do it here=
.
> > > > +        */
> > > > +       mutex_lock(&delayed_uprobe_lock);
> > > > +       delayed_uprobe_remove(uprobe, NULL);
> > > > +       mutex_unlock(&delayed_uprobe_lock);
> > > > +
> > > > +       kfree(uprobe);
> > > > +}
> > > > +
> > > >  static void uprobe_free_rcu(struct rcu_head *rcu)
> > > >  {
> > > >         struct uprobe *uprobe =3D container_of(rcu, struct uprobe, =
rcu);
> > > >
> > > > -       kfree(uprobe);
> > > > +       INIT_WORK(&uprobe->work, uprobe_free_deferred);
> > > > +       schedule_work(&uprobe->work);
> > > >  }
> > > >
> > > >  static void put_uprobe(struct uprobe *uprobe)
> > >
> > > It seems put_uprobe hunk was lost, since the patch is not doing
> > > what commit log describes.
> >
> >
> > Hmm, put_uprobe() has:
> >
> > call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
> >
> > at the end (see [0], which added that), so we do schedule_work() in
> > RCU callback, similarly to what we do with bpf_map freeing in the BPF
> > subsystem.
> >
> > This patch set is based on the latest tip/perf/core (and also assuming
> > the RCU Tasks Trace patch that mysteriously disappeared is actually
> > there, hopefully it will just as magically be restored).
> >
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commi=
t/?h=3Dperf/core&id=3D8617408f7a01e94ce1f73e40a7704530e5dfb25c
>
> I'm still not following.
> put_uprobe() did delayed_uprobe_remove() and this patch is doing it again=
.
>
> The commit log implies that mutex+delayed_uprobe_remove should be removed
> from put_uprobe(), but that's not what the patch is doing.

Ah, that part. You are right, it's my bad. I copied that lock to a
work queue callback, but didn't remove it from the put_uprobe(). Will
fix it in v2, thanks for catching!

