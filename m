Return-Path: <bpf+bounces-35989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BCE9405B4
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBF3B21966
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1682613B780;
	Tue, 30 Jul 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieVUkNxV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10D1854;
	Tue, 30 Jul 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309514; cv=none; b=VU4PtFAZX9YwBRJl1/NhO9/SqNbdr14AlxsD9AQLSpwdYMti/HjVwwpnbeEfYh9nwmpp7C7Ex687K0zZBeG1WjBYv+TH+byjT2cuBFJ5QC0kCxIE5AzEUcHdSVmJOvc2mYGkPFeBijf73qwq3yGehxhKpEFpgKZu1EBAddDbWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309514; c=relaxed/simple;
	bh=V5viyVGeEzFEYSukra6rxwhQW93nJp1xu5scNqwoPHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgPcApLWXvrjUYvLdDekGTYdP3y3Fv49D8N1I0/n2Jd3qdEzEjS48PFP9JAkZAnG9f9LQR/u3+gj44/rOtwQqLMxCXNR+L8r3x65s4SFRa25srxCswfbTcSkmfv91VZJ3IrjD+Q/X4kCRmjwhgsFxPa+7bRglA1mrJDMwpt7Xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieVUkNxV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a0c6ab3354so2559742a12.0;
        Mon, 29 Jul 2024 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722309512; x=1722914312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8yaQqBLHf/m9UbFCAcqwLLHilWw74Ua5tsplnejJs8=;
        b=ieVUkNxV51iEiMSVZRK/GrmILhdA81C/1ZEP80cXU2TXBOYKnc0z1mnPWzcXOwVk8M
         gM0Wuauq+h6FACCGLrZYOol2uopXStuFB2Z8K3SUCt6ksRVXbdqSIrD1lYE1SC1y2+Hh
         GF7Z6hVAbT7/W22WAPZnL8g0Kt0N9OIb083L/BDyefFiwTt2uN8jjG0EfTiiyu978+Nv
         b8yrtQe1Z1vL67Rnj7blXWbi8aDO37nq8cK1KCOOl48wH8jjvavfgaUYLuQqzF0CiZd/
         Lt+KL0dh7eEvnPMwVPgvFiFdBEM/yn6Gm9oxOU/DT+MOSP/xeWEy422vy8ow9t82o/hH
         Zw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722309512; x=1722914312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8yaQqBLHf/m9UbFCAcqwLLHilWw74Ua5tsplnejJs8=;
        b=gdLZUUy68wk+mqOV4BcRYzSVbu82RP/L81T1GX5Oxg6lwRo1NL67CbwWxlLnFL5Ul9
         oPZ+tieBtgnIaxgs93+tvMY0XZF05FuANCIExTg0NUHjJmjd7Rh3WCfuhsBOf5IsKrCY
         BDQlDXzfY1mO9CQoZ4gQ+l17T+LDu9UgPV1WvHiWq15GwoCSfk/G1QZkoAaa69Yl2Mt8
         P2tJqrTqfYoPPDrcYiBjtrTeJxjeMQWOC/a8OL0puG5i1ziApwJkGZcNC2xQGggjFGWm
         UcJxRlKo8ysOlDu75Q7rC35OFKk41Y5saIhJZk/2/G3bId9CQM+gbsW61W4v1uUXNq+Z
         arXw==
X-Forwarded-Encrypted: i=1; AJvYcCXbXU4fWNUUboRZHNnwhkQ9gVWfQvVlN58Z/tIJ7DeLhfMFZ+wLt54wTrox6BKt6mZCYP6bIv8xcruL1rT8aOv1yrfG6lIrdg2+v9KUW6Vwl5pKdeu5TNz8TwpxezVoZY/t
X-Gm-Message-State: AOJu0YzueBuwJ4JfmVI64d6oMSg9ASNvyjYjcc80gdkxTF2Llm4WUWXx
	yI2NUX0ABFNzRcf12vCDr4Fe7950EcX+Z+C0sYfqc8oHgequMCBuz8wdIiAqzulF1mki9L0WMrv
	qV8VJHhcOe71LXV31GfGCGQ443Zs=
X-Google-Smtp-Source: AGHT+IEK9xQkGi/zPPOc7nhDQ5S7YJLLOQJf+PeZP8tggGX/zME0pEED/4HKZEu0N0DEMO2+dQCoV6i/vonoPJ3kGeU=
X-Received: by 2002:a05:6a20:77aa:b0:1c4:6bb9:b7ac with SMTP id
 adf61e73a8af0-1c4a14ef61dmr6558949637.48.1722309512315; Mon, 29 Jul 2024
 20:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net> <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net> <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net> <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com> <ZqRtcZHWFfUf6dfi@casper.infradead.org>
In-Reply-To: <ZqRtcZHWFfUf6dfi@casper.infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 20:18:20 -0700
Message-ID: <CAEf4BzY2XVcd1CmSwPkBzqc_UhdDBvvqrB3pdmoWdtH+X9Aq2w@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:45=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jul 26, 2024 at 06:29:44PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Jul 26, 2024 at 5:20=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jul 22, 2024 at 12:09=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > >
> > > > On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> > > > >
> > > > > > If it were an actual sequence count, I could make it work, but =
sadly,
> > > > > > not. Also, vma_end_write() seems to be missing :-( If anything =
it could
> > > > > > be used to lockdep annotate the thing.
> > > >
> > > > Thanks Matthew for forwarding me this discussion!
> > > >
> > > > > >
> > > > > > Mooo.. I need to stare more at this to see if perhaps it can be=
 made to
> > > > > > work, but so far, no joy :/
> > > > >
> > > > > See, this is what I want, except I can't close the race against V=
MA
> > > > > modification because of that crazy locking scheme :/
> > > >
> > > > Happy to explain more about this crazy locking scheme. The catch is
> > > > that we can write-lock a VMA only while holding mmap_lock for write
> > > > and we unlock all write-locked VMAs together when we drop that
> > > > mmap_lock:
> > > >
> > > > mmap_write_lock(mm);
> > > > vma_start_write(vma1);
> > > > vma_start_write(vma2);
> > > > ...
> > > > mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all loc=
ked vmas
> > > >
> > > > This is done because oftentimes we need to lock multiple VMAs when
> > > > modifying the address space (vma merge/split) and unlocking them
> > > > individually would be more expensive than unlocking them in bulk by
> > > > incrementing mm->mm_lock_seq.
> > > >
> > > > >
> > > > >
> > > > > --- a/kernel/events/uprobes.c
> > > > > +++ b/kernel/events/uprobes.c
> > > > > @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
> > > > >         return is_trap_insn(&opcode);
> > > > >  }
> > > > >
> > > > > -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr,=
 int *is_swbp)
> > > > > +#ifndef CONFIG_PER_VMA_LOCK
> > > > > +static struct uprobe *__find_active_uprobe(unsigned long bp_vadd=
r)
> > > > > +{
> > > > > +       return NULL;
> > > > > +}
> > > > > +#else
> > > >
> > > > IIUC your code below, you want to get vma->vm_file without locking =
the
> > > > VMA. I think under RCU that would have been possible if vma->vm_fil=
e
> > > > were RCU-safe, which it's not (we had discussions with Paul and
> > > > Matthew about that in
> > > > https://lore.kernel.org/all/CAJuCfpHW2=3DZu+CHXL+5fjWxGk=3DCVix=3DC=
66ra+DmXgn6r3+fsXg@mail.gmail.com/).
> > > > Otherwise you could store the value of vma->vm_lock_seq before
> > > > comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
> > > > then compare your locally stored vm_lock_seq against vma->vm_lock_s=
eq
> > > > to see if VMA got locked for modification after we got the file. So=
,
> > > > unless I miss some other race, I think the VMA locking sequence doe=
s
> > > > not preclude you from implementing __find_active_uprobe() but
> > > > accessing vma->vm_file would be unsafe without some kind of locking=
.
> > >
> > > Hey Suren!
> > >
> > > I've haven't yet dug properly into this, but from quick checking
> > > around I think for the hot path (where this all matters), we really
> > > only want to get vma's underlying inode. vm_file itself is just a
> > > means to that end. If there is some clever way to do
> > > vma->vm_file->f_inode under RCU and without mmap_read_lock, that woul=
d
> > > be good enough, I think.
> >
> > Hi Andrii,
> > Sorry, I'm not aware of any other way to get the inode from vma. Maybe
> > Matthew with his FS background can find a way?
>
> Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That way
> we could do:
>
>         inode =3D NULL;
>         rcu_read_lock();
>         vma =3D find_vma(mm, address);
>         if (!vma)
>                 goto unlock;
>         file =3D READ_ONCE(vma->vm_file);
>         if (!file)
>                 goto unlock;
>         inode =3D file->f_inode;
>         if (file !=3D READ_ONCE(vma->vm_file))
>                 inode =3D NULL;
> unlock:
>         rcu_read_unlock();
>
>         if (inode)
>                 return inode;
>         mmap_read_lock();
>         vma =3D find_vma(mm, address);
>         ...
>
> I think this would be safe because 'vma' will not be reused while we
> hold the read lock, and while 'file' might be reused, whatever f_inode
> points to won't be used if vm_file is no longer what it once was.
>
> On the other hand, it's quarter to midnight on Friday, and I have a
> terrible virus that I'm struggling through, so not ideal circumstances
> for me to be reasoning about RCU guarantees.

Hi Matthew,

Hopefully you got some rest over the weekend and are feeling better!

What you proposed above with SLAB_TYPESAFE_BY_RCU (assuming it is safe
and correct) I think would solve the uprobe scalability problem when
it comes to mmap_lock. So did you get a chance to think this through
some more? And if that still seems correct, how should we go about
making this happen?

