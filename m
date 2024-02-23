Return-Path: <bpf+bounces-22612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE55861C93
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 20:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E571428546E
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE914535B;
	Fri, 23 Feb 2024 19:33:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AB12A16D
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716833; cv=none; b=HdyJKyRjPtgx2GP+iV/2ZmJOqY2EDZLqBCnA7pG+x3X5T+CDb3+QGx18UKGdSxqksOPMIH+Q1l9eerZEzcnr1bwZnf3E6Z3HXn85FUffwfTxGD42gFZcDqkGGEWeuOnCTUqBpV23WXBRZ2kO8Xvp6MDuHjKc0ghc9vxwWhFT4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716833; c=relaxed/simple;
	bh=NHMUP9NraBD6Eqk68pcz1wWKgF7lFeJ89j+9hHUMX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpcZFO7te1TSm89IYI/WolcCgIm3abd+DS1FlfOdPC3nKxxQl9lyn5kOFd0UU27l/cbXa5knaqqyFfmj1TFui2SvfyCRV7dv2l1N4GTQ0GIdjhMTj8JWTrRcZxm3fIKavrV0kjeejaOZv/Qmq3AtG3iTwWWQ35Aqa9+lTktsxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so1072270276.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 11:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716830; x=1709321630;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkwMxyU0Q46C/t8rQZ8Xx5eJVTBpDa+VcrdWSFgt2B0=;
        b=wlBRqUCBmRf7/8sG3oQAGM0m5vl1ZxZSZPBvsUEqRR21wO17hoc5nwWfodSkgW3TiE
         MU013qwJF/ylIBQT/32QxAMOdQsjODsZW1z20laCzO41uoFNEtVZXrOrJlKZywnWSye5
         i0cpDTfLuoILlc/Y2Kf3hTHWTDoOKScYQZsTBIjifuSB05VbZWe/RbdOk80k424QEI9M
         9Nce3AGpNoG0b1EU4OWgePCOnOh0Tpr7OSLf6U30T+D0QYm8GeFc5fCFtQBviPw6O4CH
         4gc8forMSfZzItXoO2DHxA/UvY1XxiSJbw/YH49q4GsVu9qJyNewcBIL7+s2qZfDT5CR
         mk6w==
X-Forwarded-Encrypted: i=1; AJvYcCWvo+x9L6fFm8tBvj7KFcV1GokugOlc2hmA3mvj1Ad7PxfOH/fr68AZYvhSIT1eyGeObTQNclylbXD6OLv7Tp5+vgap
X-Gm-Message-State: AOJu0YwYoHSMyVGQRzRVq8zgOiAeD9ZYkuW6dn2EOXfNoCx9uqV/+01v
	WnbG1heGG4Qdy80MI2dzDEYzkTonb5w6Dcqj7/9tnkz7RzWIyUhv
X-Google-Smtp-Source: AGHT+IGccsgslU+g7fG8RH5vESyaHGN3kG/kY82DvxdiXHadySf0pGOPfauWUKWsGoYLdLArro/ecQ==
X-Received: by 2002:a25:d391:0:b0:dcd:3663:b5e5 with SMTP id e139-20020a25d391000000b00dcd3663b5e5mr746234ybf.25.1708716830219;
        Fri, 23 Feb 2024 11:33:50 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a01c600b0042c61b99f42sm574541qtw.46.2024.02.23.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 11:33:49 -0800 (PST)
Date: Fri, 23 Feb 2024 13:33:47 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf, docs: Add callx instructions in
 new conformance group
Message-ID: <20240223193347.GA2026@maniforge>
References: <20240221191725.17586-1-dthaler1968@gmail.com>
 <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqDR/5myZN5HNQ8X"
Content-Disposition: inline
In-Reply-To: <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--nqDR/5myZN5HNQ8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:28:47AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 21, 2024 at 11:17=E2=80=AFAM Dave Thaler <dthaler1968@googlem=
ail.com> wrote:
> >
> > -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K=
 only, see `Helper functions`_
> > +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K=
 only
> > +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X=
 only
>=20
> ...
>=20
> > +* call_by_address(value) means to call a helper function by the addres=
s specified by 'value' (see `Helper functions`_ for details)
>=20
>=20
> Sorry, we're not going to take this path in the kernel verifier.
> I understand that you went with this semantics in PREVAIL verifier,
> but this is user space and I suspect once PREVAIL folks realize
> that it's not that useful you will change that.
> User space has a luxury to change. The kernel doesn't
> and we won't be able to change such things in the standard either.
>=20
> Essentially what you're proposing is to treat
> callx dst_reg
> as calling any of the existing helpers by a number.
> Let's look at the first ~6:
> id =3D 1  void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> id =3D 2 long bpf_map_update_elem(struct bpf_map *map, const void *key,
> const void *value, u64 flags)
> ...
> id =3D 6 long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)
>=20
> They have almost nothing in common.
> In C that would be an indirect call of "long (*fn)(...)"
> just call anything and hope it works.
> This is not useful in practice.
>=20
> Also commit log is wrong:
>=20
> > Only src=3D0 is currently listed for callx. Neither clang nor gcc
> > use src=3D1 or src=3D2, and both use exactly the same semantics for
> > src=3D0 which was agreed between them (Yonghong and Jose).
>=20
> this is not at all what gcc and clang are doing.
> They emit "callx dst_reg" when they need to compile a normal indirect call
> which address is in dst_reg.
> It's the real address of the function and not a helper ID.
>=20
> Hence these two:
> > +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K=
 only
> > +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X=
 only
>=20
> are not correct.
> call imm is a call of helper with a given ID.
> callx dst_reg is a call of a function by its real address.
>=20
> This is _prelminary_ definition of callx dst_reg from compiler pov,
> but there is no implementation of it in the kernel, so
> it's way too early to hard code such semantics in the standard.

Dave -- are you OK with us just reserving the semantics for all callx
instructions, including src=3D0? At this point I think it's probably just
best for us to boot the whole thing to an extension.

I'm happy to send a patch for that if you agree (or please feel free to
send a v5 of this series which just reserves the group).

Thanks,
David

--nqDR/5myZN5HNQ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdjzGwAKCRBZ5LhpZcTz
ZDAyAP9EjBNLZhSAh7AGADKMfnox3Byuh7TNzpWprJc4oTUGHwD+MyT1LAORPwyG
asVXe1cBLnDM3DMOlMf8ad6jok6ukAw=
=CVFA
-----END PGP SIGNATURE-----

--nqDR/5myZN5HNQ8X--

