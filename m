Return-Path: <bpf+bounces-34936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA09334B1
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 02:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303671C21ED7
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07227370;
	Wed, 17 Jul 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz+ICrRp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52219A
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721175135; cv=none; b=MtoObCddXAnPrZYffNlYZeYStkXcfyeWlfV7h4Yyzgp/0pNh66F2y3JMB/mCQsQ8Y513gZAaM99PBO3x77s8v7L8pb/LJl3So0fJcozJLISXpT1+WZTaHosD/P0c07jUhrPnjla3r2vd3VjQ4N5lkopQ4+hlU3AIShQRcLCJBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721175135; c=relaxed/simple;
	bh=O0yYYhgQPXbScRcW7hLgvtYdv4LvuYsatMkRSUuDsOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ks7zoHyz/dDvTH27csnXE8H1k3mY4fIkNjzVOicaesILmsgKe60ava+GMMztCclU8gBiyTsR5DQzucB0msXcM21qEhz+sdtWxK0IJ7MP2Z39HlMtNGs7u1j280dl9mblhbXSLmvS629vg/TtE/yYKFYB2QXb4OXQOppPl+6X3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz+ICrRp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7044bda722fso3653386a34.2
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721175133; x=1721779933; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YEfCXBvqsc+LiMrn5noEiI6VWI6yhzdWsqgqPXteBGw=;
        b=lz+ICrRp/u8asphNz01V3QGS8gH8Mlax0+xr+IgjvEFwiLUKN5uRMm78VOyUopRMjz
         vxgtRK8eeOjnAf5p+iUGLoJrqf0Lrm0VK6NXiEKyEpyBCG5xKhrXKroy2iCxNLilbc09
         6vi5fytdy8FCWTWnFafPlHcVS5HBW/KFpndN47cBhAc6YBFMRaJT7OPlmKO5L8LrGeMl
         bqMvH2lrzIDdoOf7xB/OaG8TpneOpTPFMXTHh9Y4XswL2gCzNku2P+z0KRBnwOCB1S91
         HKXWu0Uw+jITS+c10JTV0KM7t9WCRyiQYXJJUnz3GgGAv1Nvlj4vAlDsAHX0fbDHI5Sr
         O7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721175133; x=1721779933;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEfCXBvqsc+LiMrn5noEiI6VWI6yhzdWsqgqPXteBGw=;
        b=gU8+tKUFC89FF4/CukXZaf5eClwUXQTFa/AKZFwAzh1Az4poONnutWx05b4aKGJMal
         LSqInH4bDwyVy1NL9GPNAksfntLET8OOtc6obLU+m1DXLLX9/yS7C5fdn+9X+M94x00o
         EqtbxILqtKpoKOzEMNN6BhUg9+0VPhAxnWb+vbl60QKBapCVPeJT5P/Swk4SuvmFJR8r
         KkW1F8NDHW+jA1hS28Ml3cjZewigsePKq0xq1wd9sVgnrVj3mtdPVKeoxL2QhUPkBUxd
         feCWKT/Xz9sdNzNCmcgmJm9UKvGMMXaAjYL0PzRclvLorkWvUsjVhM+4ceyix4ZZQm/q
         zrxg==
X-Forwarded-Encrypted: i=1; AJvYcCX/+IyzGjUkaqCXBfhIqMR33Ao/T+vVH+nRKfM9tPp/ISenGq6/APZeeORyfi00VxgdZLOrsJsO8dNaHx02RKEKAUQ3
X-Gm-Message-State: AOJu0Yx2HzhpqoPGJDA+2mnlaBu/ie8jCBxm8k3GY0G6sqwFbYWNcaKM
	D+dWpI6n9baOdN2B5wnjLXZLdtfmaaI8RV85Hw8wzS1XgA+92BLSUks8wQ==
X-Google-Smtp-Source: AGHT+IGnc8J+k1LK4XfoU6FnHOuE9B+dEGGbx6TC8j2XAlcodyLu5UNQlHyG4c6izRRf3tp2B6EBSw==
X-Received: by 2002:a05:6870:a450:b0:25c:ad1f:b32a with SMTP id 586e51a60fabf-260d9231832mr50684fac.27.1721175133048;
        Tue, 16 Jul 2024 17:12:13 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e204sm6915177b3a.32.2024.07.16.17.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 17:12:12 -0700 (PDT)
Message-ID: <9f7470ba841548b6d534b3886d8c76c4352323e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add ldsx selftests for
 ldsx and subreg compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 16 Jul 2024 17:12:07 -0700
In-Reply-To: <9ff9b619-aa69-42eb-9c71-39bd5ef425cc@linux.dev>
References: <20240712234359.287698-1-yonghong.song@linux.dev>
	 <20240712234404.288115-1-yonghong.song@linux.dev>
	 <5ce8b885e35e780d3ec6e730d9be2b45be3fea05.camel@gmail.com>
	 <9ff9b619-aa69-42eb-9c71-39bd5ef425cc@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 15:38 -0700, Yonghong Song wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index eb74363f9f70..c88602908cfe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -441,6 +441,22 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
>          if (t_is_32(y_t) && !t_is_32(x_t)) {
>                  struct range x_swap;
>  =20
> +               /* If we know that
> +                *   - *x* is in the range of signed 32bit value
> +                *   - *y_cast* range is 32-bit sign non-negative, and
> +                * then *x* range can be narrowed to the interaction of
> +                * *x* and *y_cast*. Otherwise, if the new range for *x*
> +                * allows upper 32-bit 0xffffffff then the eventual new
> +                * range for *x* will be out of signed 32-bit range
> +                * which violates the origin *x* range.
> +                */
> +               if (x_t =3D=3D S64 && y_t =3D=3D S32 &&
> +                   !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0=
xffffffff80000000) &&
> +                   (long long)x.a >=3D S32_MIN && (long long)x.b <=3D S3=
2_MAX) {
> +                               return range(S64, max_t(S64, y_cast.a, x.=
a),
> +                                            min_t(S64, y_cast.b, x.b));
> +               }
> +
>                  /* some combinations of upper 32 bits and sign bit can l=
ead to
>                   * invalid ranges, in such cases it's easier to detect t=
hem
>                   * after cast/swap than try to enumerate all the conditi=
ons
> @@ -2108,6 +2124,9 @@ static struct subtest_case crafted_cases[] =3D {
>          {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
>          {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
>          {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007ffffff=
fULL}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007ff=
fULL}},
> +       {S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007=
fULL}},
>   };
>  =20
>   /* Go over crafted hard-coded cases. This is fast, so we do it as part =
of
>=20
> The logic is very similar to kernel implementation but has a difference i=
n generating
> the final range. In reg_bounds implementation, the range is narrowed by i=
ntersecting
> y_cast and x range which are necessary.
>=20
> In kernel implementation, there is no interection since we only have one =
register
> and two register has been compared before.
>=20
> Eduard, could you take a look at the above code?

I think this change is correct.
The return clause could be simplified a bit:

	return range_improve(x_t, x, y_cast);

[...]

