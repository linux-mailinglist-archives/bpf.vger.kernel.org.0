Return-Path: <bpf+bounces-47686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F69FDBCF
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19207161A19
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349F18B46E;
	Sat, 28 Dec 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RVWtGLyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271D2111
	for <bpf@vger.kernel.org>; Sat, 28 Dec 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408862; cv=none; b=mhluJGswS4U7x1FKq3uZKzYjs3KTqEybGuO0o8nLhE0NyviwE3vF4QjpENYpZaCnzHmhHn2MtMXQ7/BjuVlegCiY+HwK5zzz7Q4F+tbKn1UpPS5PabURN7lUauTjKI65MivSPw9Ep2iu8F7qC9H9UJtWEEXnvf7LeMD4e77ohM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408862; c=relaxed/simple;
	bh=xZZlX136M1U1/RIpLsfe8GB76Wp9kOWatRvJuMtWhMI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Aa+3nFQ9CO06/iOOg3RUj8xTN7qNTq917PTQZ22k4g5oiJqcLOqM5F9lHMpTAGiYVFkrp5sYmDb1iztVHSUQeITKSyFoYN2OkFEfvHb5p7K0ZzxQyGDHmDIYVHTgCD8nIu4t8boEjFne4MqowowurG6Q/FU1wHPKcD91L6KjzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RVWtGLyS; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735408855; x=1735668055;
	bh=/wTsBFqgSQdInXSya0vTG0Kxn3CJmdb/QApsN1g/pxI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=RVWtGLyS4dHN7n+k447HyExCNI/aB7qgw6jukwVtTRvyY3md+BrsEoNe9E6oov+b0
	 jSHwop5ws24u+U73tnP+R/79uEMCXhngn1h0mIxpXgasgyzzbc4W9OAfXZ+jOcy0Tj
	 seXrdBegY/o6ydRXh0Z4xT0pjOCUhz8S1zTAriEMWii0vBkTMLZta59CFGwGVN+83u
	 ANIOYpqC8EfyBt10qDoN91DHvGBXX9PK8oxKnbXU5pHRVxUsnww2qX/FFH6ZCep0RU
	 6UWr5RxbiePmoHLH97Igl3FSuttf7jRIhD8JLMP4Y0cUGJMubJDFDuOAS1+faqIofc
	 FTa/wzviO103w==
Date: Sat, 28 Dec 2024 18:00:48 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Andrei Enache <andreien@proton.me>
Subject: [PATCH v2 bpf-next] bpf: Use non-executable memfds for maps
Message-ID: <eTid-pMaxx4d_gMkyFN6fgVGub01RRJYIl1SzTmRG7RtRlPUJOMrVfe2I1W8s0OBHBFy3UN2WGm_e6mak0nGcrZ4ZdxAYRUSDDcUSVMvNA4=@proton.me>
Feedback-ID: 46877017:user:proton
X-Pm-Message-ID: 23de1dfb87eb4c543a3adb93ef4e44af2869afe2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------54623a82819daa5e37fb6e2b160d50569290472b08931ffc40ad50b9871f65ac"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------54623a82819daa5e37fb6e2b160d50569290472b08931ffc40ad50b9871f65ac
Content-Type: multipart/mixed;boundary=---------------------31de881ffae5e84a515470eec0a919b8

-----------------------31de881ffae5e84a515470eec0a919b8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

This patch enables use of non-executable memfds for bpf maps. [1]
As this is a recent kernel feature, the code checks errno to make sure it =
is available.

---
Changes in v2:
- Rebase on dad704e
- Link to v1: https://lore.kernel.org/bpf/6qGQ7n8-hGVRUbVaU4K2NOdK93nEC-Yt=
b1ZCWhJyHoeIJgs0plTiTHLLQ8ghWSxjdhsu7VRiTD8SSqEW0eJyssE0FGOp4fn3wNG7TS-jsq=
8=3D@proton.me/

[1] https://lwn.net/Articles/918106/
[2] =



Signed-off-by: Andrei Enache <andreien@proton.me>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5..490b41e2d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1732,11 +1732,22 @@ static int sys_memfd_create(const char *name, unsi=
gned flags)
 #define MFD_CLOEXEC 0x0001U
 #endif
 =


+#ifndef MFD_NOEXEC_SEAL
+#define MFD_NOEXEC_SEAL 0x0008U
+#endif
+
 static int create_placeholder_fd(void)
 {
 	int fd;
+	int memfd;
+
+	memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC | MFD_NO=
EXEC_SEAL);
+
+	/* MFD_NOEXEC_SEAL is missing from older kernels */
+	if (errno =3D=3D EINVAL)
+		memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC);
 =


-	fd =3D ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOE=
XEC));
+	fd =3D ensure_good_fd(memfd);
 	if (fd < 0)
 		return -errno;
 	return fd;
-- =


2.47.1
-----------------------31de881ffae5e84a515470eec0a919b8--

--------54623a82819daa5e37fb6e2b160d50569290472b08931ffc40ad50b9871f65ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJncDzDCZDqw+/Aif2onkUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnWJp2RigL/Tl8gnGZI3TfuctTsQtUsR3djW2U
Q/e3pVoWIQSLXhaG+wc35eodSKjqw+/Aif2ongAAJSkP/i9q5TDAKa1v5JRw
OPVjQX5coDG0Hm92enjcG+WiGjAGB/Z3lK9Hjmv3vsF+I1SiYaxf1N8+/T8M
J7b8A3Iuiv1ZZKXFvve1SjOLCV4E9KgCIPDiXdvZVycl1bMLF65Aap1Hsp7W
btg0Bm3Tad5xNbGjn0MhAD6EyxGYVziOGpd3g8vlQd1mWu91RFXCMDloBHv6
iidjt+w/WnHH5FZnV753IPUaw3xAgmy4N6Pn6YNC+G+Rb785x+mSAiwdYMuZ
gMydBIgq/d41F3cEhyB10gsl/nqMVNitcr+o/zPXk5s1nhHThxS3vRFovftK
mBGiLbAByennG7MS7q3mX+9lc51eDEPXMYBPcaRMCOZswUEu5r+aoyh24z5Q
8oe21bA0ZlDPjJimQ2+ho9cuB3ssj0u7r+phBLwJnI04LK1wUzJjfFs7KLwB
iC/hQHo0PBhSbtepOe5Ig3+LGQwXmtWQuhGS1h7VYi52A2pRqQ1dsrGODSnB
vIaKlX/K5ef67ypVM0eSmT1YygjuqYvP6lcuTZSePtqlwEjYRaiYWThmR4KP
a6KiYZh0OU2NGXlduNeA4qkq7gZPxEf8D8t9zetWtyUfPa5Avc6nkcnud0vi
ioiTaPUadRPmjwKrfHN4R9SL9izTEEmT7GzHwa7zUTSMLsGT07NDuLdiObCa
zpelg567
=jeZc
-----END PGP SIGNATURE-----


--------54623a82819daa5e37fb6e2b160d50569290472b08931ffc40ad50b9871f65ac--


