Return-Path: <bpf+bounces-30510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911F8CE8C3
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC81C20F04
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65212EBE6;
	Fri, 24 May 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IedWzaQm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FC83A0D;
	Fri, 24 May 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568585; cv=none; b=PI8WbDcX53Bc26GzvFpAyzDaylZsVsfwUgkKGVzMtzcWz0sVhziHw97UOfKVfOvIZYXMCDUoNJsynxnxNaonaCLKi8BFP3Lzx02NAfAqp5lLpwZW1xrBn9NyIa+ay0HwY3s3ZT3yhlM7IhW9oqI2X5W5Svsd4nbxHTKZjyY4Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568585; c=relaxed/simple;
	bh=r7dbGSZS+UZxQmd3Kum0wG+KGiCY04G8988SN7eCPYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8B4GchYrIygl7atApHMWpPatmjkjws2ErHM/yp9TI6CtdYTFDbw5+jc6FhVKVCS8trKgKvDoAmVlBo2cBwsw5KRcoJPPbGaAtz0FH6g8fj0fZZga5s9dB0xn+Wewg1ql/B8sUlMiyC+5pFGlytoQNacm4rTBal+uUm+XMGC+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IedWzaQm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cDjjizADC9QJgiIBgN8vyRB9H0Mk619r0v3k1gZ+FbA=; b=IedWzaQmn1IvPQ+7sDOzFzz1uy
	9fQ/iLb6V5VjCq8w7gZd7lTz0Y/m/dX6IqQKCBIavXD12Zm3CrJzvaIe/JTdTUY4TXuH1ja0mw5q7
	1+GTdZciuuGbYTdnJez2MpOIKtplCnnOmwfAb9wjOPkP1I8LcyFClLpvmPCXzkvOKUPBn/kdrRCIQ
	QIV4REcapCAuprreDglCtheHVjpoIsQRl0lKSDtApqpAWoxxum0JCIOpwk8mxJ9fEKOdRRX5M5Ovk
	YvxGReD7KfD+jkqQ6ULgAI91zsmOk6OIVUr3LFVQZGSLZqbbgkKUyAhYfnncG962gie4b8vg1xgu8
	w3D45ckg==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXu1-000IRK-JE; Fri, 24 May 2024 18:36:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/4] netkit: Fix setting mac address in l2 mode
Date: Fri, 24 May 2024 18:36:16 +0200
Message-Id: <20240524163619.26001-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

When running Cilium connectivity test suite with netkit in L2 mode, we
found that it is expected to be able to specify a custom MAC address for
the devices, in particular, cilium-cni obtains the specified MAC address
by querying the endpoint and sets the MAC address of the interface inside
the Pod. Thus, fix the missing support in netkit for L2 mode.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a4d2e76a8d58..272894053e2c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -155,6 +155,16 @@ static void netkit_set_multicast(struct net_device *dev)
 	/* Nothing to do, we receive whatever gets pushed to us! */
 }
 
+static int netkit_set_macaddr(struct net_device *dev, void *sa)
+{
+	struct netkit *nk = netkit_priv(dev);
+
+	if (nk->mode != NETKIT_L2)
+		return -EOPNOTSUPP;
+
+	return eth_mac_addr(dev, sa);
+}
+
 static void netkit_set_headroom(struct net_device *dev, int headroom)
 {
 	struct netkit *nk = netkit_priv(dev), *nk2;
@@ -198,6 +208,7 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_start_xmit		= netkit_xmit,
 	.ndo_set_rx_mode	= netkit_set_multicast,
 	.ndo_set_rx_headroom	= netkit_set_headroom,
+	.ndo_set_mac_address	= netkit_set_macaddr,
 	.ndo_get_iflink		= netkit_get_iflink,
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
@@ -300,9 +311,11 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (!attr)
 		return 0;
-	NL_SET_ERR_MSG_ATTR(extack, attr,
-			    "Setting Ethernet address is not supported");
-	return -EOPNOTSUPP;
+	if (nla_len(attr) != ETH_ALEN)
+		return -EINVAL;
+	if (!is_valid_ether_addr(nla_data(attr)))
+		return -EADDRNOTAVAIL;
+	return 0;
 }
 
 static struct rtnl_link_ops netkit_link_ops;
@@ -365,6 +378,9 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		strscpy(ifname, "nk%d", IFNAMSIZ);
 		ifname_assign_type = NET_NAME_ENUM;
 	}
+	if (mode != NETKIT_L2 &&
+	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
+		return -EOPNOTSUPP;
 
 	net = rtnl_link_get_net(src_net, tbp);
 	if (IS_ERR(net))
@@ -379,7 +395,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 
 	netif_inherit_tso_max(peer, dev);
 
-	if (mode == NETKIT_L2)
+	if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
 		eth_hw_addr_random(peer);
 	if (ifmp && dev->ifindex)
 		peer->ifindex = ifmp->ifi_index;
@@ -402,7 +418,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	if (err < 0)
 		goto err_configure_peer;
 
-	if (mode == NETKIT_L2)
+	if (mode == NETKIT_L2 && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
-- 
2.34.1


