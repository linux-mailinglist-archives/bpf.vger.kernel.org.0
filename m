Return-Path: <bpf+bounces-17045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A828094E4
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F61C20CE3
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BF840E0;
	Thu,  7 Dec 2023 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f7U6djFr"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC010D8;
	Thu,  7 Dec 2023 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1701985680;
	bh=X4YTdhqhYGZhla9xm2lKDRZhCpTvNfgHqPxqimBLQcI=;
	h=Date:From:To:Cc:Subject:From;
	b=f7U6djFrY7Lfec5Yg7KzsqwaRWtjKKz9CIdTIr1UXkLbMvAcg5GuyBmMx5/ADGk7f
	 WJvbuSXE60dhZETBCDo/IfgmQ51WSjtOrr3E+JIJTE48M/ORlgbZ6iVtFko6JRLAVc
	 +QKGqxKkxa1j72X9t3c2slUYkAR+ZE4ZsIef+K4f+aDRV6C8LfUOJYK7sOqxzPcurG
	 v+hU5muKW2v0r4uSU3Et9wg23tSLiABdSoe1h+8ot8yzLduG7W0DJbAZEiEbrn0pO1
	 8UlRSE4BdFu9P+IyZNP2hbQHUdzmlcyhGKyb8En6Pq8Bo/kJUBGPq6Kq+bnRjNWdCc
	 dF63vU0bfyJIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmSYr3WpLz4wbQ;
	Fri,  8 Dec 2023 08:48:00 +1100 (AEDT)
Date: Fri, 8 Dec 2023 08:47:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf-next tree
Message-ID: <20231208084758.67fbd198@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2nANb0jHZuV8Ax4TDOEWvFz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ec32ca301faa ("bpf: Add verifier regression test for previous patch")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyPY4ACgkQAVBC80lX
0Gzw1wf+OpNcMLk3Rm7RzEKa6h9k7RoQ/Bp0koSb2U2ZAIcSH2VC8qtaLvKEHggh
PghXq14ESp8gAuCZZ0FoxzNN5AB6z/539yHTavCR86u08XuFRvWHVAfPKopjquTZ
jeawhj4h/FzSTTqjIFOtZM6UMH0pQ3Nqahr2wKVPMGidw6+V9WZ48Y3L+F+SMfv0
QdJS9Mxy03nS6SDq27g1HvawhvURMf1nGNFQ95oABprvWxjvSX0klb5ie6dNSsrT
1F6rpWDTb+pacLpVeQviSTXhE1zAQRdOULrG/uoCyIS1sIXsVTkBEMTBW4dlED8W
jzG2mY5OOfF0yrt+38VLJURgLZ7C2A==
=RWTj
-----END PGP SIGNATURE-----

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz--

