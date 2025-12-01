Return-Path: <bpf+bounces-75847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D2C99A09
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 00:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED6E24E0F10
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2311D5CD1;
	Mon,  1 Dec 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8uAK8G8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93036D4EA
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764633000; cv=none; b=CnaGwbmulmSYRZU/A0rWFcmKE2pStdHTCLgZxPWYoOkgT0SVgWmK0wvCbDH78k4YEniM6q282mB/SqoyEie6OzImjvhc+tQgPNsE/kG61/9gGo6bsxaSxCA0UqErLljc5eY6yZGCPDZLgh6K5kbepDjUZE8OPtCqxQJZQr+EiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764633000; c=relaxed/simple;
	bh=rZEKvQKy8ODSxY/cqKlRzdHz8mQTU2vFY9pi0URJpyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WV6ZfYmPGHDSdwqrBHNJc6TybnrWiKkUO2dbB2PRY+vyhLpVT+VDTcLINekge/yU1XIXxLpOfmLOm8JLcLE9MwqB3aVrNIXoKs1xB2Fy91NfaUht2zHAIrTv5xs5L3CDcJXKycNckpC40pTy8IomdZIQtLURfVK/hFXbiihJTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8uAK8G8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343684a06b2so4570355a91.1
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764632998; x=1765237798; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=73RfFI8iCMKVaI5BDVN9LSQj2E1nXmtQD8pzfup9B7I=;
        b=h8uAK8G8qTfydKPaRws0lCrhHohr6ICuJJU7riclytc5hRFv/DUojoa2wEdEfxZkZp
         oJWG++Y7zxD5d7WIOFw1mmDcIvSjxeC55PVXL+NjkiMXJh+qGe1/h0ytPFJmZbV0/vWw
         PdWXL4xIJVJARpjRvDQoJUPF2Cgs2Dg8A+GqMFUTDg6I8L6u/wtPV/LNhWHymx99tD6t
         Oypt5KsU7WKgFF3m7FMjmVOtXX2IW+dyhqoYZk3UJQFsMnFOkH+rlQTlVvrgY04r+A6V
         AGSyh5zMV9G7LzIBgOLRHb3vtrjWD5pC/PHJK6sijGqwcSTNl8DPZU58dsyE9WJPf3kM
         8acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764632998; x=1765237798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73RfFI8iCMKVaI5BDVN9LSQj2E1nXmtQD8pzfup9B7I=;
        b=emR9fULo0Wx0lJA5sZkS3/1LdmOuxXh5wvXJVJKuri0MglU1Pn7OIEWTGX656XWceD
         cVZjmAVYOSTevOjorYd//4c4HX8a3dKysH28YPrUtrDl1hD2tBBYq4fPvc4yorsvnEcK
         Y6fKYOeq+JIvYPP6oSpfzG7y26ba7g/X3IMXQyOYcB6JxXTf3FySLL51d3IUBXoA2pyo
         mmYlvyGG2vljzsW4c2Pi95sWRbUW6IHHmWr6DkcrLPEdgptMkgJgyXHBw/9umx0cDLE1
         VEJ2eTlX8K96ey4Gtmif6t6uYYUMfViw42y1wblNpbZXDz19TwqWcgHqN9GeS9LxWqXs
         Rigg==
X-Forwarded-Encrypted: i=1; AJvYcCVqd2eYsPPpz3vgiz8Qg0Mp3GKfjPmZB7Qr9jAUjUADe8DrzelGfuJUCl4FdfC6hScgQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBsyb3hCYC+0PllDeQ5NHokNCJ8h9d2/+n4uS+ilwrhguBZAt
	bdtkVgNVwRJwrYvSnWuRK68v3HW6YD4x062M+LyjAcfXNjCgWD9PLWEt
X-Gm-Gg: ASbGnctUBudQgddKdB9YfTS4OMv289fCJ+ZckKtSwFJT1tFxwM91mcjdDA25pdMmX0q
	REU2J7Na3IUzwu9Ebr1a5cjKafoEP9PG5vmYmnnkXQTsM6MPq7ivRM3PzpicTm43u9hGggoOU4Z
	c3abPKtMx62iwiDlDIZPQkpWd8E8NNFton0NdsfbteS59fB78zvYcBTqUQ2hA5peTI4lXzfmTSB
	gBJkLROnHD1wRTQgdgaf5XpTNdiSfEgUV4ar/G4GPZIp43sHZCdFcBYw7KjdOztx0L+1PSgLk/A
	DYWUVBSRg4eM0Wn3tHjgIg3XeN5/cOP6ilZbyDu1BGtK/cvTX6YwaoGydTwZ4hHcjjz+Spwxeye
	Qx6brsVnhzZVffXbUtKycsn0/rh7PYIOdRH1a9ooCj1NTsft/oFbwSoLJyg9/bMnSzfmhH+QKsJ
	M7hxajAJR52fV8hYYQ6NsgQ9PeoaPkKXZjiF1/
X-Google-Smtp-Source: AGHT+IGJFC+U7uTchYwkuemCBq9WQYPPvLYretMr6tq1CUMMX5sdmYFigDWDFv5wc/7ZP9cmm/+Lng==
X-Received: by 2002:a17:90b:2b50:b0:340:ec6f:5ad0 with SMTP id 98e67ed59e1d1-34733e55257mr35142155a91.1.1764632997753;
        Mon, 01 Dec 2025 15:49:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a2c1:e629:f1e2:84c8? ([2620:10d:c090:500::6:79eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a54705csm18087784a91.2.2025.12.01.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 15:49:57 -0800 (PST)
Message-ID: <cad6577291b778e6caad2f06fae304b2ec07f752.camel@gmail.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko	
 <mykolal@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Mon, 01 Dec 2025 15:49:54 -0800
In-Reply-To: <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
	 <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 14:56 +0200, Dimitar Kanaliev wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 766695491bc5..c9a6bf85b4ad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_reg_st=
ate *reg, int size)
>  	reg_bounds_sync(reg);
>  }
> =20
> -static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
> -{
> -	if (size =3D=3D 1) {
> -		reg->smin_value =3D reg->s32_min_value =3D S8_MIN;
> -		reg->smax_value =3D reg->s32_max_value =3D S8_MAX;
> -	} else if (size =3D=3D 2) {
> -		reg->smin_value =3D reg->s32_min_value =3D S16_MIN;
> -		reg->smax_value =3D reg->s32_max_value =3D S16_MAX;
> -	} else {
> -		/* size =3D=3D 4 */
> -		reg->smin_value =3D reg->s32_min_value =3D S32_MIN;
> -		reg->smax_value =3D reg->s32_max_value =3D S32_MAX;
> -	}
> -	reg->umin_value =3D reg->u32_min_value =3D 0;
> -	reg->umax_value =3D U64_MAX;
> -	reg->u32_max_value =3D U32_MAX;
> -	reg->var_off =3D tnum_unknown;
> -}
> -
>  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>  {
> -	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
> -	u64 top_smax_value, top_smin_value;
> -	u64 num_bits =3D size * 8;
> +	s64 smin_value, smax_value;
> =20
> -	if (tnum_is_const(reg->var_off)) {
> -		u64_cval =3D reg->var_off.value;
> -		if (size =3D=3D 1)
> -			reg->var_off =3D tnum_const((s8)u64_cval);
> -		else if (size =3D=3D 2)
> -			reg->var_off =3D tnum_const((s16)u64_cval);
> -		else
> -			/* size =3D=3D 4 */
> -			reg->var_off =3D tnum_const((s32)u64_cval);
> -
> -		u64_cval =3D reg->var_off.value;
> -		reg->smax_value =3D reg->smin_value =3D u64_cval;
> -		reg->umax_value =3D reg->umin_value =3D u64_cval;
> -		reg->s32_max_value =3D reg->s32_min_value =3D u64_cval;
> -		reg->u32_max_value =3D reg->u32_min_value =3D u64_cval;
> +	if (size >=3D 8)
>  		return;
> -	}
> =20
> -	top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bits;
> -	top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bits;
> +	reg->var_off =3D tnum_scast(reg->var_off, size);
> =20
> -	if (top_smax_value !=3D top_smin_value)
> -		goto out;
> +	smin_value =3D -(1LL << (size * 8 - 1));
> +	smax_value =3D (1LL << (size * 8 - 1)) - 1;
> =20
> -	/* find the s64_min and s64_min after sign extension */
> -	if (size =3D=3D 1) {
> -		init_s64_max =3D (s8)reg->smax_value;
> -		init_s64_min =3D (s8)reg->smin_value;
> -	} else if (size =3D=3D 2) {
> -		init_s64_max =3D (s16)reg->smax_value;
> -		init_s64_min =3D (s16)reg->smin_value;
> -	} else {
> -		init_s64_max =3D (s32)reg->smax_value;
> -		init_s64_min =3D (s32)reg->smin_value;
> -	}
> -
> -	s64_max =3D max(init_s64_max, init_s64_min);
> -	s64_min =3D min(init_s64_max, init_s64_min);
> +	reg->smin_value =3D smin_value;
> +	reg->smax_value =3D smax_value;
> =20
> -	/* both of s64_max/s64_min positive or negative */
> -	if ((s64_max >=3D 0) =3D=3D (s64_min >=3D 0)) {
> -		reg->s32_min_value =3D reg->smin_value =3D s64_min;
> -		reg->s32_max_value =3D reg->smax_value =3D s64_max;
> -		reg->u32_min_value =3D reg->umin_value =3D s64_min;
> -		reg->u32_max_value =3D reg->umax_value =3D s64_max;
> -		reg->var_off =3D tnum_range(s64_min, s64_max);
> -		return;
> -	}
> +	reg->s32_min_value =3D (s32)smin_value;
> +	reg->s32_max_value =3D (s32)smax_value;
> =20
> -out:
> -	set_sext64_default_val(reg, size);
> -}

Assume that size =3D=3D 1, s64_min =3D 0b000, s64_max =3D=3D 0b100.
This corresponds to tnum with value =3D=3D 0b000 and mask =3D=3D 0b111.
Old algorithm computes more precise range in this situation.
Old:

  0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
  1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
  2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
  3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
  4: (b7) r0 =3D 0                        ; R0=3D0
  5: (95) exit

New:

  0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
  1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
  2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
  3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D7,var_off=3D(0x0; 0x7)) ...
  4: (b7) r0 =3D 0                        ; R0=3D0
  5: (95) exit

Note that range for R0 at (3) is 0..4 for old algorithm and 0..7 for
new algorithm.

Can we keep both algorithms by e.g. replacing set_sext64_default_val()
implementation with tnum_scast() adding tnum_scast() in
coerce_reg_to_size_sx()?

In general, for such kinds of patch-sets it is interesting to see how
much precision is gained/lost with the change. It shouldn't be hard to
collect such data for e.g. complete s8 range by writing a small
user-space program that enumerates the s8 x s8 range and applies both
old an new range computations.

[...]

