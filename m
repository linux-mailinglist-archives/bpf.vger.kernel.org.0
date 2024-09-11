Return-Path: <bpf+bounces-39667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34F975CA5
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5021F2484A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B258157A5C;
	Wed, 11 Sep 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAK1w13j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69A145B14
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091321; cv=none; b=WLUUtPSlV/UqTNvkxawcEb3834Bj8ncOElOrg6nA/LgzQsDEVsgRTHRY3EMqi7USvYgHYtByrrP3LvY1vaxWA2Bm+CZ8AEM4wsq20X/241fn+m7DBMaI/Cy5Zl0otECl1xFdJqmArviYRBTkZdOrRSrpcWKMB6wi8PtYTG39UzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091321; c=relaxed/simple;
	bh=pc+DaIT8Z2TuZhceXNepea8cZHlBoTaFWH+DRQwBbbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPyMvMms5ROZzwc5XbPrluEi8WYFClg3gPAy2N/WMAfiZDRpGUb7Q0goal0Ee96TDR7RI2VUNWnDRX7l7mM5f9acrBzwjadQIIPbPAQmn4fXXFVGEiHOKPeH2y24k5lMBo3Xyz9AFgUc3NUEa6xnDGaHND/GUo6/itvFDX35PW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAK1w13j; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso27595ab.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726091318; x=1726696118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Z8HdUc1+IRM76erXzE6hZcoAD0AgTlijcNod5P+zA=;
        b=xAK1w13j5Q/zzXYU02JpZNv8jmpuCeOJSgGWOpIPBF+4hJN4yKgZEgaZlFBdfojJJe
         nZujD9IAhYZ63u83V11kv0fUA5gdnqxCzKEz57oTgnWtbib91zHKJE8gIkwYcZ4P5uDf
         Pxqxcfnun32Oi5kHp+o/gDsHo0IsQ2SE2B/BPXJXfbkd/8GBZXcGZYO3b63HSiBOIkbD
         qugSQk7R6uHDx0baKpS0agzkBhzLV1LJvwnqclwrG/7VKCEt5Nl72eEjAy8jPqEPDoMf
         z1h+laXyVUy3Bh9M8xYoLsGzXysPC4dgLY1smx/H7MGwwGDYJcueU/miD7MZGUZArLLi
         nMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726091318; x=1726696118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Z8HdUc1+IRM76erXzE6hZcoAD0AgTlijcNod5P+zA=;
        b=F+TuGz9nxrECnRcaIvKejwWmoQ31ocduElDM6BgwbuuZddlFj8MWxceY/lfva7p/j5
         B1UXwl6dMoOwmTh/YHYRjnd6IPmarGT+5lMwsFJT3nhNbL4YW26FAORORykR9UrE0DWu
         UklP0Rr8nC9UETGob9PrkEnQ/PF9JlDYhLo4u4yoqmOLi/wQoSkjmAzUpV+kPL0W0hrC
         p6GCD0YaoBsCaN76O8Pdj8umMHyFv842fx7oQENPHJV3siMAEhnTzvwX2lfhdrNQLbAP
         oFZwPL+09yus1iVcouM3kv0/mP6mMaw1MZBI310pU/uYLIA2fccrjmHD/FbLx0JuUAzk
         nHug==
X-Forwarded-Encrypted: i=1; AJvYcCXH94QMp60aa5Kw0/MwrXgk8T2yvuFeud7MmpiT4TOZPYHmL2dkUD97UXqk7lfBfdy+p40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaB4S3p7ots2jbw0T80m+dXPvK3TP9RTqXLAMiMXrLbBb8G2FN
	ZOj5mZQpT7np0AXwhaxZ2tAqw6Bu7n7GijnmD97FuoOy+KGurXu7EtTpLyHaYOHN8uODBK1nBOl
	YoBDR9S/CkVAtuAvpO2Ups1Wd9FV7hh/7N824
X-Google-Smtp-Source: AGHT+IFmg4D1lfVet1nvJD1JAF6kEa9fIBsQooXq/7H7e2YTkj6xbHkrW2QYeQkv9L0W5OsOaKT7H6dmK3UPQKAEs3o=
X-Received: by 2002:a05:6e02:1809:b0:398:fc12:d70f with SMTP id
 e9e14a558f8ab-3a08464d5f7mr1398105ab.0.1726091318258; Wed, 11 Sep 2024
 14:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
 <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com>
 <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com> <CAEf4BzbzDjKbSZz4U+L_F3V-abXY3stgen2UhpQ1Tvba5owFcw@mail.gmail.com>
In-Reply-To: <CAEf4BzbzDjKbSZz4U+L_F3V-abXY3stgen2UhpQ1Tvba5owFcw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Sep 2024 14:48:24 -0700
Message-ID: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jann Horn <jannh@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Mon, Sep 9, 2024 at 5:35=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm,=
 int seq)
> > > > +{
> > > > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > > > +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> > > > +}
> > >
> > > A load-acquire can't provide "end of locked section" semantics - a
> > > load-acquire is a one-way barrier, you can basically use it for
> > > "acquire lock" semantics but not for "release lock" semantics, becaus=
e
> > > the CPU will prevent reordering the load with *later* loads but not
> > > with *earlier* loads. So if you do:
> > >
> > > mmap_lock_speculation_start()
> > > [locked reads go here]
> > > mmap_lock_speculation_end()
> > >
> > > then the CPU is allowed to reorder your instructions like this:
> > >
> > > mmap_lock_speculation_start()
> > > mmap_lock_speculation_end()
> > > [locked reads go here]
> > >
> > > so the lock is broken.
> >
> > Hi Jann,
> > Thanks for the review!
> > Yeah, you are right, we do need an smp_rmb() before we compare
> > mm->mm_lock_seq with the stored seq.
> >
> > Otherwise reads might get reordered this way:
> >
> > CPU1                        CPU2
> > mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> > reloaded_seq =3D mm->mm_lock_seq; // reordered read
> >                                  mmap_write_lock() // inc_mm_lock_seq(m=
m)
> >                                  vma->vm_file =3D ...;
> >                                  mmap_write_unlock() // inc_mm_lock_seq=
(mm)
> > <speculate>
> > mmap_lock_speculation_end() // return (reloaded_seq =3D=3D seq)
> >
> > >
> > > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > > >  {
> > > >         __mmap_lock_trace_start_locking(mm, true);
> > > >         down_write(&mm->mmap_lock);
> > > > +       inc_mm_lock_seq(mm);
> > > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > > >  }
> > >
> > > Similarly, inc_mm_lock_seq(), which does a store-release, can only
> > > provide "release lock" semantics, not "take lock" semantics, because
> > > the CPU can reorder it with later stores; for example, this code:
> > >
> > > inc_mm_lock_seq()
> > > [locked stuff goes here]
> > > inc_mm_lock_seq()
> > >
> > > can be reordered into this:
> > >
> > > [locked stuff goes here]
> > > inc_mm_lock_seq()
> > > inc_mm_lock_seq()
> > >
> > > so the lock is broken.
> >
> > Ugh, yes. We do need smp_wmb() AFTER the inc_mm_lock_seq(). Whenever
>
> Suren, can you share with me an updated patch for mm_lock_seq with the
> right memory barriers? Do you think this might have a noticeable
> impact on performance? What sort of benchmark do mm folks use to
> quantify changes like that?

Yes, I think I can get it to you before leaving for LPC.
It might end up affecting paths where we take mmap_lock for write
(mmap/munmap/mprotect/etc) but these are not considered fast paths.
I'll think about possible tests we can run to evaluate it.

>
> > we use inc_mm_lock_seq() for "take lock" semantics, it's preceded by a
> > down_write(&mm->mmap_lock) with implied ACQUIRE ordering. So I thought
> > we can use it but I realize now that this reordering is still
> > possible:
> > CPU1                        CPU2
> >                                  mmap_write_lock()
> >                                        down_write(&mm->mmap_lock);
> >                                        vma->vm_file =3D ...;
> >
> > mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> > <speculate>
> > mmap_lock_speculation_end() // return (mm->mm_lock_seq =3D=3D seq)
> >
> >                                        inc_mm_lock_seq(mm);
> >                                  mmap_write_unlock() // inc_mm_lock_seq=
(mm)
> >
> > Is that what you were describing?
> > Thanks,
> > Suren.
> >
> > >
> > > For "taking a lock" with a memory store, or "dropping a lock" with a
> > > memory load, you need heavier memory barriers, see
> > > Documentation/memory-barriers.txt.

