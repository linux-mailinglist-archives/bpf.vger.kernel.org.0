Return-Path: <bpf+bounces-37279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133195388B
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F40DB21029
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282651BA86F;
	Thu, 15 Aug 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0mVCdvO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22384198E78;
	Thu, 15 Aug 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740460; cv=none; b=n55Sc2sk16jGJ3phx34bfYinaj9U19oaNnIEUtVgfnzFQX63SYr96wT6fPzigea5+5lMZe5BEDY4IYCcFCLOxjZWb4OYq1iHjSpW1VIbIUtJubyct3OjRQBnu8Uk0L4JiZWKexoqRpvCZ3CKi/WIA3BWjKVRK/rTDUAvw5gy0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740460; c=relaxed/simple;
	bh=gCOEEich/4uFnkLx89sIR9V72jWQ3VR5yr/HkG+1YIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scYYlw1QnAcUqEcKRBwJqT6zEbfZnKkp3D75CKEOHmhC1+ufMgE7BS/wjpPzHl2FiM2bHRuyZ17U5Z3QiQhg9y1Qmy68ohgtkrf5lmx0YraltbvQo34KtdLjfuXF+Jjkd2U4gOOWUzJXqGBl4sbf8MI9uF1sWdopz/48ZL/xcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0mVCdvO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so465981a91.0;
        Thu, 15 Aug 2024 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723740458; x=1724345258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAffWbsLnPetVPci2wTuvab/xXJ2z1Q3fN0le8307es=;
        b=i0mVCdvO64pVzrzeUd7Seq0aexQaHlAo8XvPdkLHKlo6drOeRqkPJk4jSPLKQS3MIR
         XTSOzT/RGmnyaG4ZQkmT6kuLMtjhqpxgh17AEI5ZcfxxAQV06KQQMa3RvP/NDzy/WwFH
         pEkB9zaSU3wCsEVoBS5BxBAWKPWAB7hDSylETGUW5sWCBm6TD+uozfGgYeRmtNfxltF+
         5wENN5z2EsrcmmhvC0utW5dq7dgi/VvaV/sDqfi3+ed47d6C/g0b4dz6TfJPZtTOwc8T
         CodIHju4HilZermIKqBC8nc6BQjW0tJsqP7Z36FJBSTPg9N/n+LxYGn6rvZgqZEFLL9V
         tJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740458; x=1724345258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAffWbsLnPetVPci2wTuvab/xXJ2z1Q3fN0le8307es=;
        b=itXJBTjZCa4wR9nmz6Nm6JXkHgoA9OHxQ1CunUNKRtyX2nA2IiibD2DJ+pbwGAEyY7
         5MXTAXMOaXY9KoDm19z558EyUwcE3mM/WT/jLHjuRydJweQaCdNphK4egOrhH8/dbui3
         zeKdhSx/l9jG8xbZgC+do8x4KIyTTr6QE+GBMY27Tz5yRhAKyosXQubNTTGCj1xmtOAb
         uDaygzqD/IC/EBpvH7HluLPgURZDnVS/csATXEJapotVnd5awTkDDJpyL+9hNwPU6wWG
         8cUcFYfmfdB9MEkSqmlFEjuZxAlF29dvkZe5WtVZwZ2XQ7OiMjWwPypr/3mem5qkG6aT
         9ZUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/hCOYBoSeTYSKy9UlqL3+vZfjD5Z5hx3F5QXxynJeJDYdzgNU+m1cFRStJoB/Ms4Id+9PiHy7UxYnGzoRVvYA2PxP2FMHI4X23R13y/cdH87mCJ6SyZ4apfwY9Y0AYZ5nX5ac1dY9QvjZDynbIp5ajqje9ApTpNj9J2aGQtCDMjPJK9pR
X-Gm-Message-State: AOJu0YxcEvQN+4N4ZJI/lSDIa15Hvl+MIERV1zn1sN7I1Hv6wdfObWNc
	ruvW+BRwvCytMjhksZCIZjDyEdV85FqyBbt3TLkm1Xx4LYjiReFgdIX13hVNDc4OPecX2VnVIBF
	gjnlVYereXLPjEHVKCz+JPelhVoI=
X-Google-Smtp-Source: AGHT+IGPPhKOy6VU0AspQwojFzQHGwzc8lH4o3OUbuX1lktMpt4gThW4jG4kZW+gLk846vEjT7ApldS9rVr8CiXLS5s=
X-Received: by 2002:a17:90a:6fe2:b0:2d3:d4eb:10e0 with SMTP id
 98e67ed59e1d1-2d3e0f39057mr186867a91.43.1723740458382; Thu, 15 Aug 2024
 09:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com> <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
In-Reply-To: <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 09:47:26 -0700
Message-ID: <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > > > vma->vm_file->f_inode lockless only under rcu_read_lock() protectio=
n,
> > > > attempting uprobe look up speculatively.
> > > >
> > > > We rely on newly added mmap_lock_speculation_{start,end}() helpers =
to
> > > > validate that mm_struct stays intact for entire duration of this
> > > > speculation. If not, we fall back to mmap_lock-protected lookup.
> > > >
> > > > This allows to avoid contention on mmap_lock in absolutely majority=
 of
> > > > cases, nicely improving uprobe/uretprobe scalability.
> > > >
> > >
> > > Here I have to admit to being mostly ignorant about the mm, so bear w=
ith
> > > me. :>
> > >
> > > I note the result of find_active_uprobe_speculative is immediately st=
ale
> > > in face of modifications.
> > >
> > > The thing I'm after is that the mmap_lock_speculation business adds
> > > overhead on archs where a release fence is not a de facto nop and I
> > > don't believe the commit message justifies it. Definitely a bummer to
> > > add merely it for uprobes. If there are bigger plans concerning it
> > > that's a different story of course.
> > >
> > > With this in mind I have to ask if instead you could perhaps get away
> > > with the already present per-vma sequence counter?
> >
> > per-vma sequence counter does not implement acquire/release logic, it
> > relies on vma->vm_lock for synchronization. So if we want to use it,
> > we would have to add additional memory barriers here. This is likely
> > possible but as I mentioned before we would need to ensure the
> > pagefault path does not regress. OTOH mm->mm_lock_seq already halfway
> > there (it implements acquire/release logic), we just had to ensure
> > mmap_write_lock() increments mm->mm_lock_seq.
> >
> > So, from the release fence overhead POV I think whether we use
> > mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
> > here.
> >
>
> Per my previous e-mail I'm not particularly familiar with mm internals,
> so I'm going to handwave a little bit with my $0,03 concerning multicore
> in general and if you disagree with it that's your business. For the
> time being I have no interest in digging into any of this.
>
> Before I do, to prevent this thread from being a total waste, here are
> some remarks concerning the patch with the assumption that the core idea
> lands.
>
> From the commit message:
> > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> > attempting uprobe look up speculatively.
>
> Just in case I'll note a nit that this paragraph will need to be removed
> since the patch adding the flag is getting dropped.

Yep, of course, I'll update all that for the next revision (I'll wait
for non-RFC patches to land first before reposting).

>
> A non-nit which may or may not end up mattering is that the flag (which
> *is* set on the filep slab cache) makes things more difficult to
> validate. Normal RCU usage guarantees that the object itself wont be
> freed as long you follow the rules. However, the SLAB_TYPESAFE_BY_RCU
> flag weakens it significantly -- the thing at hand will always be a
> 'struct file', but it may get reallocated to *another* file from under
> you. Whether this aspect plays a role here I don't know.

Yes, that's ok and is accounted for. We care about that memory not
going even from under us (I'm not even sure if it matters that it is
still a struct file, tbh; I think that shouldn't matter as we are
prepared to deal with completely garbage values read from struct
file).

>
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +     const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> > +     struct mm_struct *mm =3D current->mm;
> > +     struct uprobe *uprobe;
> > +     struct vm_area_struct *vma;
> > +     struct file *vm_file;
> > +     struct inode *vm_inode;
> > +     unsigned long vm_pgoff, vm_start;
> > +     int seq;
> > +     loff_t offset;
> > +
> > +     if (!mmap_lock_speculation_start(mm, &seq))
> > +             return NULL;
> > +
> > +     rcu_read_lock();
> > +
>
> I don't think there is a correctness problem here, but entering rcu
> *after* deciding to speculatively do the lookup feels backwards.

RCU should protect VMA and file, mm itself won't go anywhere, so this seems=
 ok.

>
> > +     vma =3D vma_lookup(mm, bp_vaddr);
> > +     if (!vma)
> > +             goto bail;
> > +
> > +     vm_file =3D data_race(vma->vm_file);
> > +     if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> > +             goto bail;
> > +
>
> If vma teardown is allowed to progress and the file got fput'ed...
>
> > +     vm_inode =3D data_race(vm_file->f_inode);
>
> ... the inode can be NULL, I don't know if that's handled.
>

Yep, inode pointer value is part of RB-tree key, so if it's NULL, we
just won't find a matching uprobe. Same for any other "garbage"
f_inode value. Importantly, we never should dereference such inode
pointers, at least until we find a valid uprobe (in which case we keep
inode reference to it).

> More importantly though, per my previous description of
> SLAB_TYPESAFE_BY_RCU, by now the file could have been reallocated and
> the inode you did find is completely unrelated.
>
> I understand the intent is to backpedal from everything should the mm
> seqc change, but the above may happen to matter.

Yes, I think we took that into account. All that we care about is
memory "type safety", i.e., even if struct file's memory is reused,
it's ok, we'll eventually detect the change and will discard wrong
uprobe that we might by accident lookup (though probably in most cases
we just won't find a uprobe at all).

>
> > +     vm_pgoff =3D data_race(vma->vm_pgoff);
> > +     vm_start =3D data_race(vma->vm_start);
> > +
> > +     offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_star=
t);
> > +     uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > +     if (!uprobe)
> > +             goto bail;
> > +
> > +     /* now double check that nothing about MM changed */
> > +     if (!mmap_lock_speculation_end(mm, seq))
> > +             goto bail;
>
> This leaks the reference obtained by find_uprobe_rcu().

find_uprobe_rcu() doesn't obtain a reference, uprobe is RCU-protected,
and if caller need a refcount bump it will have to use
try_get_uprobe() (which might fail).

>
> > +
> > +     rcu_read_unlock();
> > +
> > +     /* happy case, we speculated successfully */
> > +     return uprobe;
> > +bail:
> > +     rcu_read_unlock();
> > +     return NULL;
> > +}
>
> Now to some handwaving, here it is:
>
> The core of my concern is that adding more work to down_write on the
> mmap semaphore comes with certain side-effects and plausibly more than a
> sufficient speed up can be achieved without doing it.
>
> An mm-wide mechanism is just incredibly coarse-grained and it may happen
> to perform poorly when faced with a program which likes to mess with its
> address space -- the fast path is going to keep failing and only
> inducing *more* overhead as the code decides to down_read the mmap
> semaphore.
>
> Furthermore there may be work currently synchronized with down_write
> which perhaps can transition to "merely" down_read, but by the time it
> happens this and possibly other consumers expect a change in the
> sequence counter, messing with it.
>
> To my understanding the kernel supports parallel faults with per-vma
> locking. I would find it surprising if the same machinery could not be
> used to sort out uprobe handling above.

per-vma locking is still *locking*. Which means memory sharing between
multiple CPUs, which means limited scalability. Lots of work in this
series went to avoid even refcounting (as I pointed out for
find_uprobe_rcu()) due to the same reason, and so relying on per-VMA
locking is just shifting the bottleneck from mmap_lock to
vma->vm_lock. Worst (and not uncommon) case is the same uprobe in the
same process (and thus vma) being hit on multiple CPUs at the same
time. Whether that's protected by mmap_lock or vma->vm_lock is
immaterial at that point (from scalability standpoint).

>
> I presume a down_read on vma around all the work would also sort out any
> issues concerning stability of the file or inode objects.
>
> Of course single-threaded performance would take a hit due to atomic
> stemming from down/up_read and parallel uprobe lookups on the same vma
> would also get slower, but I don't know if that's a problem for a real
> workload.
>
> I would not have any comments if all speed ups were achieved without
> modifying non-uprobe code.

I'm also not a mm-focused person, so I'll let Suren and others address
mm-specific concerns, but I (hopefully) addressed all the
uprobe-related questions and concerns you had.

