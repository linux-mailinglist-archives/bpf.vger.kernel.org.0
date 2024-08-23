Return-Path: <bpf+bounces-37978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69C95D5AA
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B696C28353B
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF8192588;
	Fri, 23 Aug 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGyo460t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2B191F7E
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439601; cv=none; b=oN5ZeOc8W0sbNbtx6RfcXTiBGOgVctOPKy+0Jap0yxDtfTNeIUUslw5PbSClnQ54CTZ2MoFLoFv1Vp0JNJeV9BTPetLtYFQt2CPPZKteIXOipm08NrvoOYYPxgNyzpBKYZrpmvXz69AY3VCRVi7y5uUTKcggNFdz+Qo1OM5XBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439601; c=relaxed/simple;
	bh=N4rIt1Wj3vbFxALUtjHFvbtzh6R78ZZMI9ivObeQBxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFUJX8pONK0zTt0d3qA8wsNHeLLikvzP9mb3bcGWNRpnq+6NhYMaJZjee+YnkhcVexsyLr4KYcyYd3sYhE55wNH56KpZX+rUzEKGVxbBvtwSJsMB7+bI3u3M7uJ7YAp0rC3kGJqPzSqtOnI9EDpqlIABSedwEKloUn0OB9RqgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGyo460t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86a0b5513aso148393066b.1
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439598; x=1725044398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5atdaonwvc3+hlXoAS4QaWZ3JdWcXafw3z1vUQ4XXGM=;
        b=NGyo460td8QR6r6VKhhwcwIci8mazy6coqgQ5osvDLHfVfVTRcPDVECLQnIRrgBXJx
         I+XMC1cqfPEstTLRsfqZjsYw8ezobhOO1d4tKbt/OHQoSlYPxKLusxsl93rcHuorGhsG
         AuA6Ft+LpoS+1jdXbXAD4+ZLcbG5Cdj0BHzdWSSinAEa7v9T9qagKuLGHxRILMTMubv5
         IVgDgcwn3JS6MU2ydQnzFORLsKozbWD9IxRbG/14Xe57IbLuWUVnVHqXQO/tsgDYomNw
         ogY8cIY50JEiwiZpO1ZPyWfDUJWc/gGAuUUrrkJiNoCLMca2KAcQ/wK0fdNBPYgAXlhM
         8Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439598; x=1725044398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5atdaonwvc3+hlXoAS4QaWZ3JdWcXafw3z1vUQ4XXGM=;
        b=NTfGbEbHciUsvsFdam/Mx7rnMgp6CncX/xFUlAh2X45DE4rCPTWJ83m44AGjnJuLeQ
         vJJttz/QhFIUs65vgfBUen3qfuc2gODPxs+oLbipMfnl2xinsXWF/16yqOPhqE5QkagB
         iSkL49xWchPqjg3zLRrbOtLG0fN1JpVx+jjOkEgZ9I14Bn04YxlyiSBmxezA7qS6iOwK
         F5wYk5bufJuzW8Vill7L48YSjT60Qoex5oUQucnypQO4HjD3VTuhfNDYQ2X/L+rsvZs+
         XSTLwruh3qhhx2SN92AdrgT0+bI8Uir1boRMtTLGb6qBDmXAJIZCuOxws1JutkJdzXeg
         Pzzw==
X-Gm-Message-State: AOJu0YzYi5UkC+/k1kF9sRjlc14KS1QeXsqg4kFjnq5jM5jdv6CDteNK
	VOolWMSplhlnmUJOTcc56rzzqnJoe1ieyIFs3ESijqGBYggZiYn9Z1OT/3T/YnyTyPPvDarVahN
	1UnocZYXocqIDgVjnZUu2MR352ks=
X-Google-Smtp-Source: AGHT+IFk/luWBrcs9xgEcBBMQex47d4wwWnJFXq17rf3DJHm+1IKFpTto2GarZXmNCNES8LVfAPj6wuEYJ9omuVEjlI=
X-Received: by 2002:a17:907:868f:b0:a7a:aa35:408c with SMTP id
 a640c23a62f3a-a86a5188e44mr160660866b.8.1724439597589; Fri, 23 Aug 2024
 11:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823184823.3236004-1-linux@jordanrome.com> <20240823184823.3236004-2-linux@jordanrome.com>
In-Reply-To: <20240823184823.3236004-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 11:59:40 -0700
Message-ID: <CAEf4BzaRRwDCfH7D_BLdxU7j+RZAYE1AQtbGfzRp-3A-q-KiGw@mail.gmail.com>
Subject: Re: [bpf-next v9 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:49=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> This adds tests for both the happy path and
> the error path.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++-
>  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
>  .../selftests/bpf/progs/read_vsyscall.c       |  9 ++-
>  .../selftests/bpf/progs/test_attach_probe.c   | 64 ++++++++++++++++++-
>  4 files changed, 75 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 7175af39134f..329c7862b52d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_attach=
_probe *skel)
>         trigger_func3();
>
>         ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_upro=
be_byname3_sleepable_res");
> -       ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname=
3_res");
> -       ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_=
uretprobe_byname3_sleepable_res");
> -       ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_=
byname3_res");
> +       ASSERT_EQ(skel->bss->uprobe_byname3_str_sleepable_res, 10, "check=
_uprobe_byname3_str_sleepable_res");
> +       ASSERT_EQ(skel->bss->uprobe_byname3_res, 11, "check_uprobe_byname=
3_res");
> +       ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 12, "check_=
uretprobe_byname3_sleepable_res");
> +       ASSERT_EQ(skel->bss->uretprobe_byname3_str_sleepable_res, 13, "ch=
eck_uretprobe_byname3_str_sleepable_res");
> +       ASSERT_EQ(skel->bss->uretprobe_byname3_res, 14, "check_uretprobe_=
byname3_res");
>  }
>
>  void test_attach_probe(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/too=
ls/testing/selftests/bpf/prog_tests/read_vsyscall.c
> index 3405923fe4e6..c7b9ba8b1d06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> @@ -23,6 +23,7 @@ struct read_ret_desc {
>         { .name =3D "probe_read_user_str", .ret =3D -EFAULT },
>         { .name =3D "copy_from_user", .ret =3D -EFAULT },
>         { .name =3D "copy_from_user_task", .ret =3D -EFAULT },
> +       { .name =3D "copy_from_user_str", .ret =3D -EFAULT },
>  };
>
>  void test_read_vsyscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/te=
sting/selftests/bpf/progs/read_vsyscall.c
> index 986f96687ae1..39ebef430059 100644
> --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> +#include "vmlinux.h"
>  #include <linux/types.h>
>  #include <bpf/bpf_helpers.h>
>
> @@ -7,10 +8,15 @@
>
>  int target_pid =3D 0;
>  void *user_ptr =3D 0;
> -int read_ret[8];
> +int read_ret[9];
>
>  char _license[] SEC("license") =3D "GPL";
>
> +/*
> + * This is the only kfunc, the others are helpers
> + */
> +int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __k=
sym;
> +
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int do_probe_read(void *ctx)
>  {
> @@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
>         read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
>         read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_pt=
r,
>                                               bpf_get_current_task_btf(),=
 0);
> +       read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), =
user_ptr, 0);
>
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tool=
s/testing/selftests/bpf/progs/test_attach_probe.c
> index 68466a6ad18c..0b16502726f8 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
> +#include <errno.h>
>  #include "bpf_misc.h"
>
>  int kprobe2_res =3D 0;
> @@ -14,10 +15,15 @@ int uretprobe_byname_res =3D 0;
>  int uprobe_byname2_res =3D 0;
>  int uretprobe_byname2_res =3D 0;
>  int uprobe_byname3_sleepable_res =3D 0;
> +int uprobe_byname3_str_sleepable_res =3D 0;
>  int uprobe_byname3_res =3D 0;
>  int uretprobe_byname3_sleepable_res =3D 0;
> +int uretprobe_byname3_str_sleepable_res =3D 0;
>  int uretprobe_byname3_res =3D 0;
>  void *user_ptr =3D 0;
> +u32 dynamic_sz =3D 1;
> +
> +int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __k=
sym;
>
>  SEC("ksyscall/nanosleep")
>  int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, stru=
ct __kernel_timespec *rem)
> @@ -87,11 +93,61 @@ static __always_inline bool verify_sleepable_user_cop=
y(void)
>         return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
>  }
>
> +static __always_inline bool verify_sleepable_user_copy_str(void)
> +{
> +       int ret;
> +       char data_long[20];
> +       char data_long_pad[20];
> +       char data_long_err[20];
> +       char data_short[4];
> +       char data_short_pad[4];
> +
> +       ret =3D bpf_copy_from_user_str(data_short, sizeof(data_short), us=
er_ptr, 0);
> +
> +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_short_pad, sizeof(data_short_=
pad), user_ptr, BPF_F_PAD_ZEROS);
> +
> +       if (bpf_strncmp(data_short, 4, "tes\0") !=3D 0 || ret !=3D 4)
> +               return false;
> +
> +       // Make sure this passes the verifier

also please don't use C++-style comments

> +       ret =3D bpf_copy_from_user_str(data_long, dynamic_sz &=3D sizeof(=
data_long), user_ptr, 0);
> +
> +       if (ret !=3D 0)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user=
_ptr, 0);
> +
> +       if (bpf_strncmp(data_long, 10, "test_data\0") !=3D 0 || ret !=3D =
10)
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long_pad, sizeof(data_long_pa=
d), user_ptr, BPF_F_PAD_ZEROS);
> +
> +       if (bpf_strncmp(data_long_pad, 10, "test_data\0") !=3D 0 || ret !=
=3D 10 || data_long_pad[19] !=3D '\0')
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long_err, sizeof(data_long_er=
r), (void *)data_long, BPF_F_PAD_ZEROS);
> +
> +       if (ret > 0 || data_long_err[19] !=3D '\0')
> +               return false;
> +
> +       ret =3D bpf_copy_from_user_str(data_long, sizeof(data_long), user=
_ptr, 2);
> +
> +       if (ret !=3D -EINVAL)
> +               return false;
> +
> +       return true;
> +}
> +
>  SEC("uprobe.s//proc/self/exe:trigger_func3")
>  int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
>  {
>         if (verify_sleepable_user_copy())
>                 uprobe_byname3_sleepable_res =3D 9;
> +       if (verify_sleepable_user_copy_str())
> +               uprobe_byname3_str_sleepable_res =3D 10;
>         return 0;
>  }
>
> @@ -102,7 +158,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *c=
tx)
>  SEC("uprobe//proc/self/exe:trigger_func3")
>  int handle_uprobe_byname3(struct pt_regs *ctx)
>  {
> -       uprobe_byname3_res =3D 10;
> +       uprobe_byname3_res =3D 11;
>         return 0;
>  }
>
> @@ -110,14 +166,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
>  int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
>  {
>         if (verify_sleepable_user_copy())
> -               uretprobe_byname3_sleepable_res =3D 11;
> +               uretprobe_byname3_sleepable_res =3D 12;
> +       if (verify_sleepable_user_copy_str())
> +               uretprobe_byname3_str_sleepable_res =3D 13;
>         return 0;
>  }
>
>  SEC("uretprobe//proc/self/exe:trigger_func3")
>  int handle_uretprobe_byname3(struct pt_regs *ctx)
>  {
> -       uretprobe_byname3_res =3D 12;
> +       uretprobe_byname3_res =3D 14;
>         return 0;
>  }
>
> --
> 2.43.5
>

