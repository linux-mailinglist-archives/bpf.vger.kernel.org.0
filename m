Return-Path: <bpf+bounces-19148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188F825C5B
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 23:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469521C23AF9
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DA22EF1;
	Fri,  5 Jan 2024 22:07:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7D35EFC
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bba50cd318so73983b6e.0
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 14:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704492435; x=1705097235;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkWl61IHi8QwURBI7RSKnKtlI7w3yRYJSk15nYJ9GXU=;
        b=t07RtoY7NXaVDvW+vz8s+TKxQ2dsyosQnK4tRpvPfQtKz23vANmbs6CZZINbkq3QXa
         V344fBkteVcdv9YTjPIOaJRU06yBndDdzgGZ23ocrK3IvW0v2jsT3qfxVCvtBcrDww6d
         uRGqU18Vlau4Kwg8udZBaRu5aYPxrDTMZS8qQceO5eHd+DjWWiHj6jf5X+6PWFlSBYbF
         pWV//MwTsHzwD+TEq0CXKPolX0TgugFG8gt/woz7rDYXmKrSJ4pCKJBdlVovxUHQGkx8
         ApveYo8wMASr2Dxi2as5Kx3El3U96+yI40nLpn4y+3Rs4oUAXP6b2nzleIidxN5Gyup/
         5cLw==
X-Gm-Message-State: AOJu0Ywwub6IM1AwsqgXn5v67U54zR5d+MgOELFCzuF0E72LmUtAwqcA
	HcNxNu8KhhJh473qv34BfPebg8oVWW6u3Q==
X-Google-Smtp-Source: AGHT+IFZw8EoIpH7tFfQc/rQNFLxva8MzTZiJFLw2ND6an61UV1ztu3aZwffQ1DIZJkT685SkUzt3A==
X-Received: by 2002:a05:6808:140b:b0:3bc:26df:3772 with SMTP id w11-20020a056808140b00b003bc26df3772mr86315oiv.53.1704492434692;
        Fri, 05 Jan 2024 14:07:14 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f7-20020ad45587000000b0067cd5c86936sm926565qvx.79.2024.01.05.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 14:07:14 -0800 (PST)
Date: Fri, 5 Jan 2024 16:07:11 -0600
From: David Vernet <void@manifault.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <20240105220711.GA1001999@maniforge>
References: <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge>
 <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4NU6u4wMuY8EVbdq"
Content-Disposition: inline
In-Reply-To: <ZYPiq6ijLaMl/QD8@infradead.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--4NU6u4wMuY8EVbdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:00:59PM -0800, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 07:28:10PM -0800, Alexei Starovoitov wrote:
> > Right, but bringing the verifier into the "compliance picture"
> > makes the ISA standard incomplete.
> > Same can be said about nfp compliance. It's compliant with an ISA,
> > but the verifier will reject things it doesn't support.
>=20
> Yes, that's a good point.  Especially for anything call related I think
> it's fine to say they are a mandatory part of the basic some coarse
> group, but a given program type might not support it, but that is
> enforced by the verifier as the compiler should not have to known about
> the program type.

Agreed as well.

>=20
> > All ld_imm64 and call insns look the same. The compiler emits
> > them the same way.
> > The src_reg encoding is what libbpf does based on compiler relocations.
> >=20
> > Then the verifier checks them differently and later JIT sees
> > _all_ ld_imm64 as one type of instruction.
> > Same with call insn. To x86/arm64/riscv JITs there is only one BPF CALL=
 insn.
>=20
> Yup.  Another case for ISA supported vs program type supported (and
> enforced by the verifier).

+1

So how do we want to move forward here? It sounds like we're leaning
toward's Alexei's proposal of having:

- Base Integer Instruction Set, 32-bit
- Base Integer Instruction Set, 64-bit
- Integer Multiplication and Division
- Atomic Instructions

And then either having 3 separate groups for the calls, or putting all 3
in the basic group? I'd lean towards the latter given that we're
decoupling ISA compliance from the verifier, but don't feel strongly
either way.

--4NU6u4wMuY8EVbdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZh9jwAKCRBZ5LhpZcTz
ZIINAP4wvbechRRKpks0j0yNoflBRQxgOib+SC88vkED8vy1RgEAimsCnx2p6pKy
zB7HDLzSoFDNqmjhzayQAZ10Fr3KmwQ=
=t0Dv
-----END PGP SIGNATURE-----

--4NU6u4wMuY8EVbdq--

