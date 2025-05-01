Return-Path: <bpf+bounces-57137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46CAA6281
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564231BA6EBA
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E721C9E0;
	Thu,  1 May 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyF6HR2y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8391D54C0
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121643; cv=none; b=Wr1pZFcMMLtpioamxgeWttJhEMu1szeXplBUePyrirvWC1KeYoyM4ZCmHgHbfgx9hr0LBp/aCODJEcwoGmOSTvsTPyjUTUvTYQmw2humWMYWsg/JQmdELkUG+O3HeqCsqVtLVRcadSfoKPf6fDw+xmF/ZbCByGHTdeliQ4+WQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121643; c=relaxed/simple;
	bh=7kk540T2f4687hgXmXF45uzP1io9qwySTfJCJoAwRqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NytF0K7tvXJJVr9vV7OqqGYL5GoAVs4WFV6O4+GSiSbD4m6J4p00PN+fSOK+1hXu5zq7piI7lJtqlAvC1mxWjuMxFJrTMbEjnLCTlhKwKc4GLRdZfWvGLpwIrBe56l67fkVVoE31vCeer2iE/hxQyKh5REMf2X6zz9VRCOioVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyF6HR2y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736aaeed234so1288792b3a.0
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746121641; x=1746726441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5UADtM0W9+mi5Mi4RH5vv80GR87hJ2qZVMPt12dgiA=;
        b=XyF6HR2ydaOR4rvVWvq8MZby0mmFEQm/5fl7DyyYY7Hj3KnFaCtrVTkBMijZAwqaUr
         PV1oy6YBgkTyd/geLh6KzI0gWOCNKOPVn6VCgCeLJhCNnM0GKmm1AApk6Ui5gM8HR7jm
         KxPVAZruHsljhpNyoZnf9rRqb2scv4W/afiSOkO0HhFWDqphs1X1N8/WD6BLPQkQb9XD
         HH3reG8pCYtP0ru5YtevSzSuqo00PC3kXe53lycYPpWvQXs0EFTWGLrxB3s1o4OvmMNu
         cweftapPqoOn2QE3NoHozcy2XRkxCchLZhmaORt21boBrJ9MTDYAjpoJ561m8LvMvmSu
         DM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746121641; x=1746726441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5UADtM0W9+mi5Mi4RH5vv80GR87hJ2qZVMPt12dgiA=;
        b=xPe/QfMX+T1cw0vMNWaRJ788yIz0Hq7u8vYXufCbtzeK15AEAlGSRB6emZRG5tbdt2
         iwo3m7TixM4lUlY6JdPn+I3AQGk3cQEdqkSvMg9QslakqRvO76HY0esM2sosNbM81bWJ
         PxQ+NMrIUw/0ON+zP2vSqQSOu8YWAYH+BVFKbtf5tGCubYSDeciWzcxTc7yyjWFw3mHg
         YBEGyro5gIGTHLnFZ7TSXfGRDjGczMyrBQjZndepSJF4aLL/cPmmfLPfpeXfu32vUI4Z
         Y/u2s+1QRXQYGxOtJysHC2WNu4X95RB8yjyuRtS9mitFEy6tYFU+KvgqGhC/aGFjigYP
         hNdQ==
X-Gm-Message-State: AOJu0YwcWmrotE1rEsXbY9+13+T1z05Slwct2qXwJ3AVlkMgRAEXvgqi
	8AX5p/nFAGEVDIEMFcnBQ4fnnPUNn1V7RFOoNUEdAFmRF5qZLcZR3BHpJm+Kmb37fuJjgBYdHaG
	w1KlFY4lQNRJBl/wvQ2UKJR6gCNw=
X-Gm-Gg: ASbGnctfe3K/T/yu4K381RR4Ui9EwUUAwVAPDgklVh9Ea9fIOTXQsfpDv4RS6OozuTB
	CIIkPEUQOAoaVY663rySiNnRICgOiaZne/8umXeGbd9ILVVhYzPT99AULfqB/lS8zAFEoSjLYAW
	kgRN7cd8VskPTu8G3mGRY8z14vRBSOZfHrMKI8Mg==
X-Google-Smtp-Source: AGHT+IEwIDxP3H03otZikuRu49XVOwTfygveMKY/LI4GC7U8JwFJPBK3kSetu/B7aASsE0bMqsn3FSg7Oqyl0e0RcCM=
X-Received: by 2002:a05:6a00:3d55:b0:73e:23be:11fc with SMTP id
 d2e1a72fcca58-7404927593emr4353284b3a.22.1746121641217; Thu, 01 May 2025
 10:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430174754.2576367-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250430174754.2576367-1-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 10:47:08 -0700
X-Gm-Features: ATxdqUHS0Ol7eV6RqD_59Vyd3wZsgp9wGksusEhEbHWrmD6JnMGdBGToDehoc4o
Message-ID: <CAEf4BzZNhS7eZ07ozSU4VJdYz3k3nnOs+gkdSio2-AmYOjwuBg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:43=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> With the latest LLVM bpf selftests build will fail with
> the following error message:
>
>     progs/profiler.inc.h:710:31: error: default initialization of an obje=
ct of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigne=
d int') leaves the object uninitialized and is incompatible with C++ [-Werr=
or,-Wdefault-const-init-unsafe]
>       710 |         proc_exec_data->parent_uid =3D BPF_CORE_READ(parent_t=
ask, real_cred, uid.val);
>           |                                      ^
>     tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35:=
 note: expanded from macro 'BPF_CORE_READ'
>       520 |         ___type((src), a, ##__VA_ARGS__) __r;                =
               \
>           |                                          ^
>
> This happens because BPF_CORE_READ (and other macro) declare the
> variable __r using the ___type macro which can inherit const modifier
> from intermediate types.
>
> Fix this by using __typeof_unqual__, when supported. (And when it
> is not supported, the problem shouldn't appear, as older compilers
> haven't complained.)
>
> Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() =
family of macros")
> Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() m=
acro family")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/bpf_core_read.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index c0e13cdf9660..a371213b7f3e 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -390,6 +390,14 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 =
btf_id) __ksym __weak;
>
>  #define ___type(...) typeof(___arrow(__VA_ARGS__))
>
> +#if defined(__clang__) && (__clang_major__ >=3D 19)
> +#define ___type_unqual(...) __typeof_unqual__(___arrow(__VA_ARGS__))
> +#elif defined(__GNUC__) && (__GNUC__ >=3D 14)
> +#define ___type_unqual(...) __typeof_unqual__(___arrow(__VA_ARGS__))
> +#else
> +#define ___type_unqual(...) ___type(__VA_ARGS__)
> +#endif

instead of defining both ___type_unqual and ___type, let's just define
___type as either typeof or typeof_unqual and use it uniformly? I
don't think we ever care about const/volatile/restrict stuff in
___type usage

pw-bot: cr

> +
>  #define ___read(read_fn, dst, src_type, src, accessor)                  =
   \
>         read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->access=
or)
>
> @@ -517,7 +525,7 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 b=
tf_id) __ksym __weak;
>   * than enough for any practical purpose.
>   */
>  #define BPF_CORE_READ(src, a, ...) ({                                   =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       ___type_unqual((src), a, ##__VA_ARGS__) __r;                     =
   \
>         BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);               =
   \
>         __r;                                                             =
   \
>  })
> @@ -533,14 +541,14 @@ extern void *bpf_rdonly_cast(const void *obj, __u32=
 btf_id) __ksym __weak;
>   * input argument.
>   */
>  #define BPF_CORE_READ_USER(src, a, ...) ({                              =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       ___type_unqual((src), a, ##__VA_ARGS__) __r;                     =
   \
>         BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);          =
   \
>         __r;                                                             =
   \
>  })
>
>  /* Non-CO-RE variant of BPF_CORE_READ() */
>  #define BPF_PROBE_READ(src, a, ...) ({                                  =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       ___type_unqual((src), a, ##__VA_ARGS__) __r;                     =
   \
>         BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);              =
   \
>         __r;                                                             =
   \
>  })
> @@ -552,7 +560,7 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 b=
tf_id) __ksym __weak;
>   * not restricted to kernel types only.
>   */
>  #define BPF_PROBE_READ_USER(src, a, ...) ({                             =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       ___type_unqual((src), a, ##__VA_ARGS__) __r;                     =
   \
>         BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);         =
   \
>         __r;                                                             =
   \
>  })
> --
> 2.34.1
>
>

