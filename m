Return-Path: <bpf+bounces-29158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D598C09A8
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 04:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FF21F222F0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FB13C9AB;
	Thu,  9 May 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNwcp/Jf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC513C66A
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220718; cv=none; b=NmjKnhQBUH30o8jc4qcJkngE+nlqMD2+5o1SXCw0GSfeaF2DbrRS6GHZ2mkA+CPh/N4gcBkOJxfZaCaf2enLS3SfZfcfYyYdeT8ziwhtQej/mzTtl361eMvBk8i/aXpZ8Hgr4oJgVUp317VecfFMNZMCDLEM3BzGsy03uIcC8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220718; c=relaxed/simple;
	bh=2IBXkNud63eSWXLjUPho1nyqY7CDu4DURB3fABpTfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiF4SRVY2i1E4oPuLJC+imVCfVWRlQT+XVED4Ixql8evkDvJtZi087W4J4HwxiGlye+pl9tYxrvemnonQKHfm+dwnxLochDA8gbVIc5L75NnxvKE4cIdyIwZWxzLMLQDL5s9zBiJPLAJoAAXquW03GEfh2GPIKIBO4hwpaFaCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNwcp/Jf; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47f39711c94so124396137.1
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 19:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715220715; x=1715825515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMHyKAOzspC0P1aEHMkM+nFok08wIDlhZbTNsS9ndkQ=;
        b=TNwcp/JfxJ02nrerGN/T75RJyuKw0P6MpYuuEhskOSuOgM3nhbEabiGli4lX3ZTAiJ
         v/ONldS/3xVcSmuNJXJckEHLNautqiaI9nmrWVnWXclYdpk9vEZwXjB2EpsHpU4E2Kea
         SwQGpab/FqKoSpbmLJJdN/A4RcIPgI55UKnEJCsiXFuCD9DsTEVIMHjN/+Jz+OpQiJuj
         B+gXjupEGa0/cyVQOXFoJ6qo6ZNYZf75y7+b4e9MfPum9NbPJw+FFx2iTm8d9l2sP9bA
         UjOeFH8SIKZVTAFaEHfBmSaiTNIWn2rC+fjh8FWB5wiFPABMff1hOOZeVM3WYOD2iUlG
         nkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220715; x=1715825515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMHyKAOzspC0P1aEHMkM+nFok08wIDlhZbTNsS9ndkQ=;
        b=b8Y71W5m2l10/MLmSYvfhknndEG2XULrnwObMCIPHxuM5hn+YaZHab8MOnI1E2e0d1
         0XlyWaG+OU5Dzl9eMlZsGMnYridfGyUGmgbCvevkce2ELIYHTRbrhurRiXoCcCGYRiTV
         1r8GiopNia2n4HrbVSSXX0FE+Ne4icPdU5U3YHNW/Ryr/52HW0fNWfvBPem6YJRIm8d0
         hy9H/bC2Vu3rRMYqwY517anLTFFimC+qDrFRgIu928Rx+ISjw1zBKwWh5ThQF8QKfO4Z
         ZA7kuGGVUDK7WB9tL2njU0p4ymhduLHGo5/r0s1E4tc5uiY3B9eVpLlN4fFHjK6m4u4r
         ud8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKCvIOlDdax/16MUzvdVB4DP5sArY0CsMN65Bl2EWqvDYWY8cUH1+DRRv+UOs/+yKmEOrouVZZj2pRXhKbKERQInWw
X-Gm-Message-State: AOJu0YzbOx+g3te2fXUelvnnYcH2HYQRhwuuyRyRlvi7FvYbY0xnkl8u
	Sb672BMQU5fFeQ85YTxAumQncRDG1L2wJNEBNrwRgyXdeLVM3dlH0lfmIu4wn9iIQZCOHluCejs
	X/sEEYaSZQ3h9OCN8ATGAaK0H8ds=
X-Google-Smtp-Source: AGHT+IHIeOsS0EOHRgzOeYgA0G6r99iNEMBo5yimbG35U5Nfx7PribFHh2FwzKGWMjuKChH/7X/98jP9sv5+hS9b4pU=
X-Received: by 2002:a05:6102:2245:b0:47a:2cab:75ad with SMTP id
 ada2fe7eead31-47f3c2d613dmr3719403137.14.1715220715201; Wed, 08 May 2024
 19:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-3-laoar.shao@gmail.com>
 <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com>
 <CALOAHbCWVXG4V1yDwDRaZQe82O9NcsH6RpUEtursx91ZAFiySQ@mail.gmail.com> <CAEf4BzYeyUs6CmRLcEp1irBBxFUE+4MDEpRfM2=NhxzuP5WQfg@mail.gmail.com>
In-Reply-To: <CAEf4BzYeyUs6CmRLcEp1irBBxFUE+4MDEpRfM2=NhxzuP5WQfg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 9 May 2024 10:11:18 +0800
Message-ID: <CALOAHbBiHa8+LXio6ZnJ-kUhezQnDhaj9koT-hVOaPiS3SHrDA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 1:12=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 7, 2024 at 6:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Tue, May 7, 2024 at 11:42=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > Add test cases for the bits iter:
> > > > - positive case
> > > >   - bit mask smaller than 8 bytes
> > > >   - a typical case of having 8-byte bit mask
> > > >   - another typical case where bit mask is > 8 bytes
> > > >   - the index of set bit
> > > >
> > > > - nagative cases
> > > >   - bpf_iter_bits_destroy() is required after calling
> > > >     bpf_iter_bits_new()
> > > >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> > > >   - bpf_iter_bits_next() must use an initialized iter
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++=
++++
> > > >  2 files changed, 162 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits=
_iter.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/to=
ols/testing/selftests/bpf/prog_tests/verifier.c
> > > > index c4f9f306646e..7e04ecaaa20a 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > @@ -84,6 +84,7 @@
> > > >  #include "verifier_xadd.skel.h"
> > > >  #include "verifier_xdp.skel.h"
> > > >  #include "verifier_xdp_direct_packet_access.skel.h"
> > > > +#include "verifier_bits_iter.skel.h"
> > > >
> > > >  #define MAX_ENTRIES 11
> > > >
> > > > @@ -198,6 +199,7 @@ void test_verifier_var_off(void)              {=
 RUN(verifier_var_off); }
> > > >  void test_verifier_xadd(void)                 { RUN(verifier_xadd)=
; }
> > > >  void test_verifier_xdp(void)                  { RUN(verifier_xdp);=
 }
> > > >  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_x=
dp_direct_packet_access); }
> > > > +void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> > > >
> > > >  static int init_test_val_map(struct bpf_object *obj, char *map_nam=
e)
> > > >  {
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c=
 b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > > new file mode 100644
> > > > index 000000000000..2f7b62b25638
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > > @@ -0,0 +1,160 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > > > +
> > > > +#include "vmlinux.h"
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +
> > > > +#include "bpf_misc.h"
> > > > +#include "task_kfunc_common.h"
> > > > +
> > > > +char _license[] SEC("license") =3D "GPL";
> > > > +
> > > > +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe=
_ptr__ign,
> > > > +                     u32 nr_bits) __ksym __weak;
> > > > +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> > > > +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak=
;
> > > > +
> > > > +SEC("iter.s/cgroup")
> > > > +__description("bits iter without destroy")
> > > > +__failure __msg("Unreleased reference")
> > > > +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup=
 *cgrp)
> > > > +{
> > > > +       struct bpf_iter_bits it;
> > > > +       struct task_struct *p;
> > > > +
> > > > +       p =3D bpf_task_from_pid(1);
> > > > +       if (!p)
> > > > +               return 1;
> > > > +
> > > > +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> > > > +
> > > > +       bpf_iter_bits_next(&it);
> > > > +       bpf_task_release(p);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +SEC("iter/cgroup")
> > > > +__description("bits iter with uninitialized iter in ->next()")
> > > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > > +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgrou=
p *cgrp)
> > > > +{
> > > > +       struct bpf_iter_bits *it =3D NULL;
> > > > +
> > > > +       bpf_iter_bits_next(it);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +SEC("iter/cgroup")
> > > > +__description("bits iter with uninitialized iter in ->destroy()")
> > > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > > +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cg=
roup *cgrp)
> > > > +{
> > > > +       struct bpf_iter_bits it =3D {};
> > > > +
> > > > +       bpf_iter_bits_destroy(&it);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +SEC("syscall")
> > > > +__description("bits copy 32")
> > > > +__success __retval(10)
> > > > +int bits_copy32(void)
> > > > +{
> > > > +       /* 21 bits:             --------------------- */
> > > > +       u32 data =3D 0b11111101111101111100001000100101U;
> > >
> > > if you define this bit mask as an array of bytes, then you won't have
> > > to handle big-endian in the tests at all
> >
> > This test case provides a clear example of iterating over data of type
> > u32, offering valuable guidance for users who need to perform such
> > iterations.
> >
> > >
> > >
> > > > +       int nr =3D 0, offset =3D 0;
> > > > +       int *bit;
> > > > +
> > > > +#if defined(__TARGET_ARCH_s390)
> > > > +       offset =3D sizeof(u32) - (21 + 7) / 8;
> > > > +#endif
> > > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
> > > > +               nr++;
> > > > +       return nr;
> > > > +}
> > > > +
> > > > +SEC("syscall")
> > > > +__description("bits copy 64")
> > > > +__success __retval(18)
> > > > +int bits_copy64(void)
> > > > +{
> > > > +       /* 34 bits:         ~-------- */
> > > > +       u64 data =3D 0xffffefdf0f0f0f0fUL;
> > > > +       int nr =3D 0, offset =3D 0;
> > > > +       int *bit;
> > > > +
> > > > +#if defined(__TARGET_ARCH_s390)
> > > > +       offset =3D sizeof(u64) - (34 + 7) / 8;
> > > > +#endif
> > > > +
> > > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 34)
> > >
> > > see above about byte array, but if we define different (not as byte
> > > array but long[]), it would be cleaner to have
> >
> > This test case demonstrates how to iterate over data of type u64.
> >
> > >
> > > #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > > u64 data =3D 0x......UL;
> > > #else
> > > u64 data =3D 0x......UL;
> > > #endif
> >
> > looks good.
> >
>
> Please hold off on sending a new revision until we figure out what the
> contract should be. Because I feel like it's a (relatively) big
> decision whether a bit mask is treated as an array of bytes or as an
> array of longs. For little-endian it makes no difference, but for
> big-endian it's a big difference and has usability and performance
> implications.

Perhaps it would be advantageous to define the interface as follows:

bpf_iter_bits_new(struct bpf_iter_bits *it, const u64
*unsafe_ptr__ign, u32 words)

This approach eliminates the need to account for endianness.

--=20
Regards
Yafang

