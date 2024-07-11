Return-Path: <bpf+bounces-34604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D092F215
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 00:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C101F27611
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14E1A0713;
	Thu, 11 Jul 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rX5MzmVo"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F685956;
	Thu, 11 Jul 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737379; cv=none; b=AFx8zG3P0skkWHWXl+zVJup9j0NqS0ioPHqqj1oWNOAn4nrStZsndy/WmTAfzDrwUhso343yxa7oq2g+Ole+g03myGCGKnlaI9VR/q9FfkHeqhT5OngKzoSfqjHSCn7WUhENJwNPmIkh39cj766/8FbrQ78K+4e8fGCnOouAuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737379; c=relaxed/simple;
	bh=dc4Jw3DTKtefZuRRzMr/hY9B1TDH97UDzj3YCB3E4p4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=looolxlJ8X6bCJtTrfCt+iYvddw0KSz2sU8FwFdncoLW/KkhyA+b+AaFEgv0fJ4kOHFXmvewPkKgc/pbcuRS8Gt3HauyOkWu8lasOg0BQm/wzGj6pzHMftHNG/PfmMeXNiJ2galFRMSWsI+1+R1M3Nk+3hjYLRJynoL6T1rFclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rX5MzmVo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720737367;
	bh=r9hKUTWh5HXYpxD+Z8+97RAaJIdCfBVXj1YcCQXcHzw=;
	h=Date:From:To:Cc:Subject:From;
	b=rX5MzmVovlAzMUfHII3Q5eTQaoZOL/gm2MpRWKmkVdv7tOiIkzvOu68JeBLsuYGJ/
	 xrbSeZW0UVxuqjiWCC43GBOWlPf3hcbtZag8KIk8HNYiu4WKNupRFtfWOl8k5wkz4e
	 z4AMPVG6KwLk3ZWPbnXa3y9HiwnvgghbnSOmdETgzqdvNvVPi/VHFZUp7dre6OzoOz
	 QVI297kTCuYQD2k53fCVngtKjmsLfObwMqj2MFGlvv0C0mOHaUZHeSEqvTWW2Kku5L
	 XkmIav2E04Uj828x4GW2f1u2mPbk9s9owyKeBUwhKzulQe6R0bkU/i0U3YbcnY2kUk
	 tX71cslZMw4tQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKqM95vsXz4x12;
	Fri, 12 Jul 2024 08:36:05 +1000 (AEST)
Date: Fri, 12 Jul 2024 08:36:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the bpf-next tree
Message-ID: <20240712083603.10cbdec3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3KrzG.q/=lXaTJ/VL9pZalK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3KrzG.q/=lXaTJ/VL9pZalK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the net tree as a different commit
(but the same patch):

  6f130e4d4a5f ("bpf: Fix order of args in call to bpf_map_kvcalloc")

This is commit

  af253aef183a ("bpf: fix order of args in call to bpf_map_kvcalloc")

in the net tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/3KrzG.q/=lXaTJ/VL9pZalK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaQXlMACgkQAVBC80lX
0GwU+wf/accOP7SbyaFHTbEpMeVe5wwGhbEd3JWxSpbuKTZx5bWFATYgNamBIZR4
amaHYWLkwi7EJyMQg7bknWqbtxAavj4rxKMuzxIhVC7+d+CUUDmPr6M00DsYWdsw
LetA/az4UhyaZ0Hx2xhEzeA+pS9RWcCFscjb62NQa5MOK86gCTXZ9biVjJl0YnYQ
eQ83IofSjOQCjkF+l6EtBVzpUYEXxEnOkYQqIPwAD9UM8cyf7E8HcmCa3J1xVnzy
j35/A4zWmZ5YtMUupowtxyhX+G2OEOnIqYiYuEvZifpskLYbaMU8I0C4+mZK8FvT
UcTs54Qls4DtFyb4WwKVgoOqE+A6PQ==
=EaLA
-----END PGP SIGNATURE-----

--Sig_/3KrzG.q/=lXaTJ/VL9pZalK--

