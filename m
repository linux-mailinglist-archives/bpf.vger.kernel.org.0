Return-Path: <bpf+bounces-63959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877ADB0CC9B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89CD173925
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EE23F41A;
	Mon, 21 Jul 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4gPWY4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5332236FD
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133390; cv=none; b=ZxSzAbrOt7CHiujh26iA5EEjq17DsMquL2bhM6pJGOHhj8WChNh64R/2fvAWdwwGr1jIzuqtJOtCNHwmv+bmZGiQgYQY879gS3o70DoPXuuRRKYtVGMo/lg2nVw6NgHzXrlRN+ehFrzZwxZPCQWcCeMUlwNUhdOC3pE5cjP1lGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133390; c=relaxed/simple;
	bh=gWDKWs/0x09C67mvHaET6b/9mbFv8BvJk7q1osnkMS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cIEKVGJslspOq21qm/iDab5TnbyS2tWFwyk2HyBABf5wzOZ2N89UWHD+044XCOe5uPRAyYcuCOrT2Hpcgssq0fsmSYpSh5r4FD+Da8eSgEmhK6RWWDh9xcYo9s3i9kWMtPsrInXVNib3mvmdg3JDkM4NlM07SMn2O193NQEEbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4gPWY4d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b9dfb842so40106035ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133388; x=1753738188; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lVWmEilrzx5aPSTVzRA9QlnLYM85/DmXAH/nE6oRyw=;
        b=g4gPWY4dC2e3V3DSsLw2kt2cYOScJxnTWQIFX8inYEoLOoITLdbK2GqgVH1W0sp5TP
         Beio0zGPGW7NcT81lbLfAQHxtLHP4vV1aMJJdhHNfAdOK/SPUIm8vO60JJu+21nZuUTt
         MrM4fP/TGsqGVYTW0drbcKBz2oVlePa0HzvjYQ6xlQCm3hadIOXOxXXVTW3U2ieNU0kb
         Vd4rbEUJ0PCy6BqEg1WxvicDjREtMQiRzzxO8pp+PFsa1BB2DllJ78oksZqvuNqmTsjc
         qS8m13MfTX5DMe2SEDeU2o8nU2ZnArZQbEgU59Bf+xDi6jDExAwMKSloB9dx6LW2nvNY
         rTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133388; x=1753738188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lVWmEilrzx5aPSTVzRA9QlnLYM85/DmXAH/nE6oRyw=;
        b=COWRVkX/BzW/2kNrzDZgyzF/FIE3aqUA+RTFjW+HsO4QbeUb+S8RjMajQhnmJenJGC
         elW7GoWLHMwm1RlYHbH+w9UI6fDeybaIpEesXhQCE4lU1F+GImDmhoyTHVHsJmo+td5W
         nEh68Xcyzz5RDXnSbj5fCJgKIc9UUeJ8SxsEKoVKeBd4TXeUDdy8qz7h05toYdqKIqSu
         fDxu6I6uLuIpKTCu8UTssv/H8UKdjlk8gPkx2bAdyk7d+sLwt2DBzDSvCvlvhYp3VArM
         Chk+ixyAtFeLa5JE1Y+D8hzRv53YdvZYXmaags3/xfBOjdXinHA/dX3OIe3Asl4j42uN
         o7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX6gfgdyZrOvokmh5d+t8yGJsOGDdFWF6V4WTVopxha7ZADSUzk+n6V9Z/hAD9kmgPyw90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHnSh0WPoouVfVqW4l86XRWIgXP1HBLwNrn9wxI6bidqAL/o2
	ClbAeDZlP4md8RGfSrE1gN21QpfL3q8R3DOd/ysS7oF1qNm5ReZRlZBnsUWZfZxU
X-Gm-Gg: ASbGnctj9FE5KjDnLhkNdsn/Mrl/ObGMRP0PVQ1DA4KEEOcDQGJ3h5u+0/4khpjmxcf
	a7Qi028wci0weUSNDpNIDsiQlv59nLN/crtOBAbuALgTR/Lvtjh3U91U+EfVVov72VPWZIcBk5R
	qJvlN/hupLufJkyomd5d1vHZSOLo5DJW0R5zEhxpwRxEDNcuayT1FbTQXZ1tWRFRAoYnWaGECQf
	CQxVc4bytEBGh/kxhumRax+AHfFKwPqkDUaG5W9Nkwr7hWkdhi2KJqIIe/Ubz6Vp+gf+256Bojr
	HWHVDJ6hfDNjAC0bBEVTCXEDFORPSuj45uBjxEaUMCr+N4Z+ZgPW3MwxrjchS5xX0/l8R6eTpKV
	zXDTyap5Bd3XHEu5lcuq+H2zf6lEF
X-Google-Smtp-Source: AGHT+IH+S10uIIpRxXKC0ftn3f8tDf8ImVOOPFbzoYCSzupPlyxvzOpvqS7BK6NQLDO7olzX6j4TMw==
X-Received: by 2002:a17:902:e54a:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23e2566af24mr365231405ad.2.1753133388477;
        Mon, 21 Jul 2025 14:29:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d397esm62574275ad.147.2025.07.21.14.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:29:48 -0700 (PDT)
Message-ID: <8dc4b79af360bb6121c6b96a2c351bd060bfca29.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Update reg_bound range
 refinement logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 21 Jul 2025 14:29:47 -0700
In-Reply-To: <4636f494d90da3627e955d62e54a7927c6b2b92e.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
		 <4636f494d90da3627e955d62e54a7927c6b2b92e.1752934170.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-19 at 16:22 +0200, Paul Chaignon wrote:
> This patch updates the range refinement logic in the reg_bound test to
> match the new logic from the previous commit. Without this change, tests
> would fail because we end with more precise ranges than the tests
> expect.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 39d42271cc46..e261b0e872db 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
>  		return range_improve(x_t, x, x_swap);
>  	}
> =20
> +	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t !=3D y_t) {

Nit: I'd swap x and y if necessary, to avoid a second branch.

> +		if (x_t =3D=3D S64 && x.a > x.b) {
> +			if (x.b < y.a && x.a <=3D y.b)
> +				return range(x_t, x.a, y.b);
> +			if (x.a > y.b && x.b >=3D y.a)
> +				return range(x_t, y.a, x.b);
> +		} else if (x_t =3D=3D U64 && y.a > y.b) {
> +			if (y.b < x.a && y.a <=3D x.b)
> +				return range(x_t, y.a, x.b);
> +			if (y.a > x.b && y.b >=3D x.a)
> +				return range(x_t, x.a, y.b);

Nit: here returned type us U64, while above it is S64, I don't think
     it matters but having same type in both branches would be less
     confusing.

> +		}
> +	}
> +
>  	/* otherwise, plain range cast and intersection works */
>  	return range_improve(x_t, x, y_cast);
>  }


