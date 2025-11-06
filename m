Return-Path: <bpf+bounces-73753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FBC387ED
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420FB4F29A4
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 00:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123551ACEAF;
	Thu,  6 Nov 2025 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GPM717ar"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151552F88;
	Thu,  6 Nov 2025 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389333; cv=none; b=WjWes5IiYNYMNeY80bwzLcVkT3sA/VzSw/GtT0yj20n0OysLqZvLrhPEsJO/9+fQQc6kIXn8c17OSrNLHjspfM9e3KZJeyue0C0zk4KLdmwLuXrbXr8ri+hxBjXQQeGWxU7H5tVO8QQaa9MURWGUuF4jQD13ANwEz6GucYzi56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389333; c=relaxed/simple;
	bh=KVpDWxWF/dm4zgKhhVqhqvrQM0bzaukrblkcGtaAFao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n6wHWwu7hlrxxxxq9iFwMq5msXdPM6U0ltC2r0J6naY1L4Fp7lso31a5qwmWjtP8L8RV03gD1KNBqvf1eJzcfWCjaF/MJvFk1A3B07C3L9bL1Hu8RAN97nn+OnusHRsH7JQLgzpSrENN/otN34eo3AOT6/JdyBT6UnIuoRK4cyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GPM717ar; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762389321;
	bh=DhZc1sa9BxLzaAumTCpTVerftcgyskXVgkIQbbKjSwo=;
	h=Date:From:To:Cc:Subject:From;
	b=GPM717arSqZpALFFg48dOXn2o7iCenJu+l5lbrrZ8dS4L4Ev9XXo2G2PohJksW5Cw
	 BcPXolPguJ5oqUmntlCKni0Lsr35JzSOL8rK4g/SNr/n1TFZ041x0hDtbZjNlRJpAz
	 o9ZCFLo1JBjIrLp3ycsEP4Dc+/34B6FD6Rwvu62Daka9E5M9DIjxvD1i8z5cETv9zI
	 cP7UQwDsHoX2QhAGTS6GktbaBqd+XtymVmyHnKaOcL6RyN6mWlERaUOiO2yO45COMy
	 f65J42Xj7Y+aD0rJ5dPwjS3qtZ2aCIGKZCkFnxBsNCSYltBqxhIAN0yWljY+aCJpIl
	 TJPDAl+L5P2MA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d23BK1LS2z4w23;
	Thu, 06 Nov 2025 11:35:20 +1100 (AEDT)
Date: Thu, 6 Nov 2025 11:35:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20251106113519.544d147d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0lwr1YLBOt+uFngh7Rx_hSQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0lwr1YLBOt+uFngh7Rx_hSQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/helpers.c

between commits:

  ea0714d61dea ("bpf:add _impl suffix for bpf_task_work_schedule* kfuncs")
  137cc92ffe2e ("bpf: add _impl suffix for bpf_stream_vprintk() kfunc")

from the bpf tree and commit:

  8d8771dc03e4 ("bpf: add plumbing for file-backed dynptr")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/bpf/helpers.c
index e4007fea4909,865b0dae38d1..000000000000
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@@ -4380,9 -4531,11 +4535,11 @@@ BTF_ID_FLAGS(func, bpf_strncasestr)
  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
  #endif
 -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 -BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 -BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 +BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
 +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
 +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
+ BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
+ BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
  BTF_KFUNCS_END(common_btf_ids)
 =20
  static const struct btf_kfunc_id_set common_kfunc_set =3D {

--Sig_/0lwr1YLBOt+uFngh7Rx_hSQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkL7UcACgkQAVBC80lX
0GwSjgf+IwWpUtTU/H/MvvQmDHmtqqSSj9OqIhYdw8pBSr2gWW4BHJyTu+XUSthB
oq5ixveT/j4idfg4HSSAHY6eQiYG7l0XarnlEtgO1y+ttPldVEhPlWkLSWn+nLRo
A8tzUHAXID5z4OLmTV2CzdE4jzdjCO00I73+zg2R7YJMLsMGHwNThFar5hlN4ush
veYwA7b0xnHg2x8aTJ0cU6WOrPl8i73d6EPd5CQtA0yoVASXhfIKWpyjk0WEJ+BM
7OL4TjfW1w5k2tp92r3RjAOcoHOAuk4Vj5uUOPTfi0NuRgslOx9CsADvCyaVGuiz
RQngF4UhCZBJMSs/PJxLiLgdXQJCug==
=/jW5
-----END PGP SIGNATURE-----

--Sig_/0lwr1YLBOt+uFngh7Rx_hSQ--

