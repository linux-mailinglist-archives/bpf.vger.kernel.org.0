Return-Path: <bpf+bounces-28829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B868BE47C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE4288AE8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F615E1E6;
	Tue,  7 May 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkQuXjYa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB11DFCB
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089150; cv=none; b=QB9DUD7vxlrpIERRCIR6e/SYULopyMlOInKy9HgAzB4pJbBcC9qWDvsBCG4vcMBMDboQVLSrWWXgdgZ60nMVOmRnjjLu4WaJaf1AFdif+v3p/UGNt0nIp6sTQhx5R8ReezFzb1D+07O0uSfEHXmzHgQbdGKi7IodfN2YFXu0s+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089150; c=relaxed/simple;
	bh=rRyKXqh6HkRBP5CcaYVgN8vGZL06jAquWXsJqcelJvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M72gNO1jIiI0J39X9yQ78pTcjFxLS1EMNRaJ/ULYrA2lgCeJ4+2zobV9FWQK+njCxbqSKLkZ1SfA8XJG/QiV7L+PYR9Ipcv69Nsq+7gYRcEWcIS+FAK09ZcdmDjrxT/ZQ0WN+s1SN0K0fkcM13U9jgVgVWwTToxXE38AItlhaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkQuXjYa; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9691e1e78so1405774b6e.3
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715089147; x=1715693947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hctO0SiG/WDkR58Qhp5dp0wrRyUu6YXjaVCpyXq/kuk=;
        b=GkQuXjYaeoGk9+RWdD4ZBMy2tyKSu/4HfJO3HWqlCKHNpI563edYebGBEZt3R4YNUH
         gR49xhLESoYCUOAbmvQwbMCZmyaS4WkbdZl+aqtck/ZXZHNH46Yl0akXpixx/e1ODdQE
         gpgCgWf8+PZoX1DVphkDSMS2umcT7X19g5x1bDKiO3Rt88OpbevbY4fSq5sgfyjhjn06
         Hntn/1FJspYqRKQvigzeeAS2YOPzn49yjBUWKfXoyEVJmcKTQ48cOZ02XKGcFD4f3/ue
         eGcYKN8zkywI5kS/uy59UHhH0zrG/I0Rrp2yRzAKgJ1xjx6gBC3zgT5swrFDMDJwYgTp
         AVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089147; x=1715693947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hctO0SiG/WDkR58Qhp5dp0wrRyUu6YXjaVCpyXq/kuk=;
        b=L5AtooV0q+9J1+o8nMlgQuqI2P29A8MbzHiapYBjKmAHEmpXUUAaOT/ZTOeWoYFrq+
         ohkbw5XeRkhJ2SeUshgBuBsm3aR6FlIvGklQrUcJGX2VoNZjFmE15tolxYpW85K4bNAU
         5ixWsqMn5E+LlC/eLaik+rnTB3iN9SzcCXQfqkarQeYEtwYoJBYX2R9NcFAv+1025Anx
         a9pDOOSDtVA0kHl/eUnbQy/R9EldcCUdQvO4t0ammsfMQcPe3yrsIYH/I4RNsDRipwn7
         2zbMekLc+lT26yaVfhWO7Yu9nZmt59/eWojJWkxjltAKaguzVPglQQFk1w+LRDJAnzVt
         pcmA==
X-Forwarded-Encrypted: i=1; AJvYcCWqWoZXUQW/kXU3ps68dF/0EjXiA/Q9y04T80CpOzhtfU0SBvYLB82cdl67uGcxoAIO4y08NOEfu+QV9bIIh65d8XBY
X-Gm-Message-State: AOJu0YwJrDh+Y9KYuhSbnsXzTywjl0GviZxKE9CFap3qpbnDanJSIdU+
	c031rzMMl0+U5yliwqlnmUNLvrf7vbpO6KJM0hlj/P60SLyxAL8js8jUx/219ArKdYrMQIVWaYL
	kkhMeZDcpXMt7x9cUD/Jvavr9IzE=
X-Google-Smtp-Source: AGHT+IH0QvhotP6uGCNJyACb3OIOzGoyKet0PtljpJBVmi3gLtf8128uOmUOZe1A+sESdand5rXvlPm9E+USkVF68kM=
X-Received: by 2002:a05:6808:150c:b0:3c8:4964:48da with SMTP id
 u12-20020a056808150c00b003c8496448damr17868059oiw.0.1715089147426; Tue, 07
 May 2024 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-3-laoar.shao@gmail.com>
 <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com>
In-Reply-To: <CAEf4Bza0UnsAVuBH1J_nGN14gXg_Sa2QnJG7jjFjozcYzxx2dg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 May 2024 21:38:31 +0800
Message-ID: <CALOAHbCWVXG4V1yDwDRaZQe82O9NcsH6RpUEtursx91ZAFiySQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Add test cases for the bits iter:
> > - positive case
> >   - bit mask smaller than 8 bytes
> >   - a typical case of having 8-byte bit mask
> >   - another typical case where bit mask is > 8 bytes
> >   - the index of set bit
> >
> > - nagative cases
> >   - bpf_iter_bits_destroy() is required after calling
> >     bpf_iter_bits_new()
> >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> >   - bpf_iter_bits_next() must use an initialized iter
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++++++
> >  2 files changed, 162 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_ite=
r.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index c4f9f306646e..7e04ecaaa20a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -84,6 +84,7 @@
> >  #include "verifier_xadd.skel.h"
> >  #include "verifier_xdp.skel.h"
> >  #include "verifier_xdp_direct_packet_access.skel.h"
> > +#include "verifier_bits_iter.skel.h"
> >
> >  #define MAX_ENTRIES 11
> >
> > @@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { RUN=
(verifier_var_off); }
> >  void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
> >  void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
> >  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_d=
irect_packet_access); }
> > +void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> >
> >  static int init_test_val_map(struct bpf_object *obj, char *map_name)
> >  {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/t=
ools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > new file mode 100644
> > index 000000000000..2f7b62b25638
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> > @@ -0,0 +1,160 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include "bpf_misc.h"
> > +#include "task_kfunc_common.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr=
__ign,
> > +                     u32 nr_bits) __ksym __weak;
> > +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> > +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
> > +
> > +SEC("iter.s/cgroup")
> > +__description("bits iter without destroy")
> > +__failure __msg("Unreleased reference")
> > +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cg=
rp)
> > +{
> > +       struct bpf_iter_bits it;
> > +       struct task_struct *p;
> > +
> > +       p =3D bpf_task_from_pid(1);
> > +       if (!p)
> > +               return 1;
> > +
> > +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> > +
> > +       bpf_iter_bits_next(&it);
> > +       bpf_task_release(p);
> > +       return 0;
> > +}
> > +
> > +SEC("iter/cgroup")
> > +__description("bits iter with uninitialized iter in ->next()")
> > +__failure __msg("expected an initialized iter_bits as arg #1")
> > +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *c=
grp)
> > +{
> > +       struct bpf_iter_bits *it =3D NULL;
> > +
> > +       bpf_iter_bits_next(it);
> > +       return 0;
> > +}
> > +
> > +SEC("iter/cgroup")
> > +__description("bits iter with uninitialized iter in ->destroy()")
> > +__failure __msg("expected an initialized iter_bits as arg #1")
> > +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup=
 *cgrp)
> > +{
> > +       struct bpf_iter_bits it =3D {};
> > +
> > +       bpf_iter_bits_destroy(&it);
> > +       return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bits copy 32")
> > +__success __retval(10)
> > +int bits_copy32(void)
> > +{
> > +       /* 21 bits:             --------------------- */
> > +       u32 data =3D 0b11111101111101111100001000100101U;
>
> if you define this bit mask as an array of bytes, then you won't have
> to handle big-endian in the tests at all

This test case provides a clear example of iterating over data of type
u32, offering valuable guidance for users who need to perform such
iterations.

>
>
> > +       int nr =3D 0, offset =3D 0;
> > +       int *bit;
> > +
> > +#if defined(__TARGET_ARCH_s390)
> > +       offset =3D sizeof(u32) - (21 + 7) / 8;
> > +#endif
> > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
> > +               nr++;
> > +       return nr;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bits copy 64")
> > +__success __retval(18)
> > +int bits_copy64(void)
> > +{
> > +       /* 34 bits:         ~-------- */
> > +       u64 data =3D 0xffffefdf0f0f0f0fUL;
> > +       int nr =3D 0, offset =3D 0;
> > +       int *bit;
> > +
> > +#if defined(__TARGET_ARCH_s390)
> > +       offset =3D sizeof(u64) - (34 + 7) / 8;
> > +#endif
> > +
> > +       bpf_for_each(bits, bit, ((char *)&data) + offset, 34)
>
> see above about byte array, but if we define different (not as byte
> array but long[]), it would be cleaner to have

This test case demonstrates how to iterate over data of type u64.

>
> #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> u64 data =3D 0x......UL;
> #else
> u64 data =3D 0x......UL;
> #endif

looks good.

>
> wherer we'd hard-code bit masks in proper endianness in one place and
> then just do a clean `bpf_for_each(bits, bit, &data, <len>) {}` calls
>
> > +               nr++;
> > +       return nr;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bits memalloc long-aligned")
> > +__success __retval(32) /* 16 * 2 */
> > +int bits_memalloc(void)
> > +{
> > +       char data[16];
> > +       int nr =3D 0;
> > +       int *bit;
> > +
> > +       __builtin_memset(&data, 0x48, sizeof(data));
> > +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> > +               nr++;
> > +       return nr;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bits memalloc non-long-aligned")
> > +__success __retval(85) /* 17 * 5*/
> > +int bits_memalloc_non_aligned(void)
> > +{
> > +       char data[17];
> > +       int nr =3D 0;
> > +       int *bit;
> > +
> > +       __builtin_memset(&data, 0x1f, sizeof(data));
> > +       bpf_for_each(bits, bit, &data, sizeof(data) * 8)
> > +               nr++;
> > +       return nr;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bits memalloc non-aligned-bits")
> > +__success __retval(27) /* 8 * 3 + 3 */
> > +int bits_memalloc_non_aligned_bits(void)
> > +{
> > +       char data[16];
> > +       int nr =3D 0;
> > +       int *bit;
> > +
> > +       __builtin_memset(&data, 0x31, sizeof(data));
> > +       /* Different with all other bytes */
> > +       data[8] =3D 0xf7;
> > +
> > +       bpf_for_each(bits, bit, &data,  68)
> > +               nr++;
> > +       return nr;
> > +}
> > +
> > +
> > +SEC("syscall")
> > +__description("bit index")
> > +__success __retval(8)
> > +int bit_index(void)
> > +{
> > +       u64 data =3D 0x100;
> > +       int bit_idx =3D 0;
> > +       int *bit;
> > +
> > +       bpf_for_each(bits, bit, &data, 64) {
> > +               if (*bit =3D=3D 0)
> > +                       continue;
> > +               bit_idx =3D *bit;
> > +       }
> > +       return bit_idx;
> > +}
> > --
> > 2.30.1 (Apple Git-130)
> >



--=20
Regards
Yafang

