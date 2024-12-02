Return-Path: <bpf+bounces-45930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E49E0203
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D3165745
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8611FECB3;
	Mon,  2 Dec 2024 12:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74514481C4;
	Mon,  2 Dec 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141531; cv=none; b=W+ePTW88oxnLNFpKnLGv6CWnzLUgRjqErRG8aUCsL4xPTBE7Km/PB1i269ylZqMxJqTMslvAtbhPhcpmo664GzSXJycp+hZQqYsX4hpruoVqQbGavOV5nKucH/UAUKFO3bxRhXrxnl1PkmqlUR+TFGFuUnSIkvPRU8xKMBBLW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141531; c=relaxed/simple;
	bh=MkzK6dus06fMlQwf7cDlcwQoJ7ROfhuxKa5GPAQRKaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC2Iw8JGR9mDqVoSdBwjz0CdvNr6yz5MCoieR2q1nexy7EfflDLiR20lIJviySKnV5ZxA+H0y2xva1RKLxrztKYlnwVZ0Q9KNfSlc9FMZ8e+2pL9s6Ydr7U+CghrN0kHMtuQNEx5piQ+byRdJ65nc6Fdl9Ux1pZWxlUEabi/qgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D53B1C00C4; Mon,  2 Dec 2024 13:12:07 +0100 (CET)
Date: Mon, 2 Dec 2024 13:12:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 02/21] samples/bpf: Fix a resource leak
Message-ID: <Z02kF5egZ//yB7Tf@duo.ucw.cz>
References: <20241124135709.3351371-1-sashal@kernel.org>
 <20241124135709.3351371-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWZ96iafGrXzatfO"
Content-Disposition: inline
In-Reply-To: <20241124135709.3351371-2-sashal@kernel.org>


--QWZ96iafGrXzatfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit f3ef53174b23246fe9bc2bbc2542f3a3856fa1e2 ]
>=20
> The opened file should be closed in show_sockopts(), otherwise resource
> leak will occur that this problem was discovered by reading code

Well, code exits when this fails, so there's really no leak.

Best regards,
								Pavel

> +++ b/samples/bpf/test_cgrp2_sock.c
> @@ -174,8 +174,10 @@ static int show_sockopts(int family)
>  		return 1;
>  	}
> =20
> -	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
> +	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
> +		close(sd);
>  		return 1;
> +	}
> =20
>  	mark =3D get_somark(sd);
>  	prio =3D get_priority(sd);

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QWZ96iafGrXzatfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02kFgAKCRAw5/Bqldv6
8uO/AJ4yu02w5oJJFG44mmAXcBPNDsbUPwCaA0u9To22S1kITmJIDKIl6rEP8tA=
=FaIJ
-----END PGP SIGNATURE-----

--QWZ96iafGrXzatfO--

