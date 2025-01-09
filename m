Return-Path: <bpf+bounces-48348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69831A06C44
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423363A7C4D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755617C7C4;
	Thu,  9 Jan 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIyGKh+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AB17C9F1;
	Thu,  9 Jan 2025 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393420; cv=none; b=KG4dRg7moTCRYCZkgIzcpXsmoCWQC1UDgQ3vj8HOVjfFMgmkq6l4WWCtOSKS5ZGFgOEkmG01VZMyNFtO4LDvrD6UwPe/D4zpmVI0l7ONDK6lIAsukmO9mRexL2ZWMz0HZfa/hlOq+7NkGV2KnwdpqqsC3aEnWbyFP+D3xii6s+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393420; c=relaxed/simple;
	bh=p5S5mW+LeXp0PvEEiwMnHoT3w+2HlRlfA2h48ZU173Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgRCxbKWkHwA2rO1+NMGB6N9nL+2gUVoSe9zqrY+n/EsFANWAYicx+u5AG39XURDEnxCxkuJeETSN2/N1EB8rF2urYeIjl3flAJU3l0zEMmAWWUrTTboTt9zvZge9VnJHBQm4Ih6DNVD5znZerBmSJqnYhh6j9VtF892iiHIQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIyGKh+x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso3880125e9.0;
        Wed, 08 Jan 2025 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393416; x=1736998216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5S5mW+LeXp0PvEEiwMnHoT3w+2HlRlfA2h48ZU173Q=;
        b=KIyGKh+xYExS6KczYVol4BtYWyb3bMusKKXiKW23i16sbQqH+zrHvztIPtxezpsVsm
         iTzmJ3itGJla0f9Mhp7ZDm1pLEdL5F5y97dc2SLbyp3u5T3oNQ9ONoIYrwCUw+3twlG9
         vdm28T3nSfjjdboA8tUBTEOvOvzh4MOvyR+ar25wePRrrHhlKKD7WBrqGLZvlajMAmWo
         PuRngeLa+XILIYEPRR6f0FQRT6u+ZIh5oZkmf4nxYZeb+8dayk2Ie4VG7W63mAfrmUq+
         0yNAoBa+Sq4YuSkuSQVhltri2EhxtBRkSYHSXzXVGelg6P+PSd4/JqDLXfbn9/F2PwBm
         7adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393416; x=1736998216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5S5mW+LeXp0PvEEiwMnHoT3w+2HlRlfA2h48ZU173Q=;
        b=p43dvJDt4v23ImZLnPHlfd4e8W34PdKIjso3AmdQd8NQJnft7TyVWGA+aO+k06bNBN
         UJY7DxLEQzEXClvxFgk6Huj7TqvWtaTJpCVBppvzz2XPcNRJJy0hzpLYQaIZUK1XpQHq
         QKs7M4OveDlkr9hiXq0/aMhQN4rNMAeo530I07rwmojogUcSfokjQQOtvA2TrcWk5knk
         Ua70B176xvM5ue2LBNa47h2nYWK70mib0solZkksVA20rUVBKYhCLcq3giBPR6nvnmyx
         q4Her9cQ0jfZBHohTkniGk5oHbXO/x6lx9rgs29nU8iF+7ULUlZMgEjBE3lb+gYQyrrl
         7u7A==
X-Forwarded-Encrypted: i=1; AJvYcCWU3BOWPYx59RLg49fdIa7Ce0dv7MTYXuWl4oYlm0zitfZE00a2aG1FXtJxqlaITpHCGJpbM+fUtJ2S/ZYv@vger.kernel.org, AJvYcCXK40hcdaCTdlK41T5B/iYHaBPfeE4lQtLa8Pmv8sQbJ2zTXN2RhOWKEo153qiOkq55ZFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhaKBKMrknRIP3LGYaUe4+ddMI7ZHOlywhTtFRuFJ4VKE0iES
	3ST3LbQdYng5HcuI5zod9wkfvc/4sdguxbssfqOvl9fnwC2aExroNaqkwRKXl8gaLDDI5R7yA9R
	DkDjM1qJmkk2qjDqk1I6/7gMg4TM=
X-Gm-Gg: ASbGnctaX38+kQf+7OH8xftr8ZALJMLkTfDvnT2TluCrr3DujTc3vNxck/49DUxlrmF
	xw3WzpDYdgGMjPIC4dp7irkpYnSqW/WOUQrjYKFarB7OQ25LScI3BG51Gp4YIHYMAMa+LoA==
X-Google-Smtp-Source: AGHT+IGB2aAk1Pw5r5FPTIxMbs4LwMycRPjcfLlx8+uRbrdAjcUMzHT8z6Unf3wscrpU7eFtzLBRIOWooDV+T2yiez8=
X-Received: by 2002:a5d:59ab:0:b0:38a:624b:e37b with SMTP id
 ffacd0b85a97d-38a873564a7mr4574653f8f.53.1736393416229; Wed, 08 Jan 2025
 19:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-15-memxor@gmail.com>
 <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com> <CAP01T77QD_pYBVS4PfG3jDeXObKHZJkV2nQX+0njv11oKTEqRA@mail.gmail.com>
 <2ff3a68c-1328-4b47-a4aa-0365b3f1809b@redhat.com>
In-Reply-To: <2ff3a68c-1328-4b47-a4aa-0365b3f1809b@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 19:30:05 -0800
X-Gm-Features: AbW1kvYbnl67k_gh2hDgKRafC1F8uLS-nHwS-eMOICyRrVcDfCyxsrXFVBL8jDI
Message-ID: <CAADnVQJ=B4cdGa+OuN7d61=LCXmQgZQz=TF+nRD55m3=2EX2cA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock usage
To: Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 5:11=E2=80=AFPM Waiman Long <llong@redhat.com> wrote=
:
>
>
> > Most of the users use rqspinlock because it is expected a deadlock may
> > be constructed at runtime (either due to BPF programs or by attaching
> > programs to the kernel), so lockdep splats will not be helpful on
> > debug kernels.
>
> In most cases, lockdep will report a cyclic locking dependency
> (potential deadlock) before a real deadlock happens as it requires the
> right combination of events happening in a specific sequence. So lockdep
> can report a deadlock while the runtime check of rqspinlock may not see
> it and there is no locking stall. Also rqspinlock will not see the other
> locks held in the current context.
>
>
> > Say if a mix of both qspinlock and rqspinlock were involved in an ABBA
> > situation, as long as rqspinlock is being acquired on one of the
> > threads, it will still timeout even if check_deadlock fails to
> > establish presence of a deadlock. This will mean the qspinlock call on
> > the other side will make progress as long as the kernel unwinds locks
> > correctly on failures (by handling rqspinlock errors and releasing
> > held locks on the way out).
>
> That is true only if the latest lock to be acquired is a rqspinlock. If.
> all the rqspinlocks in the circular path have already been acquired, no
> unwinding is possible.

There is no 'last lock'. If it's not an AA deadlock there are more
than 1 cpu that are spinning. In a hypothetical mix of rqspinlocks
and regular raw_spinlocks at least one cpu will be spinning on
rqspinlock and despite missing the entries in the lock table it will
still exit by timeout. The execution will continue and eventually
all locks will be released.

We considered annotating rqspinlock as trylock with
raw_spin_lock_init lock class, but usefulness is quite limited.
It's trylock only. So it may appear in a circular dependency
only if it's a combination of raw_spin_locks and rqspinlocks
which is not supposed to ever happen once we convert all bpf inner
parts to rqspinlock.
Patches 17,18,19 convert the main offenders. Few remain
that need a bit more thinking.
At the end all locks at the leaves will be rqspinlocks and
no normal locks will be taken after
(unless NMIs are doing silly things).
And since rqspinlock is a trylock, lockdep will never complain
on rqspinlock.
Even if NMI handler is buggy it's unlikely that NMI's raw_spin_lock
is in a circular dependency with rqspinlock on bpf side.
So rqspinlock entries will be adding computational
overhead to lockdep engine to filter out and not much more.

This all assumes that rqspinlocks are limited to bpf, of course.

If rqspinlock has use cases beyond bpf then, sure, let's add
trylock lockdep annotations.

Note that if there is an actual bug on bpf side with rqspinlock usage
it will be reported even when lockdep is off.
This is patch 13.
Currently it's pr_info() of held rqspinlocks and dumpstack,
but in the future we plan to make it better consumable by bpf
side. Printing into something like a special trace_pipe.
This is tbd.

> That is probably not an issue with the limited rqspinlock conversion in
> this patch series. In the future when more and more locks are converted
> to use rqspinlock, this scenario may happen.

The rqspinlock usage should be limited to bpf and no other
normal lock should be taken after.
At least that was the intent.
If folks feel that it's useful beyond bpf then we need to think harder.
lockdep annotations is an easy part to add.

