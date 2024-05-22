Return-Path: <bpf+bounces-30323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0B8CC638
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE991F21B65
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74313D893;
	Wed, 22 May 2024 18:21:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923711BF40
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402097; cv=none; b=CS2If2QQrPZp4MkrtFJ1hjYftQ1wGDG1xT/UzrAnOK9LxAh5+0z4wl4ZcCj9MqKdoxRoLtfB6XdwjLQ/GdOWrL4WR3ZorMnFAS65uW5yRpJ8nk7PB9fzuW9WYJMVMuHVE8/dKrlgfDpcDtR67APj1GswXr75/vZQkrk0jGJf9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402097; c=relaxed/simple;
	bh=ko5WsgRc5I9vEWJbi0+a+Fs851AshJz1K+UozTOt1Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBxGYQHV8v59mb7C2HG/sy6qiyeWLH3pEbPCl16RKiiFcUvZ1bywpvPEHUb+SYqTk1ITfXXN1P41dgDPZwYAbc40gbJOGeaPEoZDgZhZSDx+FeeBoWl3lp3OyJWXHiLn4SMQVpIy3nPJLMpaLcM6N2mslItK5XLHy4lJugLdXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8bca915so451083685a.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402094; x=1717006894;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko5WsgRc5I9vEWJbi0+a+Fs851AshJz1K+UozTOt1Is=;
        b=S+qi1y37eld1hx+EsF2yc0wCX3iwZCj4bB3FcE0cZ7JCnQdBAf/Mon96h96c+tYTR9
         +t19J4lTTo09Uwr+jGAZHg3gpIgcjTTh63nVK5aGKhzFumPRz474f5pIooMHxh68IVDt
         L4IzCtSriNz4xVlYZv9gWJcl2Guy4ZXlu/y6+zHRSvw3IG6FARsE7uCTgOmho3DBo6RN
         4iPU81YZZDS0v216C2Tc18rXVnJjvKhz3JkPrY0JFs1278KyG5IWC4LLD8l/MErhvjIM
         BMIbzTVwQV4HSiW/mKr6mpMeVLZ0qIPEDnB+mdmN8fflqSXsOimk0dcPz4AmejWVIwbA
         3jlA==
X-Gm-Message-State: AOJu0YyD7W89L44NAC7Edf376WLc67xO1xh0WXEINinWX6CKe8wL6E6i
	1fSnIM5VFSCn7lNcHhvG/OAhoXSla540STOgR3W10+Fqbq6rH5c/
X-Google-Smtp-Source: AGHT+IFYxeNiB8g6QFxEj7wJcUYAxoIhRHKYsm7YN0Sa6xDSgrw0pOUycThO5PmaPK6z4JWNSkGEUQ==
X-Received: by 2002:a05:620a:55ae:b0:792:741b:3a27 with SMTP id af79cd13be357-794994b60f4mr302103885a.53.1716402094092;
        Wed, 22 May 2024 11:21:34 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310bc3sm1419500485a.99.2024.05.22.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:21:33 -0700 (PDT)
Date: Wed, 22 May 2024 13:21:31 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, docs: clarify sign extension of 64-bit
 use of 32-bit imm
Message-ID: <20240522182131.GA41164@maniforge>
References: <20240520215255.10595-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efIhC89kt0lWJZM8"
Content-Disposition: inline
In-Reply-To: <20240520215255.10595-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--efIhC89kt0lWJZM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 02:52:55PM -0700, Dave Thaler wrote:
> imm is defined as a 32-bit signed integer.
>=20
> {MOV, K, ALU64} says it does "dst =3D src" (where src is 'imm') and it
> does do dst =3D (s64)imm, which in that sense does sign extend imm. The M=
OVSX
> instruction is explained as sign extending, so added the example of
> {MOV, K, ALU64} to make this more clear.
>=20
> {JLE, K, JMP} says it does "PC +=3D offset if dst <=3D src" (where src is=
 'imm',
> and the comparison is unsigned). This was apparently ambiguous to some
> readers as to whether the comparison was "dst <=3D (u64)(u32)imm" or
> "dst <=3D (u64)(s64)imm" so added an example to make this more clear.
>=20
> v1 -> v2: Address comments from Yonghong
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

--efIhC89kt0lWJZM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZk43qwAKCRBZ5LhpZcTz
ZAVwAP0QevFkqXGOT8QtAEdQfzTlozxFu4FCnoTP3coMnGphwQEAvt0ZVubRouOs
vsUXVCiw9Ah1AF9w7Ux9zskyuVMyzQ8=
=Qjps
-----END PGP SIGNATURE-----

--efIhC89kt0lWJZM8--

