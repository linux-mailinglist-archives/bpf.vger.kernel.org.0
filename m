Return-Path: <bpf+bounces-17046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE28094EC
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36D31C20C64
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB82840DE;
	Thu,  7 Dec 2023 21:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B139A9
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 13:51:56 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35d624b0415so4774275ab.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 13:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985915; x=1702590715;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIg9jgApiL6TE2ZQtqy8ueNRwX4CpEouQNf4pBFcudo=;
        b=LgeXXUkqBdPDQrSsmCU1TPIqJhFYMiNJRsFjY1FQ+41q/Pb1m8uLzXHqmwHnPkBVbD
         yrQozf7lD+b4lO/KgYrwl5DvIgIz3Zq4+9t5qZDfqC18kTodRyOtyngl3fbYCJuhbp54
         echx8DZaKShDFWpbAa1ehi/6Nbf0Pp19v5SlPBQ+uF19IwBVzjElmUD7KhBSNDVDF7tf
         2dbMFSoDl+t2AAHNhwb+4eUnuZTlnsgq/2U74jZDDYJX8Mi0kbNxCvKQUCr0peMTJiot
         zWoqVSo2YjHt1tBHRnL3qp3E7hmIkTkSvB1Merd8zr9QrGPl8D9BqikcO8Y17ZOXpuwV
         RQog==
X-Gm-Message-State: AOJu0YwCIrP8TL+n5m9CwmOMoWH5txUjnFNXT20HnIx2Aeux5Sbvo/xL
	51GDrQtMuuoQn8lqfL+1plk=
X-Google-Smtp-Source: AGHT+IHg3GIUIrtn5ajmaHJ1fG2xuJI/35sIoV0UiO70iEDa9Q8sjvHwz03nRjusVLfuxQFYDxrGDQ==
X-Received: by 2002:a92:d68f:0:b0:35d:6991:a535 with SMTP id p15-20020a92d68f000000b0035d6991a535mr4222993iln.30.1701985915446;
        Thu, 07 Dec 2023 13:51:55 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id n17-20020a056638121100b00468f1bb12aesm140326jas.12.2023.12.07.13.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:51:54 -0800 (PST)
Date: Thu, 7 Dec 2023 15:51:52 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org,
	alexei.starovoitov@gmail.com, hch@infradead.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <20231207215152.GA168514@maniforge>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0g2DaA4GoF2ZBbKP"
Content-Disposition: inline
In-Reply-To: <072101da2558$fe5f5020$fb1df060$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--0g2DaA4GoF2ZBbKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 11:51:50AM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> >From David Vernet's WG summary:
> > After this update, the discussion moved to a topic for the BPF ISA
> document that has yet to be resolved:
> > ISA RFC compliance. Dave pointed out that we still need to specify which
> instructions in the ISA are
> > MUST, SHOULD, etc, to ensure interoperability.  Several different optio=
ns
> were presented, including
> >  having individual-instruction granularity, following the clang CPU
> versioning convention, and grouping
> > instructions by logical functionality.
> >
> > We did not obtain consensus at the conference on which was the best way
> forward. Some of the points raised include the following:
> >
> > - Following the clang CPU versioning labels is somewhat arbitrary. It
> >   may not be appropriate to standardize around grouping that is a result
> >   of largely organic historical artifacts.
> > - If we decide to do logical grouping, there is a danger of
> >   bikeshedding. Looking at anecdotes from industry, some vendors such as
> >   Netronome elected to not support particular instructions for
> >   performance reasons.
>=20
> My sense of the feedback in general was to group instructions by logical
> functionality, and only create separate
> conformance groups where there is some legitimate technical reason that a
> runtime might not want to support
> a given set of instructions.  Based on discussion during the meeting, her=
e's
> a strawman set of conformance
> groups to kick off discussion.  I've tried to use short (like 6 characters
> or fewer) names for ease of display in
> document tables, and potentially in command line options to tools that mi=
ght
> want to use them.
>=20
> A given runtime platform would be compliant to some set of the following
> conformance groups:
>=20
> 1. "basic": all instructions not covered by another group below.
> 2. "atomic": all Atomic operations.  I think Christoph argued for this one
> in the meeting.
> 3. "divide": all division and modulo operations.  Alexei said in the meet=
ing
> that he'd heard demand for this one.
> 4. "legacy": all legacy packet access instructions (deprecated).
> 5. "map": 64-bit immediate instructions that deal with map fds or map
> indices.
> 6. "code": 64-bit immediate instruction that has a "code pointer" type.
> 7. "func": program-local functions.

I thought for a while about whether this should be part of the basic
conformance group, and talked through it with Jakub Kicinski. I do think
it makes sense to keep it separate like this. For e.g. devices with
Harvard architectures, it could get quite non-trivial for the verifier
to determine whether accesses to arguments stored in special register
are safe. Definitely not impossible, and overall very useful to support
this, but in order to ease vendor adoption it's probably best to keep
this separate.

> Things that I *think* don't need a separate conformance group (can just be
> in "basic") include:
> a. Call helper function by address or BTF ID.  A runtime that doesn't
> support these simply won't expose any
>     such helper functions to BPF programs.
> b. Platform variable instructions (dst =3D var_addr(imm)).  A runtime that
> doesn't support this simply won't
>     expose any platform variables to BPF programs.
>=20
> Comments? (Let the bikeshedding begin...)

This list seems logical to me, though I do want to think a bit more
about the maps one. Alexei, Christoph, anyone else? Now is the time to
get aligned so we can get this to WG last call in plenty of time for
IETF 119.

Thanks,
David

--0g2DaA4GoF2ZBbKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZXI+dwAKCRBZ5LhpZcTz
ZPVMAP95usrAJRj9dWxO0whI2jOvwOF8show00jtYepFoXb20gD9GdLQMkx9+H3V
jaNOj5J4uXY3NKS5h/u4phoshznqJgg=
=pyO+
-----END PGP SIGNATURE-----

--0g2DaA4GoF2ZBbKP--

