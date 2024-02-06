Return-Path: <bpf+bounces-21277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F584AD81
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BC6B2431B
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1477F31;
	Tue,  6 Feb 2024 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LCd02Lyh"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70F77F09;
	Tue,  6 Feb 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193996; cv=none; b=pCT60ZqaoQjnVw18eAFLkxaraRiuBxGLRMDtoNEFhiTVBSM7SUxRp9x2Z8zwYN23oDUFVehJZo9a8e1gaU/G73qimyq17KgYQEJZTIIhMxqnyAJJQ6Ka/8z7s72HPq6I10kxBMe7Nn2dnOKUTIjVUxVMPdxNLZEr7DiM1ONs9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193996; c=relaxed/simple;
	bh=0uR3n4fttqT1p7FWfc0C3esoKe9BC2WmZ1XoiTJeJ28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R3IjwMFV82COSeqaIVV4aq92W/dwKeNfTPfjt8gHUJOOri7Q9MKhQm+Ph+4UV+e78klh4YfRLpQmjy8iwL3IIy3z3bZFS+ATl/cXnyAQ376fHGVAWzfube1rfe+UK+GKt3CWqq5J20eFJfEJsLL09EUfh7zfsj/038wNqysYDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LCd02Lyh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707193983;
	bh=f7gSZSLZ5vY/ihKDYbvdOhv83urdobxkXG0WjH3jFAo=;
	h=Date:From:To:Cc:Subject:From;
	b=LCd02Lyh3kooDWmhYNfLt1CNF1Wf07AidYzWYIV8Zj2ui96QEykO3WLm1n68cgEp4
	 qnelsOKpmffPpJzCw+Dl+VV9uK17vXxD1J4suy9Rzea7HfGhhC7QCZ8P8corERie9o
	 NJFSNXfrT0lkdyqyT4p0c5F0OmPbpCNgg40f1YD8fwQsFl6Pz8HoDtpLCWs1KTRHmy
	 d/YG1jzVbE96YF01eiWjH9esZ6J2Rwfh++eVPlufalHVW7ouuPYwgHolvH5DYOGuzM
	 AYFCa9zoUOxc9gc3B4qDdQ1rhQKfU6vHhkt18j4YVT3t4XUQ1RDfUw45DWFQN/dSGV
	 kGTh3YS5XW/Ag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTVjV6Ctcz4wxx;
	Tue,  6 Feb 2024 15:33:02 +1100 (AEDT)
Date: Tue, 6 Feb 2024 15:33:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Dave Thaler <dthaler1968@gmail.com>, Dave Thaler
 <dthaler1968@googlemail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20240206153301.4ead0bad@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H2w1hUZ5byQHubw2m6jhPLB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/H2w1hUZ5byQHubw2m6jhPLB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/bpf/standardization/instruction-set.rst:121: ERROR: Unexpecte=
d indentation.
Documentation/bpf/standardization/instruction-set.rst:122: WARNING: Block q=
uote ends without a blank line; unexpected unindent.

Introduced by commit

  2d9a925d0fbf ("bpf, docs: Expand set of initial conformance groups")

--=20
Cheers,
Stephen Rothwell

--Sig_/H2w1hUZ5byQHubw2m6jhPLB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBtn0ACgkQAVBC80lX
0Gy8jgf/TYBszW6L0UFX1TbQIkcJW5dItvNy8aOw14JiGonipbT5LHQGxu1KeRko
ynfSZiQa8DKTzuHKF+0B/FebmcvxIieRnX8HIdwVQgs18BAIhEfqNzwRg0FRiS8H
HYw8iqTqzjQn4FZzmsnpYp5j4n5RmKOsytiUrNM5LergAgVYbwtoIzEIUhXw+goB
T7Gv4JX4syMyoFgzTlI4w5qcbezYOpjsrVZdpBgg9wtJjjSe7hq/T0NxWwdlfpFB
uXZnKh/q9vUa1w3p5J3GLE/KbgkQnjgHnF7+5a4efeH6Z/iS5iewRFBskYnz3Jlh
x7xWdyobiOUXCIDo2JuEnk8arLRakA==
=VxuT
-----END PGP SIGNATURE-----

--Sig_/H2w1hUZ5byQHubw2m6jhPLB--

