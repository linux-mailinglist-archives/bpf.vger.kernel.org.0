Return-Path: <bpf+bounces-37288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CB953A75
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C408B285AC6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E364A8F;
	Thu, 15 Aug 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldb2HkL1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5D770E4
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748338; cv=none; b=mnJm2nyt+TyyLbaQVufz1ZUTBvAIRP/NoagDka0xVsdz/Nb6lTh5LkhPjo63JjUhk0rG0pLBLreef6u/E+V+c4HD/Xbh+gmeonhQ1SVJ29v9pnfZZT0jAiNOvq38QNjXA4SsLe40SVUO2JV+wm3dFWY2zzXSHolZhEyuN1LsRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748338; c=relaxed/simple;
	bh=CAI/m2xW4m26Mo9RasCRAPGOm+6gpYgeYCGYa/s1yQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/6t5miTTKrW+sjMBtb1lTx16AdhO4fsruy6TMhRlOdHV3FjoCThkDRW6cHqFSlpGv7F+Gvg5R3/PDlCUE5PPXYmByK/GEVZmSnBXpM7o8I4l1RY0No1st0Q7wxTUWjb8h1I/ZeQSUzVtDOSQw5JEALhqtc7FEy063QLYQLyALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldb2HkL1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bec7c5af2aso1296a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723748335; x=1724353135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVcHakyd05NnnG++ppwPcYDue0FEVgLhCn69jk/bgt4=;
        b=ldb2HkL1onWdp9jKZt4qB4zFR6+uMCmumqu0GVq+qKTn/dTpfd88VvMRTry5BEg8B5
         j6kcM/nKukDJ+BzJFdcnUFdjTqtyixgcBr8Rs+9/rrFxaRdgiAmt/I0YUMJEhNlriaSf
         EEIInhrzorM43pBBu1BtSBmcKNFpELvGWP3rzHAZjDr5UneW2xiZXNdl68auwyx+u7w+
         nnDH5A8BAONJzpD2ySQyEo9jNRQ3x5EAvMz6kgu6QmuzRzsW1hvh1ew/ERLS3dyJkBoC
         hDhYD5GRkTzkWe0KNMvPLGagDTumIYWpdnUl43EhHpRF+CNe4HGlhPoqAcFfcSPluQSR
         OdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748335; x=1724353135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVcHakyd05NnnG++ppwPcYDue0FEVgLhCn69jk/bgt4=;
        b=gdZpPERWIvT+1U8h/gNmLfx0nFRIWfE3fUDoqPy7rqyLH6UYfP0sxc62kMCyTrLRdS
         d2PgzSK3EwFd7ZFB3DoI1w6FvTukViT6DBBB18BLnjUJpFPMTJyghz8ZstcDcOdqYVop
         UYoF4DH89cm44WgkVZlV4mZnNxbJPNj7KUYSdilxmJT4IqGs8U5AYws41yHhH4M89GeY
         VTbXVnkRRzzGiKTXjPbVsHhxx3Obrz8mdVtTlozMHGB1oVRrhNBZY9PH8vPQlKBstqtH
         tMMOiF2aLD5CcYbUjp/2xU3U3eIyKcRXTyxDiqzVUw5dle5L/qsBplS424Z2XN24/Amv
         KCZA==
X-Forwarded-Encrypted: i=1; AJvYcCUlzCU6jjxZUSrJcZKM7dxkwlfVQU8at5ZPm1c8+2WTZH6FKQfv3W53ILgVdS+cRZvKWax2Q+K/0hTFqWPFdMwHPjgI
X-Gm-Message-State: AOJu0YyDZclcRB0tPOiakm1t4ur/HZ0qQ4ehhAnr0eUuyHCS1PHfXW3s
	9o1EBu2sfSYPM4aUZLckDISCZI8qDabS+cgnidM4G7Y0xDZrgBeqxBgT7ngqUS9W4584b9J+jWp
	OjNOmHikXHyHxzxBovlImbrxQhShlv+eTsDUw
X-Google-Smtp-Source: AGHT+IFhaELbaTp+2SL+fH5/AKVycHneEw3wgavFmIEylenYsuJz3vLPtFF1ca6y0fLuRrLkR7xUKX1ps2bpA04MCro=
X-Received: by 2002:a05:6402:1ed5:b0:5bd:3fff:7196 with SMTP id
 4fb4d7f45d1cf-5becb50b041mr9405a12.6.1723748334040; Thu, 15 Aug 2024 11:58:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
 <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
 <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com> <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 Aug 2024 20:58:16 +0200
Message-ID: <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+brauner for "struct file" lifetime

On Thu, Aug 15, 2024 at 7:45=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Thu, Aug 15, 2024 at 9:47=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 15, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@gma=
il.com> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > > > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely ac=
cess
> > > > > > vma->vm_file->f_inode lockless only under rcu_read_lock() prote=
ction,
> > > > > > attempting uprobe look up speculatively.

Stupid question: Is this uprobe stuff actually such a hot codepath
that it makes sense to optimize it to be faster than the page fault
path?

(Sidenote: I find it kinda interesting that this is sort of going back
in the direction of the old Speculative Page Faults design.)

> > > > > > We rely on newly added mmap_lock_speculation_{start,end}() help=
ers to
> > > > > > validate that mm_struct stays intact for entire duration of thi=
s
> > > > > > speculation. If not, we fall back to mmap_lock-protected lookup=
.
> > > > > >
> > > > > > This allows to avoid contention on mmap_lock in absolutely majo=
rity of
> > > > > > cases, nicely improving uprobe/uretprobe scalability.
> > > > > >
> > > > >
> > > > > Here I have to admit to being mostly ignorant about the mm, so be=
ar with
> > > > > me. :>
> > > > >
> > > > > I note the result of find_active_uprobe_speculative is immediatel=
y stale
> > > > > in face of modifications.
> > > > >
> > > > > The thing I'm after is that the mmap_lock_speculation business ad=
ds
> > > > > overhead on archs where a release fence is not a de facto nop and=
 I
> > > > > don't believe the commit message justifies it. Definitely a bumme=
r to
> > > > > add merely it for uprobes. If there are bigger plans concerning i=
t
> > > > > that's a different story of course.
> > > > >
> > > > > With this in mind I have to ask if instead you could perhaps get =
away
> > > > > with the already present per-vma sequence counter?
> > > >
> > > > per-vma sequence counter does not implement acquire/release logic, =
it
> > > > relies on vma->vm_lock for synchronization. So if we want to use it=
,
> > > > we would have to add additional memory barriers here. This is likel=
y
> > > > possible but as I mentioned before we would need to ensure the
> > > > pagefault path does not regress. OTOH mm->mm_lock_seq already halfw=
ay
> > > > there (it implements acquire/release logic), we just had to ensure
> > > > mmap_write_lock() increments mm->mm_lock_seq.
> > > >
> > > > So, from the release fence overhead POV I think whether we use
> > > > mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
> > > > here.
> > > >
> > >
> > > Per my previous e-mail I'm not particularly familiar with mm internal=
s,
> > > so I'm going to handwave a little bit with my $0,03 concerning multic=
ore
> > > in general and if you disagree with it that's your business. For the
> > > time being I have no interest in digging into any of this.
> > >
> > > Before I do, to prevent this thread from being a total waste, here ar=
e
> > > some remarks concerning the patch with the assumption that the core i=
dea
> > > lands.
> > >
> > > From the commit message:
> > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > > > vma->vm_file->f_inode lockless only under rcu_read_lock() protectio=
n,
> > > > attempting uprobe look up speculatively.
> > >
> > > Just in case I'll note a nit that this paragraph will need to be remo=
ved
> > > since the patch adding the flag is getting dropped.
> >
> > Yep, of course, I'll update all that for the next revision (I'll wait
> > for non-RFC patches to land first before reposting).
> >
> > >
> > > A non-nit which may or may not end up mattering is that the flag (whi=
ch
> > > *is* set on the filep slab cache) makes things more difficult to
> > > validate. Normal RCU usage guarantees that the object itself wont be
> > > freed as long you follow the rules. However, the SLAB_TYPESAFE_BY_RCU
> > > flag weakens it significantly -- the thing at hand will always be a
> > > 'struct file', but it may get reallocated to *another* file from unde=
r
> > > you. Whether this aspect plays a role here I don't know.
> >
> > Yes, that's ok and is accounted for. We care about that memory not
> > going even from under us (I'm not even sure if it matters that it is
> > still a struct file, tbh; I think that shouldn't matter as we are
> > prepared to deal with completely garbage values read from struct
> > file).
>
> Correct, with SLAB_TYPESAFE_BY_RCU we do need an additional check that
> vma->vm_file has not been freed and reused. That's where
> mmap_lock_speculation_{start|end} helps us. For vma->vm_file to change
> from under us one would have to take mmap_lock for write. If that
> happens mmap_lock_speculation_{start|end} should detect that and
> terminate our speculation.
>
> >
> > >
> > > > +static struct uprobe *find_active_uprobe_speculative(unsigned long=
 bp_vaddr)
> > > > +{
> > > > +     const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSH=
ARE;
> > > > +     struct mm_struct *mm =3D current->mm;
> > > > +     struct uprobe *uprobe;
> > > > +     struct vm_area_struct *vma;
> > > > +     struct file *vm_file;
> > > > +     struct inode *vm_inode;
> > > > +     unsigned long vm_pgoff, vm_start;
> > > > +     int seq;
> > > > +     loff_t offset;
> > > > +
> > > > +     if (!mmap_lock_speculation_start(mm, &seq))
> > > > +             return NULL;
> > > > +
> > > > +     rcu_read_lock();
> > > > +
> > >
> > > I don't think there is a correctness problem here, but entering rcu
> > > *after* deciding to speculatively do the lookup feels backwards.
> >
> > RCU should protect VMA and file, mm itself won't go anywhere, so this s=
eems ok.
> >
> > >
> > > > +     vma =3D vma_lookup(mm, bp_vaddr);
> > > > +     if (!vma)
> > > > +             goto bail;
> > > > +
> > > > +     vm_file =3D data_race(vma->vm_file);
> > > > +     if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > > > +             goto bail;
> > > > +
> > >
> > > If vma teardown is allowed to progress and the file got fput'ed...
> > >
> > > > +     vm_inode =3D data_race(vm_file->f_inode);
> > >
> > > ... the inode can be NULL, I don't know if that's handled.
> > >
> >
> > Yep, inode pointer value is part of RB-tree key, so if it's NULL, we
> > just won't find a matching uprobe. Same for any other "garbage"
> > f_inode value. Importantly, we never should dereference such inode
> > pointers, at least until we find a valid uprobe (in which case we keep
> > inode reference to it).
> >
> > > More importantly though, per my previous description of
> > > SLAB_TYPESAFE_BY_RCU, by now the file could have been reallocated and
> > > the inode you did find is completely unrelated.
> > >
> > > I understand the intent is to backpedal from everything should the mm
> > > seqc change, but the above may happen to matter.
> >
> > Yes, I think we took that into account. All that we care about is
> > memory "type safety", i.e., even if struct file's memory is reused,
> > it's ok, we'll eventually detect the change and will discard wrong
> > uprobe that we might by accident lookup (though probably in most cases
> > we just won't find a uprobe at all).
> >
> > >
> > > > +     vm_pgoff =3D data_race(vma->vm_pgoff);
> > > > +     vm_start =3D data_race(vma->vm_start);
> > > > +
> > > > +     offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_=
start);
> > > > +     uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > +     if (!uprobe)
> > > > +             goto bail;
> > > > +
> > > > +     /* now double check that nothing about MM changed */
> > > > +     if (!mmap_lock_speculation_end(mm, seq))
> > > > +             goto bail;
> > >
> > > This leaks the reference obtained by find_uprobe_rcu().
> >
> > find_uprobe_rcu() doesn't obtain a reference, uprobe is RCU-protected,
> > and if caller need a refcount bump it will have to use
> > try_get_uprobe() (which might fail).
> >
> > >
> > > > +
> > > > +     rcu_read_unlock();
> > > > +
> > > > +     /* happy case, we speculated successfully */
> > > > +     return uprobe;
> > > > +bail:
> > > > +     rcu_read_unlock();
> > > > +     return NULL;
> > > > +}
> > >
> > > Now to some handwaving, here it is:
> > >
> > > The core of my concern is that adding more work to down_write on the
> > > mmap semaphore comes with certain side-effects and plausibly more tha=
n a
> > > sufficient speed up can be achieved without doing it.
>
> AFAIK writers of mmap_lock are not considered a fast path. In a sense
> yes, we made any writer a bit heavier but OTOH we also made
> mm->mm_lock_seq a proper sequence count which allows us to locklessly
> check if mmap_lock is write-locked. I think you asked whether there
> will be other uses for mmap_lock_speculation_{start|end} and yes. For
> example, I am planning to use them for printing /proc/{pid}/maps
> without taking mmap_lock (when it's uncontended).

What would be the goal of this - to avoid cacheline bouncing of the
mmap lock between readers? Or to allow mmap_write_lock() to preempt
/proc/{pid}/maps readers who started out uncontended?

Is the idea that you'd change show_map_vma() to first do something
like get_file_active() to increment the file refcount (because
otherwise the dentry can be freed under you and you need the dentry
for path printing), then recheck your sequence count on the mm or vma
(to avoid accessing the dentry of an unrelated file that hasn't become
userspace-visible yet and may not have a proper dentry pointer yet),
then print the file path, drop the file reference again, and in the
end recheck the sequence count again before actually returning the
printed data to userspace?

> If we have VMA seq
> counter-based detection it would be better (see below).
>
> > >
> > > An mm-wide mechanism is just incredibly coarse-grained and it may hap=
pen
> > > to perform poorly when faced with a program which likes to mess with =
its
> > > address space -- the fast path is going to keep failing and only
> > > inducing *more* overhead as the code decides to down_read the mmap
> > > semaphore.
> > >
> > > Furthermore there may be work currently synchronized with down_write
> > > which perhaps can transition to "merely" down_read, but by the time i=
t
> > > happens this and possibly other consumers expect a change in the
> > > sequence counter, messing with it.
> > >
> > > To my understanding the kernel supports parallel faults with per-vma
> > > locking. I would find it surprising if the same machinery could not b=
e
> > > used to sort out uprobe handling above.
>
> From all the above, my understanding of your objection is that
> checking mmap_lock during our speculation is too coarse-grained and
> you would prefer to use the VMA seq counter to check that the VMA we
> are working on is unchanged. I agree, that would be ideal. I had a
> quick chat with Jann about this and the conclusion we came to is that
> we would need to add an additional smp_wmb() barrier inside
> vma_start_write() and a smp_rmb() in the speculation code:
>
> static inline void vma_start_write(struct vm_area_struct *vma)
> {
>         int mm_lock_seq;
>
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
>
>         down_write(&vma->vm_lock->lock);
>         /*
>          * We should use WRITE_ONCE() here because we can have concurrent=
 reads
>          * from the early lockless pessimistic check in vma_start_read().
>          * We don't really care about the correctness of that early check=
, but
>          * we should use WRITE_ONCE() for cleanliness and to keep KCSAN h=
appy.
>          */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> +        smp_wmb();
>         up_write(&vma->vm_lock->lock);
> }
>
> Note: up_write(&vma->vm_lock->lock) in the vma_start_write() is not
> enough because it's one-way permeable (it's a "RELEASE operation") and
> later vma->vm_file store (or any other VMA modification) can move
> before our vma->vm_lock_seq store.
>
> This makes vma_start_write() heavier but again, it's write-locking, so
> should not be considered a fast path.
> With this change we can use the code suggested by Andrii in
> https://lore.kernel.org/all/CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjcA2=
+6k69Q@mail.gmail.com/
> with an additional smp_rmb():
>
> rcu_read_lock()
> vma =3D find_vma(...)
> if (!vma) /* bail */

And maybe add some comments like:

/*
 * Load the current VMA lock sequence - we will detect if anyone concurrent=
ly
 * locks the VMA after this point.
 * Pairs with smp_wmb() in vma_start_write().
 */
> vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
/*
 * Now we just have to detect if the VMA is already locked with its current
 * sequence count.
 *
 * The following load is ordered against the vm_lock_seq load above (using
 * smp_load_acquire() for the load above), and pairs with implicit memory
 * ordering between the mm_lock_seq write in mmap_write_unlock() and the
 * vm_lock_seq write in the next vma_start_write() after that (which can on=
ly
 * occur after an mmap_write_lock()).
 */
> mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
> /* I think vm_lock has to be acquired first to avoid the race */
> if (mm_lock_seq =3D=3D vm_lock_seq)
>         /* bail, vma is write-locked */
> ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
/*
 * Order the speculative accesses above against the following vm_lock_seq
 * recheck.
 */
> smp_rmb();
> if (vma->vm_lock_seq !=3D vm_lock_seq)

(As I said on the other thread: Since this now relies on
vma->vm_lock_seq not wrapping back to the same value for correctness,
I'd like to see vma->vm_lock_seq being at least an "unsigned long", or
even better, an atomic64_t... though I realize we don't currently do
that for seqlocks either.)

>         /* bail, VMA might have changed */
>
> The smp_rmb() is needed so that vma->vm_lock_seq load does not get
> reordered and moved up before speculation.
>
> I'm CC'ing Jann since he understands memory barriers way better than
> me and will keep me honest.

