Return-Path: <bpf+bounces-20628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB548414D2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D7A286DC6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046F1586C9;
	Mon, 29 Jan 2024 21:04:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246B76C87
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562269; cv=none; b=Avi25MWyvV7TIoE0F20UMzs85QcZLeprd7+MCMOEQ8D6gEMqxrIUwgdKHH3dJYzr910yTy1WB4PjMYzfaTb4BPkIJEOpm+Tv5sqVUDuU5eQNVzo2NsPdewCeP3sn6Yesc3nGukzXt7A0hRZwWxhw4qZ+2ILcjGRj02XnfhS0o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562269; c=relaxed/simple;
	bh=aCYyc9b57Ee3+Gv7R/UG3yZWxgXX7zdX1GibdjHaTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrzeIFpDuC8ptfAiDpgCiGcCJKvjrYrJtkBIcdNSYnOn8vtsGjNpIi1B+bRNGG+nqUPoW7OBZNBhBf6qZCWKlzEnKHzb7+jGmVIVhzAAI4OvwpL/x6kRi3BLnnwfqgCn5OoSM0A/Uv3P+TUuEzhizGHtjc6VM0PAp1rQMw99KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a8a398cb2so30339791cf.1
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 13:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562266; x=1707167066;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ybYMhxUcplW/o61rPshhwWAGKY1JMhsgnXTM1CnFqs=;
        b=Zk/oRIzOkp9+wEegd1f89hJzHU65wIiems5W+eoD7ce6iKiHmu9DJWls2kEZzWMN+P
         iMa5bBv2OKRhdJazy7frTc96tYvreOJeMFDEsTZmNAIAe6dERNW3bv15kCTZOzNl6tLx
         Uu4eZvlMI4UAxoDwyG4XL2+aZ2eTXZMjdSD3vpsLIV3cw39KJJhnKQsIxs9qZKKMCd6K
         D95BwluswOaRkhgCnUlJLFR4etB1S6NFExEiJf10IcvUAXJBGxq/SXcfx+ImPPrGGSiH
         Yd1S7TAyDleMutzi/RXZnXAilFPNS7EXaKmHM9GWg17wz7mCFZX0MWZN97PA26vgdWDS
         M9yA==
X-Gm-Message-State: AOJu0Yxvlz3t691tgq81aeAuGNovdHi8bjlhV/ayEzIx6FLBFnf8Uzo7
	QHS5/SLR1H+pz+JhrpL/hh/gHspygXyG7+d/a/xyQx0ppGHSUYTW
X-Google-Smtp-Source: AGHT+IFombvLF0LMPo6Y1Pdn78G0kVUXhFbVsiD/RPXF4g8u60I3fHr5vuhoY6IxEdDmghINxUi7Eg==
X-Received: by 2002:a05:622a:14cf:b0:42a:af34:af1e with SMTP id u15-20020a05622a14cf00b0042aaf34af1emr1477229qtx.135.1706562266386;
        Mon, 29 Jan 2024 13:04:26 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05622a22a500b0042a68c96bc0sm333622qtb.68.2024.01.29.13.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:04:25 -0800 (PST)
Date: Mon, 29 Jan 2024 15:04:23 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	kuba@kernel.org, jose.marchesi@oracle.com, hch@infradead.org,
	ast@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Expand set of initial
 conformance groups
Message-ID: <20240129210423.GB753614@maniforge>
References: <20240127170314.15881-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqjwq8jJ2FKYrrfY"
Content-Disposition: inline
In-Reply-To: <20240127170314.15881-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--nqjwq8jJ2FKYrrfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 09:03:14AM -0800, Dave Thaler wrote:
> This patch attempts to update the ISA specification according
> to the latest mailing list discussion about conformance groups,
> in a way that is intended to be consistent with IANA registry
> processes and IETF 118 WG meeting discussion.
>=20
> It does the following:
> * Split basic into base32 and base64 for 32-bit vs 64-bit base
>   instructions
> * Split division/modulo instructions out of base groups
> * Split atomic instructions out of base groups
>=20
> There may be additional changes as discussion continues,
> but there seems to be consensus on the principles above.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Thanks a lot for working on this. I think it's getting very close. Left
a few comments below.

> ---
>  .../bpf/standardization/instruction-set.rst   | 44 ++++++++++++++-----
>  1 file changed, 32 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index af43227b6..a090b5131 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -102,7 +102,7 @@ Conformance groups
> =20
>  An implementation does not need to support all instructions specified in=
 this
>  document (e.g., deprecated instructions).  Instead, a number of conforma=
nce
> -groups are specified.  An implementation must support the "basic" confor=
mance
> +groups are specified.  An implementation must support the base32 conform=
ance
>  group and may support additional conformance groups, where supporting a
>  conformance group means it must support all instructions in that conform=
ance
>  group.
> @@ -112,12 +112,20 @@ that executes instructions, and tools as such compi=
lers that generate
>  instructions for the runtime.  Thus, capability discovery in terms of
>  conformance groups might be done manually by users or automatically by t=
ools.
> =20
> -Each conformance group has a short ASCII label (e.g., "basic") that
> +Each conformance group has a short ASCII label (e.g., "base32") that
>  corresponds to a set of instructions that are mandatory.  That is, each
>  instruction has one or more conformance groups of which it is a member.
> =20
> -The "basic" conformance group includes all instructions defined in this
> -specification unless otherwise noted.
> +This document defines the following conformance groups:
> +* base32: includes all instructions defined in this
> +  specification unless otherwise noted.
> +* base64: includes base32, plus instructions explicited noted

s/explicited/explicitly

> +  as being in the base64 conformance group.
> +* atom32: includes 32-bit atomic operation instructions (see `Atomic ope=
rations`_).
> +* atom64: includes atom32, plus 64-bit atomic operation instructions.
> +* div32: includes 32-bit division and modulo instructions.

Did we want to separate division and modulo? It looks like Netronome
doesn't support modulo [0], presumably because it's not as useful as in
tracing.

Jakub -- can you confirm? If so, how difficult would it have been to add
modulo support, and do you think it would have provided any value?

[0]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/net=
ronome/nfp/bpf/jit.c#L3421

> +* div64: includes div32, plus 64-bit division and modulo instructions.
> +* legacy: deprecated packet access instructions.
> =20
>  Instruction encoding
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -239,7 +247,8 @@ Arithmetic instructions
>  -----------------------
> =20
>  ``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wi=
de operands for
> -otherwise identical operations.
> +otherwise identical operations. ``BPF_ALU64`` instructions belong to the
> +base64 conformance group unless noted otherwise.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' r=
efer
>  to the values of the source and destination registers, respectively.
> =20
> @@ -293,6 +302,9 @@ where '(u32)' indicates that the upper 32 bits are ze=
roed.
>  Note that most instructions have instruction offset of 0. Only three ins=
tructions
>  (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
> =20
> +Division and modulo operations for ``BPF_ALU`` are part of the "div32"
> +conformance group, and division and modulo operations for ``BPF_ALU64``
> +are part of the "div64" conformance group.
>  The division and modulo operations support both unsigned and signed flav=
ors.
> =20
>  For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
> @@ -349,7 +361,9 @@ BPF_ALU64  Reserved   0x00   do byte swap uncondition=
ally
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
>  The 'imm' field encodes the width of the swap operations.  The following=
 widths
> -are supported: 16, 32 and 64.
> +are supported: 16, 32 and 64.  Width 64 operations belong to the base64
> +conformance group and other swap operations belong to the base32
> +conformance group.
> =20
>  Examples:
> =20
> @@ -374,8 +388,8 @@ Examples:
>  Jump instructions
>  -----------------
> =20
> -``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wi=
de operands for
> -otherwise identical operations.
> +``BPF_JMP32`` uses 32-bit wide operands and indicates the base32 conform=
ance group, while ``BPF_JMP`` uses 64-bit wide operands for

Could you please wrap this line?

> +otherwise identical operations, and indicates the base64 conformance gro=
up unless otherwise specified.
>  The 'code' field encodes the operation as below:

[...]

Seems reasonable other than the division vs. modulo question above.
Alexei, Christoph, Jose, what do you think?

Thanks,
David

--nqjwq8jJ2FKYrrfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbgS1wAKCRBZ5LhpZcTz
ZBfoAP4mzH0k93r4muPvcTNNHozHZxfRee/Y+J3sKa5nd2olegD+M8hFatoGvQx8
qVAG7BUlJGLwdK/isPtth4subsZoYw0=
=DUB8
-----END PGP SIGNATURE-----

--nqjwq8jJ2FKYrrfY--

