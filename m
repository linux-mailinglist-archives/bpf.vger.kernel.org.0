Return-Path: <bpf+bounces-52125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55089A3E966
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7033BFEFD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AF1CAA4;
	Fri, 21 Feb 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh16TbVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278579F2
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099148; cv=none; b=KIELrKG32+85nXgoGIu8XWH1mcc17NoGO7uxKmg9TNRwhZ1NCgifT2C9qQfPFW4Y02ZhJm+KTNUZeDwXdUesifJ5rTs3kDBs2dLg75wUvB2uYFjif5owMYs1Ss4UXuz56jfPl4iCDi/luGDdfh+ka4ukYtDsDr1wMILcp5Af78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099148; c=relaxed/simple;
	bh=YsMywgn546TIHCYV7hXQqFxqg0q82sDBBg7TMLptvFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+2Uzc1NqbmJG1NSKJIp1lKckrxl5v5iA0ruTQt395z1jn2JPAfOl8aAvyeM9y8jJsYrYBV6g7aLKmHzOM8uv4Q6Zh2LY4f+/gxQ2AyXQqdvQ0XsKnJQM3o6NAa5U4bapY8wNrMj2dIlWLyr2oqv7k29sJ8jn8t3mi4cA7n+PRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh16TbVZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso2494981a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099146; x=1740703946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lCOeoWlloc28BKJdvGY3luOn247YTRZElbNnRNMKus=;
        b=Dh16TbVZkylnZ1E23fe4KncFdEDOEwzRiXcoJnLV02wcBFpos9RkXPoaWyAo+xPVqr
         4ZhnYmY63tDjlnp/utF6twWYdNExC3pjfD2Kd0C3Tmyx/j8qTwzj278EsDJr0k8/Rgdp
         GjgCMJ2iAfuvKUqZqWqk0xiaAzk187oHuDGio6U8UoJLRxvPCO24u0Av71L0lmqCvZgE
         HbfPbgY/8L0jXDDD1FyI3Hz7da5sfEuemf37K+FpBpx4OeEB889+bfp8hDSIhU46FkvF
         4j3dSH/HK7h8L3WPHsACymJJjbWovqq7coxmtc/ugmBMgoujqc6O0aKPSP4DGD2qR1gW
         kMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099146; x=1740703946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lCOeoWlloc28BKJdvGY3luOn247YTRZElbNnRNMKus=;
        b=LqChx0FREe4qxh2PyDRJdK9oGqm8EOBo6ZmnfxaptpTa8Mcm7qTLduo4AmzvwYhh3b
         hP8W+l6igKa+xI62gb1JU+odpmmDdsSP4T0RGDp+umEcrTzB8rEYds/S/c7q2iKieSVm
         +exBzrD3ZZnUvy30yaJt9CMynfzT5U0M+nDsqZrYSqp8iDn6JOL2Cbu8xyOIHbO5fFEV
         jQroK11NGQE+0YZ+bArHoI+j1SBXvwH6IyowQNW7CPxpOnEel8YWeLTE+ztsXFT8LTRb
         0+1a8IawPpOQSGtbzjNiijBiwkr+dOJfAks77jJUUgKiSQfwT0yeW72f3CaoyqnqUyBw
         n7ZA==
X-Gm-Message-State: AOJu0Yx62JnPJkhb3GEuqC/ZS6reP/N7eAfmefqIw+XWeHbAOq/KfdSA
	E7P9EvhxDIWMQJH1wICGO0K3W977s8ed21vulYAM17OT9wQ8fEftLn3X3im8ch4Dc9pe5tKuqw7
	kNoWQ8RUp7DSjaHEZ/bdw8SK8K6OY0w==
X-Gm-Gg: ASbGnctdbTzyo5Nq3tRIqPD+sndC533O+zIEeFIoMZGIgr9dhpGzmffQkigpiwSaq5E
	Oj6YfJWGOcQykb0yaEyOXM23zZ3Vm8t1Lp2JBBHVkGg4YOeSWpLUVZMvIO4g0X3U0HUb+3AGMRG
	fgBMYKOr7mIdbx
X-Google-Smtp-Source: AGHT+IHeKk9V0+L7JTAY9FMfGbLO2twjFLgqmXHHJWvQKHptqUbKGZJUVCrQgbq+A4oRe1dUVn9QNSlBUINd1dtfrPQ=
X-Received: by 2002:a17:90b:2e4f:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2fce859ae98mr1756042a91.0.1740099144063; Thu, 20 Feb 2025
 16:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com> <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 16:52:12 -0800
X-Gm-Features: AWEUYZlisy_TW8dsRtIzZI7x8uJFwbGI_RCJtWvwHUSoLV3tvqaFOdXVcO-eWF8
Message-ID: <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_dynptr_copy
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:01=E2=80=AFAM Mykyta Yatsenko
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
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
>  .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++++
>  3 files changed, 110 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 8215c9b3115e..e9c193036c82 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -43,6 +43,14 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynp=
tr *ptr) __ksym __weak;
>  extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak=
;
>  extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dyn=
ptr *clone__init) __ksym __weak;
>
> +/* Description
> + *  Copy data from one dynptr to another
> + * Returns
> + *  Error code
> + */
> +extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u32 dst_off,
> +                          struct bpf_dynptr *src, __u32 src_off, __u32 s=
ize) __ksym __weak;
> +

Do we *need* this? Doesn't all this come from vmlinux.h nowadays?

>  /* Description
>   *  Modify the address of a AF_UNIX sockaddr.
>   * Returns
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index b614a5272dfd..247618958155 100644
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
> @@ -120,6 +123,28 @@ static void verify_success(const char *prog_name, en=
um test_setup_type setup_typ
>
>                 break;
>         }
> +       case SETUP_XDP_PROG:
> +       {
> +               char data[5000];
> +               int err, prog_fd;
> +

no empty line here, opts is a variable

> +               LIBBPF_OPTS(bpf_test_run_opts, opts,
> +                           .data_in =3D &data,
> +                           .data_size_in =3D sizeof(data),
> +                           .repeat =3D 1,
> +               );
> +
> +               prog_fd =3D bpf_program__fd(prog);
> +               if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
> +                       goto cleanup;


we shouldn't check this, if program loaded successfully this will
always be true (and yeah, I know that existing code does that, we
should remove or at least not duplicate this)

> +
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
> index bfcc85686cf0..8a6b35418e39 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -567,3 +567,80 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void=
 *location)
>
>         return 1;
>  }
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int test_dynptr_copy(void *ctx)
> +{
> +       char *data =3D "hello there, world!!";
> +       char buf[32] =3D {'\0'};
> +       __u32 sz =3D strlen(data);

this is fragile, this is not guaranteed to work (only if compiler just
substituted a constant value). maybe just use data[] =3D "hello
there..." and use sizeof(data) then?

> +       struct bpf_dynptr src, dst;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
> +
> +       err =3D bpf_dynptr_write(&src, 0, data, sz, 0);
> +       err =3D err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
> +       err =3D err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
> +       err =3D err ?: __builtin_memcmp(data, buf, sz);
> +
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
> +       char *data =3D "qwertyuiopasdfghjkl;";
> +       char buf[32] =3D {'\0'};
> +       __u32 len =3D strlen(data);

ditto

> +       int i, chunks =3D 200;
> +
> +       bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
> +
> +       bpf_for(i, 0, chunks) {
> +               err =3D  err ?: bpf_dynptr_write(&ptr_buf, i * len, data,=
 len, 0);
> +       }
> +
> +       err =3D err ?: bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * ch=
unks);
> +
> +       bpf_for(i, 0, chunks) {
> +               memset(buf, 0, sizeof(buf));

__builtin_memset(), memset() works only because compiler optimizes it
to built-in, but let's not rely on that

> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, i * l=
en, 0);
> +               err =3D err ?: memcmp(data, buf, len);

__builtin_memcmp() and all the other cases below, please

> +       }
> +
> +       memset(buf, 0, sizeof(buf));
> +       bpf_for(i, 0, chunks) {
> +               err =3D err ?: bpf_dynptr_write(&ptr_buf, i * len, buf, l=
en, 0);
> +       }
> +
> +       err =3D err ?: bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * ch=
unks);
> +
> +       bpf_for(i, 0, chunks) {
> +               memset(buf, 0, sizeof(buf));
> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, i * l=
en, 0);
> +               err =3D err ?: memcmp(data, buf, len);
> +       }
> +
> +       bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> +
> +       err =3D err ?: bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * =
(chunks - 1));
> +
> +       bpf_for(i, 0, chunks - 1) {
> +               memset(buf, 0, sizeof(buf));
> +               err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i=
 * len, 0);
> +               err =3D err ?: memcmp(data, buf, len);
> +       }
> +
> +       err =3D err ?: (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len =
* chunks) =3D=3D -E2BIG ? 0 : 1);

overdoing it a bit with the whole `err ?: ` pattern, IMO


BTW, more questions to networking folks (maybe Martin knows). Is there
a way to setup SKB or XDP packet with a non-linear region for testing?

> +
> +       return XDP_DROP;
> +}
> --
> 2.48.1
>

