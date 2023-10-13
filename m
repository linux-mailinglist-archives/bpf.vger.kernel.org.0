Return-Path: <bpf+bounces-12118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12467C7D04
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 07:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CF62824C2
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 05:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AA5697;
	Fri, 13 Oct 2023 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rw38ukSj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA835685;
	Fri, 13 Oct 2023 05:30:41 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34264BC;
	Thu, 12 Oct 2023 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1697175037;
	bh=AfBIySfe8fzqGBOdkjxdb3bfx1qDc/XmAZ67Y9SaAac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rw38ukSjr6aqa3lxPk3vRRGIuP5LW4BKBj9TK36FGVsbxjB+nAUYJvvmf0/FUSo1j
	 F3uK4/C4qbEumhrdNz9Asz4zj0x28JeJTVc/Hi+nsnlQh0PJA74fGy6Pg7/YaNVVLz
	 G0fUr8y5yYekuGZNw0Ckt8iKrdMi9A9UcczLvSABhSw0q4fNDbG1jZrADtG0yDc7jT
	 o1408nJUy75CY/Myuy1kYxr9nyPfPAx+6CrcK1/NG0j+FoK1LxIBoyPPu2jvaBuS8d
	 dGKq2YfSqy2b7ubXQiWi+AIsAhKSh8RliwVqGkB7FJQVSgqb+kI0udN9+WOl8ssLlN
	 TqQFnXw69zOOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6FTS65HBz4x5K;
	Fri, 13 Oct 2023 16:30:36 +1100 (AEDT)
Date: Fri, 13 Oct 2023 16:30:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Daan De
 Meyer <daan.j.demeyer@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20231013163034.73314060@canb.auug.org.au>
In-Reply-To: <20231013114007.2fb09691@canb.auug.org.au>
References: <20231013114007.2fb09691@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k+myDR2_YBcKtAwJqPXFyO6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/k+myDR2_YBcKtAwJqPXFyO6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Oct 2023 11:40:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the bpf-next tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> net/ipv4/af_inet.c: In function 'inet_getname':
> net/ipv4/af_inet.c:791:13: warning: unused variable 'sin_addr_len' [-Wunu=
sed-variable]
>   791 |         int sin_addr_len =3D sizeof(*sin);
>       |             ^~~~~~~~~~~~
>=20
> Introduced by commit
>=20
>   fefba7d1ae19 ("bpf: Propagate modified uaddrlen from cgroup sockaddr pr=
ograms")

This became a build failure for the i386 defconfig build, so I applied
the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 Oct 2023 16:25:08 +1100
Subject: [PATCH] fix up for "bpf: Propagate modified uaddrlen from cgroup s=
ockaddr programs"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/ipv4/af_inet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7e27ad37b939..0fcab6b6cb04 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -788,7 +788,9 @@ int inet_getname(struct socket *sock, struct sockaddr *=
uaddr,
 	struct sock *sk		=3D sock->sk;
 	struct inet_sock *inet	=3D inet_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
+#ifdef CONFIG_CGROUP_BPF
 	int sin_addr_len =3D sizeof(*sin);
+#endif
=20
 	sin->sin_family =3D AF_INET;
 	lock_sock(sk);
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/k+myDR2_YBcKtAwJqPXFyO6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUo1foACgkQAVBC80lX
0Gy36gf8DWwDC94MJhWkzMIkGcJHT8SGoMCeaYPIqPAVeD7L5DUf9WRTz9DQf0bJ
hC1bNGqyfW9e52BBYPMDpFZgyNbJ3avCPH67Jm4f97J7Sq5tGWKKoUyI/j3dQgt/
RbJ+px91E2OK7gSKQLaj1V041f7/1owJdF/z9h9cuNjc56yy5n9mb1v9+cl4YMQq
hYzo2lfq2Rw7yiDYvNwY3dHQJfkzER/0zExupCyCbOeO1z3zC6Qc5cX3dZB32RDa
MwgXQQPe3deMgLDHcJKNkOUBjszxwcfZHGhRLD7H29KxXEZFrDexrUojRrosvDQm
vuuvjMIoC4lz6HG8VEN4ZRbtcH2jaw==
=V1UC
-----END PGP SIGNATURE-----

--Sig_/k+myDR2_YBcKtAwJqPXFyO6--

