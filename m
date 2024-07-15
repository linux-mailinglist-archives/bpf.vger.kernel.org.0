Return-Path: <bpf+bounces-34837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAE9319AF
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85000B22D21
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D6502BE;
	Mon, 15 Jul 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjSapmbT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77B4D8B1;
	Mon, 15 Jul 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064876; cv=none; b=nUld/A73ROBJcvAkXMuHpOBvVu7LIwyMWSkNYwl8BEG73rt6/HrpNe18roqtiTudgAPuoQZRDNw0Q8QGrLf29D/gwSEUPgymPWzRtNhzo/xBuEe7REOSGR8uRqnQw13TRo2i6xjYTVLHOv699xt4WTBTyIi1ly6Q/TIN3fMsJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064876; c=relaxed/simple;
	bh=ffeMUlmK/Fq3a35a+TUdvjumDs98NyO9DPbQao+X4dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2VGttuXYC2a9qNLYsspIgxi+sEUSE1XM0YlMnYTJqnfKdj6MhAFHST2i/Mo94VdTYZ4YksF47K+gicd5Dykay9z83lHcvxKafta8Yu+f8bRV+8U+uJRvXy749RWpMVau5smGTF3lFaruzM1CopMY5FqHxVO05P1ym/PXX6oJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjSapmbT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75e15a48d6aso2446690a12.0;
        Mon, 15 Jul 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064874; x=1721669674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYdxhbbHIWWH2ixkk73ZJszIT+H79ZWarOUTpgHr6qo=;
        b=hjSapmbTQzm+TJFcRVSTNPRUJ2o0my4c86m6lBjIeTHvOFRE2DBCVr4Qe1OM1P1zii
         7mg2+aGogkE8VIFacZtExddI/oSizC+A5neNjFntErOx6vkxdf24y6QfMZO5Z1Ibz4wq
         fsf2W+C6LoCK74hQCyrE2NIP+JZG5Gy0onKdOibG9wVbg2omkFWZf+W9yCRi+MSCJ940
         3zQluIPIO2FTM8M65TVzRkmkfKLozSd0RtpZMLEh5SMJTYRpqrakLnKN5Kg89DdWntZw
         Fi7rmiLPYQM9q8818bdfTZM6SrZ5z/oGlqyXsX5OSL0Cd+2uQ8L2X3g1M4k8kBeS9AOY
         7OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064874; x=1721669674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYdxhbbHIWWH2ixkk73ZJszIT+H79ZWarOUTpgHr6qo=;
        b=KNvIetSjtxmhVfFSe71XTHLKwnKFKgFR4PQhxdIqGWbE9lwysw47H1mLGIwbZ0c8CV
         vdFkYKFjMqj/gC/4SkpAVEdV9nbL2IF/Rtid/X93JY1N/6njToGyvKKhp9I8+7ZjLV1W
         HTjdQ2jxMf/ueap0Gy4/VVLsx+fj0H636SWe8zBy6cTpXW7IP4uJe3MU/Sjt/wlwWO8r
         8q3ztLJ1YflKkAM8tILcuekMpFmpbKihcBK7jP4IAC38AKMiz2i3zGf7h5JJ0AnGXcMv
         i0kbq7NNjOYqOQYl4w0Oc1YlFo/uSbbj2efF6jz51zUJsUUH1TUxsuCW5H0qtzCM/TLi
         Bzzw==
X-Forwarded-Encrypted: i=1; AJvYcCUbEn7GxmQKeYYnJ5ULY3DvnQJgwA89IdZVSjmhVuV7gZIFZfALW8F8mn1RlkRwQNrw00QBmh3QOYV71uGmZdMRRiK/blYwGkpvY9jWlX1z4cO8OJNUnbI6L1KK6Wb2aoVxUAeXTDv7s8mUsOlSGg/iaYnmqEQaJI5PF2jiel85GITl/i7I
X-Gm-Message-State: AOJu0YwFhNsxoAofQOWjvMNDWO5/PVGGE3biafut5N/C+teRQxgnzXbr
	flPHs/mVhCYZzoFcCDaNOJU9s9gHH0UMIlN1b65RhtZ1LROLhob+1UYMulAp0gezKTiOCQSSuoJ
	blCasZPKL77MfYxqA45PiO0lh37o=
X-Google-Smtp-Source: AGHT+IEKyiNYE5yqKdi2me9tunULdPdiJOcvYzgKX6xqeTAbuCCI0LIR26V0zznbOPmF45Mfc/7J4vVEZuk0mzk+LL0=
X-Received: by 2002:a05:6a20:7485:b0:1be:c9bd:7b8b with SMTP id
 adf61e73a8af0-1c3ee5bfc10mr718383637.45.1721064874075; Mon, 15 Jul 2024
 10:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110401.412779774@infradead.org>
 <CAEf4BzZCzqOsk55E0b8i9y5zFuf8t=zwrjORnVaLGK0ZVgJTFg@mail.gmail.com> <20240715114107.GE14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715114107.GE14400@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 10:34:22 -0700
Message-ID: <CAEf4BzaycyKxX7KFim0_C+FobPSDcfahUGA4mgfiz_d81noSGQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jul 12, 2024 at 02:43:52PM -0700, Andrii Nakryiko wrote:
> > + bpf
> >
> > On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > In order to put a bound on the uretprobe_srcu critical section, add a
> > > timer to uprobe_task. Upon every RI added or removed the timer is
> > > pushed forward to now + 1s. If the timer were ever to fire, it would
> > > convert the SRCU 'reference' to a refcount reference if possible.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/uprobes.h |    8 +++++
> > >  kernel/events/uprobes.c |   67 +++++++++++++++++++++++++++++++++++++=
+++++++----
> > >  2 files changed, 69 insertions(+), 6 deletions(-)
> > >
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/rbtree.h>
> > >  #include <linux/types.h>
> > >  #include <linux/wait.h>
> > > +#include <linux/timer.h>
> > >
> > >  struct vm_area_struct;
> > >  struct mm_struct;
> > > @@ -79,6 +80,10 @@ struct uprobe_task {
> > >         struct return_instance          *return_instances;
> > >         unsigned int                    depth;
> > >         unsigned int                    active_srcu_idx;
> > > +
> > > +       struct timer_list               ri_timer;
> > > +       struct callback_head            ri_task_work;
> > > +       struct task_struct              *task;
> > >  };
> > >
> > >  struct return_instance {
> > > @@ -86,7 +91,8 @@ struct return_instance {
> > >         unsigned long           func;
> > >         unsigned long           stack;          /* stack pointer */
> > >         unsigned long           orig_ret_vaddr; /* original return ad=
dress */
> > > -       bool                    chained;        /* true, if instance =
is nested */
> > > +       u8                      chained;        /* true, if instance =
is nested */
> > > +       u8                      has_ref;
> >
> > Why bool -> u8 switch? You don't touch chained, so why change its
> > type? And for has_ref you interchangeably use 0 and true for the same
> > field. Let's stick to bool as there is nothing wrong with it?
>
> sizeof(_Bool) is implementation defined. It is 1 for x86_64, but there
> are platforms where it ends up begin 4 (some PowerPC ABIs among others.
> I didn't want to grow this structure for no reason.

There are tons of bools in the kernel, surprised that we (kernel
makefiles) don't do anything on PowerPC to keep it consistent with the
rest of the world. Oh well, it just kind of looks off when there is a
mix of 0 and true used for the same field.

>
> > >         int                     srcu_idx;
> > >
> > >         struct return_instance  *next;          /* keep as stack */
> >
> > [...]
> >
> > > @@ -1822,13 +1864,20 @@ static int dup_utask(struct task_struct
> > >                         return -ENOMEM;
> > >
> > >                 *n =3D *o;
> > > -               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx)=
;
> > > +               if (n->uprobe) {
> > > +                       if (n->has_ref)
> > > +                               get_uprobe(n->uprobe);
> > > +                       else
> > > +                               __srcu_clone_read_lock(&uretprobes_sr=
cu, n->srcu_idx);
> > > +               }
> > >                 n->next =3D NULL;
> > >
> > >                 *p =3D n;
> > >                 p =3D &n->next;
> > >                 n_utask->depth++;
> > >         }
> > > +       if (n_utask->return_instances)
> > > +               mod_timer(&n_utask->ri_timer, jiffies + HZ);
> >
> > let's add #define for HZ, so it's adjusted in just one place (instead
> > of 3 as it is right now)
>
> Can do I suppose.

thanks!

>
> > Also, we can have up to 64 levels of uretprobe nesting, so,
> > technically, the user can cause a delay of 64 seconds in total. Maybe
> > let's use something smaller than a full second? After all, if the
> > user-space function has high latency, then this refcount congestion is
> > much less of a problem. I'd set it to something like 50-100 ms for
> > starters.
>
> Before you know it we'll have a sysctl :/ But sure, we can do something
> shorter.

:) let's hope we won't need sysctl (I don't think we will, FWIW)

