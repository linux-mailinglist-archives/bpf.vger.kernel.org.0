Return-Path: <bpf+bounces-69755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042FBA0D79
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC74E1BC2521
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191D30FF30;
	Thu, 25 Sep 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2FOppdA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739630CDA2
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821324; cv=none; b=oduAMwAyGB110hnQgjVO1LwKZlDpZyBuAJLPc7DnnS/yLy5y8f6tmPKh5MnXYN7abhagISjMrlyZUSJPxH/CcwqqPA5qb4oNI5IV+Zqy/+c+q7REtx19Swunm4ycGdGEIcdRo4jwC6ubJD+Z1B/7zleIsLpbOdKDP8UA8SvD3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821324; c=relaxed/simple;
	bh=rOcf7syoHsIouvlswXay6faEtX9NiT5q5lhurDm9gxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaRCMIbIN1aou6fED4UGH/DYFMYT3SZoP1jC2uiMWRZGU0nSbI5Q404IcGhHBvf2LJJ0WKDvrCKe08CiNQLTrMmghTiwbbWio3qY1gY9PorMBtfJnghZAfzHtfn0Y9tWEskLutFwP72qc6aq3IfWb796MBRUEUDb8NKUJ9WJ52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2FOppdA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3352018e051so650267a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821322; x=1759426122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps1znGvbkVaXEVnKByBRiv/UuQfRsE9vw1c5JC/YArg=;
        b=d2FOppdA71KPVxL4yqVq0J17ketd9frW1ZFNY36rDd6h3QPd1vb1/3RRuw5Nr2heoV
         MBJQJqV8QGHt0GnbY/RygyLJlHE0dUUsXpDg/UW2qcJugWwzC87F0l/Xug/EmzdkpYzL
         QmQf5MZvxY2vR6tc1ijaNatih0Gb1lapR5Mr8/j98y/czntxUlZ+HUuqODHI21DQ2aqE
         JlSZU9AdzK+gLJnd8yOReBuHhobTtLLZTn9mPKpIa4tGpOduFm9vVe/8/FiY+jTUIsbQ
         vG9880L0MiJh/b5nMRMcbWrV9me3khSxMVHSEZfG9G6veSD2w1Akfnj60SEN2qH95DbW
         yTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821322; x=1759426122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps1znGvbkVaXEVnKByBRiv/UuQfRsE9vw1c5JC/YArg=;
        b=OVqo/XxKIfn4OtdwmevTEBROw3/KiEEkxi2Iy6x0bMApLiCd7X5fVHHv3gQzC4l26d
         hkMojGT+N3q/fvvxMtm/+Sb9YG1ugSeA1QJcp/OMINtvohlmrr2RkcQISW1BzYm0itQF
         4NVIMMidTszwcgMH8g8oF+0jRXB3l4aXX4Tx45E2LNxrHnr4FIjsod/CMmuQFHvJ7V+C
         vKaedRpWP7TWPHLLQbRsfedA8c8yTdxM+nibh7JUPxIp2JpJjFdLk8EbQVzOoh3jx/b/
         9OeiNO2XayXojYLRoQpYydt02m40P8XoY/32VziA1FyzwMxGKnShuY6fGIPqe87+lkao
         9NSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVlY3FM6fZPswBXrK7Cd+ar9aG9uUFehQdnfQtfc8GqC9cOdMxY+TmUzfFEp0QoWGCwlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+66R3nDditDtN8O7wttBJWutQaHjZ4AFFj7buIH8WPKeiPGrq
	HS6xxVRHw9CLqR4larYHW/MFC0/LqI1LgsynHJNfSwxZ/EOCG/zvS27tlygd3zQv4RZx3/E9Wu8
	IYldctbr9ltXKgkdVHAnf4Hw1X5GBEDg=
X-Gm-Gg: ASbGncv1fN20c9Ba5wn/dJrfqX1h6nBpsXLEKTJqZXxHzWWPuKXzEADUCqT0/B2q46k
	NmLoCIQ3RR3IMHo4MsT1PxPk+UZLoev4X3YwG1lIVwBoHhZJXdG9kzYA1S3H1yebmb2TOLbESja
	+qEi+FBZVl3+V97cyw91c38X8IWDySuypuBuvV2UHmdxf8WCT/NdkgkDkhNHdFaP/UoaCrrQgPf
	jyN7Ymb6DL2kXQaWrM1ufo=
X-Google-Smtp-Source: AGHT+IERtJP4yKArjLd7Spfh81zpMovZaA2mNRIPJ9EYwYqEAhNv01fojMGCGP2U42CUl9VrWp6tPm5mBsH2WhMmmfM=
X-Received: by 2002:a17:90b:4f86:b0:31e:cc6b:320f with SMTP id
 98e67ed59e1d1-3342a2574b0mr4566533a91.5.1758821321850; Thu, 25 Sep 2025
 10:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-6-ihor.solodrai@linux.dev> <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
In-Reply-To: <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:28:27 -0700
X-Gm-Features: AS18NWB-4LZf9cOXY9YqPOuXPeqtspFedHp8sVRj_k25pAwxrufXUj48JJ82jg0
Message-ID: <CAEf4BzY+9gxA+r6K4u==mC8DMs_0F6jsG72B4HXWQo5uQLOhZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with KF_IMPLICIT_PROG_AUX_ARG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:01=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >
> > Update bpf_stream_vprink macro in libbpf and fix call sites in
>
> 't' is missing in bpf_stream_vprintk().
>
> > the relevant selftests.
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >  kernel/bpf/helpers.c                            | 2 +-
> >  kernel/bpf/stream.c                             | 3 +--
> >  tools/lib/bpf/bpf_helpers.h                     | 4 ++--
> >  tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
> >  4 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6b46acfec790..875195a0ea72 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
> >  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
> >  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
> >  #endif
> > -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_P=
ROG_AUX_ARG)
>
> This kfunc will be in part of 6.17 release in a couple days,
> so backward compat work is necessary.
> I don't think we can just remove the arg.

Can we still rename current "explicit prog_aux" version to
bpf_stream_vprintk_impl() still?

That would solve backwards compat problems and would be in line with
bpf_wq_set_callback_impl() approach.


If we can't, then we'd have to name the new function something different?

Don't know if there is some other  BPF CO-RE and ELF symbol aliasing
magic that can be used, we'll need to play with this to see what
works.

>
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -316,7 +316,7 @@ enum libbpf_tristate {
> >  })
> >
> >  extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, con=
st void *args,
> > -                             __u32 len__sz, void *aux__prog) __weak __=
ksym;
> > +                             __u32 len__sz) __weak __ksym;
>
> CI is complaining of conflicting types for 'bpf_stream_vprintk',
> since it's using pahole master.
> It will stop complaining once pahole changes are merged,
> but this issue will affect all developers until they
> update pahole.
> Not sure how to keep backward compat.

