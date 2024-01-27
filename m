Return-Path: <bpf+bounces-20457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8383EB46
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0CB1F229DA
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DE13FFB;
	Sat, 27 Jan 2024 05:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC611CBB
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706333386; cv=none; b=FV9BoFgeTDKP/8EKz51yMpoEj1b1+99z26qfJ5FxGYPBxea6johESChwSm8R8nkeD6/qsDx6Uv6BWE1Gr4vy8J1qSh8m63K04ZTuCKKl0eb2jZH95FoVlWWXkX6Kw4kT37oHxkHURbsZZRLvMuhr2m2/1tC/e4be4BEN6uVXOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706333386; c=relaxed/simple;
	bh=/RMzBNpuT88b8IsI+8uZqeM4xDVvKf2nGxbQkqnk7Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDSRkEhYNUOst3GraHIaTqCiZWcl0z3UFuYM9VjfCgg9Lu7M1Q/SAQHeI0yNQthwyOwI2XjuyqXPVkGthIbCDsIMI+lkBZzd3itchJYnK4nF/p5cAw4942gkDmb3TPZo6JY5ndgHUb+vfc30xq4ihAwu1+vV7kB38FlzOaMWIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783cd284528so81791585a.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 21:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706333384; x=1706938184;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VCFkUCqirmE8gfHkK/NEL0ng3+N7UaUQ/1dKzpw2IE=;
        b=QKew4dHejzT3vOitgfjzjdpB8E9PDqc495CsaYSJOGxtWs/eo/4HqCvxHMz8oYkxr7
         dhrONm5uGoCT6U0KXWcxjN2rT7oS7zb/OlMouWKDWKaz8c1Tevdc1fzQs4wFc3Wsu32s
         8g6aG4U7ZK7y689XssJ3rkTs090IW3S+kTGpRm9+YaDJ+Sca8viPBZV5YEI5P4SP1HEW
         2bfdICHjgC6VMFN/b/3DfwMNEiSNXBfhfnegd9BrCPg3ImwsJiJAPYPbFxFy4d3rPmGb
         F6/oPeLc0z2iIU95N9STwN12zgXBf7x9RLd37X88E2xm/4fpa6uqx62uds29sHIgNVcH
         4GBw==
X-Gm-Message-State: AOJu0YzQjGSuUgU227OC2xyAem1816C3A5/EbVtsfwblCpYvgTvebCl/
	EoKgRACVd0+KeYWS3LDNDqMVBBjo6fawePY2tDWtaz5iwhtV3wzBILNV30q/buU9RQ==
X-Google-Smtp-Source: AGHT+IHLh277QTPMCtk4ZgUeHQc5n5vYt0o3Ky4Pkvc5GR3HwoU/2OvVslZsYKHT9HAgTInuEA3f0w==
X-Received: by 2002:a05:620a:4609:b0:783:9079:93a6 with SMTP id br9-20020a05620a460900b00783907993a6mr1247537qkb.4.1706333383785;
        Fri, 26 Jan 2024 21:29:43 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id u26-20020a05620a023a00b0078353332599sm1166351qkm.21.2024.01.26.21.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 21:29:43 -0800 (PST)
Date: Fri, 26 Jan 2024 23:29:39 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [Bpf] Standardizing BPF assembly language?
Message-ID: <20240127052939.GA31099@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
 <20240123215214.GC221862@maniforge>
 <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ytvqyf7RainnNXoI"
Content-Disposition: inline
In-Reply-To: <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ytvqyf7RainnNXoI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 06:51:16PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 23, 2024 at 1:52=E2=80=AFPM David Vernet <void@manifault.com>=
 wrote:
> > > > > A second question would be, which dialect(s) to standardize.  Jos=
e's
> > > > > link above argues that the second dialect should be the one
> > > > > standardized (tools are free to support multiple dialects for
> > > > > backwards compat if they want).  See the link for rationale.
> > > >
> > > > My recollection was that the outcome of that discussion is that we =
were
> > > going
> > > > to continue to support both. If we wanted to standardize, I have a =
hard
> > > time
> > > > seeing any other way other than to standardize both dialects unless
> > > there's
> > > > been a significant change in sentiment since LSFMM.
> > >
> > > If "standardize both", does that mean neither is mandatory and each t=
ool
> > > is free to pick one or the other?  And would the IANA registry requir=
e a
> > > document
> > > adding any new instructions to specify the assembly in both dialects?
> >
> > Well, if we're standardizing on both, then yes I think it would be
> > mandatory for a tool to support both, and I think instructions would
> > require assembly for both dialects.
>=20
> I think it's obvious that there is no way we will add gcc's flavor
> of asm to kernel and llvm.

Well, it will depend on how widely it's used. Or if it's used widely :-)

> > Practically speaking that's already
> > what's happening, no? Both dialects are already pervasive,
>=20
> They are not. There are thousands of lines of asm written in pseudo-c
> used in production applications and probably only ubpf/tests and gcc/tests
> in that other asm, since gcc bpf support is not yet in the released gcc v=
ersion.
>=20
> There is also this asm flavor:
> https://github.com/Xilinx-CNS/ebpf_asm
>=20
> Which is different from pseudo-c and ubpf asm.
>=20
> I don't think asm syntax should be an IETF draft.

Ok, fair enough. Another thought that occurred to me after thinking
about this more -- even if we want source code compatibility (which is
still an open question), that doesn't necessarily imply or require
assembly dialect compatibility. Let's table this for now, and revisit
another day, should we ever find that it makes sense to do so.

Thanks,
David

--ytvqyf7RainnNXoI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbSUwwAKCRBZ5LhpZcTz
ZAQ3AP9ZTZAyVhF8bpmqquUV+p+3kvzMtuHgnFb5Og1HUh71HwD/cCuIb0jeVWNV
hj3wDsvyC93w6rz2Gx6DN1JvVIDzKQk=
=w4PK
-----END PGP SIGNATURE-----

--ytvqyf7RainnNXoI--

