Return-Path: <bpf+bounces-75782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCBC95579
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 23:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA9C94E01BF
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19114247289;
	Sun, 30 Nov 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L7wR2Ldr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EC1B142D;
	Sun, 30 Nov 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764542034; cv=none; b=NXCreQae48NPGQQ25btrfQ8xrxkVfdmkMbvQLUI2SpkkBFCRpckjWd9jBYDGw8Rr7vTvm4xNHJseIEnUB02oxoCOxZKSVvYEWnF25Zkwin8k5fTvF3XzvOX4agatClRcWEIc6ctKEULmdMM/sl5ZK3nOfp4nO7W+tQ8KeviCG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764542034; c=relaxed/simple;
	bh=aI2Fjh0EuTgp06sWFPtjxV496etyQtSHdlELtSsfuUg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z/QL8+11B3Ld4Y90kVEAFXMhN2EG8X4ZejvSBXYUpMmwoRn5luQ9DRMqrheZ/5/B3VMO+nDeAgVhTsKzmHF82x4fFD/Cy4lSuWpvsmi0rDbylEyiHhYR42q6Pkcwmau6tWg3bbaNfQr5jBppYCelcaC53gzyO8R1MRM588rQiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=L7wR2Ldr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1764542026;
	bh=cYbQRbqRxs7AFwZkYvZ2Rbg+w/wWCE2C0/Vz0z8ZdW8=;
	h=Date:From:To:Cc:Subject:From;
	b=L7wR2LdrqrFm62drylRcdgxkzu/nWZWppsHI3WT7ZUqVKI/ih7rT+9MrGsZxmxkTU
	 JX7DxdOy4bHFkHcNIKE/KA2/remMcHEbxTdV4d5ti4evAjYGyO8qSZbKZXj5G2eY2v
	 PF37bQVQWnKQ/iHpmOxiya2vE6Yp27rU9DMnCH5NQZ0vrAlVWxrmGOkDmbqKXROEtA
	 /ooTL4lmu2HMupq2qq2T8I3bGBHn7b8G//IlPS3NZW56cnFvDoC71yG3BY76f6PAEt
	 WxfYwsxBb6VcfLzCSpxwKlMbHR1iciUqM5ysYySRRxPwHHQYyZgcgk4zk9IlGJu3iD
	 +FAzvJnIrBmEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4dKMJT0YCtz4wCm;
	Mon, 01 Dec 2025 09:33:44 +1100 (AEDT)
Date: Mon, 1 Dec 2025 09:33:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Menglong Dong <dongml2@chinatelecom.cn>, Menglong Dong
 <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ftrace tree with the bpf-next tree
Message-ID: <20251201093343.63ef2596@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iS7vxE.ekFe8CJNQF9TLIBJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iS7vxE.ekFe8CJNQF9TLIBJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  kernel/trace/Kconfig

between commit:

  25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")

from the bpf-next tree and commit:

  f93a7d0caccd ("ftrace: Allow tracing of some of the tracing code")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/trace/Kconfig
index 4661b9e606e0,e1214b9dc990..000000000000
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@@ -336,12 -330,20 +336,26 @@@ config DYNAMIC_FTRACE_WITH_ARG
  	depends on DYNAMIC_FTRACE
  	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
 =20
 +config DYNAMIC_FTRACE_WITH_JMP
 +	def_bool y
 +	depends on DYNAMIC_FTRACE
 +	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 +	depends on HAVE_DYNAMIC_FTRACE_WITH_JMP
 +
+ config FUNCTION_SELF_TRACING
+ 	bool "Function trace tracing code"
+ 	depends on FUNCTION_TRACER
+ 	help
+ 	  Normally all the tracing code is set to notrace, where the function
+ 	  tracer will ignore all the tracing functions. Sometimes it is useful
+ 	  for debugging to trace some of the tracing infratructure itself.
+ 	  Enable this to allow some of the tracing infrastructure to be traced
+ 	  by the function tracer. Note, this will likely add noise to function
+ 	  tracing if events and other tracing features are enabled along with
+ 	  function tracing.
+=20
+ 	  If unsure, say N.
+=20
  config FPROBE
  	bool "Kernel Function Probe (fprobe)"
  	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC

--Sig_/iS7vxE.ekFe8CJNQF9TLIBJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmksxkcACgkQAVBC80lX
0GzsYAf/bC8k6CqMic4MYcWrv09d9J/PUzka+bJsjsucLZcdt0WGgZ6Tb02IRJUE
J17ihYlGocqjaIXM82xmGgRfceqLmnjcS81N43bMlxGmjHeho7SsgTtELTZPuWpC
Bywr5095cb6O2QhJrGx1qZ/rRCb5DyzemH0CvcrLouTW+zUA2+mVE9jUj/u7J9CD
G//38nr4L0Z0/RRSGGw0EKD/Qkrx7yfXW+TqwX/BL51331vElW/nou/hhdoRcFR8
PQkMamgEVisiGmFr8Ogmiy7CQfmBLKNLzhl5pF7gPxmeVI3+bQrP3+Cyi8qpd9Z0
7TDmaZ5gTuR41Z2HzZoMk1ZKSOArGA==
=MNus
-----END PGP SIGNATURE-----

--Sig_/iS7vxE.ekFe8CJNQF9TLIBJ--

