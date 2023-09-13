Return-Path: <bpf+bounces-9858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B415879DF4D
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B6E1C20E82
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 04:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C8615481;
	Wed, 13 Sep 2023 04:59:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FD659;
	Wed, 13 Sep 2023 04:59:23 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E76172A;
	Tue, 12 Sep 2023 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1694581160;
	bh=BQWQxVgtDq67jRQfNxeUs/YY/NSz0gkDxgXPDiLLg4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ox7p/ixZ4XdLZb7vURtOdqoQjj/ecaEwbncvnBgOqT3tTmsuN0O2a3cMbMyFBquQD
	 TnvHstGG7e/t5hECabxAgouneLH5VM4aExCobQD8N1t/H8lySAmJCB1ljn7wwL4GYc
	 eAbjC8uzV6XsMtxaY4Q7cxpEwpKADca3EvFrxrUamcWh5PpBgEKabXUFVWCAFY4MGj
	 mH1Nb4zHofGCOw1Eiw4E9CBgPT/XSdh1bzPQms6WKGCcISbSgjhmRvIeZwU8aH32HJ
	 ZbI8W36fhtEoo302Pkp958hplz79Ah+aqFlh97kAwlgxMn+kYIEYQXcA9W3HiH53du
	 9egLxkWgDcMyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlpCC68Bmz4wbj;
	Wed, 13 Sep 2023 14:59:19 +1000 (AEST)
Date: Wed, 13 Sep 2023 14:59:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot warning from the bpf-next tree
Message-ID: <20230913145919.6060ae61@canb.auug.org.au>
In-Reply-To: <20230913133436.0eeec4cb@canb.auug.org.au>
References: <20230913133436.0eeec4cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PXHm/nlbskOi1ycBzy=CONu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PXHm/nlbskOi1ycBzy=CONu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 13 Sep 2023 13:34:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next boot tests (powerpc pseries_le_defconfig) produced
> this warning:
>=20
>  ------------[ cut here ]------------
>  bpf_mem_cache[0]: unexpected object size 16, expect 96
>  WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+0=
x410/0x440
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-04964-g2e08ed1d459f =
#1
>  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0=
00004 of:SLOF,HEAD pSeries
>  NIP:  c0000000003c0890 LR: c0000000003c088c CTR: 0000000000000000
>  REGS: c000000004783890 TRAP: 0700   Not tainted  (6.6.0-rc1-04964-g2e08e=
d1d459f)
>  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000280  XER: 00=
000000
>  CFAR: c00000000014cfa0 IRQMASK: 0=20
>  GPR00: c0000000003c088c c000000004783b30 c000000001578c00 00000000000000=
36=20
>  GPR04: 0000000000000000 c000000002667e18 0000000000000001 00000000000000=
00=20
>  GPR08: c000000002667ce0 0000000000000001 0000000000000000 00000000440002=
80=20
>  GPR12: 0000000000000000 c000000002b00000 c000000000011188 00000000000000=
60=20
>  GPR16: c0000000011f9a30 c000000002920f68 c0000000021fac40 c0000000021fac=
40=20
>  GPR20: c000000002a3ed88 c000000002921560 c0000000014867f0 c00000000291cc=
d8=20
>  GPR24: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
10=20
>  GPR28: c0000000011f9a30 0000000000000000 000000000000000b c00000007fc9ac=
40=20
>  NIP [c0000000003c0890] bpf_mem_alloc_init+0x410/0x440
>  LR [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440
>  Call Trace:
>  [c000000004783b30] [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440 (un=
reliable)
>  [c000000004783c20] [c00000000203d0c0] bpf_global_ma_init+0x5c/0x9c
>  [c000000004783c50] [c000000000010bc0] do_one_initcall+0x80/0x300
>  [c000000004783d20] [c000000002004978] kernel_init_freeable+0x30c/0x3b4
>  [c000000004783df0] [c0000000000111b0] kernel_init+0x30/0x1a0
>  [c000000004783e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0=
x1c
>  --- interrupt: 0 at 0x0
>  NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
>  REGS: c000000004783e80 TRAP: 0000   Not tainted  (6.6.0-rc1-04964-g2e08e=
d1d459f)
>  MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
>  CFAR: 0000000000000000 IRQMASK: 0=20
>  GPR00: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR04: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR08: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR12: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR16: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR20: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR24: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  GPR28: 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=20
>  NIP [0000000000000000] 0x0
>  LR [0000000000000000] 0x0
>  --- interrupt: 0
>  Code: 3b000000 4bfffcbc 78650020 3c62ffe7 39200001 3d420130 7cc607b4 7ba=
40020 386382f0 992a1e24 4bd8c631 60000000 <0fe00000> 4bffff40 ea410080 3860=
fff4=20
>  ---[ end trace 0000000000000000 ]---
>=20
> Presumably related to commit
>=20
>   41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
>=20
> (or other commist in that series) from the bpf-next tree.

Actually it looks like it is some interaction between that commit a
commits in the bpf tree.


--=20
Cheers,
Stephen Rothwell

--Sig_/PXHm/nlbskOi1ycBzy=CONu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUBQacACgkQAVBC80lX
0Gwh9gf+NxNxIq7gQtNipwJYuIA0IKO1UYtFeQYprv/zknhJrGIwuBk1/YIolPfF
R1MGdnszYqdVr76FRZ7tODn32QsRAmyus220G6TW9P4JYIeMHrgZ/mF4ji0GsAcV
gF+de4mLrgJlvBVQhdqp04NKR9UmHzluV4kQH/IFTm8QMCBGr91fOC4kEfjvtbKT
FGqpvkR6q0xrzUrnbC+N9sEO6YurXRuQ01clAHEwOx2i2NKGaYURAnIODNG7eJY7
AwZ/FE/lec1Y2jHV8nIKTrJU7WvLgiA+mIbl4fKJOTESUYKCTMOnq4ihb5E9UXJe
aIUyIVPBV41c7EDT6ypCyiQRmj4g3Q==
=8q4r
-----END PGP SIGNATURE-----

--Sig_/PXHm/nlbskOi1ycBzy=CONu--

