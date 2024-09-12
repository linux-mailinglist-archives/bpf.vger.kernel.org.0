Return-Path: <bpf+bounces-39774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0E97743C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FC1C241B8
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8C1C2435;
	Thu, 12 Sep 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhwt5M9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F9191F8F;
	Thu, 12 Sep 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179608; cv=none; b=rYvbKUygE+9uj0xzlG7wRNPb0NG2p8X3jaF+l++Wmxirb787t+CCekS5mN2Bf1EMIzdSqq+kOUtf+/HZKkxs1vLpUpUKSAY4DMvCdqJgkjQ6j1+UArqjB5tB7SFTyJwRkDE3vy5KX+kYQVuA71EKGm2+7uZ0t+SIFdTJ5p1H74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179608; c=relaxed/simple;
	bh=4KvjL9alLChNH5qfYu8L6u407dvTlrkvisLjpNv431s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk16ldnB1n8AazLQAl8I2PIC93ubnDIA8GN9uxANrlZ0AdZEJS5h1IWPnx3SABjstfd311w7AE+2yUfij/AEZYEWDPZZTWIAL8dH77hBNuCriRV1/4hK6uVkS17vaytEY+Zstw/AO9d3RkhqcfGx2YMgC6RlxMFuLPy7pu4Qiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhwt5M9y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so1250443a91.0;
        Thu, 12 Sep 2024 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726179606; x=1726784406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SagmcUfMRj7CswGgvyMGzL+KR4HzY8oA3rfSHnW0rGw=;
        b=Hhwt5M9yNOANdo7nn9RurtRbl2OpD6VluoGIyzHk3yATg5QaiaBCUPTugqyhF39Cay
         1dbRlNLSFwz1Fo6NlTQ8w9x7WQkqLKrcn2+ZxarBsy31Q5zGU0NcDOMlKT+gBcVh5OF+
         N8wR9uCeZp9NPBVIBYqq1hLqOJe5lfwfyRl9J07hk7m+LcJqo/CoGEVeHjVVnETklH2e
         q6cnkIAPDrhqz/ZFYUHjSLEy3BmWmQPxKYUeq9BH5gVnKrue9XdtxX20TqOKVIcH+WTP
         j0WFJXnEm2DTejT1LE/azMFax7vAqf+StEbzHQDZnSi6MWOuSES75qc/X0mywL3gZmYE
         SIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179606; x=1726784406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SagmcUfMRj7CswGgvyMGzL+KR4HzY8oA3rfSHnW0rGw=;
        b=itWZJyXYZvLCU/ArA6jBp6g58dPLlU6K4UY3FLhWfc3zsOxwEDNDmh81ciHimn7fCN
         n9Wki7U9HD1qPG98fLoCCxxYeCX4q57c0zAvKdYQ1AI86GLdD5kImNdiWK0tvF0+VQBH
         oohafbQysy0iHp82rd/U2FPFMxdVrMQO9PDdXwUB4vAZvk8xRx1QorBIR7hh30ld6QSw
         UeV9/cpuKIndV8pshtdxm2mH15EV+sBRt1BenYKUWSIYLYYMnsNAHYt97UXhACic6U1i
         8Ir9v/RKcD8IDFO8SJhuZMB/FOLqoV91HX/uXU3Q7QcgAHxmkcDvu7Bm8qjBsF07zv4A
         MEiw==
X-Forwarded-Encrypted: i=1; AJvYcCXw/K3R6nAnbx+YomupDcCLfZif6iYAkHIAzPEQZR0tUo5HhdWDtN5X+t/NuOEi9PDfmkM=@vger.kernel.org, AJvYcCXyqZsA/r3gpUUy0PpNDSbhfmJfaYobkij07Vd8AbCKU7F591PTWmbkyxmwdVOsePCVWHKnLJ9O1JLKOd/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9PbJPCFZ1iqG8Hulyr7xj3AFLg4R2Lqx2Txg1c4fF4HNPk/Hj
	3edKnyMD8EXxDrFv6B5Mnm6MXrCVK59kdY5ojSjvsIg6pRwT7RGvXeSxmR6nHqQwdEC/8RAmDa3
	0WWVMB581qsEeLaeBlhVGEGE6QBs=
X-Google-Smtp-Source: AGHT+IGfqDytp8ykySDhYO5cmlto0zg26xLHQ2nm/xbuMBqLsy5H3krZS+pfz6TUXijAno29TpeKY7wnK6r3A8gBe+4=
X-Received: by 2002:a17:90a:ab0b:b0:2d8:97b7:449f with SMTP id
 98e67ed59e1d1-2dba0065e20mr5259536a91.38.1726179606298; Thu, 12 Sep 2024
 15:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com> <CAJuCfpGgoSYmGSdcf+fZF1mUeNo-M=fzfk7G6ATs5-0TT+zkfQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGgoSYmGSdcf+fZF1mUeNo-M=fzfk7G6ATs5-0TT+zkfQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 15:19:54 -0700
Message-ID: <CAEf4BzZTaS3jeUvBiAdH8x6N71fkxJYT7ohPYPKqfSyJZ=NGog@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:04=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Sep 12, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Add helper functions to speculatively perform operations without
> > read-locking mmap_lock, expecting that mmap_lock will not be
> > write-locked and mm is not modified from under us.
>
> Here you go. I hope I got the ordering right this time around, but I
> would feel much better if Jann reviewed it before it's included in
> your next patchset :)

Thanks a lot! And yes, I'll give it a bit of time for reviews before
sending a new revision.

Did you by any chance get any new ideas for possible benchmarks
(beyond what I did with will-it-scale)?


> Thanks,
> Suren.
>
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> > Changes since v1 [1]:
> > - Made memory barriers in inc_mm_lock_seq and mmap_lock_speculation_end
> > more strict, per Jann Horn
> >
> > [1] https://lore.kernel.org/all/20240906051205.530219-2-andrii@kernel.o=
rg/
> >
> >  include/linux/mm_types.h  |  3 ++
> >  include/linux/mmap_lock.h | 74 ++++++++++++++++++++++++++++++++-------
> >  kernel/fork.c             |  3 --
> >  3 files changed, 65 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 6e3bdf8e38bc..5d8cdebd42bc 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -887,6 +887,9 @@ struct mm_struct {
> >                  * Roughly speaking, incrementing the sequence number i=
s
> >                  * equivalent to releasing locks on VMAs; reading the s=
equence
> >                  * number can be part of taking a read lock on a VMA.
> > +                * Incremented every time mmap_lock is write-locked/unl=
ocked.
> > +                * Initialized to 0, therefore odd values indicate mmap=
_lock
> > +                * is write-locked and even values that it's released.
> >                  *
> >                  * Can be modified under write mmap_lock using RELEASE
> >                  * semantics.
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index de9dc20b01ba..a281519d0c12 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -71,39 +71,86 @@ static inline void mmap_assert_write_locked(const s=
truct mm_struct *mm)
> >  }
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > +static inline void init_mm_lock_seq(struct mm_struct *mm)
> > +{
> > +       mm->mm_lock_seq =3D 0;
> > +}
> > +
> >  /*
> > - * Drop all currently-held per-VMA locks.
> > - * This is called from the mmap_lock implementation directly before re=
leasing
> > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > - * This should normally NOT be called manually from other places.
> > - * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > - * *all* VMA write locks, including ones from further up the stack.
> > + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE s=
emantics)
> > + * or write-unlocked (RELEASE semantics).
> >   */
> > -static inline void vma_end_write_all(struct mm_struct *mm)
> > +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
> >  {
> >         mmap_assert_write_locked(mm);
> >         /*
> >          * Nobody can concurrently modify mm->mm_lock_seq due to exclus=
ive
> >          * mmap_lock being held.
> > -        * We need RELEASE semantics here to ensure that preceding stor=
es into
> > -        * the VMA take effect before we unlock it with this store.
> > -        * Pairs with ACQUIRE semantics in vma_start_read().
> >          */
> > -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +
> > +       if (acquire) {
> > +               WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +               /*
> > +                * For ACQUIRE semantics we should ensure no following =
stores are
> > +                * reordered to appear before the mm->mm_lock_seq modif=
ication.
> > +                */
> > +               smp_wmb();
> > +       } else {
> > +               /*
> > +                * We need RELEASE semantics here to ensure that preced=
ing stores
> > +                * into the VMA take effect before we unlock it with th=
is store.
> > +                * Pairs with ACQUIRE semantics in vma_start_read().
> > +                */
> > +               smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1=
);
> > +       }
> > +}
> > +
> > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, i=
nt *seq)
> > +{
> > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > +       /* Allow speculation if mmap_lock is not write-locked */
> > +       return (*seq & 1) =3D=3D 0;
> > +}
> > +
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq)
> > +{
> > +       /* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
> > +       smp_rmb();
> > +       return seq =3D=3D READ_ONCE(mm->mm_lock_seq);
> >  }
> > +
> >  #else
> > -static inline void vma_end_write_all(struct mm_struct *mm) {}
> > +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> > +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)=
 {}
> > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, i=
nt *seq) { return false; }
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq) { return false; }
> >  #endif
> >
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +       inc_mm_lock_seq(mm, false);
> > +}
> > +
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >         init_rwsem(&mm->mmap_lock);
> > +       init_mm_lock_seq(mm);
> >  }
> >
> >  static inline void mmap_write_lock(struct mm_struct *mm)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write(&mm->mmap_lock);
> > +       inc_mm_lock_seq(mm, true);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -111,6 +158,7 @@ static inline void mmap_write_lock_nested(struct mm=
_struct *mm, int subclass)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write_nested(&mm->mmap_lock, subclass);
> > +       inc_mm_lock_seq(mm, true);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -120,6 +168,8 @@ static inline int mmap_write_lock_killable(struct m=
m_struct *mm)
> >
> >         __mmap_lock_trace_start_locking(mm, true);
> >         ret =3D down_write_killable(&mm->mmap_lock);
> > +       if (!ret)
> > +               inc_mm_lock_seq(mm, true);
> >         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> >         return ret;
> >  }
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 61070248a7d3..c86e87ed172b 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >         seqcount_init(&mm->write_protect_seq);
> >         mmap_init_lock(mm);
> >         INIT_LIST_HEAD(&mm->mmlist);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -       mm->mm_lock_seq =3D 0;
> > -#endif
> >         mm_pgtables_bytes_init(mm);
> >         mm->map_count =3D 0;
> >         mm->locked_vm =3D 0;
> >
> > base-commit: 015bdfcb183759674ba1bd732c3393014e35708b
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

