Return-Path: <bpf+bounces-36353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B49471C1
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 01:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A58EB20A16
	for <lists+bpf@lfdr.de>; Sun,  4 Aug 2024 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891613B5BD;
	Sun,  4 Aug 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApO/XTDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800D1755C;
	Sun,  4 Aug 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813751; cv=none; b=GPjLdazDeI8kPVbfeZwnBTIk37q/MIOoJvkU3dcJH8I/1uDYVdON1yGUiZc3LiAvhVgpYCbnZjpETfW+Ee4r3NDASvU/xz4A7cys/Xh46ffWkKQn3w4jne6+sI2ZqpU9WR7GebrlFo6lhqdI7wrsIflbPz6PhRcbitEWBGOpSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813751; c=relaxed/simple;
	bh=B22bmXMk5vCAwTCNlStAiknyA/Ux6zdUTO4642Al0WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQNv4cendtoP0YbiLYKa4igfb2AwG/9Bv6duLYazhwb1asfESryYK42EhBL+cYsMDv/npezPrd2iah/edWBiDcd38Bn74+oEvmRT2aRcEeKGr5GAZEYfOcN96y52fG3bEiuy2RstVicZpS/xsnqxaehUoQGMqMKf/XGVjBbfyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApO/XTDo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cf98ba0559so5242919a91.2;
        Sun, 04 Aug 2024 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722813749; x=1723418549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMier1JNA60dPkurr0YXWlfST+AOM1jYQPXfg6gYsVw=;
        b=ApO/XTDoqrNfBNInBUOmmyxLUmxWZ8SPBHyvjsmSYWoekKHtg3K7TLZb5w3x97jSFS
         lQeQ8ANAscSdoTeH9vrjvh47XnrT37BUSYZza8vSlYKCevGJuvfMuUc+s60gJXNdlQtk
         EQ96dNjwddejTYsc3ZsrIb5sXz11yhuxuYpDkEJiU9tzMd355zJxpvi6D3vTFaacwtx1
         StgNVOmQpP/M57A8NgbhE7rbcycIpLWJPdNqkuCprYxEhU4jbOO/5NhzaHcw3vEWbRE9
         FXZ7DkjRmTKFM+/RfYXNKZNhji1sk2I6/YEzTWK1b4C8m/GEl098B/WyJURK7mmBwwhq
         zXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722813749; x=1723418549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMier1JNA60dPkurr0YXWlfST+AOM1jYQPXfg6gYsVw=;
        b=s69QdlgDl8XeBOdG6rBmEFtIoP9JUqmlGd2sbgJpd8qn9uhDOios4choBWVtW3+1ix
         pReorj2+DeXZM9AoH+uOoHiq62luJWwyHVr7PHLyDhROdsPYn+8Y82y9v3SckZ0e0Dlv
         ySvIzPZ223oSEvl2ZstYPLj4q2yKq2I6GZMTNcGSLu7R0vUXRXf4Ii+F9aLhQJjYhAcV
         8WCkjWH5anKoI6Qfkyc7sFQ1DA24RUnV7IU7E9oSICpHExpaonX8Is8vFFCwhp0fkEDV
         E6nFo+IgGatp4oj2aIoAqZy2KKS7xY3wCm3OlltjAteO62LNlhffX/h49C7vP6u5x/fe
         60YA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrlU8V29zgzsfeE9L6drCxRWSZ1sbhEoNS/aWYfImv5cI0k3N92hFM3GNp94yAxUOKIofC1KVsp4BGvhZ5URcJcbMZI0usHutHb3GT/+wigVNZ9WAW5QZU9R8zkWhqHwk
X-Gm-Message-State: AOJu0YxNtV7oJ3oedF6AWODRyhmY4g48nSqT4UHnim2DlvOOHFAQzvEg
	1bEWOniH6+sV3i9f0LshUrZ9ONhMmGsWh1D3Gq2dbiogDnQbDkZUQz1HGgW+a+03+4nLWvxhbSz
	kU8FWvGXV8+U7zQauZEuTLpiQAY0=
X-Google-Smtp-Source: AGHT+IGN8j2tQMRiomVIg+aJ87djNKquNTsygm6hQ4uPogwFFowxAwoZ0ir7bNjDkiP+qIxjl10EgEjcSPDzmp44c7s=
X-Received: by 2002:a17:90b:33ca:b0:2cb:f9e:3bfb with SMTP id
 98e67ed59e1d1-2cff952bdf1mr8480587a91.32.1722813748906; Sun, 04 Aug 2024
 16:22:28 -0700 (PDT)
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
 <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com> <20240803085312.GP39708@noisy.programming.kicks-ass.net>
In-Reply-To: <20240803085312.GP39708@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 4 Aug 2024 16:22:16 -0700
Message-ID: <CAEf4BzYPpkhKtuaT-EbyKeB13-uBeYf8LjR9CB=xaXYHnwsyAQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, oleg@redhat.com, 
	jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko wrote:
>
> > Is there any reason why the approach below won't work?
>
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 8be9e34e786a..e21b68a39f13 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2251,6 +2251,52 @@ static struct uprobe
> > *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> >         struct uprobe *uprobe =3D NULL;
> >         struct vm_area_struct *vma;
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE, vm_=
flags;
> > +       struct file *vm_file;
> > +       struct inode *vm_inode;
> > +       unsigned long vm_pgoff, vm_start, vm_end;
> > +       int vm_lock_seq;
> > +       loff_t offset;
> > +
> > +       rcu_read_lock();
> > +
> > +       vma =3D vma_lookup(mm, bp_vaddr);
> > +       if (!vma)
> > +               goto retry_with_lock;
> > +
> > +       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
>
> So vma->vm_lock_seq is only updated on vma_start_write()

yep, I've looked a bit more at the implementation now

>
> > +
> > +       vm_file =3D READ_ONCE(vma->vm_file);
> > +       vm_flags =3D READ_ONCE(vma->vm_flags);
> > +       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXEC)
> > +               goto retry_with_lock;
> > +
> > +       vm_inode =3D READ_ONCE(vm_file->f_inode);
> > +       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
> > +       vm_start =3D READ_ONCE(vma->vm_start);
> > +       vm_end =3D READ_ONCE(vma->vm_end);
>
> None of those are written with WRITE_ONCE(), so this buys you nothing.
> Compiler could be updating them one byte at a time while you load some
> franken-update.
>
> Also, if you're in the middle of split_vma() you might not get a
> consistent set.

I used READ_ONCE() only to prevent the compiler from re-reading those
values. We assume those values are garbage anyways and double-check
everything, so lack of WRITE_ONCE doesn't matter. Same for
inconsistency if we are in the middle of split_vma().

We use the result of all this speculative calculation only if we find
a valid uprobe (which could be a false positive) *and* if we detect
that nothing about VMA changed (which is what I got wrong, but
honestly I was actually betting on others to help me get this right
anyways).

>
> > +       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
> > +               goto retry_with_lock;
> > +
> > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_st=
art);
> > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > +       if (!uprobe)
> > +               goto retry_with_lock;
> > +
> > +       /* now double check that nothing about VMA changed */
> > +       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
> > +               goto retry_with_lock;
>
> Since vma->vma_lock_seq is only ever updated at vma_start_write() you're
> checking you're in or after the same modification cycle.
>
> The point of sequence locks is to check you *IN* a modification cycle
> and retry if you are. You're now explicitly continuing if you're in a
> modification.
>
> You really need:
>
>    seq++;
>    wmb();
>
>    ... do modification
>
>    wmb();
>    seq++;
>
> vs
>
>   do {
>           s =3D READ_ONCE(seq) & ~1;
>           rmb();
>
>           ... read stuff
>
>   } while (rmb(), seq !=3D s);
>
>
> The thing to note is that seq will be odd while inside a modification
> and even outside, further if the pre and post seq are both even but not
> identical, you've crossed a modification and also need to retry.
>

Ok, I don't think I got everything you have written above, sorry. But
let me explain what I think I need to do and please correct what I
(still) got wrong.

a) before starting speculation,
  a.1) read and remember current->mm->mm_lock_seq (using
smp_load_acquire(), right?)
  a.2) read vma->vm_lock_seq (using smp_load_acquire() I presume)
  a.3) if vm_lock_seq is odd, we are already modifying VMA, so bail
out, try with proper mmap_lock
b) proceed with the inode pointer fetch and offset calculation as I've code=
d it
c) lookup uprobe by inode+offset, if failed -- bail out (if succeeded,
this could still be wrong)
d) re-read vma->vm_lock_seq, if it changed, we started modifying/have
already modified VMA, bail out
e) re-read mm->mm_lock_seq, if that changed -- presume VMA got
modified, bail out

At this point we should have a guarantee that nothing about mm
changed, nor that VMA started being modified during our speculative
calculation+uprobe lookup. So if we found a valid uprobe, it must be a
correct one that we need.

Is that enough? Any holes in the approach? And thanks for thoroughly
thinking about this, btw!

P.S. This is basically the last big blocker towards linear uprobes
scalability with the number of active CPUs. I have
uretprobe+SRCU+timeout implemented and it seems to work fine, will
post soon-ish.

P.P.S Also, funny enough, below was another big scalability limiter
(and the last one) :) I'm not sure if we can just drop it, or I should
use per-CPU counter, but with the below change and speculative VMA
lookup (however buggy, works ok for benchmarking), I finally get
linear scaling of uprobe triggering throughput with number of CPUs. We
are very close.

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f7443e996b1b..64c2bc316a08 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1508,7 +1508,7 @@ static int uprobe_dispatcher(struct
uprobe_consumer *con, struct pt_regs *regs)
        int ret =3D 0;

        tu =3D container_of(con, struct trace_uprobe, consumer);
-       tu->nhit++;
+       //tu->nhit++;

        udd.tu =3D tu;
        udd.bp_addr =3D instruction_pointer(regs);


> > +
> > +       /* happy case, we speculated successfully */
> > +       rcu_read_unlock();
> > +       return uprobe;
> > +
> > +retry_with_lock:
> > +       rcu_read_unlock();
> > +       uprobe =3D NULL;
> > +#endif
> > +
> >         mmap_read_lock(mm);
> >         vma =3D vma_lookup(mm, bp_vaddr);
> >         if (vma) {
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index cc760491f201..211a84ee92b4 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
> >                         NULL);
> >         files_cachep =3D kmem_cache_create("files_cache",
> >                         sizeof(struct files_struct), 0,
> > -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > + SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
> >                         NULL);
> >         fs_cachep =3D kmem_cache_create("fs_cache",
> >                         sizeof(struct fs_struct), 0,

