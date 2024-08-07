Return-Path: <bpf+bounces-36616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4E94AFE6
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A70F281F73
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E9143C60;
	Wed,  7 Aug 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdMzcxkV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2020143722
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055649; cv=none; b=daXqv3y/yyjAz9mMH235W4NKnR89zMzNIEZU99uO00qhB/fF9SpM0XSSJ4tdAhRERBucHyJqYLCFYTVN4CD3noHrXhl7WXYn2NXdSiIBeIhbYzfYw/jZ4bahstpW06vd+G7HRRB2P6PyQWpdLLPo5B7BDBhUZcgaBChtHXgTPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055649; c=relaxed/simple;
	bh=MT/lQe9QlAHcJpuc1sL//YsJ70ZKTzWRacETbZHKL9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo8nkOzCU2KYMoWGKsQDKTpiyEX8h8qWFgmHGxgYr7nFQ26zKgcgu1cby/HMOBaAxJcsEn7zgo/T5ML7QJk/avh8X50HX9Bu/YV0Px2tbf6nIq/dElWEd1+3wFKmabauQgfZk8sjruW49Lq8RYcR3kNzvj0xO8G/xUCx2EcXSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdMzcxkV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-699d8dc6744so5714007b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723055644; x=1723660444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUseDj6ACgtQl3lwemaAhPNyHvapgvVKdjbXWFS/cY=;
        b=rdMzcxkVabgwhEjaoaM6f7kWRNHNA7ZjmLwudS5HEczKBuaBUnDgYoCSl9f96F0XIY
         qoxqFyMbzAt9g4grNoWLDOpmy7/NRVfUkHllxeUlk57incGOK4ggf3wXTqX7A0vPjZkm
         n9S0tl6VWGldzoS8jHp3U0d+X4BXLKruX+qprihOqm8gfLtBbQ0QzXHCKRg/czGZhRMs
         6klB2RGLjHWLYoG372rrl3Srnh6Das2xpAjozIgVnwaenH+GeV6FgiFcwP59SGO/u0W1
         5rPXmC6zO0892k9Udd9PYPji/+ZKSz6y4WKwzYyw4JTaF/ds5wVp7nOh0qlr65YTY95N
         bo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055644; x=1723660444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SUseDj6ACgtQl3lwemaAhPNyHvapgvVKdjbXWFS/cY=;
        b=RPVWPRxLOD5JmZbdP37egI5/sx7f50E7+uivtYJ/gRvbbk+ULuJ6xtQ27IruuPrRbH
         yMFTrwTnr31cn8zCG1GLzHEw2TlexdakV1/HTKyAcV0RcN61IXrMrnVKyp4bUr2M48mz
         RX2r6n590UN01/TNlUvFRsaWZgKSPzW95PGBQmQCx3uqWXPtCtmCljvwkWKIGOmdEnvv
         2k78U+tUQfUb4PqacC+vNvl3wQAG6m2X2DXtofzY9ilGDQllTWRHImTj1WQbs3+Cp5s3
         wnGm33NDoxOwp4dP9lIoPTjqLsaSNPXUkAk3j0Ysych4KmxKG++iL6FcCHQbt/7bfaMo
         9p9w==
X-Forwarded-Encrypted: i=1; AJvYcCVbBwqzvBD7a/dYBIkRTQ4ajIiGLakQ4ai6WSqYLRDSeemLD93P7CK3LulTMvrgqH6Ej1aMYAxDfDqbcVV810jc8lyb
X-Gm-Message-State: AOJu0YymkiT8mKQxRy5bpzXx8G94QjjfduqBp8PHXmdWENavY+vcSvNf
	BVWExAtQc1VvY22fu3iGBHHm7gP/FD1FBDUaGw61qWcCMfKrkamUDmD3LTfxAtGZtuQXA06+6SX
	CzQUZksxbEfu7nt1i9ANuszQSXVhcGNw1m4BW
X-Google-Smtp-Source: AGHT+IHDpqFiEma4BWmBM1Tl+j5xpqekOPgJ2GeXAtbyPrfAZ1B8x802lhzbpHF0novwaG+BeEaNvJ0cm2/FX8/WgQA=
X-Received: by 2002:a0d:f143:0:b0:65f:7c41:30b2 with SMTP id
 00721157ae682-6990fb2f86amr28854327b3.3.1723055644046; Wed, 07 Aug 2024
 11:34:04 -0700 (PDT)
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
 <CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjcA2+6k69Q@mail.gmail.com> <CAJuCfpFp+_n_t7ufKt=uEdoaeMykpEVZXCcsj5wqOMvJq+EcHw@mail.gmail.com>
In-Reply-To: <CAJuCfpFp+_n_t7ufKt=uEdoaeMykpEVZXCcsj5wqOMvJq+EcHw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 7 Aug 2024 11:33:49 -0700
Message-ID: <CAJuCfpF5P=o-jh0HHtn=VARRwfg59EuZOFghNjQVUD7Q2JQxUw@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, 
	Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:04=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 5:49=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 10:13=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 6:36=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 9:08=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Sun, Aug 4, 2024 at 4:22=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Aug 3, 2024 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko wro=
te:
> > > > > > >
> > > > > > > > Is there any reason why the approach below won't work?
> > > > > > >
> > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobe=
s.c
> > > > > > > > index 8be9e34e786a..e21b68a39f13 100644
> > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > @@ -2251,6 +2251,52 @@ static struct uprobe
> > > > > > > > *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> > > > > > > >         struct uprobe *uprobe =3D NULL;
> > > > > > > >         struct vm_area_struct *vma;
> > > > > > > >
> > > > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > > > +       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_M=
AYSHARE, vm_flags;
> > > > > > > > +       struct file *vm_file;
> > > > > > > > +       struct inode *vm_inode;
> > > > > > > > +       unsigned long vm_pgoff, vm_start, vm_end;
> > > > > > > > +       int vm_lock_seq;
> > > > > > > > +       loff_t offset;
> > > > > > > > +
> > > > > > > > +       rcu_read_lock();
> > > > > > > > +
> > > > > > > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > > > > > > +       if (!vma)
> > > > > > > > +               goto retry_with_lock;
> > > > > > > > +
> > > > > > > > +       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
> > > > > > >
> > > > > > > So vma->vm_lock_seq is only updated on vma_start_write()
> > > > > >
> > > > > > yep, I've looked a bit more at the implementation now
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +       vm_file =3D READ_ONCE(vma->vm_file);
> > > > > > > > +       vm_flags =3D READ_ONCE(vma->vm_flags);
> > > > > > > > +       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXEC)
> > > > > > > > +               goto retry_with_lock;
> > > > > > > > +
> > > > > > > > +       vm_inode =3D READ_ONCE(vm_file->f_inode);
> > > > > > > > +       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
> > > > > > > > +       vm_start =3D READ_ONCE(vma->vm_start);
> > > > > > > > +       vm_end =3D READ_ONCE(vma->vm_end);
> > > > > > >
> > > > > > > None of those are written with WRITE_ONCE(), so this buys you=
 nothing.
> > > > > > > Compiler could be updating them one byte at a time while you =
load some
> > > > > > > franken-update.
> > > > > > >
> > > > > > > Also, if you're in the middle of split_vma() you might not ge=
t a
> > > > > > > consistent set.
> > > > > >
> > > > > > I used READ_ONCE() only to prevent the compiler from re-reading=
 those
> > > > > > values. We assume those values are garbage anyways and double-c=
heck
> > > > > > everything, so lack of WRITE_ONCE doesn't matter. Same for
> > > > > > inconsistency if we are in the middle of split_vma().
> > > > > >
> > > > > > We use the result of all this speculative calculation only if w=
e find
> > > > > > a valid uprobe (which could be a false positive) *and* if we de=
tect
> > > > > > that nothing about VMA changed (which is what I got wrong, but
> > > > > > honestly I was actually betting on others to help me get this r=
ight
> > > > > > anyways).
> > > > > >
> > > > > > >
> > > > > > > > +       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
> > > > > > > > +               goto retry_with_lock;
> > > > > > > > +
> > > > > > > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_v=
addr - vm_start);
> > > > > > > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > > > > > +       if (!uprobe)
> > > > > > > > +               goto retry_with_lock;
> > > > > > > > +
> > > > > > > > +       /* now double check that nothing about VMA changed =
*/
> > > > > > > > +       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
> > > > > > > > +               goto retry_with_lock;
> > > > > > >
> > > > > > > Since vma->vma_lock_seq is only ever updated at vma_start_wri=
te() you're
> > > > > > > checking you're in or after the same modification cycle.
> > > > > > >
> > > > > > > The point of sequence locks is to check you *IN* a modificati=
on cycle
> > > > > > > and retry if you are. You're now explicitly continuing if you=
're in a
> > > > > > > modification.
> > > > > > >
> > > > > > > You really need:
> > > > > > >
> > > > > > >    seq++;
> > > > > > >    wmb();
> > > > > > >
> > > > > > >    ... do modification
> > > > > > >
> > > > > > >    wmb();
> > > > > > >    seq++;
> > > > > > >
> > > > > > > vs
> > > > > > >
> > > > > > >   do {
> > > > > > >           s =3D READ_ONCE(seq) & ~1;
> > > > > > >           rmb();
> > > > > > >
> > > > > > >           ... read stuff
> > > > > > >
> > > > > > >   } while (rmb(), seq !=3D s);
> > > > > > >
> > > > > > >
> > > > > > > The thing to note is that seq will be odd while inside a modi=
fication
> > > > > > > and even outside, further if the pre and post seq are both ev=
en but not
> > > > > > > identical, you've crossed a modification and also need to ret=
ry.
> > > > > > >
> > > > > >
> > > > > > Ok, I don't think I got everything you have written above, sorr=
y. But
> > > > > > let me explain what I think I need to do and please correct wha=
t I
> > > > > > (still) got wrong.
> > > > > >
> > > > > > a) before starting speculation,
> > > > > >   a.1) read and remember current->mm->mm_lock_seq (using
> > > > > > smp_load_acquire(), right?)
> > > > > >   a.2) read vma->vm_lock_seq (using smp_load_acquire() I presum=
e)
> > > > > >   a.3) if vm_lock_seq is odd, we are already modifying VMA, so =
bail
> > > > > > out, try with proper mmap_lock
> > > > > > b) proceed with the inode pointer fetch and offset calculation =
as I've coded it
> > > > > > c) lookup uprobe by inode+offset, if failed -- bail out (if suc=
ceeded,
> > > > > > this could still be wrong)
> > > > > > d) re-read vma->vm_lock_seq, if it changed, we started modifyin=
g/have
> > > > > > already modified VMA, bail out
> > > > > > e) re-read mm->mm_lock_seq, if that changed -- presume VMA got
> > > > > > modified, bail out
> > > > > >
> > > > > > At this point we should have a guarantee that nothing about mm
> > > > > > changed, nor that VMA started being modified during our specula=
tive
> > > > > > calculation+uprobe lookup. So if we found a valid uprobe, it mu=
st be a
> > > > > > correct one that we need.
> > > > > >
> > > > > > Is that enough? Any holes in the approach? And thanks for thoro=
ughly
> > > > > > thinking about this, btw!
> > > > >
> > > > > Ok, with slight modifications to the details of the above (e.g., =
there
> > > > > is actually no "odd means VMA is being modified" thing with
> > > > > vm_lock_seq),
> > > >
> > > > Correct. Instead of that (vm_lock_seq->vm_lock_seq =3D=3D mm->mm_lo=
ck_seq)
> > > > means your VMA is write-locked and is being modified.
> > > >
> > > > > I ended up with the implementation below. Basically we
> > > > > validate that mm->mm_lock_seq didn't change and that vm_lock_seq =
!=3D
> > > > > mm_lock_seq (which otherwise would mean "VMA is being modified").
> > > >
> > > > Validating that mm->mm_lock_seq did not change does not provide you
> > > > with useful information. It only means that between the point where
> > > > you recorded mm->mm_lock_seq and where you are checking it, there w=
as
> > > > an mmap_write_unlock() or mmap_write_downgrade() call. Your VMA mig=
ht
> > > > not have even been part of that modification for which mmap_lock wa=
s
> > > > taken.
> > > >
> > > > In theory what you need is simpler (simplified code for explanation=
 only):
> > > >
> > > > int vm_lock_seq =3D vma->vm_lock_seq;
> > > > if (vm_lock_seq =3D=3D mm->mm_lock_seq)
> > > >         goto bail_out; /* VMA is write-locked */
> > > >
> > > > /* copy required VMA attributes */
> > > >
> > > > if (vm_lock_seq !=3D vma->vm_lock_seq)
> > > >         goto bail_out; /* VMA got write-locked */
> > > >
> > > > But this would require proper ACQUIRE/RELEASE semantics for
> > > > vma->vm_lock_seq which is currently not there because all reads/wri=
tes
> > > > to vma->vm_lock_seq that matter are done under vma->vm_lock->lock
> > > > protection, so additional ordering is not required. If you decide t=
o
> > > > add that semantics for vma->vm_lock_seq, please make sure that
> > > > pagefault path performance does not regress.
> > > >
> > > > > There is a possibility that vm_lock_seq =3D=3D mm_lock_seq just b=
y
> > > > > accident, which is not a correctness problem, we'll just fallback=
 to
> > > > > locked implementation until something about VMA or mm_struct itse=
lf
> > > > > changes. Which is fine, and if mm folks ever change this locking
> > > > > schema, this might go away.
> > > > >
> > > > > If this seems on the right track, I think we can just move
> > > > > mm_start_vma_specuation()/mm_end_vma_speculation() into
> > > > > include/linux/mm.h.
> > > > >
> > > > > And after thinking a bit more about READ_ONCE() usage, I changed =
them
> > > > > to data_race() to not trigger KCSAN warnings. Initially I kept
> > > > > READ_ONCE() only around vma->vm_file access, but given we never c=
hange
> > > > > it until vma is freed and reused (which would be prevented by
> > > > > guard(rcu)), I dropped READ_ONCE() and only added data_race(). An=
d
> > > > > even data_race() is probably not necessary.
> > > > >
> > > > > Anyways, please see the patch below. Would be nice if mm folks
> > > > > (Suren?) could confirm that this is not broken.
> > > > >
> > > > >
> > > > >
> > > > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > > > Date:   Fri Aug 2 22:16:40 2024 -0700
> > > > >
> > > > >     uprobes: add speculative lockless VMA to inode resolution
> > > > >
> > > > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >
> > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > index 3de311c56d47..bee7a929ff02 100644
> > > > > --- a/kernel/events/uprobes.c
> > > > > +++ b/kernel/events/uprobes.c
> > > > > @@ -2244,6 +2244,70 @@ static int is_trap_at_addr(struct mm_struc=
t
> > > > > *mm, unsigned long vaddr)
> > > > >         return is_trap_insn(&opcode);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +static inline void mm_start_vma_speculation(struct mm_struct *mm=
, int
> > > > > *mm_lock_seq)
> > > > > +{
> > > > > +       *mm_lock_seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > > > > +}
> > > > > +
> > > > > +/* returns true if speculation was safe (no mm and vma modificat=
ion
> > > > > happened) */
> > > > > +static inline bool mm_end_vma_speculation(struct vm_area_struct =
*vma,
> > > > > int mm_lock_seq)
> > > > > +{
> > > > > +       int mm_seq, vma_seq;
> > > > > +
> > > > > +       mm_seq =3D smp_load_acquire(&vma->vm_mm->mm_lock_seq);
> > > > > +       vma_seq =3D READ_ONCE(vma->vm_lock_seq);
> > > > > +
> > > > > +       return mm_seq =3D=3D mm_lock_seq && vma_seq !=3D mm_seq;
> > > >
> > > > After spending some time on this I think what you do here is
> > > > semantically correct but sub-optimal.
> > >
> >
> > Yes, requiring that mm_lock_seq doesn't change is too pessimistic, but
> > relative to the frequency of uprobe/uretprobe triggering (and how fast
> > the lookup is) this won't matter much. Absolute majority of uprobe
> > lookups will manage to succeed while none of mm's VMAs change at all.
> > So I felt like that's ok, at least for starters.
> >
> > My goal is to minimize intrusion into purely mm-related code, this
> > whole uprobe work is already pretty large and sprawling, I don't want
> > to go on another quest to change locking semantics for vma, if I don't
> > absolutely have to :) But see below for adjusted logic based on your
> > comments.
> >
> > > Actually, after staring at this code some more I think
> > > vma->vm_lock_seq not having proper ACQUIRE/RELEASE semantics would
> > > bite us here as well. The entire find_active_uprobe_speculative()
> > > might be executing while mmap_lock is write-locked (so, mm_seq =3D=3D
> > > mm_lock_seq is satisfied) and we might miss that the VMA is locked du=
e
> > > to vma->vm_lock_seq read/write reordering. Though it's late and I
> > > might have missed some memory barriers which would prevent this
> > > scenario...
> >
> > So, please bear with me, if it's a stupid question. But don't all
> > locks have implicit ACQUIRE and RELEASE semantics already? At least
> > that's my reading of Documentation/memory-barriers.txt.
> >
> > So with that, wouldn't it be OK to just change
> > READ_ONCE(vma->vm_lock_seq) to smp_load_acquire(&vma->vm_lock_seq) and
> > mitigate the issue you pointed out?
> >
> >
> > So maybe something like below:
> >
> > rcu_read_lock()
> >
> > vma =3D find_vma(...)
> > if (!vma) /* bail */
> >
> > vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
> > mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
> > /* I think vm_lock has to be acquired first to avoid the race */
> > if (mm_lock_seq =3D=3D vm_lock_seq)
> >     /* bail, vma is write-locked */
> >
> > ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
> >
> > if (smp_load_acquire(&vma->vm_lock_seq) !=3D vm_lock_seq)
> >     /* bail, VMA might have changed */
> >
> > Thoughts?
>
> Hi Andrii,
> I've prepared a quick patch following Peter's suggestion in [1] to
> make mm->mm_lock_seq a proper seqcount. I'll post it shortly as RFC so
> you can try it out. I think that would be a much cleaner solution.
> I'll post a link to it shortly.

The RFC is posted at
https://lore.kernel.org/all/20240807182325.2585582-1-surenb@google.com/.
With that patch you can do:

bool success =3D false;
int seq;

if (!mmap_lock_speculation_start(mm, &seq)) /* bail out */

rcu_read_lock()
vma =3D find_vma(...)
if (!vma) /* rcu_read_unlock and bail out */
/* obtain vma->vm_file->f_inode */
rcu_read_unlock();

if (!mmap_lock_speculation_end(mm, seq)) /* bail out */

> Thanks,
> Suren.
>
> [1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programming.=
kicks-ass.net/
>
>
> >
> > >
> > > > This check means that there was no call to
> > > > mmap_write_unlock()/mmap_write_downgrade() since
> > > > mm_start_vma_speculation() and the vma is not currently locked. To
> > > > unlock a write-locked VMA you do need to call
> > > > map_write_unlock()/mmap_write_downgrade(), so I think this check wo=
uld
> > > > guarantee that your vma was not locked and modified from under us.
> > > > However this will also trigger false positives if
> > > > mmap_write_unlock()/mmap_write_downgrade() was called but the vma y=
ou
> > > > are using was never locked. So, it will bail out more than necessar=
y.
> > > > Maybe it's ok?
> > > >
> > > > > +}
> > > > > +
> >
> > [...]

