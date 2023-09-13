Return-Path: <bpf+bounces-9855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04779DEAB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 05:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFC1C20D09
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 03:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68CEDC;
	Wed, 13 Sep 2023 03:34:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893065A;
	Wed, 13 Sep 2023 03:34:40 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3A125;
	Tue, 12 Sep 2023 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1694576077;
	bh=Dy9uoHunOxBUhL2lOo0mUbBiUZ+oUaTiLsVFylkoPbQ=;
	h=Date:From:To:Cc:Subject:From;
	b=piMKBqFnBW2rxtAwIlETdgFgk4YpJiyl+QYOkTT0G/dJI/T3UhZdDyGkdJAwW/weu
	 02h3SXWir6FmOKhdRVW0lZAkUo0euxAxm+75ztK4SAX4uRGxaVS8AJ06AW7xmX8Tr7
	 zE9TogB9NWJpCRVfpVb7RLnVhhI2pzPJ/LYYMBcuLVAUEvE8ofnk+8h8LhLLkyMsV8
	 pbbipfVxB/BQPAahm5bPHj48E50GFLByWUrPMv1kp5kacA1U33ya2OCn31j2CfK1jH
	 7HHIuiozuMaaBVA5h94kQrarKnmTptIg2bkQ7lfxbkiQoZpdrzRQ0zxwFKObwjNURX
	 PNQCKyCMOMkuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlmKT42vdz4wxn;
	Wed, 13 Sep 2023 13:34:37 +1000 (AEST)
Date: Wed, 13 Sep 2023 13:34:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: boot warning from the bpf-next tree
Message-ID: <20230913133436.0eeec4cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2nhR/XrgbpD/A2lo9BdBFyW";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2nhR/XrgbpD/A2lo9BdBFyW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next boot tests (powerpc pseries_le_defconfig) produced
this warning:

 ------------[ cut here ]------------
 bpf_mem_cache[0]: unexpected object size 16, expect 96
 WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+0x4=
10/0x440
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-04964-g2e08ed1d459f #1
 Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000=
004 of:SLOF,HEAD pSeries
 NIP:  c0000000003c0890 LR: c0000000003c088c CTR: 0000000000000000
 REGS: c000000004783890 TRAP: 0700   Not tainted  (6.6.0-rc1-04964-g2e08ed1=
d459f)
 MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000280  XER: 0000=
0000
 CFAR: c00000000014cfa0 IRQMASK: 0=20
 GPR00: c0000000003c088c c000000004783b30 c000000001578c00 0000000000000036=
=20
 GPR04: 0000000000000000 c000000002667e18 0000000000000001 0000000000000000=
=20
 GPR08: c000000002667ce0 0000000000000001 0000000000000000 0000000044000280=
=20
 GPR12: 0000000000000000 c000000002b00000 c000000000011188 0000000000000060=
=20
 GPR16: c0000000011f9a30 c000000002920f68 c0000000021fac40 c0000000021fac40=
=20
 GPR20: c000000002a3ed88 c000000002921560 c0000000014867f0 c00000000291ccd8=
=20
 GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000010=
=20
 GPR28: c0000000011f9a30 0000000000000000 000000000000000b c00000007fc9ac40=
=20
 NIP [c0000000003c0890] bpf_mem_alloc_init+0x410/0x440
 LR [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440
 Call Trace:
 [c000000004783b30] [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440 (unre=
liable)
 [c000000004783c20] [c00000000203d0c0] bpf_global_ma_init+0x5c/0x9c
 [c000000004783c50] [c000000000010bc0] do_one_initcall+0x80/0x300
 [c000000004783d20] [c000000002004978] kernel_init_freeable+0x30c/0x3b4
 [c000000004783df0] [c0000000000111b0] kernel_init+0x30/0x1a0
 [c000000004783e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
 --- interrupt: 0 at 0x0
 NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
 REGS: c000000004783e80 TRAP: 0000   Not tainted  (6.6.0-rc1-04964-g2e08ed1=
d459f)
 MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
 CFAR: 0000000000000000 IRQMASK: 0=20
 GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 NIP [0000000000000000] 0x0
 LR [0000000000000000] 0x0
 --- interrupt: 0
 Code: 3b000000 4bfffcbc 78650020 3c62ffe7 39200001 3d420130 7cc607b4 7ba40=
020 386382f0 992a1e24 4bd8c631 60000000 <0fe00000> 4bffff40 ea410080 3860ff=
f4=20
 ---[ end trace 0000000000000000 ]---

Presumably related to commit

  41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")

(or other commist in that series) from the bpf-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2nhR/XrgbpD/A2lo9BdBFyW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUBLcwACgkQAVBC80lX
0GwoWAf/WS/cy+zGeUOhFGGy4ClkfDlQdz+7voGFOfLXmfowWgVau3QTv3+XXr5c
B8uLvoxuS0EJfcZw5/4l2qPnYcl3UyTXTfRAOdVpZlGz2FZIhPGzizrcg5FdPCxc
0PeDPG8sVklwVOFfQ8N+ZN/9xhWbV5lTt3miYo2wtMaWPSTRxl7/2l9dpvr8wVSR
zePaC6s2dGTIrzSZ0mqbd7fEjyUmt3fcRC16bh3WdRYk6cwBqPfQt9Gmbl61/lna
x8n62LU7WpcYEQIHU6ZM0E2STDabPmK9MAX9UFem9lxzIu3XFlQuUNQvlhsEl7J+
QJIa2LvwFF0jZYbHSfBTo0oLsx3dcA==
=HIPp
-----END PGP SIGNATURE-----

--Sig_/2nhR/XrgbpD/A2lo9BdBFyW--

