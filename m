Return-Path: <bpf+bounces-50178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78369A237CA
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 00:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D838E164848
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC21F03DB;
	Thu, 30 Jan 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftVWxxYc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FD1BEF63
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279508; cv=none; b=Qw3kB//KBlfjSjroP3PfXmt7M9LGdJ2bZEYnMjy2my7Zv8iA3E6nrBy+/6gyWgxGvPaVJxgm1+2SpwfZMhWwAzU/dxxxUvWqDkdFe5Gz7Hezwkx+HjTBSP7Tf2VHMk1DfKlEA0/hrX8NM/RJYcwZ5F9+ZqwHfC4D2QEbZUNroIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279508; c=relaxed/simple;
	bh=xV9qx1XHUphAUNHwVx8wOuoP3ZpbNtYcYyYcNNfFXqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxg2QQ/7ZIMCvK+Y+T+7rfOALoctY5sikt5D+hWllcvbE2mhs9zwzDyqcJ/j3FSvdzXNNP6jwehaNMgC9C7Qp8nHGmK6+G98iuBSD5RHuQGWHYS0kHKG1201FYwPxraSgUKSSsn05dtO3e24nUxcgiWWEaPkyCQVhN1wsiCDzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftVWxxYc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso3942825a91.1
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 15:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738279505; x=1738884305; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rEsd5DweQ9RKHveqCV/87KCiNoseqKxhg8AyJFjYtdk=;
        b=ftVWxxYccT/bjEPj2+Gw7rwVg/CsdasTQQ1B9/xpKkQ403OW7hCg3hpdlUHL7Go+La
         SSs/LBI+Ymwcno1iVLAHZ2Rd7tSHscL82zFlODYoTWDCrT1SOX868WIR8NOMrVKli0Kz
         run042NddCCbQVfmf0jeT0pgDgUouX3qztJd2UHpQTHRgFUtBz7b1jqBV87TA6PZn0Mk
         AiMaGUwBJYBsltI9i2ZRP4TxjnFaoIQdq+bXyK3ORsKp4YpVHMa8gpBcXGTEVV+4S7FW
         naLXeOfq8jN/FZYARIwxzAhNKMyzNU3NO2RdX9tc7jb3ogD1IrgMY5Z+5FmQnkaGtr6F
         NGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279505; x=1738884305;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEsd5DweQ9RKHveqCV/87KCiNoseqKxhg8AyJFjYtdk=;
        b=PveFginqhZNenpJLV7yEqax1QYjAWQybTwETDrvFioDYVn6QUl5MhhpbFbtKyzXvL8
         /99ooEfaypdnUtGTTygmyt2iaV3Pjnw7PU2ZOVQp/zlY9Hqk++ZukYutWnyASag9fO2K
         2B2F8KiDOWz2Ptnyb6NJ9Dtp2NdepFfGFOzZSambgqWziMCsGA7RHfYIQKl3PT2a2nUm
         TtZgwsyT3Z7PllelTbSJmdEUlsbK0+9Se6FarYTB7Q5pE3+Bl7585+mrNJTmve8I6jTm
         O6RpaHezaYk+9TDlG/goH74SC+XBqS6Web8yiiqs1eRTskTUaRokU9oBglJJ0OtXoduv
         ZPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUSywoduDU0lxilkW+kzt/GkNqKe6+fHUtzS/Cp+SSFOWbtwN4cMRv+NE4Pn+u8u4QR/Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvI5WlgG8PjoUTurkxrLwHm8ShNyqzWmaGMb5qzTvq7X7c8qt
	WpXWfJJDwjqlVKILO0kSWYOOXydfsV5xwZ5K63RiltIpXmr07Wt9
X-Gm-Gg: ASbGnctsj83tYuYeIqTIuf52Zx/xJWnLqxogsQ7NzMW8po/KujwGH1UIxFjr9tn1ykE
	D40FWMcdIEJgg5sJ9sDHE6RFYan3dJpIhHCDj1e3Y8Z7IfKHbf1+IlG+kqfMGhgeiz/Xoiw8irV
	d951LSJp7MbY/HNg7mt0pR2T6VIMxg/xtuoIMK6tD/0uCAJn+dUYY44QWclmh4UtCX1lLbE219q
	oTzCWUUDQ5eYKsxeIxHu5SZf+XtlvU128pR0zukBxkrGTlhmWnutXEtvOL+zwHuPnXHl9VGOwUo
	Xa7AIinckP0L
X-Google-Smtp-Source: AGHT+IG8cyu4Y2oSPaVAlDa0yXVCmbETzxOiet6DbKA+TkN15AbsfFlHE2eplpX4/HjDJQqKxytJAg==
X-Received: by 2002:a05:6a00:808e:b0:725:cd8b:d798 with SMTP id d2e1a72fcca58-72ff2c2f881mr2094446b3a.9.1738279504204;
        Thu, 30 Jan 2025 15:25:04 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653ab13sm2045467b3a.83.2025.01.30.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 15:25:03 -0800 (PST)
Message-ID: <99c5181efc1fccb90bb04190abe174abfce8354a.camel@gmail.com>
Subject: Re: [PATCH v0 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu	 <shung-hsi.yu@suse.com>
Date: Thu, 30 Jan 2025 15:24:58 -0800
In-Reply-To: <20250130112342.69843-3-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
	 <20250130112342.69843-3-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-30 at 13:23 +0200, Dimitar Kanaliev wrote:

[...]

>  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>  {
> -	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
> -	u64 top_smax_value, top_smin_value;
> -	u64 num_bits =3D size * 8;
> +	u64 s =3D size * 8 - 1;
> +	u64 sign_mask =3D 1ULL << s;
> +	s64 smin_value, smax_value;
> +	u64 umax_value;
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
> -
> -	/* find the s64_min and s64_min after sign extension */
> -	if (size =3D=3D 1) {
> -		init_s64_max =3D (s8)reg->smax_value;
> -		init_s64_min =3D (s8)reg->smin_value;
> -	} else if (size =3D=3D 2) {
> -		init_s64_max =3D (s16)reg->smax_value;
> -		init_s64_min =3D (s16)reg->smin_value;
> +	if (reg->var_off.mask & sign_mask) {
> +		smin_value =3D -(1LL << s);
> +		smax_value =3D (1LL << s) - 1;
>  	} else {
> -		init_s64_max =3D (s32)reg->smax_value;
> -		init_s64_min =3D (s32)reg->smin_value;
> +		smin_value =3D (s64)(reg->var_off.value);
> +		smax_value =3D (s64)(reg->var_off.value | reg->var_off.mask);

Note the following code in __update_reg64_bounds():

static void __update_reg64_bounds(struct bpf_reg_state *reg)
{
	/* min signed is max(sign bit) | min(other bits) */
	reg->smin_value =3D max_t(s64, reg->smin_value,
				reg->var_off.value | (reg->var_off.mask & S64_MIN));
	/* max signed is min(sign bit) | max(other bits) */
	reg->smax_value =3D min_t(s64, reg->smax_value,
				reg->var_off.value | (reg->var_off.mask & S64_MAX));
	reg->umin_value =3D max(reg->umin_value, reg->var_off.value);
	reg->umax_value =3D min(reg->umax_value,
			      reg->var_off.value | reg->var_off.mask);
}

Is it possible to set {u,s}min/{u,s}max to {U,S}64_MIN/{U,S}64_MAX and rely=
 on
__update_reg64_bounds() for this computation?

>  	}
> =20
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
> +	reg->umin_value =3D reg->var_off.value;
> +	umax_value =3D reg->var_off.value | reg->var_off.mask;
> +	reg->umax_value =3D umax_value;
> =20
> -out:
> -	set_sext64_default_val(reg, size);

After this commit the functions set_sext64_default_val() and
set_sext32_default_val() are never called.

> +	reg->s32_min_value =3D (s32)smin_value;
> +	reg->s32_max_value =3D (s32)smax_value;
> +	reg->u32_min_value =3D (u32)reg->umin_value;
> +	reg->u32_max_value =3D (u32)umax_value;
>  }

[...]


