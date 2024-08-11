Return-Path: <bpf+bounces-36848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04694E361
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949B12819C7
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3815C157;
	Sun, 11 Aug 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uMkFClxl"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EF11CAB;
	Sun, 11 Aug 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411688; cv=none; b=XGUCmb0GON68Y8e9Rq9iBrD4G43l5lIYSq2MV1x9JDJMwCjiN6eu+j15eZdf4jPStskLIsjqPQM5w5xA/8NobVEvt9D/AvM5MS0GwWv4mSILdZVYTLoO23aWM2+9sp9iLBo+mzch1A3Au8wCh08dlp7ZLlFc/5WPIgfLt8jAc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411688; c=relaxed/simple;
	bh=hK/3+Gzc0DH1gc+/8FerXKv+bLc1g3J/ZqvDYphSfsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TWgEXswOgTyoJ31dQAxGiLf3834+0j0yTsMOIn6cHAlXeF6n+TbkAZxyyasUgtHx0eGsB/bKgWddiHGN6rKtZnObdHAl+y0q1fdY1UzGH4AMEf0hQbpg4FwnUs87ZfWuVAui9fuxpzzp9k18rtVKWKBt2TchALYc/9+wJFFEL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=uMkFClxl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723411684;
	bh=ChN2ORLT70fk7/cAt8tujTgHQmbtR4/dTf3dgFUBMS0=;
	h=Date:From:To:Cc:Subject:From;
	b=uMkFClxlN703989I6uB3tfgWm7o+SOa4c2pcH6zBOPmC7kH8PztxoKIVgmEuB5AJM
	 E4omEsfDB6Vds0ubYiguby8zJrZ9A5xBvDbQnVlgoW2E/IRlu7glgrGZz2fRwsTu3K
	 eIpi3d4FycbhX3O65lEWbRbWm9xqCbLhSmyS88EjSmgAyMnMFQT9ovP/B4mXzxwaLC
	 n8q+vvZyu0IkiOK/KsatBHV9Z3cjup3qwUysYjDmgDDFHNZosELSeB5u63gZ+GrL3t
	 THRebQFMfiwAfAiut1DHPSlMG0eRlapQKsoWuxlKGZAEaU//Khk2FnGqLlggZB6IKM
	 cRwv4vmkidlpQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WhrNN0FLXz4x8N;
	Mon, 12 Aug 2024 07:28:03 +1000 (AEST)
Date: Mon, 12 Aug 2024 07:28:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the bpf-next tree
Message-ID: <20240812072803.78139fba@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Legwrp.uHXHP.JzqwQ4dSIl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Legwrp.uHXHP.JzqwQ4dSIl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  1cbe8143fd2f ("bpf: kprobe: Remove unused declaring of bpf_kprobe_overrid=
e")

This is commit

  0e8b53979ac8 ("bpf: kprobe: remove unused declaring of bpf_kprobe_overrid=
e")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Legwrp.uHXHP.JzqwQ4dSIl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma5LOMACgkQAVBC80lX
0GxfjQf+OXUl2pSD8wBag7YwugkAQNHtBIplXcXpzqis9Cy8IoeRYO5k+slHd6ES
34XYDpOQDzmTnqQtK1dRhhdFTw0vfZ8rFwKRrDr/nf0LQj2X1TFIfr0viRwVBqAI
HnIPFCSSRuaFpcHmpHy6Qf8F08ueNtNVtNQzliYaRn2iUjZDygbTHkhqTsRzrAPj
GWrox/AdocQLRH1mTELulNM+w1biRSpRRRNWtZ3wI81nS4TI9b57Tccob/4iWx5o
59Ck0FuhyMIup2Vx3/z25wRqj+6Uji8r5hXRrfLQ7P/VIqC8T+vIV2LZFwfX6u0V
ZjJxFZNH5voFrZ56R+Wy6nvKk3MT1g==
=dDCl
-----END PGP SIGNATURE-----

--Sig_/Legwrp.uHXHP.JzqwQ4dSIl--

