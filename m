Return-Path: <bpf+bounces-61736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7AAEB087
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB5C57A8644
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8982264CA;
	Fri, 27 Jun 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rXkexf8w"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AD2264A4;
	Fri, 27 Jun 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010639; cv=none; b=pgFY6vxgHHTQAR5eMQjUrGIkPK1alElR4sWIvH32mSgf3JiEtH4kQvvf7Z6jQ7thzduisGnCdK3TuOespJ0fI21FIVB0yg8gy3JBSdN/85ZRIscVy1dd6hmglKE7WzqDdK9BkwJ0sfTNmcbuIOuM8umcyohTsmIhXH+u81ZOdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010639; c=relaxed/simple;
	bh=rkfI3s72IkUqadXiLrDRNWU/eKBpZbHUz0VwmWZ0+rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPSVsTW5TguiWm09UDjim63UbJ1RgL0mwCV+TnxRzJB4BF6VJeKAj4BwqotNcoXl1dF8Jla8wQIs3Xc4csteQwgvDslLaydhTtqFu0VZYodUYwoQuXekISj8lf1q8/YMxtmJca317qqg0Or0Z5yPBapm+lUmnqPDWeJhAZRTuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rXkexf8w; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751010635;
	bh=rkfI3s72IkUqadXiLrDRNWU/eKBpZbHUz0VwmWZ0+rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rXkexf8wK4g+1ONBAdvINtip4QZs6bHc/XqR7Bs/8OyHpy6vdB8BWTpKGTG9u21iZ
	 0HplRi82OI0FvrqyRXkBryW7x9rf/tKLAL/DIS9NEjVBn2azmucSAaN27jH20WLnNh
	 BmZ7jQwa43jmUOapSdwQDhWVmjiHnoahaJAOcYGPHSvfKW+edn4k381pgHOfodMAnW
	 g0xZkYmUx3Zz22yq8CQMVxGSudwGM6OgG5y/MN2E2vVO8uUPY83OwKusiwbhRam7b8
	 UWxCSEMmDlllpo9IksgvG2zI8P3wvurkl6wDdWhixPtp3lVAG8WnXbgYaWl7V8Fq5j
	 OkL0yIotM851g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bT75R3n0tz4x6r;
	Fri, 27 Jun 2025 17:50:35 +1000 (AEST)
Date: Fri, 27 Jun 2025 17:50:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Song Liu <song@kernel.org>, Viktor Malik
 <vmalik@redhat.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 vfs-brauner tree
Message-ID: <20250627175035.3155e118@canb.auug.org.au>
In-Reply-To: <CAADnVQLo4-jSRh5J=tNeEnN_3Rsxy0zOGccYdfqe934+jteVjA@mail.gmail.com>
References: <20250627121206.31048e14@canb.auug.org.au>
	<CAADnVQLo4-jSRh5J=tNeEnN_3Rsxy0zOGccYdfqe934+jteVjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AhR.4B8b5clFJHMoiCMQC6G";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AhR.4B8b5clFJHMoiCMQC6G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Thu, 26 Jun 2025 19:17:25 -0700 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> Our emails raced in www :)
> A minute ago merged vfs's branch into bpf-next/master,
> resolved this conflict and pushed to /master and /for-next.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/AhR.4B8b5clFJHMoiCMQC6G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmheTUsACgkQAVBC80lX
0Gx5jAf+OyfEy1mVlTadUyfddkuoS5ACvw12CG+GFkpP5J012vH+l1wwF64lcQoj
LppPftGfSF6rfF3or3RHmOcN5y+Ad2YPFRTghHQZ1J2f7SRBZmNbHSqeVj7O4jOG
9QTF4fbbh/ClbUKiIZOTLJQ7OqrcajUc28e0DoBY2JkJbYpDO81cXZ5t3Dg3AGXJ
A66FuPzuFbQJcOwXvT4zB5HBlYAS2MhmL/bFkv90joI3Ry6ploVabXwiuY8TBfgX
3YkfBCFJ/ZNMIu0f2aEpXUKomA3yQEiiWJQvgndHJw1xIn9CP04vOuTUQkHxzll2
z0RaHFYzd43Hx5kHjGYY6UKBBCVJew==
=fcal
-----END PGP SIGNATURE-----

--Sig_/AhR.4B8b5clFJHMoiCMQC6G--

