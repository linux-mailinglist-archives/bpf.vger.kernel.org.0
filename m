Return-Path: <bpf+bounces-20132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC8839B75
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F11F2253A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711584643B;
	Tue, 23 Jan 2024 21:52:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6213E47F
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046742; cv=none; b=Uqwgr4N9idfA2nJBytsqtj5DOX5aqfImezo71SxwFas5RWG1S8nGrRFaMjP95bIAZH5/uYldpMcpU2Jz7se6v+w/jZnl4wqrWHWoeOrq68uqaBydTob3jYppuxIMELAtAEFgH1WnsbX0cKR8pal++mC0S9mZLN6kcRYsihLmabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046742; c=relaxed/simple;
	bh=iIhycEZhKusUB7G8uMvH8JwyOSxFusEkQhqw8ib8mi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8bnHv86QgYKBgyLbyzEUkaBeTZ+1Fgbx4C3sKygr3aJXz3q1tmDYyT5F9fv7Y+lCsNJuLoTiJ2leTj0OY+xBozqFqMmlgu2JDZSsT/GavVmJ99GpecxSM0uINzPBDt5dBCN1ryzQ4eRVHVcsnSUdqAPo77y3gnyjgd9W8uaAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd72353d9fso3923577b6e.3
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046739; x=1706651539;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvJ+BaBwhV3UkswshjPW1gQt1pNqypy86XvcjGB9mYY=;
        b=NYWoO6cG1LZdT86wjVGHADzvcArjI6fqhMUWbZNpWa1ML909hmEtXe9QwQG/ZAq1wO
         EPQd+UItWQ0ZZOpEcZ3Os7odbH+VqoFfapkjqUZ7AFLwMDoATmZQziqX/gWib57Gmi+k
         O2lT/76FY+B15X5Sea8bbKx6VSjcK/fNXBM2QuLAEt0mIWld7NZxMmZGMcj4Eeqi5KDI
         z5qP+GyfzxasOkwJtlIpwO3Ycxpt09tSCoG8vg5Xf7gOOpuPBBrdrgNjINEKcdkb7Q/M
         Lf3c5TIZZK/To4+CmvMzDf5gEdZDCMX7yOVO8SpDeeSGsgZG1M9V5LPIrPkQ5fEnkhko
         7wog==
X-Gm-Message-State: AOJu0YxWgSfLbuGf8GjAVD89IlmNS8jsAcOK1JufRVVSJubHs8rkgTVr
	LwseRlZd4VfL6IXHsLxTehTbZD7uj+VvSSTxgoCkq5ZmCqLJ25sO
X-Google-Smtp-Source: AGHT+IEwYwAmMmNNhXg+SRfb9qd/dtfdcWVJfWJwpHi+KlS6JAglnoIOOuyZWcA/V0YTAkxZ88qcKw==
X-Received: by 2002:a05:6808:f8e:b0:3bd:caae:e87b with SMTP id o14-20020a0568080f8e00b003bdcaaee87bmr674812oiw.14.1706046739589;
        Tue, 23 Jan 2024 13:52:19 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id jc11-20020a05622a714b00b00429d86c5c68sm3842950qtb.32.2024.01.23.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:52:17 -0800 (PST)
Date: Tue, 23 Jan 2024 15:52:14 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org, jose.marchesi@oracle.com
Subject: Re: [Bpf] Standardizing BPF assembly language?
Message-ID: <20240123215214.GC221862@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nZYOHgN8vDE0U4MF"
Content-Disposition: inline
In-Reply-To: <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--nZYOHgN8vDE0U4MF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:41:10PM -0800, dthaler1968@googlemail.com wrote:
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Tuesday, January 23, 2024 1:31 PM
> > To: dthaler1968@googlemail.com
> > Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> > Subject: Re: [Bpf] Standardizing BPF assembly language?
> >=20
> > On Tue, Jan 23, 2024 at 08:45:32AM -0800,
> > dthaler1968=3D40googlemail.com@dmarc.ietf.org wrote:
> > > At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> > > language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.tx=
t).
> > >
> > > Jose wrote in that link:
> > > > There are two dialects of BPF assembler in use today:
> > > >
> > > > - A "pseudo-c" dialect (originally "BPF verifier format")
> > > >  : r1 =3D *(u64 *)(r2 + 0x00f0)
> > > >  : if r1 > 2 goto label
> > > >  : lock *(u32 *)(r2 + 10) +=3D r3
> > > >
> > > > - An "assembler-like" dialect
> > > >  : ldxdw %r1, [%r2 + 0x00f0]
> > > >  : jgt %r1, 2, label
> > > >  : xaddw [%r2 + 2], r3
> > >
> > > During Jose's talk, I discovered that uBPF didn't quote match the
> > > second dialect and submitted a bug report.  By the time the conference
> > > was over, uBPF had been updated to match GCC, so that discussion
> > > worked to reduce the number of variants.
> > >
> > > As more instructions get added and supported by more tools and
> > > compilers there's the risk of even more variants unless it's
> standardized.
> > >
> > > Hence I'd recommend that BPF assembly language get documented in some
> > > WG draft.  If folks agree with that premise, the first question is
> > > then: which document?
> >=20
> > > One possible answer would be the ISA document that specifies the
> > > instructions, since that would the IANA registry could list the
> > > assembly for each instruction, and any future documents that add
> > > instructions would necessarily need to specify the assembly for them,
> > > preventing variants from springing up for new instructions.
> >=20
> > I'm not opposed to this, but would strongly prefer that we do it as an
> extension
> > if we go this route to avoid scope creep for the first iteration.
>=20
> If the first iteration does not have it, then presumably the initial
> IANA registry would not have it either, since this iteration creates
> the registry and the rules for it.
>=20
> That's doable, but may continue to proliferate more and more variants
> until it is addressed.

The same could be said for any new instructions that are added while we
sort out standardizing the assembly language as well, no?

> If it's in another document, do you agree it would still fall under
> the existing charter bullet about "defining the instructions"
> > [PS] the BPF instruction set architecture (ISA) that defines the
> > instructions and low-level virtual machine for BPF programs,
> ?

I wouldn't say it's illogical to group assembly language in this bucket,
but I would say that defining the assembly language does not need to be
tied at the hip with defining instruction encodings and semantics. So my
answer is "yes, I think it belongs here", but I also don't think it's
necessary or desirable for the first iteration.

> > > A second question would be, which dialect(s) to standardize.  Jose's
> > > link above argues that the second dialect should be the one
> > > standardized (tools are free to support multiple dialects for
> > > backwards compat if they want).  See the link for rationale.
> >=20
> > My recollection was that the outcome of that discussion is that we were
> going
> > to continue to support both. If we wanted to standardize, I have a hard
> time
> > seeing any other way other than to standardize both dialects unless
> there's
> > been a significant change in sentiment since LSFMM.
>=20
> If "standardize both", does that mean neither is mandatory and each tool
> is free to pick one or the other?  And would the IANA registry require a
> document
> adding any new instructions to specify the assembly in both dialects?

Well, if we're standardizing on both, then yes I think it would be
mandatory for a tool to support both, and I think instructions would
require assembly for both dialects. Practically speaking that's already
what's happening, no? Both dialects are already pervasive, so it seems
unlikely that a tool would succeed without supporting both regardless.
To Jose's point (pasted below), there are of course drawbacks:

> - Expensive :: it makes it very difficult to reuse infrastructure.
> - Problematic :: dis/assemblers, CGEN, LaTeX, editors, IDEs, etc.
> - Ambiguous :: with both GAS and llvm/MCParser: symbol assignments.
> - Pervasive :: because of the inline asm.

I think it would be a lot simpler to standardize on only a single
dialect, but I also think the standard should reflect how BPF is being
used in practice.

--nZYOHgN8vDE0U4MF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbA1DQAKCRBZ5LhpZcTz
ZKawAQCMOLHMd2YqlC3rJG6dk4UcAd9lC+X0g93XRM8w3D3lUwD/V23jzepdCKP7
dnKIrk3c0mFQ907+J60P9HNPp7ld/wg=
=yNnj
-----END PGP SIGNATURE-----

--nZYOHgN8vDE0U4MF--

