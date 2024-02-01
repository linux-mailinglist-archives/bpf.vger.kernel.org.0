Return-Path: <bpf+bounces-20884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1951844F9E
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B452959E2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0AA3A8EB;
	Thu,  1 Feb 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BuN93lZN"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C11DFF3;
	Thu,  1 Feb 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757838; cv=none; b=qPWTrworjfG1x3uaP4SepJ9EpfVDNH49FELaDe0MP8ZAbBwQZ/8ybiZoUkKhQ/2bLXYyKJeCEKxsmxkcuxpY1A+0QItEVw1tdFGOQ3aAUTM9coPUmKzT5ScgoJpcOyal11fuiKYrNs5/AGmaglmizkInj6IN0BFbamtaXEiCmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757838; c=relaxed/simple;
	bh=MtSAE4kQ0ro4PqZ8a9LgEQXVgqNRTt8P4g84Pfbty5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xo3tHxiWFQYp3tTIJWajGjF1j8xqkuUKfFyHrzjIJZC6dZINi/79JbXq5kurpgYzSwgdyihWJptgpSxNnLwKuzp5usjevi2yBUdfABEFzzaTBdN1KUTEqradawCRsd/YEWR6HsTuwbfHQvIVjP/JqTQRTnqcIs1GJvtHjYv6J3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BuN93lZN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706757830;
	bh=N8a0aY25rkscSNwTfJr7k+5fNe2/G4vUIB9/0tfmbHk=;
	h=Date:From:To:Cc:Subject:From;
	b=BuN93lZNU+/EeDebh/JRE2PHFxSu7jMoMrSuWAiNlH37AK93hxJ7PEpcKhc17KVnJ
	 aKBbxDT8P/tu92Z6XuozE64c7OyUc7rD1sLnxm0PjCAJOSvqEAD6zkvCae0OMwSi5f
	 wrp/9/a4xRSnQ1dncjUeB1ZvOGLZJZ2kICCxnAjpKviblW/b8eeiLYm/+tqe5PazP5
	 oo4NQWk8UlYIW7wMEVkFt916peNTburvFFIAym35gSSWa9emaMWUKGHUIBMrJiwYIG
	 hwUh8j/tveLZDbtQl+kxkjONpFsAlwmvHay6irrnZ9JFPhyPo9i5uso1bihEnB4lk4
	 5TGkBWZQ49uBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQPPy1F91z4wd4;
	Thu,  1 Feb 2024 14:23:49 +1100 (AEDT)
Date: Thu, 1 Feb 2024 14:23:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: runtime warnings after merge of the bpf-next tree
Message-ID: <20240201142348.38ac52d5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IdzMCA.1BtKvMaBdA9eqQJZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IdzMCA.1BtKvMaBdA9eqQJZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
pseries_le_defconfig) produced these runtime warnings in my qemu boot
tests:

  ipip: IPv4 and MPLS over IPv4 tunneling driver
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-03380-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c00000000209ba3c CTR: c00000000209b9a4
  REGS: c0000000049bf960 TRAP: 0700   Not tainted  (6.8.0-rc2-03380-gd0c0d8=
0c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 000=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c00000000209ba3c c0000000049bfc00 c0000000015c9900 000000000000001=
b=20
  GPR04: c0000000012bc980 000000000000019a 000000000000019a 000000000000013=
3=20
  GPR08: c000000002969900 0000000000000001 c000000002969900 c00000000296990=
0=20
  GPR12: c00000000209b9a4 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
0=20
  GPR28: 0000000000000000 0000000000000007 c0000000020c10a8 c000000002968f8=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c00000000209ba3c] cubictcp_register+0x98/0xc8
  Call Trace:
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  NET: Registered PF_INET6 protocol family
	.
	.
	.
  Running code patching self-tests ...
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c00000000204900c CTR: c000000002048fe0
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c00000000204900c c0000000049bfc10 c0000000015c9900 000000000000001=
a=20
  GPR04: c000000001218fb0 0000000000000002 c0000000049bfc02 0000000035b5793=
c=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000009e3fcb9=
9=20
  GPR12: c000000002048fe0 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002048fe=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c00000000204900c] bpf_rstat_kfunc_init+0x2c/0x40
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  registered taskstats version 1
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002050fdc CTR: c000000002050fb8
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002050fdc c0000000049bfc10 c0000000015c9900 000000000000001=
d=20
  GPR04: c000000001223600 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000002400024=
2=20
  GPR12: c000000002050fb8 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002050fb=
8=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002050fdc] bpf_fs_kfuncs_init+0x24/0x38
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002050fa4 CTR: c000000002050f80
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002050fa4 c0000000049bfc10 c0000000015c9900 000000000000001=
a=20
  GPR04: c0000000012235e8 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000002400024=
2=20
  GPR12: c000000002050f80 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002050f8=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002050fa4] bpf_key_sig_kfuncs_init+0x24/0x38
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c0000000020517dc CTR: c000000002051790
  REGS: c0000000049bf940 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000422  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c0000000020517dc c0000000049bfbe0 c0000000015c9900 000000000000001=
a=20
  GPR04: c000000001227670 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000002400028=
2=20
  GPR12: c000000002051790 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000122767=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c0000000020517dc] kfunc_init+0x4c/0x110
  Call Trace:
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c0000000003976c8 CTR: c00000000039769c
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000422  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c0000000003976c8 c0000000049bfc10 c0000000015c9900 000000000000000=
0=20
  GPR04: c000000001228d70 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000002400028=
2=20
  GPR12: c00000000039769c c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000039769=
c=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c0000000003976c8] init_subsystem+0x2c/0x40
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002051ed8 CTR: 0000000000000000
  REGS: c0000000049bf950 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000220  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002051ed8 c0000000049bfbf0 c0000000015c9900 000000000000001=
a=20
  GPR04: c00000000122ad08 0000000000000001 c000000004810c00 c00000007fc92c3=
0=20
  GPR08: 0000000000000017 0000000000000001 0000000000000008 000000002400022=
2=20
  GPR12: 0000000000000034 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000122ad0=
8=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002051ed8] cpumask_kfunc_init+0x98/0xf0
  Call Trace:
  [c0000000049bfbf0] [c000000002051e84] cpumask_kfunc_init+0x44/0xf0 (unrel=
iable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  Loading compiled-in X.509 certificates
	.
	.
	.
  netconsole: network logging started
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000000f0099c CTR: c000000000f00970
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000000f0099c c0000000049bfc10 c0000000015c9900 000000000000001=
a=20
  GPR04: c0000000012b12c0 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000000000000=
0=20
  GPR12: c000000000f00970 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000000f0097=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000000f0099c] init_subsystem+0x2c/0x40
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002094ab0 CTR: c000000002094a70
  REGS: c0000000049bf960 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002094ab0 c0000000049bfc00 c0000000015c9900 000000000000000=
3=20
  GPR04: c0000000012b1260 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000000000000=
0=20
  GPR12: c000000002094a70 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000012aef20 c0000000012b126=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002094ab0] bpf_kfunc_init+0x40/0x18c
  Call Trace:
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002094ccc CTR: c000000002094ca0
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002094ccc c0000000049bfc10 c0000000015c9900 000000000000000=
6=20
  GPR04: c0000000012b25e0 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000000000000=
0=20
  GPR12: c000000002094ca0 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c000000002094ca=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002094ccc] xdp_metadata_init+0x2c/0x40
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c000000002095890 CTR: c000000002095800
  REGS: c0000000049bf940 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000282  XER: 200=
00000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c000000002095890 c0000000049bfbe0 c0000000015c9900 000000000000000=
3=20
  GPR04: c0000000012b5938 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 000000000000000=
0=20
  GPR12: c000000002095800 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c0000000012b593=
8=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c000000002095890] bpf_prog_test_run_init+0x90/0xec
  Call Trace:
  [c0000000049bfbe0] [c000000002095848] bpf_prog_test_run_init+0x48/0xec (u=
nreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  modprobe (54) used greatest stack depth: 28336 bytes left
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x68/0x74
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc2-0338=
0-gd0c0d80c1162 #2
  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
  NIP:  c0000000003bfbfc LR: c00000000209bd0c CTR: c00000000209bce0
  REGS: c0000000049bf970 TRAP: 0700   Tainted: G        W           (6.8.0-=
rc2-03380-gd0c0d80c1162)
  MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000242  X=
ER: 20000000
  CFAR: c0000000003bfbb0 IRQMASK: 0=20
  GPR00: c00000000209bd0c c0000000049bfc10 c0000000015c9900 000000000000001=
b=20
  GPR04: c0000000012bcb28 0000000000000002 c0000000049bfc02 fffffffffffe000=
0=20
  GPR08: 0000000000000000 0000000000000001 0000000000000000 c00000000291fb9=
0=20
  GPR12: c00000000209bce0 c000000002b60000 c0000000000110cc 000000000000000=
0=20
  GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
  GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd25=
0=20
  GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c106=
8=20
  GPR28: 0000000000000000 0000000000000008 c0000000020c10b0 c00000000209bce=
0=20
  NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
  LR [c00000000209bd0c] bpf_tcp_ca_kfunc_init+0x2c/0x74
  Call Trace:
  [c0000000049bfc10] [c0000000020c10b0] 0xc0000000020c10b0 (unreliable)
  [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
  [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
  [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
  [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x=
1c
  --- interrupt: 0 at 0x0
  Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bff=
f8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0=
121=20
  ---[ end trace 0000000000000000 ]---
  Freeing unused kernel image (initmem) memory: 6464K

Exposed (and maybe caused) by commit

  6e7769e6419f ("bpf: treewide: Annotate BPF kfuncs in BTF")

--=20
Cheers,
Stephen Rothwell

--Sig_/IdzMCA.1BtKvMaBdA9eqQJZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW7DsQACgkQAVBC80lX
0GwK6wf5AaWtLw0kNLRUntfY2QZiLPlox2O5XTHOu5dOt4ovN6i9r8FXKPb93J4x
XkMQHTy40vJBCKjNIRzr2g+usTiXA32y7+KILBTDUqmFnqyOnpGZHv3uqgobmmuy
ypTHmmsk0hxY8lHF9iWuk7Kj3lA/Jx1Q3dbCVUY82/quoqwX9uQogpSBnt50ILw4
jNfiT/saxIWuL9ln5BUuPyHi+Ib0tDi7wPnwZ+znRM+oGZs7hw3SgOOGkj8JU+b6
q7bcmoNBWTx/aNQ6oCitIsZQMtKjCFVW14OG+js7dqdeovv69VrmLCTVDwF4Wr8T
nTTmK50gHwrOWZrYDD+KQBcylXubow==
=R6IK
-----END PGP SIGNATURE-----

--Sig_/IdzMCA.1BtKvMaBdA9eqQJZ--

