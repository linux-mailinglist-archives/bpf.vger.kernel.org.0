Return-Path: <bpf+bounces-75702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6EC92181
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F79A3AE9C5
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6632E698;
	Fri, 28 Nov 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="r7jsnc6K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE052B9B7;
	Fri, 28 Nov 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335769; cv=none; b=TkcvzmTOgUmBZtwRjrVlCEhjZLB/jXYh9aVZa72viksirfbl9xbpY3ibZ7027m47oXAeVmpvLO7pNCNYGXSowVupAWx/mMbfDJL7Llw3KTpwPSLcIiaGbIA2BIMvqHviftaEhZgsq74mf/Oe6xz2nrqZiZdLFuEOXWmrCMVTRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335769; c=relaxed/simple;
	bh=6g7T2l9HW0KB/0B3LjK4bBlF1RgsQst32tmCQPSoqZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcwaGScnJFVf+T3hsvAvE/CIftEYLmHmC4dBalMOBy6locZg54HtrWEtKU7RURoKiNP/wAtgQZctDEeuv8LAQEbbxRe28zLMUrac0h9ggrIpWP1EXLp2yWftsyxdeeYHkDr9pFX6JE9tRLLlfXoDTY0B2ZE4h+RRAmOukRCR4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=r7jsnc6K; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764335764;
	bh=6g7T2l9HW0KB/0B3LjK4bBlF1RgsQst32tmCQPSoqZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7jsnc6KrtjCs5mi5hc4jTL2esqGYzUmLP0IHmAEFIzRdyWhh/Zn8q0V1TJ4dUYPa
	 sW/C5hIEpZOblJFCrPCtqF+4joUkxwLSPjAxyU8kLaPpIjyTlhhRh7hdf/Ph2POG54
	 OyYWTQX8Qug1wmM6bE+CqHvliSLPLTUDClPxdM4RFD7unz+LE5iuc22T+azXzCEuxD
	 4g/lTGBr71WU8/MD9ofXfwWwhpMVQltvOrPK8rlh6/feqWSzz2gTHE2s61js2q2IoR
	 Pp6b1JbHRlG0HV1cUX2Q/uBpSk+0xq8qr051yKPDf03V2TITRADCotPqbnl27Giruk
	 5bqhBsrY0Lf+g==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 3443E1F97D;
	Fri, 28 Nov 2025 16:16:04 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 16:16:03 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru.astracloud.ru (rbta-msk-lt-156703.astralinux.ru [10.198.57.41])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHv1r592rzwPGy;
	Fri, 28 Nov 2025 16:16:00 +0300 (MSK)
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
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Ido Schimmel <idosch@nvidia.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: [PATCH 5.10 v2 2/3] bonding: Fix memory leak when changing bond type to Ethernet
Date: Fri, 28 Nov 2025 16:15:36 +0300
Message-Id: <20251128131537.4241-3-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251128131537.4241-1-apanov@astralinux.ru>
References: <20251128131537.4241-1-apanov@astralinux.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, {Tracking_spam_in_reply_from_match_msgid}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198520 [Nov 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/28 10:03:00 #27985542
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/28 10:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit c484fcc058bada604d7e4e5228d4affb646ddbc2 ]

When a net device is put administratively up, its 'IFF_UP' flag is set
(if not set already) and a 'NETDEV_UP' notification is emitted, which
causes the 8021q driver to add VLAN ID 0 on the device. The reverse
happens when a net device is put administratively down.

When changing the type of a bond to Ethernet, its 'IFF_UP' flag is
incorrectly cleared, resulting in the kernel skipping the above process
and VLAN ID 0 being leaked [1].

Fix by restoring the flag when changing the type to Ethernet, in a
similar fashion to the restoration of the 'IFF_SLAVE' flag.

The issue can be reproduced using the script in [2], with example out
before and after the fix in [3].

[1]
unreferenced object 0xffff888103479900 (size 256):
  comm "ip", pid 329, jiffies 4294775225 (age 28.561s)
  hex dump (first 32 bytes):
    00 a0 0c 15 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81a6051a>] kmalloc_trace+0x2a/0xe0
    [<ffffffff8406426c>] vlan_vid_add+0x30c/0x790
    [<ffffffff84068e21>] vlan_device_event+0x1491/0x21a0
    [<ffffffff81440c8e>] notifier_call_chain+0xbe/0x1f0
    [<ffffffff8372383a>] call_netdevice_notifiers_info+0xba/0x150
    [<ffffffff837590f2>] __dev_notify_flags+0x132/0x2e0
    [<ffffffff8375ad9f>] dev_change_flags+0x11f/0x180
    [<ffffffff8379af36>] do_setlink+0xb96/0x4060
    [<ffffffff837adf6a>] __rtnl_newlink+0xc0a/0x18a0
    [<ffffffff837aec6c>] rtnl_newlink+0x6c/0xa0
    [<ffffffff837ac64e>] rtnetlink_rcv_msg+0x43e/0xe00
    [<ffffffff839a99e0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff839a738f>] netlink_unicast+0x53f/0x810
    [<ffffffff839a7fcb>] netlink_sendmsg+0x96b/0xe90
    [<ffffffff8369d12f>] ____sys_sendmsg+0x30f/0xa70
    [<ffffffff836a6d7a>] ___sys_sendmsg+0x13a/0x1e0
unreferenced object 0xffff88810f6a83e0 (size 32):
  comm "ip", pid 329, jiffies 4294775225 (age 28.561s)
  hex dump (first 32 bytes):
    a0 99 47 03 81 88 ff ff a0 99 47 03 81 88 ff ff  ..G.......G.....
    81 00 00 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
  backtrace:
    [<ffffffff81a6051a>] kmalloc_trace+0x2a/0xe0
    [<ffffffff84064369>] vlan_vid_add+0x409/0x790
    [<ffffffff84068e21>] vlan_device_event+0x1491/0x21a0
    [<ffffffff81440c8e>] notifier_call_chain+0xbe/0x1f0
    [<ffffffff8372383a>] call_netdevice_notifiers_info+0xba/0x150
    [<ffffffff837590f2>] __dev_notify_flags+0x132/0x2e0
    [<ffffffff8375ad9f>] dev_change_flags+0x11f/0x180
    [<ffffffff8379af36>] do_setlink+0xb96/0x4060
    [<ffffffff837adf6a>] __rtnl_newlink+0xc0a/0x18a0
    [<ffffffff837aec6c>] rtnl_newlink+0x6c/0xa0
    [<ffffffff837ac64e>] rtnetlink_rcv_msg+0x43e/0xe00
    [<ffffffff839a99e0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff839a738f>] netlink_unicast+0x53f/0x810
    [<ffffffff839a7fcb>] netlink_sendmsg+0x96b/0xe90
    [<ffffffff8369d12f>] ____sys_sendmsg+0x30f/0xa70
    [<ffffffff836a6d7a>] ___sys_sendmsg+0x13a/0x1e0

[2]
ip link add name t-nlmon type nlmon
ip link add name t-dummy type dummy
ip link add name t-bond type bond mode active-backup

ip link set dev t-bond up
ip link set dev t-nlmon master t-bond
ip link set dev t-nlmon nomaster
ip link show dev t-bond
ip link set dev t-dummy master t-bond
ip link show dev t-bond

ip link del dev t-bond
ip link del dev t-dummy
ip link del dev t-nlmon

[3]
Before:

12: t-bond: <NO-CARRIER,BROADCAST,MULTICAST,MASTER,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/netlink
12: t-bond: <BROADCAST,MULTICAST,MASTER,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 46:57:39:a4:46:a2 brd ff:ff:ff:ff:ff:ff

After:

12: t-bond: <NO-CARRIER,BROADCAST,MULTICAST,MASTER,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/netlink
12: t-bond: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 66:48:7b:74:b6:8a brd ff:ff:ff:ff:ff:ff

Fixes: e36b9d16c6a6 ("bonding: clean muticast addresses when device changes type")
Fixes: 75c78500ddad ("bonding: remap muticast addresses without using dev_close() and dev_open()")
Fixes: 9ec7eb60dcbc ("bonding: restore IFF_MASTER/SLAVE flags on bond enslave ether type change")
Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/netdev/78a8a03b-6070-3e6b-5042-f848dab16fb8@alu.unizg.hr/
Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 drivers/net/bonding/bond_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 127242101c8e..97e556302b04 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1693,14 +1693,15 @@ void bond_lower_state_changed(struct slave *slave)
 
 /* The bonding driver uses ether_setup() to convert a master bond device
  * to ARPHRD_ETHER, that resets the target netdevice's flags so we always
- * have to restore the IFF_MASTER flag, and only restore IFF_SLAVE if it was set
+ * have to restore the IFF_MASTER flag, and only restore IFF_SLAVE and IFF_UP
+ * if they were set
  */
 static void bond_ether_setup(struct net_device *bond_dev)
 {
-	unsigned int slave_flag = bond_dev->flags & IFF_SLAVE;
+	unsigned int flags = bond_dev->flags & (IFF_SLAVE | IFF_UP);
 
 	ether_setup(bond_dev);
-	bond_dev->flags |= IFF_MASTER | slave_flag;
+	bond_dev->flags |= IFF_MASTER | flags;
 	bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 }
 
-- 
2.39.5


