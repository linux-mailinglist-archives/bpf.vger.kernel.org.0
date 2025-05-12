Return-Path: <bpf+bounces-58000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A5AB3235
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E16318969A4
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3725A2B7;
	Mon, 12 May 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mHJ9z0pz"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698122512E8;
	Mon, 12 May 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039781; cv=none; b=dgDqEnata8OhVUeuvMMVtiRj0Gl4YHMYUKx13eujiN0nhAD1KuSlBfotajaGn1psY2xaD6cADllYRQ3LJsOmUd2uViOnjUddG7oz1FQ2eAaDKWsWTqdMBDhZRgNbm08k/qlXS8GOjKFJq/aHOiTk38XdXrDO/1JBIAMW5Xk88BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039781; c=relaxed/simple;
	bh=bDLA8MAwgxibeeoc9N05etDX5oP0DiemHp3wni4e8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZQdnqYujfFKimxa5lJg7f5Wl8Gkcv2dK+4iGjtpoKiXT3stwwQOGfgSrCPuzkjRTXFMdvmWEGmBk4zfiQbxr188B2bUQyW9ISlFupU3yK8F7p92ko1mwqx0zZEQd7bFDFYe/95B/Z5pkEaglXrtXvewkq3A3MkFJkzHQ7X/ByRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mHJ9z0pz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1747039776;
	bh=7Y3NikCUQZgHe3wYf2uK94Lpabh7b3I9mWqLXC3UVrs=;
	h=Date:From:To:Cc:Subject:From;
	b=mHJ9z0pzo4D91NZG1aMkpdylWsaRTOVvSNxm2bDIeB7x5DsKTS1aeLY+jhoRw3/ue
	 7Rv4I3FMtg/uJnzp/locixcTVxCvDmTwxTCwbO7+q7hOqBCx5iA/OyMqD5Xj4cTFiL
	 44fFcowt6w/W3XvOWlv1dUwzOVQuRem4PYhhHRKqFHfQkuAW8nGBa+SXCzwhVXyoFX
	 CThUX9O0/4zFH8VWaNgRtXq7mkARdCjmP6KDf1OH77fvyrIyAurzgA7ul9ppLCXElj
	 iCnHjZ4Z1w4ZAbMm3vQcHsyUNOLyITKInWxMwVGIxgaTE49HFiGvRrLuVvyfhzfWnH
	 RWCRBQiEfhf6Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZwtZm2nMcz4x07;
	Mon, 12 May 2025 18:49:36 +1000 (AEST)
Date: Mon, 12 May 2025 18:49:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20250512184935.03464094@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+tB7C2afzcs1qPM/DOJPkfK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+tB7C2afzcs1qPM/DOJPkfK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without a=
 blank line; unexpected unindent. [docutils]

Introduced by commit

  7220eabff8cb ("bpf, docs: document open-coded BPF iterators")

--=20
Cheers,
Stephen Rothwell

--Sig_/+tB7C2afzcs1qPM/DOJPkfK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmghth8ACgkQAVBC80lX
0GxIzQf9EpkYipSeBArAFK5oPspUvKgYf3Gfa9Zbxo4lFbkPEa8b64ncRjJI+gK+
02s+jaEEjm1yaubo0DzZ0pxMZ4u9xe/H/Tf6cHGBVyNOln0gD4Q8vXg6E++M8Qny
IdE1m7uxzekK8qbreZr5t2759AQS/TuZkGuNHWEtvBR5kZuqgry2G9V/vEvrWZJB
kkR3xoOPwMSxbi9lzwnt+ZgYR0tBOkUGnD6yjTQXvLZtpv6d46LhtxDxsfO9yfXb
jikrXuOI5GaiqAzJS2bXaEyOKCXcPHcR6voW4iGKuhJT4x5i4SPKeNxFl+To32vw
zMAVUtLNbptJZZ2V+eq/Lv5jO4J5Kg==
=KZDx
-----END PGP SIGNATURE-----

--Sig_/+tB7C2afzcs1qPM/DOJPkfK--

