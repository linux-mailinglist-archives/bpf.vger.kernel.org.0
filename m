Return-Path: <bpf+bounces-23202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F10486EB91
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107AB1F24088
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34959141;
	Fri,  1 Mar 2024 22:05:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141B14295
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330705; cv=none; b=dw3/+ZpFP53RbtY4ijNQN1GjJ4CYWKSVdSkNwpvS/hyCkG8zwcJUGXfdPdCDLx2ZYXE8tOwykGp0/rQTbvgSbY+5ZsDmwI5wMW6LOHHwhu/JQU19fIXS5vmVLqSicDC2UMVHkxRRzU+0xE9eCBTNyIF0ZSP1/ojGQ3IEGTTmN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330705; c=relaxed/simple;
	bh=LgKPoCdHiXG0QLccatceiVjKSLMVKZwrtX9U1iHKwd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTFx68B4ZvlVKzJnJcegZvvOxvGqlkGRQwKmJwmGchZZ/6uxOOk60c9tlTQkOZC3Py06m0kAcQutdjC+u73u1mCzZnak6cWg/KrPlctCiiYKfcvotQ6I2sWAzjTUF43sds8uOrSYjUj5+02Eh8QgL8NOook+dC6AHRSTUTdTC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f571be9ddso19993386d6.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 14:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709330702; x=1709935502;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSlI/TtzoUdkSg2iVSWhH6rf3DTlysvwHka0FGU92Po=;
        b=BL42km5VQCEqfJnVT8aCtSkdHHwn3+KZLKizJWAxGGKdIw2EiQKDd5iSIcBCfZXqyt
         FeVspAKkqtUwmFTdMxN1CiyzAa14QySaqdVdZqbEvY/TpAnCgwSBLcG5Z2k2g2fZdFta
         TXUN1f0JajvaXAJAh4P1s9kBDWeLjjhUrbgEOBtppnyPiJ7YOjUkvVy+x6I51wM6/wy8
         ZOrVR6yr+SHoDGmVc3fKjynQ0u0qZP6Q3cPuWkSbPso4ZPLzn5rQTdD4GoPmFkyD9iEo
         47we57NKdv4LDmQqkbiuxHFpE2tELEgbmubwyRgiY0peLbX17ScUNNDxPCF3bFH/Z0KC
         MeBQ==
X-Gm-Message-State: AOJu0YzQdnvawg3Rpb9QLHYI1RZSObr+GhEtqBMpoKILLBgFD1mzZ5S/
	BoR/lYSia5VTo45kewvSAtTnGPi/pSUMD7l+7aM/kNqj+L1Vc3T4
X-Google-Smtp-Source: AGHT+IEZfRAHIwXSxE3s1/cBCxuP4GRbSr2X8JngG1vqHJDaxMk5Nzupf0+XawsNBIh5ri7nvMMnjQ==
X-Received: by 2002:a0c:9c0f:0:b0:68f:62c8:39d3 with SMTP id v15-20020a0c9c0f000000b0068f62c839d3mr2741134qve.56.1709330702354;
        Fri, 01 Mar 2024 14:05:02 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id oi4-20020a05621443c400b0068f11ceb309sm804621qvb.128.2024.03.01.14.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:05:00 -0800 (PST)
Date: Fri, 1 Mar 2024 16:04:58 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Use IETF format for field
 definitions in instruction-set.rst
Message-ID: <20240301220458.GC192865@maniforge>
References: <20240301192020.15644-1-dthaler1968@gmail.com>
 <20240301214929.GB192865@maniforge>
 <236501da6c23$30b03380$92109a80$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h+bXX5nS0hEPOju2"
Content-Disposition: inline
In-Reply-To: <236501da6c23$30b03380$92109a80$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--h+bXX5nS0hEPOju2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:55:34PM -0800, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> wrote:
> [...]=20
> > Very glad that we were able to do this before sending to WG last call.
> Thank
> > you, Dave. I left a couple of comments below but here's my AB:
> >=20
> > Acked-by: David Vernet <void@manifault.com>
> [...]
> > > -``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > +``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> 'class'=3D``ALU``,
> > means::
> >=20
> > For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly w=
hen
> > built with sphinx. It looks like we need to do this:
> [...]=20
> > -``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> 'class'=3D``ALU``,
> > means::
> > +``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and '=
class'
> =3D
> > ``ALU``, means::
>=20
> Ack.  Do you want me to submit a v2 now with that change or hold off for a
> bit?  Keep in mind the deadline for submitting a draft before the meeting=
 is
> end-of-day Monday.

I think we can hold off until other people review.

>=20
> [...]
> > > -``BPF_XOR | BPF_K | BPF_ALU64`` means::
> > > +``{XOR, K, ALU64}`` means::
> >=20
> > I do certainly personally prefer the notation that was there before, but
> if this
> > more closely matches IETF norms then LGTM.
>=20
> The notation before assumed the values were full byte values so you could=
 OR
> them together.  When they're not full byte values (and they're not in IETF
> convention), OR'ing makes no sense.

Yep

> The proposed {} notation matches the C struct initialization convention a=
s a
> precedent.

Makes sense

Thanks,
David

--h+bXX5nS0hEPOju2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZeJRCgAKCRBZ5LhpZcTz
ZOTZAQC3/6y6QAd8sEHhGDc9qW1EeTQrEijx2MFR86SslQvzRQEA2fLLW7MrjTp3
L57SqdZ7KJ2qiS9flrlZ2BZKv6LrGgE=
=NPUf
-----END PGP SIGNATURE-----

--h+bXX5nS0hEPOju2--

