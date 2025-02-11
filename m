Return-Path: <bpf+bounces-51103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E427A3028E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3B168ADE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143D1D79B8;
	Tue, 11 Feb 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2IZRZc3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B326BDB9;
	Tue, 11 Feb 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739248642; cv=none; b=I2ShM/B1OzOLIbadSlLxZ8+v/zHJEH9xwcx0kIdSApL7CEc+i0CkA/GPFjnPRnR7iSejQGbFgzhFgQn9nekM+90UY8enEbNlD5AriHOtYITljYpA/HUJMP1QoKUehRi3TOSILWbWPfo9EZdPn37R0M6rCT7Vklfes4NdXxgfAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739248642; c=relaxed/simple;
	bh=iiD3hFv4/MGf8LpuTJ3yO1d/xx2v3nf6evB3IjbCFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8AeKmgRvA9CBW1TmzgNCkGfKO50yXJSl5W55lfYILkAFaGG9DRhh2LS1fVs14hIkPRWvt+vdPH2M2jeIdmjZUElGaT2uE/qjIxP66Yehsom64wYJEX48jOqAOQ1Aw0hypKZWS24Mpc7jN3tCmD4YKzSBABl7KpJhFya+6cYf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2IZRZc3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so12454565e9.0;
        Mon, 10 Feb 2025 20:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739248638; x=1739853438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWpfdB70sbWftAcYj4ejbqqRA/4AsMF0XJbVpkeKv2U=;
        b=G2IZRZc3lN0oMzFj+c5OTst/db9R7smsii+Av03qPbRVSyl3yVjeT/ytrymYHX8f0q
         fM4GOhErObrIssEKVaFqveE4sfz++UghT0diPadnGLaShmajoRTooT07Bjb+qKiMECrN
         CtQtrQtEHucW3KTacC25/L8kAqWwWWphNqSiKYU/bkxqNmpYsbcKwrABjTHnRsjlMcmM
         JBQ8Da7nWViH7+KtbdK+UlpYw3cCDs4GEpu+tgdKerERyhfZtWRfVu7ioD5fADQcKkHY
         MsuExbxrTEB+OiB6wPGo7r/HKCxIEnO8cdPMLKxuNksImqZ+TNv5cvvzp5C7vm9KrWNH
         9Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739248638; x=1739853438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWpfdB70sbWftAcYj4ejbqqRA/4AsMF0XJbVpkeKv2U=;
        b=xJ074SlNZDmyRoeQ8v6mj8quQeuxXUGuPFeBSA4HbAGQ/JI6tntKEDzD/251A4ydCj
         ggMBoaTUo6A6stAfBForn3xtJdvBIgCJz5sg/DvH2a/qYYkRkX1HbWnikY3OVjCt7Vzh
         r8zqGNBzLd+JRke335LvbFdAXgHdCRXBnVvxlo38nZUW5vIo2CyYTRGExnvJmsv85C91
         yjSNhRf1a+YN6QfYxKKJQgBLM/rsLt9seGC1RoLn+PTufxF0bdOAtvmDzlraR+JeD99V
         v/GwzeFYboXU8qsK0pL/GNs8DplZP0Mu3/RDlTN1CqAhMAOVbvdxs+SlHjA8sVRSLXPx
         adXw==
X-Forwarded-Encrypted: i=1; AJvYcCUz1FkTQ+ZG1VMHSkNITsu3UGRb6qo/jytejlzaMKegw3Z+EC+lczx1/lyU6Q1STCGKHlk=@vger.kernel.org, AJvYcCW/YqzoAE8896Y19myOC8ywaIvqqf5zrA6Tl10yxfd9LJA02Y5GvSB36J26X+ao4vlXrKvfCmgFEK/jEvFS@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6u+mjB9ZXV2zzpgtgXtVzDYOPH6vPdUZuDKDLPkUlKlGwLNY
	3uleRXuyHEbC1Q55xjAxnCBpONI+CEszYaHEPvTPwQC3gimQfuHiUmF42Qoel+iABd2yAFIcnWw
	hWToc+2J0f7P/ujpYBcCr1702WMI=
X-Gm-Gg: ASbGncuud97vvJqRSPJcrsFwmhvPfZ8mrWFHYDabKmWwoUPAuUUKi0kJbMvYOhWXZaq
	B1QpfXPu5Q7ufCJkw1tJopCfpUQen7sQmmrgHvVWTXVPFXMeVoMytzmyCX8+1K23VKiGI0suhL/
	pdIlZAQ5renPSv4apCMCxjXPTBc9Ot
X-Google-Smtp-Source: AGHT+IGRefKznhz5yHKjcgGgQFbE9mcQJ89SBHVOVNja4lptmvxdcQaOzzSj54C/Z2QjZl52i6rOHwKdMoqDioHBQj0=
X-Received: by 2002:a5d:64ef:0:b0:38d:e6f4:5a88 with SMTP id
 ffacd0b85a97d-38de6f45ebemr99163f8f.12.1739248638184; Mon, 10 Feb 2025
 20:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210104931.GE31462@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Feb 2025 20:37:06 -0800
X-Gm-Features: AWEUYZkr9lC8NBO_G3nOjJwjSNmxpru73XcllQ0zpalWtpIGmw6oAJpxSMv3-wg
Message-ID: <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:49=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> >
> > Do you force unload the BPF program?

Not yet. As you can imagine, cancelling bpf program is much
harder than sending sigkill to the user space process.
The prog needs to safely free all the resources it holds.
This work was ongoing for a couple years now with numerous discussions.
Many steps in-between are being considered as well.
Including detaching misbehaving prog, but there is always a counter
argument.

> Even the simple AB-BA case,
>
>   CPU0          CPU1
>   lock-A        lock-B
>   lock-B        lock-A <-
>
> just having a random lock op return -ETIMO doesn't actually solve
> anything. Suppose CPU1's lock-A will time out; it will have to unwind
> and release lock-B before CPU0 can make progress.
>
> Worse, if CPU1 isn't quick enough to unwind and release B, then CPU0's
> lock-B will also time out.
>
> At which point they'll both try again and you're stuck in the same
> place, no?

Not really. You're missing that deadlock is not a normal case.
As soon as we have cancellation logic working we will be "sigkilling"
prog where deadlock was detected.
In this patch the verifier guarantees that the prog must check
the return value from bpf_res_spin_lock().
The prog cannot keep re-trying.
The only thing it can do is to exit.
Failing to grab res_spin_lock() is not a normal condition.
The prog has to implement a fallback path for it,
but it has the look and feel of normal spin_lock and algorithms
are written assuming that the lock will be taken.
If res_spin_lock errors, it's a bug in the prog or the prog
was invoked from an unexpected context.

Same thing for patches 19,20,21 where we're addressing years
of accumulated tech debt in the bpf core parts, like bpf hashmap.
Once res_spin_lock() fails in kernel/bpf/hashtab.c
the bpf_map_update_elem() will return EBUSY
(just like it does now when it detects re-entrance on bucket lock).
This is no retry.
If res_spin_lock fails in bpf hashmap it's 99% case of syzbot
doing "clever" attaching of bpf progs to bpf internals and
trying hard to break things.

> Given you *have* to unwind to make progress; why not move the entire
> thing to a wound-wait style lock? Then you also get rid of the whole
> timeout mess.

We looked at things like ww_mutex_lock, but they don't fit.
wound-wait is for databases where deadlock is normal and expected.
The transaction has to be aborted and retried.
res_spin_lock is different. It's kinda safe spin_lock that doesn't
brick the kernel.
To be a drop in replacement it has to perform at the same speed
as spin_lock. Hence the massive benchmarking effort that
you see in the cover letter. That's also the reason to keep it 4 bytes.
We don't want to increase it to 8 or whatever unless it's absolutely
necessary.

In the other email you say:

> And it seems to me this thing might benefit somewhat significantly from
> adding this little extra bit.

referring to optimization that 8 byte res_spin_lock can potentially
do O(1) ABBA deadlock detection instead of O(NR_CPUS).
That was a conscious trade-off. Deadlocks are not normal.
If it takes a bit longer to detect it's fine.
The res_spin_lock is optimized to proceed as normal qspinlock.

