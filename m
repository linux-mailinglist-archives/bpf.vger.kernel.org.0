Return-Path: <bpf+bounces-54372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5CA68DF1
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73AD1779C9
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FB2571C4;
	Wed, 19 Mar 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2QwVYVL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC3A29;
	Wed, 19 Mar 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391504; cv=none; b=CmVJ/9+lL1CsjNCyLBuohN5JLAKuD8Bx/kCcC0aPOKj+p8LJfiXO/QUJdzdphcyUO/NFxgOorDWUkPPGfkoyESqQR/n9+RaKrEk9ey/w8WFzGvdXtxIhlD/eZSoryd+wWXB44Ankjeq+m2M8m9+kafykh6mOPE+RjhocietW4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391504; c=relaxed/simple;
	bh=MVYifdB7XOuUZcXrnEyxQSRe1sXNhjSse7qEoJppzFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6fH4avC/8RSAN/ebwmtm7CoF3SKjiVGDEDC925O8288Hjwyk1T2CZLO1LHvKo+OQEVBWIiAD5UjBG44dmouuQsuBsqroOTpOF1IBbMO9u/xwB87WpZWkONO7bZCWTobzWTFu/gRLamJTKYQEdhjNwapta6fez6lXURT3aqAf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2QwVYVL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9661974a12.0;
        Wed, 19 Mar 2025 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391501; x=1742996301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqOX5J/2aBI9WMJbR7g5ITJy8xJzcYpINmhYecXAw4A=;
        b=a2QwVYVLB29oiyJIcmoKjwgPzb8LOfAxACk8wDOjmmN9y97Cy/VnqPkAOW9iPJXjiG
         xJibqAwgAfvA9wyvwJfN8OXYY/BihvyCuhX8wSllqsnoqcsNM7UeIgCnGeBHMOaQge9A
         pQ3zWaAyajUHX1Q9S2lE3kzlB6Ag1DnJVCn4L2k+MVzmj4VDFCsQfSI8h7kdAlBF6UKa
         JekLoQD0eEd9yUqIoUXrmhopOXLC+jG8GlnNlB861hRyyATndmKqSI9jC4Y9M65x3b68
         IodLu3KXvd6ykxk7P92RrtfLDVGb1thzKcGd2RHFNWSo/6v3E07/Elc0ACHIMCTgnfnX
         Qwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391501; x=1742996301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqOX5J/2aBI9WMJbR7g5ITJy8xJzcYpINmhYecXAw4A=;
        b=rIpKH457mVGZp/H+aAWPJyvysAzRHYtCEuJyiuGOOovLgeRaldWAiS4toYc1rDq+PL
         rU3qvWEKcd1wmwKn5V7aQR+mZ2YGGnNU76rVC5c0CXGFhUgDw2lSMJKa8Bgu8ZigH7eY
         QVXdFlQd5+cCkEMNUBm2Ia/Jdk3t3IMZXGYQes/L8UUyiX7dq8VOd/xQjHApfOSXlYEw
         hkutOHOcdT8x38kdakFJjXpIaBFNXRET+QBgrp772KTdoebUQ//7jKVzsTmIztAvMzN3
         JSTFXrS/iMiiRY2VwGiu+tRmgoG3xddjfOMkfg5yYV3sIYBYShfrlSUYfxAUAMQ0XaEc
         nJQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZEupuAufl/eR0sHVmhqaNMC4ZWf8DtbX0iO4rPnq9HP0raD3YuHyoFlnXrPqClD+HJqc=@vger.kernel.org, AJvYcCX3Aur9YlzORo8L0oPAfTPDnssA7C49Tg27YJKrau47wcifgabZwsaTvkYZ0jDs0D9ZXHCoU8L+@vger.kernel.org, AJvYcCXVMeZmWvwZA5k2sNIFGSyehq7T9Kimh8q3fqKOgKYDOiT3zMNbN9CMzKDslmB86sP/rmmcVO5eicEmI0po@vger.kernel.org, AJvYcCXZLVrxzPAAHi3H7fKBILdt5UChYnDD3v9mcuu3rnBaXTtuEWifhhq5vRQjCBjLhY9X3v07etr4Y7oY7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwosIKg6f+KZjMY5cWOFHKuDWd44nCb6AjD2qv76/MNS2EBxIC/
	XU+bvZaj6lBTaF+vqyi7fRpuhpsQS+Qnr2+cpae4Iboa3Wen94Kuyq7aSUJuUTPYQbCvKDo09r5
	JITPZ5rspKiBr4u651wwBRZMhObs=
X-Gm-Gg: ASbGncvTIadj65t1SV4JfhNbCKwekcFaJ9ymaZ/f5U88xH+IiS3iaKcnuiSOFjTulWE
	ED3gXv7DaEqUXkKs3NFJTeWLrhgQeBMjqRiJV7lEhp/xuj6kzV1L9rxcKmwAa0TJTSCaIpzNvD6
	KKJUQ8DPG3Kqgl9VhZEG4ZyprhP6s0MXSNT634HQ70wA4VxDE=
X-Google-Smtp-Source: AGHT+IEopwlgS/uGtIuW38Wt1GbJxJdW6CbLjbQidRV3omH5LwTommPvAkrNEru76Gt4bFdCp+qRaShE72Bi/4KSqA0=
X-Received: by 2002:a05:6402:5245:b0:5e7:c438:83ec with SMTP id
 4fb4d7f45d1cf-5eb80ca9a18mr3269824a12.6.1742391500245; Wed, 19 Mar 2025
 06:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
In-Reply-To: <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Mar 2025 14:37:44 +0100
X-Gm-Features: AQ5f1JpjZkB8zJ9kdtnAIEXxqGeb9vv4mNqsW9hZ-9htSXwm37U6oY9UIAC0GQU
Message-ID: <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
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

On Wed, 19 Mar 2025 at 03:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 18, 2025 at 7:33=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > In file included from include/asm-generic/percpu.h:7,
> >                  from arch/x86/include/asm/percpu.h:630,
> >                  from arch/x86/include/asm/preempt.h:6,
> >                  from include/linux/preempt.h:79,
> >                  from include/linux/smp.h:116,
> >                  from kernel/locking/qspinlock.c:16:
> > kernel/locking/qspinlock.h: In function 'decode_tail':
> > include/linux/percpu-defs.h:219:45: error: initialization from pointer =
to non-enclosed address space
> >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0=
))NULL;    \
> >       |                                             ^
> > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verif=
y_pcpu_ptr'
> >   237 |         __verify_pcpu_ptr(ptr);                                =
         \
> >       |         ^~~~~~~~~~~~~~~~~
> > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_=
ptr'
> >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> >       |                ^~~~~~~~~~~
> > include/linux/percpu-defs.h:219:45: note: expected 'const __seg_gs void=
 *' but pointer is of type 'struct mcs_spinlock *'
> >   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0=
))NULL;    \
> >       |                                             ^
> > include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verif=
y_pcpu_ptr'
> >   237 |         __verify_pcpu_ptr(ptr);                                =
         \
> >       |         ^~~~~~~~~~~~~~~~~
> > kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_=
ptr'
> >    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
> >       |                ^~~~~~~~~~~
> > kernel/locking/qspinlock.c: In function 'native_queued_spin_lock_slowpa=
th':
> > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode=
_tail' from pointer to non-enclosed address space
> >   285 |                 prev =3D decode_tail(old, qnodes);
> >       |                                         ^~~~~~
> > In file included from kernel/locking/qspinlock.c:30:
> > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but a=
rgument is of type '__seg_gs struct qnode *'
> >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail,=
 struct qnode *qnodes)
> >       |                                                                =
 ~~~~~~~~~~~~~~^~~~~~
> > In file included from kernel/locking/qspinlock.c:401:
> > kernel/locking/qspinlock.c: In function '__pv_queued_spin_lock_slowpath=
':
> > kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode=
_tail' from pointer to non-enclosed address space
> >   285 |                 prev =3D decode_tail(old, qnodes);
> >       |                                         ^~~~~~
> > kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but a=
rgument is of type '__seg_gs struct qnode *'
> >    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail,=
 struct qnode *qnodes)
> >       |                                                                =
 ~~~~~~~~~~~~~~^~~~~~
> >
> > Caused by the resilient-queued-spin-lock branch of the bpf-next tree
> > interacting with the "Enable strict percpu address space checks" series
> > form the mm-stable tree.
>
> Do you mean this set:
> https://lore.kernel.org/all/20250127160709.80604-1-ubizjak@gmail.com/
>
> >
> > I don't know why this happens, but reverting that branch inf the bpf-ne=
xt
> > tree makes the failure go away, so I have done that for today.
>
> Kumar,
>
> pls take a look.

I've sent a fix [0], but unfortunately I was unable to reproduce the
problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=3D 14
as the patches require to confirm, but based on the error I am 99%
sure it will fix the problem.

[0] https://lore.kernel.org/bpf/20250319133523.641009-1-memxor@gmail.com

Feel free to cherry-pick or squash into the fixed commit, whatever is best.

