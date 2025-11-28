Return-Path: <bpf+bounces-75708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA1C921F7
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427633A1BEF
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761832E748;
	Fri, 28 Nov 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="ReVJ1faD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703230E0F3;
	Fri, 28 Nov 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336145; cv=none; b=S1PYtZPWyMsUCNS1uNBf0XBuM88FUAgC/6JzdfZAYF1eiqKyGTegNLO2NFQyFpokfGFNqbElXhCvDFzfdHhdgTkUVWgOa1W73yBYz1ihSkRAns0iteWWF+gW477km5Zr5gvBqTrBFfZOvAp92CQDyNoO5g0MrPMMhiRwdfJIY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336145; c=relaxed/simple;
	bh=0duWjTUsbySq3CaYAyrFjiAslVzcsNwSMNp0T9yZa6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOE/skPqHCB/q7va9zj4ApGACiL9CjZNmKrctIGmqFPWETdpjLV0PVtYoDaoFH3vXeFcEQjZT7AmLSRUJ1dzzFHG/1a0OVzLFNdypv0+T3RtzWtosx1ohFQESQxktnpnE3PMLKks8AEtZlp3ABOd48fR+v40ojUktaF5giokJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=ReVJ1faD; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764336141;
	bh=0duWjTUsbySq3CaYAyrFjiAslVzcsNwSMNp0T9yZa6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReVJ1faDtdfMY+5dXYMSdIViHqOUEIto3OdUsmB13sQnWTzMjoyCyQdJXbZbyIYbM
	 170X1PaZ/5bEQQ5mYK6bzVCJ/7P8Tz25DYPsb6lVdAWTdXEXHKdB31SCChpwsel5HC
	 71BxzXXELUn7Cya4aiLTOBy0BmX5V/C0XN69szDiWMXO7ZBB9L5FSCFLPhdYxs4w3j
	 mD+89pPja5NiHjB3WnVCxRIHEFklS1vUuSVEdraVkXKrFohm0Kg1TxtBAntr5bg5uf
	 zk4JtUP8UcXE8Ql/QSAn7G7mOiaMB3IW79+vFpRnu6X2jxzE3S30cV3JcSAi9V/Vn1
	 jlC2RM38YxCBA==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A310B1F9C1;
	Fri, 28 Nov 2025 16:22:21 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 16:22:19 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru.astracloud.ru (rbta-msk-lt-156703.astralinux.ru [10.198.57.41])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHv8V2sZqzJqMr;
	Fri, 28 Nov 2025 16:21:46 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Veaceslav Falico <vfalico@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Moni Shoua <monis@Voltaire.COM>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+9dfc3f3348729cc82277@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jonathan Toppins <jtoppins@redhat.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: [PATCH 5.10 v3 3/3] bonding: restore bond's IFF_SLAVE flag if a non-eth dev enslave fails
Date: Fri, 28 Nov 2025 16:21:26 +0300
Message-Id: <20251128132126.7467-4-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251128132126.7467-1-apanov@astralinux.ru>
References: <20251128132126.7467-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/28 10:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_one_url}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, {Tracking_spam_in_reply_from_match_msgid}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198520 [Nov 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/28 12:43:00 #27986045
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/28 10:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit e667d469098671261d558be0cd93dca4d285ce1e ]

syzbot reported a warning[1] where the bond device itself is a slave and
we try to enslave a non-ethernet device as the first slave which fails
but then in the error path when ether_setup() restores the bond device
it also clears all flags. In my previous fix[2] I restored the
IFF_MASTER flag, but I didn't consider the case that the bond device
itself might also be a slave with IFF_SLAVE set, so we need to restore
that flag as well. Use the bond_ether_setup helper which does the right
thing and restores the bond's flags properly.

Steps to reproduce using a nlmon dev:
 $ ip l add nlmon0 type nlmon
 $ ip l add bond1 type bond
 $ ip l add bond2 type bond
 $ ip l set bond1 master bond2
 $ ip l set dev nlmon0 master bond1
 $ ip -d l sh dev bond1
 22: bond1: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noqueue master bond2 state DOWN mode DEFAULT group default qlen 1000
 (now bond1's IFF_SLAVE flag is gone and we'll hit a warning[3] if we
  try to delete it)

[1] https://syzkaller.appspot.com/bug?id=391c7b1f6522182899efba27d891f1743e8eb3ef
[2] commit 7d5cd2ce5292 ("bonding: correctly handle bonding type change on enslave failure")
[3] example warning:
 [   27.008664] bond1: (slave nlmon0): The slave device specified does not support setting the MAC address
 [   27.008692] bond1: (slave nlmon0): Error -95 calling set_mac_address
 [   32.464639] bond1 (unregistering): Released all slaves
 [   32.464685] ------------[ cut here ]------------
 [   32.464686] WARNING: CPU: 1 PID: 2004 at net/core/dev.c:10829 unregister_netdevice_many+0x72a/0x780
 [   32.464694] Modules linked in: br_netfilter bridge bonding virtio_net
 [   32.464699] CPU: 1 PID: 2004 Comm: ip Kdump: loaded Not tainted 5.18.0-rc3+ #47
 [   32.464703] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
 [   32.464704] RIP: 0010:unregister_netdevice_many+0x72a/0x780
 [   32.464707] Code: 99 fd ff ff ba 90 1a 00 00 48 c7 c6 f4 02 66 96 48 c7 c7 20 4d 35 96 c6 05 fa c7 2b 02 01 e8 be 6f 4a 00 0f 0b e9 73 fd ff ff <0f> 0b e9 5f fd ff ff 80 3d e3 c7 2b 02 00 0f 85 3b fd ff ff ba 59
 [   32.464710] RSP: 0018:ffffa006422d7820 EFLAGS: 00010206
 [   32.464712] RAX: ffff8f6e077140a0 RBX: ffffa006422d7888 RCX: 0000000000000000
 [   32.464714] RDX: ffff8f6e12edbe58 RSI: 0000000000000296 RDI: ffffffff96d4a520
 [   32.464716] RBP: ffff8f6e07714000 R08: ffffffff96d63600 R09: ffffa006422d7728
 [   32.464717] R10: 0000000000000ec0 R11: ffffffff9698c988 R12: ffff8f6e12edb140
 [   32.464719] R13: dead000000000122 R14: dead000000000100 R15: ffff8f6e12edb140
 [   32.464723] FS:  00007f297c2f1740(0000) GS:ffff8f6e5d900000(0000) knlGS:0000000000000000
 [   32.464725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [   32.464726] CR2: 00007f297bf1c800 CR3: 00000000115e8000 CR4: 0000000000350ee0
 [   32.464730] Call Trace:
 [   32.464763]  <TASK>
 [   32.464767]  rtnl_dellink+0x13e/0x380
 [   32.464776]  ? cred_has_capability.isra.0+0x68/0x100
 [   32.464780]  ? __rtnl_unlock+0x33/0x60
 [   32.464783]  ? bpf_lsm_capset+0x10/0x10
 [   32.464786]  ? security_capable+0x36/0x50
 [   32.464790]  rtnetlink_rcv_msg+0x14e/0x3b0
 [   32.464792]  ? _copy_to_iter+0xb1/0x790
 [   32.464796]  ? post_alloc_hook+0xa0/0x160
 [   32.464799]  ? rtnl_calcit.isra.0+0x110/0x110
 [   32.464802]  netlink_rcv_skb+0x50/0xf0
 [   32.464806]  netlink_unicast+0x216/0x340
 [   32.464809]  netlink_sendmsg+0x23f/0x480
 [   32.464812]  sock_sendmsg+0x5e/0x60
 [   32.464815]  ____sys_sendmsg+0x22c/0x270
 [   32.464818]  ? import_iovec+0x17/0x20
 [   32.464821]  ? sendmsg_copy_msghdr+0x59/0x90
 [   32.464823]  ? do_set_pte+0xa0/0xe0
 [   32.464828]  ___sys_sendmsg+0x81/0xc0
 [   32.464832]  ? mod_objcg_state+0xc6/0x300
 [   32.464835]  ? refill_obj_stock+0xa9/0x160
 [   32.464838]  ? memcg_slab_free_hook+0x1a5/0x1f0
 [   32.464842]  __sys_sendmsg+0x49/0x80
 [   32.464847]  do_syscall_64+0x3b/0x90
 [   32.464851]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [   32.464865] RIP: 0033:0x7f297bf2e5e7
 [   32.464868] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
 [   32.464869] RSP: 002b:00007ffd96c824c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 [   32.464872] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f297bf2e5e7
 [   32.464874] RDX: 0000000000000000 RSI: 00007ffd96c82540 RDI: 0000000000000003
 [   32.464875] RBP: 00000000640f19de R08: 0000000000000001 R09: 000000000000007c
 [   32.464876] R10: 00007f297bffabe0 R11: 0000000000000246 R12: 0000000000000001
 [   32.464877] R13: 00007ffd96c82d20 R14: 00007ffd96c82610 R15: 000055bfe38a7020
 [   32.464881]  </TASK>
 [   32.464882] ---[ end trace 0000000000000000 ]---

Fixes: 7d5cd2ce5292 ("bonding: correctly handle bonding type change on enslave failure")
Reported-by: syzbot+9dfc3f3348729cc82277@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=391c7b1f6522182899efba27d891f1743e8eb3ef
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Acked-by: Jonathan Toppins <jtoppins@redhat.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 drivers/net/bonding/bond_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 127242101c8e..0c5bda75dc60 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2176,9 +2176,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			eth_hw_addr_random(bond_dev);
 		if (bond_dev->type != ARPHRD_ETHER) {
 			dev_close(bond_dev);
-			ether_setup(bond_dev);
-			bond_dev->flags |= IFF_MASTER;
-			bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+			bond_ether_setup(bond_dev);
 		}
 	}
 
-- 
2.30.2


