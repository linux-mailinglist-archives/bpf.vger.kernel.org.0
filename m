Return-Path: <bpf+bounces-20866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262D8447F5
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2894EB253EB
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5893AC16;
	Wed, 31 Jan 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FGx80vjf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="hsdlSKhP"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD43A8FE
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729219; cv=none; b=J9o2Emu4aIsqdDYHcMqO2ZIX+E9zcY3j9GQ04MSupp5DN6YQbrkN/O20LN4VvPhOOCqRjeF/ukeGy76I3epNPMxn+FGWOpnwEFQR1dBUQAH6VIOx1gXLULcFWEqN/QX8i9IEFxIeDIguSckW8tlzDOiGh/5KuuJeeSRe4KSR9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729219; c=relaxed/simple;
	bh=vis142wgRbZvmvEXitLnRp3PeJb8izh6vZWyZyproCs=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=ahr2EeeLFBq4KvKosqNtvwseZGbaIutIztAZsvBej4mpkb8mSCAp8bXrVfKWwAU2q7q3X+wu1OZf2vTAdkw9vp078+6uS0Rk1xCX0TKISjBB1F3FArKKZFw74IzXeu62kjfaaows4YPt1NiTdObRG2+Y4k4uAnvAcW4YGaMssCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FGx80vjf; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=hsdlSKhP; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 280E4C14F702
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706729217; bh=vis142wgRbZvmvEXitLnRp3PeJb8izh6vZWyZyproCs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=FGx80vjfbDnTdo3AoR7MAGCXz30ueMzxPivJNNGnCAJHZnby4nfzUiBCVIhsjJPo2
	 sxGEZGPDTMt4VOnSithOtRtfqYCnMZwsVLfkV46AfKleIIe3wobrSa5GBHM3tmcXZ2
	 heUnnPuXMAIKduHgkheI/iUwBnvVNauxczSGqw0E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 31 11:26:57 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EC9ECC14F61A;
	Wed, 31 Jan 2024 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706729216; bh=vis142wgRbZvmvEXitLnRp3PeJb8izh6vZWyZyproCs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=hsdlSKhP4wbwCwHK0ZqsIYExrx0h/SP5gX7avQr77xfe/YYIcjn/9KZTYrWX2W2tq
	 VcDrh4HlBHJJ31np9pNPVC0ea9dshovvebpdNdipz7l6fXsVnVZE290O6PHOK7Qxf7
	 9orTVk9yX+7/KF5I9ouZXdJsWgyTU6n7szypZqnY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1B9D0C14F61A
 for <bpf@ietfa.amsl.com>; Wed, 31 Jan 2024 11:26:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWyu-3tse2sQ for <bpf@ietfa.amsl.com>;
 Wed, 31 Jan 2024 11:26:50 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C0612C14F618
 for <bpf@ietf.org>; Wed, 31 Jan 2024 11:26:50 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6818aa08a33so771686d6.0
 for <bpf@ietf.org>; Wed, 31 Jan 2024 11:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706729210; x=1707334010;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkMsnANZ4IJr/ZYEeRJg4AsRHEEumMvRVV3AQD441vA=;
 b=VyFD6qavhqXSAwfygBvl5fFfVQNYzi5MNCc+iXcBnFT9ZQdBRx0mwZS8RgNle9afUd
 p7T+xZMvObohUQjHjSxq3oJ3fyTsT6ncymsjRw8DB8sCqw4zTKDHLR/znfGT4wS999Dw
 6U/1ArgkhuRmP6UJqvicOHw5galn5Hh+JWWnB5ZPQ8T5pZ8gS5onP9VEPcoAz5DVuTuF
 aEBIAKdojzLbgx8t//8DFA76iiyPCq5xZieTyDOtZUV5lvkfA/u1XylfqDdbGpA+eh3v
 Z0iMXzEQ3U+REq9yoGNSC3iN0diHD5Q95wz7+i1HINauXteYVD7U8nhiV/HS92RLjRHP
 QDkQ==
X-Gm-Message-State: AOJu0YwxyQxcAquHnZs2R97vdk+G3tAsSZfajIe9Y9LO5uIqSf0kavGl
 kZNDTunhmtg55lTT0YyF7lg9IusHPyPjJJebjA5bmncDKw5qtGJFuH9q144e3FQ=
X-Google-Smtp-Source: AGHT+IEWDVgu6fry9QFJ/uard0h2oaa1nYsUEzRF/gAuSDoIyO5gBJYqezsaExptBSE+6qMDchyksw==
X-Received: by 2002:a05:6214:ca9:b0:68c:444e:2bea with SMTP id
 s9-20020a0562140ca900b0068c444e2beamr6470270qvs.6.1706729209588; 
 Wed, 31 Jan 2024 11:26:49 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 og7-20020a056214428700b0068688a2964asm2723571qvb.113.2024.01.31.11.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 11:26:49 -0800 (PST)
Date: Wed, 31 Jan 2024 13:26:46 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 kuba@kernel.org, jose.marchesi@oracle.com, hch@infradead.org,
 ast@kernel.org
Message-ID: <20240131192646.GB1051028@maniforge>
References: <20240127170314.15881-1-dthaler1968@gmail.com>
 <20240129210423.GB753614@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240129210423.GB753614@maniforge>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/plAns-_woFpnG6fMmr95ZpjhN3w>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Expand set of initial conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8573674232455004291=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8573674232455004291==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1O6UFeeW7Xhx2khh"
Content-Disposition: inline


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


--===============8573674232455004291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8573674232455004291==--


