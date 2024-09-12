Return-Path: <bpf+bounces-39777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C735997748D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898EB2862AE
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3751C2DBD;
	Thu, 12 Sep 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vZ0J/JH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDD1C0DEB
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181601; cv=none; b=NZysQt/ngFaxVwAP+kscp8JhBa8DdthRNC43RJBFAoR6GZ+FuW3N8s0sESCjABewArQxC1MGG5R52/wH+GBmPwm1U1ri6L4KsLsPvvjEvdkzTqcUt4ek9Z/CNfU+vRDO3VeHewh/rJf0qm+K9Zdh0gnwVkdChtbeIruy9CfeWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181601; c=relaxed/simple;
	bh=Rbbh6gPcXkQa0/EdPAvuvlCLT6ueJOwJIlQlPvjSpy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0ybI5kkqc1IRnxJJYXe1DQkTRFQB0/iHiIXkKU7o/crkK0aH5dFQpjXf0Pj3Cxd/BVv5PRr5FAWJWJ4rHjm5449q2SK2DkkSuP5LUaq8S4Y7yqUQQh+0g9Z1gShkh+3Z2U3DaRy6naMD5keZt1YyWpx0c2rjjrsXOk3KpGJv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vZ0J/JH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24374d8b6so5850a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726181598; x=1726786398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCNOG1CDmyqExdlHYX65JYGn2614r9IBeuPVpY+h7D0=;
        b=3vZ0J/JHwoxMyk2YsXl0AMVlc2Ypj15CiuKBPCs3TNK4llPO5ZGy7k6T+l2B+lSpEQ
         ki5zbFSuxtvZuc5s86HsazVSHtFIkKwTPcSqZBgaSobR2wjVXL4KpagzcpyfnY5aN/it
         VBYzSEzc1CCrZJe1G5pFBQ8gDI1fAnPARcdKYdgaJ8/C7LQVQVbHxKPXBjV7HgjC8R9t
         RG2/IynG+yNLVI3RQgpP1TyBKfsyKecYVIQ0BT+/1vgo+4GR72RiY+6aRia21JLvFCc/
         A+OjHBDT1hudxM+1mXtGcRts1W98Kf3atCy4vrPQdyLbgTDmNy+bFIBBiIRv4dWMvFb4
         0e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181598; x=1726786398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCNOG1CDmyqExdlHYX65JYGn2614r9IBeuPVpY+h7D0=;
        b=IN0am3EUXjOQGekLX2HuGV4bM2mCc/N98TZDIpmLDpAcLMf11TbVebeEMH0oKGp/yW
         MMY8ClZE3EZ0FWnnB+NY55oRzK20/au5QILq4Qv5mNySRmd/aA9VDytR7byInhynCdYx
         awWfg69rKjTRpeq6OQAZdV3G2n80Yq53W1pgev6kvUzI2F6WoctF4xBr/fAR0aDVjpWo
         jXGK5iPN2AkdNTsCPKsmTzfgrZmOJ0olueoIOzotA/QjfMpC8H3pLoxlEguoa2uKsx9e
         mfrN5aeT5prPaIn2gg1Cf0Ad2cBkOnU4WeEew67anoNwDGaGsgMUuz3xbnstiF5WZns4
         mE5w==
X-Forwarded-Encrypted: i=1; AJvYcCUTA4po/Ml6xtEobR+ta5dD0OfNbf14R5H7fBMGKHJrQusI1KFrQkafEHI1yDmYB/oUmOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIK3BLLD/d1oFMj/QJKV77QF+D/KR9rrMmHUeclTO7xM8NAsWC
	nznKYtAllepBDZxK5YiE8YW2Tsb7fvT2iDY2eB6C8Z5sc9OaG5kCmHzedXt9dCDQ3l+qGLox9vr
	SFIy38hloiv9Nr8Jhh9v4Pu0/R9IQPmFpXJLY
X-Google-Smtp-Source: AGHT+IHkhZDhmWWPB1cRiDxB9O+hnujHgxHATcCOa7iU1U0cCGKQa4vDx7adryVU89//eg9XTwPdcw004ewXy/PqEHA=
X-Received: by 2002:a05:6402:27c7:b0:5c2:5641:af79 with SMTP id
 4fb4d7f45d1cf-5c414384e17mr546049a12.0.1726181597390; Thu, 12 Sep 2024
 15:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com>
In-Reply-To: <20240912210222.186542-1-surenb@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 13 Sep 2024 00:52:39 +0200
Message-ID: <CAG48ez131NJWvo_RrxL7Ss0p4jd_aKOu71z1vm9wfaH7Qjn+qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.

I think this is okay now, except for some comments that should be
fixed up. (Plus my gripe about the sequence count being 32-bit.)

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..5d8cdebd42bc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -887,6 +887,9 @@ struct mm_struct {
>                  * Roughly speaking, incrementing the sequence number is
>                  * equivalent to releasing locks on VMAs; reading the seq=
uence
>                  * number can be part of taking a read lock on a VMA.
> +                * Incremented every time mmap_lock is write-locked/unloc=
ked.
> +                * Initialized to 0, therefore odd values indicate mmap_l=
ock
> +                * is write-locked and even values that it's released.

FWIW, I would still feel happier if this was a 64-bit number, though I
guess at least with uprobes the attack surface is not that large even
if you can wrap that counter... 2^31 counter increments are not all
that much, especially if someone introduces a kernel path in the
future that lets you repeatedly take the mmap_lock for writing within
a single syscall without doing much work, or maybe on some machine
where syscalls are really fast. I really don't like hinging memory
safety on how fast or slow some piece of code can run, unless we can
make strong arguments about it based on how many memory writes a CPU
core is capable of doing per second or stuff like that.

> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..a281519d0c12 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,39 +71,86 @@ static inline void mmap_assert_write_locked(const str=
uct mm_struct *mm)
>  }
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +static inline void init_mm_lock_seq(struct mm_struct *mm)
> +{
> +       mm->mm_lock_seq =3D 0;
> +}
> +
>  /*
> - * Drop all currently-held per-VMA locks.
> - * This is called from the mmap_lock implementation directly before rele=
asing
> - * a write-locked mmap_lock (or downgrading it to read-locked).
> - * This should normally NOT be called manually from other places.
> - * If you want to call this manually anyway, keep in mind that this will=
 release
> - * *all* VMA write locks, including ones from further up the stack.
> + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE sem=
antics)
> + * or write-unlocked (RELEASE semantics).
>   */
> -static inline void vma_end_write_all(struct mm_struct *mm)
> +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
>  {
>         mmap_assert_write_locked(mm);

Not a memory barriers thing, but maybe you could throw in some kind of
VM_WARN_ON() in the branches below that checks that the sequence
number is odd/even as expected, just to make extra sure...

>         /*
>          * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
>          * mmap_lock being held.
> -        * We need RELEASE semantics here to ensure that preceding stores=
 into
> -        * the VMA take effect before we unlock it with this store.
> -        * Pairs with ACQUIRE semantics in vma_start_read().
>          */
> -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +
> +       if (acquire) {
> +               WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +               /*
> +                * For ACQUIRE semantics we should ensure no following st=
ores are
> +                * reordered to appear before the mm->mm_lock_seq modific=
ation.
> +                */
> +               smp_wmb();

This is not really a full ACQUIRE; smp_wmb() only orders *stores*, not
loads, while a real ACQUIRE also prevents reads from being reordered
up above the atomic access. Please reword the comment to make it clear
that we don't have a full ACQUIRE here.

We can still have subsequent loads reordered up before the
mm->mm_lock_seq increment. But I guess that's probably fine as long as
nobody does anything exceedingly weird that involves lockless users
*writing* data that we have to read consistently, which wouldn't
really make sense...

So yeah, I guess this is probably fine, and it matches what
do_raw_write_seqcount_begin() is doing.

> +       } else {
> +               /*
> +                * We need RELEASE semantics here to ensure that precedin=
g stores
> +                * into the VMA take effect before we unlock it with this=
 store.
> +                * Pairs with ACQUIRE semantics in vma_start_read().
> +                */
> +               smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +       }
> +}
> +
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> +       /* Allow speculation if mmap_lock is not write-locked */
> +       return (*seq & 1) =3D=3D 0;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq)
> +{
> +       /* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */

(see above, it's not actually a full ACQUIRE)

> +       smp_rmb();
> +       return seq =3D=3D READ_ONCE(mm->mm_lock_seq);
>  }
> +
>  #else
> -static inline void vma_end_write_all(struct mm_struct *mm) {}
> +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire) {=
}
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq) { return false; }
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq) { return false; }
>  #endif
>
> +/*
> + * Drop all currently-held per-VMA locks.
> + * This is called from the mmap_lock implementation directly before rele=
asing
> + * a write-locked mmap_lock (or downgrading it to read-locked).
> + * This should normally NOT be called manually from other places.
> + * If you want to call this manually anyway, keep in mind that this will=
 release
> + * *all* VMA write locks, including ones from further up the stack.

Outdated comment - now you are absolutely not allowed to call
vma_end_write_all() manually anymore, it would mess up the odd/even
state of the counter.

> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +       inc_mm_lock_seq(mm, false);
> +}

