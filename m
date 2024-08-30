Return-Path: <bpf+bounces-38505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA89654BC
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E305F1C20F69
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491CC4D599;
	Fri, 30 Aug 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V1fpOC4+"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26221D12FB;
	Fri, 30 Aug 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981582; cv=none; b=OMcCT1VleElGt9Om27wfKKBvEoOCrddxhXRFyAwFyxvamxKIpEu1Y++tqNZzKRTZrRRDG5RbmolbJuj+P+lHVp6KqajB3TCyCywGA9fm33dJWg+6utw1LMjYcUzkKVtbhoSWvJ2uvDsOnnFYhZT5Ncg9GYcSpYfBRWQg097Y9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981582; c=relaxed/simple;
	bh=Yi1Fdhj9/53RRfCFGvoVxhFJoGCv/N8eBAbHIaM5mkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3s1nX12xlrfqeZln7DOgAW10z2lh014s+wy/j5bOVpkjF7wl5INHMINovkvFpPVRGJn6FvEHZ+GzoqYtzv7FYfMxSAB+GzMkHRmjAT7yToj/9BJRuXCCQWdVzGQ8muvdUz29n4cQeF9vEf/6XTrTOaGhPo+hMNMg4LxfTpOT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=V1fpOC4+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1724981572;
	bh=67rtekJghnS3QXmSRsr2ESJaIvxwUWmhUoXjwqC+Nkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1fpOC4+8Fv4gyE5KVhK3CUT0Q8ysPoQewzqOzl+YDkZt++E0wePuHsDw7XYO27+A
	 hjeK8BEwQ8kGpNKj4VThTVPV2odfZp3HOdp0ymBgyJSjecXMhllVlYI10u2NGODcR2
	 SW/BxqT/5QAhwGicVmZc63AlV1ai/hGPi7iOgOki3j1+uVncYPv/i+SkW4628ozGFt
	 /d6S0aEpoHMSM+xby0qBJ1lXmSBaLrMu8SwKvyNidWrjA1wjk7cRKPi3ClgT/5lbfz
	 EjWRoac3otwRTwm1MBKmcGDJLBch7IfM1pZeHMx+PEqeydH6UE7hwYGSDr458UzKUS
	 6BSsjMYCr19XQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ww0yW0Cjtz4wd0;
	Fri, 30 Aug 2024 11:32:50 +1000 (AEST)
Date: Fri, 30 Aug 2024 11:32:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240830113249.0c03687d@canb.auug.org.au>
In-Reply-To: <20240814112504.42f77e3c@canb.auug.org.au>
References: <20240814112504.42f77e3c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jcdeaMnhlMF.q7rBpk6pC2/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jcdeaMnhlMF.q7rBpk6pC2/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 14 Aug 2024 11:25:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Caused by commit
>=20
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
>=20
> interacting with commits
>=20
>   1a61c9d6ec1d ("xattr: handle AT_EMPTY_PATH when setting xattrs")
>   278397b2c592 ("xattr: handle AT_EMPTY_PATH when getting xattrs")
>   5560ab7ee32e ("xattr: handle AT_EMPTY_PATH when listing xattrs")
>   33fce6444e7d ("xattr: handle AT_EMPTY_PATH when removing xattrs")
>=20
> from the vfs-brauner tree.

It looks like he bpf-next tree has lost the above commit, so I have
removed my merge fix patches.

--=20
Cheers,
Stephen Rothwell

--Sig_/jcdeaMnhlMF.q7rBpk6pC2/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbRIUEACgkQAVBC80lX
0Gzy1QgAhLCqNHQvJF2U11mJXrIe/7b5wi0QNw+Y9R7Qy3S3lslZ7oOyyzM5rKl8
fjJJk0YYhK/2fMm5ZgPJYRbm/ykj9+2rgoaQPXdvKH3g/RnKkGZwGNNj7c4qkpOu
srlC54nmsyXemwUVzU5cyLzgTYgnhh2arWgMpF7ANHElp2LjF7o8maJbTt+Nrroo
vef9TKILab2TiZRMS4u8ozi/63uoStXJYH8A8D/9JKFEi6x0/khsBFa4Ph0rwoYJ
EUigIPCiv03rMniYRM/8XqcTuWkG2AB4oE5k2uPMoYM07WCinWlicv6/Y7nncZbE
7eBTeAneJK6Kg3zdrUr9+DOKYTbtQQ==
=cYOL
-----END PGP SIGNATURE-----

--Sig_/jcdeaMnhlMF.q7rBpk6pC2/--

