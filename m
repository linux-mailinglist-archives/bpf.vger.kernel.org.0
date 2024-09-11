Return-Path: <bpf+bounces-39666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D0975C7C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F22A284976
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51F1AB6D4;
	Wed, 11 Sep 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/SYNjoe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA60149003;
	Wed, 11 Sep 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090512; cv=none; b=Z2gVU84iQxN2vdrgINJj91Ks9o3RecXLiKyedVhYhncMEADry24VK1mYmACFfga0ONvWlQP5BNBpEhq81aVr+Ob+6IbYJuW+ZMABeZ3ilL4knLEnxxOoPE2INCOXX7FzCEvbrxEAgQ6jiJIu9dgASc8vumOJiS6Md+hCGn8nxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090512; c=relaxed/simple;
	bh=MydnGImg1onEloD9oWqIoE/nw9qPew4bJNLmTScXE4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uy9Q895lHbkgV6+Z50E+sN1R4O4ZKznCUBDIKAtAO/ru2LpSYpNnGccJ3oQKJ174PM+66yw6v+DeTQ3/GzJ8+439OAe7IACzTE6CA11Wy0P74k+Y9q3YurlAB5ojdvaGdbm3pzLoK+lLE5FQ2HIzXRTOQKClVKuZfvP8CqZ9hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/SYNjoe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso174224a91.3;
        Wed, 11 Sep 2024 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726090510; x=1726695310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+jEybtqgHr3PVAiuDdOVn7cuVbpZHXqKxPkgKvDJyU=;
        b=I/SYNjoeNG7/IZc7B6pSAvtRuh1BPZy47GWxOSvs4ZV/26GliJa8h9hsZ3g6XNbDrT
         hf+PlJbYaiXrIZ6V86bK6gXfG373IpocdmHzZ8H5nBMOwuKKj0a/yp3fiQA3xI25Rjdo
         ELH+YXFXQE1f3DndXDSedSj61YowKJV2pFnwTtwDL8+ER16As4hRBbh7Y3VmidqHM+PP
         56XKroPTDNKzbSF6q5CKLc2IGqGCbtTNZgluBBxPSH3XVUCM6r78a9Do63bycRNCSQkt
         wpzujLxzfUF5CYbal/I9ZUKtrcW1W97Ow/k68mP6vA00EmHO/3XM+2/hAUdaRI94Vpv0
         p5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726090510; x=1726695310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+jEybtqgHr3PVAiuDdOVn7cuVbpZHXqKxPkgKvDJyU=;
        b=heHGPIGNaYDPbHe/E7HSlN8uVKcZsESD3csIaNYw/abyKyOfemuP9aOXJAYYTk6auz
         BM0CtJGYhgcYAQMIt0p1Cn3sw9CD0KJaXh77N0XXrcdsUxynqIfp6w3kDBafpd6cm/Y3
         lDKnwQwR+8dPMxRWq4Y1I0G+SVQEWQkl9NLzlm0fRCMnwz7hKja0E9NpXXPy+pWe8fSN
         ECraOn1/JlJJaj9fTrafy/+E+irAJ+TkKX/4b0EMc6S/vhIfFUXKX1VWg5Kz3vMFwFie
         DTi8SH7v5sl5gY96//UsN7k1WDMh2Asb7P2lpXH0LXQ7bXsgVhZ9A4/Fp02OfWGDGdui
         jVtA==
X-Forwarded-Encrypted: i=1; AJvYcCUuamRxlGhEC6T6ThsQFcwpEFjWhS/JWoVL1UOyVL9QWiMO1bu/dqSvdXDKr4YfahPbFBOQNM9kFtJFQKxIeqrKQRFh@vger.kernel.org, AJvYcCVvfGqB1sUq0N6g3hTJG7uV+0j7cjJ8gzRLBI6ZUP674agONvegdPm7QV9hID8458j2rlg=@vger.kernel.org, AJvYcCXtJzYdoXbGX5LiA79UrykwRISpS+gJrCoORIPgrCKCjX+rSSj2Hs2/MDiYie8axclqCKvdtO4vEwpHvHHg@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpXWMTWMpVsrIr0Z0g2mWiXq88M+yLkanIP4bVNBP21Wb6zZp
	jV221u1JTlXkDGMnirmcoz88xCFMlUrN9rGoc8t/gSwID1GgLU2mpYkPLdfayXwsarWUOa+Pccn
	8WDIEBLbj86HWtQJLs0BKf0bAnD0=
X-Google-Smtp-Source: AGHT+IGpXC3R7Ca0taMUwh/MVl1yLymIr33cDWnZgZwGWtPi5Mtd23oK4XL2nH75+xxRhAVXb0qYJbp+sa10tNeg9ro=
X-Received: by 2002:a17:90b:17c5:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2db9ffbfbf2mr650796a91.11.1726090510597; Wed, 11 Sep 2024
 14:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
 <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com> <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
In-Reply-To: <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:34:58 -0700
Message-ID: <CAEf4BzbzDjKbSZz4U+L_F3V-abXY3stgen2UhpQ1Tvba5owFcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jann Horn <jannh@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Mon, Sep 9, 2024 at 5:35=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, i=
nt seq)
> > > +{
> > > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > > +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> > > +}
> >
> > A load-acquire can't provide "end of locked section" semantics - a
> > load-acquire is a one-way barrier, you can basically use it for
> > "acquire lock" semantics but not for "release lock" semantics, because
> > the CPU will prevent reordering the load with *later* loads but not
> > with *earlier* loads. So if you do:
> >
> > mmap_lock_speculation_start()
> > [locked reads go here]
> > mmap_lock_speculation_end()
> >
> > then the CPU is allowed to reorder your instructions like this:
> >
> > mmap_lock_speculation_start()
> > mmap_lock_speculation_end()
> > [locked reads go here]
> >
> > so the lock is broken.
>
> Hi Jann,
> Thanks for the review!
> Yeah, you are right, we do need an smp_rmb() before we compare
> mm->mm_lock_seq with the stored seq.
>
> Otherwise reads might get reordered this way:
>
> CPU1                        CPU2
> mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> reloaded_seq =3D mm->mm_lock_seq; // reordered read
>                                  mmap_write_lock() // inc_mm_lock_seq(mm)
>                                  vma->vm_file =3D ...;
>                                  mmap_write_unlock() // inc_mm_lock_seq(m=
m)
> <speculate>
> mmap_lock_speculation_end() // return (reloaded_seq =3D=3D seq)
>
> >
> > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write(&mm->mmap_lock);
> > > +       inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> >
> > Similarly, inc_mm_lock_seq(), which does a store-release, can only
> > provide "release lock" semantics, not "take lock" semantics, because
> > the CPU can reorder it with later stores; for example, this code:
> >
> > inc_mm_lock_seq()
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> >
> > can be reordered into this:
> >
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> > inc_mm_lock_seq()
> >
> > so the lock is broken.
>
> Ugh, yes. We do need smp_wmb() AFTER the inc_mm_lock_seq(). Whenever

Suren, can you share with me an updated patch for mm_lock_seq with the
right memory barriers? Do you think this might have a noticeable
impact on performance? What sort of benchmark do mm folks use to
quantify changes like that?

> we use inc_mm_lock_seq() for "take lock" semantics, it's preceded by a
> down_write(&mm->mmap_lock) with implied ACQUIRE ordering. So I thought
> we can use it but I realize now that this reordering is still
> possible:
> CPU1                        CPU2
>                                  mmap_write_lock()
>                                        down_write(&mm->mmap_lock);
>                                        vma->vm_file =3D ...;
>
> mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> <speculate>
> mmap_lock_speculation_end() // return (mm->mm_lock_seq =3D=3D seq)
>
>                                        inc_mm_lock_seq(mm);
>                                  mmap_write_unlock() // inc_mm_lock_seq(m=
m)
>
> Is that what you were describing?
> Thanks,
> Suren.
>
> >
> > For "taking a lock" with a memory store, or "dropping a lock" with a
> > memory load, you need heavier memory barriers, see
> > Documentation/memory-barriers.txt.

