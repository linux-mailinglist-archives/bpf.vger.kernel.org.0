Return-Path: <bpf+bounces-61454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F8AE7225
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EF91BC2664
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A325B1C4;
	Tue, 24 Jun 2025 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlB0Hm8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2C246BCD
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803291; cv=none; b=dq2OYFOhxixTmVKFzux77o+oCHYaCLy33ATYCYE1XMAC90MMEsFIGLOamhiwmz9qIirIo670VTDxefhFo2HRiKsCVgK+x7U+MwL/2OevoBbJA2msNHRZ6fzwUy7x6ruRb3mZfYe+ajTtj5tDu4xaHiUY+TxgY6fFE1tjv+Cvn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803291; c=relaxed/simple;
	bh=XZ/u9Oy/LrX221d7guExpNZD5rTlcb0NxC1sl3pNqhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVG7YhPiYgTQ5plWZlgww3VMfIXeqqQSlXMV1/U7qwkqhYtVLbOLpgOS4gr9ebPKwwzPt/PeWtRMu0j8P23hWVRppl9FgKHG52zB6p12uAoYKqpOyVE5mE4OcuasGhspQMP8KMq6EFhSdBjupZ6sHQ3t8lQEkn4DTC75RkgH3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlB0Hm8i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6369626b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750803289; x=1751408089; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qC1Iz4sEqiZMcMa5DS15LIIYnBsZUNaGeA2wRZ3iBkY=;
        b=KlB0Hm8iMh3q3ndLxFNR6z1pUVm6aZInvE+TbZRnXh10+Uq/MtXOjXs8qvunHZOvys
         u1RR/3NpivAFaeuSGxw7nfXDkixjQXqjjT9hcZKvx74fvkTUmuCt8y8Zj88GsE7L/v9a
         fg7c0AOWOkZasRPM2bBlRHz+s20PD65a4tQCbi+1TP2DAEdxpxJ8BNZV+5tR2VR4Ko/8
         cl3Kj1E8qkwxJ27e/akuQL75Yh20kQCm5V9jGMSUwTze1BKiXrD2YmkJcvt4z/guhOMN
         k5EKf9Rfm/HdGqyLYK8NI4TSzGne+VAccJ6C26OpqqV6ghUfWyLV3/R+pDKPkejL2MNy
         Z+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750803289; x=1751408089;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qC1Iz4sEqiZMcMa5DS15LIIYnBsZUNaGeA2wRZ3iBkY=;
        b=a0zCdmr1uZVdf98CaPlTVN8Rk7x0EdETViQk4xaUT3eImPZSOtHMk7TSB82lKaw9wh
         ERNhA+Jzm0N/LzWKU4jKU0gasiDxG9z1fCU0LPho2d5OE55aWTSn08ZKDu7G8+umrdtH
         pNgSgs85s2ECMqjgOgd/bzBtpiHc7uXcVssP+4yK44LqDEPWA71vSCNhFb2XD3jZchHv
         GTWxy9VByxWVCy0fACgWXrg89PUYmyLeRp8TttpmxAUcUAy+/3OSzugxSQETKtGVn+Gg
         i6cGkoNmA4l/OcNVIE4+kBpvFTP6E80w4JIkj9DQLEJaesCh7uPaAY1nqDhMMYR/4Eky
         SQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUtr31HxJa6c0edPEmtCELg1dQd5LWUCjA3CXkCtRoh9HQOU35mA5AiZtB7XQLFGD3YzcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCEZRXKU8gruEIyh+1hln7RbWAl0M8UVQevkBT9eTKlNMjmQO
	JNMUHKPOU00aOc75fAY/Q2JDACuHf0AyCbRwPuTS+qdTqgMOOrCRr/fZ
X-Gm-Gg: ASbGncsRzaQxOVkoeflreBbtrUJqTNgcjMo3V9zg/t+TIHf3JxfMjIenrMzdQP29RU5
	YIAyJc3EHvUHL9XFpi3RDSvvAWHdLhQkv5Yv/SAKVCjfmGbrflFw+HmJ2dQr0xycoUUyK/C2z1y
	pbzbel7bu6Xzdw2gub6eOxoKcyBAdF4+LnZIJ1KZb+SyqMGgzYxBoUVUngg9KQjRgfPDuGu4pQy
	pVdVYW/8d2XzU7FMH0gIkbLoD/7hEwhSEU2xl6DTkOjNlLnJ8KYc8Nllpu28FCJiooZYi12JreJ
	l5mlTQ18uhoEAsYJT1795Dh3Vw9VJrCB5/yaC6FT6cgJ2NBz168xI5GZiqF/iSIRNV3XUycbgFU
	AQB9ye0Akbg==
X-Google-Smtp-Source: AGHT+IHDzeQIKEyl9BzDVIjP2HlTAeRAcuEKYP9gucCiqUh3/f4cViFCQDgDRO5e/2RuRPO0sHqaaw==
X-Received: by 2002:a05:6a21:680b:b0:204:4573:d854 with SMTP id adf61e73a8af0-2207f1adf3bmr881782637.9.1750803288898;
        Tue, 24 Jun 2025 15:14:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88732a8sm2805204b3a.175.2025.06.24.15.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:14:48 -0700 (PDT)
Message-ID: <19803713ab26e3c464710c9e9bae60c7dbb8fdd9.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Tue, 24 Jun 2025 15:14:47 -0700
In-Reply-To: <20250624220038.656646-2-song@kernel.org>
References: <20250624220038.656646-1-song@kernel.org>
	 <20250624220038.656646-2-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 15:00 -0700, Song Liu wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.=
c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
> index c506afbdd936..8d886c15fdcc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
> @@ -151,21 +151,4 @@ l0_%=3D:	r0 -=3D r1;					\
>  "	::: __clobber_all);
>  }
> =20
> -SEC("socket")
> -__description("check deducing bounds from const, 10")
> -__failure
> -__msg("math between ctx pointer and register with unbounded min value is=
 not allowed")
> -__failure_unpriv
> -__naked void deducing_bounds_from_const_10(void)
> -{
> -	asm volatile ("					\
> -	r0 =3D 0;						\
> -	if r0 s<=3D 0 goto l0_%=3D;				\
> -l0_%=3D:	/* Marks reg as unknown. */			\
> -	r0 =3D -r0;					\
> -	r0 -=3D r1;					\

It looks like rX =3D -rX was used in a few tests as a source of unbound
scalar values. It is probably not safe to throw these tests away or
convert failure->success, unless we are sure the logic is tested
elsewhere.

One option to keep the tests is to call bpf_get_prandom_u32() and
obtain an unbound value in r0 as a result.

> -	exit;						\
> -"	::: __clobber_all);
> -}
> -
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c=
 b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> index fcea9819e359..799eccd181b5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> @@ -225,9 +225,7 @@ l2_%=3D:	r0 =3D 1;						\
> =20
>  SEC("socket")
>  __description("map access: known scalar +=3D value_ptr unknown vs unknow=
n (lt)")
> -__success __failure_unpriv
> -__msg_unpriv("R1 tried to add from different maps, paths or scalars")
> -__retval(1)
> +__success __success_unpriv __retval(1)
>  __naked void ptr_unknown_vs_unknown_lt(void)
>  {
>  	asm volatile ("					\
> @@ -265,9 +263,7 @@ l2_%=3D:	r0 =3D 1;						\
> =20
>  SEC("socket")
>  __description("map access: known scalar +=3D value_ptr unknown vs unknow=
n (gt)")
> -__success __failure_unpriv
> -__msg_unpriv("R1 tried to add from different maps, paths or scalars")
> -__retval(1)
> +__success __success_unpriv __retval(1)
>  __naked void ptr_unknown_vs_unknown_gt(void)
>  {
>  	asm volatile ("					\

