Return-Path: <bpf+bounces-46377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97269E8BFA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 08:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515621641A5
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE4214A9A;
	Mon,  9 Dec 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ii2f0KYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AE1EB3D;
	Mon,  9 Dec 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728573; cv=none; b=qJysI0D5wVbgJpOPlugViRBzsMB5SQu1XazpGhVOao/QHnGhunaJ9xIUVO2fTmvTXsqgvXWuaTlmBN/PaOgQpdYnGLwOhqUX7sAUCvWHi5iPHP4HqmHeH2FnGiu03+MuzvMHTW4kA1NeI/CJFQaA/icW5u2/7iHcJcI0WBF0jJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728573; c=relaxed/simple;
	bh=1J6V4E8LA0GGaZJ+POqJMUUoNezDtzJbOgOTt4Cj3ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rlDGvi0mN/a27NRv7PEEjac8fW/LcynzwdII3Muyw9OkIzSHY8ZTmEOwE43hV3DXxxbugMWv0HM2+KxzsVyXXfz0H8rL9j+5jv4ZdJO1x7MFoVrEzCnC5aeqjbR1iKrZqkr87dtjp6zeKE/lC34fV4P4fHf/716VT2Foer7r1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ii2f0KYp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1733728564;
	bh=l8PMxQonCXz47oET43kTRgtVB66upph2v/VQEttAlKo=;
	h=Date:From:To:Cc:Subject:From;
	b=Ii2f0KYph51ZksyHS6iZxYyfe7FY4Jqyil4xObbImf4MubzEmRK5E6Wg8CXzVEJsm
	 2HF4ZUJJCP2hnZ9Kny5Wy+ip7IyDF2tX1pUzuSUSzk82QMf+irzAG7+XifeXia2rVC
	 SQX6fARwgqkX2KmlawmD/UNRlkjpSf7Fcr6bQoxt3VWDtCSzEBnVF0kBeBi/jzCJL/
	 zy2ooM9CvRva0at0m8p62JV7w/mZyYohlWUjbk9M5hf9REZ2oxn4QamG9/k2ZRMGgK
	 lIuy3kEYE1QWjF0EBNz7s8XReXMifcBbmO/Icm+xL9xyYMM0yp04osx8Ub6EGvzWjJ
	 LUhfoylh349hQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y6Cnw25L7z4wcj;
	Mon,  9 Dec 2024 18:16:03 +1100 (AEDT)
Date: Mon, 9 Dec 2024 18:16:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Alexis =?UTF-8?B?TG90aG9yw6k=?= (eBPF Foundation)"
 <alexis.lothore@bootlin.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bpf-next tree
Message-ID: <20241209181607.421c025f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.=Jldjg5mtb2ktJcqUecz9.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.=Jldjg5mtb2ktJcqUecz9.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c721d8f8b196 ("selftests/bpf: ensure proper root namespace cleanup when t=
est fail")

Fixes tag

  Fixes: 284ed00a59dd ("selftests/bpf: migrate flow_dissector namespace exc=
lusivity test")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 6fb5be12d1bb ("selftests/bpf: migrate flow_dissector namespace exclu=
sivity test")

--=20
Cheers,
Stephen Rothwell

--Sig_/.=Jldjg5mtb2ktJcqUecz9.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmdWmTcACgkQAVBC80lX
0Gyaegf9GcYmvcPCRNc/v8zT0K0viqhGSuVTHttaMtO2gSBZ/q6YhKaPk43LbXHd
ovgnM19jQ4vYBuKhtQ0M3kXOsRc88b2fAwA5GP8pjxAtYehmc6mjbktQx44mP5XR
jnyxfEAjZTLXLkYQ6GFHLL0Gnn6tREGzIR2nnoyWn48NJvrGQzXcdVCl0Fadm7x5
Fc7FUoW/hFK3n+2WptQikFRgA07n+A7ri01tujsAs9JplfdgvD/q0cfPd39OIEyP
YXIp4rVOtQ3f6tja58fZBlbR6el9bLCAK0MfuQgHIdKmm6RQn7/mSRcB95DoM6D8
A17bRo/9FL9EIv/ycZleBIpN9DsVxw==
=XeEq
-----END PGP SIGNATURE-----

--Sig_/.=Jldjg5mtb2ktJcqUecz9.--

