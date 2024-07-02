Return-Path: <bpf+bounces-33594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D491ECB4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316D11C21FF3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE619441;
	Tue,  2 Jul 2024 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OTVYjPCI"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E51C3D;
	Tue,  2 Jul 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719884038; cv=none; b=nOYGq/9rHpkh+8hv2ePfAuBoD6BWX/u7y5T7UacwVhqRVIBoK3fFrW8M9wnU6zmV/kqjrbBQ4tMASvrJrqykQ6Qnzf/ENREqxRWIYb1jt8DlMpyQVM2WTCIcRwEc3ATK2M8lAIWJcNkxVhuaFHT0QGx6ByfeOJ6Fd1i005k/raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719884038; c=relaxed/simple;
	bh=vowYZXT65q4SoLCOan8TdxdPWMkMor5BArZ8G2yzyKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ndmrcEjDsQqYLUAYNC03PmdjJGO5AzlkqQv4ikoKWtjCKkagoBTlXm9A/GFpSW0INz5FaK2lG+7wKx0AknQb4ek9k4+smia7WZdaH4L+mGrdnOcJp3vRrhOpFSHyGPf7EMhi70TD0CWzxlBYm2Lj2v9e8gLRZxG48NTvyGCa5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OTVYjPCI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1719884032;
	bh=osaodmYgkIbzoCaes8lyDNDS1woeaul+AxGca1P9X2M=;
	h=Date:From:To:Cc:Subject:From;
	b=OTVYjPCIGZFqctfouYBuKFXTLa9v0Lng8eTAdrNuLU8I+nRl9n0h1/nmS+6AL11L3
	 l+NQKIr3OyIrjiwHA9UvGYcNXdORtgbyOZ9gzy/NNdK27vLsa4//aFGZpdVbHY/MF/
	 JjTr4R8sBAS+1UxV8dW6Kw60G3ynQ+4huv0VT4vkZwQGtJDN0iCL4IA3p2otCDrAjP
	 5tMPWs+KXtwWsEfu99Zxa/ztWVm/KMyWzXvrugv32xBAm4QFbwoQ1vCttfGUdGGoCJ
	 AIbk5Z2ZqpqCGJwR5OP+B7TFFguI5Dd8fROC+OT0UbxkwlQ2GIF1wQROZLys1yyUwl
	 XMoijzM0RLkTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WClmv4nwfz4wcS;
	Tue,  2 Jul 2024 11:33:51 +1000 (AEST)
Date: Tue, 2 Jul 2024 11:33:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Pu
 Lehui <pulehui@huawei.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: linux-next: manual merge of the bpf-next tree with the risc-v tree
Message-ID: <20240702113350.064e4cf2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qxf6wFMBcWO8I9pCJcUlB8I";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qxf6wFMBcWO8I9pCJcUlB8I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  arch/riscv/net/bpf_jit_comp64.c

between commit:

  51781ce8f448 ("riscv: Pass patch_text() the length in bytes")

from the risc-v tree and commit:

  9f1e16fb1fc9 ("riscv, bpf: Fix out-of-bounds issue when preparing trampol=
ine image")

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

diff --cc arch/riscv/net/bpf_jit_comp64.c
index 7a34e5b44fc4,351e1484205e..000000000000
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@@ -16,7 -16,8 +16,9 @@@
  #include "bpf_jit.h"
 =20
  #define RV_FENTRY_NINSNS 2
 +#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
+ /* imm that allows emit_imm to emit max count insns */
+ #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
 =20
  #define RV_REG_TCC RV_REG_A6
  #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls =
*/

--Sig_/Qxf6wFMBcWO8I9pCJcUlB8I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaDWP4ACgkQAVBC80lX
0GyHlgf/TlrWyrnr237z1aCU4l2mo82xL68CYM+q2r6cLj+9r/dNBM5DBLRbh9mw
io8M83846VBrE63sCavSvy7vXJo2m26Hh4SF9/lGBXNrS9lv0gDp+iA9ET4fZ2Mu
QZm6tYeGqJVi6WKmwVdyt7aWOMA4Xxv8drJrPf+hI1vUNhirA24+WusQ4H+SuVTD
Gug1Lpo+lWtA1od7ozG67LIQ2/6wZx1iIcFDIficMiBgXGEIk8tJkX0I20BS2Ri7
53bjOhbgqWaosTCs5kEoAxTefzjcQuL7sMoQQqkfcWQemAzJbZVnMcfsNJD3BRWP
OWP+298JEB4R0JvDI4deG6aIz3GoCg==
=UI1O
-----END PGP SIGNATURE-----

--Sig_/Qxf6wFMBcWO8I9pCJcUlB8I--

