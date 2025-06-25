Return-Path: <bpf+bounces-61585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE56AE9067
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0286D4A7B74
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86599215191;
	Wed, 25 Jun 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/wx87rC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F226E6EA
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888013; cv=none; b=npI/iKAUXAoiH8m2TS0RvP4hq9Yh9a48KYJrriMAMIuLbDMxBeJ1FrsDfSL8xC+CcZo6MHbVw8FH8H8sXcXntjndPE8KGuwBSa5eXk/jAqlNwBght+zDKZumNVhW4b0JBiFasYipFH/8fxoUcbQ1KsJtaXNkmj5hPrh1rEGpNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888013; c=relaxed/simple;
	bh=K1APj/dnLiB3sTfTJrSm0zHYLiHaziF47AVnv10jFBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FplEod34Bk3h5u+YpHS3B9I87lyZidhtadBdRL4PqGjGFGHU4ml/6LsPcnI2Ytvta88Y1emMyNKu25c+AXeydo0hQR9AoskcxZDDZst3onZyHtUXzqptT/vPf/khcVTVO+VGXIddUP24Ow9KOx/SUkZlCWg9sd9uRDvvHomcrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/wx87rC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236377f00easo5011875ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750888011; x=1751492811; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OUerEWOPxeiCZ533b6jXsVza23MjA5VB219q0mwbYCQ=;
        b=T/wx87rC+LgF9FmRSnqS7orwmmyj/q05DbEHMUlDege8++/htJuCL5rR+G+mKXJsT9
         /MLbFd/uEotkvX4zyiwSLPT0IQ7QCrMhtT14KNeakO6+ez6J4MSSTgspricjeZmaW1Og
         6fW6Drc1vrhHZCRP6kCayNarjmtwjcI2+FIfbEcPpdjpBufugwr6ghMnlJKTK7Yi8+Vf
         Frcan+Q1vkSz8PCDgebTuEcNW/+kxSM8swCJgvPummTNxhRY/PB9/mjP/IVuiFmwYgkC
         JyLHE+ISll5xqCwah3DvFksll1IRnMy47aaWYHRLEcCuD7NtPVOh8+D5JPYWeT/R30MG
         zykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750888011; x=1751492811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUerEWOPxeiCZ533b6jXsVza23MjA5VB219q0mwbYCQ=;
        b=SBWLGmtJ3sXDVNtVYLFRnXE851y4qO/mzpMbqQXS4ihMKIrQhZCar9ANzaiipF3/8t
         f111S+MtisffRJVuG1Xopk5M8Psy3weDlZEwTNFgLEvTHHezTattcFlpJJX9P9ABsRMY
         9Mo6Qn9oVjAdDzDn1uXqM3fajq817wd78skLgnQX+n6iRPxxzhuyruh6JYmPQaliD2e1
         tsj67L8504yNPTkhgoUeD9Nt0CGTXyzUwOmjx29yzBNprGZUAA5k0G2s+Ua+k6mPC975
         RFcUG6OK9Q+bBVeCUuo6QPkBTwg6S/q0FXP4+iv6k7sQFThNLr1Gfnu7dYqTPwTrLpP2
         YZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUArWh2x8t+WcGfHKF4RsELh/IJFVaEu4tr1qOCp9ArRZaRfxI5IcvB2NQGBG/tawwK61s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6+DttFA+Xt6EMUOu5wPg85+dWM+m6/GHlFzGkSACxzv8/MoD
	apyH+FWecrGkqIwMUuhYqfd1DkKDRA/OTU3dx1YWqC9O4iCGpVXrKzEH
X-Gm-Gg: ASbGncsAPtyX1z6Iqe+v8xO1gD3lJbLdeUWJi3ymxwDLhn4WJQE36PmewwExTKRGD1/
	G7cNs8uMzq8tKD+JTAJCJY9Gx+sKRyB/ZxdTwBckKtwWsPCtuxLx19b4wzrH0vu18vDsXgSX032
	dtnvcZY1mKcO/Aqg6y8qvD5nWGUH/e236eskzn7ovXmnoX11j5gbXTHwHlsZW8ZsFaZ/zbl8KNY
	PfQzhuSvzfaKIS2MZa2gJvXVBtH3h1AtwOKTbXhMy1SmsxI2NSC+4gWNXj+d9irelcBkcc9K8sT
	HU/qpLqQp4MPFb3WCsOxVNSzutMdFsWTtuiT4TVUESZEcVUmCpDbM32V2CFacaKFwgbDsc10bfA
	iwuv3s56DI7c=
X-Google-Smtp-Source: AGHT+IGgQ3T7J7S/ka+l50E+AtWqY4tFvCbubBSCpg+Yw/tnAcAjD2/ZkHzA2Ycb8g0A4PMmSpWzHA==
X-Received: by 2002:a17:903:4b27:b0:234:d679:72e9 with SMTP id d9443c01a7336-23823fcc7b9mr85332515ad.12.1750888010737;
        Wed, 25 Jun 2025 14:46:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm141495175ad.86.2025.06.25.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:46:50 -0700 (PDT)
Message-ID: <20a5f48ff07d02da2f51aaa815a0943078c87655.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 25 Jun 2025 14:46:48 -0700
In-Reply-To: <20250625165904.87820-3-mykyta.yatsenko5@gmail.com>
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
	 <20250625165904.87820-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 17:59 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Implement support for presetting values for array elements in veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> ```
> Arrays of structures and structure of arrays work, but each individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

This looks great, I have a few minor nits but let's land this patch-set.
Maybe fix error reporting below as a follow-up.
New array offset computation logic is much simpler to grasp.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

---

Nit: this signals an error:

        $ ./veristat -G "   arr[   fff  ]      =3D 1" set_global_vars.bpf.o
        Processing 'set_global_vars.bpf.o'...
        Can't resolve enum value fff
        Failed to set global variables -3
        Failed to process 'set_global_vars.bpf.o': -3
     =20
     but this does not:

        $ ./veristat -G "   arr[   11111111111111111111111111111  ]      =
=3D 1" set_global_vars.bpf.o
        Failed to parse value '11111111111111111111111111111'
        Processing 'set_global_vars.bpf.o'...
        File                   Program           Verdict  Duration (us)  In=
sns  States  Program size  Jited size
        ---------------------  ----------------  -------  -------------  --=
---  ------  ------------  ----------
        set_global_vars.bpf.o  test_set_globals  success             27    =
 64       0            82           0
        ---------------------  ----------------  -------  -------------  --=
---  ------  ------------  ----------
        Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.


>  tools/testing/selftests/bpf/veristat.c | 239 +++++++++++++++++++------
>  1 file changed, 189 insertions(+), 50 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 483442c08ecf..9c67adcf0a33 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

[...]

> @@ -1670,10 +1706,16 @@ static int append_var_preset(struct var_preset **=
presets, int *cnt, const char *
>  	memset(cur, 0, sizeof(*cur));
>  	(*cnt)++;
> =20
> -	if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=3D strlen(=
expr)) {
> +	if (sscanf(expr, " %[][a-zA-Z0-9_. ] =3D %s %n", var, val, &n) !=3D 2 |=
| n !=3D strlen(expr)) {
>  		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
>  		return -EINVAL;
>  	}
> +	/* Remove trailing spaces from var, as scanf may add those */
> +	for (i =3D strlen(var) - 1; i > 0; --i) {
> +		if (!isspace(var[i]))
> +			break;
> +		var[i] =3D '\0';
> +	}

Nit: It appears, this sequence is needed only for nicer error reporting,
     I'd just drop it.

> =20
>  	err =3D parse_rvalue(val, &cur->value);
>  	if (err)

[...]

> @@ -3164,11 +3296,18 @@ int main(int argc, char **argv)
>  	free(env.deny_filters);
>  	for (i =3D 0; i < env.npresets; ++i) {
>  		free(env.presets[i].full_name);
> -		for (j =3D 0; j < env.presets[i].atom_count; ++j)
> -			free(env.presets[i].atoms[j].name);
> +		for (j =3D 0; j < env.presets[i].atom_count; ++j) {
> +			switch (env.presets[i].atoms[j].type) {
> +			case FIELD_NAME:
> +				free(env.presets[i].atoms[j].name);
> +				break;
> +			case ARRAY_INDEX:
> +				if (env.presets[i].atoms[j].index.type =3D=3D ENUMERATOR)
> +					free(env.presets[i].atoms[j].index.svalue);
> +				break;
> +			}
> +		}

Nit: removing union in `struct field_access` would simplify this loop to:

		for (j =3D 0; j < env.presets[i].atom_count; ++j) {
			free(env.presets[i].atoms[j].name);
			free(env.presets[i].atoms[j].index.svalue);
		}

     (assuming zero initialization).

>  		free(env.presets[i].atoms);
> -		if (env.presets[i].value.type =3D=3D ENUMERATOR)
> -			free(env.presets[i].value.svalue);
>  	}
>  	free(env.presets);
>  	return -err;

