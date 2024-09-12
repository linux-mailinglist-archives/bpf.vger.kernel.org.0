Return-Path: <bpf+bounces-39768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76234977347
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 23:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA982839CC
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59F1C1AA4;
	Thu, 12 Sep 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0Q1MNMh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1281BB691
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175060; cv=none; b=qM42P6Q5O3IWg36WjSFnMIR4CllJDXhDbsYywggrTMjQ7JqI0w2i8sTjEh3l2sLAMBz5vA3KvlWknsEssbC8S8ZJgGOI3JwOJJ+dYkAoKUpL1ulO0tbDQLIjdQGmNzkqEQEqJRIxbuceHwORMuCBjZZZdoqW2FhQ1wXvyN/46ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175060; c=relaxed/simple;
	bh=vM4ejuzZFoGQ4IIqaqzuyaHUU/1X4Ko8fl7eEhkQ/UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPL2EAe8/pqEzdEiW5zZT5VyzTWSiK5jMc7pbMHOHgy/gz65+OpHJAQSpaKhfhbcr02Oy0un6TRxhaTjVM+vhqJ+KGZIpAxzZAknD2h9ByafJ2WnUtBB8dwArIxMKMf1CqECd/cDJhU9vXWi0Qp4Al3qHRfxJ5HRUcgTmfSvYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0Q1MNMh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c24374d8b6so3292a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726175057; x=1726779857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9VsB68MQof9g4wA1cKKKrr59DMnuyJ0zAwUPhXjwPI=;
        b=Z0Q1MNMhdGcLjS/s2eLQVEwqfCz+U/DXu4wqoIZ6xY22Bq0Kxcuyv3ASr2L/LKbWZi
         L0UV4Ul8yAd+T76vlyB7FZGpvNT+3KYe7t+xUT4BXfJanG5Y6O068hjTZrDfaCXNspQr
         OZxnV7Q/B262+8wcg5Wu9ODYjA4kqRBO/bvOh+KAjeTFz/4eQDD/A7MaHelg20Q73OJV
         Z6osNAPdyYPvzeGqG/QMBvYbOvRMud9HAjI+pyZ3LqYP+JlhE56zGnOsmklYHEMAIbjr
         TsNy+sYUAW6eKGEUu00E8+VWuTwoAnb8JCd7NRCmMk9Y5kXXAxTJlGun7CFk817q8+FI
         qLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175057; x=1726779857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9VsB68MQof9g4wA1cKKKrr59DMnuyJ0zAwUPhXjwPI=;
        b=nrGprPraAPCWjA/9IPBA6G2wqcLt/BVG9dS3EA+0p/zZIDCcFj7WdDzFpMzLu2wARC
         6dsCHxBWsyivh6WmR3Qu6joztr72VCnrRlxCqjTAkw8LcZwrt9Q9rOl5L6cr99X2W3D9
         tEBEL4B3PGEYgbp1VRgB0Fd8WzxqeBthKwtx1SYB/DgFw52WkciVACDgscR90MPd09ia
         q/zd6ocFAZbT1eIejob8kTaM2SRVSzm6L5Z8Ap9uVUGXuTHwjclL0JK/NG3oQ5Punkm+
         d7OSz0LCS4Z7DqyhRF0Ts8K2Ft0pvIii5D84sPr3JP8rn907sXRSreeoTqLfHPqz2WTb
         VGvg==
X-Forwarded-Encrypted: i=1; AJvYcCVlNxb2DoX12VgUrSI/A/BYzD6x7I0JT7kMdgwYpJ8mb6W3ucfBOUfzSIpAg6Ab21G14qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQLHvP/8LtLGp3T3UF1AAoTtElkBRx28uOnZoBwZH3Dkk4Sw6
	eH1AddM+4t9xby9LvHmulEEqTZEaXvQwuKF1n5zBzcTR4jDR/L6eRsAwb+APF5LnOAdOVhnGqJr
	WMSViaN7nnQaKTNsRq2a931FVna/iXCIiCej9
X-Google-Smtp-Source: AGHT+IFLf7AFcbkAtsWFWFjzpfStlqHufGs3sxLk2dIi+9wgBc3dInwrl75rUyYqCfZRJ/a24Knz1XzFxhyJ/z86Zyo=
X-Received: by 2002:a05:6402:27c7:b0:5c2:5641:af79 with SMTP id
 4fb4d7f45d1cf-5c414384e17mr488780a12.0.1726175055955; Thu, 12 Sep 2024
 14:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com>
In-Reply-To: <20240912210222.186542-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Sep 2024 14:04:00 -0700
Message-ID: <CAJuCfpGgoSYmGSdcf+fZF1mUeNo-M=fzfk7G6ATs5-0TT+zkfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.

Here you go. I hope I got the ordering right this time around, but I
would feel much better if Jann reviewed it before it's included in
your next patchset :)
Thanks,
Suren.

>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> Changes since v1 [1]:
> - Made memory barriers in inc_mm_lock_seq and mmap_lock_speculation_end
> more strict, per Jann Horn
>
> [1] https://lore.kernel.org/all/20240906051205.530219-2-andrii@kernel.org=
/
>
>  include/linux/mm_types.h  |  3 ++
>  include/linux/mmap_lock.h | 74 ++++++++++++++++++++++++++++++++-------
>  kernel/fork.c             |  3 --
>  3 files changed, 65 insertions(+), 15 deletions(-)
>
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
>                  *
>                  * Can be modified under write mmap_lock using RELEASE
>                  * semantics.
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
> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +       inc_mm_lock_seq(mm, false);
> +}
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> +       init_mm_lock_seq(mm);
>  }
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -111,6 +158,7 @@ static inline void mmap_write_lock_nested(struct mm_s=
truct *mm, int subclass)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write_nested(&mm->mmap_lock, subclass);
> +       inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -120,6 +168,8 @@ static inline int mmap_write_lock_killable(struct mm_=
struct *mm)
>
>         __mmap_lock_trace_start_locking(mm, true);
>         ret =3D down_write_killable(&mm->mmap_lock);
> +       if (!ret)
> +               inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
>         return ret;
>  }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 61070248a7d3..c86e87ed172b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct *=
mm, struct task_struct *p,
>         seqcount_init(&mm->write_protect_seq);
>         mmap_init_lock(mm);
>         INIT_LIST_HEAD(&mm->mmlist);
> -#ifdef CONFIG_PER_VMA_LOCK
> -       mm->mm_lock_seq =3D 0;
> -#endif
>         mm_pgtables_bytes_init(mm);
>         mm->map_count =3D 0;
>         mm->locked_vm =3D 0;
>
> base-commit: 015bdfcb183759674ba1bd732c3393014e35708b
> --
> 2.46.0.662.g92d0881bb0-goog
>

