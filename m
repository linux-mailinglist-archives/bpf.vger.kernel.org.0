Return-Path: <bpf+bounces-35791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D893DCEA
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C823D1C234E7
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869B1FC4;
	Sat, 27 Jul 2024 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf9mQaWK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA80186A
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043799; cv=none; b=nin/qu8UdYXT349emXOsZjTFZh7GEAn8svMTGAOn/g/2Gok6EWobAR7kdFsu+DseERUMpRgWUDmT72GjEacV4MUMuwixFfXi6VLbfvijrs1sR0C/bD4qwMwZ60PK3rjIQx115laNDqPUepN/ZBjlCE7SNihxyeuBa6NPomu8iYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043799; c=relaxed/simple;
	bh=UpwuPU8c9lK5x8UD286ZSwMnfMk53bycoWXsc4D/CpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOrBXM/MydF8tqNzVXpWzE4qAKfLqLq0fJ99CnNJDdAc9f2A1nWalkMwZ7FRiygEhUa8cy8dRCjaQudBOl5aGUFPiwLDe4xc42d643tc1UcTH6yo+ZkS9pBEulfEHzP+6XOuxx/+9dLHhw+KRr30Q+hQ50jOCUz+K3EefPPWC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf9mQaWK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e087641d2a2so281551276.0
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722043797; x=1722648597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/sYrfdPVrARX3LTUviHaKtIlfAgSWZteSzTHDeE5NQ=;
        b=bf9mQaWK/p2e+71rgaZD7XNAY6QcBYtImI/IB1mMTX/Oa1cxv/1uBM5TP/+U+kzTkz
         93/FxhC+FR6ogPv05gpu7H8JPrPJOhOl5LKsge0fbR9OjDEu6la0lfCmhDzVDPbMnhnJ
         0oIIiVuekTygIXOT/inUzitNRJ2/3N58jk1LTnIlBYmo+WX68hWmYnn9KO1olcschD8q
         4sXCPb0HofeyuPFJidlawrynku1LjeLLU2jSNbMYOFS6tnJrVlyM/Dnb4A6540AOJytv
         StJOmFkJ1RqEK2rI+c/gJolCpv8/IAm0j3ByR40MLmY8MD4Wklz9WQqQzUhrstAwg11K
         SkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722043797; x=1722648597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/sYrfdPVrARX3LTUviHaKtIlfAgSWZteSzTHDeE5NQ=;
        b=NKOAagm1iV6R/d0AjSG7D8wf7J5udXN1O0RHrHlIpXgu1322IfuI94BAXVMEc/AQYz
         4RjhDNloXWdpPfijLPQUythcl58LpcOAG/XgI2NpE/+eWYQ9T8Wuc66uRMxzo+nJC6xh
         l6lWiYiv1xiACCie1zIDkn1pf+z4pPOddyRyLYV6FS21opHHLOXwZ9ATX8W0DXbi1aMw
         QRXTozD0x5p4832uTS1lpHISqAs/8uRjt/4R5nGqfW9R48+4ZjkTRkranMOrP8XHFan3
         I8lXOKeIxCkzoqOR0ivSa6xsnwFcxM3S4db/vWtdXMp9qkG7nauEAc0cBwIFzSwd4ZLN
         RRdg==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ3bTNkdYDoc2jviYs7ma7k6HRtPJeGkYJWLGozR/VuHBspqNiPDfpyRQkoCpCkmR5gj8N8WL+6DOnf+UzU2pZQGD
X-Gm-Message-State: AOJu0YwJUKBEZpgfzWPRRO/SzfT1wtJrDJqXE9f372JD4lXHfDt66pCF
	bFkviS+Dkq3mS/tFkRTdqYTD67kWbD5Ieqg8xYChWCOyi2Nc2QWeT4KlmVPyv9C1ysN64AnTDo1
	7XipLI7IgfWrnrbcyq8jQmOKqg6LIYXokbmPX
X-Google-Smtp-Source: AGHT+IFFts+nSRcVL/p5CRPU8cfU3HbHd2JziR7v3syMog2CGzBHNSdu2JJebFaCHFt6FioCNtmroAviPTaymyo/JLE=
X-Received: by 2002:a81:8415:0:b0:64a:9fc7:3b15 with SMTP id
 00721157ae682-67a07d62ff1mr16240647b3.26.1722043796876; Fri, 26 Jul 2024
 18:29:56 -0700 (PDT)
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
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com> <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Jul 2024 18:29:44 -0700
Message-ID: <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 22, 2024 at 12:09=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> > >
> > > > If it were an actual sequence count, I could make it work, but sadl=
y,
> > > > not. Also, vma_end_write() seems to be missing :-( If anything it c=
ould
> > > > be used to lockdep annotate the thing.
> >
> > Thanks Matthew for forwarding me this discussion!
> >
> > > >
> > > > Mooo.. I need to stare more at this to see if perhaps it can be mad=
e to
> > > > work, but so far, no joy :/
> > >
> > > See, this is what I want, except I can't close the race against VMA
> > > modification because of that crazy locking scheme :/
> >
> > Happy to explain more about this crazy locking scheme. The catch is
> > that we can write-lock a VMA only while holding mmap_lock for write
> > and we unlock all write-locked VMAs together when we drop that
> > mmap_lock:
> >
> > mmap_write_lock(mm);
> > vma_start_write(vma1);
> > vma_start_write(vma2);
> > ...
> > mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked =
vmas
> >
> > This is done because oftentimes we need to lock multiple VMAs when
> > modifying the address space (vma merge/split) and unlocking them
> > individually would be more expensive than unlocking them in bulk by
> > incrementing mm->mm_lock_seq.
> >
> > >
> > >
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
> > >         return is_trap_insn(&opcode);
> > >  }
> > >
> > > -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int=
 *is_swbp)
> > > +#ifndef CONFIG_PER_VMA_LOCK
> > > +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> > > +{
> > > +       return NULL;
> > > +}
> > > +#else
> >
> > IIUC your code below, you want to get vma->vm_file without locking the
> > VMA. I think under RCU that would have been possible if vma->vm_file
> > were RCU-safe, which it's not (we had discussions with Paul and
> > Matthew about that in
> > https://lore.kernel.org/all/CAJuCfpHW2=3DZu+CHXL+5fjWxGk=3DCVix=3DC66ra=
+DmXgn6r3+fsXg@mail.gmail.com/).
> > Otherwise you could store the value of vma->vm_lock_seq before
> > comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
> > then compare your locally stored vm_lock_seq against vma->vm_lock_seq
> > to see if VMA got locked for modification after we got the file. So,
> > unless I miss some other race, I think the VMA locking sequence does
> > not preclude you from implementing __find_active_uprobe() but
> > accessing vma->vm_file would be unsafe without some kind of locking.
>
> Hey Suren!
>
> I've haven't yet dug properly into this, but from quick checking
> around I think for the hot path (where this all matters), we really
> only want to get vma's underlying inode. vm_file itself is just a
> means to that end. If there is some clever way to do
> vma->vm_file->f_inode under RCU and without mmap_read_lock, that would
> be good enough, I think.

Hi Andrii,
Sorry, I'm not aware of any other way to get the inode from vma. Maybe
Matthew with his FS background can find a way?

>
> >
> > > +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> > >  {
> > >         struct mm_struct *mm =3D current->mm;
> > >         struct uprobe *uprobe =3D NULL;
> > >         struct vm_area_struct *vma;
> > > +       MA_STATE(mas, &mm->mm_mt, bp_vaddr, bp_vaddr);
> > > +
> > > +       guard(rcu)();
> > > +
> > > +again:
> > > +       vma =3D mas_walk(&mas);
> > > +       if (!vma)
> > > +               return NULL;
> > > +
> > > +       /* vma_write_start() -- in progress */
> > > +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->=
mm_lock_seq))
> > > +               return NULL;
> > > +
> > > +       /*
> > > +        * Completely broken, because of the crazy vma locking scheme=
 you
> > > +        * cannot avoid the per-vma rwlock and doing so means you're =
racy
> > > +        * against modifications.
> > > +        *
> > > +        * A simple actual seqcount would'be been cheaper and more us=
efull.
> > > +        */
> > > +
> > > +       if (!valid_vma(vma, false))
> > > +               return NULL;
> > > +
> > > +       struct inode =3D file_inode(vma->vm_file);
> > > +       loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
> > > +
> > > +       // XXX: if (vma_seq_retry(...)) goto again;
> > > +
> > > +       return find_uprobe(inode, offset);
> > > +}
> > > +#endif
> > > +
> > > +static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int=
 *is_swbp)
> > > +{
> > > +       struct uprobe *uprobe =3D __find_active_uprobe(bp_vaddr)
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       if (uprobe)
> > > +               return uprobe;
> > >
> > >         mmap_read_lock(mm);
> > >         vma =3D vma_lookup(mm, bp_vaddr);
> > >

