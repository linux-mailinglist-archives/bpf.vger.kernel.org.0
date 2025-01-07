Return-Path: <bpf+bounces-48172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6122A04A93
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974311665E3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CC1F63ED;
	Tue,  7 Jan 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCA8EJw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B71E25EB;
	Tue,  7 Jan 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279727; cv=none; b=s2ede+vHisdmaT5rB0vpsI9iE7fwVTH/hpWwoxoQCmqW/SWSMyytLk2oYk7Nva/KSuHTqQxyDsoQW9zVafC+ikzAD+r/E1XIrp3vYoQe7l4dthx0O+rU8V/1gr+avBd0fOZVQy9bplkXfchZUtnlvFhAZYV2qc7+YIliVDnsU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279727; c=relaxed/simple;
	bh=L3mEZsdJtE1SvLeyxLcMWlR/r2bKK+0ntXF/gIrt55U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB3bax4dwn4Tz4lF4AEcasKu/LVqQk4v6qEj6SjoemyDSuT8sWSLvy7LwxtMUdaIni7UmLPsiiIZDRM82KKAXUNchHQcx+T5Fq9mO55QmxqFJBReKcNOLgn04PKSPZz11OlAWjeI/7vPfDH5RWjx+RGFIUYTI5SOxceyb6a38eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCA8EJw3; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5f2e31139d9so7179348eaf.0;
        Tue, 07 Jan 2025 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736279724; x=1736884524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xQPM8GlyvrYQL2ipNVH1pEAS9moSFslwHLjifYpbj4=;
        b=OCA8EJw3a5vcFFX9BLv6D+De0SYkOxd0cXT301S6tsfCPsvMIaHD3vE4xGuhsY6Rcb
         NTGMVH6fuTmZ/8KD3AXp6fVDGRwtJHKFnuFz65KdEcQTTqOMi3fl0ejZ5gcuEl1IPEQD
         NiwEbI7wpp954vxPyZNuOFfihwFyvSTttW9DTFdTnZ1Q+H33HfMoocVZsPUCQ+8PE2/H
         X/IDhaPMyOiOEaOHWnYcgqd6n1fexEy2Kr+udckjskCrQ1TG8/esgrBYux8RvXexsBgY
         k52tvIgOaBYU+oty7AwDlMwmesRIax16REAt0o85raUhAmv3lxgAPOvpReN16sfFQi2Y
         BHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736279724; x=1736884524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xQPM8GlyvrYQL2ipNVH1pEAS9moSFslwHLjifYpbj4=;
        b=ibO/Esyt1nDMqRyuYp7Kvo4qvxBjEMTb/DxQpJ6moRZma/i3xjgJO49LNSH015xGUC
         CwZOLk4C8HIl7dvL8/lkUVsbSGc1yrgzsqnYQ6h7p8WIEObM8awenZ0OE81kkaKgHnUg
         5FQ56fVGKZQQZ7Mwp4yLFtk4YsqlBeW+cfRk7dKDoDow9wA8FmIbFWbFAwuBJCzbapAx
         mxt8CsigMYGW0GIRGBtLIzrDxnYB9qCOub8KEmBmvnm6ZKhiDrqPuq9P2Ugsl7xg/ElY
         6T9swqigKvgis/G2sAH4BtqXJAqBZgB31Depvc6UXL5OY29qQ+GojKkE9kkrPnpnxFkn
         U3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV9P2zaEc1YNRcaa18SnI7V31llu3/0n6MLeBTE83syrX/amROvvhe8zflL0cyFxhUU++edBoXrSymIrx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFPPRu2c0Y26StmG8hB4vULPIMOy/5wrsk8pV/xHCe9a+KmCr
	wGCu/rWO3cIcsobmmJaAaM96BMigsvaAM9EDEifZX5kjmBdIEdXqxsGxkbWYY1j+Vg8E8suqmUo
	UG7lJ442pd5f80QGEz4kGMbOBoXI=
X-Gm-Gg: ASbGnctcaPqbJSvdrV7Htaonk/jE9y5kbyHDJdXtJvC/Oir/3XJbLJXo3+27ZyRQQkU
	Gh/r+bQn33giHyfzSrn/nXrntcBuFweZNnW9ne82ODHuri5g9uvev+oNKx0pDoJLjlxZk
X-Google-Smtp-Source: AGHT+IF8LAaZfHUGPsibyrZDMGXjaOEsDhZBhjbwBPjLCqCgjgeQ/Y+S/X2AjO+N7L930ALL+GNdnjcVDMI7C2vdBNY=
X-Received: by 2002:a05:6870:d0f:b0:29e:2991:d953 with SMTP id
 586e51a60fabf-2aa0673a3a6mr161175fac.20.1736279723668; Tue, 07 Jan 2025
 11:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-9-memxor@gmail.com>
 <20250107145159.GB23315@noisy.programming.kicks-ass.net> <CAP01T74SHdhtshm3iO_=+W4AHNQSZekJVKwaQn-Sr5up2apKhA@mail.gmail.com>
 <20250107191756.GA28303@noisy.programming.kicks-ass.net> <20250107192202.GA36003@noisy.programming.kicks-ass.net>
In-Reply-To: <20250107192202.GA36003@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Jan 2025 01:24:45 +0530
X-Gm-Features: AbW1kvYNDn-hwrVgbcJZYSxe8OVsnAj85VqDc7V-R4ClCrxolK1ZlT4SjpsDc8Q
Message-ID: <CAP01T75JPEFVYnVQhJ_Lv0F=oKoT7-LDEXeLoc2mzVv4Vvw9YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barret Rhoden <brho@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com, 
	Will Deacon <will@kernel.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 00:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 07, 2025 at 08:17:56PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 07, 2025 at 10:44:16PM +0530, Kumar Kartikeya Dwivedi wrote=
:
> > > On Tue, 7 Jan 2025 at 20:22, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > > >
> > > > On Tue, Jan 07, 2025 at 05:59:50AM -0800, Kumar Kartikeya Dwivedi w=
rote:
> > > > > +     if (val & _Q_LOCKED_MASK) {
> > > > > +             RES_RESET_TIMEOUT(ts);
> > > > > +             smp_cond_load_acquire(&lock->locked, !VAL || RES_CH=
ECK_TIMEOUT(ts, ret));
> > > > > +     }
> > > >
> > > > Please check how smp_cond_load_acquire() works on ARM64 and then ad=
d
> > > > some words on how RES_CHECK_TIMEOUT() is still okay.
> > >
> > > Thanks Peter,
> > >
> > > The __cmpwait_relaxed bit does indeed look problematic, my
> > > understanding is that the ldxr + wfe sequence can get stuck because w=
e
> > > may not have any updates on the &lock->locked address, and we=E2=80=
=99ll not
> > > call into RES_CHECK_TIMEOUT since that cond_expr check precedes the
> > > __cmpwait macro.
> >
> > IIRC the WFE will wake at least on every interrupt but might have an
> > inherent timeout itself, so it will make some progress, but not at a
> > speed comparable to a pure spin.

Yes, also, it is possible to have interrupts disabled (e.g. for
irqsave spin lock calls).

> >
> > > Do you have suggestions on resolving this? We want to invoke this
> > > macro as part of the waiting loop. We can have a
> > > rqspinlock_smp_cond_load_acquire that maps to no-WFE smp_load_acquire
> > > loop on arm64 and uses the asm-generic version elsewhere.
> >
> > That will make arm64 sad -- that wfe thing is how they get away with no=
t
> > having paravirt spinlocks iirc. Also power consumption.
> >

Makes sense.

> > I've not read well enough to remember what order of timeout you're
> > looking for, but you could have the tick sample the lock like a watchdo=
g
> > like, and write a magic 'lock' value when it is deemed stuck.
>
> Oh, there is this thread:
>
>   https://lkml.kernel.org/r/20241107190818.522639-1-ankur.a.arora@oracle.=
com
>
> That seems to add exactly what you need -- with the caveat that the
> arm64 people will of course have to accept it first :-)

This seems perfect, thanks. While it adds a relaxed variant, it can be
extended with an acquire variant as well.
I will make use of this once it lands, it looks like it is pretty close.
Until then I'm thinking that falling back to a non-WFE loop is the
best course for now.

