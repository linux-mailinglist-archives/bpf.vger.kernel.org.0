Return-Path: <bpf+bounces-36655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5194B44E
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1089F1C21AA8
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B532114;
	Thu,  8 Aug 2024 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBM+Uy/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFA1FBA;
	Thu,  8 Aug 2024 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078052; cv=none; b=XVHQ7i7+mXMq7ZaBghTZxfRcJ+I9hHk+8AWiAln6dQZvLj3PlHLNA0iLEqoeVOsfzc43u0QlJeGLnZ9SFvxqrs3l1iAD10fJI7UPIpwZFjuTYk6czNHOx8IAbylAIXua2+Se/cA0NhfRec4OTYSoiLZYtd8psI6cwSJmGSBrLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078052; c=relaxed/simple;
	bh=CLobMc1mkh83xplfPIs+ye2lsShEu5eLBbqz0w7SpXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KImSUxtd5nwG3745yno7RIyImSvRbvmx8rcJ81YBFanpKJqRAvsGB59ExvYiIuVhR0YRqmD0inze175UdpipeiYvMUonDhmvwvW/hBDOVJGvsRbou16M8SOmQeVIgGXkegPnSjRAZepiG5O7MsauS7PA+x/4Ud6/KWX5rELkXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBM+Uy/k; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso312928a12.2;
        Wed, 07 Aug 2024 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723078050; x=1723682850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgG57ggiW8yo3NCcMsg+flgpEKg2u9n5rxgBtDE1RMI=;
        b=BBM+Uy/k7uzAkSzoQxSc//Twfkj3esHBvyX2vptwVrWQstc06uHfXrbg8FFThmGtS0
         S7Q+w6NURi6nou/xJsAGNUPbUrjKUFw78COv7LMxSND+qeHu/U+vBDQittTyYy/jX63y
         Ei69+k9RMI4rWMu++GlhWQXXpxx7tTq7gsGM8gvaN1zGwswkqdWZTq06S3hHgIE+wCSj
         nJbQ63uUgzG33zRe6eyY/mOGKFQxeM21RxxMmshSz8YWxm+VkQ3ZPKuZT5b8qOYkldOg
         HCyHPpNug2A/1wKSKFOk7VlZ2CGgxn3p882p5H8wCmGS9wKjEJbDYWeS3Fx2BjOy9e0a
         gbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723078050; x=1723682850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgG57ggiW8yo3NCcMsg+flgpEKg2u9n5rxgBtDE1RMI=;
        b=QMBiROKuXzXtuvvGlnJVJTARaimd9ealbvAdTJmrpMGfHTTeEYYxdf6svNsUut9950
         ojmsad5zHw/0SPugaB2rvDP++nr0m7AW2VcxV9lTMuItGLKd1rkQ2qWnJ7+OwOr7yUL1
         EGkM9hbv8qSgB/nYx/k/8c5bW0ztlUVWGhJCJSQtMaCqyC5J+GJwjeK6g9iy4bXxZ8/+
         Uz3nCFrEteI6y9Fl8p7mLfyxJb02O/NPq+rkxzn4CS3KEJWPFJs2uHqv9nuj8Nf8CNB6
         AmNuNRhcbTTQhX8FOPJit420J30c13T5Qf+m0v5nxmfX8HEm8bFFBfr8xYiL20VwxLjq
         Ru3g==
X-Forwarded-Encrypted: i=1; AJvYcCU/fqhblyKmKMYxzOmx7/C4PYoD9JTZumwMDEt7R4CPZy2tRuUFt/ZKPayY1mWbGNDoejq0pBvNjnUIZrURrYGsMrf1r/wSGddykP8GZd0r6wEvL5dyD/z4Q5ioo2nFirb8
X-Gm-Message-State: AOJu0YxUdOC1/SNAKWmbCkmmFewauxAeLnP88+zfoY43JRZQX9hpLJiq
	u7V5CnoyJiBUIRhLzjep5ffymkvHivMPcMU6CNxyQOcyPQp50KuWIdPZlkLa/rHu+ufFp5BPAyt
	I5dtIkhAE0NHxs1ZOb/9q1gNHpMQ=
X-Google-Smtp-Source: AGHT+IFkw2BcSSnC5ONjY08z7Ch9Ar+Rw4EBHqpXpioThM5p1pn6X/bdFzI7yRNgseCpW9hnAZ3hzLdj32oCffwHrQE=
X-Received: by 2002:a05:6a20:430e:b0:1c2:8af6:31d3 with SMTP id
 adf61e73a8af0-1c6fce83508mr271571637.10.1723078049974; Wed, 07 Aug 2024
 17:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zo1hBFS7c_J-Yx-7@casper.infradead.org> <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net> <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org> <20240730131058.GN33588@noisy.programming.kicks-ass.net>
 <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
 <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com>
 <20240803085312.GP39708@noisy.programming.kicks-ass.net> <CAEf4BzYPpkhKtuaT-EbyKeB13-uBeYf8LjR9CB=xaXYHnwsyAQ@mail.gmail.com>
 <CAEf4BzZ26FNTguRh_X9_5eQZvOeKb+c-o3mxSzoM2+TF3NqaWA@mail.gmail.com>
 <CAJuCfpFqEjG7HCx1F=Q3fScYAhaAou0Un2SFpibimkxZr7Jsbw@mail.gmail.com>
 <CAJuCfpGsDbcDy9s7NwZuaf2S+v9RMGjoC9NUVszDG3kwCMHCXg@mail.gmail.com>
 <CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjcA2+6k69Q@mail.gmail.com>
 <CAJuCfpFp+_n_t7ufKt=uEdoaeMykpEVZXCcsj5wqOMvJq+EcHw@mail.gmail.com> <CAJuCfpF5P=o-jh0HHtn=VARRwfg59EuZOFghNjQVUD7Q2JQxUw@mail.gmail.com>
In-Reply-To: <CAJuCfpF5P=o-jh0HHtn=VARRwfg59EuZOFghNjQVUD7Q2JQxUw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 17:47:17 -0700
Message-ID: <CAEf4BzaYWkobJRaduFRYQDYpftfg0Ahj1t=g99mGmGrkB-nU-w@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, 
	Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:34=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 11:04=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 5:49=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 10:13=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Aug 6, 2024 at 6:36=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 9:08=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Aug 4, 2024 at 4:22=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Aug 3, 2024 at 1:53=E2=80=AFAM Peter Zijlstra <peterz=
@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko w=
rote:
> > > > > > > >
> > > > > > > > > Is there any reason why the approach below won't work?
> > > > > > > >
> > > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/upro=
bes.c
> > > > > > > > > index 8be9e34e786a..e21b68a39f13 100644
> > > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > > @@ -2251,6 +2251,52 @@ static struct uprobe
> > > > > > > > > *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_s=
wb
> > > > > > > > >         struct uprobe *uprobe =3D NULL;
> > > > > > > > >         struct vm_area_struct *vma;
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > > > > +       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM=
_MAYSHARE, vm_flags;
> > > > > > > > > +       struct file *vm_file;
> > > > > > > > > +       struct inode *vm_inode;
> > > > > > > > > +       unsigned long vm_pgoff, vm_start, vm_end;
> > > > > > > > > +       int vm_lock_seq;
> > > > > > > > > +       loff_t offset;
> > > > > > > > > +
> > > > > > > > > +       rcu_read_lock();
> > > > > > > > > +
> > > > > > > > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > > > > > > > +       if (!vma)
> > > > > > > > > +               goto retry_with_lock;
> > > > > > > > > +
> > > > > > > > > +       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
> > > > > > > >
> > > > > > > > So vma->vm_lock_seq is only updated on vma_start_write()
> > > > > > >
> > > > > > > yep, I've looked a bit more at the implementation now
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +       vm_file =3D READ_ONCE(vma->vm_file);
> > > > > > > > > +       vm_flags =3D READ_ONCE(vma->vm_flags);
> > > > > > > > > +       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXE=
C)
> > > > > > > > > +               goto retry_with_lock;
> > > > > > > > > +
> > > > > > > > > +       vm_inode =3D READ_ONCE(vm_file->f_inode);
> > > > > > > > > +       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
> > > > > > > > > +       vm_start =3D READ_ONCE(vma->vm_start);
> > > > > > > > > +       vm_end =3D READ_ONCE(vma->vm_end);
> > > > > > > >
> > > > > > > > None of those are written with WRITE_ONCE(), so this buys y=
ou nothing.
> > > > > > > > Compiler could be updating them one byte at a time while yo=
u load some
> > > > > > > > franken-update.
> > > > > > > >
> > > > > > > > Also, if you're in the middle of split_vma() you might not =
get a
> > > > > > > > consistent set.
> > > > > > >
> > > > > > > I used READ_ONCE() only to prevent the compiler from re-readi=
ng those
> > > > > > > values. We assume those values are garbage anyways and double=
-check
> > > > > > > everything, so lack of WRITE_ONCE doesn't matter. Same for
> > > > > > > inconsistency if we are in the middle of split_vma().
> > > > > > >
> > > > > > > We use the result of all this speculative calculation only if=
 we find
> > > > > > > a valid uprobe (which could be a false positive) *and* if we =
detect
> > > > > > > that nothing about VMA changed (which is what I got wrong, bu=
t
> > > > > > > honestly I was actually betting on others to help me get this=
 right
> > > > > > > anyways).
> > > > > > >
> > > > > > > >
> > > > > > > > > +       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
> > > > > > > > > +               goto retry_with_lock;
> > > > > > > > > +
> > > > > > > > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp=
_vaddr - vm_start);
> > > > > > > > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > > > > > > +       if (!uprobe)
> > > > > > > > > +               goto retry_with_lock;
> > > > > > > > > +
> > > > > > > > > +       /* now double check that nothing about VMA change=
d */
> > > > > > > > > +       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
> > > > > > > > > +               goto retry_with_lock;
> > > > > > > >
> > > > > > > > Since vma->vma_lock_seq is only ever updated at vma_start_w=
rite() you're
> > > > > > > > checking you're in or after the same modification cycle.
> > > > > > > >
> > > > > > > > The point of sequence locks is to check you *IN* a modifica=
tion cycle
> > > > > > > > and retry if you are. You're now explicitly continuing if y=
ou're in a
> > > > > > > > modification.
> > > > > > > >
> > > > > > > > You really need:
> > > > > > > >
> > > > > > > >    seq++;
> > > > > > > >    wmb();
> > > > > > > >
> > > > > > > >    ... do modification
> > > > > > > >
> > > > > > > >    wmb();
> > > > > > > >    seq++;
> > > > > > > >
> > > > > > > > vs
> > > > > > > >
> > > > > > > >   do {
> > > > > > > >           s =3D READ_ONCE(seq) & ~1;
> > > > > > > >           rmb();
> > > > > > > >
> > > > > > > >           ... read stuff
> > > > > > > >
> > > > > > > >   } while (rmb(), seq !=3D s);
> > > > > > > >
> > > > > > > >
> > > > > > > > The thing to note is that seq will be odd while inside a mo=
dification
> > > > > > > > and even outside, further if the pre and post seq are both =
even but not
> > > > > > > > identical, you've crossed a modification and also need to r=
etry.
> > > > > > > >
> > > > > > >
> > > > > > > Ok, I don't think I got everything you have written above, so=
rry. But
> > > > > > > let me explain what I think I need to do and please correct w=
hat I
> > > > > > > (still) got wrong.
> > > > > > >
> > > > > > > a) before starting speculation,
> > > > > > >   a.1) read and remember current->mm->mm_lock_seq (using
> > > > > > > smp_load_acquire(), right?)
> > > > > > >   a.2) read vma->vm_lock_seq (using smp_load_acquire() I pres=
ume)
> > > > > > >   a.3) if vm_lock_seq is odd, we are already modifying VMA, s=
o bail
> > > > > > > out, try with proper mmap_lock
> > > > > > > b) proceed with the inode pointer fetch and offset calculatio=
n as I've coded it
> > > > > > > c) lookup uprobe by inode+offset, if failed -- bail out (if s=
ucceeded,
> > > > > > > this could still be wrong)
> > > > > > > d) re-read vma->vm_lock_seq, if it changed, we started modify=
ing/have
> > > > > > > already modified VMA, bail out
> > > > > > > e) re-read mm->mm_lock_seq, if that changed -- presume VMA go=
t
> > > > > > > modified, bail out
> > > > > > >
> > > > > > > At this point we should have a guarantee that nothing about m=
m
> > > > > > > changed, nor that VMA started being modified during our specu=
lative
> > > > > > > calculation+uprobe lookup. So if we found a valid uprobe, it =
must be a
> > > > > > > correct one that we need.
> > > > > > >
> > > > > > > Is that enough? Any holes in the approach? And thanks for tho=
roughly
> > > > > > > thinking about this, btw!
> > > > > >
> > > > > > Ok, with slight modifications to the details of the above (e.g.=
, there
> > > > > > is actually no "odd means VMA is being modified" thing with
> > > > > > vm_lock_seq),
> > > > >
> > > > > Correct. Instead of that (vm_lock_seq->vm_lock_seq =3D=3D mm->mm_=
lock_seq)
> > > > > means your VMA is write-locked and is being modified.
> > > > >
> > > > > > I ended up with the implementation below. Basically we
> > > > > > validate that mm->mm_lock_seq didn't change and that vm_lock_se=
q !=3D
> > > > > > mm_lock_seq (which otherwise would mean "VMA is being modified"=
).
> > > > >
> > > > > Validating that mm->mm_lock_seq did not change does not provide y=
ou
> > > > > with useful information. It only means that between the point whe=
re
> > > > > you recorded mm->mm_lock_seq and where you are checking it, there=
 was
> > > > > an mmap_write_unlock() or mmap_write_downgrade() call. Your VMA m=
ight
> > > > > not have even been part of that modification for which mmap_lock =
was
> > > > > taken.
> > > > >
> > > > > In theory what you need is simpler (simplified code for explanati=
on only):
> > > > >
> > > > > int vm_lock_seq =3D vma->vm_lock_seq;
> > > > > if (vm_lock_seq =3D=3D mm->mm_lock_seq)
> > > > >         goto bail_out; /* VMA is write-locked */
> > > > >
> > > > > /* copy required VMA attributes */
> > > > >
> > > > > if (vm_lock_seq !=3D vma->vm_lock_seq)
> > > > >         goto bail_out; /* VMA got write-locked */
> > > > >
> > > > > But this would require proper ACQUIRE/RELEASE semantics for
> > > > > vma->vm_lock_seq which is currently not there because all reads/w=
rites
> > > > > to vma->vm_lock_seq that matter are done under vma->vm_lock->lock
> > > > > protection, so additional ordering is not required. If you decide=
 to
> > > > > add that semantics for vma->vm_lock_seq, please make sure that
> > > > > pagefault path performance does not regress.
> > > > >
> > > > > > There is a possibility that vm_lock_seq =3D=3D mm_lock_seq just=
 by
> > > > > > accident, which is not a correctness problem, we'll just fallba=
ck to
> > > > > > locked implementation until something about VMA or mm_struct it=
self
> > > > > > changes. Which is fine, and if mm folks ever change this lockin=
g
> > > > > > schema, this might go away.
> > > > > >
> > > > > > If this seems on the right track, I think we can just move
> > > > > > mm_start_vma_specuation()/mm_end_vma_speculation() into
> > > > > > include/linux/mm.h.
> > > > > >
> > > > > > And after thinking a bit more about READ_ONCE() usage, I change=
d them
> > > > > > to data_race() to not trigger KCSAN warnings. Initially I kept
> > > > > > READ_ONCE() only around vma->vm_file access, but given we never=
 change
> > > > > > it until vma is freed and reused (which would be prevented by
> > > > > > guard(rcu)), I dropped READ_ONCE() and only added data_race(). =
And
> > > > > > even data_race() is probably not necessary.
> > > > > >
> > > > > > Anyways, please see the patch below. Would be nice if mm folks
> > > > > > (Suren?) could confirm that this is not broken.
> > > > > >
> > > > > >
> > > > > >
> > > > > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > > > > Date:   Fri Aug 2 22:16:40 2024 -0700
> > > > > >
> > > > > >     uprobes: add speculative lockless VMA to inode resolution
> > > > > >
> > > > > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > >
> > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > index 3de311c56d47..bee7a929ff02 100644
> > > > > > --- a/kernel/events/uprobes.c
> > > > > > +++ b/kernel/events/uprobes.c
> > > > > > @@ -2244,6 +2244,70 @@ static int is_trap_at_addr(struct mm_str=
uct
> > > > > > *mm, unsigned long vaddr)
> > > > > >         return is_trap_insn(&opcode);
> > > > > >  }
> > > > > >
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +static inline void mm_start_vma_speculation(struct mm_struct *=
mm, int
> > > > > > *mm_lock_seq)
> > > > > > +{
> > > > > > +       *mm_lock_seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > > > > > +}
> > > > > > +
> > > > > > +/* returns true if speculation was safe (no mm and vma modific=
ation
> > > > > > happened) */
> > > > > > +static inline bool mm_end_vma_speculation(struct vm_area_struc=
t *vma,
> > > > > > int mm_lock_seq)
> > > > > > +{
> > > > > > +       int mm_seq, vma_seq;
> > > > > > +
> > > > > > +       mm_seq =3D smp_load_acquire(&vma->vm_mm->mm_lock_seq);
> > > > > > +       vma_seq =3D READ_ONCE(vma->vm_lock_seq);
> > > > > > +
> > > > > > +       return mm_seq =3D=3D mm_lock_seq && vma_seq !=3D mm_seq=
;
> > > > >
> > > > > After spending some time on this I think what you do here is
> > > > > semantically correct but sub-optimal.
> > > >
> > >
> > > Yes, requiring that mm_lock_seq doesn't change is too pessimistic, bu=
t
> > > relative to the frequency of uprobe/uretprobe triggering (and how fas=
t
> > > the lookup is) this won't matter much. Absolute majority of uprobe
> > > lookups will manage to succeed while none of mm's VMAs change at all.
> > > So I felt like that's ok, at least for starters.
> > >
> > > My goal is to minimize intrusion into purely mm-related code, this
> > > whole uprobe work is already pretty large and sprawling, I don't want
> > > to go on another quest to change locking semantics for vma, if I don'=
t
> > > absolutely have to :) But see below for adjusted logic based on your
> > > comments.
> > >
> > > > Actually, after staring at this code some more I think
> > > > vma->vm_lock_seq not having proper ACQUIRE/RELEASE semantics would
> > > > bite us here as well. The entire find_active_uprobe_speculative()
> > > > might be executing while mmap_lock is write-locked (so, mm_seq =3D=
=3D
> > > > mm_lock_seq is satisfied) and we might miss that the VMA is locked =
due
> > > > to vma->vm_lock_seq read/write reordering. Though it's late and I
> > > > might have missed some memory barriers which would prevent this
> > > > scenario...
> > >
> > > So, please bear with me, if it's a stupid question. But don't all
> > > locks have implicit ACQUIRE and RELEASE semantics already? At least
> > > that's my reading of Documentation/memory-barriers.txt.
> > >
> > > So with that, wouldn't it be OK to just change
> > > READ_ONCE(vma->vm_lock_seq) to smp_load_acquire(&vma->vm_lock_seq) an=
d
> > > mitigate the issue you pointed out?
> > >
> > >
> > > So maybe something like below:
> > >
> > > rcu_read_lock()
> > >
> > > vma =3D find_vma(...)
> > > if (!vma) /* bail */
> > >
> > > vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
> > > mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
> > > /* I think vm_lock has to be acquired first to avoid the race */
> > > if (mm_lock_seq =3D=3D vm_lock_seq)
> > >     /* bail, vma is write-locked */
> > >
> > > ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
> > >
> > > if (smp_load_acquire(&vma->vm_lock_seq) !=3D vm_lock_seq)
> > >     /* bail, VMA might have changed */
> > >
> > > Thoughts?
> >
> > Hi Andrii,
> > I've prepared a quick patch following Peter's suggestion in [1] to
> > make mm->mm_lock_seq a proper seqcount. I'll post it shortly as RFC so
> > you can try it out. I think that would be a much cleaner solution.
> > I'll post a link to it shortly.
>
> The RFC is posted at
> https://lore.kernel.org/all/20240807182325.2585582-1-surenb@google.com/.

Yep, looks good, thanks a lot! Applied locally and will be running
tests and benchmarks. If anything comes up, I'll let you know.

> With that patch you can do:
>
> bool success =3D false;
> int seq;
>
> if (!mmap_lock_speculation_start(mm, &seq)) /* bail out */
>
> rcu_read_lock()
> vma =3D find_vma(...)
> if (!vma) /* rcu_read_unlock and bail out */
> /* obtain vma->vm_file->f_inode */
> rcu_read_unlock();
>
> if (!mmap_lock_speculation_end(mm, seq)) /* bail out */
>
> > Thanks,
> > Suren.
> >
> > [1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programmin=
g.kicks-ass.net/
> >
> >
> > >
> > > >
> > > > > This check means that there was no call to
> > > > > mmap_write_unlock()/mmap_write_downgrade() since
> > > > > mm_start_vma_speculation() and the vma is not currently locked. T=
o
> > > > > unlock a write-locked VMA you do need to call
> > > > > map_write_unlock()/mmap_write_downgrade(), so I think this check =
would
> > > > > guarantee that your vma was not locked and modified from under us=
.
> > > > > However this will also trigger false positives if
> > > > > mmap_write_unlock()/mmap_write_downgrade() was called but the vma=
 you
> > > > > are using was never locked. So, it will bail out more than necess=
ary.
> > > > > Maybe it's ok?
> > > > >
> > > > > > +}
> > > > > > +
> > >
> > > [...]

