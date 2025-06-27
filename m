Return-Path: <bpf+bounces-61735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08778AEB074
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029C016B18A
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711102253EE;
	Fri, 27 Jun 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dpAqmKjb"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F86223316;
	Fri, 27 Jun 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010485; cv=none; b=AXV7FypHY6SUluySf8ga0zxOYFr44OPRvx/mocS/BvntBzJPpuiatnubGB/fZxARN+dqHDfP391geeP/04llNvoKXiVzfqim3mLd/K5J6CgrDpTlpZQh8Ii/VLPX61imR3rQFfI3ssY7XwfxzsJKu3PkBFZJuN1TXwJNoBBeVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010485; c=relaxed/simple;
	bh=e3ZY0/pui2Vz7RrxJYmby3liH1RgnHTQdK37ii9ibXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aKyKbmncDvBM6SMiT3gLqhd8MXHQNYRx5eyBdPcyx2ynr5iBi3BrQ+XKm2mfyjHUF2sCRzowHblBPOSJxODolUc2/KHFt+s+GnCq//xbPcx3yqoMkhZfbAhTgRA/b/KfpJNnt6eX7DAfGAa1sxfVxtykQ25eWUEogaL0nhllLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dpAqmKjb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751010480;
	bh=fy1EyAnTjmeVxDb3+C3bDInrgdQUJPABqEglxufnHMc=;
	h=Date:From:To:Cc:Subject:From;
	b=dpAqmKjbtjoe+0ay92ZjIMNIQNALLlNt8+P8idx0KXqgdZvFw3Xwru4AKmDVSUbUB
	 Izi7qTq1zLpaVBz0uZxIqfhJTELQKCzKKASYXzs3/xCKS9b3j+dMKPjIFK+n8map6Q
	 AGOsjEQqy3bYGERWWjChcp4sGLRhI2a9SManYqIkCwhwV/+2xRCWgrXw3Ggg0Gy3J5
	 lRZhLY2ik7X5+xcozERs6Gn2DiHp/8HRWwJb3jFM6ZjZkILPu9qX+uDl/WManNZTMq
	 rIFgK2fdpoDv7JFDeptO9RnW/8Ispr3eJlxM7vh0/QvzD8DDSDDiUwK7h5ProzK6fo
	 sZEXeJGrNAG+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bT72S2YNYz4x5d;
	Fri, 27 Jun 2025 17:47:59 +1000 (AEST)
Date: Fri, 27 Jun 2025 17:47:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20250627174759.3a435f86@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tXxknDF54A1Q.Q8AAv6kdW+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tXxknDF54A1Q.Q8AAv6kdW+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (htmldocs)
produced this warning:

kernel/bpf/helpers.c:3465: warning: expecting prototype for bpf_strlen(). P=
rototype was for bpf_strnlen() instead
kernel/bpf/helpers.c:3557: warning: expecting prototype for strcspn(). Prot=
otype was for bpf_strcspn() instead

Introduced by commit

  e91370550f1f ("bpf: Add kfuncs for read-only string operations")

--=20
Cheers,
Stephen Rothwell

--Sig_/tXxknDF54A1Q.Q8AAv6kdW+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmheTK8ACgkQAVBC80lX
0GzBHAf/Tyvc5FiGRv0lq0rtA4R0nVYIOKub58TcVsAZYu2Zu6vMPRHw1tUT8s93
YSgSDch5CxrCGcNid7d2Lob3JcFI7T7TsdGBSjCthQxZzhbiaR94+oewqq/L02Fj
lq7vvfV7qJ/1M+mtOMYBB0sCdp9/0jzFeSNV5JJkkibh20K15OU/NizUMfnxytlf
+0QcVRnMc86E3jiJHMac/GuumkHCpxF2nGrPBpg7py32RTJ/q0GdHG8LbsVhcb70
QP0tiK+IMQMx5IuI+GBHz+JeSlZttw2Hz0hC1RRwajjYXaTzHHF4yuhmtQGptPbA
wbOIR2QlE90HiFs19Oeo7JW6ZXbaTg==
=qmkn
-----END PGP SIGNATURE-----

--Sig_/tXxknDF54A1Q.Q8AAv6kdW+--

