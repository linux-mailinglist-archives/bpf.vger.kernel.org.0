Return-Path: <bpf+bounces-36445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97858948833
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 06:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93C61C21F06
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 04:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6D1BA88D;
	Tue,  6 Aug 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CItAcj+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783AA59;
	Tue,  6 Aug 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917304; cv=none; b=Ja7kROdHONF9a2+kMsHtDRM/QbiQxVU9Ib7VufXBI4ZNQrJZ5rrxy55OneHp8gULJJDvoDo5VxzQ+yLw54eAZJSbP1o7krToLr1zGwvMZRkhu0VJUlPmmrxY11dmJT4BOtIiuPVklA5ofpFFkzIVzV23rRCQHDXxHrDLhWQrYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917304; c=relaxed/simple;
	bh=LscGH4hKGxiphI81let4IXI6/0DyKy1o2DGYhysplM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yua03KQ56szG6xjH+I/QhByT/UJVbjCwKdehgUVjjrTGpEO6Lzj0E4z2fIlrNAiz96fLLEG77pNk2vehGWguAaIr98SqG4wBWq6f2kUzZ+ziSCv9CT/rZEeog5HGiK8gPsYdBc82DNjCkWKAMe1CHA83zs6fW4Ocaapt6dZDEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CItAcj+u; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso123063b3a.0;
        Mon, 05 Aug 2024 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722917302; x=1723522102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IT8sEsFAxIa+ue7ADaJWFTGS/kPVVConO5rGnfybXg=;
        b=CItAcj+uDR/3aspTIx31d81fNThS2piufyTCkAf0NC9TQ+xqh9FBXsLgpmlEMD3faT
         BCOwPAtMHTD5eV5Ngfr5ulifjeahT5AyFnO2ritTfgjIxo7qzi68RpJ681zAQKjLd8iI
         WtSxRAy3zC8Jf3n92SMXFQlfBPmp5Df+xF5UciD/he7dEALujJYqi7OiFcwxXSq1BkTz
         u2iJkhQGFpn7PmZJm9iEBf6dniNeXXr4dgCGZjMDz8l3nX7tWJWRAzlGxwgCkmcVGGuT
         2m3NygcIx/lgQ9H5fobC0FoUV9SiFXz8/83Gr0Mt42K3tjfN4c5T4WLyY6DnTzxYaMf+
         wLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722917302; x=1723522102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IT8sEsFAxIa+ue7ADaJWFTGS/kPVVConO5rGnfybXg=;
        b=Ptq/MxOaR4Bx6ow6biYmuLVKHbiVjbhwqVIYYHWSTBGjusAzm9ZSNrO5JUW/PunmFj
         BmNhorq5oBeQkg9EgweuE4aPoBTmhnpehoduBG3K0YcMOvN0NBixqRWI9frioLUtgAmp
         YwGVFHxJzHfTl2iBvy02Z/RVcg0U/LQv3DlM8tQIa4IGUqfBaoWbEjFlhEjImYgsDoZm
         UyrFr04jOQE8FYTNnupVP3NFJnLDnWFKmrlzpTjZ+XZ3uJArjXJPg93KyZPzkSUxAX5F
         oNfhJ2jJu/SzWe0JfbxMy4O8+BMyotdnDB+24i7o3FGkNPs/yLQNOqonhzwSt8d4Z6uh
         7x4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6DczyPWaD+8YfoE9T1MLpS8vN0tytHZ3glQ0VHN2miZzYkOj0MzrjHp3h2trQg5cT21zCIL2ZFvp97Kxo1TW5i1uLfXysP0v1IEjN8V6RwruCNHZOeYNt2XYB1x172f67
X-Gm-Message-State: AOJu0Yz30JdjBSWtyGp5g2JDHphZ7IGQ6cs8xN4KmNuRJ7DiVhV9UipV
	Ou2s1Ba7jOrVjUTAMtc8lGNkvBWcGSiPpiyOQsSCZFbvXAh6UOhRmB5toEZ1WcvHT743j/ggYFR
	AGLoPgJ0R5w6yfTk8F1lhg/vnU/4=
X-Google-Smtp-Source: AGHT+IF20GaEPNQro6dBiwEIVSRqnAshwy8AQADhn3PB57dSXpIv2LWeFXipXlJpjrGifopKW8CyuShoUAd8vpwa6E8=
X-Received: by 2002:a05:6a20:9148:b0:1c0:eba5:e192 with SMTP id
 adf61e73a8af0-1c69958619amr15112499637.27.1722917302185; Mon, 05 Aug 2024
 21:08:22 -0700 (PDT)
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
In-Reply-To: <CAEf4BzYPpkhKtuaT-EbyKeB13-uBeYf8LjR9CB=xaXYHnwsyAQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Aug 2024 21:08:09 -0700
Message-ID: <CAEf4BzZ26FNTguRh_X9_5eQZvOeKb+c-o3mxSzoM2+TF3NqaWA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, oleg@redhat.com, 
	jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 4:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Aug 3, 2024 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko wrote:
> >
> > > Is there any reason why the approach below won't work?
> >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 8be9e34e786a..e21b68a39f13 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2251,6 +2251,52 @@ static struct uprobe
> > > *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> > >         struct uprobe *uprobe =3D NULL;
> > >         struct vm_area_struct *vma;
> > >
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE, v=
m_flags;
> > > +       struct file *vm_file;
> > > +       struct inode *vm_inode;
> > > +       unsigned long vm_pgoff, vm_start, vm_end;
> > > +       int vm_lock_seq;
> > > +       loff_t offset;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > +       if (!vma)
> > > +               goto retry_with_lock;
> > > +
> > > +       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
> >
> > So vma->vm_lock_seq is only updated on vma_start_write()
>
> yep, I've looked a bit more at the implementation now
>
> >
> > > +
> > > +       vm_file =3D READ_ONCE(vma->vm_file);
> > > +       vm_flags =3D READ_ONCE(vma->vm_flags);
> > > +       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXEC)
> > > +               goto retry_with_lock;
> > > +
> > > +       vm_inode =3D READ_ONCE(vm_file->f_inode);
> > > +       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
> > > +       vm_start =3D READ_ONCE(vma->vm_start);
> > > +       vm_end =3D READ_ONCE(vma->vm_end);
> >
> > None of those are written with WRITE_ONCE(), so this buys you nothing.
> > Compiler could be updating them one byte at a time while you load some
> > franken-update.
> >
> > Also, if you're in the middle of split_vma() you might not get a
> > consistent set.
>
> I used READ_ONCE() only to prevent the compiler from re-reading those
> values. We assume those values are garbage anyways and double-check
> everything, so lack of WRITE_ONCE doesn't matter. Same for
> inconsistency if we are in the middle of split_vma().
>
> We use the result of all this speculative calculation only if we find
> a valid uprobe (which could be a false positive) *and* if we detect
> that nothing about VMA changed (which is what I got wrong, but
> honestly I was actually betting on others to help me get this right
> anyways).
>
> >
> > > +       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
> > > +               goto retry_with_lock;
> > > +
> > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_=
start);
> > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > +       if (!uprobe)
> > > +               goto retry_with_lock;
> > > +
> > > +       /* now double check that nothing about VMA changed */
> > > +       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
> > > +               goto retry_with_lock;
> >
> > Since vma->vma_lock_seq is only ever updated at vma_start_write() you'r=
e
> > checking you're in or after the same modification cycle.
> >
> > The point of sequence locks is to check you *IN* a modification cycle
> > and retry if you are. You're now explicitly continuing if you're in a
> > modification.
> >
> > You really need:
> >
> >    seq++;
> >    wmb();
> >
> >    ... do modification
> >
> >    wmb();
> >    seq++;
> >
> > vs
> >
> >   do {
> >           s =3D READ_ONCE(seq) & ~1;
> >           rmb();
> >
> >           ... read stuff
> >
> >   } while (rmb(), seq !=3D s);
> >
> >
> > The thing to note is that seq will be odd while inside a modification
> > and even outside, further if the pre and post seq are both even but not
> > identical, you've crossed a modification and also need to retry.
> >
>
> Ok, I don't think I got everything you have written above, sorry. But
> let me explain what I think I need to do and please correct what I
> (still) got wrong.
>
> a) before starting speculation,
>   a.1) read and remember current->mm->mm_lock_seq (using
> smp_load_acquire(), right?)
>   a.2) read vma->vm_lock_seq (using smp_load_acquire() I presume)
>   a.3) if vm_lock_seq is odd, we are already modifying VMA, so bail
> out, try with proper mmap_lock
> b) proceed with the inode pointer fetch and offset calculation as I've co=
ded it
> c) lookup uprobe by inode+offset, if failed -- bail out (if succeeded,
> this could still be wrong)
> d) re-read vma->vm_lock_seq, if it changed, we started modifying/have
> already modified VMA, bail out
> e) re-read mm->mm_lock_seq, if that changed -- presume VMA got
> modified, bail out
>
> At this point we should have a guarantee that nothing about mm
> changed, nor that VMA started being modified during our speculative
> calculation+uprobe lookup. So if we found a valid uprobe, it must be a
> correct one that we need.
>
> Is that enough? Any holes in the approach? And thanks for thoroughly
> thinking about this, btw!

Ok, with slight modifications to the details of the above (e.g., there
is actually no "odd means VMA is being modified" thing with
vm_lock_seq), I ended up with the implementation below. Basically we
validate that mm->mm_lock_seq didn't change and that vm_lock_seq !=3D
mm_lock_seq (which otherwise would mean "VMA is being modified").
There is a possibility that vm_lock_seq =3D=3D mm_lock_seq just by
accident, which is not a correctness problem, we'll just fallback to
locked implementation until something about VMA or mm_struct itself
changes. Which is fine, and if mm folks ever change this locking
schema, this might go away.

If this seems on the right track, I think we can just move
mm_start_vma_specuation()/mm_end_vma_speculation() into
include/linux/mm.h.

And after thinking a bit more about READ_ONCE() usage, I changed them
to data_race() to not trigger KCSAN warnings. Initially I kept
READ_ONCE() only around vma->vm_file access, but given we never change
it until vma is freed and reused (which would be prevented by
guard(rcu)), I dropped READ_ONCE() and only added data_race(). And
even data_race() is probably not necessary.

Anyways, please see the patch below. Would be nice if mm folks
(Suren?) could confirm that this is not broken.



Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Fri Aug 2 22:16:40 2024 -0700

    uprobes: add speculative lockless VMA to inode resolution

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3de311c56d47..bee7a929ff02 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2244,6 +2244,70 @@ static int is_trap_at_addr(struct mm_struct
*mm, unsigned long vaddr)
        return is_trap_insn(&opcode);
 }

+#ifdef CONFIG_PER_VMA_LOCK
+static inline void mm_start_vma_speculation(struct mm_struct *mm, int
*mm_lock_seq)
+{
+       *mm_lock_seq =3D smp_load_acquire(&mm->mm_lock_seq);
+}
+
+/* returns true if speculation was safe (no mm and vma modification
happened) */
+static inline bool mm_end_vma_speculation(struct vm_area_struct *vma,
int mm_lock_seq)
+{
+       int mm_seq, vma_seq;
+
+       mm_seq =3D smp_load_acquire(&vma->vm_mm->mm_lock_seq);
+       vma_seq =3D READ_ONCE(vma->vm_lock_seq);
+
+       return mm_seq =3D=3D mm_lock_seq && vma_seq !=3D mm_seq;
+}
+
+static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vadd=
r)
+{
+       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+       struct mm_struct *mm =3D current->mm;
+       struct uprobe *uprobe;
+       struct vm_area_struct *vma;
+       struct file *vm_file;
+       struct inode *vm_inode;
+       unsigned long vm_pgoff, vm_start;
+       int mm_lock_seq;
+       loff_t offset;
+
+       guard(rcu)();
+
+       mm_start_vma_speculation(mm, &mm_lock_seq);
+
+       vma =3D vma_lookup(mm, bp_vaddr);
+       if (!vma)
+               return NULL;
+
+       vm_file =3D data_race(vma->vm_file);
+       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
+               return NULL;
+
+       vm_inode =3D data_race(vm_file->f_inode);
+       vm_pgoff =3D data_race(vma->vm_pgoff);
+       vm_start =3D data_race(vma->vm_start);
+
+       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start)=
;
+       uprobe =3D find_uprobe_rcu(vm_inode, offset);
+       if (!uprobe)
+               return NULL;
+
+       /* now double check that nothing about MM and VMA changed */
+       if (!mm_end_vma_speculation(vma, mm_lock_seq))
+               return NULL;
+
+       /* happy case, we speculated successfully */
+       return uprobe;
+}
+#else /* !CONFIG_PER_VMA_LOCK */
+static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vadd=
r)
+{
+       return NULL;
+}
+#endif /* CONFIG_PER_VMA_LOCK */
+
 /* assumes being inside RCU protected region */
 static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr,
int *is_swbp)
 {
@@ -2251,6 +2315,10 @@ static struct uprobe
*find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
        struct uprobe *uprobe =3D NULL;
        struct vm_area_struct *vma;

+       uprobe =3D find_active_uprobe_speculative(bp_vaddr);
+       if (uprobe)
+               return uprobe;
+
        mmap_read_lock(mm);
        vma =3D vma_lookup(mm, bp_vaddr);
        if (vma) {
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..211a84ee92b4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
                        NULL);
        files_cachep =3D kmem_cache_create("files_cache",
                        sizeof(struct files_struct), 0,
-                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+
SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
                        NULL);
        fs_cachep =3D kmem_cache_create("fs_cache",
                        sizeof(struct fs_struct), 0,


>
> P.S. This is basically the last big blocker towards linear uprobes
> scalability with the number of active CPUs. I have
> uretprobe+SRCU+timeout implemented and it seems to work fine, will
> post soon-ish.
>
> P.P.S Also, funny enough, below was another big scalability limiter
> (and the last one) :) I'm not sure if we can just drop it, or I should
> use per-CPU counter, but with the below change and speculative VMA
> lookup (however buggy, works ok for benchmarking), I finally get
> linear scaling of uprobe triggering throughput with number of CPUs. We
> are very close.
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f7443e996b1b..64c2bc316a08 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1508,7 +1508,7 @@ static int uprobe_dispatcher(struct
> uprobe_consumer *con, struct pt_regs *regs)
>         int ret =3D 0;
>
>         tu =3D container_of(con, struct trace_uprobe, consumer);
> -       tu->nhit++;
> +       //tu->nhit++;
>
>         udd.tu =3D tu;
>         udd.bp_addr =3D instruction_pointer(regs);
>
>
> > > +
> > > +       /* happy case, we speculated successfully */
> > > +       rcu_read_unlock();
> > > +       return uprobe;
> > > +
> > > +retry_with_lock:
> > > +       rcu_read_unlock();
> > > +       uprobe =3D NULL;
> > > +#endif
> > > +
> > >         mmap_read_lock(mm);
> > >         vma =3D vma_lookup(mm, bp_vaddr);
> > >         if (vma) {
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index cc760491f201..211a84ee92b4 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
> > >                         NULL);
> > >         files_cachep =3D kmem_cache_create("files_cache",
> > >                         sizeof(struct files_struct), 0,
> > > -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > > + SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
> > >                         NULL);
> > >         fs_cachep =3D kmem_cache_create("fs_cache",
> > >                         sizeof(struct fs_struct), 0,

