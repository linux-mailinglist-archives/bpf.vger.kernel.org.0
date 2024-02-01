Return-Path: <bpf+bounces-20915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D616584508A
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A6B1C2596D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE133C08D;
	Thu,  1 Feb 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b2QCujBS"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCF3BB3A;
	Thu,  1 Feb 2024 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763224; cv=none; b=VHmcED+NQROjzI8YCGro4LgptJrvfksfdhoDCiXA6lHC2LRT4qIl2ojZFpMJgF/7PjMvoJ8qV7+1LdG9M6hConc1TaKkPUOoLEZD2Q7CQogv/peSrK7wA7epRsqG6EwdTsPTW+rbh6yTDa2eb7t3SsOh+4r3HofwMtVs5hqEHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763224; c=relaxed/simple;
	bh=tNDZ84JWSrZ5U3526IgJ8WphlC3VHFF+HXv6u+aq0JI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv8+kOZOsrXptfemNkJbSe6zUcyufS6GFhqfWawe/IM7wOwHC7KSNsTBWJiyCo4mhw5Dxffn3H/K5BuvQjkRRugODtgTyZy2CWjzWOXm6CJy1CEIhS9pAAmdsyRl+Og4ciXk8DC+4GqaUo81CW0Wp611oE6K31HrTZ9fiBVt3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b2QCujBS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706763220;
	bh=tNDZ84JWSrZ5U3526IgJ8WphlC3VHFF+HXv6u+aq0JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2QCujBS9k9CiDJzG+IJu6aiNQoTj298ErkfRz1vvaeDL1GDmeuBZietTyMfAIKGR
	 B2hotHO3ISh1CGoszjMAJL7MZ5au6Ctx+X6goXcpfvGbDFuyMrC/cNHlZVyfeu9Xja
	 SkscrHZ3YRYCt5+i95fNoPHsiRkyJFQaGjy8MTxWo6e2Vg/NI9XzjqKtMqTuS+GqT4
	 iYk2sCgTLmuC1n7VIO/9US64AgHTf0g9on6mbbCX740rtWjNvwykxAET04fASiX894
	 39uvixIaEhpFI/G1P8vgGs9vOsqMcjVX/i+qGYoP9I1fZttSCWdyuwinakXtBWJWlO
	 /LtsHEZ/p1kVw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQRPc3TwXz4wp0;
	Thu,  1 Feb 2024 15:53:40 +1100 (AEDT)
Date: Thu, 1 Feb 2024 15:53:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
Message-ID: <20240201155339.2b5936be@canb.auug.org.au>
In-Reply-To: <yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
References: <20240201142348.38ac52d5@canb.auug.org.au>
	<yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VRbZIguX2oIMQiDNt5d/haW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/VRbZIguX2oIMQiDNt5d/haW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 31 Jan 2024 20:55:43 -0700 Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Stephen,
>=20
> Thanks for the report.
>=20
> On Thu, Feb 01, 2024 at 02:23:48PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the bpf-next tree, today's linux-next build (powerpc
> > pseries_le_defconfig) produced these runtime warnings in my qemu boot =
=20
>=20
> I can't quite find that config in-tree. Mind giving me a pointer?

Its a constructed config ("make pseries_le_config")

$ grep BPF .config
CONFIG_BPF=3Dy
CONFIG_HAVE_EBPF_JIT=3Dy
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
# BPF subsystem
CONFIG_BPF_SYSCALL=3Dy
CONFIG_BPF_JIT=3Dy
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=3Dy
CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy
# CONFIG_BPF_PRELOAD is not set
CONFIG_BPF_LSM=3Dy
# end of BPF subsystem
CONFIG_CGROUP_BPF=3Dy
CONFIG_NETFILTER_BPF_LINK=3Dy
CONFIG_NET_CLS_BPF=3Dm
CONFIG_NET_ACT_BPF=3Dm
# CONFIG_BPF_STREAM_PARSER is not set
# HID-BPF support
# end of HID-BPF support
CONFIG_BPF_EVENTS=3Dy
CONFIG_TEST_BPF=3Dm

> My guess is the config does not enable CONFIG_DEBUG_INFO_BTF which
> causes compilation to use the dummy definitions for BTF_KFUNCS_START().

Correct, see above.

--=20
Cheers,
Stephen Rothwell

--Sig_/VRbZIguX2oIMQiDNt5d/haW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW7I9MACgkQAVBC80lX
0GxwMQf8CdFGOSXVr8l/32od6WIg+985DCrs7EvRaaov37ErHYRs7O5skHP0/AZr
LcW6LHlx4Btp8mGyEVOWp4+i9v5yvp6ZOcT6AzfcCNGE5pfUv/J5Uh4N+Kr3uo8g
KsBZJpxVjv3tsbiJsN6tXuNluxlrTd0cCnKQDkFDhSG4mRAsff03Yia3R1ck67hH
viuMG8p0DHgck5LeXizcY4bv93Rc0B2kmFjFYMAy1V1HWe/sx+ZRBFkacSdXCR9U
303U3mNS5yzNcDP+OWm8cE3VZMxAKZSszYtQ2lg0kVbQ0gSsb9ef/a+ktxRomv81
znBX60FsCLAcHekdxdXQoGE3KiThzA==
=cA6c
-----END PGP SIGNATURE-----

--Sig_/VRbZIguX2oIMQiDNt5d/haW--

