Return-Path: <bpf+bounces-54375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B2A68FD4
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77557AD38E
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30368210186;
	Wed, 19 Mar 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxbhWbZh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67F1DF986;
	Wed, 19 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395012; cv=none; b=iRpYe+fsvIvGFcOhEuAepbvHwQBBE5v/u6qh48zXd6IU3UOghWJV/fsCdVPObf/cyerxLh0cGvsS31HB6Kpc7Rv/VkC1cMF/g3sBsNDNdxx9EH+E1kpyInHrhbcHbbagNA0M9WsXhZCtrUWBstU3YeKLVpj08y4Lwh25ILqGOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395012; c=relaxed/simple;
	bh=5ISoKMGoKTb252HA9x5/Q6Db9PC9eaXgdj9Ru45RcW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oInPlQ1ySUMszumAeXuJGO2F7wvnJJuDXZczmpe2akjsZNorOWfv5lnNjIMQgPKKzcnbjPVghMHKUmKboALz3Y7ooCgS/6IWfsAZC/xWDO5OFYJVBTr7XD+4oDO9OXFaDNGIVpW0YOkbIQt1kyubWLJHaVIpnlZBb7WezpgnYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxbhWbZh; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso3323786a12.2;
        Wed, 19 Mar 2025 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395009; x=1742999809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn15IXFR4OT4laOzRpofJZURwq8wYjIMrKFVK1LfAeE=;
        b=bxbhWbZhLud51fDQxkhmEM7g+kkAEgk6xcGnFA5tGW4nbyvMDaAqyXJdcbyI1xWi55
         ngcRMuOz7EATTUMSgSC1sFZWD0sE3r2XJbzeey83IIMXCyCyc9VHV/tCx/8ubQWe3jCh
         Bhec06x/AU++TkP37nk+6jy8IoYml5EB/p3ij35x5uEAozvJzLaUjaeDkr/kv8BgyYqW
         mBxWd/xTkOKAjjihKeUE2DhDjMHPVPgjH+GbDWuGBHJyxJvcYsUmAQNXfNBeutydSrJ6
         agwPynggwkja/3Xes5jxTO3Dk6LswkEQGwhQahIT8Lz3J4XpBqE+x9s6UYgf5aMWsdaT
         4EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395009; x=1742999809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn15IXFR4OT4laOzRpofJZURwq8wYjIMrKFVK1LfAeE=;
        b=fKqlljcdxweopxgOE6QKYohnWispzZbfcrE+qH4SiW7AZO5bZzC90/Vq4EfLMQhF+z
         xJk9/6whk8sio3K7TyRG5+J/5ycprdwiOx6mh/zR87TCHXnZ+fiGaIEm1ijkI+58/lqG
         OqKLHQ7WBJOiLF6/JTqctklSA0nf3jj/KbJue+9irH2S9kWjc0qQmvj4bqfW7PagIZTI
         KGmVdWSpktzXXg02E9/8uaxcqCSk9C4lexcLPh/ZDa07q+ABX87LJzbJuT7CSLOzYOby
         kRlIJ/A1HXvrBrvK/LrrcOCaKX44BTkMo+YjTmQ55mkM28gKVfLEtBmD4qL1SLP9ZReR
         WIFw==
X-Forwarded-Encrypted: i=1; AJvYcCUijNnaw/6SFCQKHzmcmbWq6E8pOjZ8+sJ53s8UK8JyPYc3d7lQUVBv9LXmvMYaA5jLet8=@vger.kernel.org, AJvYcCUwKgxWJkOc9A20E6ENaM+pF2mqKxIJDbX0uCSAE9QQrndpW5YNnlbDj2YLC8Cr1mwTgFC90KDZ@vger.kernel.org, AJvYcCV+Ma8hFHwnFV89ElsqRpODvpGSDInV1ShmogyJNw81YOeFSUyVACe390H8uMUiB8aWA0UYQrR+8rHk6Mq+@vger.kernel.org, AJvYcCXoqD3p53XtAJQa3413jr3tbBDr/GtxZVoRlG1unaTctDQ/YsCF38cHx3bxd8ep/66MVB1m62mBApUenw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfj/io7vKURqwQbzqtqvYPOcQE0ZIX468byFqP819FX+PW9DZ9
	3ONF0L1JfLpmNt0mmL2eMJfOsbOcU34sOrz7agAaAUsFr2tMteTpNSsA+UDGiwocDDIWJs2XOjx
	HOsjds2jiAOVTZSiKxshKGGjGSao=
X-Gm-Gg: ASbGncsCyL9UenJg6F0Dv93f9RHoWg9ZKAa1YYS7ChMYkifC9yIqEhrIeRESzJUT7zL
	dqHdeunY6EmBiEmz2ykcKjNgluzv+Y4a3fYUVzCMCF3wd707R6lVJMV07B5Komt3teh9mZnKVk5
	HBFTKkwzWGWVEvnyNDm/mv8yLSC5K85GX9anberSeq66H+oIA=
X-Google-Smtp-Source: AGHT+IHddeeN8mNv5+1bh6K/hWSllyearFYtBv5DfrBko/3PysyR4w2SEgYrLjtzsAgB9isOZOWnbqqYZLZ+z7mV+mg=
X-Received: by 2002:a05:6402:2355:b0:5d3:cff5:634f with SMTP id
 4fb4d7f45d1cf-5eb80fcbf36mr2823694a12.24.1742395008833; Wed, 19 Mar 2025
 07:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com> <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
In-Reply-To: <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Mar 2025 15:36:11 +0100
X-Gm-Features: AQ5f1JqDGcJXFW4K4PXGlZ9V0tVmeXaDpiwZKjz6iIM3cSHrVyoJtVhkAXXcnaA
Message-ID: <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 at 14:43, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Wed, 19 Mar 2025 at 14:37, Kumar Kartikeya Dwivedi <memxor@gmail.com> =
wrote:
> >
> > On Wed, 19 Mar 2025 at 03:47, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 7:33=E2=80=AFPM Stephen Rothwell <sfr@canb.au=
ug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > After merging the bpf-next tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >
> > > > In file included from include/asm-generic/percpu.h:7,
> > > >                  from arch/x86/include/asm/percpu.h:630,
> > > >                  from arch/x86/include/asm/preempt.h:6,
> > > >                  from include/linux/preempt.h:79,
> > > >                  from include/linux/smp.h:116,
> > > >                  from kernel/locking/qspinlock.c:16:
> > > > kernel/locking/qspinlock.h: In function 'decode_tail':
> > > > include/linux/percpu-defs.h:219:45: error: initialization from poin=
ter to non-enclosed address space
> > > >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr)=
 + 0))NULL;    \
> > > >       |                                             ^
> > > > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__v=
erify_pcpu_ptr'
> > > >   237 |         __verify_pcpu_ptr(ptr);                            =
             \
> > > >       |         ^~~~~~~~~~~~~~~~~
> > > > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_=
cpu_ptr'
> > > >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> > > >       |                ^~~~~~~~~~~
> > > > include/linux/percpu-defs.h:219:45: note: expected 'const __seg_gs =
void *' but pointer is of type 'struct mcs_spinlock *'
> > > >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr)=
 + 0))NULL;    \
> > > >       |                                             ^
> > > > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__v=
erify_pcpu_ptr'
> > > >   237 |         __verify_pcpu_ptr(ptr);                            =
             \
> > > >       |         ^~~~~~~~~~~~~~~~~
> > > > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_=
cpu_ptr'
> > > >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> > > >       |                ^~~~~~~~~~~
> > > > kernel/locking/qspinlock.c: In function 'native_queued_spin_lock_sl=
owpath':
> > > > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'de=
code_tail' from pointer to non-enclosed address space
> > > >   285 |                 prev =3D decode_tail(old, qnodes);
> > > >       |                                         ^~~~~~
> > > > In file included from kernel/locking/qspinlock.c:30:
> > > > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' b=
ut argument is of type '__seg_gs struct qnode *'
> > > >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 t=
ail, struct qnode *qnodes)
> > > >       |                                                            =
     ~~~~~~~~~~~~~~^~~~~~
> > > > In file included from kernel/locking/qspinlock.c:401:
> > > > kernel/locking/qspinlock.c: In function '__pv_queued_spin_lock_slow=
path':
> > > > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'de=
code_tail' from pointer to non-enclosed address space
> > > >   285 |                 prev =3D decode_tail(old, qnodes);
> > > >       |                                         ^~~~~~
> > > > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' b=
ut argument is of type '__seg_gs struct qnode *'
> > > >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 t=
ail, struct qnode *qnodes)
> > > >       |                                                            =
     ~~~~~~~~~~~~~~^~~~~~
> > > >
> > > > Caused by the resilient-queued-spin-lock branch of the bpf-next tre=
e
> > > > interacting with the "Enable strict percpu address space checks" se=
ries
> > > > form the mm-stable tree.
> > >
> > > Do you mean this set:
> > > https://lore.kernel.org/all/20250127160709.80604-1-ubizjak@gmail.com/
> > >
> > > >
> > > > I don't know why this happens, but reverting that branch inf the bp=
f-next
> > > > tree makes the failure go away, so I have done that for today.
> > >
> > > Kumar,
> > >
> > > pls take a look.
> >
> > I've sent a fix [0], but unfortunately I was unable to reproduce the
> > problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=3D 1=
4
> > as the patches require to confirm, but based on the error I am 99%
> > sure it will fix the problem.
>
> Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
> Let me give it a go with GCC.
>

Can confirm now that this fixes it, I just did a build with GCC 14
where Uros's __percpu checks kick in.

> >
> > [0] https://lore.kernel.org/bpf/20250319133523.641009-1-memxor@gmail.co=
m
> >
> > Feel free to cherry-pick or squash into the fixed commit, whatever is b=
est.

