Return-Path: <bpf+bounces-22893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C786B600
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744411F231B3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E41586EF;
	Wed, 28 Feb 2024 17:30:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812433FBBE
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141412; cv=none; b=FkHahfRjfcNgglA6ZSOLS0N2D1BuxSrUnf/iSY5Opfh/92lsrxUtZvKUHI/Go2WYfxyY+BhOB8Rk4+hUJff0o+85Q+KmUjbL6Sb0r2/tvCkUIyc+NnbXfuwFsmFcoVL155CUYb3Xmwqr3KJym/Cbwfs+mlQYsabDpkl7VX4xP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141412; c=relaxed/simple;
	bh=EpfqhvsuyPi7f9NAa+mJeL811UuDXAjytJnPmQ2Ahaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWg7kvPZ/3V99kF6teeTsQHW1u+140s1SvCSVHSMimllBc9ReJ23FC7vhXvvSpUocuYEPvPEk7tFzWfrvaYR8zQKNhEl+h/Em8IyLKcS7mGw4JgQvsd1v5NHlUT7Kr0WhL/yp3N3ABiji2QrSLHJd6giW4WernR6QmAJhj7NCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6902947c507so11006836d6.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141409; x=1709746209;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpfqhvsuyPi7f9NAa+mJeL811UuDXAjytJnPmQ2Ahaw=;
        b=LEREdWsQep7ixq7AE2OMmgNNlwBwGP5gZ3lqSHJjE9mx+AUxwBv1maM9funKH0768I
         iNT9cm9x/dDLXgHchiIqruDkv9CB+szFwdykJEz6NUMTGHiU6T9oMR0r20VZnEjDMI57
         YrB1Pi3PMKJtHRNbZpMhpe56gCCbuQ7fOpxvmoRLNkn5Zn7h5nVdBx4CiQ550SPPyZ6Q
         TAbYQMbYf3nVduqOFNFfkTqZIsaEFTfOLdBkzTL3oQ5Ycai2Wniz/YHrb0jWlSm1VhJS
         wPBzij+2rbQ7T9kOVcg242UJnV0i4sGSvg9lYJZfu1SQfbGerArFDUfwK2zZBg//gOeU
         EEzA==
X-Gm-Message-State: AOJu0YxEPgAykaPSQi/sdHo3RLKuyoX94vov2S06bw70KD1pq/wJ5qdA
	ypFiIaidl/H/KhiXmlRMomLPwNdYJmbYzwvg2bLDdmpRHdSfiUiA
X-Google-Smtp-Source: AGHT+IHiaXroxuAfx435o77n6XPKnmCMFUgXDyE9xVttdX0nlobShVbSl8ILdT0UNLoUMnW78Nsdgg==
X-Received: by 2002:a05:6214:ca6:b0:68f:f634:f899 with SMTP id s6-20020a0562140ca600b0068ff634f899mr7419137qvs.64.1709141409311;
        Wed, 28 Feb 2024 09:30:09 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068cdc0a0d42sm5400735qvb.25.2024.02.28.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:30:08 -0800 (PST)
Date: Wed, 28 Feb 2024 11:30:05 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes (___smth)
 for struct_ops types
Message-ID: <20240228173005.GC148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-2-eddyz87@gmail.com>
 <20240228162936.GA148327@maniforge>
 <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8zs4K4JeFfuF8QW"
Content-Disposition: inline
In-Reply-To: <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--e8zs4K4JeFfuF8QW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 07:28:49PM +0200, Eduard Zingerman wrote:
> On Wed, 2024-02-28 at 10:29 -0600, David Vernet wrote:
> [...]
>=20
> > Modulo the leak pointed out by Kui-Feng in another thread. It would be =
nice if
> > we could just do this on the stack, but I guess there's no static max s=
ize for
> > a tname.
>=20
> GCC documents [0] that it does not impose name length limits.
> Skimming through libbpf's btf.c it looks like it does not impose limits e=
ither.
> I can add a name buffer and a fallback to strdup logic if tname is too lo=
ng,
> but I don't think this code would ever be on the hot path.
>=20
> [0] https://gcc.gnu.org/onlinedocs/gcc/Identifiers-implementation.html#Id=
entifiers-implementation

Yeah, definitely not worth it. Thanks for looking at the documentation just=
 in
case.

--e8zs4K4JeFfuF8QW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd9tnQAKCRBZ5LhpZcTz
ZLYHAQCQGrtelLFx76jOclrMA6kZcCdiI7pIE1iHFKzofpEypwEA+IS+jU4b53Ah
zgtAVszaC12rtbZC68+wNQNlvt84dQQ=
=3pU4
-----END PGP SIGNATURE-----

--e8zs4K4JeFfuF8QW--

