Return-Path: <bpf+bounces-37114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53432950FF3
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803511C22EAC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5A1AC453;
	Tue, 13 Aug 2024 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cgbZWUPs"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E31AB52A;
	Tue, 13 Aug 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589612; cv=none; b=ZJaT1aRH4LqFL01xg3Tm/Y0B7zrYUn94vOmomliI+mb1Mlh3pBM3lnPbfvmbGqVWHRFAl/6VMf89ODqNJmcFi2ZQdISLUAvg96uWA4uF4pE+foGT5v/V/NlHLDfw2QJS6uCc1WeKbSp3oUA9hTwRtVljpbBuVx58X247dQ3EVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589612; c=relaxed/simple;
	bh=RaWUnW+Z+bvztMZYFuqHMi6sNeBg8WhCr19u+2z/s4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uRDaRYOcBQdH3s1s6bGVAGG4IFtlwy8jAiJwL4bIpMeW1nHEYA6rFA2+hzmxiCLW5fK+eFAw4kPQnK/TpEzYQ7pVcvfPo+nVGCmAOopgAbeK8vqfpUTLmyCk0Ij4XwBlmQcK9O8u3zqhTRyxKxhXgzh4XWgV7mFNVB2NtofGRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cgbZWUPs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723589600;
	bh=O65EqEzxltMuk5Y0mg2TEwCIgAIRuSUdJHy92bA9gS0=;
	h=Date:From:To:Cc:Subject:From;
	b=cgbZWUPsPGTbiWBcJ2yOvMB1Vgp4sJpwLMmlTe+6iKASQboiO1+ECilGdqpB5Em38
	 cNZUYu6/mQ5STvqJ9O+7mimsc8ePbrm/WBV9JQRvgwiJd+VXwS0ezK+CcFVBOF99sh
	 +ATEELA+kzyOWwQxVpJtOj1Zd/gT4S50HO/7MqMRIk6zMNaRJcs3vxR2TlXTEF7XJs
	 NFAdRLfmGepmdvOBC4DHHXc527mPjYf0/eRU176J0LSj0z9Y0C6M7JebRB//jIpxjY
	 JD5TPvlzHDJGQLm4vvLLlaB3vN3Mo6yW5Pu5manvk2ier5SsNkv+7Sa+QT9dtEBi8v
	 gjVtVsG6MRXbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wk69r4qn5z4x7F;
	Wed, 14 Aug 2024 08:53:20 +1000 (AEST)
Date: Wed, 14 Aug 2024 08:53:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf-next tree
Message-ID: <20240814085319.719b42ff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xEPxP7OegPTaAwCAlmheMn8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xEPxP7OegPTaAwCAlmheMn8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e811c1ee15c7 ("bpf: convert bpf_token_create() to CLASS(fd, ...)")
  795bc52f75ad ("bpf: more trivial fdget() conversions")
  139dc6fa791d ("bpf: trivial conversions for fdget()")
  2d74d8e9897c ("bpf: switch maps to CLASS(fd, ...)")
  b57c48f806fd ("bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)")
  b7014005e1e8 ("bpf: convert __bpf_prog_get() to CLASS(fd, ...)")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/xEPxP7OegPTaAwCAlmheMn8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma7498ACgkQAVBC80lX
0GxsfAgAjdtyvEBNjD/zfEhu5Q8If8uNX/DOxKPZJ02MD0Kx6qLGW5mDoPDifkLS
Z7rn+xxnZQ1hawEc117jb8yJ94xi2hGoz4JxwmH1NRFlWLJrdOXMM3XIcvRfKbnC
wgoF5rkmlBDHZPRIyaXtIrxjwXgTDzViQLdUKcuZWHtyegbNgR8meGvw7AMooK/a
J8eTa3w0Ilw8RXO8wCSijZOu3XhFwwdvbMkmkVTp4p4BoPWZW6W198MBS0ktd6gV
dsndVA8lUnyZ6vP09QSAcr4nQowC8Cgm4zeqZkoupj5x+J1ut1nRoOSsZ4D1L7dY
pQnv+szdJqZnq/aHi4Ph2ct1JiKliA==
=XJt/
-----END PGP SIGNATURE-----

--Sig_/xEPxP7OegPTaAwCAlmheMn8--

