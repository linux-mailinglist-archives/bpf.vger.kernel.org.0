Return-Path: <bpf+bounces-62365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13753AF85EF
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 05:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2C21C485E0
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22261E8320;
	Fri,  4 Jul 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hc+GHlpy"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9617CA1B;
	Fri,  4 Jul 2025 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598704; cv=none; b=BYDt8ypdwycK8ODjv+VVIxBbGzBE7mDDEH1yVmkyUai+Ja51IlZJJQNBsxIFMWBYUc86m5ZsGB9l0MZfkxSZiPAewUiXQqs6LtK14L/9y7FM5RbZmqQo77tB1j0/v34WatDeeGKrJMRjmTfHMwO97S51l2iHqqttbk80VpSIzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598704; c=relaxed/simple;
	bh=43Q7A3VRL4TnRonDlu6Q4IeSp7pTTqPtvV2liehgIyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BqEL17JSTyZ1lo8Qx5yPMKvp3n7iBYd8HAch7/yv1O+DT4tVzu85R8ljNcf9rE3gtdCzMazgwt+lMAwlxhsNh/2rqYO6HMJE9qHIdtGubwXWNAkNYgBDB3eTZ5yjM9zaU1tvlQjTkNGbmaZkRHMo/rL73rXZMZYAaJgQbnPVB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Hc+GHlpy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751598669;
	bh=gDdy+536mUIxf1DeR863dGAOtY2TVORyc2BvNtT+JdY=;
	h=Date:From:To:Cc:Subject:From;
	b=Hc+GHlpye3EBxeVotIESMrfoXnJe0JGugBLNpJNvjjlvQarh9VwfwXY6Rr0McIvfu
	 ZQfiZ9saOqE6Vw3x84I5vvsN5a/G4A9uSScaBhj21fNSXy7HmSw00Eu8eHAPLcJO+H
	 +6TpTe+3C2m6WtnDL+ZZ4eNGk4E0NgE879nWGyYYE0g2TptsWr8vjKLOzQdZMBIArB
	 cxN56uxPTCEQ0z4UKw4+TZnxoLIsvzhG1brrUWtIrqbCj/qN5+KvnlOENC/rHNBTD6
	 eu/WAtJFq4dcXwVwIzNCVJTpeOmkyW+Dbh6GK3/VdFukvOUBBw3OeNRjQ/aGYrh14q
	 IcNZTfYh2o9Yg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bYJYn0Wbvz4x11;
	Fri,  4 Jul 2025 13:11:08 +1000 (AEST)
Date: Fri, 4 Jul 2025 13:11:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@de.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Thomas Huth <thuth@redhat.com>
Subject: linux-next: manual merge of the bpf-next tree with the s390 tree
Message-ID: <20250704131135.1da6c34d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uJZDkAfq+ILtcqSLTUC/+ev";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uJZDkAfq+ILtcqSLTUC/+ev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  arch/s390/net/bpf_jit.h

between commit:

  42398caf16c9 ("s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi =
headers")

from the s390 tree and commit:

  e26d523edf2a ("s390/bpf: Describe the frame using a struct instead of con=
stants")

from the bpf-next tree.

I fixed it up (the latter deleted the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/uJZDkAfq+ILtcqSLTUC/+ev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhnRmcACgkQAVBC80lX
0Gx+1Af/cwbu4s3JWbpJGDK5eExNhF2ULcsDI3C6WJk/dVck6AnCaHLUiKlnoUcm
WgVVzJ3f73OwyRwnrjk1INabmdmUtm1/6RaUZHeETqbz2pfTGrVlKPfCKuHMpc5i
MkiuybVXMHuI0Pyk/79QoGDx8ckG5oubCefiDZPvwwa9JPstVkxnlu9WJOW97/4N
LYO98igB6MecgAO2f6EEGqNjE2qkF8lJmCDpl3+YA6ExILoRoeS3iPGYGSW09U1a
H3uVsrhuF96K04/o2CNJZ7ZQyOHbLeTja3lXf8ffC60V6AlApZLJCr/0sQEzmhT2
CWY/yw7Dp6vrBOT31MXdOeUZFdKWdQ==
=j7L0
-----END PGP SIGNATURE-----

--Sig_/uJZDkAfq+ILtcqSLTUC/+ev--

