Return-Path: <bpf+bounces-19846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B08321BE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520C8288AEC
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6541D69F;
	Thu, 18 Jan 2024 22:54:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD41EB37
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618474; cv=none; b=rfPexOlXtOjmnDcKHqC9SNFHHv0dkOWxUL7wCk2vcObHa4zLAsJP4M85VVS/Na8NYM7tqVWN5wLRx4trm6KmtdTw3k6iqlN1WDwTO+ltr9I1im+6P9MvRhVCev3l4iY6btQptqCC7MdvR8XsuFvVm3zAwnZtSRevPjzI0PwSh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618474; c=relaxed/simple;
	bh=SlA5jVz2M9fWHBrYymjxdoyuAvVq6Ty4NY2T/nZOl2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj8QLNC62auyl91Lsi2h6e0e90zgW8y2boSCB4IsBc4K0C/oobWTVOWGH9xMODuMkLc/Un+OgiNU2gGR+4s+5JxVImUcE+O9EDg0xaAYbDq49x7AnPEr8AwngtZK00VgBfRfJH7yeBXOBv47zX1iYnDRPzacmbG90Vs91p3BIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78313f4d149so16384685a.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 14:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705618471; x=1706223271;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHOoNlrfjEvGZsS1hMw+vPiGNp386bKPhKGHFHXOF6k=;
        b=hXmNKXMes/GAYblaWzjSvhKxc9c0Ro9KTw8gpKKr7xSnV7N5lKAXX/Q/jlgkCD6zzN
         UCID8MIJzWwi4QFBLLn9a6UMpKp+YbmNp0kGM1F8lPl3yLl99NRVfCqdrqB6rkCKdLm5
         D4lY7WpeHUnxI0yzyagt5tV+M9HGiY9k0AtGH/cX58VWsU138HeDhQ5qr4pX9VW6OvRz
         Oj4aG7oBHJ4qHeAK3FK6sdGqFkN/7xCxzH0kcD5UYHVGBButmhg4mVXVkFpdU/rITWWX
         unH3yPGiNtPZF6Mn28q1fNlqUVmlMKqcqlmk9golcaPd7IH5ffPtsmQe7+OSJ47k3d10
         W67w==
X-Gm-Message-State: AOJu0YwF/JcNHM+FVNb5Vy8qqgcS3vJ0q05yf0g1ZzbOVc8UM6FjpbE1
	fgLdn1Rw+EGIMiieMaFVs8WAqOo6A6VGPyTnAUneDd/GjDntIcqscXvq1h7ObPE=
X-Google-Smtp-Source: AGHT+IEruA3k1UG2uHE367N8PlTpdFpfnc7U0KV1WRQHYT8CVTz0fCOvTQ/d5V1RmVscYsjkVdJziw==
X-Received: by 2002:a05:620a:d5c:b0:783:88d0:85f3 with SMTP id o28-20020a05620a0d5c00b0078388d085f3mr17979qkl.154.1705618471579;
        Thu, 18 Jan 2024 14:54:31 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id vv25-20020a05620a563900b007832895cf8csm5622191qkn.38.2024.01.18.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:54:30 -0800 (PST)
Date: Thu, 18 Jan 2024 16:54:29 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Aoyang Fang' <aoyangfang@link.cuhk.edu.cn>, bpf@vger.kernel.org,
	bpf@ietf.org
Subject: Re: [PATCH bpf-next] The original document has some inconsistency.
Message-ID: <20240118225429.GA875006@maniforge>
References: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn>
 <20240109173227.GB79024@maniforge>
 <016101da4326$8dbad1a0$a93074e0$@gmail.com>
 <20240109191037.GC79024@maniforge>
 <025c01da4594$4544e3f0$cfceabd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xcQc5tYfzAYvc18J"
Content-Disposition: inline
In-Reply-To: <025c01da4594$4544e3f0$cfceabd0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--xcQc5tYfzAYvc18J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:16:47PM -0800, dthaler1968@googlemail.com wrote:

[...]

> >=20
> > This is already pretty different from how we're visualizing and
> enumerating
> > the instructions in our document.
>=20
> The packet layout diagram style above is indeed the most common
> (and I'd be fine if the WG wants to switch to that style), but there are
> RFCs that use other styles.  See for example RFC 9000 which uses a custom
> style, but has a full explanation defining it.

I guess my question would be why did RFC 9000 deviate, but I don't think
that's super relevant or important. As I mention below, I'm fine with
applying this change if you think it makes the doc more canonical.

Regarding question of the layout diagram style, at this point I don't
think we need to spend time switching the style, though I do think the
other style is more legible than what we have now. If someone wants to
do the work then I'd say go for it, but otherwise I'd prefer we don't
block on it given how close we are to WG last call.

> > Consider:
> >=20
> > 1. They're not even using numerical values to define some fields, such
> >    as with Type of Service. They're specifying the exact values of
> >    individual bits within the field (e.g. with Precedence).
> >=20
> > 2. They're using decimal instead of hexadecimal.
>=20
> Sometimes values are given in decimal, sometimes in hexadecimal
> (e.g., see Table 1 of RFC 9000), sometimes in binary (e.g., Precedence as
> you noted).  Decimal is most common but hex or binary are ok if it's clear
> that's what's used.

Ack as well

> > Unless I'm missing something, it seems like the deviation in terms of
> using
> > 0x40 vs. 0x4 is specific to how they present examples in the appendices
> > (though even the appendices are using base 10).
>=20
> For a 4-bit field, I've only seen cases where the value is 0x4, 4, or 010=
0,
> which fit into a 4-bit field.  I've not seen a case of 0x40.

Fair enough, though as mentioned above, I'm having trouble understanding
where deviations are acceptable or not. I trust your judgement though.

> > So while I certainly agree that we should follow conventions, I think I=
'd
> prefer
> > that we either follow them completely, or not sacrifice readability by
> following
> > them in specific ways which don't necessarily match the chosen format f=
or
> > our document.
>=20
> If you're suggesting we use packet layout format like you quoted, that'd
> be fine with me.

See above -- if someone wants to do the work then I'd say go for it, but
I don't think it should be a blocker.

[...]

> > I agree with you that we should stay consistent, but it seems like we're
> being
> > selective about it. Could you help me understand why the deviations we
> have
> > already wouldn't have required a separate section?
>=20
> It's fair to argue that having a section defining the convention, like RFC
> 9000 did,
> would be recommended if one deviates from standard conventions. =20
> But it'd be shorter (and perhaps less work) to use a more standard
> convention.

Agreed. At this point I'd say let's do whatever is kosher and will
require less time and effort; unless someone wants to spend time writing
up fancy ASCII diagrams.

Thanks,
David

--xcQc5tYfzAYvc18J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZamsJAAKCRBZ5LhpZcTz
ZPltAP9XjoN7NK7RF90wSoKxx4e/gYdjBIPTRl4am4emDVKWjgEAl3gOqS7YDOYk
4dA9kkZZvOv1jwq8qug4Cz+CPA+Nnw4=
=sXuY
-----END PGP SIGNATURE-----

--xcQc5tYfzAYvc18J--

