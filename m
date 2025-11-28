Return-Path: <bpf+bounces-75704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFFC9218E
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A23F935112D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BC32E686;
	Fri, 28 Nov 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="1G9Z++A7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1032E12F;
	Fri, 28 Nov 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335797; cv=none; b=ZXblH7LemzF4SliSvRed/JL+4/RlZEGttbk4L7QrbAoH7dR7QtZmOmDvtCjvxTi8kY1RSOWOFD3DnV7/+IsgO+eJ3mD5GaAss+7HYIeTRF/KEOCcLXsICYliyXXDxXVaKmKT+7Q7yy1OS4uK/y5rPthtNnpBIAdopW8t+t9RODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335797; c=relaxed/simple;
	bh=5MwlDraxyNlmirgOdWC70LRDoKS3QWroy32Zqswic8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWcyiF6AS/XcrxdP3XTGxlHfbSS/xAZw5Zqkjn7vuoTVK8ZgHmFONl5cTIg1YXvlggXXTEvNXVFDZNEjPrKVpc9SjwIMes5jnsQdfF14dvDm/MfrMZk8Aj64vPc6sUPw1/ibfPy+04wJgaaSPxkcc9RPjeKaLlFVS1AzpUyoF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=1G9Z++A7; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764335792;
	bh=5MwlDraxyNlmirgOdWC70LRDoKS3QWroy32Zqswic8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1G9Z++A7cYIiPV2V2UfwUEshJ+qxnXDRxhdRkWQkQwW+lb1wMhej1zhmVvgw+uz8d
	 QqhCY0JLqa487wcdfZ/j+bitOqtnNDAuBya8QWM1Ce2OIAWHsQzoUMvllZtIo0iJXu
	 tEWpTiVoGqTJdMsQ3hc+xL3rUXh1HPLjFukGAlEnydFqUSMduExVMLcu+BrfSsnnEV
	 sliKBY2J+46tq2+Pe2bLsO2sjnTKQSNqs0ZKXZkjGltuY80e0rVMvcszTnyIdV8mKN
	 zjNiqJvTKM9R0mUSbSpETbhD6JGMcsXogg2cAIPxYic1tOktk1UO5XUNvYLSJ9Dkq6
	 eFGJv3Tt6MJ7g==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 3CEF61F97D;
	Fri, 28 Nov 2025 16:16:32 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 16:16:30 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru.astracloud.ru (rbta-msk-lt-156703.astralinux.ru [10.198.57.41])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHv1n6T87zwPGr;
	Fri, 28 Nov 2025 16:15:57 +0300 (MSK)
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
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH 5.10 v2 1/3] bonding: restore IFF_MASTER/SLAVE flags on bond enslave ether type change
Date: Fri, 28 Nov 2025 16:15:35 +0300
Message-Id: <20251128131537.4241-2-apanov@astralinux.ru>
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, {Tracking_spam_in_reply_from_match_msgid}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198520 [Nov 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/28 10:03:00 #27985542
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit 9ec7eb60dcbcb6c41076defbc5df7bbd95ceaba5 ]

Add bond_ether_setup helper which is used to fix ether_setup() calls in the
bonding driver. It takes care of both IFF_MASTER and IFF_SLAVE flags, the
former is always restored and the latter only if it was set.
If the bond enslaves non-ARPHRD_ETHER device (changes its type), then
releases it and enslaves ARPHRD_ETHER device (changes back) then we
use ether_setup() to restore the bond device type but it also resets its
flags and removes IFF_MASTER and IFF_SLAVE[1]. Use the bond_ether_setup
helper to restore both after such transition.

[1] reproduce (nlmon is non-ARPHRD_ETHER):
 $ ip l add nlmon0 type nlmon
 $ ip l add bond2 type bond mode active-backup
 $ ip l set nlmon0 master bond2
 $ ip l set nlmon0 nomaster
 $ ip l add bond1 type bond
 (we use bond1 as ARPHRD_ETHER device to restore bond2's mode)
 $ ip l set bond1 master bond2
 $ ip l sh dev bond2
 37: bond2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether be:d7:c5:40:5b:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 1500
 (notice bond2's IFF_MASTER is missing)

Fixes: e36b9d16c6a6 ("bonding: clean muticast addresses when device changes type")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 drivers/net/bonding/bond_main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 08bc930afc4c..127242101c8e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1691,6 +1691,19 @@ void bond_lower_state_changed(struct slave *slave)
 	netdev_lower_state_changed(slave->dev, &info);
 }
 
+/* The bonding driver uses ether_setup() to convert a master bond device
+ * to ARPHRD_ETHER, that resets the target netdevice's flags so we always
+ * have to restore the IFF_MASTER flag, and only restore IFF_SLAVE if it was set
+ */
+static void bond_ether_setup(struct net_device *bond_dev)
+{
+	unsigned int slave_flag = bond_dev->flags & IFF_SLAVE;
+
+	ether_setup(bond_dev);
+	bond_dev->flags |= IFF_MASTER | slave_flag;
+	bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+}
+
 /* enslave device <slave> to bond device <master> */
 int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 struct netlink_ext_ack *extack)
@@ -1777,10 +1790,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 			if (slave_dev->type != ARPHRD_ETHER)
 				bond_setup_by_slave(bond_dev, slave_dev);
-			else {
-				ether_setup(bond_dev);
-				bond_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-			}
+			else
+				bond_ether_setup(bond_dev);
 
 			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
 						 bond_dev);
-- 
2.30.2


