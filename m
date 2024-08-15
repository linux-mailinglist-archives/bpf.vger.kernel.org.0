Return-Path: <bpf+bounces-37292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4301E953B06
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F3A1C23DF5
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894813C661;
	Thu, 15 Aug 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUCDj9Ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4182876
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751096; cv=none; b=eW+sOqgU1zxI5ariPnK580VzYaXOworSWl6fND9ELQBYFGjq3j1odJx80KX0ZkFRZC0oSF2xhLFZoNr4/rbUiwLAvHuhpcg0y8PgSvHSzw0H0JztTk1aOgzyBGhU4LCLzReN9HVHfA/ohE7klcvE6TskixH4qWKBBze9PDJaOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751096; c=relaxed/simple;
	bh=DJMzCw/sPBoyqxze5PdK49JRsfTIoeGbAf/4FlFl0gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUg9xMBGfg7TRFBzj3TjnQyp3d1BAmiUPdI2RLoLPu1Tp4pr/hZDt9OiuO73oYWj0L726A+zta6ld3CGLcdMThnYvIRr53x+e60urLHPYDrdWkJCpN4uYn9d8kbb9ftUnRIwn/vcDWXhzQYb/ifMbU23dxohS2hbEmWPtikMm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUCDj9Ko; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66599ca3470so12960617b3.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723751093; x=1724355893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t6XhYIEZnyVh3jH9KKsmGdUUyO+tWe72GSzHcBC0Bs=;
        b=cUCDj9Ko9grR8KeCdzwyOJPtKANqfYZnqGFl7tacb02yhw1XIt8pdgieuRVFx/AOdy
         ks+l5+cgw8WE2Vr71XCAZbLdG9NRdmQhtWBKqC2xrgqZJnWql4ggK5VRbjs5UlSVx+gz
         By7qa3K9hY+0FmzjQm47Phiiu3zzHkZ2HiyMIyBkkeA69/f1FdSZYx+sZIF7YFrWRRNp
         qZSn/vC3cxxkAAFdDp8kpgD3tCfekRX6RUeAU+aIATCpjuJoWCYdbb040ge9KiFiHudp
         /M+d08WVsmtIN0vgXh7D2cvrZJk7ghtU9GZXXqCJ0hTF4HYavFyCTLr3lUPKVyrPWnBg
         Oavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723751093; x=1724355893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t6XhYIEZnyVh3jH9KKsmGdUUyO+tWe72GSzHcBC0Bs=;
        b=NVAiDEC7yXU4NcS3nGVlC4+GUkMABaG6wEJJaLD4jV9zTR+VcFfG8R1rph1nuXbtM/
         ogWcIh5PtNfkNh4mbL1RcUwu9GKWSSah6G87nfRDkQb9SFmbcBttgrlbmOD35edz78Wx
         zZ6PnC6aXnsX9kZLPeVXTdNHWZmMSm4njKbaEapGsiEMS3Vtq7ZkdtAO7Dag0ixr0CEs
         BKUZHt7j4D5i0avj9UBm1+71awjFhwc7wotN3Njjfor01Cio9nL/h4SH62vIJj7Wzz8I
         gwlWMhfvp4Lsd30Hyt5HX2akwyn5xqD+pkLvNbMhRBd6d8RAQoIN75/YIUCHDfQon9nD
         7rnA==
X-Forwarded-Encrypted: i=1; AJvYcCVUFPHEAxYOsEp2YfV+dhwftnxpTBL3itgwSbhPPcIoHumcFGjygw2S/Rw+jOnFTUVvg0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TVjenPUDXAn6+tRM/xC0bwJpDUkxqNnchW77EyX9NJ5r48nI
	gudL6eDvwYrfEaQUeKNCdjITPwwF7GCFPCwptLcBXVW7z2ikd5r/4AL6OwYef0tGyYVWIqNbgvc
	KJ+yg/qu/A47KMope0znLeFa2WjKNckcMefXy
X-Google-Smtp-Source: AGHT+IGFiu2dsnb0iBEpNTaU9KVmRuLZuyiJNu/FnHWtHgC8Ueh3DZGTkW2v1iGQuV1T8XRCWB8LYxP6YszCk0z50XQ=
X-Received: by 2002:a05:690c:4c8f:b0:664:a85d:47c6 with SMTP id
 00721157ae682-6b1bdb21ae8mr8811077b3.33.1723751093161; Thu, 15 Aug 2024
 12:44:53 -0700 (PDT)
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
 <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
 <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com> <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
In-Reply-To: <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Aug 2024 12:44:37 -0700
Message-ID: <CAJuCfpF0Cvk0D_tLqiFmFze9ErgNe-_z1HHZoY34DcZ8CPd7yA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:58=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> +brauner for "struct file" lifetime
>
> On Thu, Aug 15, 2024 at 7:45=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Thu, Aug 15, 2024 at 9:47=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Aug 15, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.=
com> wrote:
> > > >
> > > > On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@g=
mail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote=
:
> > > > > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely =
access
> > > > > > > vma->vm_file->f_inode lockless only under rcu_read_lock() pro=
tection,
> > > > > > > attempting uprobe look up speculatively.
>
> Stupid question: Is this uprobe stuff actually such a hot codepath
> that it makes sense to optimize it to be faster than the page fault
> path?
>
> (Sidenote: I find it kinda interesting that this is sort of going back
> in the direction of the old Speculative Page Faults design.)
>
> > > > > > > We rely on newly added mmap_lock_speculation_{start,end}() he=
lpers to
> > > > > > > validate that mm_struct stays intact for entire duration of t=
his
> > > > > > > speculation. If not, we fall back to mmap_lock-protected look=
up.
> > > > > > >
> > > > > > > This allows to avoid contention on mmap_lock in absolutely ma=
jority of
> > > > > > > cases, nicely improving uprobe/uretprobe scalability.
> > > > > > >
> > > > > >
> > > > > > Here I have to admit to being mostly ignorant about the mm, so =
bear with
> > > > > > me. :>
> > > > > >
> > > > > > I note the result of find_active_uprobe_speculative is immediat=
ely stale
> > > > > > in face of modifications.
> > > > > >
> > > > > > The thing I'm after is that the mmap_lock_speculation business =
adds
> > > > > > overhead on archs where a release fence is not a de facto nop a=
nd I
> > > > > > don't believe the commit message justifies it. Definitely a bum=
mer to
> > > > > > add merely it for uprobes. If there are bigger plans concerning=
 it
> > > > > > that's a different story of course.
> > > > > >
> > > > > > With this in mind I have to ask if instead you could perhaps ge=
t away
> > > > > > with the already present per-vma sequence counter?
> > > > >
> > > > > per-vma sequence counter does not implement acquire/release logic=
, it
> > > > > relies on vma->vm_lock for synchronization. So if we want to use =
it,
> > > > > we would have to add additional memory barriers here. This is lik=
ely
> > > > > possible but as I mentioned before we would need to ensure the
> > > > > pagefault path does not regress. OTOH mm->mm_lock_seq already hal=
fway
> > > > > there (it implements acquire/release logic), we just had to ensur=
e
> > > > > mmap_write_lock() increments mm->mm_lock_seq.
> > > > >
> > > > > So, from the release fence overhead POV I think whether we use
> > > > > mm->mm_lock_seq or vma->vm_lock, we would still need a proper fen=
ce
> > > > > here.
> > > > >
> > > >
> > > > Per my previous e-mail I'm not particularly familiar with mm intern=
als,
> > > > so I'm going to handwave a little bit with my $0,03 concerning mult=
icore
> > > > in general and if you disagree with it that's your business. For th=
e
> > > > time being I have no interest in digging into any of this.
> > > >
> > > > Before I do, to prevent this thread from being a total waste, here =
are
> > > > some remarks concerning the patch with the assumption that the core=
 idea
> > > > lands.
> > > >
> > > > From the commit message:
> > > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely acce=
ss
> > > > > vma->vm_file->f_inode lockless only under rcu_read_lock() protect=
ion,
> > > > > attempting uprobe look up speculatively.
> > > >
> > > > Just in case I'll note a nit that this paragraph will need to be re=
moved
> > > > since the patch adding the flag is getting dropped.
> > >
> > > Yep, of course, I'll update all that for the next revision (I'll wait
> > > for non-RFC patches to land first before reposting).
> > >
> > > >
> > > > A non-nit which may or may not end up mattering is that the flag (w=
hich
> > > > *is* set on the filep slab cache) makes things more difficult to
> > > > validate. Normal RCU usage guarantees that the object itself wont b=
e
> > > > freed as long you follow the rules. However, the SLAB_TYPESAFE_BY_R=
CU
> > > > flag weakens it significantly -- the thing at hand will always be a
> > > > 'struct file', but it may get reallocated to *another* file from un=
der
> > > > you. Whether this aspect plays a role here I don't know.
> > >
> > > Yes, that's ok and is accounted for. We care about that memory not
> > > going even from under us (I'm not even sure if it matters that it is
> > > still a struct file, tbh; I think that shouldn't matter as we are
> > > prepared to deal with completely garbage values read from struct
> > > file).
> >
> > Correct, with SLAB_TYPESAFE_BY_RCU we do need an additional check that
> > vma->vm_file has not been freed and reused. That's where
> > mmap_lock_speculation_{start|end} helps us. For vma->vm_file to change
> > from under us one would have to take mmap_lock for write. If that
> > happens mmap_lock_speculation_{start|end} should detect that and
> > terminate our speculation.
> >
> > >
> > > >
> > > > > +static struct uprobe *find_active_uprobe_speculative(unsigned lo=
ng bp_vaddr)
> > > > > +{
> > > > > +     const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAY=
SHARE;
> > > > > +     struct mm_struct *mm =3D current->mm;
> > > > > +     struct uprobe *uprobe;
> > > > > +     struct vm_area_struct *vma;
> > > > > +     struct file *vm_file;
> > > > > +     struct inode *vm_inode;
> > > > > +     unsigned long vm_pgoff, vm_start;
> > > > > +     int seq;
> > > > > +     loff_t offset;
> > > > > +
> > > > > +     if (!mmap_lock_speculation_start(mm, &seq))
> > > > > +             return NULL;
> > > > > +
> > > > > +     rcu_read_lock();
> > > > > +
> > > >
> > > > I don't think there is a correctness problem here, but entering rcu
> > > > *after* deciding to speculatively do the lookup feels backwards.
> > >
> > > RCU should protect VMA and file, mm itself won't go anywhere, so this=
 seems ok.
> > >
> > > >
> > > > > +     vma =3D vma_lookup(mm, bp_vaddr);
> > > > > +     if (!vma)
> > > > > +             goto bail;
> > > > > +
> > > > > +     vm_file =3D data_race(vma->vm_file);
> > > > > +     if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > > > > +             goto bail;
> > > > > +
> > > >
> > > > If vma teardown is allowed to progress and the file got fput'ed...
> > > >
> > > > > +     vm_inode =3D data_race(vm_file->f_inode);
> > > >
> > > > ... the inode can be NULL, I don't know if that's handled.
> > > >
> > >
> > > Yep, inode pointer value is part of RB-tree key, so if it's NULL, we
> > > just won't find a matching uprobe. Same for any other "garbage"
> > > f_inode value. Importantly, we never should dereference such inode
> > > pointers, at least until we find a valid uprobe (in which case we kee=
p
> > > inode reference to it).
> > >
> > > > More importantly though, per my previous description of
> > > > SLAB_TYPESAFE_BY_RCU, by now the file could have been reallocated a=
nd
> > > > the inode you did find is completely unrelated.
> > > >
> > > > I understand the intent is to backpedal from everything should the =
mm
> > > > seqc change, but the above may happen to matter.
> > >
> > > Yes, I think we took that into account. All that we care about is
> > > memory "type safety", i.e., even if struct file's memory is reused,
> > > it's ok, we'll eventually detect the change and will discard wrong
> > > uprobe that we might by accident lookup (though probably in most case=
s
> > > we just won't find a uprobe at all).
> > >
> > > >
> > > > > +     vm_pgoff =3D data_race(vma->vm_pgoff);
> > > > > +     vm_start =3D data_race(vma->vm_start);
> > > > > +
> > > > > +     offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - v=
m_start);
> > > > > +     uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > > +     if (!uprobe)
> > > > > +             goto bail;
> > > > > +
> > > > > +     /* now double check that nothing about MM changed */
> > > > > +     if (!mmap_lock_speculation_end(mm, seq))
> > > > > +             goto bail;
> > > >
> > > > This leaks the reference obtained by find_uprobe_rcu().
> > >
> > > find_uprobe_rcu() doesn't obtain a reference, uprobe is RCU-protected=
,
> > > and if caller need a refcount bump it will have to use
> > > try_get_uprobe() (which might fail).
> > >
> > > >
> > > > > +
> > > > > +     rcu_read_unlock();
> > > > > +
> > > > > +     /* happy case, we speculated successfully */
> > > > > +     return uprobe;
> > > > > +bail:
> > > > > +     rcu_read_unlock();
> > > > > +     return NULL;
> > > > > +}
> > > >
> > > > Now to some handwaving, here it is:
> > > >
> > > > The core of my concern is that adding more work to down_write on th=
e
> > > > mmap semaphore comes with certain side-effects and plausibly more t=
han a
> > > > sufficient speed up can be achieved without doing it.
> >
> > AFAIK writers of mmap_lock are not considered a fast path. In a sense
> > yes, we made any writer a bit heavier but OTOH we also made
> > mm->mm_lock_seq a proper sequence count which allows us to locklessly
> > check if mmap_lock is write-locked. I think you asked whether there
> > will be other uses for mmap_lock_speculation_{start|end} and yes. For
> > example, I am planning to use them for printing /proc/{pid}/maps
> > without taking mmap_lock (when it's uncontended).
>
> What would be the goal of this - to avoid cacheline bouncing of the
> mmap lock between readers? Or to allow mmap_write_lock() to preempt
> /proc/{pid}/maps readers who started out uncontended?

The latter, from my early patchset which I need to refine
(https://lore.kernel.org/all/20240123231014.3801041-3-surenb@google.com/):

This change is designed to reduce mmap_lock contention and prevent a
process reading /proc/pid/maps files (often a low priority task, such as
monitoring/data collection services) from blocking address space updates.

>
> Is the idea that you'd change show_map_vma() to first do something
> like get_file_active() to increment the file refcount (because
> otherwise the dentry can be freed under you and you need the dentry
> for path printing), then recheck your sequence count on the mm or vma
> (to avoid accessing the dentry of an unrelated file that hasn't become
> userspace-visible yet and may not have a proper dentry pointer yet),
> then print the file path, drop the file reference again, and in the
> end recheck the sequence count again before actually returning the
> printed data to userspace?

Yeah, you can see the details in that link I posted above. See
get_vma_snapshot() function.

>
> > If we have VMA seq
> > counter-based detection it would be better (see below).
> >
> > > >
> > > > An mm-wide mechanism is just incredibly coarse-grained and it may h=
appen
> > > > to perform poorly when faced with a program which likes to mess wit=
h its
> > > > address space -- the fast path is going to keep failing and only
> > > > inducing *more* overhead as the code decides to down_read the mmap
> > > > semaphore.
> > > >
> > > > Furthermore there may be work currently synchronized with down_writ=
e
> > > > which perhaps can transition to "merely" down_read, but by the time=
 it
> > > > happens this and possibly other consumers expect a change in the
> > > > sequence counter, messing with it.
> > > >
> > > > To my understanding the kernel supports parallel faults with per-vm=
a
> > > > locking. I would find it surprising if the same machinery could not=
 be
> > > > used to sort out uprobe handling above.
> >
> > From all the above, my understanding of your objection is that
> > checking mmap_lock during our speculation is too coarse-grained and
> > you would prefer to use the VMA seq counter to check that the VMA we
> > are working on is unchanged. I agree, that would be ideal. I had a
> > quick chat with Jann about this and the conclusion we came to is that
> > we would need to add an additional smp_wmb() barrier inside
> > vma_start_write() and a smp_rmb() in the speculation code:
> >
> > static inline void vma_start_write(struct vm_area_struct *vma)
> > {
> >         int mm_lock_seq;
> >
> >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> >                 return;
> >
> >         down_write(&vma->vm_lock->lock);
> >         /*
> >          * We should use WRITE_ONCE() here because we can have concurre=
nt reads
> >          * from the early lockless pessimistic check in vma_start_read(=
).
> >          * We don't really care about the correctness of that early che=
ck, but
> >          * we should use WRITE_ONCE() for cleanliness and to keep KCSAN=
 happy.
> >          */
> >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > +        smp_wmb();
> >         up_write(&vma->vm_lock->lock);
> > }
> >
> > Note: up_write(&vma->vm_lock->lock) in the vma_start_write() is not
> > enough because it's one-way permeable (it's a "RELEASE operation") and
> > later vma->vm_file store (or any other VMA modification) can move
> > before our vma->vm_lock_seq store.
> >
> > This makes vma_start_write() heavier but again, it's write-locking, so
> > should not be considered a fast path.
> > With this change we can use the code suggested by Andrii in
> > https://lore.kernel.org/all/CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjc=
A2+6k69Q@mail.gmail.com/
> > with an additional smp_rmb():
> >
> > rcu_read_lock()
> > vma =3D find_vma(...)
> > if (!vma) /* bail */
>
> And maybe add some comments like:
>
> /*
>  * Load the current VMA lock sequence - we will detect if anyone concurre=
ntly
>  * locks the VMA after this point.
>  * Pairs with smp_wmb() in vma_start_write().
>  */
> > vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
> /*
>  * Now we just have to detect if the VMA is already locked with its curre=
nt
>  * sequence count.
>  *
>  * The following load is ordered against the vm_lock_seq load above (usin=
g
>  * smp_load_acquire() for the load above), and pairs with implicit memory
>  * ordering between the mm_lock_seq write in mmap_write_unlock() and the
>  * vm_lock_seq write in the next vma_start_write() after that (which can =
only
>  * occur after an mmap_write_lock()).
>  */
> > mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
> > /* I think vm_lock has to be acquired first to avoid the race */
> > if (mm_lock_seq =3D=3D vm_lock_seq)
> >         /* bail, vma is write-locked */
> > ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
> /*
>  * Order the speculative accesses above against the following vm_lock_seq
>  * recheck.
>  */
> > smp_rmb();
> > if (vma->vm_lock_seq !=3D vm_lock_seq)
>
> (As I said on the other thread: Since this now relies on
> vma->vm_lock_seq not wrapping back to the same value for correctness,
> I'd like to see vma->vm_lock_seq being at least an "unsigned long", or
> even better, an atomic64_t... though I realize we don't currently do
> that for seqlocks either.)
>
> >         /* bail, VMA might have changed */
> >
> > The smp_rmb() is needed so that vma->vm_lock_seq load does not get
> > reordered and moved up before speculation.
> >
> > I'm CC'ing Jann since he understands memory barriers way better than
> > me and will keep me honest.

