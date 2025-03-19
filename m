Return-Path: <bpf+bounces-54373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC339A68E24
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 14:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623C44258B6
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED412258CEE;
	Wed, 19 Mar 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q64Fv0po"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE321257AE8;
	Wed, 19 Mar 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391869; cv=none; b=EJoQ/CUVq7vj9X+G79SOSYlWZw0FTli3HNLlJC9o1B7+PXLyTzslmuqnDYtePijz5gAy3gvO1rLpZYmBNPH5/+DamTx7n5XifKNwc9qKXHQrlNVC5BYhWBUK5ICZhXhCuB6Yzuu927CP2zy5ll1fdHweEgXePNYe9mM9l+hIoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391869; c=relaxed/simple;
	bh=TDb86smUbcuAHzkojHnX5nlb7Pmx7GHlODr8IaE8ksw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA43nqXlHDxEcy2KWQ3QbbGvmw0ad53F3zaNQvQo7dipiqAj4skbpI3kry73f1iyYbHfee9EaO4Dg2qikyiv9eTo2SyrOivsaY/970DIKmWsYS/US7xuA4KZNOWrcpoWGQidsZNsd48/lpqrT6rwSJbLOJC1ULHaZdCm+is4+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q64Fv0po; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso3309516a12.3;
        Wed, 19 Mar 2025 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391866; x=1742996666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mXlb6a7wFUcGS5/U6F0ptMpwT27VxURkPFmORF1m1s=;
        b=Q64Fv0po/yLHRaODmyUKVuYmmyWdFHC7tm0mi0Mmh1kTpSeW/PdkFwY/kYd1rWFQOF
         xTAtE2QSXGQpf1xvQ9Zz+dqhs1GroKkpvKqdPQ2RWP0o8OBfveBACxUG521ap9HH+EPk
         o29kfT8psPZJwpncJi1OhUa20LtmLaQWG+TLBgwO/3lN/YToK3CMmK/i8brcnDlHKTkC
         721WZkf5VQTVEOSOKlu1h7xDugsnWe06CByHZK9eOdycDR+ItYEk2r14jSMFgJLPvkfQ
         0aDEeqO9O311vJO07NmRiinupr7WrYlx3g9jW9dhqD6OVaoKOQst1Om4ESPX5aziGhfA
         eR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391866; x=1742996666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mXlb6a7wFUcGS5/U6F0ptMpwT27VxURkPFmORF1m1s=;
        b=GGuqReUFqrDVXcUvj0zDiT5C7ikwLencBQKn5F0vnbs/t6arf67U28BbeuvTpRpXTz
         iHmdc+hkpUX0TfKH6QPcwSwgCI9LPmrIqXuj/H+qQQgD0drK8z/ZkdDuLbypPpOffyj2
         U+A40/EEDqpnSw0rIuN4kcqhWup8u+gn5Y2HcSaOMFWJwZNu/KdA+NeLgLSdqbPDZthe
         v53WG8lweRsLKapW6gWKIA2C6o9sEeOhYmyak9FKMhFa/TdzQEU7jW0feXUWBRB4XZ8g
         lYkUvcpUMhEQxFOapX7NDfm9Vr5p4LdmKRb2+LJRIoaMN1H5dDNVrZ4ENaeFjDS1FKmd
         36Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWVQdpTfhcY7Mq2cdCCpSSa7wSa+d0SrYsMj8YKO9RSGEZvGRGWbyufk8iNNOFGc6mY5nFf4Z1kKZrQ==@vger.kernel.org, AJvYcCVhWPdmZWoYCcBftcI+/ZX2wmgREKKwDuToAiwTWcQOj8YTZD/2Ts9Gzm8NjFMdft2WJhHgr/EP0yHGEKk4@vger.kernel.org, AJvYcCX6MsQTp1u00EqJuam1IE4rbqlkHX9CwvJ5OU4VzrCtYAetFXekYHgjAaxFgnNdc/w5E+5fMZbu@vger.kernel.org, AJvYcCXcYFfRgPKOUEfYRIuQy5tKJeH8A/A2UNkfbrQSyfg5G8UYxtCLZUVAQ39otQQXiSNUtbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHh/ucw7YxSSDhFvxwydVRZuj1Y2vCuDYeZzOHGWT5wkW627l
	UHRH7cmib8w56uEsvZiXvXbKJdGcp1YVILffwssoBzbTZs5LVQRfnrBIE80IKt0LnOKkSzr8iYE
	Pr/zUZK7a2JyKDH93u1bZm5ama/o=
X-Gm-Gg: ASbGnctNe5mbLKsIKto+RHO/XxTzxdzPlShqIuacFzqFoeC926UAH5jry7X5gzCUBFY
	9omwuw68D3t5n0zyz9VkXbs9OIDdXSVBoCZeu6qqIz88MPoZCBYdVWZ7m5Z8RkrwOwMupemXgJZ
	v1r0eQ49pClArMeEa7HUZo6L2+gdb6ULUOkXsuxGIB+OuaHiROOk2wMtwlSA==
X-Google-Smtp-Source: AGHT+IFvLDrujM4yKAhdVi/UGZ4FMBVm3U5A8tMGhKLXP+Vn0Nro60u/TCHTRqq54AuMeJ85qLrOfDUFmFrSFEmOtec=
X-Received: by 2002:a05:6402:27d1:b0:5e0:9269:f54e with SMTP id
 4fb4d7f45d1cf-5eb80d445aemr2559225a12.14.1742391865910; Wed, 19 Mar 2025
 06:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
In-Reply-To: <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Mar 2025 14:43:48 +0100
X-Gm-Features: AQ5f1Jpd6YH1vfPNEBHTXM5D-u_8RSvaQE7lO7NTwVB3SOWOBMMLAPn6u9zE8xY
Message-ID: <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
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

On Wed, 19 Mar 2025 at 14:37, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Wed, 19 Mar 2025 at 03:47, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 7:33=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the bpf-next tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > In file included from include/asm-generic/percpu.h:7,
> > >                  from arch/x86/include/asm/percpu.h:630,
> > >                  from arch/x86/include/asm/preempt.h:6,
> > >                  from include/linux/preempt.h:79,
> > >                  from include/linux/smp.h:116,
> > >                  from kernel/locking/qspinlock.c:16:
> > > kernel/locking/qspinlock.h: In function 'decode_tail':
> > > include/linux/percpu-defs.h:219:45: error: initialization from pointe=
r to non-enclosed address space
> > >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) +=
 0))NULL;    \
> > >       |                                             ^
> > > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__ver=
ify_pcpu_ptr'
> > >   237 |         __verify_pcpu_ptr(ptr);                              =
           \
> > >       |         ^~~~~~~~~~~~~~~~~
> > > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cp=
u_ptr'
> > >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> > >       |                ^~~~~~~~~~~
> > > include/linux/percpu-defs.h:219:45: note: expected 'const __seg_gs vo=
id *' but pointer is of type 'struct mcs_spinlock *'
> > >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) +=
 0))NULL;    \
> > >       |                                             ^
> > > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__ver=
ify_pcpu_ptr'
> > >   237 |         __verify_pcpu_ptr(ptr);                              =
           \
> > >       |         ^~~~~~~~~~~~~~~~~
> > > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cp=
u_ptr'
> > >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> > >       |                ^~~~~~~~~~~
> > > kernel/locking/qspinlock.c: In function 'native_queued_spin_lock_slow=
path':
> > > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'deco=
de_tail' from pointer to non-enclosed address space
> > >   285 |                 prev =3D decode_tail(old, qnodes);
> > >       |                                         ^~~~~~
> > > In file included from kernel/locking/qspinlock.c:30:
> > > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but=
 argument is of type '__seg_gs struct qnode *'
> > >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tai=
l, struct qnode *qnodes)
> > >       |                                                              =
   ~~~~~~~~~~~~~~^~~~~~
> > > In file included from kernel/locking/qspinlock.c:401:
> > > kernel/locking/qspinlock.c: In function '__pv_queued_spin_lock_slowpa=
th':
> > > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'deco=
de_tail' from pointer to non-enclosed address space
> > >   285 |                 prev =3D decode_tail(old, qnodes);
> > >       |                                         ^~~~~~
> > > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but=
 argument is of type '__seg_gs struct qnode *'
> > >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tai=
l, struct qnode *qnodes)
> > >       |                                                              =
   ~~~~~~~~~~~~~~^~~~~~
> > >
> > > Caused by the resilient-queued-spin-lock branch of the bpf-next tree
> > > interacting with the "Enable strict percpu address space checks" seri=
es
> > > form the mm-stable tree.
> >
> > Do you mean this set:
> > https://lore.kernel.org/all/20250127160709.80604-1-ubizjak@gmail.com/
> >
> > >
> > > I don't know why this happens, but reverting that branch inf the bpf-=
next
> > > tree makes the failure go away, so I have done that for today.
> >
> > Kumar,
> >
> > pls take a look.
>
> I've sent a fix [0], but unfortunately I was unable to reproduce the
> problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=3D 14
> as the patches require to confirm, but based on the error I am 99%
> sure it will fix the problem.

Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
Let me give it a go with GCC.

>
> [0] https://lore.kernel.org/bpf/20250319133523.641009-1-memxor@gmail.com
>
> Feel free to cherry-pick or squash into the fixed commit, whatever is bes=
t.

