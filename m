Return-Path: <bpf+bounces-7553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95037779257
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5893B282232
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823C29E13;
	Fri, 11 Aug 2023 15:03:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C45692;
	Fri, 11 Aug 2023 15:03:26 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD3124;
	Fri, 11 Aug 2023 08:03:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 368A13200925;
	Fri, 11 Aug 2023 11:03:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Aug 2023 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691766202; x=1691852602; bh=JmeqxHGPGnlBa
	slKrMFWzKJwZxY6feJYwiXE4sSBUg0=; b=vGWVJQ69d+aHct/C6zJ2HKodpjDZ+
	I3EjiF1Qff4/cIQ73b9RRWXWFPSUyiPg/gV8p4WxMSZRRdZdNNj8UfOL0bs01sRe
	DTZK9MMnCO9GLCenBRBP0t0+5Fl5aXvuh1hCChHE082f5gOM2r9GJouj3uYmmvZK
	fzIcA047o6FL/uUQHn9t7FhAB1j1N9uE0XxkKjUE/oNEkBgNYez+zwIrUXUFYylL
	HBOMopTYaFCIBmnqwFEEjvhfGtscgnEseln+KJhC3nWQGwQyWeJRMqcx0Q4CQyHJ
	7NCd8aTGNqfWVUKgcaytC6iCNLiDbcuxc11ihpMBoK8JygIeiHNT4BooQ==
X-ME-Sender: <xms:uk3WZJCxVcmSzqwc1oUkimr5SLOUJ7QZhE_kiWBqglDy2wYSftpNAw>
    <xme:uk3WZHgWuo_KmRzlZ8nIQRXUdmjZ-CUNXFKO0eVh4NDrzeUbGWhPIng05AJ9S2FtF
    GODl_GKN-adb5k>
X-ME-Received: <xmr:uk3WZEm5ayCpv1AuRfeP2LQ1Ti0GUiSiYhx1As4yNK51miXY5JDmAbqp7tJlYtHduBR4ZpI_FNO0irZ4W3Br1wJErRkM5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvhfevffeujefgieehgefhgeeihfekfffhfeetieekjeejieeijedvueffffdv
    vdenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhooh
    hglhgvrghpihhsrdgtohhmpdhgohhordhglhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:uk3WZDzmhPgItcq5HWqCChDBtlUrqFLEXjtsgHgOdtfg-DSZfTcJoA>
    <xmx:uk3WZOSzA7ulUJLF3BcV6ZaK61PmJCgB-ZGDfbUE49criYjU9lwvUw>
    <xmx:uk3WZGYMSQPb1jV2AO5flihUpvI0cMd4hVpPMehZOijcWxTF8rJTkg>
    <xmx:uk3WZHBB4AZ9SnUNlcq07MGvEYKnIbvxrn-6o2DgZVLeZ3H5I4gMBA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Aug 2023 11:03:21 -0400 (EDT)
Date: Fri, 11 Aug 2023 18:03:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: syzbot <syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com>,
	vladbu@nvidia.com
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	hawk@kernel.org, idosch@nvidia.com, jasowang@redhat.com,
	john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	vladbu@nvidia.com, willemdebruijn.kernel@gmail.com
Subject: Re: [syzbot] [net?] WARNING in ip6_tnl_exit_batch_net
Message-ID: <ZNZNs3I20BK7/kmp@shredder>
References: <0000000000009f0f9c0602a616ce@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009f0f9c0602a616ce@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 06:57:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=103213a5a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
> dashboard link: https://syzkaller.appspot.com/bug?extid=d810d3cd45ed1848c3f7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1475a873a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153cc91ba80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz
> 
> The issue was bisected to:
> 
> commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
> Author: Vlad Buslov <vladbu@nvidia.com>
> Date:   Tue Aug 8 09:35:21 2023 +0000
> 
>     vlan: Fix VLAN 0 memory leak

I wasn't able to reproduce using the C reproducer, but I'm pretty sure I
know what is the problem. I wasn't aware that user space can create VLAN
devices with VID 0, which can result in the VLAN driver wrongly deleting
it upon NETDEV_DOWN. Reproduced using:

ip link add name dummy1 up type dummy
ip link add link dummy1 name dummy1.0 type vlan id 0
ip link del dev dummy1

Always adding VID 0 on NETDEV_UP "solves" the problem, but it will
increase the memory consumption for each netdev, which is not ideal. A
possible solution is trying to delete VID 0 upon NETDEV_UNREGISTER
instead of only iterating over upper VLAN devices.

Anyway, Vlad, it's probably best to send a revert while we figure it
out.

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cbf169a80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cbf169a80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cbf169a80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
> Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 12 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
> Modules linked in:
> CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Workqueue: netns cleanup_net
> RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
> Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
> RSP: 0018:ffffc90000117a30 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000070de5201 RCX: 0000000000000000
> RDX: ffff88801526d940 RSI: ffffffff8829a7b8 RDI: 0000000000000001
> RBP: ffff88807d7ee000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffffff81004e11 R12: ffff888018fb2a00
> R13: 0000000000000000 R14: 0000000000000002 R15: ffff888018fb2a00
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005581d741a950 CR3: 000000007deef000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip6_tnl_exit_batch_net+0x57d/0x6f0 net/ipv6/ip6_tunnel.c:2278
>  ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
>  cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
>  process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
>  worker_thread+0x687/0x1110 kernel/workqueue.c:2748
>  kthread+0x33a/0x430 kernel/kthread.c:389
>  ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

