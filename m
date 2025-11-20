Return-Path: <bpf+bounces-75193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB54C7660C
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CC5EC2B655
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F995309EE0;
	Thu, 20 Nov 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5LaptT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC023074B1
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674038; cv=none; b=WZAbO04s33nm+mu9B5qPcXRas1yKFQathyFYrrHtP2VmBlEGrB5lOTYwPQVSEdbM/uSL0gkP2wHxObtxWPRLUpDTr8vlBQx12cky27ZkxVhfL94UoeFLTQ5RmhwmwT/RcYS1nh+c2/0tw/xzdxQ0s0uEQkadWVbUVwO4iw7AxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674038; c=relaxed/simple;
	bh=tK/h47AtclL63MsiZIw5DLkxiAtWxUM5WBuqmUYCwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNeUHP8uds8J3ieZ1TJzpteQSKBwCuGysLhueQD4oZRlO00gEouMi2yT2Oin5tbGId0btmZx/tGh63AlyRSa2WdCjabq8/LLd2mv9WDFvBGQ2ctdegWBsV3HisJuQ8BaR2Bh3sYAaXlEhvFjbPPcbf14O3g3Z9YnxdcGNz9VTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5LaptT0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so13266785e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763674035; x=1764278835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa7KQe8aI04mw6svA4KQsLLzNLWFcPgdOgxNPPV4Iks=;
        b=c5LaptT0eaa9zxmP8xtUATMo/MZgv27A4XQmGpCIuvJqzxESAPOBkhZ29IZe40f0IO
         y/P95uGCsa1rm0kdQ9MukucZ/M/q49F8ovXkfOWs33yx+G3hNrCVPlN7Fsza/DUEdRU1
         LflsA4NloCoECLcQy81Ot8hallv035W0YuMAZs/PA6MMXIa301DQWrbp/zo/1nAPMxGS
         I8MKksFBlTSvyk7MlEnGMhLp0+AcoSl7orOMux/9iXubawJNy0RpxEE5vYj9vhcOw7uf
         7koyf+bOvueadVtJszlVx3ZTxXf1nhr+g1SyhMGbQmgKWmCNcoOC9pT8PUlID9gaZIwy
         Ozng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674035; x=1764278835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xa7KQe8aI04mw6svA4KQsLLzNLWFcPgdOgxNPPV4Iks=;
        b=dtRsItyIQA0d+h2+o7ZoUutfziuLf15gfVFOvezjhZ4jhf1bt7bcbmGJd4kz2H/tRF
         AQiK77uzm0bSDwgBPe0qZO5B37Yk+pUd7OZ1U63CknOqTI66352IZmlu52ER6XVgQjo4
         6887gAYPNPyI1dF3FaAs3CxDSmor7NS8TkNgmmL9g7WLv7yM1JcZqSxizxEkowVGtusW
         A5IfDZmenCW6OFkHnPZWg7HcV09Jht22uySm4EFRvLnP+DOyT+HGKGp14ien8fEsarkr
         0JGXb0KpO9PuBEfWfiEJkivKujlwoIuIa2YnLSv9CkckT//iPp7rHz7lalU4RezTz2tl
         8Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCXf1jf2WTmPjkoRk6rB9jE9WhVxuZdS3HAtvZwKhpkR1G7DKyB9XwL6exH8WyZ23v+voGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeEcQqLow7X93iTkR/KJ3mz4KTdsloiwSll4UWer7FfRSyVbB
	dOSdvIsg0A1wdCQS0p9tbJexyxq3dKPHND5pu9t1jtmOSiAbK65zmI4v
X-Gm-Gg: ASbGnctPdvFYiYOwMGljAGvdAJi7EmLRT+RiKrcsMKdaFJE/MTRm2Iad14tkZ8tbV8a
	1JPhT/sM0Fm7uXNjEg/FAS8t3EMgAf4Ev2YU8jvOB0wi0xRDRG4NuAlBHCDbTSL5nh8AAendqcS
	2y6FaOxjqBbGrkCmrxqtcIMZKciETxngZ8a87YGrq9Tc1Nvh5hNq4WH1mRtiBjfWVN2FPNmPkJZ
	yl+SpxILduik1pMT1ecilwSDxUH2/9/JQAZcn7xTI+5gFZA0Hn6Pfe8JIGvZoXJ2/sLfVjXOYs7
	6lwqbMLFKRffCy+TKioErgmvfVLLEI82a5Ns9eJG7zNgPAZDC8GKZ9KBDyGNhKA/dPhhDjs1S9r
	/by9N3Mb1XjiX11JLbjPRnYGFu2COzQ//3U91CkrydXnuY8psfev7qEN3RAu55Lq2NsmhMlzp+J
	NymTeanVmB3VV30h+lMseZJaCpeTKcpJ9OBfZMzP4+pMVvfG82lXwV
X-Google-Smtp-Source: AGHT+IF/A6M/582nmisb9bdwvtoe3obapWUpVz79PqZr6Va3/ErJUSniRW0f/KHs/h0vZr1g/U6e/g==
X-Received: by 2002:a05:600c:1d01:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-477c016bbe2mr1282195e9.6.1763674035188;
        Thu, 20 Nov 2025 13:27:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cbd764dbesm4251621f8f.27.2025.11.20.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:27:14 -0800 (PST)
Date: Thu, 20 Nov 2025 21:27:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <20251120212713.240fa185@pumpkin>
In-Reply-To: <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
References: <20251117191515.2934026-1-ameryhung@gmail.com>
	<CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
	<20251118104247.0bf0b17d@pumpkin>
	<CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 12:12:12 -0800
Amery Hung <ameryhung@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 18 Nov 2025 05:16:50 -0500
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > =20
> > > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:=
 =20
> > > >
> > > > Locking a resilient queued spinlock can fail when deadlock or timeo=
ut
> > > > happen. Mark the lock acquring functions with __must_check to make =
sure
> > > > callers always handle the returned error.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > --- =20
> > >
> > > Looks like it's working :)
> > > I would just explicitly ignore with (void) cast the locktorture case.=
 =20
> >
> > I'm not sure that works - I usually have to try a lot harder to ignore
> > a '__must_check' result. =20
>=20
> Thanks for the heads up.
>=20
> Indeed, gcc still complains about it even casting the return to (void)
> while clang does not.
>=20
> I have to silence the warning by:
>=20
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wunused-result"
>        raw_res_spin_lock(&rqspinlock);
> #pragma GCC diagnostic pop

I think the simpler:
	if (raw_res_spin_lock(&rqspinlock)) {};
also works.
But I'm sure I've resorted to crap like:
	x +=3D foo() ? 0 : 0;
and/or:
	x +=3D foo() =3D=3D IMPOSSIBLE_VALUE;
and/or wrapping the call in a static inline function.

It is all a right PITA when you are doing read/write on a pipe
that is being used for events.

At least no one has put a 'must_check' on fprintf() (yet).
Code that looks at the return value is usually broken!
(hint: you need to call fflush() and then check ferror().)

	David

>=20
> Thanks!
> Amery
>=20
> >
> >         David =20


