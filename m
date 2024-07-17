Return-Path: <bpf+bounces-34972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7E93452C
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9768FB21A68
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717066EB56;
	Wed, 17 Jul 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NkqhUNbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E01878;
	Wed, 17 Jul 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260477; cv=none; b=n8+jaObEyH/pqNlLCvlnfQj34lDxhM9/mydv0ZnepGyryxwMlP/O5rpp1HWjZOgP3+HlFi2jvZVruWIqDO6HX287FA2/Fe1VMqg5qUQq6HYinXImg2b6Suo9KDkY0iJ0hNAUyQ2trysWpGDlP32nunVIVtfYRvKCBbWasACwxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260477; c=relaxed/simple;
	bh=orzb0peVMTNR3GhKTlFAbKIAm9YwEI8zJBlUYCC3WuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QVHZtxJavMq8ixu9Z7Plv222fXGJK62E5PRn1qxGVr4uOla/2REj7fqWMBwm2b+bygpwMqC6/VKYlETfS5EeNEJjSm06TzwY/T6kIGvQSpTC1Sm442284wArNOcmW4U6qsvSMu+k5ytT5KQoYuh0JZTai7UEl3xw20pyJ5RXGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NkqhUNbp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721260469;
	bh=XKKG24LUHfwl+S6Lasz6G9yozksEgNION8fi9ihfAwU=;
	h=Date:From:To:Cc:Subject:From;
	b=NkqhUNbpWVtWzkOx0BkPMwI5r1NPtY4WVHsIvOW3PJAZLrS0YVrgAWd+QEDjL+ccT
	 qwZFdXdossa0xfkPir2aALQ4l9BD3wnFq8x1A/QyzUS0PCCycE7UO0Nx7l3JLiPEh9
	 5eSSdgN6bXwUBI1BwcqhWWQIwf9f+hQ1yo6+1ZgsyCkjq19y3UP5GyoZuMluemRNx9
	 EQerT9EJpRpFK+Q7+EJeTqHV1iji3w87mut8vgKwhu4XE8HGRdYgzmsqTCuV1AQVqg
	 2f4BfA9VeCnPr8JjQtYhuEbTQ54QLrzkxwEmi38DSaxPcyZIpfur4HvmVV0XTflWp5
	 lHW90Dajc/vvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPXps0QZXz4w2Q;
	Thu, 18 Jul 2024 09:54:29 +1000 (AEST)
Date: Thu, 18 Jul 2024 09:54:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the powerpc tree
Message-ID: <20240718095428.56145ce1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//jK+5O_.IB6DwYZQ1hxVMBz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//jK+5O_.IB6DwYZQ1hxVMBz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the bpf tree as a different commit
(but the same patch):

  358492fc426f ("MAINTAINERS: Update email address of Naveen")

This is commit

  afcc8e1ef7bb ("MAINTAINERS: Update email address of Naveen")

in the bpf tree.

Note also that commit

  e8061392ee09 ("MAINTAINERS: Update powerpc BPF JIT maintainers")

from the powerpc tree is almost identical to commit

  c638b130e83e ("MAINTAINERS: Update powerpc BPF JIT maintainers")

from the bpf tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//jK+5O_.IB6DwYZQ1hxVMBz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaYWbQACgkQAVBC80lX
0Gyo2Qf/aP4pe+3KIej3vnuuDJZ0ucpzlphiDpk9T51qRvpQEn51tdj2M82xGRrv
01wigo+s4fb0t/BLDRgnJN2YjN0Y5U3IlBt+yWa1Y2JD9AHl4Ak0hX8uCGuPYJCL
oD9szYrpnGCEYVnQj5KMbHCCmiD5rDSPZMwgBBlOLcARliXg9QD8YdtAv7lyUgZH
Mjp1mpirRDOiAqnA2TsuCNPuUyJody3IwTEaijJpqYI0EaoXbbCFqM+o68avIGNv
ge3MSdP5rRSwFd05C9j4IMEoBJ0GeNEN9tPtUw99MZUM+TevGnTykbneJZcLD6cT
JeNw7oSC0VYsz8V+SIKPWNeR9ixRYg==
=3S5l
-----END PGP SIGNATURE-----

--Sig_//jK+5O_.IB6DwYZQ1hxVMBz--

