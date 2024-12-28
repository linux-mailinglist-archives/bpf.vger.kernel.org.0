Return-Path: <bpf+bounces-47685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6159FDBB3
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3DC1882662
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C04166F07;
	Sat, 28 Dec 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b2n+VcSW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956132744D
	for <bpf@vger.kernel.org>; Sat, 28 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735403977; cv=none; b=RhMS4jRzgwgmVpF7mUVUaTjapOvV6m7+1wggYZHU1FbzXID+ssq4dI/B7wid8V9cfTLeeEezU+/GJud1AxTRNKj9db1+8GurX0gHdOVZqyDZRRTChM9yslFV5OF2WUYOxLziWUZhQu4Y8axNmLA5L7vS/rTMKeva17H7F8X55gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735403977; c=relaxed/simple;
	bh=HG+4RQjZ/cMRg9lXiDhqckUmbME18WI0HdHLMcdMhdc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=owqjSMNTj/zeogDM3odslWjm/HBkdIYCm/qdf+NIq/Vb49W1+CjfqdQ42y/bqtUoKf5U99F47j5w96oYT2En/vFaX/nrAij2h9erps+daDZjxUl4zqQ66spPOfdF0P0KoQ62kPqU3P4oNrRimlGg4p3xZbsuKEJx2yMlVjbHQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b2n+VcSW; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xokottflwraypny4jxbupgon5e.protonmail; t=1735403973; x=1735663173;
	bh=iClUQrDKuK2L2rymLWAGi156zYTSfkRy4BnCAdGDA2o=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=b2n+VcSWNDbxefFYAUGKKeKuBGiy1qqVPZwwdH3SWYHrSBy4dxK0jg199HJZEPUfS
	 GgkmMPexk14zAywVAr5gaVubEnXM6iCOFrr/x9HZDDnl+m+gV8Pln01Sx4A8QzkcmF
	 JmQKTrso6msVLKTRw5//DkzsvGADagak3UmzRtd+Wd/9v2mFetLwjuZyKhPpdBOx9C
	 m5ConeUAy5RxC/VXtOLSdf4tXDOXKUX6326y7eAuQKMD4apY6ij4OF4ZxheIiowT/I
	 dxXu78MfZnhsT4gIrHUimRVBagPsImXskaXeOE2nadePOz3BGUDTrHWc2BvFQA4Oww
	 LT6IHhwIYE/jg==
Date: Sat, 28 Dec 2024 16:39:30 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Andrei Enache <andreien@proton.me>
Subject: [PATCH bpf-next] bpf: Use non-executable memfds for maps
Message-ID: <6qGQ7n8-hGVRUbVaU4K2NOdK93nEC-Ytb1ZCWhJyHoeIJgs0plTiTHLLQ8ghWSxjdhsu7VRiTD8SSqEW0eJyssE0FGOp4fn3wNG7TS-jsq8=@proton.me>
Feedback-ID: 46877017:user:proton
X-Pm-Message-ID: 1ada9794c1d5c68d7e66172cc59f267244210765
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------49263a6fe6775a6a6f95638b07c6b37b3a9b701d9c44a1bfbf470da50a5a4670"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------49263a6fe6775a6a6f95638b07c6b37b3a9b701d9c44a1bfbf470da50a5a4670
Content-Type: multipart/mixed;boundary=---------------------490d92e8b107cfc103798e9dab7fed26

-----------------------490d92e8b107cfc103798e9dab7fed26
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

This patch enables use of non-executable memfds for bpf maps. [1]
As this is a recent kernel feature, the code checks errno to make sure it =
is available.

[1] https://lwn.net/Articles/918106/

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
+       int memfd;
+
+       memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC | =
MFD_NOEXEC_SEAL);
+
+       /* MFD_NOEXEC_SEAL is missing from older kernels */
+       if (errno =3D=3D EINVAL)
+               memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CL=
OEXEC);
 =


-       fd =3D ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MF=
D_CLOEXEC));
+       fd =3D ensure_good_fd(memfd);
        if (fd < 0)
                return -errno;
        return fd;
-- =


2.47.1
-----------------------490d92e8b107cfc103798e9dab7fed26--

--------49263a6fe6775a6a6f95638b07c6b37b3a9b701d9c44a1bfbf470da50a5a4670
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJncCmyCZDqw+/Aif2onkUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3Jnm+fBIDwWeSeJspQqiDBdjaKr+I6cU+01pFUm
fdh06bEWIQSLXhaG+wc35eodSKjqw+/Aif2ongAAB1AP/ApcN4mEqEaS7+hd
l+VobckUH5sAEhf9vVH1RR4dvj3GqZtnOMGQF47IPewfhFzLKWgpEGfL59ES
J5p/hm4B5+VKBr5H8qUBkQaEyCnNlLYY96+8u5ncYqN1fGOMrwWwKYGS8Sec
RdFJ2whkg1pF7XZ8vf5ZoDLdTqymZj2IyvRRfn543jUE+FgQ88t7WUzpqETv
+dinxmXwPQhakK8pp7UMY5/P8JUNkQy8VecEGdU2INzH19+b4dkh1PrLqdqi
1dMsNhikXhuBVTi4ky+xhE0cfXW7oyQWkZF0cU+a3YzUFrnwrGXAIF47w4XW
jNUk6XnwzqMPcN8e8qdg0tCFILUCZ2D98nBGJat1+L5h/cnHyiy62Ghw4ht6
k4jkTnCTX38WjrBhfNcGWyA9s6JcL42ODwBKT2fZCMzXN70H1PBV99wdJRsO
FFerJzngn2JvWgv/OFrm7Dc8+BbXNdTWDLUB564D8mVs69y0bxoHxv8SqiTo
i3LdCcNEP1LRbeTwBPwH4le/KjQwZ+OzGINXiKq0U62o7upp2uiBBAFJE9eA
f/utL2LURSI72Fnv081RHmT1tVE7GQEqgiLaptGljZZ4ado/sdYFkW+01tAD
nqqoeAdEI++BdU7O7zLv6ICFjJE3I7776Lbg9d6soBWF4czxM+x9pDC3ds0h
mY8l3SfZ
=5C3V
-----END PGP SIGNATURE-----


--------49263a6fe6775a6a6f95638b07c6b37b3a9b701d9c44a1bfbf470da50a5a4670--


