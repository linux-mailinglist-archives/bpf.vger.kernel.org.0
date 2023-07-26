Return-Path: <bpf+bounces-5911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1F762DF1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6129B281C95
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7809463;
	Wed, 26 Jul 2023 07:38:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F18829;
	Wed, 26 Jul 2023 07:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A88C433C8;
	Wed, 26 Jul 2023 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690357101;
	bh=MxlSMvIY/Wra0hNDTsfaKX0G5b7LTUom63ialjShl6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuiBQXryh8/svbI1KdFVu88IjU8h2tqCaglsN/L4+IGNTMlHinFJlZ8gw7yonPpBP
	 qmE0DUQduHa5S5rI4NG0h4IigDqItxH54iB9ZBfHCzvf9J5RddZVuHbTs12c69vygk
	 ysEWENyYD8Ee/MXCMv9Xr6Vlm2MESdK6sIBnNfntdnMC2ehh+sovSCq5uV3JOBptWO
	 HdBzRkpIBS5ALfrxyigoa+8O1LmIR7jDWMTCD4StHhOh8uMW3dWMhpLdqGf38btmcW
	 HPlJ0PN4EgdKvP+479zpbLCbZUPjp37pZkZOO20CdxvxhDKjzhwtoAEUwfeEubgnHP
	 wBpOv0cYkZxHQ==
Date: Wed, 26 Jul 2023 10:12:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230726071254.GA1380402@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>

On Fri, Jul 21, 2023 at 02:52:14AM +0200, Daniel Borkmann wrote:
> On 7/20/23 5:06 PM, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be s=
tatic
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17ac9ffaa80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D32e3dcc11fd=
0d297
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D14736e249bce4=
6091c18
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D133f36c6a=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a8e73aa80=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/d=
isk-03b123de.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmli=
nux-03b123de.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041=
/bzImage-03b123de.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
>=20
> Thanks, I'll take a look this evening.

Did anybody post a fix for that?

We are experiencing the following kernel panic in netdev commit
b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/=
pub/scm/linux/kernel/git/tnguy/next-queue

 [  935.131864] ------------[ cut here ]------------
 [  935.133223] WARNING: CPU: 7 PID: 32248 at kernel/bpf/tcx.c:114 tcx_unin=
stall+0x158/0x1a0
 [  935.135408] Modules linked in: act_tunnel_key vxlan act_mirred act_skbe=
dit cls_matchall nfnetlink_cttimeout act_gact cls_flower sch_ingress bondin=
g mlx5_vfio_pci vfio_pci vfio_pci_core vfio_iommu_type1 vfio mlx5_ib mlx5_c=
ore ip6_gre ib_ipoib nf_tables rdma_ucm ib_uverbs geneve ip_gre gre ip6_tun=
nel tunnel6 ipip tunnel4 ib_umad iptable_raw openvswitch nsh xt_conntrack x=
t_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat =
br_netfilter rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib=
_cm rpcsec_gss_krb5 auth_rpcgss oid_registry ib_core overlay zram zsmalloc =
fuse [last unloaded: ib_uverbs]
 [  935.141679] CPU: 7 PID: 32248 Comm: devlink Not tainted 6.5.0-rc2_net_n=
ext_mlx5_89edf40 #1
 [  935.142577] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS re=
l-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [  935.143758] RIP: 0010:tcx_uninstall+0x158/0x1a0
 [  935.144297] Code: f0 fe ff ff ba 4c 00 00 00 48 c7 c6 e7 33 27 82 48 c7=
 c7 c0 32 27 82 c6 05 5c 0a 3d 01 01 e8 4f a7 e8 ff 0f 0b e9 ca fe ff ff <0=
f> 0b eb 9d 44 0f b6 35 45 0a 3d 01 41 80 fe 01 0f 87 f6 8b 91 00
 [  935.146192] RSP: 0018:ffff8881eb853928 EFLAGS: 00010202
 [  935.146789] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000=
000000
 [  935.147548] RDX: ffff8881066f2808 RSI: ffff888106c40000 RDI: 0000000000=
000000
 [  935.148328] RBP: ffff8881066f2808 R08: 0000000000000001 R09: 0000000000=
0003fe
 [  935.149081] R10: 0000000000000001 R11: 00000000fa83b2da R12: 0000000000=
000001
 [  935.149847] R13: ffff8881066f2808 R14: dead000000000122 R15: dead000000=
000100
 [  935.150490] FS:  00007fa48de38800(0000) GS:ffff88852cb80000(0000) knlGS=
:0000000000000000
 [  935.151213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  935.151753] CR2: 00007fa48dd7b1e0 CR3: 0000000125f06002 CR4: 0000000000=
370ea0
 [  935.152378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
 [  935.153000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
 [  935.153620] Call Trace:
 [  935.153918]  <TASK>
 [  935.154194]  ? __warn+0x79/0x120
 [  935.154545]  ? tcx_uninstall+0x158/0x1a0
 [  935.154936]  ? report_bug+0x17c/0x190
 [  935.155320]  ? handle_bug+0x3c/0x60
 [  935.155686]  ? exc_invalid_op+0x14/0x70
 [  935.156088]  ? asm_exc_invalid_op+0x16/0x20
 [  935.156499]  ? tcx_uninstall+0x158/0x1a0
 [  935.156896]  ? tcx_uninstall+0x57/0x1a0
 [  935.157287]  unregister_netdevice_many_notify+0x32f/0x960
 [  935.157790]  unregister_netdevice_queue+0x8d/0xe0
 [  935.158236]  unregister_netdev+0x18/0x20
 [  935.158630]  mlx5e_vport_rep_unload+0x30/0x90 [mlx5_core]
 [  935.159221]  esw_offloads_unload_rep+0x24/0x40 [mlx5_core]
 [  935.159777]  mlx5_eswitch_unload_vf_vports+0x7a/0xc0 [mlx5_core]
 [  935.160358]  mlx5_eswitch_disable_pf_vf_vports+0x15/0xa0 [mlx5_core]
 [  935.160953]  esw_offloads_disable+0xe/0x60 [mlx5_core]
 [  935.161469]  mlx5_eswitch_disable_locked+0x15a/0x180 [mlx5_core]
 [  935.162058]  mlx5_devlink_eswitch_mode_set+0xad/0x380 [mlx5_core]
 [  935.162637]  ? devlink_get_from_attrs_lock+0x9e/0x110
 [  935.163108]  devlink_nl_cmd_eswitch_set_doit+0x60/0xe0
 [  935.163579]  genl_family_rcv_msg_doit.isra.0+0xc2/0x110
 [  935.164086]  genl_rcv_msg+0x17d/0x2b0
 [  935.164460]  ? devlink_get_from_attrs_lock+0x110/0x110
 [  935.164936]  ? devlink_nl_cmd_eswitch_get_doit+0x290/0x290
 [  935.165436]  ? devlink_pernet_pre_exit+0xf0/0xf0
 [  935.165880]  ? genl_family_rcv_msg_doit.isra.0+0x110/0x110
 [  935.166381]  netlink_rcv_skb+0x54/0x100
 [  935.166769]  genl_rcv+0x24/0x40
 [  935.167109]  netlink_unicast+0x1f6/0x2c0
 [  935.167496]  netlink_sendmsg+0x239/0x4b0
 [  935.167901]  sock_sendmsg+0x38/0x60
 [  935.168265]  ? _copy_from_user+0x2a/0x60
 [  935.168654]  __sys_sendto+0x110/0x160
 [  935.169023]  ? handle_mm_fault+0xe4/0x270
 [  935.169422]  ? do_user_addr_fault+0x270/0x620
 [  935.169849]  __x64_sys_sendto+0x20/0x30
 [  935.170232]  do_syscall_64+0x3d/0x90
 [  935.170600]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 [  935.171075] RIP: 0033:0x7fa48dd1340a
 [  935.171438] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f=
 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
 [  935.172982] RSP: 002b:00007ffcd3a8a498 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000002c
 [  935.173683] RAX: ffffffffffffffda RBX: 00000000008eeb00 RCX: 00007fa48d=
d1340a
 [  935.174296] RDX: 0000000000000038 RSI: 00000000008eeb00 RDI: 0000000000=
000003
 [  935.174913] RBP: 00000000008ee910 R08: 00007fa48df37200 R09: 0000000000=
00000c
 [  935.175532] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
000000
 [  935.176166] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000=
000001
 [  935.176790]  </TASK>
 [  935.177060] ---[ end trace 0000000000000000 ]---

Thanks

