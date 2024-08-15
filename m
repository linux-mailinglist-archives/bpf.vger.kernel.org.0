Return-Path: <bpf+bounces-37286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C8953969
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464EF1C224E6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B858ABC;
	Thu, 15 Aug 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhufBQ2l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DB4F8A0
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743961; cv=none; b=dfuZfcQrSOxXfioiqJvmk0x97wuDsNTH38TncqxZgUoQkH1JtqoSwkNkcspC+cVZSCpX/n/5Ka9WorUiSOehxuOPMRzlix9n97HAI1dpV2XnK6bO+X2Lsv7fM3pVHxLMvSaX0Gojxzzz9A6vUf4XAvKXpu1m/Kjg1qNiPM0OqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743961; c=relaxed/simple;
	bh=FDcCnnlXkpEhOXNDML34ryS095b88sl01J0SdqkIKPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjfxiZGTKIkxCirW62PKXerEMov0+02P5gV12jGmuiDOn6VFoqaW8wAcp9NUkATUhwM30HcPNnlFWkJR8G9I840U8BXZyAg95L8TuvJ1H1Qfrz8pxEll/Ml6qAcsHSap1xSEIAQ2KQ/RAWFlngc3sltHRHilP4NyeqLkilgQzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhufBQ2l; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66108213e88so11995017b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743959; x=1724348759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V+AAngWgfIxv6c1YFrDspk/cizXypebZn5qis955xM=;
        b=XhufBQ2lqq8GPSBu2E2tcOwLGUK8B1f5QkLMbtV7H+c58RKzy7O653RrKhUyFXLKzl
         ag71U1Y8ZoKWL09DeIdp9WhqFEiyHPNVXhxNxHcJrblJnszqX956WNactXRx68nbtkD+
         tXQDCQWWnavPOxsVzFPiei5EGFd/M5LZtfRfQsMWjLHtm2Sh5RLSpGxhtms9CZlmSVGX
         8ub+EyqWlPzyb6FaiNuREA4ZM2CmRyYutzCHTA+OLDrY3HuhMHelQwQOWKwGv/IKdMqd
         GPxbB5cQ/TGFtIVLVsZXEG3hKHPTzPBWtmulNZsz+EjsUAZ6B7/7kgTA7ZyDr4ZRwhVa
         ts4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743959; x=1724348759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V+AAngWgfIxv6c1YFrDspk/cizXypebZn5qis955xM=;
        b=h4IoM20V3xXXNDiHfltNCAGMbxMFzfOTG3DV5uWsjbFqZerD5esph0jIM+sxNK8QTQ
         XaQuQxWDFlPJSnFoFNwDpPsRPNWCVABNVD8vVvuDIKxStp2a4/dAz9HLDysvDpFmD0UI
         RuTG/12kbLZaU6YbQQeS+wvhu4OW1HAfW486/e+nddNBus3QK4Ng/xiCxx8W2Oak2etx
         sGVs9y8OD3MGJXn/DjNoZ6U/9aODhwfBBopYSy6xVB8gtOtUw6cghxmAwvmI0SJKPSIk
         w1BKRXcfZylg823seffDqxTPU3ug3y6b01y8+r8oEO5nCd70ydToraukqh0OPniTvROY
         qCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0a0UymsEba3K4UZVkPiMg1Jo6PbCE3KJin5sy640hBDExmnf+d3mLT+Bf/7avPw+lLFY/y4HBUnP3UcRBVvGB4IXH
X-Gm-Message-State: AOJu0YyWHPdPSbByijfXA8jeGZsKtrOo7Ukh7Y7W2gbrwxjl5I5fniwN
	I1VUnT2bvooA7WZJNY9nEWEm/2HsnidESvSkaAcDy7i4p0W5wCI61T0eS2gNY6uvvy9rRQJsmLs
	kCfPY3CgeL7JXEKLQ18kyPe6AgMcm/AQtkZ26
X-Google-Smtp-Source: AGHT+IE/v/zGjlSuMoo/W6H9WCBIwRvVIVJ9q7nRaS1WSXSTrQvfY+mMx781RH1aMnU6RgWx/uBtb692fOwW31mjIUo=
X-Received: by 2002:a05:690c:62c9:b0:65f:8afe:9ba6 with SMTP id
 00721157ae682-6b1b823f4bdmr4555977b3.14.1723743958241; Thu, 15 Aug 2024
 10:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
 <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5> <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Aug 2024 10:45:45 -0700
Message-ID: <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:47=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 15, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@gmail=
.com> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely acce=
ss
> > > > > vma->vm_file->f_inode lockless only under rcu_read_lock() protect=
ion,
> > > > > attempting uprobe look up speculatively.
> > > > >
> > > > > We rely on newly added mmap_lock_speculation_{start,end}() helper=
s to
> > > > > validate that mm_struct stays intact for entire duration of this
> > > > > speculation. If not, we fall back to mmap_lock-protected lookup.
> > > > >
> > > > > This allows to avoid contention on mmap_lock in absolutely majori=
ty of
> > > > > cases, nicely improving uprobe/uretprobe scalability.
> > > > >
> > > >
> > > > Here I have to admit to being mostly ignorant about the mm, so bear=
 with
> > > > me. :>
> > > >
> > > > I note the result of find_active_uprobe_speculative is immediately =
stale
> > > > in face of modifications.
> > > >
> > > > The thing I'm after is that the mmap_lock_speculation business adds
> > > > overhead on archs where a release fence is not a de facto nop and I
> > > > don't believe the commit message justifies it. Definitely a bummer =
to
> > > > add merely it for uprobes. If there are bigger plans concerning it
> > > > that's a different story of course.
> > > >
> > > > With this in mind I have to ask if instead you could perhaps get aw=
ay
> > > > with the already present per-vma sequence counter?
> > >
> > > per-vma sequence counter does not implement acquire/release logic, it
> > > relies on vma->vm_lock for synchronization. So if we want to use it,
> > > we would have to add additional memory barriers here. This is likely
> > > possible but as I mentioned before we would need to ensure the
> > > pagefault path does not regress. OTOH mm->mm_lock_seq already halfway
> > > there (it implements acquire/release logic), we just had to ensure
> > > mmap_write_lock() increments mm->mm_lock_seq.
> > >
> > > So, from the release fence overhead POV I think whether we use
> > > mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
> > > here.
> > >
> >
> > Per my previous e-mail I'm not particularly familiar with mm internals,
> > so I'm going to handwave a little bit with my $0,03 concerning multicor=
e
> > in general and if you disagree with it that's your business. For the
> > time being I have no interest in digging into any of this.
> >
> > Before I do, to prevent this thread from being a total waste, here are
> > some remarks concerning the patch with the assumption that the core ide=
a
> > lands.
> >
> > From the commit message:
> > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > > vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> > > attempting uprobe look up speculatively.
> >
> > Just in case I'll note a nit that this paragraph will need to be remove=
d
> > since the patch adding the flag is getting dropped.
>
> Yep, of course, I'll update all that for the next revision (I'll wait
> for non-RFC patches to land first before reposting).
>
> >
> > A non-nit which may or may not end up mattering is that the flag (which
> > *is* set on the filep slab cache) makes things more difficult to
> > validate. Normal RCU usage guarantees that the object itself wont be
> > freed as long you follow the rules. However, the SLAB_TYPESAFE_BY_RCU
> > flag weakens it significantly -- the thing at hand will always be a
> > 'struct file', but it may get reallocated to *another* file from under
> > you. Whether this aspect plays a role here I don't know.
>
> Yes, that's ok and is accounted for. We care about that memory not
> going even from under us (I'm not even sure if it matters that it is
> still a struct file, tbh; I think that shouldn't matter as we are
> prepared to deal with completely garbage values read from struct
> file).

Correct, with SLAB_TYPESAFE_BY_RCU we do need an additional check that
vma->vm_file has not been freed and reused. That's where
mmap_lock_speculation_{start|end} helps us. For vma->vm_file to change
from under us one would have to take mmap_lock for write. If that
happens mmap_lock_speculation_{start|end} should detect that and
terminate our speculation.

>
> >
> > > +static struct uprobe *find_active_uprobe_speculative(unsigned long b=
p_vaddr)
> > > +{
> > > +     const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHAR=
E;
> > > +     struct mm_struct *mm =3D current->mm;
> > > +     struct uprobe *uprobe;
> > > +     struct vm_area_struct *vma;
> > > +     struct file *vm_file;
> > > +     struct inode *vm_inode;
> > > +     unsigned long vm_pgoff, vm_start;
> > > +     int seq;
> > > +     loff_t offset;
> > > +
> > > +     if (!mmap_lock_speculation_start(mm, &seq))
> > > +             return NULL;
> > > +
> > > +     rcu_read_lock();
> > > +
> >
> > I don't think there is a correctness problem here, but entering rcu
> > *after* deciding to speculatively do the lookup feels backwards.
>
> RCU should protect VMA and file, mm itself won't go anywhere, so this see=
ms ok.
>
> >
> > > +     vma =3D vma_lookup(mm, bp_vaddr);
> > > +     if (!vma)
> > > +             goto bail;
> > > +
> > > +     vm_file =3D data_race(vma->vm_file);
> > > +     if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > > +             goto bail;
> > > +
> >
> > If vma teardown is allowed to progress and the file got fput'ed...
> >
> > > +     vm_inode =3D data_race(vm_file->f_inode);
> >
> > ... the inode can be NULL, I don't know if that's handled.
> >
>
> Yep, inode pointer value is part of RB-tree key, so if it's NULL, we
> just won't find a matching uprobe. Same for any other "garbage"
> f_inode value. Importantly, we never should dereference such inode
> pointers, at least until we find a valid uprobe (in which case we keep
> inode reference to it).
>
> > More importantly though, per my previous description of
> > SLAB_TYPESAFE_BY_RCU, by now the file could have been reallocated and
> > the inode you did find is completely unrelated.
> >
> > I understand the intent is to backpedal from everything should the mm
> > seqc change, but the above may happen to matter.
>
> Yes, I think we took that into account. All that we care about is
> memory "type safety", i.e., even if struct file's memory is reused,
> it's ok, we'll eventually detect the change and will discard wrong
> uprobe that we might by accident lookup (though probably in most cases
> we just won't find a uprobe at all).
>
> >
> > > +     vm_pgoff =3D data_race(vma->vm_pgoff);
> > > +     vm_start =3D data_race(vma->vm_start);
> > > +
> > > +     offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_st=
art);
> > > +     uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > +     if (!uprobe)
> > > +             goto bail;
> > > +
> > > +     /* now double check that nothing about MM changed */
> > > +     if (!mmap_lock_speculation_end(mm, seq))
> > > +             goto bail;
> >
> > This leaks the reference obtained by find_uprobe_rcu().
>
> find_uprobe_rcu() doesn't obtain a reference, uprobe is RCU-protected,
> and if caller need a refcount bump it will have to use
> try_get_uprobe() (which might fail).
>
> >
> > > +
> > > +     rcu_read_unlock();
> > > +
> > > +     /* happy case, we speculated successfully */
> > > +     return uprobe;
> > > +bail:
> > > +     rcu_read_unlock();
> > > +     return NULL;
> > > +}
> >
> > Now to some handwaving, here it is:
> >
> > The core of my concern is that adding more work to down_write on the
> > mmap semaphore comes with certain side-effects and plausibly more than =
a
> > sufficient speed up can be achieved without doing it.

AFAIK writers of mmap_lock are not considered a fast path. In a sense
yes, we made any writer a bit heavier but OTOH we also made
mm->mm_lock_seq a proper sequence count which allows us to locklessly
check if mmap_lock is write-locked. I think you asked whether there
will be other uses for mmap_lock_speculation_{start|end} and yes. For
example, I am planning to use them for printing /proc/{pid}/maps
without taking mmap_lock (when it's uncontended). If we have VMA seq
counter-based detection it would be better (see below).

> >
> > An mm-wide mechanism is just incredibly coarse-grained and it may happe=
n
> > to perform poorly when faced with a program which likes to mess with it=
s
> > address space -- the fast path is going to keep failing and only
> > inducing *more* overhead as the code decides to down_read the mmap
> > semaphore.
> >
> > Furthermore there may be work currently synchronized with down_write
> > which perhaps can transition to "merely" down_read, but by the time it
> > happens this and possibly other consumers expect a change in the
> > sequence counter, messing with it.
> >
> > To my understanding the kernel supports parallel faults with per-vma
> > locking. I would find it surprising if the same machinery could not be
> > used to sort out uprobe handling above.

From all the above, my understanding of your objection is that
checking mmap_lock during our speculation is too coarse-grained and
you would prefer to use the VMA seq counter to check that the VMA we
are working on is unchanged. I agree, that would be ideal. I had a
quick chat with Jann about this and the conclusion we came to is that
we would need to add an additional smp_wmb() barrier inside
vma_start_write() and a smp_rmb() in the speculation code:

static inline void vma_start_write(struct vm_area_struct *vma)
{
        int mm_lock_seq;

        if (__is_vma_write_locked(vma, &mm_lock_seq))
                return;

        down_write(&vma->vm_lock->lock);
        /*
         * We should use WRITE_ONCE() here because we can have concurrent r=
eads
         * from the early lockless pessimistic check in vma_start_read().
         * We don't really care about the correctness of that early check, =
but
         * we should use WRITE_ONCE() for cleanliness and to keep KCSAN hap=
py.
         */
        WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
+        smp_wmb();
        up_write(&vma->vm_lock->lock);
}

Note: up_write(&vma->vm_lock->lock) in the vma_start_write() is not
enough because it's one-way permeable (it's a "RELEASE operation") and
later vma->vm_file store (or any other VMA modification) can move
before our vma->vm_lock_seq store.

This makes vma_start_write() heavier but again, it's write-locking, so
should not be considered a fast path.
With this change we can use the code suggested by Andrii in
https://lore.kernel.org/all/CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjcA2+6=
k69Q@mail.gmail.com/
with an additional smp_rmb():

rcu_read_lock()
vma =3D find_vma(...)
if (!vma) /* bail */

vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
/* I think vm_lock has to be acquired first to avoid the race */
if (mm_lock_seq =3D=3D vm_lock_seq)
        /* bail, vma is write-locked */
... perform uprobe lookup logic based on vma->vm_file->f_inode ...
smp_rmb();
if (vma->vm_lock_seq !=3D vm_lock_seq)
        /* bail, VMA might have changed */

The smp_rmb() is needed so that vma->vm_lock_seq load does not get
reordered and moved up before speculation.

I'm CC'ing Jann since he understands memory barriers way better than
me and will keep me honest.


>
> per-vma locking is still *locking*. Which means memory sharing between
> multiple CPUs, which means limited scalability. Lots of work in this
> series went to avoid even refcounting (as I pointed out for
> find_uprobe_rcu()) due to the same reason, and so relying on per-VMA
> locking is just shifting the bottleneck from mmap_lock to
> vma->vm_lock. Worst (and not uncommon) case is the same uprobe in the
> same process (and thus vma) being hit on multiple CPUs at the same
> time. Whether that's protected by mmap_lock or vma->vm_lock is
> immaterial at that point (from scalability standpoint).
>
> >
> > I presume a down_read on vma around all the work would also sort out an=
y
> > issues concerning stability of the file or inode objects.
> >
> > Of course single-threaded performance would take a hit due to atomic
> > stemming from down/up_read and parallel uprobe lookups on the same vma
> > would also get slower, but I don't know if that's a problem for a real
> > workload.
> >
> > I would not have any comments if all speed ups were achieved without
> > modifying non-uprobe code.
>
> I'm also not a mm-focused person, so I'll let Suren and others address
> mm-specific concerns, but I (hopefully) addressed all the
> uprobe-related questions and concerns you had.

