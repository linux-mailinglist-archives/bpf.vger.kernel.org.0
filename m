Return-Path: <bpf+bounces-44489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614309C34B6
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 22:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182E41F221B6
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5F1553BB;
	Sun, 10 Nov 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AV+3UAbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D41428F3;
	Sun, 10 Nov 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272978; cv=none; b=STS85bt80bAXJylo7o68wNUKueH/ZJeeoIK0qEpjHdcBQFzh6G1Rmlczoex93eY4/tKdc9RO4bfnG0mIaAPhzQxHPhYUtVer6s/OgGrMpp4SjlQIVWj7dgiBnmEpqCfxcA40bGHQ1fqLUe2wa10jxmTeIV5k1rh57s3bjDD7wBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272978; c=relaxed/simple;
	bh=PfVhV/C8CuUKT8Tdz4ou0DXImHGAPL3BZ5PFi7Ng6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LoJkKaCwTOgQI245q3WfKPs9wmkBnY6TQmOYXxXAw/T+t5Ueq5GYJffTM6icDNkvujkb0JCN/4wmOmJORAZsuBjZ5ST7QVhBhpU2QtsiHBWTUefGhMWtiRvHttAUclSw6slo55W0gQvMDWdZV9MEX6Ej/ZVcc2kgttr60zkwPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AV+3UAbp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1731272434;
	bh=xeP4ouQtHa/jWKkup+EzyZ61TJaSZso9w+wwv54o4I0=;
	h=Date:From:To:Cc:Subject:From;
	b=AV+3UAbp0+EZOWhilYIDyTae9qPaPn4IJtIYKtOnTqJkCzZig1YrTQpw+/Pvbst5g
	 29B9Jy4fxOu6X7SP/GW/WJOSl6IUs1DPPfDSHGNaaONs7LTUyJrCGbthXSjVQ5IGL6
	 vzkaXX7plR82sdg0ed2gyjXWZtxq+d7aNverW/jWKWC0//DIc0YPWsrxQhtPuFEuqF
	 ZeHJdA/VHvo3ZWFa4rgjd2xVD+Or89JFcaJzS1sbxtgaJnxbAUifjCtnNekjurav7H
	 WBq+mLcc5uxPIyQt89HEwPwCyBo/aUjLiQAw21C3x40pb5LydeYV7N6Nx2N6lZfBbO
	 aT5pxcZrT+tvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XmlSd6kSbz4wc2;
	Mon, 11 Nov 2024 08:00:33 +1100 (AEDT)
Date: Mon, 11 Nov 2024 08:00:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf-next tree
Message-ID: <20241111080035.10b4609e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xddUmqdPX56PdN2.LTScwGS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xddUmqdPX56PdN2.LTScwGS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9a28559932d2 ("selftests/bpf: Allow building with extra flags")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xddUmqdPX56PdN2.LTScwGS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcxHvMACgkQAVBC80lX
0GySnAf7BRb6WVj0AvqPVr0V6FAIoTSTTUGuVWrowaMzJ44vcjXA4Fs6T5sj0Z6K
ydCK05994Ukhzcaz5uPgZCAfOUtlwcBIoEFSmfylK/ZX0W6oiHAISf7tkyRtpmP+
AL1x2ftUiCqXikqqbvlblRo8CGEcUoXff8skeFAdNLBl2ku8LAFV4SJ5sZMU7GDc
YNiDhRdDjBJQ9/rhUx3iSKZ+BAhAGTYuuWqDgwzntt+meQ7ajzNdjNPShqleJQx8
QiiuzrdY/WnyqlatxDDWruIvNoFtcy70q2ieUY0/TULmYYLVp9hvCiLokxgzIKkX
ukFS58X5ENgRCOb0hvO8Sv11Yj9O6w==
=kJfa
-----END PGP SIGNATURE-----

--Sig_/xddUmqdPX56PdN2.LTScwGS--

