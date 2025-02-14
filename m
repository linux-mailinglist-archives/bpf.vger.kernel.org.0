Return-Path: <bpf+bounces-51523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B94A35678
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F6516B0E2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D618A6D7;
	Fri, 14 Feb 2025 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a7z1IruK"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8938DD8;
	Fri, 14 Feb 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511654; cv=none; b=JmT33tcbWl0Sn19c8NQFEne4sBJ4Xu6bJAiYAO3zghUfOAPT4l/SZkYE657yNl7SGvssPSV0qN7B2meOVZVmen1PCic91XC3zgnpKab+kHySmgWeBvSUh3aJLim90uxBIg+mA5UgDOJZK5C4Y4FyHX48dlly+YD2Ye3C48OqQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511654; c=relaxed/simple;
	bh=Jnmb9v8B62Ir3HXtOoo4/AOPVXEplpHdI7M5yCxr3H0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2Z3AYkfpePpq+5fP1e8T5ezJ3hOXmQrT9/+4UVhTVOg41ZkDJWB5N08dz3YkfyxCtwrpZxjzdJ9+j6hwS/WfKKxF+mKQCYas3rS2XpI5v9XX/2/CwnB51s3hIKXbhnI/0Qrq1kQ+Mt0LZ0EgyBmQsY2RgyzSGaecpe781FyPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=a7z1IruK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1739511648;
	bh=+MXpRCfyPu68EMKR4hGNZHlKqujUVXXYRHPgYvj99U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a7z1IruKuvW3S2s3rmxahVyAcfHCPMZiD6WvVPlr0dJBYbWrRvN+6TwqV1xZ9rTOI
	 iNDI/xhmd0/8Ux5LvAEkXaQXz1/B9T0tpk6yLrv1PIm4Uv2CWTaXqfueoY08rgUKbf
	 3a3xoqOFM7JqJj2p3+KhYzrVOO+Qb1Pt9SlruiAyA0ypir9p5XnaTJU606ZgkK73MF
	 V7OXfiVgWlMYX+yfS20Lzs2J1grsIK65aPjdgX4J33GW+AFwgD+o7fPtOZFK+hXttq
	 KNsa+zRZzhtiko/sthuUF5P3qfAEKfBY8J7DYQONXgb52sHKEy6Ox0OE0MkmUaFo+9
	 XO6GXblFZhXkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YvLW4150rz4x2J;
	Fri, 14 Feb 2025 16:40:47 +1100 (AEDT)
Date: Fri, 14 Feb 2025 16:40:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20250214164046.31cc51af@canb.auug.org.au>
In-Reply-To: <CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>
References: <20250214160714.4cd44261@canb.auug.org.au>
	<CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oHSxmttZ6MrA+_yjnn=t6L3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oHSxmttZ6MrA+_yjnn=t6L3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Thu, 13 Feb 2025 21:33:11 -0800 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> what should we do ?
> I feel that moving c83e2d970bae into bpf tree would be the best ?

Just remember to mention the conflict to whomever merges the bpf-next
tree towards Linus' tree.  Its a trivial conflict.  Or merge the bpf
tree into the bpf-next tree if you feel that you need the bug fixes in
the bpf-next tree as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/oHSxmttZ6MrA+_yjnn=t6L3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmeu114ACgkQAVBC80lX
0GwmFAf/YSbuHFbUHbi2sgfMDQsDEXIcOnpueFbasGwGxUEe7HPwJEPp7SUWAIa8
vUcp4NCTZ8bDnO0RUiPJL3VggaD4thapwXY1RHqffTLOVaRWWReyIwnhUPsX+aZn
KwJVoXGwhNkZ2nlMI/FZKl5eNclWzfyousyqFt1sFbTcIi5a9Bl5Q/JlccvVNAPK
IRRuSo5YaPhe/jYTWbWC+ykyJ6+8mgmlm3BXW9zg5i8FW3xwe5xyHDs1Y4q7Yf5g
cwWTWh62tXq3f8bPjsCwqWUrI6clR7IGmsj5rQTQBpMU5zMDKU2kFAt431K5NbM+
Ty4c6wdi7OqH47PjIuBuy8ACnPGgsw==
=OOqT
-----END PGP SIGNATURE-----

--Sig_/oHSxmttZ6MrA+_yjnn=t6L3--

