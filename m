Return-Path: <bpf+bounces-62217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99399AF684D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 04:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F113B2776
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9BF1AA1D5;
	Thu,  3 Jul 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YF4iyGWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF3EEBA;
	Thu,  3 Jul 2025 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511091; cv=none; b=XlCICLlCrskJt6yedpPMFjKgHxQzG1QOotZBlZ785p2sX6zZ/ps5tJJ0oHLuHo+BGf+9LQCwhfsbNm8KWJdMxGTWgknUJZmJ/ypMpcCB8j8hLbFmYAswnwl8ggoGUI+IG/3ENzTVkFzlCwAP/zmb+C6ZAb1IzceOMmh/3O58Y3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511091; c=relaxed/simple;
	bh=8W7KpWdMaIiQg2iObW8SfTHbpPj7vW5/o4e77fqeV6I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t+U8jSWegdIcfaDGLS4zOy/P3Zogn4ChUJdlUi1Du8udDD2N2BKa+EIwrL0w6zizk7leecCADdYog4PsQIBOrYo+J6nFSGKLN9nnRXvVNeXBRGgJeqZQSGkjqpU/SmrEdO4LcRmMjy+ZQeni+D1oUW1A3tNE4zmKYj4Cl9LR4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YF4iyGWh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751511063;
	bh=HwgCr4UaBtbJSmmcK7ifa1Jw1DlFKiK/NCJFmbPjCPU=;
	h=Date:From:To:Cc:Subject:From;
	b=YF4iyGWh3HVZO6ky/qw4pthQjLSd4ClgDYlvFTUl6KsmboIKov3T5D58MN3An546M
	 7c+pEiZFAW1Gy4LigY1P9gWnSztowRrbYxZJno2gBpJ2xw0IJFP5Gan4HJgqfbbKb+
	 suLsFZXFccHHL3WyQNw7fdkjE23GxyhTrwJMbyBqZsQGm3DWce/ZBLWA2Z9zzTDqb5
	 tVTkM158RVAihwFX3va6nOwUodEt8UEsd12U9xZdMSn0fyMW7ra+lRCjbQ1NN6hEk6
	 8ezs7+w3cA1pA+ZT+D80feOKLkp0mjD8CVvCB+P050Pvi5lYglKFGqNVvExE/bxhXt
	 XmZMKsXkUCL0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bXh9300pVz4wxJ;
	Thu,  3 Jul 2025 12:51:01 +1000 (AEST)
Date: Thu, 3 Jul 2025 12:51:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bpf-next tree
Message-ID: <20250703125121.2f34c015@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tmOAMKdyi2i3/ON3pYRcFO.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tmOAMKdyi2i3/ON3pYRcFO.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the vfs-brauner tree as different
commits (but the same patches):

  f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xattr")
  1504d8c7c702 ("bpf: Mark cgroup_subsys_state->cgroup RCU safe")
  535b070f4a80 ("bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgro=
up's node")

These are commits

  21eebc655b0f ("selftests/bpf: Add tests for bpf_cgroup_read_xattr")
  5bc9557c9f17 ("bpf: Mark cgroup_subsys_state->cgroup RCU safe")
  b95ee9049c93 ("bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgro=
up's node")

in the vfs-brauner tree.

These duplicates are causing unnecessary conflicts.

The previous commit in both trees is not quite identical.

--=20
Cheers,
Stephen Rothwell

--Sig_/tmOAMKdyi2i3/ON3pYRcFO.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhl8CkACgkQAVBC80lX
0GzFxAf9HegHwqGUyAvK6g01Csp7ye/ewIkp51mjuySHB2rn54HcggUA9V11PpwE
0TufMupaVfTKNVRo8cq6+GAX2bW7pQj2yTuWdVnd4xu4Di213AprYmLeYvLCjQku
Y4h53F1jEDeKH3VFiCkgNmxl3e0njGwjpT8uEPLVhUaG9cH/BJUiTJ1cUXmNvaps
2IqJjtVMaX5o02jE5StHTg5SVinY7qbBd7huK8bpkRdcvT7TGJHaYDuvWuLBVl4K
tNLMhgnlLB26cAnFLtsLwyfLaqzVX6R3Tc/9iQC0dr06dKB7sHxnrBTyIbBkWvEy
hkvlg6moBs3qUrxo9DhnGcLQ8Gpkjw==
=S9FW
-----END PGP SIGNATURE-----

--Sig_/tmOAMKdyi2i3/ON3pYRcFO.--

