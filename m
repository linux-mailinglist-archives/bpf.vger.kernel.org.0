Return-Path: <bpf+bounces-20991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A884634B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D941C2549B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6F3FE35;
	Thu,  1 Feb 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qVSpZPBa"
X-Original-To: bpf@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A972B9B7;
	Thu,  1 Feb 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825779; cv=none; b=aK4I2sZbD0ZvuBtKvxQ/4EJKYPomZ+ItwF/dg3cCJipQZ2nqW0aHuHiDRgJ5DRWnIWjdm4UOrPxjL6Z9kfru1peCTM24cMq+JEz54rqP6G3oySjntEsOaMjUQ2QYCV3tvLU+Ask7btJQ1dBeBbbhEYvKSRJHwibPBKCk3anzayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825779; c=relaxed/simple;
	bh=hqgtxNp7Iuz1bqpAIGNwcpiwbcRfEKvN3xrRY0SIspc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbjQtppnolDvr/RL0kB7LkPZj0/usMiu7mW+cIerSG3BCWvPZf1H4jnMXFZuEZFP4VIBUR/fjvaEC/hJsIJfpV6xxjv+THvStTEh5qD1Oe0Mt/OnZmUIRR7MmedC4UwarFqlAMcb99hHVv+ScCUbP0V7yWcql5dLBXJIMeIWrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qVSpZPBa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706825774;
	bh=awOmy8WaFgd4i6TyX/ak6oz6bJVoINEscXRUP4mgr+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVSpZPBatu96synLRDz35S2iFHqkqMUoJrQmnf/ahvNShdm1MlFpC5SRzoQwWnpAy
	 9OzRPWed08gi1M3jXRdkCHNrF7Tflt9LYshY5og4mSdoB3oiLLzoaKTHyyQHAz1iNE
	 9ym0GZXmBvzY5Xywbm5FTbWVE4tCDziiXBto7d+SJTc0L67povszqHRM5YrLTAFNN2
	 rN9TfVKHMB0Ex0Ln8dDT+GAwvJUFcjQJ12EU3Kd/VEUMrlXKbtS7et/ZIhJtB+NpnA
	 H2r8EVIUGfPNC74QuAJOX9mLk/ll3F96ocJq+TA5p/aOUNs6ouX1sy5j0JUGLDw4HO
	 U0D/QlTPC7wBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQtXY3rQ0z4wcP;
	Fri,  2 Feb 2024 09:16:13 +1100 (AEDT)
Date: Fri, 2 Feb 2024 09:16:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: syzbot <syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 martin.lau@linux.dev, sdf@google.com, sfr@canb.auug.org.au,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] linux-next boot error: WARNING in
 register_btf_kfunc_id_set
Message-ID: <20240202091612.11b6ebd8@canb.auug.org.au>
In-Reply-To: <000000000000e447290610580f33@google.com>
References: <000000000000e447290610580f33@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F4_GNSjmOCbv4/U/1D_f50v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F4_GNSjmOCbv4/U/1D_f50v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Thu, 01 Feb 2024 12:44:30 -0800 syzbot <syzbot+0e9c9f96dbdc31a8431b@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    51b70ff55ed8 Add linux-next specific files for 20240201
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b05288180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D88d85200b6a62=
126
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0e9c9f96dbdc31a=
8431b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f2d3a98d07e5/dis=
k-51b70ff5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d525430ddf13/vmlinu=
x-51b70ff5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6d1ec0b50066/b=
zImage-51b70ff5.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com
>=20
> greybus: registered new driver hid
> greybus: registered new driver gbphy
> gb_gbphy: registered new driver usb
> asus_wmi: ASUS WMI generic driver loaded
> usbcore: registered new interface driver snd-usb-audio
> usbcore: registered new interface driver snd-ua101
> usbcore: registered new interface driver snd-usb-usx2y
> usbcore: registered new interface driver snd-usb-us122l
> usbcore: registered new interface driver snd-usb-caiaq
> usbcore: registered new interface driver snd-usb-6fire
> usbcore: registered new interface driver snd-usb-hiface
> usbcore: registered new interface driver snd-bcd2000
> usbcore: registered new interface driver snd_usb_pod
> usbcore: registered new interface driver snd_usb_podhd
> usbcore: registered new interface driver snd_usb_toneport
> usbcore: registered new interface driver snd_usb_variax
> drop_monitor: Initializing network drop monitor service
> NET: Registered PF_LLC protocol family
> GACT probability on
> Mirror/redirect action on
> Simple TC action Loaded
> netem: version 1.3
> u32 classifier
>     Performance counters on
>     input device check on
>     Actions configured
> nf_conntrack_irc: failed to register helpers
> nf_conntrack_sane: failed to register helpers
> nf_conntrack_sip: failed to register helpers
> xt_time: kernel timezone is -0000
> IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> IPVS: Connection hash table configured (size=3D4096, memory=3D32Kbytes)
> IPVS: ipvs loaded.
> IPVS: [rr] scheduler registered.
> IPVS: [wrr] scheduler registered.
> IPVS: [lc] scheduler registered.
> IPVS: [wlc] scheduler registered.
> IPVS: [fo] scheduler registered.
> IPVS: [ovf] scheduler registered.
> IPVS: [lblc] scheduler registered.
> IPVS: [lblcr] scheduler registered.
> IPVS: [dh] scheduler registered.
> IPVS: [sh] scheduler registered.
> IPVS: [mh] scheduler registered.
> IPVS: [sed] scheduler registered.
> IPVS: [nq] scheduler registered.
> IPVS: [twos] scheduler registered.
> IPVS: [sip] pe registered.
> ipip: IPv4 and MPLS over IPv4 tunneling driver
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set=
+0x261/0x290 kernel/bpf/btf.c:8131
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240201-syzkall=
er #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> RIP: 0010:register_btf_kfunc_id_set+0x261/0x290 kernel/bpf/btf.c:8131
> Code: 16 e8 b3 fb db ff bd 0b 00 00 00 eb 0a e8 a7 fb db ff bd 0d 00 00 0=
0 89 ef 4c 89 f6 5b 41 5e 41 5f 5d eb 45 e8 90 fb db ff 90 <0f> 0b 90 e9 22=
 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c da fd
> RSP: 0000:ffffc90000067940 EFLAGS: 00010293
> RAX: ffffffff81b7d510 RBX: 0000000000000000 RCX: ffff888016a98000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff81b7d311 R09: 1ffffffff1f0b5bd
> R10: dffffc0000000000 R11: fffffbfff1f0b5be R12: 1ffffffff21e0e1d
> R13: dffffc0000000000 R14: ffffffff8caa77c0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000000df32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  fou_init+0x50/0x110 net/ipv4/fou_core.c:1239
>  do_one_initcall+0x238/0x830 init/main.c:1233
>  do_initcall_level+0x157/0x210 init/main.c:1295
>  do_initcalls+0x3f/0x80 init/main.c:1311
>  kernel_init_freeable+0x430/0x5d0 init/main.c:1549
>  kernel_init+0x1d/0x2b0 init/main.c:1439
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

#syz fix: bpf: btf: Add BTF_KFUNCS_START/END macro pair

This is a new version of a commit in linux-next yesterday.

--=20
Cheers,
Stephen Rothwell

--Sig_/F4_GNSjmOCbv4/U/1D_f50v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8GCwACgkQAVBC80lX
0Gw2XAf6A9pUD0ZTB1Hrnq2WXrpV5IziHYiG71nmLztJ+Amm9ZuRQzLdL/puJBjy
Xw+y+SllbinN7WCc+qjH7kRYrJ1FY7/q2jsoUo7xlL5WlRVdMIqJ5ikTXPDU5eI5
bDOV00g5maC5f3bHVTl+oc+eoB/kqDz/dmRv3NyEIO9q1c8ffNiF+d0O6XMXuWUh
6uv3yp0KkJLAx1dr2cvye0vMoJwmmAVpcBZxnr3anzVs9Gt27o4mimOh4OCFZqFh
nIaHJVQ0nYSTsRCquoQawkGK7RuJ7/jrSoee4p/zzVIxDAdLQtpI/Xe8ZC3bS7Qo
xGtDNOkOuvhunFLhplj5oDZPeydaTQ==
=W/Uh
-----END PGP SIGNATURE-----

--Sig_/F4_GNSjmOCbv4/U/1D_f50v--

