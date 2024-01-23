Return-Path: <bpf+bounces-20126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B04839B34
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F3A28255E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5739AE5;
	Tue, 23 Jan 2024 21:31:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DB3984D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045467; cv=none; b=nbTZIfKuicZNOCh+GG5YPDumExaVBE1O1WPtisbs9uxEfdbqCscaYoXW7dNjygrLVgOPmf83kyakXzvyP0GmbPIy94z4HSiRcyVoMshAsfhcl3OAHNrstK9AVxI5SFVILcskRT9ujTebdjsIG7EQF8Y1625ApFoUFSv7sZGSaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045467; c=relaxed/simple;
	bh=4BGF+Kz2himgwUMXeI8snxGTjk7nUbsOq1vlBjirNsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVQvikZqrqpZIWnv5nlVs/53BQLSdY8H56T3GoBEflS82/h/6K5QTBj1Gq4b+72ZOmkHQcBLY5tsLBPdiexHT9732OjbCypETufGJafnXiD3ur5IJRbAkM4tERVIcOT40i3/xzVJAw7tt4U1kcZqfH5oTi8z3sDP9icI76To6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78314e00350so367246385a.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045463; x=1706650263;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV/Xh15fCZhFFlIAa0q4I8q/sKNXjwpkP5J28622nUE=;
        b=NWnP48m/YVDcbkgC09l+vNCKtfhZvFzlbBB9vtrmk9ZHeJDLQ8gB3Q5xtJVrBW7Vgv
         a7BYtyS+9o33MoJMS2v+tXO1cg9DEXxjmd0mGVeZ52VgenHDyfoGbgYE7hjuoX9Dp0d9
         VAkNGxSE6T4L/SJ+Y2Z3WXNFfsOobyKz1dqVveBTHtNv+SSNYD9YT55je1S9WIF3Jq4g
         tLgf7LkzboIyPTYjcCQ3zH4hNmxM3gukv16kOq2ycebKFFjAPZ4aWe2xdzb2HpQ9bYxX
         fGkXq8eAMiMFlYev8Og7GtuQ7phsJxdmMfnFl3Bz/tKqJ7QHowBNJo09OEbTwGGEPK85
         kdOg==
X-Gm-Message-State: AOJu0YwhYQMXSgC6VQlS1YIaolw25/98pybgvA18uI1rQPcmFZhRoSON
	Plu6gE3szOgbbA3GZSDHXkBPI4Y48Cwtyy52b/rglkAqi3J3jyQc
X-Google-Smtp-Source: AGHT+IEIzokzqCv5vfH9w7fv+kSl36L1mg9kzKSamrgWcdg7BeV4bOMRK58NcCu0R5h4YzjhN2YE7Q==
X-Received: by 2002:a0c:e0d3:0:b0:685:d99e:117f with SMTP id x19-20020a0ce0d3000000b00685d99e117fmr1444584qvk.60.1706045463460;
        Tue, 23 Jan 2024 13:31:03 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ceb07000000b00681092cb7b4sm3781929qvp.103.2024.01.23.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:31:02 -0800 (PST)
Date: Tue, 23 Jan 2024 15:31:00 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org, jose.marchesi@oracle.com
Subject: Re: [Bpf] Standardizing BPF assembly language?
Message-ID: <20240123213100.GA221838@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hSlCmNz4qQUXX2xq"
Content-Disposition: inline
In-Reply-To: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--hSlCmNz4qQUXX2xq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 08:45:32AM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
>=20
> Jose wrote in that link:
> > There are two dialects of BPF assembler in use today:
> >
> > - A "pseudo-c" dialect (originally "BPF verifier format")
> >  : r1 =3D *(u64 *)(r2 + 0x00f0)
> >  : if r1 > 2 goto label
> >  : lock *(u32 *)(r2 + 10) +=3D r3
> >
> > - An "assembler-like" dialect
> >  : ldxdw %r1, [%r2 + 0x00f0]
> >  : jgt %r1, 2, label
> >  : xaddw [%r2 + 2], r3
>=20
> During Jose's talk, I discovered that uBPF didn't quote match the
> second dialect and submitted a bug report.  By the time the conference
> was over, uBPF had been updated to match GCC, so that discussion
> worked to reduce the number of variants.
>=20
> As more instructions get added and supported by more tools and compilers
> there's the risk of even more variants unless it's standardized.
>=20
> Hence I'd recommend that BPF assembly language get documented in some WG
> draft.  If folks agree with that premise, the first question is then: whi=
ch
> document?

> One possible answer would be the ISA document that specifies the
> instructions, since that would the IANA registry could list the
> assembly for each instruction, and any future documents that add
> instructions would necessarily need to specify the assembly for them,
> preventing variants from springing up for new instructions.

I'm not opposed to this, but would strongly prefer that we do it as an
extension if we go this route to avoid scope creep for the first
iteration.

> A second question would be, which dialect(s) to standardize.  Jose's
> link above argues that the second dialect should be the one
> standardized (tools are free to support multiple dialects for
> backwards compat if they want).  See the link for rationale.

My recollection was that the outcome of that discussion is that we were
going to continue to support both. If we wanted to standardize, I have a
hard time seeing any other way other than to standardize both dialects
unless there's been a significant change in sentiment since LSFMM.

--hSlCmNz4qQUXX2xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAwFAAKCRBZ5LhpZcTz
ZLo7AP9s3InRJFMiQo28vmaSxIF2tJR6ZShWUv2BiGaqCqHOFwEAjdckPP4oq4vP
tonVgIMM511NKDHHkI9lt4y3dAkV1go=
=ozHj
-----END PGP SIGNATURE-----

--hSlCmNz4qQUXX2xq--

