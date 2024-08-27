Return-Path: <bpf+bounces-38213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C4961A0E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A341F2415D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E431D3652;
	Tue, 27 Aug 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYIkbl9S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E98176AD8
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798264; cv=none; b=gSEhz9IFvxrkNnHfC5G87Zbv8Pu6nRQsi0qT3W2KLgAgYXWX2KwPgiiejI2Q6DFXSKhT6GUM+oOyOOjOL5oh1c8JfxeoPd3anoeP+19eDfRR4kHAa9jqZ0j0MNwQ2A1SVWslmrRsFI6HZOVZdlAlGewZmyieDv2b1GeoS4/eQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798264; c=relaxed/simple;
	bh=4pWvJGSPddqU4SWPdNDQibsDHcLOz+iQOk4scGrP+lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTlwLjjhmNWoyQfOb1YH4uuJ920ncWVnPkujq7hae2w1Kz4FmdsppveMVwncyku+Jg2+lu4/1JikDtNORd5NRQckuKqodyOATjVeRNNCJsv+VNU2oTQAxC6BgIcHu9c47wp9Parr7WEWc2hVnDHLAu/ngtBFq3Vk8SYbGvlV64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYIkbl9S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso4827191a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798262; x=1725403062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbM1YOP7GuXuCQW2pPQ+Cu6lUYBLd1+cY5gX6CTCS9Y=;
        b=bYIkbl9SXlyEVsqKijipd9hDvZcc9MGik3rEnKHQNvLwnLVdLhaqwrSGYbUYylewI+
         HrGSJra5+y7F06ygCwhdArjHWtSwuUUs311aN2gSe7X6rEPn2MMoNc4A9cigX2IpyRtg
         PsRNq4KftlsnEneTXCW5LcotNp8Rg3nCR31xpUffcenzESi/SjEcnYp/QcYCJlWBe0+g
         +fSXDTnMWU87P68I0aamiBgY0gnr+lMUW4PMaKRLbpAXAsamblUAfSeJszwtNCKMYQHi
         /wO8gDgVxw9H5qxqM5CmBnumeybvieDIg6P+axswXl3whvCGwuq9omUXRv+Jen2JS0tD
         vFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798262; x=1725403062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbM1YOP7GuXuCQW2pPQ+Cu6lUYBLd1+cY5gX6CTCS9Y=;
        b=mB5wAosq6GuQQvFqngXJyo9hpP2qWISSnc3x0k2J6TdovsWarM930IidP/zDHp+VCx
         slHXp4NFaSUs8hBX/PXG2i89gbjOetlQvhHrK4LqAN36lI4V/MC66ZtmAmRwX5LbxpVx
         UWRXmmTVDtK0e3BgTvr6kFeJRos6N5yNj41vAM0UfvbcSwqbfFE4QIeAJ8hk+pNrtLV5
         3qdlbTogRCYD+k5DWZuDG1mFOOD5S9QQTg91hKbuSwt5Wahcy56TTpdBmgEP4kNXvGN2
         eecXO8D3JpK09tlY120bJQuWS1+2tJtZtIiECB8WU9bkvIxYimMBjbqHu83DnuTehe5P
         DWbQ==
X-Gm-Message-State: AOJu0YyBhY2ZZ1j9W+VQEOi5szIQKOzCKqG3cwDZhfde6fLk7D4jHfCL
	R8EZXFUetuPndnAkYCNudTzOGNAdz/STRWQvZuql/BX6zOSR3UQ0idCw+mij1OV/34qaS/bSLqp
	7oLLzi7v3JCovR4Oc3VYx1jHrd+A=
X-Google-Smtp-Source: AGHT+IHrJjKyeQjXwXlI66nObqvGfIV3bExcGlmqlvy6WoNItiGrMWjGfe1tXyyfJWGIw1RzfGAzvpaMGUkaVbu00Tc=
X-Received: by 2002:a17:90b:4c10:b0:2cb:5678:7a1c with SMTP id
 98e67ed59e1d1-2d8440d2024mr225714a91.18.1724798262507; Tue, 27 Aug 2024
 15:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823222033.31006-1-daniel@iogearbox.net>
In-Reply-To: <20240823222033.31006-1-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 15:37:30 -0700
Message-ID: <CAEf4BzaLhBBPZWwPgTA8bRwxy-Zar07chWm4J9S55EusnH5Yzg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Fix helper writes to read-only maps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:21=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Lonial found an issue that despite user- and BPF-side frozen BPF map
> (like in case of .rodata), it was still possible to write into it from
> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
> as arguments.
>
> In check_func_arg() when the argument is as mentioned, the meta->raw_mode
> is never set. Later, check_helper_mem_access(), under the case of
> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> subsequent call to check_map_access_type() and given the BPF map is
> read-only it succeeds.
>
> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UN=
INIT
> when results are written into them as opposed to read out of them. The
> latter indicates that it's okay to pass a pointer to uninitialized memory
> as the memory is written to anyway.
>
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/helpers.c     | 4 ++--
>  kernel/bpf/syscall.c     | 2 +-
>  kernel/bpf/verifier.c    | 3 ++-
>  kernel/trace/bpf_trace.c | 4 ++--
>  net/core/filter.c        | 4 ++--
>  5 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5f0adae8293..356a58aeb79b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -538,7 +538,7 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
>  };
>
>  BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> @@ -566,7 +566,7 @@ const struct bpf_func_proto bpf_strtoul_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
>  };
>
>  BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index bf6c5f685ea2..6d5942a6f41f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5952,7 +5952,7 @@ static const struct bpf_func_proto bpf_kallsyms_loo=
kup_name_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM,
>         .arg2_type      =3D ARG_CONST_SIZE_OR_ZERO,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
>  };
>
>  static const struct bpf_func_proto *
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d8520095ca03..70b0474e03a6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8877,8 +8877,9 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>         case ARG_PTR_TO_INT:
>         case ARG_PTR_TO_LONG:
>         {
> -               int size =3D int_ptr_type_to_size(arg_type);
> +               int size =3D int_ptr_type_to_size(base_type(arg_type));
>
> +               meta->raw_mode =3D arg_type & MEM_UNINIT;

given all existing ARG_PTR_TO_{INT,LONG} use cases just write into
that memory, why not just set meta->raw_mode unconditionally and not
touch helper definitions?

also, isn't it suspicious that int_ptr_types have PTR_TO_MAP_KEY in
it? key should always be immutable, so can't be written into, no?

>                 err =3D check_helper_mem_access(env, regno, size, false, =
meta);
>                 if (err)
>                         return err;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cd098846e251..95c3409ff374 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1226,7 +1226,7 @@ static const struct bpf_func_proto bpf_get_func_arg=
_proto =3D {
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>         .arg2_type      =3D ARG_ANYTHING,
> -       .arg3_type      =3D ARG_PTR_TO_LONG,
> +       .arg3_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
>  };
>
>  BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
> @@ -1242,7 +1242,7 @@ static const struct bpf_func_proto bpf_get_func_ret=
_proto =3D {
>         .func           =3D get_func_ret,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> -       .arg2_type      =3D ARG_PTR_TO_LONG,
> +       .arg2_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
>  };
>
>  BPF_CALL_1(get_func_arg_cnt, void *, ctx)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f3c72cf86099..2ff210cb068c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6346,7 +6346,7 @@ static const struct bpf_func_proto bpf_skb_check_mt=
u_proto =3D {
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>         .arg2_type      =3D ARG_ANYTHING,
> -       .arg3_type      =3D ARG_PTR_TO_INT,
> +       .arg3_type      =3D ARG_PTR_TO_INT | MEM_UNINIT,
>         .arg4_type      =3D ARG_ANYTHING,
>         .arg5_type      =3D ARG_ANYTHING,
>  };
> @@ -6357,7 +6357,7 @@ static const struct bpf_func_proto bpf_xdp_check_mt=
u_proto =3D {
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>         .arg2_type      =3D ARG_ANYTHING,
> -       .arg3_type      =3D ARG_PTR_TO_INT,
> +       .arg3_type      =3D ARG_PTR_TO_INT | MEM_UNINIT,
>         .arg4_type      =3D ARG_ANYTHING,
>         .arg5_type      =3D ARG_ANYTHING,
>  };
> --
> 2.43.0
>
>

