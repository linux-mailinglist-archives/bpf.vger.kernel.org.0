Return-Path: <bpf+bounces-51172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376CA31422
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3387A2673
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7B250BF5;
	Tue, 11 Feb 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxHB9N7F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AF3BB54;
	Tue, 11 Feb 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298796; cv=none; b=EkcqtL1X8Qo274LDrmrUcouVT56cIesSnGq1WaTubwkut+WFGdzv6oLl8O6oKD4yWcrCPt/NY8VOGFTF2K4UVCsNF17YckiEJv7epwn7WUeGMYmvwDZmNuzY+SXNnCsOmyQzQsZZ4TyUrVFQAPqumJv/yhJQO2hPd9+RHPptmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298796; c=relaxed/simple;
	bh=LlK8yXrk8rpmwS1dW0RdbSIzWK0XQ2A0ua9/S+4MO7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+etiAaE45qSY+vT/YkxnisxlyzL13LJ4JtNES0T1egCmzvG5MtN1p9GTLuQgVHQnR+xI8tlhoC12qoKXyvtiYk48Lqj392d2+9BpWH5vVV1GKlo3T/Goc0x5sa/ERxn6xyOE0pN6FvIe2xZrvv+g29wR/X5Z0abvSrj7ryjijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxHB9N7F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393f6a2c1bso175995e9.1;
        Tue, 11 Feb 2025 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739298793; x=1739903593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9xncSfJUqF3qhAWmrgAzO9fCiQaEXfBzNsshntNyI=;
        b=gxHB9N7Fcnh6GLrdvmnadUTIDRwp3S8vu0PgQX2m8Z6NE4MtWVy42ia6WUdr6MSNEU
         7twSaplPi1olhvCgjLXMqT8ePKHJY2mAvE0zq+HwayPIvYBQ43krgTA2WBWebt8UZtQV
         o59iTS6amY+o7P42k30SBEIgWvEQ8X03mpRjaRA/ptxaV9BYjbllk2JDHEfTupvE1hFk
         m8oLAgF7MJf4EbiVKqJvLodexxVb5V8c7V/ASaJwV3Wm3FsS0WqaLz7DB56gEboMrEWI
         NvXzq4KLyAmM/s3WAX9nhny7Q8Btdhcy6Ngqkn8cKg8Yqgd61At8S7bPm17PKL3sR13M
         u9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739298793; x=1739903593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n9xncSfJUqF3qhAWmrgAzO9fCiQaEXfBzNsshntNyI=;
        b=O+5NT5KNQdQ+lH+rM5Wlr0Wbt4+7379UcNkGDGacdfbWKgRj9qSimsakx+UfJnXGs0
         Z6zLPKjP+I3XLVssfrzcjPoV8itrTvSRvRGETvEuIehAgFNeyh4VoDIVyVyTur1MdgGC
         IP/OLI9empO1sXtNtGimwIZ7QU8H3vr5LGpMbdakCqLX/gSyl/9lQ7OgFdQG1lIawYVD
         AmQvc3pbnCAOyx7gbYlWkDPvsHC53/C7wNi7pLpvg03/a/e1mDIelFwtSAy2MrZ7jNEN
         r+6nQOd+7pn5JpNxGAe1nDGNazl0Cvw9NWMzpiKpsAxJxR+ugnFsgfSa6C43EpLAc5nx
         /nRA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmEW4vqtBGUsvYxHrfCh07GHmg7NfcoMyhfhJ1V7rH+EU/EFwxkO2ISjwhKMOUQf73rA=@vger.kernel.org, AJvYcCVp1cSopeW2Ka3Twwk+ULsqHBVeWwqKAhJGZN/twMmEvucn+96vsck5MN0/pfHYmqRxo+dZ7Ese6FtQ1WfH@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ9DKYo4lp1iGfcpaIaX6931xQnvLQ6sndMjLSIaYyoeca4Eh
	a+yDp6sR6J2VAIGSm5OAHaVvTd9r0/ZR5Kl8Rm4ytrUdMstKY1PVit+1hsADEVmLmR7QTSUqZr0
	zy3QWX3P0r20zsIZ9Jw7blTKV4os=
X-Gm-Gg: ASbGnctQEIna368CGZ977uvTYDJHHtdkNmy2PDu8xNn++W8Ab1M+URIKX9DLesfxvxO
	j455lhirSPpL144iTSBSYSgw9HUeUsZSOqNq+Tv9xBikxJDIwuoZ2P0C71zN8zwZmxYjhjYS8CF
	ZSiAvSx+Hql1/m
X-Google-Smtp-Source: AGHT+IE22meWQEZbh6iCNZ83MxT8OPoGPC3rZhyxiT3FBfkUhRKZ2TeAUPawGwjn1n4PN4BAKXmRozRp3o6LVQYVSUA=
X-Received: by 2002:a05:6000:1541:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-38dea15b478mr130562f8f.0.1739298792407; Tue, 11 Feb 2025
 10:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net> <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
 <20250211104352.GC29593@noisy.programming.kicks-ass.net>
In-Reply-To: <20250211104352.GC29593@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Feb 2025 10:33:00 -0800
X-Gm-Features: AWEUYZlc7wUdKqIC9UpU_G5Er__TqS_i5I1mQbNN7oKcsRHscpu2UHDdRRGMHAs
Message-ID: <CAADnVQJ=81PE19JWeNjq6aNOy+GM-wo6n7WU9StX1b6kevqCUw@mail.gmail.com>
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

On Tue, Feb 11, 2025 at 2:44=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Feb 10, 2025 at 08:37:06PM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 10, 2025 at 2:49=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > > >
> > > > Do you force unload the BPF program?
> >
> > Not yet. As you can imagine, cancelling bpf program is much
> > harder than sending sigkill to the user space process.
>
> So you are killing the user program? Because it wasn't at all clear what
> if anything is done when this failure case is tripped.

No. We're not killing the user process. bpf progs often run
when there is no owner process. They're just attached
somewhere and doing things.
Like XDP firewall will work just fine without any user space.

> > The prog needs to safely free all the resources it holds.
> > This work was ongoing for a couple years now with numerous discussions.
>
> Well, for you maybe, I'm new here. This is only the second submission,
> and really only the first one I got to mostly read.
>
> > > Even the simple AB-BA case,
> > >
> > >   CPU0          CPU1
> > >   lock-A        lock-B
> > >   lock-B        lock-A <-
> > >
> > > just having a random lock op return -ETIMO doesn't actually solve
> > > anything. Suppose CPU1's lock-A will time out; it will have to unwind
> > > and release lock-B before CPU0 can make progress.
> > >
> > > Worse, if CPU1 isn't quick enough to unwind and release B, then CPU0'=
s
> > > lock-B will also time out.
> > >
> > > At which point they'll both try again and you're stuck in the same
> > > place, no?
> >
> > Not really. You're missing that deadlock is not a normal case.
>
> Well, if this is unpriv user programs, you should most definitely
> consider them the normal case. Must assume user space is malicious.

Ohh. No unpriv here.
Since spectre was discovered unpriv bpf died.
BPF_UNPRIV_DEFAULT_OFF=3Dy was the default for distros and
all hyperscalers for quite some time.

> > As soon as we have cancellation logic working we will be "sigkilling"
> > prog where deadlock was detected.
>
> Ah, so that's the plan, but not yet included here? This means that every
> BPF program invocation must be 'cancellable'? What if kernel thread is
> hitting tracepoint or somesuch?
>
> So much details not clear to me and not explained either :/

Yes. The plan is to "kill" bpf prog when it misbehaves.
But this is orthogonal to this res_spin_lock set which is
a building block.

> Right, but it might have already modified things, how are you going to
> recover from that?

Tracking resources acquisition and release by the bpf prog
is a normal verifier job.
When bpf prog does bpf_rcu_read_lock() the verifier makes sure
that all execution paths from there on have bpf_rcu_read_unlock()
before program reaches the exit.
Same thing with locks.
If bpf_res_spin_lock() succeeds the verifier will make sure
there is matching bpf_res_spin_unlock().
If some resource was acquired before bpf_res_spin_lock() and
it returned -EDEADLK the verifier will not allow early return
without releasing all acquired resources.

> > Failing to grab res_spin_lock() is not a normal condition.
>
> If you're going to be exposing this to unpriv, I really do think you
> should assume it to be the normal case.

No unpriv for foreseeable future.

> > The prog has to implement a fallback path for it,
>
> But verifier must verify it is sane fallback, how can it do that?
>
> > > Given you *have* to unwind to make progress; why not move the entire
> > > thing to a wound-wait style lock? Then you also get rid of the whole
> > > timeout mess.
> >
> > We looked at things like ww_mutex_lock, but they don't fit.
> > wound-wait is for databases where deadlock is normal and expected.
> > The transaction has to be aborted and retried.
>
> Right, which to me sounds exactly like what you want for unpriv.
>
> Have the program structured such that it must acquire all locks before
> it does a modification / store -- and have the verifier enforce this.
> Then any lock failure can be handled by the bpf core, not the program
> itself. Core can unlock all previously acquired locks, and core can
> either re-attempt the program or 'skip' it after N failures.

We definitely don't want to bpf core to keep track of acquired resources.
That just doesn't scale.
There could be rcu_read_locks, all kinds of refcounted objects,
locks taken, and so on.
The verifier makes sure that the program does the release no matter
what the execution path.
That's how it scales.
On my devserver I have 152 bpf programs running.
All of them keep acquiring and releasing resources (locks, sockets,
memory) million times a second.
The verifier checks that each prog is doing its job individually.

> It does mean the bpf core needs to track the acquired locks -- which you
> already do,

We don't. The bpf infra does static checks only.
The core doesn't track objects at run-time.
The only exceptions are map elements.
bpf prog might store an acquired object in a map.
Only in that case bpf infra will free that object when it frees
the whole map.
But that doesn't apply to short lived things like RCU CS and
locks. Those cannot last long. They must complete within single
execution of the prog.

> > That was a conscious trade-off. Deadlocks are not normal.
>
> I really do think you should assume they are normal, unpriv and all
> that.

No unpriv and no, we don't want deadlocks to be considered normal
by bpf users. They need to hear "fix your broken prog" message loud
and clear. Patch 14 splat is a step in that direction.
Currently it's only for in-kernel res_spin_lock() usage
(like in bpf hashtab). Eventually we will deliver the message to users
without polluting dmesg. Still debating the actual mechanism.

