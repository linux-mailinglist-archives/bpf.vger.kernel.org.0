Return-Path: <bpf+bounces-35952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554B94009C
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34618283C41
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24018E756;
	Mon, 29 Jul 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="riS/w9Wk"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7B18A93E;
	Mon, 29 Jul 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289856; cv=none; b=Vszw+LqTlqiFltpeUboSTGApWgmus1N+WIyt6mMpUFxlNJcgh+HonnlrysnT7cGVcy6SkGkb8RgiWy+GESi+nzfxz2Q+TWoep2hkuY3fOrVUcYD5hdzA0YwZr9W3nVChxxixxglFErw3+u0TStJwj/UArOlKjl/JR43kH3tBUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289856; c=relaxed/simple;
	bh=x/FZoS9ZyTq5EvZkFb72FdN2neoz3nrPm5porRzrSVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SQqibjmuL28xeRt/UuqyC/fZQb1lkVDK1+SYuItRSYw2U3jV8uR6+H8duuq+LElEE6wwVr26s7Ml3NYLT/gcT7IIGFkHoNCQgXFyXM9a9A9Ku5+dXi93JNbHlJqiMlq8bo9NP9Pk+WIQTOrxChnRDLRLM28z2KrddxXgy7kXpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=riS/w9Wk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1722289849;
	bh=mBehfmWKYN8yVcEXUpWuUZrPZL3ctRmUNHHR+cZal9U=;
	h=Date:From:To:Cc:Subject:From;
	b=riS/w9WkOotKHF6ycbcRrl/+6PsW9cOX9q461W433LE8vgZFuSHWShBJ4q7GTkal1
	 4ra03s8aDFwvbx/dKbRpR/Vr73RGkp1yTkXDR3ayCLkHwGfwhg93G4w7wtlgSybEm9
	 hVE9y+t78yS1T/n5QOWeoUGDQohuoqDKmybPv1RzlFqBkkhg1asqYFbnn6sgfBDOXb
	 nY/0WGUVS3/MMUmzkEXYAbumKuFlULXgQ1ZfxW/OfNh//98rE0wwUnlROi0xPg5yPY
	 02IT9pJMLEGFm9U3j549MvZav+Jqo6ve9Q5jDRnC10YXtGcpJsu5bnv7udsdRI869U
	 Mw/C09+R1khEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WXsVd3PrBz4x1V;
	Tue, 30 Jul 2024 07:50:49 +1000 (AEST)
Date: Tue, 30 Jul 2024 07:50:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bpf-next tree
Message-ID: <20240730075047.3247884c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cbyiZ7nId9xt4S9EvneLdZz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cbyiZ7nId9xt4S9EvneLdZz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  76ea8f9e0003 ("selftests/bpf: Workaround strict bpf_lsm return value chec=
k.")

Fixes tag

  Fixes: af980eb89f06 ("bpf, lsm: Add check for BPF LSM return value")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")

--=20
Cheers,
Stephen Rothwell

--Sig_/cbyiZ7nId9xt4S9EvneLdZz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaoDrcACgkQAVBC80lX
0GzNPgf+OkzudykqgTkIYY+xP/P6soKv4Sl+pOIubRr9tBMQgrz9y8SPsHeejgnK
TUFaqrUgDoxqvGNlAtmx8JWnk/8BUhAeGsuvaV0U7HgzSZYlo6vh5oX3J4WX2GJE
XjxfnScPJ71LA485js6VrCpbFN+9rC43EsSNr9wDk1Ee9uhvz7AbBNPjVmh3mUS1
6eXTp9Nv7yHQe0hQ3CcH7eynm8SR5xI4OK1vl4gwt4Ji+asviM1IpSaWixMrparF
Mt7FUSX73riy1nzt5hqyo2eir/91XtrGW8WBqczey+qcGd41qkmnxcktGeiHEpaa
NI0rgmudGZWuIy0ZQM9zJL9JitzDDw==
=dDSC
-----END PGP SIGNATURE-----

--Sig_/cbyiZ7nId9xt4S9EvneLdZz--

