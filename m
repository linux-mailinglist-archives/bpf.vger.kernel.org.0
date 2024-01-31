Return-Path: <bpf+bounces-20865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591718447F4
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147E228CACE
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85F39863;
	Wed, 31 Jan 2024 19:26:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A33E481
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729212; cv=none; b=I/UJsIbCrabiqYOpYmRgI0jVgGA0DDFhyAwn+k6I51XAe4ZIo7YasqdtPAZxI4jCI48f6GM9ctFZYZEHky08U4ce/bgBTgm8XkHDIAGekNDERVtrRsKZcRtjr3uH1rpFaqFhrEJNEUEMycFfInHLkAqYKduMLUftPsBN6Zvydec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729212; c=relaxed/simple;
	bh=otsOcoN4efWMd8+/aqp+VjvERo6SSCgR9PA5Ez/7QvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPGooDdZXw6qWCLp1DK+Yw08AU9rm/gETnDEfOdgY0q19FTJplCxrGyVlNFP0hZUkMwK0BhQ13EsdFLpK5tOPuk6vexfu1jehkW7TuCZlK9t+nO2KDMNrxEsi6MgIXI1gR3P354FmqATCe/Uq0SCzLdF7jXtCLAeqjWheihbpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c420bf6f1so633866d6.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 11:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729210; x=1707334010;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkMsnANZ4IJr/ZYEeRJg4AsRHEEumMvRVV3AQD441vA=;
        b=Mp0pzEny0rottCIcrbgjFm4R/CtEOzqvBRzvI3O/DOvPYowkD0DhZpNw3ZdH69mstJ
         fqTp4+KudKcL1o9a3+c+lhsizZIyVuqHpZwMbSqiBPPu1egZGjTeG327Q5PXrdu41VnY
         MdChqKtTEfEGhqPeZZ8pQKYKeOJDGrHzZf0BtPmx2e9/yG41PR2ktlTr7eDP32XdOHEi
         xJNXdbG+d0I4amksK01URNzNFQVRG9mRt5w5h2ezAy96VSVPtgZbymJrTNVf6zQHR6Qj
         ZLIJ/BJprYHDJGuO2bSudv/FKyj9V0eJAW7V7ElZpjjz4e5r0CBJ9q3SK7nQUf35j9pQ
         TTvg==
X-Gm-Message-State: AOJu0Ywh1ku2dwMPJccRIAwj2J3nIRwPLy8h2tDCU7yod5P3vIiFHi+5
	xyeVSjGCsHY6snEQjWdOX2VNEkvvcXO4+atjWzUicRKLitWvQYby
X-Google-Smtp-Source: AGHT+IEWDVgu6fry9QFJ/uard0h2oaa1nYsUEzRF/gAuSDoIyO5gBJYqezsaExptBSE+6qMDchyksw==
X-Received: by 2002:a05:6214:ca9:b0:68c:444e:2bea with SMTP id s9-20020a0562140ca900b0068c444e2beamr6470270qvs.6.1706729209588;
        Wed, 31 Jan 2024 11:26:49 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id og7-20020a056214428700b0068688a2964asm2723571qvb.113.2024.01.31.11.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:26:49 -0800 (PST)
Date: Wed, 31 Jan 2024 13:26:46 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	kuba@kernel.org, jose.marchesi@oracle.com, hch@infradead.org,
	ast@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Expand set of initial
 conformance groups
Message-ID: <20240131192646.GB1051028@maniforge>
References: <20240127170314.15881-1-dthaler1968@gmail.com>
 <20240129210423.GB753614@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1O6UFeeW7Xhx2khh"
Content-Disposition: inline
In-Reply-To: <20240129210423.GB753614@maniforge>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1O6UFeeW7Xhx2khh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:04:23PM -0600, David Vernet wrote:

[...]

> > +  as being in the base64 conformance group.
> > +* atom32: includes 32-bit atomic operation instructions (see `Atomic o=
perations`_).
> > +* atom64: includes atom32, plus 64-bit atomic operation instructions.
> > +* div32: includes 32-bit division and modulo instructions.
>=20
> Did we want to separate division and modulo? It looks like Netronome
> doesn't support modulo [0], presumably because it's not as useful as in
> tracing.
>=20
> Jakub -- can you confirm? If so, how difficult would it have been to add
> modulo support, and do you think it would have provided any value?
>=20
> [0]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/n=
etronome/nfp/bpf/jit.c#L3421

I spoke about this offline with Jakub. It turns out that there was
actually neither division nor modulo in the silicon. They only supported
division by the kernel's reciprocal division library. We could choose to
apply Netronome's choice to the standard, but I really don't think we
should.  Kuba pointed out that Netronome is old silicon, and that most
vendors today would likely start with RISC-V.

To that point, I believe the most prudent thing is to just mirror the
smallest riscv32 instruction-set granularity for our conformance groups.
For the case of multiplication, division, and modulo, this would be the
"M" standard extension for Integer Multiplication and Division, which
provides signed and unsigned multiplication, division, and modulo
instructions.

My suggestion is for us to mirror this exactly, here. I think the
contours set by RISC-V are much stronger data points for what will make
sense for vendors than what Netronome did on what at this point is
rather old silicon.

How do we feel about having divmul32/64 conformance groups? Thus
removing multiplication from the base32/64 groups. This would leave us
with:

- base{32/64}   (reflecting RV32I and RV64I plus our call instructions,
		 which logically fit here given that RISC-V control flow
		 instructions are in RV{32,64}I as well)
- divmul{32/64} (the "M" instruction set provides both 32 and 64 bit
		 versions of MUL(W), DIV{U}(W), and REM{U}(W)
		 instructions respectively)
- atom{32/64}   (the "A" extension provides 32 and 64 bit instructions
		 for R32 and R64 respectively, just like with div/mod)
- legacy

This to me seems like both the most logical layout of instructions, as
well as the least likely to cause pain for vendors given the precedence
that's already been set by RISC-V.

[...]

Thanks,
David

--1O6UFeeW7Xhx2khh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbqe9gAKCRBZ5LhpZcTz
ZNJEAQDTbR9dUbZjNHmp/wxqRHSY0rI8fl+xN11WUt2mdmzdgAD+IMTI72phHgtF
5NOect/LdyRdKvU+ZWIfqCYU2SjeFgk=
=XCjY
-----END PGP SIGNATURE-----

--1O6UFeeW7Xhx2khh--

