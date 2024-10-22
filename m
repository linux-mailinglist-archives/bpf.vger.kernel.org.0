Return-Path: <bpf+bounces-42718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF59A953A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972481F23C6D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8D8063C;
	Tue, 22 Oct 2024 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nxhCEaAB"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C22A927;
	Tue, 22 Oct 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558940; cv=none; b=RxY0oaF407713pJm2HrjflqihXDU2Yj6QuhB0lPefrrrK+dp7NZMTGsTRrV3Jzj/e3vyrWV77n9ANzwaOK2CUXFuTyPpR9xfMU505c0lLAio55of3nMUO+PJSkbmRZvhQ35RybgbkaCRVFfuBPt6q/G90M0SkNuMkl7vRRj7yxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558940; c=relaxed/simple;
	bh=+uPsrAOcChIVguTREmIEfgaYRyyry6uMqgm7mCev93s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pSLdC8ids9PwiV+Ap3hSJKRxnkOIcKD19yqSQHR7/wU/YhgC/SBooRuj1oKFRTqYNOm6Ky6c0MJMq9k40PC2C0RII95Bu4h6yGJKl7uDf1yAcYjtODNJsUBsDVuB2lPPBx5+AdQAr0LTtGJxPDj54AQynjtuQN1GHNE26zw/B0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nxhCEaAB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729558932;
	bh=GZItvcYPlsFji1zxIwCTQdK4eNnugj/oYP/4HDVcadM=;
	h=Date:From:To:Cc:Subject:From;
	b=nxhCEaABmJP5emfqXYqoWu7OmBRiPfZkpLDd06HaxY6259rLV9RCouXYiaCMiuSL/
	 USSbWULhzFwq60XQNENm7rtXOMoIWze8EQFy+3/uIRabbozoXiUEXkGJt71Lv97Ke3
	 UMV1WsmamA4ysI1W3fhq3rr8hlrhX2GPcjp9XzSct6kUd8AN1MAuLgZVYwtIzJl8HS
	 0hAAU7g1hsSkvYmL7Lu1U2vFal7cMtlJAJKKNZeHgPDFuDMlGnTI2qh+cVwBrMj153
	 0gD7JShRwB8PqQCAgjILCrIEzl2Q1E+iaSS8q+SInCgYnsUao8UIqEaCChh0r3WTJb
	 0ABr3lnQ2+b3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXYmg2LSWz4wb7;
	Tue, 22 Oct 2024 12:02:10 +1100 (AEDT)
Date: Tue, 22 Oct 2024 12:02:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: "Alexis =?UTF-8?B?TG90aG9yw6k=?= (eBPF Foundation)"
 <alexis.lothore@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Simon Sundberg <simon.sundberg@kau.se>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?=
 =?UTF-8?B?cmdlbnNlbg==?= <toke@redhat.com>
Subject: linux-next: manual merge of the bpf-next tree with Linus' tree
Message-ID: <20241022120211.2a5d41ed@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zSLe_0kB=.oReJxYbu9mSw0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zSLe_0kB=.oReJxYbu9mSw0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/Makefile

between commit:

  f91b256644ea ("selftests/bpf: Add test for kfunc module order")

from Linus' tree and commit:

  c3566ee6c66c ("selftests/bpf: remove test_tcp_check_syncookie")

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

diff --cc tools/testing/selftests/bpf/Makefile
index 75016962f795,6d15355f1e62..000000000000
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@@ -154,11 -153,9 +153,10 @@@ TEST_PROGS_EXTENDED :=3D with_addr.sh=20
 =20
  # Compile but not part of 'make run_tests'
  TEST_GEN_PROGS_EXTENDED =3D \
- 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
- 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
- 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
- 	xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
- 	bpf_test_modorder_y.ko
+ 	flow_dissector_load test_flow_dissector	test_lirc_mode2_user xdping \
+ 	test_cpp runqslower bench bpf_testmod.ko xskxceiver xdp_redirect_multi \
 -	xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cfi.ko
++	xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cfi.ko \
++	bpf_test_modorder_x.ko bpf_test_modorder_y.ko
 =20
  TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_multi
 =20
@@@ -301,22 -302,11 +303,24 @@@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF
  $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard=
 bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
  	$(call msg,MOD,,$@)
  	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
- 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) -C bpf_=
test_no_cfi
+ 	$(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
+ 		RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS)	 \
+ 		EXTRA_CFLAGS=3D'' EXTRA_LDFLAGS=3D''
  	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
 =20
 +$(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wild=
card bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
 +	$(call msg,MOD,,$@)
 +	$(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-compilat=
ion
 +	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) -C bpf_=
test_modorder_x
 +	$(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
 +
 +$(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wild=
card bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
 +	$(call msg,MOD,,$@)
 +	$(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-compilat=
ion
 +	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) -C bpf_=
test_modorder_y
 +	$(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
 +
 +
  DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
  ifneq ($(CROSS_COMPILE),)
  CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool

--Sig_/zSLe_0kB=.oReJxYbu9mSw0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcW+ZMACgkQAVBC80lX
0GzFlQf+OxGNSa17pOr41tHcb3O5LScGrLIKKn0lkzNHEp8x6fOIgzPIgN9VvWoS
JXe4xtAjJYD8hHco4Dsx4au7uEG+a0Q8GqjJ++IZu0fdWC9b8tcijGk0Ro63U/XA
w84nY+l8CsNNHtqWvgOsmtpCRM2D0YS18zvREyYILndlsHDbUTw8ck5F8HCa/z9e
4t3ba7U999V2RyDqYv3DOo0mLZ1fweU7kn1LgE67N6IIGIbaxoHNoUQA5U+3UqFZ
DUUKtcHbqjtCh3VPrqCvvXUDQkpErgX3nED1NzWVQOESqOInqM4Cd9YnWpWfV0W5
YQx3+kt5tzUlvgYd7C9csDeHC+wNfQ==
=Apvx
-----END PGP SIGNATURE-----

--Sig_/zSLe_0kB=.oReJxYbu9mSw0--

