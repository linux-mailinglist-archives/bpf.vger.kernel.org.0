Return-Path: <bpf+bounces-50840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F259A2D35C
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 04:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14899169B30
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588551531E1;
	Sat,  8 Feb 2025 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZcvAdk1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA32913;
	Sat,  8 Feb 2025 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983858; cv=none; b=K95WHaVvGKpfeL5RJ/+sI5iks7v+pQVE0mzkOO7GcVSDTseAWBdKXaayg4AE15sO+/GJBK9L9k8jjyYG9eqa5065DA/zYmVXc7QrZhJD0E7niDcVPFvifuENwtTT5W3B1gE2i02YByoPPNMYJWjq/yG2N3gi7k4co9zU4XM1tsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983858; c=relaxed/simple;
	bh=HxxbTdmm+TibAeqgcfMjuxXWZL7KynZF8XeEc08iYBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOIQcsDoErkuZQrL3BEH2LSa3vFZUtIEibx8BauLEUq0Vbv6fpF4kblTvfGjuMpsSFXY9Nl35yFp97atxGAQ+8HqCJdLV78Pv3gi0zqkV6/LKtj8BaD5uwTl92l9Bmn2pIwU89KJvdryMHeLWm4J7gievo+8nJIDJkAr5XIvkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZcvAdk1; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5de5bf41652so554000a12.1;
        Fri, 07 Feb 2025 19:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738983853; x=1739588653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjC+K99sHuLBC1SWOWdiNm+irY8tDwRsTBF9CpEJdmk=;
        b=BZcvAdk1ZLjIcO5NOYQj+Rvj1pM7U2iwc5vzGebDNZ2ZmnD2hEtVewpSioxSJ1icmF
         wnK8AtITxz0xRuIDyKNmgxvXOdNnh8LqPe+vcgSV+B1WaydFhWTsAUFy6gwpBda5+Oki
         XKQXs1lxp5N87LJ49Yd/Ev66kBKRFbwTlGzesd/LNmUR7C7embJeoXYSpkg0psewYaKI
         Udrexng+94U0nULkCY8FE4d36kPyptqxdz/cH/s/8TDKx8ucWFA6FclQNgu3w7Mc8byr
         E5GQMheaxGWzRrXe9iRHtgE6legmosCcI/mAJsvsTHJwAJyU6lQfTvcUWPRzFlVT19/d
         D+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738983853; x=1739588653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjC+K99sHuLBC1SWOWdiNm+irY8tDwRsTBF9CpEJdmk=;
        b=BTF/i3vuOevOFF/tXhWljm4H0CQwU4X6xCLJCAWmamb+ZsBv8pieLWvh8aEXQGhkpk
         Gdvd3iSACrgWYWZ/g+SkN8PdkhtcKM6q92cbufwy973oEt9lKyHPMsGHxJ8qQEHK9T9j
         +1sFdwWDtoqss3XgcDVJzyAZR5cTTlrbXY8B2kVQc4OjlV2iOxP7pNAdXO0DFoaqWuVO
         iR7aR/f92VsqJP5TCRMgyOQB5JGt86fT4eH9OIG3/9fFMGdQW+e9BXlpav+pInIGPRyO
         tqnNGXG3b+ezfrxYaYxEp4nRAIGr8oeecDZQ53rJvaODCALxpx1qtIjHZhTTXQaEfYgj
         r70g==
X-Forwarded-Encrypted: i=1; AJvYcCVVzsqMoPbiVdA74vJ2RszWAgq48YaGBSyyfwjpkINbLlFZGRmMDXCFNftX1oi+DgTR+RdHLaz8vwFmgVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2zt8RSuFjsMcFWbDzFGoicVKSZqu1KsRu8Vs28p2Cz310ocP
	JcUG5pxLfEM0b+++n4nwC2yTfeE9xIn0WCdzqav5M7yjIK502bLPFmD9ETEGHkHI3vKm6+NgEcy
	MUARtlIBzgzyHRVs257y2uRorwYQ=
X-Gm-Gg: ASbGnct6jOr+m8bRpCkMUUUNj4bwPPSKw/CPAMbAIW10sbHO3Vnyj7dBWx/DrBlcv/P
	ANAnMRNyu2aSBWIXoAnfCKuO4C9LnCqX4lCGF1rW7iBqEUt7rQzOtgObDhhC/pEWURt8jiFE9eB
	Y=
X-Google-Smtp-Source: AGHT+IEpffqioYc8FzNyaf4qBzxtDg8xfAqMVbDjSBfvR4Oecfrwg3Vz7TAhEDmRxRydbVIiW+4rwwYQefd9K+hSBv4=
X-Received: by 2002:a05:6402:194b:b0:5dc:7fbe:730d with SMTP id
 4fb4d7f45d1cf-5de44fe9d71mr7386616a12.6.1738983853264; Fri, 07 Feb 2025
 19:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-12-memxor@gmail.com>
 <CAADnVQL=E3F5-Uwa5_508e+OKzLnLGJGtAMhv1WW8kHobzBMgQ@mail.gmail.com>
In-Reply-To: <CAADnVQL=E3F5-Uwa5_508e+OKzLnLGJGtAMhv1WW8kHobzBMgQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 8 Feb 2025 04:03:37 +0100
X-Gm-Features: AWEUYZmo5Th1l7iYtvIDvAaFSUXU6ssq4vkO0stPQeynM7x5qg3kIxSA0EMK9Fs
Message-ID: <CAP01T77XaGH=EDc=m2uL6gLWCM8jm5ycPgmZavXnThpDF6bY8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/26] rqspinlock: Add deadlock detection and recovery
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Feb 2025 at 02:54, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 2:54=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > +/*
> > + * It is possible to run into misdetection scenarios of AA deadlocks o=
n the same
> > + * CPU, and missed ABBA deadlocks on remote CPUs when this function po=
ps entries
> > + * out of order (due to lock A, lock B, unlock A, unlock B) pattern. T=
he correct
> > + * logic to preserve right entries in the table would be to walk the a=
rray of
> > + * held locks and swap and clear out-of-order entries, but that's too
> > + * complicated and we don't have a compelling use case for out of orde=
r unlocking.
> > + *
> > + * Therefore, we simply don't support such cases and keep the logic si=
mple here.
> > + */
>
> The comment looks obsolete from the old version of this patch.
> Patch 25 is now enforces the fifo order in the verifier
> and code review will do the same for use of res_spin_lock()
> in bpf internals. So pls drop the comment or reword.
>

Ok.

> > +static __always_inline void release_held_lock_entry(void)
> > +{
> > +       struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_l=
ocks);
> > +
> > +       if (unlikely(rqh->cnt > RES_NR_HELD))
> > +               goto dec;
> > +       WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> > +dec:
> > +       this_cpu_dec(rqspinlock_held_locks.cnt);
>
> ..
> > +        * We don't have a problem if the dec and WRITE_ONCE above get =
reordered
> > +        * with each other, we either notice an empty NULL entry on top=
 (if dec
> > +        * succeeds WRITE_ONCE), or a potentially stale entry which can=
not be
> > +        * observed (if dec precedes WRITE_ONCE).
> > +        */
> > +       smp_wmb();
>
> since smp_wmb() is needed to address ordering weakness vs try_cmpxchg_acq=
uire()
> would it make sense to move it before this_cpu_dec() to address
> the 2nd part of the harmless race as well?

So you mean, even if the dec gets ordered with inc, the other side is
bound to notice a NULL entry and not a stale entry, and we'll ensure
the NULL write is always visible before the dec.
Sounds like it should also work, I will think over it for a bit and
probably make this change (and perhaps likewise on the unlock side).

