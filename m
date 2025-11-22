Return-Path: <bpf+bounces-75271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04CC7C001
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60884E1C4B
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B61D618E;
	Sat, 22 Nov 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHmNutOM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551721348
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770778; cv=none; b=U8e/ibkBAUFVOoMemI4OVX6CBOTyqMZ4feRF+nGZ5C8734kqeG6WntBnsfPh9oKFdZP8UoB75ulStR3RF5gYCMVj9zym7uU5VoCzEPwkx4f5x2dp6dZ7KAU1FSihESmOpQNBRlgTBH++EoRbZnaC1UM6fpxUnk2HDDI3Sj334to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770778; c=relaxed/simple;
	bh=qaq2oS2jJ6pqDlo7grmvT1vAaAIcdFj321fhEhW6euw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r98j0rutfr10dyPgfCcYz1YRlEZJl+Ps+d9wk3Y7G+hs6qfLwg553uBYPUiOF51fq5+1MCt6nUveMx7m+i+SZMWvmAtosLwbOtjOYtTiy+blsfWguKJCaThqIpgY/d0OILeFDVJ2IHnqESdTujwaLABu2Ir7tPT9LxVrD+STIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHmNutOM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2957850c63bso18043805ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763770776; x=1764375576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u80GPzPw/Eyy941aojjK6moLF4D4cN6rgcDrSgRcKCk=;
        b=cHmNutOM6TAq5rSX2ml/sOA9kp2p1PIDROlMDcMOWfcv9pNhlpauBe4tUHeELHqebC
         83llls+eRdU0dGmTJiz0fdcH9dsg9fYuCKNlEMtvohPkcs0f9Zl/ynqkkbt9YH/NpcT/
         +LszpOVOhJTs7uhgJD5jAYSQ/vp6S3Q+4QBM17Zv78TuwnVQDQwB4BUvV8Lxz6mt5JGH
         d9QFyu1eZ4G+iXmA0FtPFnLc+1geG1HUmPAcAENvTzbsrFu6ZBeAVyLJ+P6kW+s9mHUZ
         L39cGaT7nCvGiDSVU0+j1rCJUVAhZqwn6xh0EzPNrn3T+x9kLCfwSl2ktNNpLYa3h0Xa
         L9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770776; x=1764375576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u80GPzPw/Eyy941aojjK6moLF4D4cN6rgcDrSgRcKCk=;
        b=GV+taH75FlkG6OauPI6qw+nrDnHDERCt5UtsMovElKycHrgYzEOIwes7BKWbtC+nhr
         qMj/Hd4fVPxTcCzc1A85q2/wndQlX56lWx/ba//sR+JlQ1KdvT+5ld2LWYXci95oWQrj
         RlJqiIpbySt9xZD7nwo22R/egKmQP/syw3aOHxCTCEmqB1pctOGlWp7PsCA6s1VoczKc
         vVe0eRCGHNrlRmuG0uqkp0uZZt4vqsRTMZPXbCBXCjdi3Y0b97kXTRAA7hyJeaxKGoEi
         z0Xh3oW6OC3O/pySyQLI+rVCzwpZ13N9I/I0+IAFbpVCs+i8oynoxztS+0wrExxfy6+X
         J90w==
X-Forwarded-Encrypted: i=1; AJvYcCXDT05smDmqmVwV1rOvo8O6Xv0XwI1T0+WRUPMkY3vM75TNmERyzORv9z8IhHMJ4QZ29jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFNwkRlF8kjwZCNECADdkYwIzu+Kq/pIP/iRB96uW2bR5nM7J
	t0c0pB7Ya1QizsNDOYxSmtc0IisDHd2zPlO96rBuuS2jtGiVJXywu+jj
X-Gm-Gg: ASbGncuOtxAXvdljzra7ceoeKVSVBCkkj6ypWoGios9YER7L1gL/TlfEGpzDHaOYT3R
	XoydnmMlZN98wiDHST0d5UJI6ylqPyjJP1DkD3uXsiJO3wAcGR7vPxV1VpRXCo6Bm/c7E37ITDp
	eLRJaJ3CQjj0MiAH/zaDYEvaR94IOxROHra0qPu4RG0K8FuLeP0eaeYVMOcR4EEU6V3OgEBlNuE
	W5zYt5HCnpffYKuZ5nI4bcwBDKTMlBjEiRvv4Vvn583OsR2Zd6gLSKxUCyXCY0tBq+eJlP7BuLv
	UBOyjBUPVfB8qEu2ukbcoYf1FpdbWmkt015VE2DT+F8Rr7+VYSs3MKQKifOV6GweMN1sxlyTMfZ
	uViRUKuWEDtf73MiOxMpcm+FUKZucblhlrYHhnUtD6ruYU7INSEPSh2BnuloEcEeE1y72P1ewe1
	8+oS9rDr4=
X-Google-Smtp-Source: AGHT+IEtFRKLLE3Lje3wft/6rKyBWZ2hYaA01Mxhu4qbT7ASkkJyLyAiHKITNweab1bh0/mMFI/y+g==
X-Received: by 2002:a17:903:1110:b0:297:eafd:5c19 with SMTP id d9443c01a7336-29b5e2f78d5mr102120105ad.10.1763770776334;
        Fri, 21 Nov 2025 16:19:36 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bf9a6sm66701505ad.102.2025.11.21.16.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 16:19:36 -0800 (PST)
Message-ID: <19763eaaa955cd3c0c67e97b413309fc13c9e3a4.camel@gmail.com>
Subject: Re: [PATCH] bpf: verifier improvement in 32bit shift sign extension
 pattern
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>, David Faust
	 <david.faust@oracle.com>, Jose Marchesi <jose.marchesi@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Fri, 21 Nov 2025 16:19:33 -0800
In-Reply-To: <20251120105401.39183-1-cupertino.miranda@oracle.com>
References: <20251120105401.39183-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 10:54 +0000, Cupertino Miranda wrote:
> This patch improves the verifier to correctly compute bounds for sign
> extension compiler pattern composed of left shift by 32bits followed by
> a sign right shift by 32bits.
> Pattern in the verifier was limitted to positive value bounds and would
> reset bound computation for negative values.
> New code allows both positive and negative values for sign extension
> without compromising bound computation and verifier to pass.
>=20
> This change is required by GCC which generate such pattern, and was
> detected in the context of systemd, as described in the following GCC
> bugzilla:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D119731
>=20
> Three new tests were added in verifier_subreg.c.
>=20
> Signed-off-by: Cupertino Miranda=C2=A0 <cupertino.miranda@oracle.com>
> Signed-off-by: Andrew Pinski=C2=A0 <andrew.pinski@oss.qualcomm.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++---
> =C2=A0.../selftests/bpf/progs/verifier_subreg.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 68 +++++++++++++++++++
> =C2=A02 files changed, 77 insertions(+), 11 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 098dd7f21c89..f92ef36fbe62 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15272,21 +15272,19 @@ static void __scalar64_min_max_lsh(struct bpf_r=
eg_state *dst_reg,
> =C2=A0				=C2=A0=C2=A0 u64 umin_val, u64 umax_val)
> =C2=A0{
> =C2=A0	/* Special case <<32 because it is a common compiler pattern to si=
gn
> -	 * extend subreg by doing <<32 s>>32. In this case if 32bit bounds are
> -	 * positive we know this shift will also be positive so we can track
> -	 * bounds correctly. Otherwise we lose all sign bit information except
> -	 * what we can pick up from var_off. Perhaps we can generalize this
> -	 * later to shifts of any length.
> +	 * extend subreg by doing <<32 s>>32. When the shift is below the
> +	 * sign extension (32 bits in this case), which is always true when we
> +	 * cast the s32 to s64, the result will always be a valid number
> +	 * representative of the respective shift and its bounds can be
> +	 * predicted.

I don't understand the new comment, to be honest.
I'd say that smin/smax assignments are correct because s32 bounds
don't flip sign when shift to the left by 32 bits.

> =C2=A0	 */
> -	if (umin_val =3D=3D 32 && umax_val =3D=3D 32 && dst_reg->s32_max_value =
>=3D 0)
> +	if (umin_val =3D=3D 32 && umax_val =3D=3D 32) {
> =C2=A0		dst_reg->smax_value =3D (s64)dst_reg->s32_max_value << 32;
> -	else
> -		dst_reg->smax_value =3D S64_MAX;
> -
> -	if (umin_val =3D=3D 32 && umax_val =3D=3D 32 && dst_reg->s32_min_value =
>=3D 0)
> =C2=A0		dst_reg->smin_value =3D (s64)dst_reg->s32_min_value << 32;
> -	else
> +	} else {
> +		dst_reg->smax_value =3D S64_MAX;
> =C2=A0		dst_reg->smin_value =3D S64_MIN;
> +	}
> =C2=A0
> =C2=A0	/* If we might shift our top bit out, then we know nothing */
> =C2=A0	if (dst_reg->umax_value > 1ULL << (63 - umax_val)) {

This appears to be correct.
If old s32 bound was negative, the new s64 bound will be negative.
If old s32 bound was positive, the new s64 bound will be positive.
Since there will be no sign flip, simple algebraic rules apply.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(But please, update the comment).

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> index 8613ea160dcd..62da0b8cf591 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c

Changes to selftests are usually submitted as a separate patch with
tag "selftests/bpf: ".

> @@ -531,6 +531,74 @@ __naked void arsh32_imm_zero_extend_check(void)
> =C2=A0	: __clobber_all);
> =C2=A0}
> =C2=A0
> +SEC("socket")
> +__description("arsh32 imm sign positive extend check")
> +__success __success_unpriv __retval(0)
             ^^^^^^^^^^^^^^^^
   Nit: I'd skip the unpriv check, priv mode should be sufficient.

Here and in the other tests, could you please include the following
log checks:

__log_level(2)
__msg("2: (57) r6 &=3D 4095                    ; R6=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4095,var_off=3D(0x0; 0xfff))")
__msg("3: (67) r6 <<=3D 32                     ; R6=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3D0xfff00000000,smax32=3Dumax32=3D0,var_off=3D(0x0; 0xfff0=
0000000))")
__msg("4: (c7) r6 s>>=3D 32                    ; R6=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4095,var_off=3D(0x0; 0xfff))")

This will make test cases a little bit more obvious.

> +__naked void arsh32_imm_sign_extend_positive_check(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 =3D r0;					\
> +	r6 &=3D 0xfff;					\
> +	r6 <<=3D 32;					\
> +	r6 s>>=3D 32;					\
> +	r0 =3D 0;						\
> +	if w6 s>=3D 0 goto l0_%=3D;			\
> +	r0 /=3D 0;					\
> +l0_%=3D:=C2=A0 if w6 s<=3D 4096 goto l1_%=3D;				\
                     ^^^^
    Nit: please use either decimal or hexadecimal constants.

> +	r0 /=3D 0;					\
> +l1_%=3D:	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[...]

