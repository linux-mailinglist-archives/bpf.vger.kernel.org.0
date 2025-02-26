Return-Path: <bpf+bounces-52664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA3A46787
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA01717F778
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E9223716;
	Wed, 26 Feb 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvW/8VcZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C603223328
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588879; cv=none; b=gV1RzgeT9X7lmYZ319UkIsxSPUOOhejCvMuwewybjAZFZZv5ECA1tpbOwajia8Z2x5PWusfwhrev8IY9/pys6TglIAj1VQmS2sy2pXVGASzH1Um+Tff8wcl1omxl/Ie01UPKPM3ANklREt9ket+WyA1PKAM+0drU+V3u6EXTPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588879; c=relaxed/simple;
	bh=MhBruUqJKHgfV+W7xwhvAhjZhpCc9eGTiRflqJoiP8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr9LELyFEW4o4FHjeOCtFQOgVJIuWhluHHOBJVvYoe9UEzuSA195ZsBZdVO+lJG10vsgakpR6UhZA0A6Mr0Z33mT1v8SJT7qLCMRjge525gzIOe2H9Df5l+iMWBsTI67WTfavupt3+ckk7O3uHfU69YDUG26rMeupJVEwDbp6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvW/8VcZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe93d7a588so110613a91.2
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588877; x=1741193677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh9O93biDzBW0tmR0RFZYR9RULl1GIg7IC/yAGm7Wt4=;
        b=TvW/8VcZY2nUSZT/xwcJXqaycy9ldys1+OXZmeFideJl7PoQZ3pZYfD4iwsnqf/HoH
         nrGPWdIUAht6RKETiLBDIPQRj64w9/ILnvqtVxWbxINVBWAYFGc8IP0+D8fu+bpB4rrN
         UaosOx1YBjrh/6Hpgg17LB4HMTYRaMN7fNS0F6CtbnGlgzS39gE494yfPbnL4YgQZajg
         yO30AFXNiaL1uuU6Yn/gINXKxDxgJkFdJPAoAOVGBwVy/RDmdVWtGvfs/f8L5aS/G6S6
         e7Crx87azhFJqKPFsjbiXNUYzDVhFNXqzY19FMttf8aSNvaR0xVj5LzMkWxGi6Zu8OY6
         bH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588877; x=1741193677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh9O93biDzBW0tmR0RFZYR9RULl1GIg7IC/yAGm7Wt4=;
        b=UwhawUsero3YfIKrznUArU4HODUYI/D/OPpoZRuk20OJelHzh9/pR0KuGnYbVWMzCQ
         4/rQq9CS3XCiRxJxhQP2JowpgjFS/dSFYwGRfVkOKXHO2pT4i2zhE4ftpk4/BWjYpkwN
         73CMheY3YHt/8MNhzUEixUOL2sINi+GmQ9c/7cdiGHC+dOUbDrDe/4wFc8snSqTRQPCU
         rMz6ma2GAH140ecCa8AS36j5Lx7rKwveyXX75YMYFBvJNzWD7C2DZFEu9qkKtH8+hhMX
         B3CTFHkbG4Dv6JDcPiPBXqCqYMUb7e1f4IdTzFaKE8gxXNqJiN/F+8PDmLk9gtRy4LxG
         Fd0w==
X-Gm-Message-State: AOJu0YxCIK/SvRbtkT1qeFxG4gO5dXrj9OgO3ennj6b2oddXjHad4eMU
	kP66DFbgOMUxC5SexMoLohB2WxHDsWz5O6sN53J6USm5PeJE1ZoHzDwlxTtqqEM43SYysHgc+j6
	CsgBzJyHijrSqlkXSL4ejLvl+SyA=
X-Gm-Gg: ASbGncupPIBkOzn0j3DYEBGuNnNrM3sZPdteGUonSml9Et24XBp8SOaDxXV4dkmkkml
	lmOznoMaVbU7mfYbCGiA4U9yggw1qGd2DCZnGKQTnkhtu1Nq3hiuo6TtPpaKqMuNNy9GTWhjrCr
	EuwNLfenCpZbSwIoS6cP/enXUZXsXQ1k1KJnoeXHoXcw==
X-Google-Smtp-Source: AGHT+IF63yVCII5B1tHLUtO4EmmJxJsUwvEkUtYIBba/FzBGd1/iY3Tal2bji3FULvGPxq8am1b65afnd5Jk52CyO9A=
X-Received: by 2002:a17:90b:270d:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2fe68ae2a2dmr11786798a91.19.1740588877132; Wed, 26 Feb 2025
 08:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com> <20250221221400.672980-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250221221400.672980-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Feb 2025 08:54:25 -0800
X-Gm-Features: AQ5f1JqZ9xiV2ZFuO5kg1F0KuYDA-PlASpUkhPrBrVKxxd18J4h5CjtqyEdYC_8
Message-ID: <CAEf4BzbLAgWBxu8zbmAw+hNLDcYjZvyk+Lu5YCoBSXGY55GXug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add tests for bpf_dynptr_copy
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:14=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add XDP setup type for dynptr tests, enabling testing for
> non-contiguous buffer.
> Add 2 tests:
>  - test_dynptr_copy - verify correctness for the fast (contiguous
>  buffer) code path.
>  - test_dynptr_copy_xdp - verifies code paths that handle
>  non-contiguous buffer.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  21 ++++
>  .../selftests/bpf/progs/dynptr_success.c      | 112 +++++++++++++++++-
>  2 files changed, 128 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index b614a5272dfd..e29cc16124c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -10,6 +10,7 @@ enum test_setup_type {
>         SETUP_SYSCALL_SLEEP,
>         SETUP_SKB_PROG,
>         SETUP_SKB_PROG_TP,
> +       SETUP_XDP_PROG,
>  };
>
>  static struct {
> @@ -18,6 +19,8 @@ static struct {
>  } success_tests[] =3D {
>         {"test_read_write", SETUP_SYSCALL_SLEEP},
>         {"test_dynptr_data", SETUP_SYSCALL_SLEEP},
> +       {"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
> +       {"test_dynptr_copy_xdp", SETUP_XDP_PROG},
>         {"test_ringbuf", SETUP_SYSCALL_SLEEP},
>         {"test_skb_readonly", SETUP_SKB_PROG},
>         {"test_dynptr_skb_data", SETUP_SKB_PROG},
> @@ -120,6 +123,24 @@ static void verify_success(const char *prog_name, en=
um test_setup_type setup_typ
>
>                 break;
>         }
> +       case SETUP_XDP_PROG:
> +       {
> +               char data[5000];
> +               int err, prog_fd;
> +               LIBBPF_OPTS(bpf_test_run_opts, opts,
> +                           .data_in =3D &data,
> +                           .data_size_in =3D sizeof(data),
> +                           .repeat =3D 1,
> +               );
> +
> +               prog_fd =3D bpf_program__fd(prog);
> +               err =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +               if (!ASSERT_OK(err, "test_run"))
> +                       goto cleanup;
> +
> +               break;
> +       }
>         }
>
>         ASSERT_EQ(skel->bss->err, 0, "err");
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
> index bfcc85686cf0..dd10411d1c02 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -1,20 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2022 Facebook */
>
> +#include <vmlinux.h>
>  #include <string.h>
>  #include <stdbool.h>
> -#include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
> -#include "bpf_kfuncs.h"
>  #include "errno.h"
>
>  char _license[] SEC("license") =3D "GPL";
>
>  int pid, err, val;
>
> -struct sample {
> +struct ringbuf_sample {
>         int pid;
>         int seq;
>         long value;
> @@ -121,7 +120,7 @@ int test_dynptr_data(void *ctx)
>
>  static int ringbuf_callback(__u32 index, void *data)
>  {
> -       struct sample *sample;
> +       struct ringbuf_sample *sample;
>
>         struct bpf_dynptr *ptr =3D (struct bpf_dynptr *)data;
>
> @@ -138,7 +137,7 @@ SEC("?tp/syscalls/sys_enter_nanosleep")
>  int test_ringbuf(void *ctx)
>  {
>         struct bpf_dynptr ptr;
> -       struct sample *sample;
> +       struct ringbuf_sample *sample;
>
>         if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
>                 return 0;
> @@ -567,3 +566,106 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, voi=
d *location)
>
>         return 1;
>  }
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_copy(void *ctx)
> +{
> +       char data[] =3D "hello there, world!!";
> +       char buf[32] =3D {'\0'};
> +       __u32 sz =3D sizeof(data);
> +       struct bpf_dynptr src, dst;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
> +
> +       /* Test basic case of copying contiguous memory backed dynptrs */
> +       err =3D bpf_dynptr_write(&src, 0, data, sz, 0);
> +       err =3D err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
> +       err =3D err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
> +       err =3D err ?: __builtin_memcmp(data, buf, sz);
> +
> +       /* Test that offsets are handled correctly */
> +       err =3D err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
> +       err =3D err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
> +       err =3D err ?: __builtin_memcmp(data + 5, buf, sz - 5);
> +
> +       bpf_ringbuf_discard_dynptr(&src, 0);
> +       bpf_ringbuf_discard_dynptr(&dst, 0);
> +       return 0;
> +}
> +
> +SEC("xdp")
> +int test_dynptr_copy_xdp(struct xdp_md *xdp)
> +{
> +       struct bpf_dynptr ptr_buf, ptr_xdp;
> +       char data[] =3D "qwertyuiopasdfghjkl";
> +       char buf[32] =3D {'\0'};
> +       __u32 len =3D sizeof(data);
> +       int i, chunks =3D 200;
> +
> +       /* ptr_xdp is backed by non-contiguous memory */
> +       bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
> +
> +       /* Destination dynptr is backed by non-contiguous memory */
> +       bpf_for(i, 0, chunks) {
> +               err =3D bpf_dynptr_write(&ptr_buf, i * len, data, len, 0)=
;
> +               if (err)
> +                       goto out;
> +       }
> +
> +       err =3D bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
> +       if (err)
> +               goto out;
> +
> +       bpf_for(i, 0, chunks) {
> +               __builtin_memset(buf, 0, sizeof(buf));
> +               err =3D bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
> +               if (err)
> +                       goto out;
> +               if (__builtin_memcmp(data, buf, len) !=3D 0)

Ok, so with GCC-BPF (see [0]) there is something wrong, seems like GCC
doesn't "inline" __builtin_memcmp() and falls back to calling actual
memcmp(). This is strange, as your buffer is pretty small (32 bytes),
so it should have been inlined. Jose, can you please take a look from
GCC-BPF side?

Meanwhile, Mykyta, can you please implement __builtin_memcp() using
bpf_for() loop logic to unblock landing this? Thanks!

pw-bot: cr


  [0] https://github.com/kernel-patches/bpf/actions/runs/13548082739/job/37=
865378205


> +                       goto out;
> +       }
> +
> +       /* Source dynptr is backed by non-contiguous memory */
> +       __builtin_memset(buf, 0, sizeof(buf));
> +       bpf_for(i, 0, chunks) {
> +               err =3D bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       err =3D bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
> +       if (err)
> +               goto out;
> +
> +       bpf_for(i, 0, chunks) {
> +               __builtin_memset(buf, 0, sizeof(buf));
> +               err =3D bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
> +               if (err)
> +                       goto out;
> +               if (__builtin_memcmp(data, buf, len) !=3D 0)
> +                       goto out;
> +       }
> +
> +       /* Both source and destination dynptrs are backed by non-contiguo=
us memory */
> +       err =3D bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunks=
 - 1));
> +       if (err)
> +               goto out;
> +
> +       bpf_for(i, 0, chunks - 1) {
> +               __builtin_memset(buf, 0, sizeof(buf));
> +               err =3D bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len,=
 0);
> +               if (err)
> +                       goto out;
> +               if (__builtin_memcmp(data, buf, len) !=3D 0)
> +                       goto out;
> +       }
> +
> +       if (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) !=
=3D -E2BIG)
> +               err =3D 1;
> +
> +out:
> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> +       return XDP_DROP;
> +}
> --
> 2.48.1
>

