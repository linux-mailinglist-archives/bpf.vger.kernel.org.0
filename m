Return-Path: <bpf+bounces-73494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE79C32C53
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F23D427854
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0302D46DB;
	Tue,  4 Nov 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqB7o5Pm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE362D3A6A
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284369; cv=none; b=MHLOmK0Xti99u0lX0mtLEoosDHn2LjNMOOC7RAyYezqRkfISJPx7imsvZvpDzEUvCajdlwgRUyt+5WS+LZjNcoFNEX7hWUmbL/kW1YnunixazLOoMX7wPwHbfFbGNuUIh/efbFGZegAj9HwI5EELztgtP0jPHRvKJf5xAixVx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284369; c=relaxed/simple;
	bh=67UNfqZhAYWMubDm3vCHWN3rZpbzSU5O4DrP7LmnoeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnE1o3A6v+wjAss2SxbIQ3XlxyAUtQSlUN+DMjxWlS9woN4Q25fgYLB9HwGbKuxBkYx3qV4qH/W7WgSWVc9dswy9FGHKU20g7k45GGxhCjceHzug8tPcknNrn0hCbgqOrJhqgNs3VyknV/Iy9SQlmp98agnrqdffvpUse0i43/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqB7o5Pm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-341988c720aso409356a91.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284364; x=1762889164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwAVYhL9BdBkKAgQEax++Z76n7Ya3grnp6EjeTEpSz4=;
        b=AqB7o5Pme2ANzR2YzqGeF+a1OzyqVD8Azg6zKs+aEwc2umevx8qvt373CBMJDlqmRw
         nuNcJh80cwBMf2PZLKI82ibTc3HjYRLCVM+iiQbjeQ7HX1w+oTlURW4Hzojr6bF+6fze
         YBLwhAsTRFIK0R9pMqL3Cwwi5sm8YS0ZFMERrR4O1BqNGk5SSrKcfvQ6isuH0O39BbWX
         X8T3hmdJXKPI7fT3DteWCKa2ETU2cXcfhoX8fA20WC6JMApHNGZX0FY9h/KckGfaZzyQ
         v8r8LHYzuHAYZoM0uXaM5UY4eIQ5ZvylxtcEthks07+fFld/hzh9pF+pIjny3N10Jsod
         OCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284364; x=1762889164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwAVYhL9BdBkKAgQEax++Z76n7Ya3grnp6EjeTEpSz4=;
        b=KLfzs9i37yrs7EegUNEEf2XF9aq07erdQh+60HVu3eZzxvfeN0hfDPDrfss/7YL3Gf
         EMLFVfskx1XxmG7AjRymJ9dzIARuBi7PfhARntI0QqZ+0hGKU6/au3VgAu9XnhLTsmQf
         AHqonaxqI7a6KCQmfUOhRW3dUtcpe/RmYtvxhLq8H95ar4jxrpS6pykA+sZHkxL/naz2
         spbFJXEVlgvS4ftMPDZUbw1hpczTgWMYQ3wWL+DE4gxyzf8qiV5hR9NTi3hR346Qdx4C
         8yUfbzH15YbsM1jECPaca0vOciSpxqChmV0yqXTqRBpXhfmfGYo55w9gK0NKaYZVx54F
         pOTQ==
X-Gm-Message-State: AOJu0YwjqpW6w4HPzJpqhzo1o5BGNOcxSiBoyieCQUli4U/KCY8VRXeL
	CWv8ID7BxVd1twO79uERnSzkdkBIwGOUnJ2bAnS+/m/f9RJzYN71iPvhfRyrfWu1175Tvkn19vT
	/VWAF5qFg3sqtBrXBiIOLmsHpVwzdIEQ=
X-Gm-Gg: ASbGncvX/CsMVO17Sc42shnwAVsfpLK3dWHxmm4ajH7Yiv7ic4tMIPQ/hQzVduYOLLd
	p02XhvlUHauJcDAC+NqbXnGzZwqWcn4nnC0tl9YRGeQgwyIoUdTqbYFMjt6NFC04Sll1jnMEPxP
	iEaeyba5KNMCNUqzyq7j6DcfEdqRUdFq2K48v0W3KdvCTmq0UKT6GPZodf6kPMcKqrbPCaKnTwT
	+ZgQ2G9Pgk7/AJRTfYtmrCsd+yQhYnwg3qNZjM7MxJh1aTr9veGQZZnyvRfAKhs1/xUisjs522v
X-Google-Smtp-Source: AGHT+IGc53GInfRlh/dt8QE08EnT3tHFwPwZZxtnCROPM4cQn6GF4Fht45r9Tgu7VzXQ8SLSkXa9xkhvFNVDVDbc3hA=
X-Received: by 2002:a17:90b:3908:b0:33b:bed8:891e with SMTP id
 98e67ed59e1d1-341a6dcc6b8mr339952a91.19.1762284364160; Tue, 04 Nov 2025
 11:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com> <20251104-implv2-v2-2-6dbc35f39f28@meta.com>
In-Reply-To: <20251104-implv2-v2-2-6dbc35f39f28@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 11:25:50 -0800
X-Gm-Features: AWmQ_bmZxnkCojPZYE7d6GJl8w2rXiov62EDo1LN_z-N03v9YvbFw5V2_Nurg_c
Message-ID: <CAEf4BzYLgHaAZ2D_6z+d2V2erE3_yDgYF=qHEM0e1YCZvovFmQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf:add _impl suffix for bpf_stream_vprintk() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:30=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Rename bpf_stream_vprintk() to bpf_stream_vprintk_impl().
>
> This aligns this recently added kfunc with the naming scheme required
> by the implicit-argument feature.
> In future BTF type for bpf_stream_vprintk() will be generated and
> aux__prog argument filled by the valid struct implicitly.

How about this wording?

This makes bpf_stream_vprintk() follow the already established "_impl"
suffix-based naming convention for kfuncs with the bpf_prog_aux
argument provided by the verifier implicitly. This convention will be
taken advantage of with the upcoming KF_IMPLICIT_ARGS feature to
preserve backwards compatibility to BPF programs.


Other than that, LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c                             |  2 +-
>  kernel/bpf/stream.c                              |  3 ++-
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  2 +-
>  tools/lib/bpf/bpf_helpers.h                      | 28 ++++++++++++------=
------
>  tools/testing/selftests/bpf/progs/stream_fail.c  |  6 ++---
>  5 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 33173b027ccf8893ce18aad474b88f8544f7b344..e4007fea49091c01c1d23af55=
a25f5567417e978 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4380,7 +4380,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif
> -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(common_btf_ids)
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index eb6c5a21c2efee96c41f4c5e43d54062694a4859..ff16c631951bb685e8ecf1707=
206dad603121a65 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -355,7 +355,8 @@ __bpf_kfunc_start_defs();
>   * Avoid using enum bpf_stream_id so that kfunc users don't have to pull=
 in the
>   * enum in headers.
>   */
> -__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, =
const void *args, u32 len__sz, void *aux__prog)
> +__bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__=
str, const void *args,
> +                                       u32 len__sz, void *aux__prog)
>  {
>         struct bpf_bprintf_data data =3D {
>                 .get_bin_args   =3D true,
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf=
/bpftool/Documentation/bpftool-prog.rst
> index 009633294b0934ac282601cf21a0fd03c388de2c..35aeeaf5f71166f0e1e8759da=
8639c2533d47482 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -182,7 +182,7 @@ bpftool prog tracelog
>
>  bpftool prog tracelog { stdout | stderr } *PROG*
>      Dump the BPF stream of the program. BPF programs can write to these =
streams
> -    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may=
 write
> +    at runtime with the **bpf_stream_vprintk_impl**\ () kfunc. The kerne=
l may write
>      error messages to the standard error stream. This facility should be=
 used
>      only for debugging purposes.
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c028540656176376909cb796e56de433ef3aab..d4e4e388e625894f8ec27b5a6=
278dbb46e658720 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -315,20 +315,20 @@ enum libbpf_tristate {
>                           ___param, sizeof(___param));          \
>  })
>
> -extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const=
 void *args,
> -                             __u32 len__sz, void *aux__prog) __weak __ks=
ym;
> -
> -#define bpf_stream_printk(stream_id, fmt, args...)                      =
       \
> -({                                                                      =
       \
> -       static const char ___fmt[] =3D fmt;                              =
         \
> -       unsigned long long ___param[___bpf_narg(args)];                  =
       \
> -                                                                        =
       \
> -       _Pragma("GCC diagnostic push")                                   =
       \
> -       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")           =
       \
> -       ___bpf_fill(___param, args);                                     =
       \
> -       _Pragma("GCC diagnostic pop")                                    =
       \
> -                                                                        =
       \
> -       bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param),=
 NULL);\
> +extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, =
const void *args,
> +                                  __u32 len__sz, void *aux__prog) __weak=
 __ksym;
> +
> +#define bpf_stream_printk(stream_id, fmt, args...)                      =
               \
> +({                                                                      =
               \
> +       static const char ___fmt[] =3D fmt;                              =
                 \
> +       unsigned long long ___param[___bpf_narg(args)];                  =
               \
> +                                                                        =
               \
> +       _Pragma("GCC diagnostic push")                                   =
               \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")           =
               \
> +       ___bpf_fill(___param, args);                                     =
               \
> +       _Pragma("GCC diagnostic pop")                                    =
               \
> +                                                                        =
               \
> +       bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___pa=
ram), NULL);   \
>  })
>
>  /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
> diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/test=
ing/selftests/bpf/progs/stream_fail.c
> index b4a0d0cc8ec8a9483b5967745cd35f8bd940460e..3662515f0107740c147f5a929=
6b4da06fa508364 100644
> --- a/tools/testing/selftests/bpf/progs/stream_fail.c
> +++ b/tools/testing/selftests/bpf/progs/stream_fail.c
> @@ -10,7 +10,7 @@ SEC("syscall")
>  __failure __msg("Possibly NULL pointer passed")
>  int stream_vprintk_null_arg(void *ctx)
>  {
> -       bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
> +       bpf_stream_vprintk_impl(BPF_STDOUT, "", NULL, 0, NULL);
>         return 0;
>  }
>
> @@ -18,7 +18,7 @@ SEC("syscall")
>  __failure __msg("R3 type=3Dscalar expected=3D")
>  int stream_vprintk_scalar_arg(void *ctx)
>  {
> -       bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0, NULL);
> +       bpf_stream_vprintk_impl(BPF_STDOUT, "", (void *)46, 0, NULL);
>         return 0;
>  }
>
> @@ -26,7 +26,7 @@ SEC("syscall")
>  __failure __msg("arg#1 doesn't point to a const string")
>  int stream_vprintk_string_arg(void *ctx)
>  {
> -       bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0, NULL);
> +       bpf_stream_vprintk_impl(BPF_STDOUT, ctx, NULL, 0, NULL);
>         return 0;
>  }
>
>
> --
> 2.51.1
>

