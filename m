Return-Path: <bpf+bounces-60944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B5ADEFDE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA39B166E30
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394332EAD14;
	Wed, 18 Jun 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQIFwer5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071827E071
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257640; cv=none; b=SFwN/tFDcXqGTNZx/ENyh1bDiDqid0oPjlr/FkWJvLCX1YhrCPN8MNBGPRprFkcTBOYvmeQxAda3UnicWBrzO+GebbDrYhinSmTd8ikJlIj3Rd3gUq/KXFq/hRuVTqnGvugiRs4wm//fFsUQEnsUrcXghyfYkg3qLm1JLDrxozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257640; c=relaxed/simple;
	bh=s4bbGvmBfOc+GNEx/wDDd4G9EZzztNpo6c3V+WPbXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0LTptpEzPfCqBxpQ6bEjtc6l4zRL7071BQBXqn5wm/K3cTmbPNo6VZY6RnAtVqbcv2lBMhEbYq6XvUrNYsJkafUnixRyVeaDLHDdR+ujW90OFsKAA9PqcpGql87/1JDSFcq1gzzyCXsA6Mxjoi752pAC4y0Gkw+sgmEekh5Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQIFwer5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d54214adso54060345e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257636; x=1750862436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KThMzXeTXCcvMnBD/oVLEje4P+EluL1loERY1QqGn84=;
        b=jQIFwer5gqpel96PaT2TV/vWIs4KHLX4Q7bIhZLUYauUr6ZCEmnEmE4RtcusUqsq0W
         7x9QGVGxciGjD1keMmoA38y7KRWrvdHyL3FpBhD6Deasup0tF0BszEQMNcjm/t9qq+lp
         3QqAj+GnSDf6p6v6kHwRXaLZF3vOPOVFsuXHJzlnunUgyBfHgCLO9eh9C88T6OAKkQXN
         hRPj542nFwrcv8a0aF1Fzlmvdky/MfruYhKM+Y8jBA3s4+PjHpf17RP4XF8XpL3hALdn
         Hdacfj+pigX59ayUKlyhYisA3y1d/Zaj3+eotL2h2oZs/hyy+8LlFtUB9nzPv7JdBc0p
         IQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257636; x=1750862436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KThMzXeTXCcvMnBD/oVLEje4P+EluL1loERY1QqGn84=;
        b=ZIbOwIyqXLGdjGT4PybsLVrxy2thGaOJGTaoKeE+qN2XncdpcyvrLdh4KLHgjdnXrz
         1a2a88ksOjbGgEG9FvHBUjlTpOd0xXu1JFbsTKlYQYvHb6Aom1usB3HStPmzBqX7hRc4
         M/OIeC9a/mQIXeF2wXIqSj0ylQ3p7NZDmed3fRRb1tCA43AhDy1BDLb8Sah7Us3HxmOk
         oLnA9bKYQqLwzGu468TQbfSsIz7v08kfsBjIsqU0nw+G1LXxeUkgIlMxyPwdG6i5waMR
         IVLmEoHbfPNl9B6setaJMpVFIF2QIIVqAbgxLAxxIlp3G4dC+F3zU/HPsa1DxLFZQtek
         JJkw==
X-Gm-Message-State: AOJu0YwccqVxBN1J0ARrk8JX3YyOAeZDLGbZWOembu9EjTY2+hOJWOn2
	BN093Q3eqTx3eLz7zuIV9yO1DXD0nFgjmj/+DVLQZeqOXIhAVYv0bNnFc5IubA6L4pxG79GGcLS
	dBB/cysDmDOF/NyVeq0e3sQ0VAcYiuoE=
X-Gm-Gg: ASbGncvT5MtYnucTBJhDjhh+nS/T4UopgmARoRUEvZFFEZxwTlFqdkRbZXdXXaIlKtK
	TFpXQomosx04hi4K+9yKDFv8fN+YSOPZ9ecuoxddJWzQdunTMaK9PlUpmKRKAaXNZr1O94vMFCI
	yromETa1moE28YRUWlto4lyJJuYyGLC+FFHaRdiQnrjLSkKnR3Yqt4/GmSA4f2yWV2m5SwUpvb
X-Google-Smtp-Source: AGHT+IH+0RPAYE7P5b/EDaBROlkg26LwIGaXd3OKxcog1FCEKJjnfek+9gS8I0X25gh1SBvkPwME3P1urxgqALbHkGg=
X-Received: by 2002:a05:600c:a02:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-4533caa641emr181370465e9.17.1750257636035; Wed, 18 Jun 2025
 07:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750252029.git.vmalik@redhat.com> <04a320f8a9405caee87c59807a4192e2b5e14bed.1750252029.git.vmalik@redhat.com>
In-Reply-To: <04a320f8a9405caee87c59807a4192e2b5e14bed.1750252029.git.vmalik@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 07:40:24 -0700
X-Gm-Features: Ac12FXy2bVcP1GQlhLYQ1aKroVbGpnKaNaP5dwhPpHU02xzDLFvFCXbvRhGrXBU
Message-ID: <CAADnVQLwxwLo5RqBPy=-Rr30nni5ZL8X5on-LenFMHqArZ6XFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Allow macros in __retval
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:32=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Allow macro expansion for values passed to the `__retval` and
> `__retval_unpriv` attributes. This is especially useful for testing
> programs which return various error codes.
>
> With this change, the code for parsing special literals is made
> redundant (as the literals are defined via macros) so drop it.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 11 ++++++-----
>  tools/testing/selftests/bpf/test_loader.c    | 17 -----------------
>  2 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index a678463e972c..1758265f5905 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -83,9 +83,10 @@
>   *                   expect return value to match passed parameter:
>   *                   - a decimal number
>   *                   - a hexadecimal number, when starts from 0x
> - *                   - literal INT_MIN
> - *                   - literal POINTER_VALUE (see definition below)
> - *                   - literal TEST_DATA_LEN (see definition below)
> + *                   - a macro which expands to one of the above
> + *                   In addition, two special macros are defined:
> + *                   - POINTER_VALUE (see definition below)
> + *                   - TEST_DATA_LEN (see definition below)
>   * __retval_unpriv   Same, but load program in unprivileged mode.
>   *
>   * __description     Text to be used instead of a program name for displ=
ay
> @@ -125,8 +126,8 @@
>  #define __success_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_success_unpriv")))
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test=
_log_level=3D"#lvl)))
>  #define __flag(flag)           __attribute__((btf_decl_tag("comment:test=
_prog_flags=3D"#flag)))
> -#define __retval(val)          __attribute__((btf_decl_tag("comment:test=
_retval=3D"#val)))
> -#define __retval_unpriv(val)   __attribute__((btf_decl_tag("comment:test=
_retval_unpriv=3D"#val)))
> +#define __retval(val)          __attribute__((btf_decl_tag("comment:test=
_retval=3D"XSTR(val))))
> +#define __retval_unpriv(val)   __attribute__((btf_decl_tag("comment:test=
_retval_unpriv=3D"XSTR(val))))
>  #define __auxiliary            __attribute__((btf_decl_tag("comment:test=
_auxiliary")))
>  #define __auxiliary_unpriv     __attribute__((btf_decl_tag("comment:test=
_auxiliary_unpriv")))
>  #define __btf_path(path)       __attribute__((btf_decl_tag("comment:test=
_btf_path=3D" path)))
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 9551d8d5f8f9..28d2d366a8ae 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -318,23 +318,6 @@ static int parse_caps(const char *str, __u64 *val, c=
onst char *name)
>
>  static int parse_retval(const char *str, int *val, const char *name)
>  {
> -       struct {
> -               char *name;
> -               int val;
> -       } named_values[] =3D {
> -               { "INT_MIN"      , INT_MIN },
> -               { "POINTER_VALUE", POINTER_VALUE },
> -               { "TEST_DATA_LEN", TEST_DATA_LEN },
> -       };
> -       int i;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(named_values); ++i) {
> -               if (strcmp(str, named_values[i].name) !=3D 0)
> -                       continue;
> -               *val =3D named_values[i].val;
> -               return 0;
> -       }
> -

and this broke a bunch of tests.

pw-bot: cr

