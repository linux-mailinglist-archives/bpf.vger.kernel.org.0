Return-Path: <bpf+bounces-46642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808899ED08C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67E328E499
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB01D8A0B;
	Wed, 11 Dec 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj89YEc5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD181D63FA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932576; cv=none; b=Ztkg/adFHAOL5Ib3TfmN45Ptp0u16FAncbl5R9zH8lfuFI5n0j4mvWcF9yx//LgZsEcilqOuYmPKa7LDir+Mln9OoMOyEdUuu0gmUEcT+5FADvvR64Ld4yAbN7bvcsmdEDwipp1+AsK8mzucuM7aL8L1ZmEW0SVbPiq9ZP6KMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932576; c=relaxed/simple;
	bh=RLBexJ5Iv2zC2cQs+sKBXKzPmWBp6/WVq5uk2AuyB/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu11fcWarDHkZZIaBvOxRZSBqcLY+3EaMGDY7fRAO8QRY1rL7WGz0EFk4V3b3BDN2whO9raC8n5145FckUiiZzn35V54loxjsMB5IovQJLceRg/Nnb+H/VYAV/udOv1LEDlZPwQEIbzmt64m3kAfLZX1itlDsFJs8oZEzIc2RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj89YEc5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361c705434so6311425e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932572; x=1734537372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfCVn31Cz29C5f9BjgKBMKPEALKGcpDXUbNgCGzlR5w=;
        b=Nj89YEc5fIEK3MuwWoa+u9PnMtnNUE/KPv5wFICgPYkfoea1rs55azru+EVXks/8+9
         5E7/2AECF61MJ4Gm5KYcptm++F8gw6nsUPxA0CyBEYn9HMyjy4ub00jOsUNdLJq0Uhsj
         AUbpd+qUr2ag7UTbkbEHTMklh3JlZpFZO7z9fLt2BWQgXsGnk4ADEVSYiyehOyv6jlM/
         e5ZwROkxPFB4dgynsNLIjq6cxr68JXksAl6k6rsf65yRcLmSxkfHVO5oTPMZc1NnoI2U
         KrLaIjWFMHHD6UllaO6DoB4VHOspvL1GvM9aGRrSlUMQVjpCNZt2k33KjK81bzJn/nIL
         PIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932572; x=1734537372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfCVn31Cz29C5f9BjgKBMKPEALKGcpDXUbNgCGzlR5w=;
        b=R6Uhdx5fud4qHCM5PASizRTiykdhQpVrYFjNs4J7WySnFOZgE28KnHa05b/aS6KZSR
         oIVtI8BVrjzmORvv32X4BhSEOyrgK8dVzA84jzQWoWT51N5wu61oa3E8MKDEyx6GsObn
         HKklFFCf4KAxPZe+x8uPCYH2uR2fCJ2OU3d4CsuprKdP0aRYVCcnQddtkl8CxLCa7pFZ
         HZ5F3WQ9AL3aTF1N8MFWoJJIDjGL7GnqMrbUcktSkskfdjzmCV19S6fDF6iz5osZhMWZ
         a/q48581aL41orcA6Fx6ZmEsDi28tuce3eUnQ3Rqhi5eKGZVLiatYsDB9LNJfoQ3ZBvX
         +zrQ==
X-Gm-Message-State: AOJu0YwplM9leLm92WDyUGNuSwJeT+5E4/jZ/a5fT74OWygo5RCmpFsj
	3SzBLxZbOeymGjek4msEvJb6hxodc/+6uQlzMBnMvHhFS2sz9wjnILt+RIMhvDxPqxiqkLH30bS
	s0Q39Wq7PWyOOq39R8snIl0XEtzU=
X-Gm-Gg: ASbGnctFGhSKAGklFMYPd6+OLuiP4WdX48uBxr92eBDyUeNF5DWmcc1hN1a8/qx+loQ
	OhAHoHsnZDiyLnQCA+zIHXznmec5b06KkaBDf3GeQW9G6vVJPryE=
X-Google-Smtp-Source: AGHT+IExlxyinmEZeN5cLr0e5Co2dzi6zZb347bsV7an6KRmQf0v90ZTi8DT61KtfhA1Rv7kJh4ElZvQMHD7d6iKLUw=
X-Received: by 2002:a05:6000:1ac6:b0:386:378c:b7ec with SMTP id
 ffacd0b85a97d-3864ced93b1mr2218400f8f.58.1733932572157; Wed, 11 Dec 2024
 07:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211020156.18966-1-memxor@gmail.com> <20241211020156.18966-4-memxor@gmail.com>
In-Reply-To: <20241211020156.18966-4-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 07:56:00 -0800
Message-ID: <CAADnVQKeF4PQE8MoZmTxWG_pOvqGJdV7nmww-rKRkPXxYPr9Ew@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>, 
	Manu Bretelle <chantra@meta.com>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Arguments to a raw tracepoint are tagged as trusted, which carries the
> semantics that the pointer will be non-NULL.  However, in certain cases,
> a raw tracepoint argument may end up being NULL. More context about this
> issue is available in [0].
>
> Thus, there is a discrepancy between the reality, that raw_tp arguments c=
an
> actually be NULL, and the verifier's knowledge, that they are never NULL,
> causing explicit NULL checks to be deleted, and accesses to such pointers
> potentially crashing the kernel.
>
> A previous attempt [1], i.e. the second fixed commit, was made to
> simulate symbolic execution as if in most accesses, the argument is a
> non-NULL raw_tp, except for conditional jumps.  This tried to suppress
> branch prediction while preserving compatibility, but surfaced issues
> with production programs that were difficult to solve without increasing
> verifier complexity. A more complete discussion of issues and fixes is
> available at [2].
>
> Fix this by maintaining an explicit, incomplete list of tracepoints
> where the arguments are known to be NULL, and mark the positional
> arguments as PTR_MAYBE_NULL. Additionally, capture the tracepoints where
> arguments are known to be PTR_ERR, and mark these arguments as scalar
> values to prevent potential dereference.
>
> In the future, an automated pass will be used to produce such a list, or
> insert __nullable annotations automatically for tracepoints. Anyhow,
> this is an attempt to close the gap until the automation lands, and
> reflets the current best known list according to Jiri's analysis in [3].
>
>   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen=
4.remote.csb
>   [1]: https://lore.kernel.org/all/20241104171959.2938862-1-memxor@gmail.=
com
>   [2]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.c=
om
>   [3]: https://lore.kernel.org/bpf/Z1d-qbCdtJqg6Er4@krava
>
> Reported-by: Juri Lelli <juri.lelli@redhat.com> # original bug
> Reported-by: Manu Bretelle <chantra@meta.com> # bugs in masking fix
> Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUS=
TED_ARGS kfuncs")
> Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ed3219da7181..cb72cbf04d12 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6439,6 +6439,96 @@ int btf_ctx_arg_offset(const struct btf *btf, cons=
t struct btf_type *func_proto,
>         return off;
>  }
>
> +struct bpf_raw_tp_null_args {
> +       const char *func;
> +       u64 mask;
> +};
> +
> +#define RAW_TP_NULL_ARGS(str, arg) { .func =3D "btf_trace_" #str, .mask =
=3D (arg) }
> +/* Use 1-based indexing for argno */
> +#define NULL_ARG(argno) (1 << (argno))
> +
> +struct bpf_raw_tp_null_args raw_tp_null_args[] =3D {
> +       /* sched */
> +       RAW_TP_NULL_ARGS(sched_pi_setprio, NULL_ARG(2)),
> +       /* ... from sched_numa_pair_template event class */
> +       RAW_TP_NULL_ARGS(sched_stick_numa, NULL_ARG(3)),

Let's avoid LOUD macros.
"btf_trace_" prefix can also be dropped to save space.
How about the following encoding:
 {"sched_pi_setprio", 0x10},
 {"sched_stick_numa", 0x100},

> +       RAW_TP_NULL_ARGS(cachefiles_lookup, NULL_ARG(1)),
 {"cachefiles_lookup", 0x1},

There is no need for arg0, since the count starts from arg1.


> +               if (!strcmp(tname, "btf_trace_mr_integ_alloc") && (arg + =
1) =3D=3D 4)
> +                       ptr_err_raw_tp =3D true;
> +               if (!strcmp(tname, "btf_trace_cachefiles_lookup") && (arg=
 + 1) =3D=3D 3)
> +                       ptr_err_raw_tp =3D true;

+1 to Jiri's point.
Let's use 0x2 to encode the scalar ?

