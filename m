Return-Path: <bpf+bounces-51283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B02A32D8E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81712164CBF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97BC25A33C;
	Wed, 12 Feb 2025 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="z23///Xj"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85F25A35B
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381648; cv=none; b=Rhm3H7B2hDISU8r3DNQ3BcSoFXcUO8a3ER9FCxuiBWAGHDhnR4ZWK8Slm+741ZqpOwdMTehOdYx7YZjY41WTX5Y7kW4h1oR9xgH6hQ3j4vb5H/5YbQbgU1wwKFT6WxqQ7opbP/kwqARbYluv+Zv+wtshebzApczdHXd1OM6QDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381648; c=relaxed/simple;
	bh=mSNvi3m8qKMq8CUUEEtGDOuOm6FuX+TxlRcWkNZApYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgfm8SkNGXGY8wD5hEBfX2wkrTrQ8L4V8z6Z9udZRebcgFBTiGapZCa6E1NKe8BhitMrXUKLskq8B4WrK7AvMRuVdWvd0PfkDIFhjMG1DOmnUHrEMaGfucknbyPSiATXAvJ4svwp7HPScfnPe53yK/LXQBA4zFTuIKp0HEnu0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=z23///Xj; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739381639; x=1739986439; i=linux@jordanrome.com;
	bh=ByANMfm1xiq2Jv/kw72ponfJbhIOJ6j+ZFzbj6o8Vbs=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=z23///XjGfJD05MLTfofqKhHMcMqYYH+tBAPP2i4tPWam/YiOLqyUGKq+F1pesqz
	 8Rg+RKO33JAXWVmvPyfTNf9KTfRBdBKcem9eyBKYfoI4dqbaKJA7OUynMg6p0amq4
	 lnsk2HybRYN0Rre7C0EHmLq79WL/zz1JGsP5gsidgbLlSkQ3mVCtco+rhyscyb/z5
	 dqa7MsFP6Sy1+zBhvyHuXnbUxPDGiUnGfH83JT3TKhoJO/1UBm/U2EMtNrGYVlB3B
	 s+G6tLzRat+LbOx4xp1EqCR69udXkBlQsDfJHqtAzjNhex+4atAb6ULQX4w2+HYdJ
	 MFYikokG3OZVAkihtw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f176.google.com ([209.85.166.176]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LfkxY-1t2t8n2Gy2-00ZakI for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 18:33:59
 +0100
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d04932a36cso61846935ab.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 09:33:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaLQMr2Lh1jbikHX7Ufv/y3Q3iTqB7cSXSbElTqIVk3Y0teoF0SVkE5CK+Nt/7Ez+VF+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzslx1LJVKILPB378XApIXZbqNyubndGsqAmCbB3me4t1TkwTCO
	vtPFagTOS1D/zEIcpP/xb7RVTFPKY7NZwDpIDIR2gWi5z5dY/gsxKX8Elxgu2ASqXYq5+eISX89
	q2WOHUYMTgXN72wB/U3idwMcASkc=
X-Google-Smtp-Source: AGHT+IHYtYCs1Zfc4tIRaiA2ngDcck6IGsVWQtsvnMOAw58zkYn+teEUY7Jgb74jfFZQqDyi7vAyaxt3u48ic4JRYY0=
X-Received: by 2002:a05:6e02:17cf:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d18c2d5526mr1580435ab.15.1739381639162; Wed, 12 Feb 2025
 09:33:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210221626.2098522-1-linux@jordanrome.com>
 <CAEf4BzYjsLnrCV9PK8gmyiFw8idXea5ckPRvCqhFbyEU5Wcd9w@mail.gmail.com> <mvrphlxx4r5mj7cmzsvmx3v6wcuo3pvjpfb5sva2jcmh34ye2p@dzfxxaymvnk3>
In-Reply-To: <mvrphlxx4r5mj7cmzsvmx3v6wcuo3pvjpfb5sva2jcmh34ye2p@dzfxxaymvnk3>
From: Jordan Rome <linux@jordanrome.com>
Date: Wed, 12 Feb 2025 12:33:47 -0500
X-Gmail-Original-Message-ID: <CA+QiOd5xgBkcfwHq_C+fvLvtWbc_SUjOp9GNsZRm=9OPHyto8w@mail.gmail.com>
X-Gm-Features: AWEUYZmwFNnaAmfKVyum6PuSMCiemWAIejoB_RcHEEXKSV1pnmDA-bxGONJ6cE0
Message-ID: <CA+QiOd5xgBkcfwHq_C+fvLvtWbc_SUjOp9GNsZRm=9OPHyto8w@mail.gmail.com>
Subject: Re: [bpf-next v7 1/3] mm: add copy_remote_vm_str
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hjEXN+VFsHBAQN6z5QtGXCK8R4Nk7E5v/KRbm2USn3JilUTVpvY
 Ch2CDwNnScjRXaE5ntv+Tl6ZGehfUTgMbmecu5Rl1UdfH1hqI9neasiOyn1D/FPbUOfwAL1
 JMz/JcnhRTKeHhWjox9dTpkEE+UUrxJtcLp1gbpBYLx1vSD0ju+6gEFv6EU3LIVI4nyeARU
 Yap09kmW7AiS5z3GbPv9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/pvsQllWwzs=;QZh9tdFJNGucHlnuf9+TZqOHXKD
 Wp7a8tXynbNOHuP/yIDBQ4LuEu93wjrICGARO7Om5yK4rv3FR4Rn/9nWJf9AgkGB2v6lc6rFo
 NXJTU4JxgWqsey+dbhgQtoZ3c2ozTS96W9Y/h0WdQoQ3Gj3aaV1VkOSvoLmNgGSLBTtT5aOjF
 +uB/MHsz8uzPs8sbfYS/HkhtKow7vTdvkWrG1oDoOd8Lefk7SMwBFUgNQ0gJfRgI3PpbwlhGc
 0OyETL5ZLCt2Zqx+tb412ee0IK0d09josI0jvfUnlGxtDHCzdTcUWMAlAFSr6NVvIS2owHMQu
 c4DBDsh+f3y/Mz/e+1lB0S4dMsRIHp5J1jPKA46Wo0Bt1cqaJSZ5g9KPQE7zkEiYBLpmon/GU
 lou5autFXckxLOvcDk/kyA7FqPy4A62uKSfdExhHVBWITlxN0d3C9+k965wc7HlIRTDtS4vcr
 KM3EBMr+ST/5YPQ+HEcGVovhomG7udubL2P1o82KyAZzjFnysrZeJJm/a4QPzRWw5A9jDiryA
 PyUEvzhKPs+OtFhWKoFmzu25VXWdCq+SizAEM+soVIYYa1lpalzrBj3yGLjyEvBWMcgfV78Jj
 jaaldVMgTIEFy6g5JgKT9OeM3RWpDibfQfC3tKv8uXrlUwZH6z2ysrV4EAxDnbbL1GySghgIZ
 4xl3DAGlGj1H8z/shPSxtyycw0gr3XlrtTbgMdmW+NPCvTRV82u794G9KuZbwq/hgs5l4c0lJ
 UlkYjjxolPCNeVg4l+JXTMUkgFmz3E+jDjv7dy1G9HE7oaGlwJU+vXmFtujAMGR2lg/KzyEBm
 VM6lh+Dl01zobz8B5BQv7L9Ot9t/jLSu9lB7bMRZMWRk2tfmM77yRicXAh6f7JGCKSuxBws2u
 XMcyNd8kfsVhiEhycBcZIUdJ5gt6/3m6TsNBh1cUUggZpVowQaUnN0+z22SzhLu7eBi/N9FhM
 TcJCjS0cwtdH86IcaJ0+9ItxlBaOqjiBWiyi68QPPJj2Ja+yxWaN4s5es1kg9A/d07cIygmGe
 JPlmVNX4uAMhFNEY4dv7pj2j11IOe/sGktGUdfUOgw93yAKUb/7SZuYwCGJWEINsszhgTbq3s
 gy62hy8Qg/wkxm26fizW38iqvOhoH1tAAiSgLvdE3c0yZ01IseVWmnXc6Qo7jatOycvX46vfV
 0Tdc/m6i/DKL/oY/1QsigJ5r8mTIGyCZkKrR7d0m3UC5rdRztFvyh5n8NPAALwl2YJLKbB2zr
 44PzmRvd4Pi1FroEmEooRQBPfMHOYZZ1TTSAyiFk/bJaJ3KPmGnVk2ZUK0gQyCJdU+Y/Britc
 fMgkcCoMvRIE0gH1PGUuFr9WG57IOPxOwK2tw2r6Fc6Bvo4yTCi9R+lRlm7xInQkoze

On Tue, Feb 11, 2025 at 9:19=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Feb 11, 2025 at 02:07:31PM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 10, 2025 at 2:23=E2=80=AFPM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > Similar to `access_process_vm` but specific to strings.
> > > Also chunks reads by page and utilizes `strscpy`
> > > for handling null termination.
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  include/linux/mm.h |   3 ++
> > >  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  mm/nommu.c         |  73 +++++++++++++++++++++++++++
> > >  3 files changed, 195 insertions(+)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 7b1068ddcbb7..aee23d84ce01 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2486,6 +2486,9 @@ extern int access_process_vm(struct task_struct=
 *tsk, unsigned long addr,
> > >  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr=
,
> > >                 void *buf, int len, unsigned int gup_flags);
> > >
> > > +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long=
 addr,
> > > +               void *buf, int len, unsigned int gup_flags);
> > > +
> > >  long get_user_pages_remote(struct mm_struct *mm,
> > >                            unsigned long start, unsigned long nr_page=
s,
> > >                            unsigned int gup_flags, struct page **page=
s,
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 539c0f7c6d54..e9d8584a7f56 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -6803,6 +6803,125 @@ int access_process_vm(struct task_struct *tsk=
, unsigned long addr,
> > >  }
> > >  EXPORT_SYMBOL_GPL(access_process_vm);
> > >
> > > +/*
> > > + * Copy a string from another process's address space as given in mm=
.
> > > + * If there is any error return -EFAULT.
> > > + */
> > > +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long =
addr,
> > > +                             void *buf, int len, unsigned int gup_fl=
ags)
> > > +{
> > > +       void *old_buf =3D buf;
> > > +       int err =3D 0;
> > > +
> > > +       *(char *)buf =3D '\0';
> >
> > LGTM overall:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > But note that all this unconditional buf access will be incorrect if
> > len =3D=3D 0. So either all of that has to be guarded with `if (len)`,
> > just dropped, or declared unsupported, depending on what mm folks
> > think. BPF helper won't ever call with len =3D=3D 0, so that's why my a=
ck.
>
> I think early return 0 on len =3D=3D 0 should be fine.

Ack.

