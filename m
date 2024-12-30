Return-Path: <bpf+bounces-47698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9789FE960
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45082161443
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1B1ACEA2;
	Mon, 30 Dec 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Dn3XCvXo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1C10F2
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579126; cv=none; b=LawhKc3tHevr468PmB//nWB+Egn6fPpk88LKzRbfQsFPhsXGjbqkfTnPiJ3POO02AMc5lEnfjo+DB9Q2Hs5dUGsDCPxzxd98kbgWxCyX+ur7he3RWmMxaeksjasO4r3wo1w/YwDw/0VCjpdknq8kWpPsW0qhvZBxshOmxkvYTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579126; c=relaxed/simple;
	bh=gmVQpRLhBhD5cBRg5VxIsVcG+RBx1LjCTYMpAk7pJMw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=O+CWw+ZNZjjfkyvJsHFJqu6z9N7VzC+f4irzX+bTwPRtl+uZGC9HKN716Jn/6rbmmilSeMXtsDa8v8JxkVAqI3v1rTt/XAcF0i6sxQtsopHmturSAw8aL0qLzF3TuZRZRTbTYc/dwgR4P0vZ5mabT5qHoi6CTUaz6Sy0BFJ4BXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Dn3XCvXo; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735579116; x=1735838316;
	bh=fXmGm0P51qgdBHCRQBDsTCun9g+/gEtVFdtEF3QHJKM=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Dn3XCvXoaBhpCLeGVL5wSgF4XutcTeVWtZbms2WsGf9m0IO/q9UESmAJgiocBpde5
	 MOLVuwmW1Yn4xsKzTf9iuNzmgsREfN0LguFu8R74zdEs2TUZzfoMDggRoV1kxFpCRA
	 uJ74IVZf8mJOf0J+scp670kO+xGpSXZ9bU2XHLo7OAZa8kN2If/weMiu/15UEsPTZO
	 6R2Fvg12/yjtfIJhTzdOO3xEb1xUu7Gf6p8psEzKEZtlgznxVMWzf1eFPZRhf2Kw4V
	 qW+NWKZfnIZn7BnrzA05uyjBpfAsRgQs6R1Qp2FFWG1wYJNJdCwi3lNbiVXbBrKT5v
	 vlUAbt8HWe3Vw==
Date: Mon, 30 Dec 2024 17:18:31 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Andrei Enache <andreien@proton.me>
Subject: [PATCH v3 bpf-next] bpf: Use non-executable memfds for maps
Message-ID: <2NK63_D3A4XK54XvOAywlNwXaq6bq2I2nc2nU9g-YVdEkYaPPKcbcQ3RI0yRDc65N2LmtEx1e2aWDKXS0BabHqkihS2gtXBcghhwM5TfDeE=@proton.me>
Feedback-ID: 46877017:user:proton
X-Pm-Message-ID: 89cbd2046b5b5a8a89a82095bbb140c099087b20
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9e0cd62b888e972d92cf9c35648088067600e5ef620bb85c30271462d5481750"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9e0cd62b888e972d92cf9c35648088067600e5ef620bb85c30271462d5481750
Content-Type: multipart/mixed;boundary=---------------------552c16eb2f04116f605a2e26fe1cfd6d

-----------------------552c16eb2f04116f605a2e26fe1cfd6d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

This patch enables use of non-executable memfds for bpf maps. [1]
As this is a recent kernel feature, the code checks at runtime to make sur=
e it is available.
---
Changes in v3:
- Check return value before checking errno
- Update newline style
- Link to v2: https://lore.kernel.org/bpf/Z3LHcCgqY7kHs08S@krava/T/

[1] https://lwn.net/Articles/918106/

Signed-off-by: Andrei Enache <andreien@proton.me>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5..3a30c094d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1732,11 +1732,22 @@ static int sys_memfd_create(const char *name, unsi=
gned flags)
 #define MFD_CLOEXEC 0x0001U
 #endif

+#ifndef MFD_NOEXEC_SEAL
+#define MFD_NOEXEC_SEAL 0x0008U
+#endif
+
 static int create_placeholder_fd(void)
 {
 	int fd;
+	int memfd;
+
+	memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC);
+
+	/* MFD_NOEXEC_SEAL is missing from older kernels */
+	if (memfd < 0 && errno =3D=3D EINVAL)
+		memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC | MFD_N=
OEXEC_SEAL);

-	fd =3D ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOE=
XEC));
+	fd =3D ensure_good_fd(memfd);
 	if (fd < 0)
 		return -errno;
 	return fd;
--
2.47.1
-----------------------552c16eb2f04116f605a2e26fe1cfd6d--

--------9e0cd62b888e972d92cf9c35648088067600e5ef620bb85c30271462d5481750
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJnctXYCZDqw+/Aif2onkUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnQMz+fOwLe7bNtI4kYuCaNnnC2OPCZmNkGtqH
jhmAf5kWIQSLXhaG+wc35eodSKjqw+/Aif2ongAAduAP/3ovudCvFdgaHaZe
rgGkl+9b0sW+A9QrYUf8ie0Y9KiraAJCDrVqC20Y9OAUHRK5ZlCN/cFx72aA
wvWzAVDrqaFUTdLBjOeFA9Sx4SkSLMFCvSjJbV8kqajnugK0QGlqypsa7dp3
4rL15eMZLtAM67UGzspzY2zdrhe0enGVVVV8QyWCOf6iI6xuFp5XvF1+B6ap
Via6usDTuGXEXQzbkhCVv48oUusuX6ZGBP2KfJXQLAI0RYNDpH+O4I4puzlz
Iv0RU5FndPAbDmNofU+2yErcJq6wsb79AX0LwrC0qDXIrXAoI6BBFxPWSgDn
Bk7fqvskuWhLimlD89tg9gKYtWJUhNkydkkFVgZtDP/5feoOhd0ZPyuji1tK
6GUGs+M6gg/DQkhAUkWAy5B/g2p8voDqcvxrMet1eh2Dzm9LONQTcpTqnNZ+
eboyDU34jQJJ5L0M+qRhaidQv1946cPE+yAbqVvc4Yfnye5+O1FTvjR59JzZ
BzjoCRCU+8EPO3o3ObUPBwiaevpoBNbuP49dp4r2oCvFsw4HrySAtBK02brJ
sJq0HadK+Kt2AijPbwtyGl4jtknt3NrV5SUKvUyhJB7V6znBoxedcQk3ZawM
oElwbdxXSTFkbPRz0mf5Kve3aF+Q4f3hoqXb0RBFopy43+yvoSZhgBFEAHNS
gh8JN80b
=cibt
-----END PGP SIGNATURE-----


--------9e0cd62b888e972d92cf9c35648088067600e5ef620bb85c30271462d5481750--


