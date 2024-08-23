Return-Path: <bpf+bounces-37979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868695D5D0
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD78B22E62
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7771B191499;
	Fri, 23 Aug 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="P2qwEJ2L"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067518488
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439944; cv=none; b=XxYfm3cEkcpVS/2oth83GH8Kj1cD9KQbt5NBDwsbo8eEeq9XtAA8uhU2Aul41lQkU6TqR2fxKvnA65f8Y9Qx01GnurGzkmViuS01CVbc9fYpXqdPLKnpJdWKtnPdqcUHPfOgYOFJGJphQiItwElCW7KHBVzJ5KIXLv4LHBQPSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439944; c=relaxed/simple;
	bh=6UyxloMPYEuOkLIAhYMsnrjcCLL1KGadihGXavB3Pp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciTxcoHW70ypYPGMCBQPa64OWvw62B4nnU9CV17Pips7FJ3Vp9/gqieWdhMXgcMZLa6gpAHQuTa5LtXB+wimnNdY0K/hGZzUF8H8RsXba+1yaNe2Kj+p9KCNgxhMPRCvznjlOEoeifPuKz9dpOamsweDwdNvU6343dWu5m8hpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=P2qwEJ2L; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724439941; x=1725044741; i=linux@jordanrome.com;
	bh=LElSnHjuhkwTTPTXkADAaahDuOObTQzQ1vqAxnCniDY=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P2qwEJ2LrzFrBz3AP4ERNF9r6S3YDY0M0AMqELI/riP4slI+JmKgtNqczYxN78Lc
	 Tlk/SvWoir9xOooWin60wo0kpFN3pN0vrIjGlIEpETEZeOZ7auqbmyyvdinacWJkO
	 9BPn95MLBhjmjbW16fBRiKOnu5F/lAKzQYtZouBAaKlux0U9fcj3wfoRH4HGYMjl3
	 ZrotnaR7r4KQgkGawHEbNjhUOvpsSi8nHiYmvSRZhJU0NOBhgiA8LUYObQbFrtJUo
	 BZQauQwHvwUlgqeRwIqzQ4MX9SCqrNxsJ+ROAPlQn5ssOTThjmgWUTW+1+pPl9p8Z
	 6tKE0QjbWzDbgnTLVg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f181.google.com ([209.85.166.181]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mzh89-1rvE7201eT-00yXAn for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 21:05:41
 +0200
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d22965434so10962375ab.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:05:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVPpoco3nsYb4n+RcCwrq5j5lloeReQEdlSFPqwQpqXHUqNrY6
	Hk6bKm8R92zkHU/kaIFfjOCBKfpdAHlkXaigaRTXIU0eVPTTvIz9J6o3TU6R5EcypBcWVpfWzMR
	VKL751xmxOmkLyzzjfWaNxYZWaKU=
X-Google-Smtp-Source: AGHT+IHFW5zU0uH4QjdRvFBpb2G9C16+tNd17BqAN3fO+Q2bd0AP1+j+lexq5uVDgetY+ZheHJdXyqAvOu0RIHG7lnM=
X-Received: by 2002:a05:6e02:12ea:b0:399:df91:bf57 with SMTP id
 e9e14a558f8ab-39e3bd5d4a8mr27982065ab.0.1724439940529; Fri, 23 Aug 2024
 12:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823184823.3236004-1-linux@jordanrome.com>
 <20240823184823.3236004-2-linux@jordanrome.com> <CAEf4BzaRRwDCfH7D_BLdxU7j+RZAYE1AQtbGfzRp-3A-q-KiGw@mail.gmail.com>
In-Reply-To: <CAEf4BzaRRwDCfH7D_BLdxU7j+RZAYE1AQtbGfzRp-3A-q-KiGw@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Fri, 23 Aug 2024 15:05:29 -0400
X-Gmail-Original-Message-ID: <CA+QiOd5KDFrZkWpWU7m-H8YcxU5TvSkpA4sA24JVLXDCuekW_Q@mail.gmail.com>
Message-ID: <CA+QiOd5KDFrZkWpWU7m-H8YcxU5TvSkpA4sA24JVLXDCuekW_Q@mail.gmail.com>
Subject: Re: [bpf-next v9 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hAse/49hLQCj3pFIBF21/WzrEUmnG6kIKNHC6A3+hVBFGZIf2H/
 guSu5M5JANdj7+qu+6+Ak9QSVxE6LIfTYM3Rkz/mOqFB00NQhTthGK3D48u9cHLTJAXcasd
 GboE6r5CHLmE/RmZfMsq5TSoJDeCB5loBLFyGuGT6HwDYsPZRCafF1abrGyoZN6Pd9pm6sd
 yedrLgNgPDKsOOJjOXcSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MLiFzzMdPIE=;iFkUKEBiSiJehUTGiJ2ZavN8wjp
 4XzEjoibIad30C34PLWjotOQpHEYuTdqDN0t5UbPSbzkYBr6tB625FSAuVH2zF/pga8fHXjcf
 1ed52CsOXJ2p78YAmwC08LebnU/yM3Yod/qp4/ICaMMK2rRb/7wlr99Axas1VK8QThh1DLF71
 8Ko6wCFA96Tdvo1zuC98YcALexRWPnaBAfDeBqmzM611UTama0gjpmhocvI04zY4r5iZRnjKu
 MLPNg/DAigkFc5px1a5Nbh78bCr1ZAVabfu+6ZGP8JTidb3ldPZvifuFLFQTuvn7bO8LaQxc+
 Uq7eH1orL31EcCeoth/PseIn+qnGNclKbOJHG1c7fvKhU8WInHo1qd2ftKeepqWo4zDQvixRP
 giBfJdUZlKlzPXvxw6EXleRkTNw2kOUuQlia14yVQJpu0huiPPBc9LPBsbl4i1zfo7ZJ0eRxT
 mD8LhSTquA0Dj8m1Nswb9YW+sFRGQo69J9JIpvb82XG2k8otNMJDca55rtHLQCTly9IpMdUOy
 7A5tkHUyMikAuitwdvhszXfR0Ak07y8knQgEPGwCjM47ei/H2zjYuiD3WWXmC9k4C5r2AJfFC
 lxH3udO8ldG0/sfHC0XhnVYFX8FG8u3dKZr+N5Nxn98df0h6MDofvpaXvDR96t0KiBhB6sGC8
 rm+ko0+OcwgDR0CaDKF6qF6wz2OJKDdDecJKSoypqXk87836LbuV745IMX9FAxhPZ6uV60zO+
 2XEaFrP72Mhuw7dRHZLVKbNzpy2aZddYA==

On Fri, Aug 23, 2024 at 3:00=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 11:49=E2=80=AFAM Jordan Rome <linux@jordanrome.co=
m> wrote:
> >
> > This adds tests for both the happy path and
> > the error path.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
> >  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
> >  .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
> >  .../selftests/bpf/progs/test_attach_probe.c   | 64 ++++++++++++++++++-
> >  4 files changed, 75 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/to=
ols/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 7175af39134f..329c7862b52d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_atta=
ch_probe *skel)
> >         trigger_func3();
> >
> >         ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_up=
robe_byname3_sleepable_res");
> > -       ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byna=
me3_res");
> > -       ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "chec=
k_uretprobe_byname3_sleepable_res");
> > -       ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprob=
e_byname3_res");
> > +       ASSERT_EQ(skel->bss->uprobe_byname3_str_sleepable_res, 10, "che=
ck_uprobe_byname3_str_sleepable_res");
> > +       ASSERT_EQ(skel->bss->uprobe_byname3_res, 11, "check_uprobe_byna=
me3_res");
> > +       ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 12, "chec=
k_uretprobe_byname3_sleepable_res");
> > +       ASSERT_EQ(skel->bss->uretprobe_byname3_str_sleepable_res, 13, "=
check_uretprobe_byname3_str_sleepable_res");
> > +       ASSERT_EQ(skel->bss->uretprobe_byname3_res, 14, "check_uretprob=
e_byname3_res");
> >  }
> >
> >  void test_attach_probe(void)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/t=
ools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > index 3405923fe4e6..c7b9ba8b1d06 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > @@ -23,6 +23,7 @@ struct read_ret_desc {
> >         { .name =3D "probe_read_user_str", .ret =3D -EFAULT },
> >         { .name =3D "copy_from_user", .ret =3D -EFAULT },
> >         { .name =3D "copy_from_user_task", .ret =3D -EFAULT },
> > +       { .name =3D "copy_from_user_str", .ret =3D -EFAULT },
> >  };
> >
> >  void test_read_vsyscall(void)
> > diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/=
testing/selftests/bpf/progs/read_vsyscall.c
> > index 986f96687ae1..39ebef430059 100644
> > --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> > +#include "vmlinux.h"
> >  #include <linux/types.h>
> >  #include <bpf/bpf_helpers.h>
> >
> > @@ -7,10 +8,15 @@
> >
> >  int target_pid =3D 0;
> >  void *user_ptr =3D 0;
> > -int read_ret[8];
> > +int read_ret[9];
> >
> >  char _license[] SEC("license") =3D "GPL";
> >
> > +/*
> > + * This is the only kfunc, the others are helpers
> > + */
> > +int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak _=
_ksym;
> > +
> >  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >  int do_probe_read(void *ctx)
> >  {
> > @@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
> >         read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
> >         read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_=
ptr,
> >                                               bpf_get_current_task_btf(=
), 0);
> > +       read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf)=
, user_ptr, 0);
> >
> >         return 0;
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/to=
ols/testing/selftests/bpf/progs/test_attach_probe.c
> > index 68466a6ad18c..0b16502726f8 100644
> > --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > @@ -5,6 +5,7 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_core_read.h>
> > +#include <errno.h>
> >  #include "bpf_misc.h"
> >
> >  int kprobe2_res =3D 0;
> > @@ -14,10 +15,15 @@ int uretprobe_byname_res =3D 0;
> >  int uprobe_byname2_res =3D 0;
> >  int uretprobe_byname2_res =3D 0;
> >  int uprobe_byname3_sleepable_res =3D 0;
> > +int uprobe_byname3_str_sleepable_res =3D 0;
> >  int uprobe_byname3_res =3D 0;
> >  int uretprobe_byname3_sleepable_res =3D 0;
> > +int uretprobe_byname3_str_sleepable_res =3D 0;
> >  int uretprobe_byname3_res =3D 0;
> >  void *user_ptr =3D 0;
> > +u32 dynamic_sz =3D 1;
> > +
> > +int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak _=
_ksym;
> >
> >  SEC("ksyscall/nanosleep")
> >  int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, st=
ruct __kernel_timespec *rem)
> > @@ -87,11 +93,61 @@ static __always_inline bool verify_sleepable_user_c=
opy(void)
> >         return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
> >  }
> >
> > +static __always_inline bool verify_sleepable_user_copy_str(void)
> > +{
> > +       int ret;
> > +       char data_long[20];
> > +       char data_long_pad[20];
> > +       char data_long_err[20];
> > +       char data_short[4];
> > +       char data_short_pad[4];
> > +
> > +       ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), =
user_ptr, 0);
> > +
> > +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_short_pad, sizeof(data_shor=
t_pad), user_ptr, BPF_F_PAD_ZEROS);
> > +
> > +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> > +               return false;
> > +
> > +       // Make sure this passes the verifier
>
> also please don't use C++-style comments
>

Good catch. Will fix.

> > +       ret =3D bpf_copy_from_user_str(data_long, dynamic_sz &=3D sizeo=
f(data_long), user_ptr, 0);
> > +
> > +       if (ret !=3D 0)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), us=
er_ptr, 0);
> > +
> > +       if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=
=3D 10)
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long_pad, sizeof(data_long_=
pad), user_ptr, BPF_F_PAD_ZEROS);
> > +
> > +       if (bpf_strncmp(data_long_pad, 10, "test_data\0") !=3D 0 || ret=
 !=3D 10 || data_long_pad[19] !=3D '\0')
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long_err, sizeof(data_long_=
err), (void *)data_long, BPF_F_PAD_ZEROS);
> > +
> > +       if (ret > 0 || data_long_err[19] !=3D '\0')
> > +               return false;
> > +
> > +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), us=
er_ptr, 2);
> > +
> > +       if (ret !=3D -EINVAL)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> >  SEC("uprobe.s//proc/self/exe:trigger_func3")
> >  int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
> >  {
> >         if (verify_sleepable_user_copy())
> >                 uprobe_byname3_sleepable_res =3D 9;
> > +       if (verify_sleepable_user_copy_str())
> > +               uprobe_byname3_str_sleepable_res =3D 10;
> >         return 0;
> >  }
> >
> > @@ -102,7 +158,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs =
*ctx)
> >  SEC("uprobe//proc/self/exe:trigger_func3")
> >  int handle_uprobe_byname3(struct pt_regs *ctx)
> >  {
> > -       uprobe_byname3_res =3D 10;
> > +       uprobe_byname3_res =3D 11;
> >         return 0;
> >  }
> >
> > @@ -110,14 +166,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
> >  int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
> >  {
> >         if (verify_sleepable_user_copy())
> > -               uretprobe_byname3_sleepable_res =3D 11;
> > +               uretprobe_byname3_sleepable_res =3D 12;
> > +       if (verify_sleepable_user_copy_str())
> > +               uretprobe_byname3_str_sleepable_res =3D 13;
> >         return 0;
> >  }
> >
> >  SEC("uretprobe//proc/self/exe:trigger_func3")
> >  int handle_uretprobe_byname3(struct pt_regs *ctx)
> >  {
> > -       uretprobe_byname3_res =3D 12;
> > +       uretprobe_byname3_res =3D 14;
> >         return 0;
> >  }
> >
> > --
> > 2.43.5
> >

