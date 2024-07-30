Return-Path: <bpf+bounces-36077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0B941F59
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215E11C21668
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4A18A6AF;
	Tue, 30 Jul 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFXf+JPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF98187FF9
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363416; cv=none; b=ZJ45sY+0xKDavITnK9xRNJXiIQy0l8LRkOSZN/+vfguZB6QGvo5oKyAa4ZGf4xq9PQuZkrCK0vdp5om/N1ZQdFmejmkwmIy4w19nHpuQBVrWJ+F7v50eMkz/IXafEbc6x1juKE/1J4u0ujyNXvWb5gJbh7b/kUP7+13KsUV/hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363416; c=relaxed/simple;
	bh=Ul43gLbjNXWv7uRvKDtkvWpbdFBiooyNeOeGbLSZUjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgwUWS8/B4IFzIzrTTHWYmyr7ed9yPGHYFuHKsXn73UMB3HzubHhL2V+t1Vi1+ULw6kqJFN0D1pOMuTz4ZF9G+mXLRM3WoT9JLyQnVQPKozb8/lE6/p+bUlGxRO8/nrXIH+WvD+V4TXXWwypQzcWBs9nxFhMSGl1d4RY+MorgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFXf+JPq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65fe1239f12so27496427b3.0
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722363414; x=1722968214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paocBMwYt9SJaAdh3bFfHBQaAh4S+xZQ2Uh5KYKzhR8=;
        b=IFXf+JPqkKDXs9eJ7+Fxr9bxUpOORnU1NN/Uf+SQHStRhH6N18Vs6hZvqjzRxkqEg1
         7Qrw7gRIPPOmX6DTIe8+OkfyAEljGCjoFuOs9VtL4IIHwUggPvaxsZpWIjrAj3Ie7sQa
         U7lrQgwJhDBAh9TY/9xI3B/0WOxc7T45PPzDBYyJ0G5JUuOsZvKpNdyD+UWd3HNbWnrV
         /n7QZy9V1BReCANvGBFcfe8Vww8fsWTGi6AriHhMmHOkJY8zkH925zrVvPad42Pjts0e
         IZteP1lp7n6G8VeekMUAkn2/T1ebVOTC4Go9opMDwF23zhvJzP0NduAOCHj/mskr/+Yh
         j3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363414; x=1722968214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paocBMwYt9SJaAdh3bFfHBQaAh4S+xZQ2Uh5KYKzhR8=;
        b=BXvvM8JgaPELVsRNYDBsxTUCb2Pz8696othognzsx9QIj5iFjQ6pruAGNYH/NIOqas
         DPbFCnow5jsbcvWwDv9kK3olA2B7wpPAtT9ccw6LD5P767o8TfN8C8xDplraSyu1ZwM1
         /Drvl7OuzVUsVUGQBbRHvRaVEgaZUJQuHmTYjOS9hD9xWbOPJA6FoMfD8oBhRxzb1wjn
         a6JJ4plkiASkyOD2dpF/avvS1wTgCbDdgzds+X6/FIpYrRZpvlRztGLpSZMxh9wMdsfl
         9tWR292XQLQlwFJcO3AyFSYCh5KOsJ7DUOJZdMwz6XoEGFBash/KqqpNMJiSEmtPQt5v
         94YA==
X-Forwarded-Encrypted: i=1; AJvYcCXjAPAl0HgRAJ5s5wuShWVio0hCfTpEBoWhspwCfoRxK5LYlOYVHlekH+un5jstJD2CP7CbZd2WyIYSe9bmCIZi5r1Q
X-Gm-Message-State: AOJu0YzECMhMNE0AxNWMxoGIQNvwztoC7GEOq83U69euhp1iLNf0relE
	Ll/MsUP8Jl4bxsvNDIcz577vG+QMKIHejgFfb5z7fUWLkIr2AyQ14Ic22t7QUOibn9k+ZzIWPzU
	TakfmVfiQ0Ebi4mDMYIOzrqUT4rOwfscub9yE
X-Google-Smtp-Source: AGHT+IHFivZ3+xvePr2SKWqE39RES1Ldta9R2db5dN+dbK9pahJeQgXCGle0FrjZBceBG7nZrXuY7oqZgHnUXnjfzP4=
X-Received: by 2002:a0d:f4c7:0:b0:65f:cda7:b065 with SMTP id
 00721157ae682-67a04ffe8bcmr102099007b3.9.1722363414000; Tue, 30 Jul 2024
 11:16:54 -0700 (PDT)
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
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com> <20240730134605.GO33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730134605.GO33588@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 30 Jul 2024 11:16:40 -0700
Message-ID: <CAJuCfpFLig1R1dKN+LiicEe3=fJpFxdC233kZ1xh8kvYSYDHRg@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 22, 2024 at 12:09:21PM -0700, Suren Baghdasaryan wrote:
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
>
> Right, but you can do that without having it quite this insane.

I'm happy to take any suggestions that would improve the current mechanism.

>
> You can still make mm_lock_seq a proper seqcount, and still have
> vma_end_write() -- even if its an empty stub only used for validation.

It's doable but what will we be validating here? That the vma is indeed loc=
ked?

>
> That is, something like the below, which adds a light barrier, ensures
> that mm_lock_seq is a proper sequence count.
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..daa19d1a3022 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -104,6 +104,8 @@ static inline void mmap_write_lock(struct mm_struct *=
mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq+1);
> +       smp_wmb();
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }

Ok, I'll try the above change and check the benchmarks for any regressions.
Thanks for the suggestions, Peter!

>
>
> With the above addition we could write (although I think we still need
> the RCU_SLAB thing on files_cachep):
>
> static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> {
>         struct mm_struct *mm =3D current->mm;
>         struct uprobe *uprobe =3D NULL;
>         struct vm_area_struct *vma;
>         struct inode *inode;
>         loff_t offset;
>         int seq;
>
>         guard(rcu)();
>
>         seq =3D READ_ONCE(mm->mm_lock_seq);
>         smp_rmb();
>         do {
>                 vma =3D find_vma(mm, bp_vaddr);
>                 if (!vma)
>                         return NULL;
>
>                 if (!valid_vma(vma, false))
>                         return NULL;
>
>                 inode =3D file_inode(vma->vm_file);
>                 offset =3D vaddr_to_offset(vma, bp_vaddr);
>
>         } while (smp_rmb(), seq !=3D READ_ONCE(mm->mm_lock_seq));
>
>         return find_uprobe(inode, offset);
> }
>

