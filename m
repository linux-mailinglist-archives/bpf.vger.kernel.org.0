Return-Path: <bpf+bounces-30480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1318CE595
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16751F21C57
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C186AE7;
	Fri, 24 May 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NcSFB3mz"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28653381BB;
	Fri, 24 May 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555690; cv=none; b=pIJPXXUhrGmfnIGxvoX5/TF0YjZlfoS0BMNVUoCkXEU9I9TwEV6MDj9zPsXEwMJ8KT/mxpmMO446gzlYwqB2UKVhBQCAIVePnsQsQqrsm9ZRYCBsRJB0nxli7bQsqbG1U9CGKxyUxO4EzU8xuJc94ViIIZcTB9d51jrmd++5bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555690; c=relaxed/simple;
	bh=Ud/amTmy8TIjZHtX7j6S78UPtRg0drlr5dAgUU+d/uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGgcGWFQ+OFiKAdjToJMg/Chm755jSWTQZqgesNdsTydPdbrk/GnLZIcHlriK7NUYEqvLKEsHdCutjQc7Fax24hWR1Yj7037YChHe8ZWFAw0PkWH+GlAjQ4yqsxEpAArz74t9cSoG0Hf3IeA6BZ7s+065NLCczpMG9bKkPv9pYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NcSFB3mz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2zCTSxqHxcraLH5KniLKHOznN5mQK5vs9BG5356v/Vo=; b=NcSFB3mzlSLUPKJ/d4BPTK9/vq
	mgP03acMhlRoyxL6rMc4xoxvgYSi0iju5N0tugSoyZgQKwzDRiX7ar2U0ujFvcFUceiijk86JZh8q
	bldM7HjhVkgrblU0HoQy7xQfUD+S1HIcigx3E0C8MdP4hIrFEWNYQOY4hXy7KzyHIIZ1rP0D0anJQ
	tBgECAyAN+uNnwsSamsmXIypY0smHf5SDhC8WKjI4/Hr3iY96ATUOxvKKmLP0ar6kJVkzLPXqjJpF
	vq91N7N6EEiwmwAF+mrirOIIcwFUHcWNwjlqpP4oIvrB/nwd3nZy7tds2Y0JiZS5U83r/xPEtpCFE
	t6/r7cOg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAUXw-000K4w-VL; Fri, 24 May 2024 15:01:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/5] netkit: Fix setting mac address in l2 mode
Date: Fri, 24 May 2024 15:01:11 +0200
Message-Id: <20240524130115.9854-1-daniel@iogearbox.net>
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


