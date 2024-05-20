Return-Path: <bpf+bounces-30059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A78CA4EF
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EE21F22A66
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AF145033;
	Mon, 20 May 2024 23:18:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4618C1A
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247116; cv=none; b=J40k2wVLU7AwaGpwZCEHqXlo3ma3kvw9bkCcFU6aXh5AP1dwlNibGiyuvyFmQWl78rqjGR4K2XdB1mOkk1B37B+cDholNuRxfr7jxSSdrTLgaSuE337KnqIJInHvcjOBlQpy5BskG8wJYg9ythZMNl73FVt0qrapb+NKJxnzsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247116; c=relaxed/simple;
	bh=dnHU809UBjH5vzKSb92hEAKe7TXLkz9FGrLjrr9ufL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAFpXbAi1KjicJz8tZ+Hq4nNDtRWjhQOrDCAeqV1Yww7+PeYI9D/avTgtinBTMyGqghaHKnh9ZSu60Xlf0MZ3MvMtClR2YWMxi1Tu+D8Yw5/uTaGidRge102cqInm2OnZQL79USMRNM8qaqqApf9zL/1U59vrzRUmoiPjduCQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43df23e034cso29598031cf.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247114; x=1716851914;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUqc4wSdLpnCjuNLhKWLrdKDKKNiFfKFYw1o3HNF77A=;
        b=rsMVf6RZn/xgbasA4YiIsrzb+XFdGXc2EAJw1a801xPkGGb0pAZ3Qa6X+uOYp60Zwa
         PAiJH9FLJwiAE/EP9b2nvKYMoPXnGmaLhIUnmA3hYTsat6d5Q2G3r8mN9A/ILpGsy7GK
         tmF4ZCfH8QmxJAgtQW13j2Yr9pR9x7+0/PjXy5QVbUNLpHLB6jjoocV8Yuu+sX18Omzk
         zHODoUIV1QCskzpcU/LXXiAOZ5ZGAZjF12dIXuLQuz6HoHMDIqSiW5sYDFLXZmAxeE0g
         iGtZ7c+Im/j2Llg6c/IjyyNNpbGE3v3y3OFhgR3OfyRPIt3gZ1vTJ41pY+IXv9dFBev7
         VxKA==
X-Gm-Message-State: AOJu0YyBYAJ8kNeodo6EoW4Ks4QfKSQSEKiiStg4jzdGT31wcypBKGom
	9HC2Htyb2lb7bTMVq21mOvqLRiSpibBfLmCJD+bj87aSqOjV11P9
X-Google-Smtp-Source: AGHT+IHpmMGWcnB8KO/+DZP9KczQN171J6UBUIucH5+w7M14R9ULkMNx/8ORoWyb9Mffkt8zNLcbYA==
X-Received: by 2002:a05:6214:4808:b0:6aa:2697:2747 with SMTP id 6a1803df08f44-6aa26973847mr78998536d6.13.1716247113757;
        Mon, 20 May 2024 16:18:33 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a93a73a4besm23230906d6.99.2024.05.20.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:18:33 -0700 (PDT)
Date: Mon, 20 May 2024 18:18:29 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA
 requirements
Message-ID: <20240520231829.GC1116559@maniforge>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOkmkFmqSH7Tl1oq"
Content-Disposition: inline
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--YOkmkFmqSH7Tl1oq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 09:58:55AM -0700, Dave Thaler wrote:
> Per IETF convention and discussion at LSF/MM/BPF, use MUST etc.
> keywords as requested by IETF Area Director review.  Also as
> requested, indicate that documenting BTF is out of scope of this
> document and will be covered by a separate IETF specification.
>=20
> Added paragraph about the terminology that is required IETF boilerplate
> and must be worded exactly as such.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

We still have "may" in a couple of places, as in e.g.:

Note that there are two flavors of ``JA`` instructions. The ``JMP``
class permits a 16-bit jump offset specified by the 'offset' field,
whereas the ``JMP32`` class permits a 32-bit jump offset specified by
the 'imm' field. A > 16-bit conditional jump may be converted to a <
16-bit conditional jump plus a 32-bit unconditional jump.

Also in the "Helper functions" and "Maps" sections.

Do we need to fix those as well? Or are they considered semantically
different than how RFC 2119 would define the terms?

Thanks,
David

--YOkmkFmqSH7Tl1oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZkvaRQAKCRBZ5LhpZcTz
ZPiWAP4juqPoXiDzaTMmnyCqgJbSAjhwr/p2C+mXZrbefsmlXQEA/RFCnTeneiKz
racIp8x5MDJDumrlDO4Y3SIZeyEbIgY=
=xG1k
-----END PGP SIGNATURE-----

--YOkmkFmqSH7Tl1oq--

