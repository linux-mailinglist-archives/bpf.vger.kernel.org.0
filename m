Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0D2441CF
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMX6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 19:58:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36198 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgHMX6l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 19:58:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1k6N7F-0002CB-RW; Fri, 14 Aug 2020 00:58:37 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1k6N7F-0025KS-8B; Fri, 14 Aug 2020 00:58:37 +0100
Date:   Fri, 14 Aug 2020 00:58:37 +0100
From:   Ben Hutchings <benh@debian.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, debian-kernel@lists.debian.org
Subject: [PATCH] bpftool: Fix version string in recursive builds
Message-ID: <20200813235837.GA497088@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When bpftool is built as part of a Debian package build, which itself
uses make, "bpftool version" shows:

    bpftool vmake[4]: Entering directory /build/linux-5.8/tools/bpf/bpftool=
 5.8.8.0 make[4]: Leaving directory /build/linux-5.8

Although we pass the "--no-print-directory" option, this is overridden
by the environment variable "MAKEFLAGS=3Dw".  Clear MAKEFLAGS for the
"make kernelversion" command.

I have no explanation for the doubled ".8" in the version string, but
this seems to fix that as well.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e85f101be85..7fbad8cbd171 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -25,7 +25,7 @@ endif
=20
 LIBBPF =3D $(LIBBPF_PATH)libbpf.a
=20
-BPFTOOL_VERSION :=3D $(shell make -rR --no-print-directory -sC ../../.. ke=
rnelversion)
+BPFTOOL_VERSION :=3D $(shell MAKEFLAGS=3D make -rR --no-print-directory -s=
C ../../.. kernelversion)
=20
 $(LIBBPF): FORCE
 	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl8106cACgkQ57/I7JWG
EQnv4Q/+JBl42JWMaObuRplPAljselPNNFU/MtWYn7PogqISR90YiTdRcJFYTdV/
KYNUKmJivosP1TJEyHASV7r1uLByvqZxnSRC4kKgJQ4x5ipsb9x0JQR0SP5K30nC
i09JC4Ih7+/DxG7xIZ7accihSb+ZN9rZIQxCkUjeNBOkEJf7ZT+ifhj6LDfNRIen
iCpksTQvRd7Z7TLJGju180943i+l3HwkfdkmJg/sqYD39zfBRERWaHNxRpa1IuoP
6X/aiKGe3LZAz1LOA+Jq2OJUlRnj1LlAGVSVW88ocBolVf0asJ+c+I9cgrjYdlqz
8j2K6NkpywaigZuXtxOKzazT0N1kDFiLOu5Apo+mgXsSHFzgTxv/O1zzqbEtzsW3
yztMeyvk46Kqp8hfannaQ51YThFchnQEFAfvNGn/jaGpU4Id5GLf7ARSjoehPSD3
frGNjJc4iorjuhM1yGEYF0Zk2kY3BJHIC5BBFsg5gT63bSp+9dD5Zd1UKuVbVic+
yk74+KW5iaLQPWVuXYFRwiNEtU52teLUiQIczmopG2u1OeAIQhyYNCe1B56Ex945
QgzkSlJsMIp56XeGlA4JCD+y8f0VWB44H9HzQ5rADPmnmRr5mJ+5Yl3az8Fzv/2K
yP1Cb3vcjPrRj/mQXKTfJCMJDXR0N0zzWtYMP0xFuer6nEFiOoQ=
=Zqg/
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
