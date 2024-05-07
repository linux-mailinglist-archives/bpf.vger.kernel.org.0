Return-Path: <bpf+bounces-28903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1798BEA22
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19F21F238AF
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7C15FD03;
	Tue,  7 May 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwMeH9b2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D3184D
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101924; cv=none; b=dk3H0ufBwzi5hX07TvTmXUpFvEQUN1Ckx9EOL30tlakTkhd1RSCkV/uXU3MBVQFM6umT40t5IELnijxSImMC1IYlTzQD/2ypik44jK5CCuTuh77qn1n2cWC13Bn1DYpWPUhXDLtN/Yq2b57NrRTBClFfKWKqgCUYMInz+D7egYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101924; c=relaxed/simple;
	bh=f90kOC4/7kLsfsnhQubnZv3IZbeI5N7TBaK/yEHZr1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCVCGCmXU4AiPXO/9+3BbT4R6rW5/5fre/2kYE+z6VrR12FfS2z8IWpRiBO6jyxBvUNXpkXYCAULXBLCPUBPmJNeGBMSl22Ysx2nQ11St1nd1ih8jkhOvcUmuHlOgvNq+PCnh8p7IeuislLT7mCqjG3xzbvlgxC9l1Cc+uEP0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwMeH9b2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed012c1afbso25974335ad.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715101922; x=1715706722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o20MtPbf10/sFMoMdvvyGnLTlfWKtiyBUIm0Zqg6h8=;
        b=PwMeH9b2+13eGmnobRSL9I4fZ9yXTRB0g8kSMI/qKa5w6ib2D1FdSHdbOamzatgOPx
         GtIX9n53PSwdCI9N46yuSPFDCmLXxzn/YZ93lkTsJsBlKFJUWQgofPKDxo/9Vac3h5WU
         relkDCnlsbsg3/s65NIRkYiay3u5HWkHK6/kMz618vPj8ZUM3UmvnpvVL2m+FdPz8Nfr
         3nvLbjK8LsobkScziD2dSH1wU6EdJipWREPDfEtHvESQn5aaYEriB5akMRAzJORsDAi2
         0MGDcJYTCTed7IukIYO3b1fvlMFNCwXK6ZUlQUGZcPS5A54s7jG4RLiZp+kNHgRH4abt
         CPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101922; x=1715706722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o20MtPbf10/sFMoMdvvyGnLTlfWKtiyBUIm0Zqg6h8=;
        b=W9fvD4Xe1ZnhNmY8dynVAVdrfrEHeuKh1ohCq95MM9zn4YOdwhhJGAKDABhpQyluza
         9FymQRYzW/dWiBXw+tJc/TfA7BwDr79dfIrBa0jXL+H1DUBVaYAbCXpft46SsZgC+djx
         ka5Ch+O8LhUp6PwSokg2W6klg+RvU1fWUGOw7D8eT/wtJrSh63WKAKQef/0YRQzF8mkO
         UNUImJqoPHe8MYVQ7eGQWvqMzUsh/CtkBzrk+Wz7umTBzvvaKVkdQcMKSHioCh7LJOL1
         KJCLOidCYnYfiN+htYU+qFzz/ufQwGX8M6QE5VVVtVCxn/UkjaofwLFRcjLIHyv7JMch
         6k/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQJj5pgbs6WPCKICAb8SS5e4A1YsFStKdV6de/79jlGtry90qAZh8x6ssi1yuU5FNzWwG+6ylHkp+tBWfE2PJwryk3
X-Gm-Message-State: AOJu0Yw44te7X6Z8g2lnQ/5u1tLQR7u0E91mqT8Tjty1AKvrpEnzz2o9
	2Ktww//stceKtj6Evpxt2r8QFXU6yv0hO5vQzwURnIUCx/+SH+vONvNbBsr/wQb7bkJjbe8x/Ac
	69GudHV5yOQAfAfEk7LgZ7L9KOo5tvA==
X-Google-Smtp-Source: AGHT+IFUPXL7ivyY7TGVrINexOe28tsq/kNy+tQWAsRJzq0B4hnHrDW7og6RXMYGkgeMFYXlT/QFh0YqftIOJOtJWRY=
X-Received: by 2002:a17:902:da81:b0:1e3:f622:f21a with SMTP id
 d9443c01a7336-1ee63463d10mr46249065ad.24.1715101922332; Tue, 07 May 2024
 10:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-3-laoar.shao@gmail.com>
 <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com> <CALOAHbCWVXG4V1yDwDRaZQe82O9NcsH6RpUEtursx91ZAFiySQ@mail.gmail.com>
In-Reply-To: <CALOAHbCWVXG4V1yDwDRaZQe82O9NcsH6RpUEtursx91ZAFiySQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 10:11:50 -0700
Message-ID: <CAEf4BzYeyUs6CmRLcEp1irBBxFUE+4MDEpRfM2=NhxzuP5WQfg@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Tue, May 7, 2024 at 11:42=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > Add test cases for the bits iter:
> > > - positive case
> > >   - bit mask smaller than 8 bytes
> > >   - a typical case of having 8-byte bit mask
> > >   - another typical case where bit mask is > 8 bytes
> > >   - the index of set bit
> > >
> > > - nagative cases
> > >   - bpf_iter_bits_destroy() is required after calling
> > >     bpf_iter_bits_new()
> > >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> > >   - bpf_iter_bits_next() must use an initialized iter
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++++=
++
> > >  2 files changed, 162 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_i=
ter.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tool=
s/testing/selftests/bpf/prog_tests/verifier.c
> > > index c4f9f306646e..7e04ecaaa20a 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > @@ -84,6 +84,7 @@
> > >  #include "verifier_xadd.skel.h"
> > >  #include "verifier_xdp.skel.h"
> > >  #include "verifier_xdp_direct_packet_access.skel.h"
> > > +#include "verifier_bits_iter.skel.h"
> > >
> > >  #define MAX_ENTRIES 11
> > >
> > > @@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { R=
UN(verifier_var_off); }
> > >  void test_verifier_xadd(void)                 { RUN(verifier_xadd); =
}
> > >  void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
> > >  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp=
_direct_packet_access); }
> > > +void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> > >
> > >  static int init_test_val_map(struct bpf_object *obj, char *map_name)
> > >  {
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b=
/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > new file mode 100644
> > > index 000000000000..2f7b62b25638
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > @@ -0,0 +1,160 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > > +
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +#include "bpf_misc.h"
> > > +#include "task_kfunc_common.h"
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_p=
tr__ign,
> > > +                     u32 nr_bits) __ksym __weak;
> > > +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> > > +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
> > > +
> > > +SEC("iter.s/cgroup")
> > > +__description("bits iter without destroy")
> > > +__failure __msg("Unreleased reference")
> > > +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *=
cgrp)
> > > +{
> > > +       struct bpf_iter_bits it;
> > > +       struct task_struct *p;
> > > +
> > > +       p =3D bpf_task_from_pid(1);
> > > +       if (!p)
> > > +               return 1;
> > > +
> > > +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> > > +
> > > +       bpf_iter_bits_next(&it);
> > > +       bpf_task_release(p);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("iter/cgroup")
> > > +__description("bits iter with uninitialized iter in ->next()")
> > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup =
*cgrp)
> > > +{
> > > +       struct bpf_iter_bits *it =3D NULL;
> > > +
> > > +       bpf_iter_bits_next(it);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("iter/cgroup")
> > > +__description("bits iter with uninitialized iter in ->destroy()")
> > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgro=
up *cgrp)
> > > +{
> > > +       struct bpf_iter_bits it =3D {};
> > > +
> > > +       bpf_iter_bits_destroy(&it);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("syscall")
> > > +__description("bits copy 32")
> > > +__success __retval(10)
> > > +int bits_copy32(void)
> > > +{
> > > +       /* 21 bits:             --------------------- */
> > > +       u32 data =3D 0b11111101111101111100001000100101U;
> >
> > if you define this bit mask as an array of bytes, then you won't have
> > to handle big-endian in the tests at all
>
> This test case provides a clear example of iterating over data of type
> u32, offering valuable guidance for users who need to perform such
> iterations.
>
> >
> >
> > > +       int nr =3D 0, offset =3D 0;
> > > +       int *bit;
> > > +
> > > +#if defined(__TARGET_ARCH_s390)
> > > +       offset =3D sizeof(u32) - (21 + 7) / 8;
> > > +#endif
> > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
> > > +               nr++;
> > > +       return nr;
> > > +}
> > > +
> > > +SEC("syscall")
> > > +__description("bits copy 64")
> > > +__success __retval(18)
> > > +int bits_copy64(void)
> > > +{
> > > +       /* 34 bits:         ~-------- */
> > > +       u64 data =3D 0xffffefdf0f0f0f0fUL;
> > > +       int nr =3D 0, offset =3D 0;
> > > +       int *bit;
> > > +
> > > +#if defined(__TARGET_ARCH_s390)
> > > +       offset =3D sizeof(u64) - (34 + 7) / 8;
> > > +#endif
> > > +
> > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 34)
> >
> > see above about byte array, but if we define different (not as byte
> > array but long[]), it would be cleaner to have
>
> This test case demonstrates how to iterate over data of type u64.
>
> >
> > #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > u64 data =3D 0x......UL;
> > #else
> > u64 data =3D 0x......UL;
> > #endif
>
> looks good.
>

Please hold off on sending a new revision until we figure out what the
contract should be. Because I feel like it's a (relatively) big
decision whether a bit mask is treated as an array of bytes or as an
array of longs. For little-endian it makes no difference, but for
big-endian it's a big difference and has usability and performance
implications.

> >
> > wherer we'd hard-code bit masks in proper endianness in one place and
> > then just do a clean `bpf_for_each(bits, bit, &data, <len>) {}` calls
> >
> > > +               nr++;
> > > +       return nr;
> > > +}
> > > +
> > > +SEC("syscall")
> > > +__description("bits memalloc long-aligned")
> > > +__success __retval(32) /* 16 * 2 */
> > > +int bits_memalloc(void)
> > > +{
> > > +       char data[16];
> > > +       int nr =3D 0;
> > > +       int *bit;
> > > +
> > > +       __builtin_memset(&data, 0x48, sizeof(data));
> > > +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> > > +               nr++;
> > > +       return nr;
> > > +}
> > > +
> > > +SEC("syscall")
> > > +__description("bits memalloc non-long-aligned")
> > > +__success __retval(85) /* 17 * 5*/
> > > +int bits_memalloc_non_aligned(void)
> > > +{
> > > +       char data[17];
> > > +       int nr =3D 0;
> > > +       int *bit;
> > > +
> > > +       __builtin_memset(&data, 0x1f, sizeof(data));
> > > +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> > > +               nr++;
> > > +       return nr;
> > > +}
> > > +
> > > +SEC("syscall")
> > > +__description("bits memalloc non-aligned-bits")
> > > +__success __retval(27) /* 8 * 3 + 3 */
> > > +int bits_memalloc_non_aligned_bits(void)
> > > +{
> > > +       char data[16];
> > > +       int nr =3D 0;
> > > +       int *bit;
> > > +
> > > +       __builtin_memset(&data, 0x31, sizeof(data));
> > > +       /* Different with all other bytes */
> > > +       data[8] =3D 0xf7;
> > > +
> > > +       bpf_for_each(bits, bit, &data,  68)
> > > +               nr++;
> > > +       return nr;
> > > +}
> > > +
> > > +
> > > +SEC("syscall")
> > > +__description("bit index")
> > > +__success __retval(8)
> > > +int bit_index(void)
> > > +{
> > > +       u64 data =3D 0x100;
> > > +       int bit_idx =3D 0;
> > > +       int *bit;
> > > +
> > > +       bpf_for_each(bits, bit, &data, 64) {
> > > +               if (*bit =3D=3D 0)
> > > +                       continue;
> > > +               bit_idx =3D *bit;
> > > +       }
> > > +       return bit_idx;
> > > +}
> > > --
> > > 2.30.1 (Apple Git-130)
> > >
>
>
>
> --
> Regards
> Yafang

