Return-Path: <bpf+bounces-29327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5E8C1921
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E12828F1
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08771292F3;
	Thu,  9 May 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnqStmR7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7291292CF
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292210; cv=none; b=SewBLqDDKqhMfNZ3kXnGA+qGdLkexJderDBcNw5Mh0pjJQbyHoekeIPr2ogZBeNsDPwcMOVoBpSJElla9dUfVdvE5w6r6G1hJTcHiLZJUSNat2TnDb6NMdYkMVQDiji2iIfSmhac2tZMQPtrIMiRiP4VxWWyk9xXL6USjS1KuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292210; c=relaxed/simple;
	bh=Y/OXLPiS7VXcOJIitf0ABZZnrhRzw9/3LGJRf2t5Wh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwKa46z4YpYJuCUcvxDcicaCzAVuLOovqF0cjrv/fCWg0MmAsibKjlBezlSt+KmVsMlYHOMNKQw79JVeHYU7QKjGPfi7hM2PAgPDn2YQ3zOczCphV18ouEAOthfNTvctmIi3iOed1jSv7vGZY/4e948nxuQzKAxKlSH+1m1x09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnqStmR7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b6208c88dcso1152872a91.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715292208; x=1715897008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwGXtJbBGXmjguxzqQGhEx1DDwbGWYOoWwos7SDcXVc=;
        b=UnqStmR7ynljBrNaB4nLq/ihQqalW1R+3TIdhqTGfrWkoEavg8Amp6VByM6akUfei7
         WCaXhLuVujuo8eN3oKpEwb+azPN169wxB+a52UA1D+GvjtKB/3hemQmUhqh6EJVsEZbL
         U9/kAv9wR2o/+4dYAMyDpbGcDDA/AyMoZlH9Vf6Fqky2bvwmKeRyhxGyShbpO2YHB02u
         J1gOA524BSER6WTzbgrIpXMXufWvvUVz3yL8rsgCzZVI3cLFoQBvpj5s4krnxhwnLuVV
         8m7J3/yMwenRW0zj/tW7qDeaJYetQCXKEWCXctinkNrDZ0aKZDsFYiL4pH9RhLdwk4j0
         l56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292208; x=1715897008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwGXtJbBGXmjguxzqQGhEx1DDwbGWYOoWwos7SDcXVc=;
        b=LoWUXQwq0HfDsx3PlPp88LIDuDSh2Hx/0rWxfaHUUsekMf5ghRJDwliZbVnD+yKNmI
         fhekgaba0dPL47EylYCEQNGMOzn7SNtw960LcdlRakThzOTUVBTpf1plbkaEngxoa45g
         zm+KLgMD5ruYUMEiYKdM4fFYbtMSyX8FOTZlSXPiwWPD9C33Ozvg1UufI0Ax02UVwXwG
         0jNU44umFJqYR6uuy4jA4vQdkQ+7fyBa+Xt+w/W18/OdGcuDCZ9357gGbrt4TeKlynDy
         60UPdaGa18JPc6Js2F3SD8jTw8/RaBAF9Nn3oN4q6pPJQRi1vEXO3RLnkNHzPiptr5nX
         HqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxdUkPf+GNKEELvGuXgwi+6ldMsFOoxto1w5u077lt1OQVyImSav9NWqRnz40cSOYSZquXDUU70wORJPaoOn06vKWH
X-Gm-Message-State: AOJu0YwyRYl1nNzO5+ieVoSM5lqGMd70tDhL4S+eiCPyln3bG5BSw0wj
	N41GmK2BM2Akep3p6hOCtViaTfp0GINd0+ashFvMkZAgVKxDJXHH9fJHPWMqgUliZ3uYK2PDtqV
	Q1hO4fLQyaTtuRcFcb9nTSJktMUo=
X-Google-Smtp-Source: AGHT+IFa8IoS46j+vYVRL2jd5UupmSqDHnTggJ5mLhQbmXwvtpN2K7Xm8Ew2e1f8jCpKODgRgZsy5ZVogojPfFVxqiE=
X-Received: by 2002:a17:90b:947:b0:2b2:d086:6f84 with SMTP id
 98e67ed59e1d1-2b6cc340547mr801109a91.7.1715292208116; Thu, 09 May 2024
 15:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-3-laoar.shao@gmail.com>
 <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com>
 <CALOAHbCWVXG4V1yDwDRaZQe82O9NcsH6RpUEtursx91ZAFiySQ@mail.gmail.com>
 <CAEf4BzYeyUs6CmRLcEp1irBBxFUE+4MDEpRfM2=NhxzuP5WQfg@mail.gmail.com> <CALOAHbBiHa8+LXio6ZnJ-kUhezQnDhaj9koT-hVOaPiS3SHrDA@mail.gmail.com>
In-Reply-To: <CALOAHbBiHa8+LXio6ZnJ-kUhezQnDhaj9koT-hVOaPiS3SHrDA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 May 2024 15:03:16 -0700
Message-ID: <CAEf4BzawfHfeOhm+BP3AzrcLE8dv+gEXQsE7nRY+yqebkbcvbA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, May 8, 2024 at 1:12=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 7, 2024 at 6:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Tue, May 7, 2024 at 11:42=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > Add test cases for the bits iter:
> > > > > - positive case
> > > > >   - bit mask smaller than 8 bytes
> > > > >   - a typical case of having 8-byte bit mask
> > > > >   - another typical case where bit mask is > 8 bytes
> > > > >   - the index of set bit
> > > > >
> > > > > - nagative cases
> > > > >   - bpf_iter_bits_destroy() is required after calling
> > > > >     bpf_iter_bits_new()
> > > > >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> > > > >   - bpf_iter_bits_next() must use an initialized iter
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > > > >  .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++=
++++++
> > > > >  2 files changed, 162 insertions(+)
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bi=
ts_iter.c
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/=
tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > > index c4f9f306646e..7e04ecaaa20a 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > > @@ -84,6 +84,7 @@
> > > > >  #include "verifier_xadd.skel.h"
> > > > >  #include "verifier_xdp.skel.h"
> > > > >  #include "verifier_xdp_direct_packet_access.skel.h"
> > > > > +#include "verifier_bits_iter.skel.h"
> > > > >
> > > > >  #define MAX_ENTRIES 11
> > > > >
> > > > > @@ -198,6 +199,7 @@ void test_verifier_var_off(void)             =
 { RUN(verifier_var_off); }
> > > > >  void test_verifier_xadd(void)                 { RUN(verifier_xad=
d); }
> > > > >  void test_verifier_xdp(void)                  { RUN(verifier_xdp=
); }
> > > > >  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier=
_xdp_direct_packet_access); }
> > > > > +void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> > > > >
> > > > >  static int init_test_val_map(struct bpf_object *obj, char *map_n=
ame)
> > > > >  {
> > > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter=
.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > > > new file mode 100644
> > > > > index 000000000000..2f7b62b25638
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > > > > @@ -0,0 +1,160 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > > > > +
> > > > > +#include "vmlinux.h"
> > > > > +#include <bpf/bpf_helpers.h>
> > > > > +#include <bpf/bpf_tracing.h>
> > > > > +
> > > > > +#include "bpf_misc.h"
> > > > > +#include "task_kfunc_common.h"
> > > > > +
> > > > > +char _license[] SEC("license") =3D "GPL";
> > > > > +
> > > > > +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsa=
fe_ptr__ign,
> > > > > +                     u32 nr_bits) __ksym __weak;
> > > > > +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> > > > > +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __we=
ak;
> > > > > +
> > > > > +SEC("iter.s/cgroup")
> > > > > +__description("bits iter without destroy")
> > > > > +__failure __msg("Unreleased reference")
> > > > > +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgro=
up *cgrp)
> > > > > +{
> > > > > +       struct bpf_iter_bits it;
> > > > > +       struct task_struct *p;
> > > > > +
> > > > > +       p =3D bpf_task_from_pid(1);
> > > > > +       if (!p)
> > > > > +               return 1;
> > > > > +
> > > > > +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> > > > > +
> > > > > +       bpf_iter_bits_next(&it);
> > > > > +       bpf_task_release(p);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +SEC("iter/cgroup")
> > > > > +__description("bits iter with uninitialized iter in ->next()")
> > > > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > > > +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgr=
oup *cgrp)
> > > > > +{
> > > > > +       struct bpf_iter_bits *it =3D NULL;
> > > > > +
> > > > > +       bpf_iter_bits_next(it);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +SEC("iter/cgroup")
> > > > > +__description("bits iter with uninitialized iter in ->destroy()"=
)
> > > > > +__failure __msg("expected an initialized iter_bits as arg #1")
> > > > > +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct =
cgroup *cgrp)
> > > > > +{
> > > > > +       struct bpf_iter_bits it =3D {};
> > > > > +
> > > > > +       bpf_iter_bits_destroy(&it);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +SEC("syscall")
> > > > > +__description("bits copy 32")
> > > > > +__success __retval(10)
> > > > > +int bits_copy32(void)
> > > > > +{
> > > > > +       /* 21 bits:             --------------------- */
> > > > > +       u32 data =3D 0b11111101111101111100001000100101U;
> > > >
> > > > if you define this bit mask as an array of bytes, then you won't ha=
ve
> > > > to handle big-endian in the tests at all
> > >
> > > This test case provides a clear example of iterating over data of typ=
e
> > > u32, offering valuable guidance for users who need to perform such
> > > iterations.
> > >
> > > >
> > > >
> > > > > +       int nr =3D 0, offset =3D 0;
> > > > > +       int *bit;
> > > > > +
> > > > > +#if defined(__TARGET_ARCH_s390)
> > > > > +       offset =3D sizeof(u32) - (21 + 7) / 8;
> > > > > +#endif
> > > > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
> > > > > +               nr++;
> > > > > +       return nr;
> > > > > +}
> > > > > +
> > > > > +SEC("syscall")
> > > > > +__description("bits copy 64")
> > > > > +__success __retval(18)
> > > > > +int bits_copy64(void)
> > > > > +{
> > > > > +       /* 34 bits:         ~-------- */
> > > > > +       u64 data =3D 0xffffefdf0f0f0f0fUL;
> > > > > +       int nr =3D 0, offset =3D 0;
> > > > > +       int *bit;
> > > > > +
> > > > > +#if defined(__TARGET_ARCH_s390)
> > > > > +       offset =3D sizeof(u64) - (34 + 7) / 8;
> > > > > +#endif
> > > > > +
> > > > > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 34)
> > > >
> > > > see above about byte array, but if we define different (not as byte
> > > > array but long[]), it would be cleaner to have
> > >
> > > This test case demonstrates how to iterate over data of type u64.
> > >
> > > >
> > > > #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > > > u64 data =3D 0x......UL;
> > > > #else
> > > > u64 data =3D 0x......UL;
> > > > #endif
> > >
> > > looks good.
> > >
> >
> > Please hold off on sending a new revision until we figure out what the
> > contract should be. Because I feel like it's a (relatively) big
> > decision whether a bit mask is treated as an array of bytes or as an
> > array of longs. For little-endian it makes no difference, but for
> > big-endian it's a big difference and has usability and performance
> > implications.
>
> Perhaps it would be advantageous to define the interface as follows:
>
> bpf_iter_bits_new(struct bpf_iter_bits *it, const u64
> *unsafe_ptr__ign, u32 words)
>
> This approach eliminates the need to account for endianness.

I don't mind that, if others don't have any opinion. Let's just
document that by "words" we mean 8-byte integers.

>
> --
> Regards
> Yafang

