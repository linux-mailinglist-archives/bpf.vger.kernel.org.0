Return-Path: <bpf+bounces-28204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DED8B6620
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0311F21F2E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD514291E;
	Mon, 29 Apr 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az//8DFi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9117BCA
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432728; cv=none; b=OH/wy0FGSfeoR7QEOFHFvBGf1dMnS0Q2dI3JOR8BTGnNAoWXSeLOwxLJVCkFxONtIyjWLqNrBoxnwdtLJbyD6dvoXOXgheLwwR/RoFz7hbFa/e/nxaq8iaiQXu7o/cfQUl3WZxny0tt10V8W+fRdQuCuNOuw+YM9Z362qiF0CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432728; c=relaxed/simple;
	bh=zD5q2oN1aHzZVebIyWykjjL3tT3bDKEqCrtdo++vEIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AU61eA32AcVtpcXm1azpXulFQ5aLe/cBtgC097zjduvNuozyTtkTRwSuFdcFoVlstg2ha14ZohMPST6dEAVyto2ms7aMTIMC7z1zzWc4aC3t4dLKcKTsP5RHhstISrSfpkA4s+rjzZX+m3vUw0oby2oSXRmhFj6n208zbbDZNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az//8DFi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so4805954b3a.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714432726; x=1715037526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qn7DMGAUz338VYB3aUCxqduyCzNzgQxkBrrXlXrL4dE=;
        b=Az//8DFiA59CJjA63hUo62bBVbXQJ0OD7N2n1JNXEyyoOA/B9ue3RO8AtE3xNFfCRN
         YtgYW3r2LBRH6fQiJbA3TA+O0CYVzsJb+pHeI1B5pRSvtIOMOr/ddURHBkxnmrBpJG/q
         xrHYCMqBpDV029P+mAG7h0ksvOE7Mda98TebKDNvxxuSZoZAsaEo/kLV/boGi7/48+uW
         uEdA0/mvgxgyud/NmSNkHIu1abzrCygK8s2XAaMktWr0stv0IdTVfDo5Y40hgoB1IJvm
         bISxENOVbqXnyCTQoF8n8+cAte76Mru1t+CkQweZVM9e+/ZV223G5POxyHtfD8fg48yV
         xu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714432726; x=1715037526;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qn7DMGAUz338VYB3aUCxqduyCzNzgQxkBrrXlXrL4dE=;
        b=kq2A79odswajx16UDS/eTUhwmwkK0v8l5ux6cc7T2gZiKjzJca0cDeeZShgZUE1+uz
         b+RXrXxBz48Na6mw9W+dP5PAGhXYo+3cT6RMk43UNfS3w8DeoBWdXbS8KWftGWEh+136
         74PFxeZereHV80CPL+bR9KMwlX3BsS+1ZIbv7kWHqS34g2XP7XdVlxbiJ4ydAGN6GM2I
         hEPwqqeBWUbyh7PxQfswqk7jNGEb2ATpGoDtmLEeQrvXsxtbbmlL0mQ0kdpRIJ6u+r/r
         VPb5VBu7V5CIfK+16FBk68Q/gAVdpL0JRGEu3vhBRd8+NQV81WQyexmQFlfoG4tnODdk
         WzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1M54u9BB1KReEkywf4jy9ZPH9kkk7hfDvoMLVlYnTR2/MUk+e+cC1lrhXujLjoOgZpdTtJw90fP3TOhg8cNKBz1/V
X-Gm-Message-State: AOJu0YxoUK5Aza0N0e3WimmeNLXIdyLfh1Ijxnt9SaYCWN2T+eEurpXa
	rpFjo0zCr07WxZDyjBzCxQyKAaZiQO5uM7H9M9aOMpn2fhZ7+6/lNuY0qm1L
X-Google-Smtp-Source: AGHT+IEgWd2/FGO3416NWn9XC5ceuG9mTRysEvlX0N7nAgPbvJuZPCGviPP/xvMpdJzOJAjoZb9xYQ==
X-Received: by 2002:a05:6a00:a11:b0:6eb:3d37:ce7a with SMTP id p17-20020a056a000a1100b006eb3d37ce7amr10125849pfh.21.1714432726101;
        Mon, 29 Apr 2024 16:18:46 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7824e000000b006edceb4ea9dsm19847326pfn.166.2024.04.29.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:18:44 -0700 (PDT)
Message-ID: <65e3b41c78870a563136109e26ab84cd880154c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:18:43 -0700
In-Reply-To: <20240429212250.78420-3-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
	 <20240429212250.78420-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6fe641c8ae33..1777ab00068b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13695,6 +13695,77 @@ static void scalar_min_max_arsh(struct bpf_reg_s=
tate *dst_reg,
>  	__update_reg_bounds(dst_reg);
>  }
> =20
> +static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, bool=
 alu32,
> +				   bool *valid)
> +{
> +	s64 smin_val =3D reg->smin_value;
> +	s64 smax_val =3D reg->smax_value;
> +	u64 umin_val =3D reg->umin_value;
> +	u64 umax_val =3D reg->umax_value;
> +	s32 s32_min_val =3D reg->s32_min_value;
> +	s32 s32_max_val =3D reg->s32_max_value;
> +	u32 u32_min_val =3D reg->u32_min_value;
> +	u32 u32_max_val =3D reg->u32_max_value;
> +	bool is_const =3D alu32 ? tnum_subreg_is_const(reg->var_off) :
> +				tnum_is_const(reg->var_off);
> +

Nit:
Sorry for missing this earlier, should we initialize 'valid' here? e.g.:

	*valid =3D true;

I understand that it is initialized upper in the stack,
but setting it here seems better.

> +	if (alu32) {
> +		if ((is_const &&
> +		     (s32_min_val !=3D s32_max_val || u32_min_val !=3D u32_max_val)) |=
|
> +		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
> +			*valid =3D false;
> +	} else {
> +		if ((is_const &&
> +		     (smin_val !=3D smax_val || umin_val !=3D umax_val)) ||
> +		    smin_val > smax_val || umin_val > umax_val)
> +			*valid =3D false;
> +	}
> +
> +	return is_const;
> +}

[...]

