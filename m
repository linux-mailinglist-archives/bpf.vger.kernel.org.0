Return-Path: <bpf+bounces-51521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0585CA35603
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB1188DE7C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56CE185B48;
	Fri, 14 Feb 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qVMgUW2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4B126F0A;
	Fri, 14 Feb 2025 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509642; cv=none; b=FAZVALH6ht1Cq0b3/7QPb/Ab8XGAB2KesAtDyVus0SAoXWPv51/i7CESZiaoScJ+6ZE03Kq/Hv3yBlL6C+WgMQR5iH+te679MBSnHF4zNhC2B3hID4MzGEayPJIJrqT7gq3PZc5WpCDBBfm+/6Xe2mWxJHSF9KsHUxcUZtcxdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509642; c=relaxed/simple;
	bh=KfFGOuc5JjjRIz0Ea0BajMpJsbMdkcnLcBnBwON+Liw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AdHjbBNVXh0gF2VpFqt2VWygmKFdJ0cglymaabm86v8UFMYiWFM/K64t/Yb0JtrsAKAU+/OyANb98Aex527+trFGEa1nI1Y4IVzTGY2ZH1vxOMCUX7Jj4FtQ75Y8+6qiuIO2Lrw30WKCu720IQKyCA2KJGxrw48yJbcVmH8VER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qVMgUW2n; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1739509636;
	bh=Ybl5pjKtAGkp6U3PePyb/EpekVJzwa92J/91S0y7yqo=;
	h=Date:From:To:Cc:Subject:From;
	b=qVMgUW2nq8Qqpti1zAihhZdxcFxWon4c8e/zpmKesw/xFjEkYSnzNttrfy87405JF
	 dly3y4DWtqQhQst1KpzHA5UZ3fWJAJlT0CdJZlhTCMJ18B5y/FmFmX6N0/Uw0M7xaw
	 Y6EpIWKLeD36Y/i/6rT3jHZAMaMMcub1vy7flxoR+5084XXz/Lxf4RlpZMTwtskKM8
	 4skbVy/OXF2uyimqqI99xYwmVeX4dvECDpbTs8CnAXWgKPKwA6bjyWLKjv6/tPMjD/
	 hEn2SX7CZK+b0DzsCGDQ3RYCfFozydynbQUDudSRVEW/tA8NRU0+NRBK6HiPxGf01v
	 1wOI73yhBnoaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YvKmN0Qtxz4x4t;
	Fri, 14 Feb 2025 16:07:15 +1100 (AEDT)
Date: Fri, 14 Feb 2025 16:07:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20250214160714.4cd44261@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WSU/=WLeJHVwI+vzmrU09TM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/WSU/=WLeJHVwI+vzmrU09TM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/btf.c

between commit:

  5da7e15fb5a1 ("net: Add rx_skb of kfree_skb to raw_tp_null_args[].")

from the bpf tree and commit:

  c83e2d970bae ("bpf: Add tracepoints with null-able arguments")

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

diff --cc kernel/bpf/btf.c
index c3223e0db2f5,f8335bdc8bf8..000000000000
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@@ -6507,8 -6505,8 +6505,10 @@@ static const struct bpf_raw_tp_null_arg
  	/* rxrpc */
  	{ "rxrpc_recvdata", 0x1 },
  	{ "rxrpc_resend", 0x10 },
+ 	{ "rxrpc_tq", 0x10 },
+ 	{ "rxrpc_client", 0x1 },
 +	/* skb */
 +	{"kfree_skb", 0x1000},
  	/* sunrpc */
  	{ "xs_stream_read_data", 0x1 },
  	/* ... from xprt_cong_event event class */

--Sig_/WSU/=WLeJHVwI+vzmrU09TM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeuz4IACgkQAVBC80lX
0GzFwQf+KccFBNU+HUJlqoL4MQCl1bRZ4k5FqGnL6ELDAMxV6Uc+neJveJfv3LD/
6jK8CsuRgAsmCBR+c3iYeaB0pJV3jMvsa5TdM93p8lbxzijZzurlLMzFxXaIAT6T
Ua9NqwACzjVLyShGZ4+b221gpbgDd1EuEtz+PEEyrG/KsCjZDWUZtbusbtQBbXOd
/lwwqe62LhOSvHUmI8xta56ZjkOODQS4M17Nwtt10x4yR/QI1h2XUg3P1600sKHL
b4t7tWigH1tgM56a4Rvk3255r5yWrhh1/LY961MndGiWQaJfWTQxXHhwX9cJ19Oe
adrWLbxTeEQBqmo99uWmX7EdadIPXQ==
=CPEF
-----END PGP SIGNATURE-----

--Sig_/WSU/=WLeJHVwI+vzmrU09TM--

