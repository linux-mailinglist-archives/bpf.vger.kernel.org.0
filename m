Return-Path: <bpf+bounces-35123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500F937DEE
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 00:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143461C21329
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCE148313;
	Fri, 19 Jul 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1+djK3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764207CF39
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721429936; cv=none; b=QMdqz0aSS6VimYGAuZRWw9o26RTda7Dsx4/CGFh6a+trvTZDW8oufKkcO6aL+lFswsqj7aqPwyPmITGtodCtWq88sA0ZrJ/zL3Aal4jutwBt4Sas6B0bn1lJDSALkCosff/Iw3WA4gsCgceTGkhuuVMFe6SVQZvbx+sFhKmx+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721429936; c=relaxed/simple;
	bh=s35Xop2ORv5udyrJaq+UhNWxekIc/bufsMG33sixJVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXtMnzobj6/iBaw0J0FuwYpucRWLGoUfLzGi+NOpEF3A1ccXqSx3hnjd78/tzRR2i1lZtvTk1L21HL4e8rInY2ev/mjBMNOJQjbnfIiHmTSylIGFdWbtRRdlL1MzOyQ3yv7oQmw3fnwOA9ctgd9X4LJSkU5Q6w8BQMXQUzhiGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1+djK3x; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-708e75d8d7cso1409590a34.3
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721429934; x=1722034734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akl585bEJGIG+daiCHgqLG5Wk0JnUQo4YL7Hdftc+7E=;
        b=d1+djK3x9qWgBZ5fknq1LJOc/NfEi5FqAbKEoKjPDFfiG0k7MRtxdZmC9fi2JKZq4Y
         hbHyzE/UZJRLZ1l445u/H2Id8hDFdhDSkwyVhjJeZqZJPNXkzd7j6UvwEMxW4im3hfti
         pmw3QgLXXVrsXLaLkLo/xSz/J+FRs0nLnHvmKeh/DAlqrgkw+Sjt6qzFuaWB6jBGgvUk
         B+AY/jqNe26LRbZbHnKaHd/ALIYfjbC288sbS47TIeSe7yOOd4lQZ3tDB6lhXRviDh93
         P6gYHLFwE9wqj4OciOw0WREeb7ncTOEJnXWRNqlQlqqDL6k4VMJL6H9tv0J4Lp+R6FIT
         kJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721429934; x=1722034734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akl585bEJGIG+daiCHgqLG5Wk0JnUQo4YL7Hdftc+7E=;
        b=oYcqwu7SD4QHrbYKX6v4fRO06U49IdiKRAVpYYPdZyEXjZ6VZDvuk75TCBEtToLz+t
         UhKREOjT84dMagRPTK9BagTV/5YKJinyFJWnaBUJR05/D3Os0Kq96RJMaAyU1IMrYVuf
         RPjv5mCzxMepn1IXHYQqpPUdiZojKEEvecOE9kg6/OkjB1/ib4qEVYO01bU+A2mTLQM8
         noAT8zNafqCzeF8S0YJeRcr3XrPUnDTU9arlxTLBhO8L+C4Bpn6KoWBNnoLTw6f7GNsQ
         hiPoGVaf6n5rt9mA1LoFCweI2+i+6wTAayqaF4yqLC+5CdF6btu9QHjh5US60ITzzNRM
         /hEA==
X-Gm-Message-State: AOJu0YynylcdzZ7zPid7zYDi1VlKz7ao7HyEWS2I/y2OWq9jW9fbyt7q
	yrp0pSoiBBCvyYd1J4HjqBpx3Uab9p5LsPb/jZ6EMZewcnfImqwVFvbflSt7/IMHILGBu8dzg1E
	6rgv5W09hkZlU7/+BIf4IirkbhBM=
X-Google-Smtp-Source: AGHT+IHU9TQtLjr+HK9s/nwV16ju5TkjTXSvt0ZgfCMrJ3WZncYs4cPpQtKMKqQfnQsrkRWQqVySzE4pDY7hHOEooGI=
X-Received: by 2002:a05:6830:418e:b0:703:6aa3:d091 with SMTP id
 46e09a7af769-708e376b0bdmr11489161a34.2.1721429934450; Fri, 19 Jul 2024
 15:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718052821.3753486-1-yonghong.song@linux.dev> <20240718052827.3753696-1-yonghong.song@linux.dev>
In-Reply-To: <20240718052827.3753696-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 15:58:42 -0700
Message-ID: <CAEf4BzYan5bw7O2Li95pO7aFJZEOJc2T3odCk7Vi8s-7Kj3Pxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add reg_bounds tests for
 ldsx and subreg compare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:28=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Add a few reg_bounds selftests to test 32/16/8-bit ldsx and subreg compar=
ison.
> Without the previous patch, all added tests will fail.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>

wow, I already forgot most of the things in here... :(

> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index eb74363f9f70..cd9bafe9c057 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -441,6 +441,20 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
>         if (t_is_32(y_t) && !t_is_32(x_t)) {
>                 struct range x_swap;
>
> +               /* If we know that
> +                *   - *x* is in the range of signed 32bit value
> +                *   - *y_cast* range is 32-bit sign non-negative, and

sign -> signed?

> +                * then *x* range can be narrowed to the interaction of

what does it mean "narrowed to the interaction"?

> +                * *x* and *y_cast*. Otherwise, if the new range for *x*
> +                * allows upper 32-bit 0xffffffff then the eventual new
> +                * range for *x* will be out of signed 32-bit range
> +                * which violates the origin *x* range.
> +                */
> +               if (x_t =3D=3D S64 && y_t =3D=3D S32 &&

tbh, given this is so specific for x_t =3D=3D S64 and y_T =3D=3D S32, I'd m=
ove
it out from this if into an independent condition, it doesn't benefit
from being inside

> +                   !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0=
xffffffff80000000) &&

isn't this just a much more convoluted way of checking:

y_cast.a <=3D 0x7fffffffULL && y_cast.b <=3D 0x7fffffffULL

? Is & + negation really easier to follow?...

> +                   (long long)x.a >=3D S32_MIN && (long long)x.b <=3D S3=
2_MAX)
> +                       return range_improve(x_t, x, y_cast);
> +
>                 /* some combinations of upper 32 bits and sign bit can le=
ad to
>                  * invalid ranges, in such cases it's easier to detect th=
em
>                  * after cast/swap than try to enumerate all the conditio=
ns
> @@ -2108,6 +2122,9 @@ static struct subtest_case crafted_cases[] =3D {
>         {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
>         {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
>         {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007ffffff=
fULL}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007ff=
fULL}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007=
fULL}},
>  };
>
>  /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
> --
> 2.43.0
>

