Return-Path: <bpf+bounces-65931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F416AB2B48A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB7A7B1BDC
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B052765CA;
	Mon, 18 Aug 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQyQp+Ia"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC6281376
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558879; cv=none; b=Nx32ftrxsc8zZlyx15bs86nEtMneVGwxPxuKQaOlYLWQNWENgkn6/hissyABCfy3gXNv4TaVj+l5RfRe4FiG9IZE7RCMyYRS4+24SK++yhsGPWSntRb0rrvpbO9EhjBYZbbdE3iZh3V6qmm5+JNxwunWiiqjxkgEsHkQj0+Q7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558879; c=relaxed/simple;
	bh=YxonKzjJQfSd4dieQzLkzH5uu9S7XFxJs4coIT5GCfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwpFmU4yC9eIqkD5F6DMWBMHEEoL6lgyiTilTJzj9w1pAFDoyflli/pL0+1Xs7jiPSGKtNj8QrMOpdQDYGPZ8zq1GbKyzvdG7niWEnZmeG2EC8UHIrTOc2eF++LKFGc0gRM1GLKt/Up9HLeoszw6ucPj+ToEVt3nvkCMI752+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQyQp+Ia; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e05b3eso3299553a91.2
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 16:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755558876; x=1756163676; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/QSBLwlS1geMb5IrAmlkZyj+YTqVIbsYJU+xy/oLo8=;
        b=KQyQp+IaBpDf7pa6xZ+96AQmP1iEf0bOdRj23GygvgCXb9OzvT7dmT0VcDbzk7VDHh
         fZafFO6XYVyZ1bzB4PGUpGN3rTuIR0zICTWy5hDL67h8tleIor9o1D8JE/bJLgFiDYXN
         3NsKcVtyIrxVR5X5GXKTJKPaKqcXrdbF9RfK9bg2J2M3wGYPBKQZY89JljA8QNYldeBI
         rLku8XO4nWYjS8y+qcTDP+B4n683q1u2O/kTDz2EUWZOkXCWmSrnJO6D0bcL3GW/IK6Z
         G2wHCQQPEC8uTxSaKGsghGWctUer1dBfLRP74QAHT6VuUSMm+KNN9so0Zgaj/LMHDG4M
         WWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558876; x=1756163676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/QSBLwlS1geMb5IrAmlkZyj+YTqVIbsYJU+xy/oLo8=;
        b=t6NoYpZK52ZDf2NdtfJoJbJEUUd/I5YkfaK94c4lbCLCWgTbkH00e5iA9PM4Z/97dr
         49EV2VMLRRL647/93Uaqo4IGpeLRBrO3FLYiH3AJ+MvRdtiQhZwXe0WvZHL/oz5gLwLf
         gxJYfUNPfAUxIUeFGX8oNJbjryVAHfDfBjbVMZukqUM0T+ReEjnCKUqdThmXR1En1V2s
         0n8tMfCTxPLMqKFPr2pwEdy7B64ha33HAgawY0zkGjBGwqG0NFUT2Wil844hpulOfznK
         duY49IJh+ewhGjADZYw5v05ZZVEEjapYr844FD/dsS0cUZxLQFXBtqaVCvdVzAOtf3Sw
         6flQ==
X-Gm-Message-State: AOJu0YwdkJwPttJdWfpkh4XyW7D/WIySp/uTWNnsN6tiVOpNljsi8eyj
	uh3H5Wq37rpZxRDnOtnbG9UVLghd0p3U36nrXdBdKNcM8fJf4GsMBpKO3bpb0JKY
X-Gm-Gg: ASbGncveL91LEhU1bPLtKYibiP2UeX71FygjFosENEMJ7uVi19CMYEnWV4HGgkFhyi0
	8wT9bzo43R6/gRBPluBWOTgEjxrZSnePhJ+1roX9ChG5JzciYof6DfNhxipqVMRYQvU9glSu+hw
	KbvnOi/1ug/LZxA4cWWHDwScAT8xArVxeYEHrA5zynahoVB0IpP9CgDDgAhfTJ2hc26ih3J6Fe+
	nU4aXabOBnOvXrO8QiRRJOv2aTYIGsoFar67nPXa9SfYUxSX0eE6bjPk/l0hRiD9yBJ9gC1JWb6
	BI0Xe2sJd83D75ND7dpgWtdxaFYE1GJXnKWxEKlXyEfWtcKFlumLqmNXVI6WDFc9u9xazdGlC6l
	mdNFhKrDNQe/oInhP9pxyD7xfvhON
X-Google-Smtp-Source: AGHT+IEen8WTijM3vtkHyD7MImhdAF16dQG560GBRoCzhGkgf1J+VL62joKpLhrQJjUk4TqZFqgdLg==
X-Received: by 2002:a17:90b:4f42:b0:312:2bb:aa89 with SMTP id 98e67ed59e1d1-32476a6d74cmr800223a91.20.1755558876402;
        Mon, 18 Aug 2025 16:14:36 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:2a59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5dcc71sm8901240a12.16.2025.08.18.16.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:14:36 -0700 (PDT)
Message-ID: <8a7d2401b39257b3dde8cdf67cdb4c382611bfee.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Date: Mon, 18 Aug 2025 16:14:34 -0700
In-Reply-To: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 19:35 +0530, Nandakumar Edamana wrote:
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>=20
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>=20
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

The algorithm makes sense to me, and seems easier to understand
compared to current one.

[...]

> @@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct tnu=
m b)
>  	return TNUM(v & ~mu, mu);
>  }
> =20
> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +	u64 v =3D a.value & b.value;
> +	u64 mu =3D (a.value ^ b.value) | a.mask | b.mask;
                 ^^^^^^^^^^^^^^^^^^^

Could you please add a comment here, saying something like:
"mask also includes any bits that are different between 'a' and 'b'"?

> +
> +	return TNUM(v & ~mu, mu);
> +}
> +
>  struct tnum tnum_cast(struct tnum a, u8 size)
>  {
>  	a.value &=3D (1ULL << (size * 8)) - 1;

