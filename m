Return-Path: <bpf+bounces-35783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECABE93DC7C
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F241F24CD0
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48F2BD05;
	Sat, 27 Jul 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k31olA2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EB2B9D4;
	Sat, 27 Jul 2024 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039636; cv=none; b=UJ5GljZDbMN9Pai4+z5ZdovbcU7m7izUOri2wU84b7AeRK4QJhyZb1F3HAv+nZgE5l/jrgRhrWdX7m/2U53SfmNZenqGlHEpyMG5wbK78LCCBDsSiHgiC7l5uGLz4LH4BzS7e+MVxTJOnaabYteOB3Gl2nT4VbRTztmDvG8U3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039636; c=relaxed/simple;
	bh=5BwdVeRXroaCch0299cZUCu929XRs81yMmwuZ8jLu6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6twdHljZv/Y0I8mYh1Til2lq7awQacs/OJsHPlLdCu5QvohaqZ9zZOjOhxEUMcLgcV9KbN6BSyG3pYFrZpkPxdi7+5DvNFRvL3nkqZ4et3dwSW7acr1daucGZOOPVx3F1ODfMFsepr1fhtb0ufQwB0rcpBenSVjLkzD4ueMGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k31olA2X; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso1165741a91.1;
        Fri, 26 Jul 2024 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722039635; x=1722644435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdZ/E67W28RaT0y7rLXbroqFFJnrFdEDfPZEL+ZYeOY=;
        b=k31olA2XvC22K2NiOTCnAX4uHrPBieW1eOGulK7qO+Ubf4xL9BhUQLYorn34+Q+cvy
         Bgz9OYI8pZXuOEBKfiF4kQGScDJBacg14Yh2YW+Lwq5VgGIq5uhrjxqQoT8wzixUzYUL
         MrZdIpTw+entKWwloP0jSLLO3LtgPkUh0UlmPxvlAvSWr8XmeasJ3zcS3vfLX4Y8vGWK
         fLMVBx6RFoqR4/WIkW0AAoJfIpU1Hs+MC8azgLkkRJDTpfOmhDxHs6QhxMBdWhqBgbWe
         WeyXmF9P5H4SgT0JS2BDVKBSUNG93pGQBBMIWAzydKNwj+4dDAJnVrGoYUZ5eY/7yKPI
         ZyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722039635; x=1722644435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdZ/E67W28RaT0y7rLXbroqFFJnrFdEDfPZEL+ZYeOY=;
        b=GzyOWWV+BiUOzQX4qbXKwvAkAn7KmoRupVZyGANJf88q0hL7Q9P+C7frRu5dwW2Iwz
         y0upph+cbhm3fwdHedzKCTSXSDyFrWkBStiuCOAMqSu8pIOco3idPPj41GUN+ApRZgMg
         K3pc5Pkrd2UzxxbVd30C0/j/QHQG8wjwtEZfbFuRs3fRjwMEgcmitILmOXun/DV/MJLC
         jPF+b0zl/F3AppejH3twUP6HFFqi/PAX1RqwbO+9CKugBlj8CDpS4JRNHiEW8CKMVce0
         F8kT7AREBpoL7dwFaif/p4FSd+JV8nPFVavpbjiku3bWhDzOA9hUr0pe7BeJ5ZATqq2a
         V2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXvBDXta4m335RgO9QAczP3+BgeBOtHz+Q4lINz7A4bd6W6dp85AHFbdpE/xWz+fXvXCG7dzTWCPTrqSynp5Lbh5kmtahy7xnBV/nx+xe6j4mzN0MZ1SkghZd2S1dt5apQA
X-Gm-Message-State: AOJu0YyN5SX459AgT8Dz60+bWH7M7AiMuiO9UhgT/8MsfK9A0EI0gzZP
	uT7caV5RqojXtLx390kA6SyTDBw899yhqltCi5ol0khmUeaje/GBXdJe9IAqax0uH0dBHQzd8Qn
	yNIjxbvO7pAJcOl4DL2wYSI10FTf7y0hM
X-Google-Smtp-Source: AGHT+IEJs9zgd9trjHhL+WYaGOsGxqbUC9T/Tq87PIhxOaBUNJQKzImcVGDcvS3KMq3Hg5mFR8an66sBJde6+JUcDiY=
X-Received: by 2002:a17:90a:e64f:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2cf7e20a113mr1304532a91.20.1722039634700; Fri, 26 Jul 2024
 17:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net> <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net> <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net> <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
In-Reply-To: <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:20:22 -0700
Message-ID: <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> >
> > > If it were an actual sequence count, I could make it work, but sadly,
> > > not. Also, vma_end_write() seems to be missing :-( If anything it cou=
ld
> > > be used to lockdep annotate the thing.
>
> Thanks Matthew for forwarding me this discussion!
>
> > >
> > > Mooo.. I need to stare more at this to see if perhaps it can be made =
to
> > > work, but so far, no joy :/
> >
> > See, this is what I want, except I can't close the race against VMA
> > modification because of that crazy locking scheme :/
>
> Happy to explain more about this crazy locking scheme. The catch is
> that we can write-lock a VMA only while holding mmap_lock for write
> and we unlock all write-locked VMAs together when we drop that
> mmap_lock:
>
> mmap_write_lock(mm);
> vma_start_write(vma1);
> vma_start_write(vma2);
> ...
> mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked vm=
as
>
> This is done because oftentimes we need to lock multiple VMAs when
> modifying the address space (vma merge/split) and unlocking them
> individually would be more expensive than unlocking them in bulk by
> incrementing mm->mm_lock_seq.
>
> >
> >
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
> >         return is_trap_insn(&opcode);
> >  }
> >
> > -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *=
is_swbp)
> > +#ifndef CONFIG_PER_VMA_LOCK
> > +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> > +{
> > +       return NULL;
> > +}
> > +#else
>
> IIUC your code below, you want to get vma->vm_file without locking the
> VMA. I think under RCU that would have been possible if vma->vm_file
> were RCU-safe, which it's not (we had discussions with Paul and
> Matthew about that in
> https://lore.kernel.org/all/CAJuCfpHW2=3DZu+CHXL+5fjWxGk=3DCVix=3DC66ra+D=
mXgn6r3+fsXg@mail.gmail.com/).
> Otherwise you could store the value of vma->vm_lock_seq before
> comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
> then compare your locally stored vm_lock_seq against vma->vm_lock_seq
> to see if VMA got locked for modification after we got the file. So,
> unless I miss some other race, I think the VMA locking sequence does
> not preclude you from implementing __find_active_uprobe() but
> accessing vma->vm_file would be unsafe without some kind of locking.

Hey Suren!

I've haven't yet dug properly into this, but from quick checking
around I think for the hot path (where this all matters), we really
only want to get vma's underlying inode. vm_file itself is just a
means to that end. If there is some clever way to do
vma->vm_file->f_inode under RCU and without mmap_read_lock, that would
be good enough, I think.

>
> > +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> >  {
> >         struct mm_struct *mm =3D current->mm;
> >         struct uprobe *uprobe =3D NULL;
> >         struct vm_area_struct *vma;
> > +       MA_STATE(mas, &mm->mm_mt, bp_vaddr, bp_vaddr);
> > +
> > +       guard(rcu)();
> > +
> > +again:
> > +       vma =3D mas_walk(&mas);
> > +       if (!vma)
> > +               return NULL;
> > +
> > +       /* vma_write_start() -- in progress */
> > +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm=
_lock_seq))
> > +               return NULL;
> > +
> > +       /*
> > +        * Completely broken, because of the crazy vma locking scheme y=
ou
> > +        * cannot avoid the per-vma rwlock and doing so means you're ra=
cy
> > +        * against modifications.
> > +        *
> > +        * A simple actual seqcount would'be been cheaper and more usef=
ull.
> > +        */
> > +
> > +       if (!valid_vma(vma, false))
> > +               return NULL;
> > +
> > +       struct inode =3D file_inode(vma->vm_file);
> > +       loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
> > +
> > +       // XXX: if (vma_seq_retry(...)) goto again;
> > +
> > +       return find_uprobe(inode, offset);
> > +}
> > +#endif
> > +
> > +static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *=
is_swbp)
> > +{
> > +       struct uprobe *uprobe =3D __find_active_uprobe(bp_vaddr)
> > +       struct mm_struct *mm =3D current->mm;
> > +       struct vm_area_struct *vma;
> > +
> > +       if (uprobe)
> > +               return uprobe;
> >
> >         mmap_read_lock(mm);
> >         vma =3D vma_lookup(mm, bp_vaddr);
> >

