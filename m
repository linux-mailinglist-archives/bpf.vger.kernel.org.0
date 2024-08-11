Return-Path: <bpf+bounces-36847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180F94E344
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 23:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37A6B2192C
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67715B0E2;
	Sun, 11 Aug 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="fxlRr/u9"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0411537A3
	for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410827; cv=none; b=joPF1p0O3C8GVr6E8woMgd7FISDfKfGVhhex+mLjoXty8ZZ6U5VVsigB4A87+2gqTQdNWwLJ+ZEpyru0QdeBL6eRI7dMnEcUQNPbs6djOnNVrXYP5sW3ec5sflcpBKnn549goPrlMliHStyUwQ1GPQjd8Y+t/1tL2U154BJp1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410827; c=relaxed/simple;
	bh=ODPybyEEMGtApdVl78zoebnTj4r+vFoqCYnCCBdtKnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3xo21UhuolNoA4s7Udk2KdGFOiDaHecufm8WxX03bMxHfcoLq3Yrpo95pRNzKTsoj/oX7ttdI9YQX+Ac8ld4rdxoi4eZI5BcKDKTFZW26Gp7OV12zVBl3D6xW1F9lhmC/oMCVN/kdl7e8T6zx7r7JCM8sb1YydN+32eHaUG5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=fxlRr/u9; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723410818; x=1724015618; i=linux@jordanrome.com;
	bh=OT8PAmOp5SM48VhshJx4gAHOuih0xyDnCLO3rhCe3yw=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fxlRr/u9fUkKnuq6w5NQhiMI6sasP4AzopNS5IqohVpFK010qIjZGr0G+Na16OHK
	 eyhKreFpBvabqLSn9pVxI9VWRz5ofQo8HwIBRtJWcEvaMPU5vPhrpGoZ8t+tlqAMz
	 tac5IWjt1XbJRG//ttHGCqnvkKAotXDcmNzlmXeltOELtFU3/JiIwltbY1fyoTB/P
	 6R1Ew8y6lnYotKlJHOjOXy3SOWXTEHZ5W/fr1OOLHiOz8zN2ZB/A1EGJ2hwu7tZfq
	 EPaaSlu0cxFpWTCUnztLdTkyYQk2zwAY9MGOMaPG1n2gdJwMpBfdZJvX2xFrSknD1
	 eraBXZwg2Dx4ORWWYA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f181.google.com ([209.85.166.181]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LtZ1G-1sE8FT3axY-0177b9 for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 23:08:27
 +0200
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b0826298cso13824815ab.2
        for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 14:08:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXcWPfcq5WnP9B5oTlEelKq8CsOw4rj1EZ9VNOc0M4IJm32eEN
	JC59Ua0nmQOZz1xFNYlkrIT2T/4c/Zcm1p9eTjC45KMokFAYqp4VAt3ZWU/aTVDbsNv1UT4nDbQ
	NCu3HERh1gNJy2QeTWUu65zzd3jo=
X-Google-Smtp-Source: AGHT+IFJW1Yd8x0C6xKkBEBJFeDv7D15p2hWxCm90WGf5CItipv9dEQ77oIl1HQJJ4b49nZeaH28P6wb1z0+BOxekpw=
X-Received: by 2002:a05:6e02:144c:b0:397:351b:2c0c with SMTP id
 e9e14a558f8ab-39b7a449a15mr91656895ab.17.1723410507361; Sun, 11 Aug 2024
 14:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809212301.3782412-1-linux@jordanrome.com> <fb6e876a-82f7-42ad-9b80-17cbcebefd21@gmail.com>
In-Reply-To: <fb6e876a-82f7-42ad-9b80-17cbcebefd21@gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Sun, 11 Aug 2024 17:08:16 -0400
X-Gmail-Original-Message-ID: <CA+QiOd7yVHfxk8CWR+qNWFT=c8JZ6o+p+P=1p9+CA+AbNfBdZQ@mail.gmail.com>
Message-ID: <CA+QiOd7yVHfxk8CWR+qNWFT=c8JZ6o+p+P=1p9+CA+AbNfBdZQ@mail.gmail.com>
Subject: Re: [bpf-next v1] bpf: Add bpf_copy_from_user_str kfunc
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tqVOG5h8MUsivlQOcYzr2q44GxwxxuWLuxVNFH5T0jSHopDIRVx
 W9JUfxm1V0M8O1pRuKOpqnOpgaJN44WUkuzkUzIpcnpWI7iYi56nOg2Te0GQEV0PeGzyzsj
 RZfslFrVxryvSWjWPjYK4LqhdfAcSjez8uWG0zPPHt3bI5UgYON+bmUzgB9OfwJqTwh5SAn
 nLHJfm9/qUv5+Ky6djmBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ko1R+7URL6Q=;jM5YNwmJXqO2cG4TmOW+X7/itSX
 +Ux8DZNDA0ZUE2/BzhTC/yWnFtspnm/4a3SBMggmhULsJwI6QaChIUElseJyolQuQEAqlU1kL
 lN/uF1RkGcx1QTyIe1fThV7WE48zucjKs7oOcRyAXf6BLJYE5B+a847j69Hy2+Do+cOhnlOQI
 1Mm86hLbmGUORHboU6cbbi08SmGdXYwj/2UwNkbzGG+WSNXyfyZ8srovTgxpZZX0E+hXu2Q87
 fkF0NXvQAJUqPoXLeC2OODCa6XPOYlQPHnAuwxIHUwF+uFeShX6QKet8ah4jJNv8jMSUj6Sn5
 orLSMMuooZLC4mCo02UMNs3dW12JSEV7UJFhySqsBsMCE+j9ZEdbLBYWudDsOtyzzbCjm/FKd
 1Yhv4j82Q9SfdUUL1Y550lEliZvMI99GGridCJWe6jrKy/vDMk1vdzZ+h6Jny73J0o03r3a7P
 IYLRHmnysm805rFiVUeDwshzjrE76vrtayZKIpQJP7XXkV1bDB8ej9T4eHbQfrPXrbyUY6f4W
 2WztLydFgvatEqhQGq1YGtHRALVnToVee/toFPIpUz8t6lcEljzeFpyPTWLtfAtA3HpLEfcc4
 ypBNS3YrXCSwd62I4Ow9eYOo1xHQ1lHXdx814x8+PLxaBnXczWvTdblo+LkeBCl1UYnYbr9lq
 SPwqR22BflN30Ia6oj+/TiJlzGMShCrwef7jEufsoDTmbEtIIghfIEni6wUMJGLPjHOy3IRtA
 HhyboU87ZC0A5Ye9nGuZrguVc/tTDZsfQ==

On Sat, Aug 10, 2024 at 2:49=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 8/9/24 14:23, Jordan Rome wrote:
> > This adds a kfunc wrapper around strncpy_from_user,
> > which can be called from sleepable BPF programs.
> >
> > This matches the non-sleepable 'bpf_probe_read_user_str'
> > helper.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >   kernel/bpf/helpers.c                          | 26 ++++++++++++++++++=
+
> >   .../selftests/bpf/prog_tests/attach_probe.c   |  8 +++---
> >   .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
> >   .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++++-
> >   .../selftests/bpf/progs/test_attach_probe.c   | 24 ++++++++++++++---
> >   5 files changed, 61 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index d02ae323996b..455cac7b2631 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2939,6 +2939,31 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bp=
f_iter_bits *it)
> >       bpf_mem_free(&bpf_global_ma, kit->bits);
> >   }
> >
> > +/**
> > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addres=
s
> > + * @dst:             Destination address, in kernel space.  This buffe=
r must be at
> > + *                   least @dst__szk bytes long.
> > + * @dst__szk:        Maximum number of bytes to copy, including the tr=
ailing NUL.
> > + * @unsafe_ptr__ign: Source address, in user space.
> > + *
> > + * Copies a NUL-terminated string from userspace to BPF space. If user=
 string is
> > + * too long this will still ensure zero termination in the dst buffer =
unless
> > + * buffer size is 0.
> > + */
> > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const =
void __user *unsafe_ptr__ign)
> > +{
> > +     int ret;
> > +
> > +     if (unlikely(!dst__szk))
> > +             return 0;
> > +
> > +     ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);
>
> Does this function promise dst is null terminated if ret >=3D 0?
> It seems not to have null at the end if the source string is longer than
> dst_szk.
>
>

Good catch. I need to copy the same logic that exists in
`strncpy_from_user_nofault` which sets the last byte to '\0'.

> > +     if (unlikely(ret < 0))
> > +             memset(dst, 0, dst__szk);
> > +
> > +     return ret;
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   BTF_KFUNCS_START(generic_btf_ids)
> > @@ -3024,6 +3049,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >   BTF_KFUNCS_END(common_btf_ids)
> >
> >   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/to=
ols/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 7175af39134f..329c7862b52d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_atta=
ch_probe *skel)
> >       trigger_func3();
> >
> >       ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_upro=
be_byname3_sleepable_res");
> > -     ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname=
3_res");
> > -     ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_=
uretprobe_byname3_sleepable_res");
> > -     ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_=
byname3_res");
> > +     ASSERT_EQ(skel->bss->uprobe_byname3_str_sleepable_res, 10, "check=
_uprobe_byname3_str_sleepable_res");
> > +     ASSERT_EQ(skel->bss->uprobe_byname3_res, 11, "check_uprobe_byname=
3_res");
> > +     ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 12, "check_=
uretprobe_byname3_sleepable_res");
> > +     ASSERT_EQ(skel->bss->uretprobe_byname3_str_sleepable_res, 13, "ch=
eck_uretprobe_byname3_str_sleepable_res");
> > +     ASSERT_EQ(skel->bss->uretprobe_byname3_res, 14, "check_uretprobe_=
byname3_res");
> >   }
> >
> >   void test_attach_probe(void)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/t=
ools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > index 3405923fe4e6..c7b9ba8b1d06 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > @@ -23,6 +23,7 @@ struct read_ret_desc {
> >       { .name =3D "probe_read_user_str", .ret =3D -EFAULT },
> >       { .name =3D "copy_from_user", .ret =3D -EFAULT },
> >       { .name =3D "copy_from_user_task", .ret =3D -EFAULT },
> > +     { .name =3D "copy_from_user_str", .ret =3D -EFAULT },
> >   };
> >
> >   void test_read_vsyscall(void)
> > diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/=
testing/selftests/bpf/progs/read_vsyscall.c
> > index 986f96687ae1..27de1e907754 100644
> > --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> > +#include "vmlinux.h"
> >   #include <linux/types.h>
> >   #include <bpf/bpf_helpers.h>
> >
> > @@ -7,10 +8,15 @@
> >
> >   int target_pid =3D 0;
> >   void *user_ptr =3D 0;
> > -int read_ret[8];
> > +int read_ret[9];
> >
> >   char _license[] SEC("license") =3D "GPL";
> >
> > +/*
> > + * This is the only kfunc, the others are helpers
> > + */
> > +int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym=
;
> > +
> >   SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >   int do_probe_read(void *ctx)
> >   {
> > @@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
> >       read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
> >       read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_pt=
r,
> >                                             bpf_get_current_task_btf(),=
 0);
> > +     read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), =
user_ptr);
> >
> >       return 0;
> >   }
> > diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/to=
ols/testing/selftests/bpf/progs/test_attach_probe.c
> > index 68466a6ad18c..a90fa0bf103b 100644
> > --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> > @@ -14,11 +14,15 @@ int uretprobe_byname_res =3D 0;
> >   int uprobe_byname2_res =3D 0;
> >   int uretprobe_byname2_res =3D 0;
> >   int uprobe_byname3_sleepable_res =3D 0;
> > +int uprobe_byname3_str_sleepable_res =3D 0;
> >   int uprobe_byname3_res =3D 0;
> >   int uretprobe_byname3_sleepable_res =3D 0;
> > +int uretprobe_byname3_str_sleepable_res =3D 0;
> >   int uretprobe_byname3_res =3D 0;
> >   void *user_ptr =3D 0;
> >
> > +int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym=
;
> > +
> >   SEC("ksyscall/nanosleep")
> >   int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, s=
truct __kernel_timespec *rem)
> >   {
> > @@ -87,11 +91,23 @@ static __always_inline bool verify_sleepable_user_c=
opy(void)
> >       return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
> >   }
> >
> > +static __always_inline bool verify_sleepable_user_copy_str(void)
> > +{
> > +     int ret;
> > +     char data[10];
> > +
> > +     ret =3D bpf_copy_from_user_str(data, sizeof(data), user_ptr);
> > +
> > +     return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0 && r=
et =3D=3D 9;
> > +}
> > +
> >   SEC("uprobe.s//proc/self/exe:trigger_func3")
> >   int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
> >   {
> >       if (verify_sleepable_user_copy())
> >               uprobe_byname3_sleepable_res =3D 9;
> > +     if (verify_sleepable_user_copy_str())
> > +             uprobe_byname3_str_sleepable_res =3D 10;
> >       return 0;
> >   }
> >
> > @@ -102,7 +118,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs =
*ctx)
> >   SEC("uprobe//proc/self/exe:trigger_func3")
> >   int handle_uprobe_byname3(struct pt_regs *ctx)
> >   {
> > -     uprobe_byname3_res =3D 10;
> > +     uprobe_byname3_res =3D 11;
> >       return 0;
> >   }
> >
> > @@ -110,14 +126,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
> >   int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
> >   {
> >       if (verify_sleepable_user_copy())
> > -             uretprobe_byname3_sleepable_res =3D 11;
> > +             uretprobe_byname3_sleepable_res =3D 12;
> > +     if (verify_sleepable_user_copy_str())
> > +             uretprobe_byname3_str_sleepable_res =3D 13;
> >       return 0;
> >   }
> >
> >   SEC("uretprobe//proc/self/exe:trigger_func3")
> >   int handle_uretprobe_byname3(struct pt_regs *ctx)
> >   {
> > -     uretprobe_byname3_res =3D 12;
> > +     uretprobe_byname3_res =3D 14;
> >       return 0;
> >   }
> >
> > --
> > 2.44.1
> >
> >

