Return-Path: <bpf+bounces-62218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CCAF689A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C87D523E98
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BE122F177;
	Thu,  3 Jul 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJQenUT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F922D78F
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512722; cv=none; b=TSP9+nI7FuEMl3RNB726zzzZ8H4K48ojTX2fY5dY448rChFW3a3b8EA9b0svBRWuNd5bBoM8GTjOD3Va+ylS8UOgsLgac3Y07R/1AF/qbfJQvqfvOoVNp364/gOb3DqYbxMdTR7gpEgHoJM3ttoBloLQ0ZCO8o5JpX76mub1wE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512722; c=relaxed/simple;
	bh=vlC8YCPsrxJnXc/Ky8Wzu90D5JJPN0uoTxmVg16fMJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRvut0zZa2zo5CAHqyBvQUfOZl3lqr6p7CE2BGYPXTnPEv8tH6biZMSR1Q9oHxoYwUwg/Qrp4VWdBaOQ5JYe7M/To06Uftr3HP4RN6hSZAd/QjEt0MNsoyJ6dQjv/8AxYsOPGch+4pjkgLzkKyrqZ+cvWrwVwLmaWLPmBBc8sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJQenUT0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so63237975e9.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751512719; x=1752117519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0n6Oyn2Y1yDROm8pxfxVZliiBAS0z/+qCWvpN0gL1Y=;
        b=fJQenUT0MA8qv430b5SE/972qXXvuCp3G6R2ofBh8+/2ZFLj7RU/s7gcbVXNGtVdns
         ySDB8uFNOKf/3cVPOiE3oNa/63fhr2YFuVuwyb2bXb9tE4d/5soMR30qPaiTuOZi3wqA
         ByKy8gW0XTd/8qsVvdb8tko076+Edm+ahXfO8ezaj52W9Ntd0GNi/WC0/V1vh0n0sLBZ
         CdyBfer01njtEWZ7cSOzpGUGTyWIovoLNuAEDiNEOSTRc8r5FcCA6qVNTU/DD7n+T3B5
         aafFg5ObyGhMau576f330C3QqM24/s9RJRcAZttn+0Fyd5mUwctUEE7G1biN8y+GAQJY
         E3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512719; x=1752117519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0n6Oyn2Y1yDROm8pxfxVZliiBAS0z/+qCWvpN0gL1Y=;
        b=ncVWV36McvFfcS2TBkIIEI88Nx6IocakzhY4/96vIM5KY9CNSd2pVrMx48ZEzazFF3
         OfTww97y49yntry24D7d4KB0BcwtCr5rYPQUvEkCRxQ78d2pYSoTxmUknws9vckZXtUp
         Z61S/us6oO0ERBYIBpHMA9y6jqmTB+u7UmnUoVoJ7JnzABXW9taiSNRBqW71hRbtJAkS
         v0eFMTwxc2OVmnyfRKtao+xXKHKkTNAOCoY9Ndk4dRGmELeUJoX3SdAvyGgDKqFSx2tq
         8lCGU/TomKLmF0hP1RseIO4lwAkQ9QNXJDFtz6n7HGzZSYIhBLBhedXs0KcGuhfFeG0k
         ku3Q==
X-Gm-Message-State: AOJu0YznJ0ZQb1TIiwOkN6xEUNkMfUoaqmqkAnKHhO6udpH1kIdl2r7i
	Nww+P3Cg13FSK79MoZ6CgSluDBOqyy6swxRrqE+rv1opobDzL5RlJHxdxntt942VMkiH9I30iZr
	uxGZBZOn7AGN9ZEB4EvgyDTeW+6Cp7V0=
X-Gm-Gg: ASbGncuocM3HQBYXbclMw4mfZBXwPDGBgHfKK4PPeDWZ5GXM0iNr0xBN1B+7mBP4/zx
	1tfRfeQjwaUDFLmZHC6z63kdT8WElaGAVm1m1cmg9yohPaeeSo9jRHB0bOPyLQ36Plc1brZ/W49
	q/ltZXfqEbBGlHODbkg5BeKHosL0vrk9TSiq0LFksP0wG+gYYi1e42hXS4skL6761FgE1bPB+p
X-Google-Smtp-Source: AGHT+IFV+EcVad94roFi8M+HGERLzVv8w3+P7lJaHe9hpRjR+tDpiRKOQSQktFqWDscenyNuJY/HPniaS2cc7qAzIJ8=
X-Received: by 2002:a05:600c:138d:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-454a36dedbcmr54914595e9.5.1751512719087; Wed, 02 Jul 2025
 20:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-5-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Jul 2025 20:18:27 -0700
X-Gm-Features: Ac12FXz3YPHJdeNHKynqP_7xkRCFasEeghcRCn6ZmAgrJWykCgwxmfWM1JuLkzI
Message-ID: <CAADnVQLRL8Vuh_VGAqSF_MhcsHhOvfYFurGoGiC9RfAiGJcbZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Add support for PTR_TO_BTF_ID | PTR_UNTRUSTED global function
> parameters. Anything is allowed to pass to such parameters, as these
> are read-only and probe read instructions would protect against
> invalid memory access.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/btf.c      | 29 ++++++++++++++++++++++++-----
>  kernel/bpf/verifier.c |  7 +++++++
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b3c8a95d38fb..28cb0a2a5402 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7646,11 +7646,12 @@ static int btf_get_ptr_to_btf_id(struct bpf_verif=
ier_log *log, int arg_idx,
>  }
>
>  enum btf_arg_tag {
> -       ARG_TAG_CTX      =3D BIT_ULL(0),
> -       ARG_TAG_NONNULL  =3D BIT_ULL(1),
> -       ARG_TAG_TRUSTED  =3D BIT_ULL(2),
> -       ARG_TAG_NULLABLE =3D BIT_ULL(3),
> -       ARG_TAG_ARENA    =3D BIT_ULL(4),
> +       ARG_TAG_CTX       =3D BIT_ULL(0),
> +       ARG_TAG_NONNULL   =3D BIT_ULL(1),
> +       ARG_TAG_TRUSTED   =3D BIT_ULL(2),
> +       ARG_TAG_UNTRUSTED =3D BIT_ULL(3),
> +       ARG_TAG_NULLABLE  =3D BIT_ULL(4),
> +       ARG_TAG_ARENA     =3D BIT_ULL(5),
>  };
>
>  /* Process BTF of a function to produce high-level expectation of functi=
on
> @@ -7758,6 +7759,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>                                 tags |=3D ARG_TAG_CTX;
>                         } else if (strcmp(tag, "trusted") =3D=3D 0) {
>                                 tags |=3D ARG_TAG_TRUSTED;
> +                       } else if (strcmp(tag, "untrusted") =3D=3D 0) {
> +                               tags |=3D ARG_TAG_UNTRUSTED;
>                         } else if (strcmp(tag, "nonnull") =3D=3D 0) {
>                                 tags |=3D ARG_TAG_NONNULL;
>                         } else if (strcmp(tag, "nullable") =3D=3D 0) {
> @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>                         sub->args[i].btf_id =3D kern_type_id;
>                         continue;
>                 }
> +               if (tags & ARG_TAG_UNTRUSTED) {
> +                       int kern_type_id;
> +
> +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> +                               bpf_log(log, "arg#%d untrusted cannot be =
combined with any other tags\n", i);
> +                               return -EINVAL;
> +                       }
> +
> +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i, bt=
f, t);
> +                       if (kern_type_id < 0)
> +                               return kern_type_id;
> +
> +                       sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | PTR=
_UNTRUSTED;
> +                       sub->args[i].btf_id =3D kern_type_id;
> +                       continue;
> +               }

Looking at this hunk standalone (without patch 7) one might get
an impression that odd ptr_to_btf_id is allowed that points
to non-struct type,
but patch 7 sort-of fixes it by handling primitive types first.

Still, I think it would be good to add a check here that kern_type_id
is a struct kind.

>                 if (tags & ARG_TAG_ARENA) {
>                         if (tags & ~ARG_TAG_ARENA) {
>                                 bpf_log(log, "arg#%d arena cannot be comb=
ined with any other tags\n", i);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cd2344e50db8..dfb5a2f8e58f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10436,6 +10436,13 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>                                 bpf_log(log, "R%d is not a scalar\n", reg=
no);
>                                 return -EINVAL;
>                         }
> +               } else if (arg->arg_type & PTR_UNTRUSTED) {
> +                       /*
> +                        * Anything is allowed for untrusted arguments, a=
s these are
> +                        * read-only and probe read instructions would pr=
otect against
> +                        * invalid memory access.
> +                        */
> +                       continue;

nit: All except one 'else if' in this loop don't do explicit 'continue'.
I think the above comment would be enough.

>                 } else if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
>                         ret =3D check_func_arg_reg_off(env, reg, regno, A=
RG_DONTCARE);
>                         if (ret < 0)
> --
> 2.47.1
>

