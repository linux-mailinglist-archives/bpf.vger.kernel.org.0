Return-Path: <bpf+bounces-71036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4BBE03EA
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8514FF817
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2E26B942;
	Wed, 15 Oct 2025 18:46:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA71DDC07
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554009; cv=none; b=DCX8IHKUusU8j+U0Edj5p1Zb8mGpAv1gJO6TULEtXtU4YrvyYDGbyoiSyZWLm2pVHqtaufIWJBIu06CIQnDyNPOuGAbSebjwuHOFX92xgs3uV90Ls598FB0rFEuezIHvSMfR4xHW7gVFbv2Bfx4QrCak5nK3DF+utyIt7sxSxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554009; c=relaxed/simple;
	bh=2DaIaoIXWN56Be8bR2S9RRLT3aBPlvYLWdZ9/CV3OeQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OTTkTP8DqSzJ2qmR5EKx8CC23HGW/olEwecil9sGHmPL2jbp9gR8nZJ/BkKfhF7/5JlTyJ3ps9d+ZssJA5HaP+PCWWxT+TRcl7xFAQpT4UmIysKlOntataYMnp9VnXPV/Vgrq1f5dAf0ueGyFRUMYBMbc9ZjKJCZ/qrqHHNgvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-927b19c5023so1298822639f.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 11:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554007; x=1761158807;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DS4Sxr0k4RTUlUgBlQ5Ey66j42nijDvXrm5qaLRzbiU=;
        b=Y7HiB8/7w3KizBepmxfObyyXGkYTc6DweI8gsG6LWvl4iwZaoxnAj5o7zp5fHGmDNV
         Y4QWVsceRRUdEmssh91tvBGgLQK7dbuVzXGPWNi58h3syXbp5yqSDLa3oTSIz2sVpgfK
         U1UWSILhaEcZL2AqxxUuHXH/aACTlg+vgmWQ7nd6MnrbhEnhqxafwj5rSiCW/FVrcxLK
         TDslI8c0mD8UJDM3zaAbf7lWGkRWP9m5ThLjqLu4zIyx93mZ5srYtMQdSWAbzCX+B29j
         pLqsip7O9HnTbD3AVj6E58s3BE3vHtRuLbsUqqLAn5Gn3/jtFuKKvhomKIv93qTY4G2c
         Frng==
X-Gm-Message-State: AOJu0YzPzfMvGtJQLOo/xASSXVcYzvTxsls6EbJHS8KmEhtB1yrZeT92
	LWVPF/653jJibJurullaXW4r1ZGRxltVG329AqUJfIrtiVpvUCuyqP1tD3g/KZKG+fZwujQOeET
	NJq8luWOz4UnbtWQn+zTnqFyBb0xUyHMOI8Rm6K09q/XwRH4CnaLPJuXJbtA=
X-Google-Smtp-Source: AGHT+IF1Nhhx8xlXgwy7bHy4Bj/MouB5mfv4Es/HoDZfRYkKDe+frFhndkYR8i0znrnn8O5rkHCRZqvTVzzaQoFlCeUPsA0/6JQL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:42f:991f:60a9 with SMTP id
 e9e14a558f8ab-42f991f6190mr218827185ab.7.1760554007102; Wed, 15 Oct 2025
 11:46:47 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:46:47 -0700
In-Reply-To: <20251015140140.62273-1-daniel@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efec17.050a0220.91a22.02ca.GAE@google.com>
Subject: [syzbot ci] Re: netkit: Support for io_uring zero-copy and AF_XDP
From: syzbot ci <syzbot+ci7c73a60f40f79ce2@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	dw@davidwei.uk, john.fastabend@gmail.com, jordan@jrife.io, kuba@kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, sdf@fomichev.me, toke@redhat.com, 
	wangdongdong.6@bytedance.com, willemb@google.com, yangzhenze@bytedance.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] netkit: Support for io_uring zero-copy and AF_XDP
https://lore.kernel.org/all/20251015140140.62273-1-daniel@iogearbox.net
* [PATCH net-next v2 01/15] net: Add bind-queue operation
* [PATCH net-next v2 02/15] net: Implement netdev_nl_bind_queue_doit
* [PATCH net-next v2 03/15] net: Add peer info to queue-get response
* [PATCH net-next v2 04/15] net, ethtool: Disallow peered real rxqs to be resized
* [PATCH net-next v2 05/15] net: Proxy net_mp_{open,close}_rxq for mapped queues
* [PATCH net-next v2 06/15] xsk: Move NETDEV_XDP_ACT_ZC into generic header
* [PATCH net-next v2 07/15] xsk: Move pool registration into single function
* [PATCH net-next v2 08/15] xsk: Add small helper xp_pool_bindable
* [PATCH net-next v2 09/15] xsk: Change xsk_rcv_check to check netdev/queue_id from pool
* [PATCH net-next v2 10/15] xsk: Proxy pool management for mapped queues
* [PATCH net-next v2 11/15] netkit: Add single device mode for netkit
* [PATCH net-next v2 12/15] netkit: Document fast vs slowpath members via macros
* [PATCH net-next v2 13/15] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
* [PATCH net-next v2 14/15] netkit: Add io_uring zero-copy support for TCP
* [PATCH net-next v2 15/15] netkit: Add xsk support for af_xdp applications

and found the following issue:
WARNING in netif_get_rx_queue_peer_locked

Full report is available here:
https://ci.syzbot.org/series/19b5990a-1eef-44da-a6f0-ffb03bd8adff

***

WARNING in netif_get_rx_queue_peer_locked

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      18a7e218cfcdca6666e1f7356533e4c988780b57
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/7583f7f3-9e92-4fe2-85f2-761655062852/config
C repro:   https://ci.syzbot.org/findings/75520448-5da8-4fc1-817b-a6c9e4d487e1/c_repro
syz repro: https://ci.syzbot.org/findings/75520448-5da8-4fc1-817b-a6c9e4d487e1/syz_repro

UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5959 at ./include/net/netdev_lock.h:17 netdev_assert_locked include/net/netdev_lock.h:17 [inline]
WARNING: CPU: 1 PID: 5959 at ./include/net/netdev_lock.h:17 netif_get_rx_queue_peer_locked+0x2f1/0x3a0 net/core/netdev_rx_queue.c:71
Modules linked in:
CPU: 1 UID: 0 PID: 5959 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:netdev_assert_locked include/net/netdev_lock.h:17 [inline]
RIP: 0010:netif_get_rx_queue_peer_locked+0x2f1/0x3a0 net/core/netdev_rx_queue.c:71
Code: 6c 7e f8 eb 08 e8 3f 6c 7e f8 45 31 f6 4c 89 f0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c6 1c 0d 02 cc e8 20 6c 7e f8 90 <0f> 0b 90 e9 a9 fd ff ff 48 c7 c1 90 44 9e 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003f17ab0 EFLAGS: 00010293
RAX: ffffffff894127e0 RBX: ffffc90003f17b60 RCX: ffff8881709cba00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f4df8a7 R09: 1ffffffff1e9bf14
R10: dffffc0000000000 R11: fffffbfff1e9bf15 R12: dffffc0000000000
R13: 0000000000000001 R14: 1ffff920007e2f6c R15: ffff8881b1832000
FS:  0000555580884500(0000) GS:ffff8882a9d0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555580884808 CR3: 00000001ba58c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 xsk_reg_pool_at_qid+0x20b/0x630 net/xdp/xsk.c:159
 xp_assign_dev+0x115/0x760 net/xdp/xsk_buff_pool.c:181
 xsk_bind+0x473/0xf90 net/xdp/xsk.c:1407
 __sys_bind_socket net/socket.c:1874 [inline]
 __sys_bind+0x2c6/0x3e0 net/socket.c:1905
 __do_sys_bind net/socket.c:1910 [inline]
 __se_sys_bind net/socket.c:1908 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1908
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb19bd8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd789e00a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fb19bfe5fa0 RCX: 00007fb19bd8eec9
RDX: 0000000000000010 RSI: 0000200000000180 RDI: 0000000000000003
RBP: 00007fb19be11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb19bfe5fa0 R14: 00007fb19bfe5fa0 R15: 0000000000000003
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

