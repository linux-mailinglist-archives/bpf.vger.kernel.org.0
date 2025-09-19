Return-Path: <bpf+bounces-68994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E44B8B68C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E814A04D76
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38C2D29D5;
	Fri, 19 Sep 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QlEmiOq+"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6D267AF2;
	Fri, 19 Sep 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318699; cv=none; b=odF2Xr3scAUiaXeH6BCHLZjREI4QXOwfS/OJmTi+n4LjWmxg6QULpRaB+VAs8asqjZ04Te2Zsb+vEJhGgBmsSMV1LWaM6STpFa7ZXD4PuAsWB400Nyo19z8ROkgjTy1dSrEaL+4CbSxski6TSD8t0Tl/UaR94zSOjnwigmH57bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318699; c=relaxed/simple;
	bh=9zyveQ2OJpJEZ19mdl3ohMrBQoYkTLXLKbcfi/2io1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO3/DsHoTcneKr5cKVMzQBuc7HwAROO+BYUOPg2pSZRFBXeeb/ULy9cf4QD0Fvq1N2j34bLgcSyh0KgENvaLDqenIvYbWSjfD2yRiF3jLpvhV/QisHiO3Z8mfCIavwCe/qpHaFq0c9JrW6gbtFcj8O735ChOniLrRwLV5zFieX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QlEmiOq+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jhiNdMCOxXoszLNFztBvaK1F95zprKgmwnqGUin0YJE=; b=QlEmiOq+EuRD9TL+i+XOwCYkj2
	sRNM/9MWXF2pZXSyO263FUORPTU2RPlZagzvOiRbXhZlQ6cs1AIz7+1zOM7Pu3h9jXj34hAp5xKIE
	ZvRkEyp0YIiYEAODsg3FmluZxE+HPhAo9zCXxIkzJMffSCi6W5cRA+WsafsEHxRSh06mi8Dam8nBD
	M3T7E2uqRHlgw24Opp0ZJrWAKgnfAQgCPS4frHl/C8j9JuC2tNHDc8iOg30jfvW+O4fHBtbTtiehF
	g5yeL8lX/pWX2QvNfefUc2Dafdf9OipYXM1NVDUJgZzg43N7eKwnvhCpsLZHfZnqH1mdRVbRrmSbS
	OSVrMq8w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uziiA-000Nt2-2g;
	Fri, 19 Sep 2025 23:32:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 17/20] netkit: Implement ndo_queue_create
Date: Fri, 19 Sep 2025 23:31:50 +0200
Message-ID: <20250919213153.103606-18-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

Implement ndo_queue_create() that adds a new rxq during the bind-queue
ynl netdev operation. We allow to create queues either in single device
mode or for the case of dual device mode for the netkit peer device which
gets placed into the target network namespace. For dual device mode the
bind against the primary device does not make sense for the targeted use
cases, and therefore gets rejected.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/netkit.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index e5dfbf7ea351..27ff84833f28 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -274,6 +274,34 @@ static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_channels		= netkit_get_channels,
 };
 
+static int netkit_queue_create(struct net_device *dev)
+{
+	struct netkit *nk = netkit_priv(dev);
+	u32 rxq_count_old, rxq_count_new;
+	int err;
+
+	rxq_count_old = dev->real_num_rx_queues;
+	rxq_count_new = rxq_count_old + 1;
+
+	/* Only allow to bind in single device mode or to bind against
+	 * the peer device which then ends up in the target netns.
+	 */
+	if (nk->pair == NETKIT_DEVICE_PAIR && nk->primary)
+		return -EOPNOTSUPP;
+
+	if (netif_running(dev))
+		netif_carrier_off(dev);
+	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
+	if (netif_running(dev))
+		netif_carrier_on(dev);
+
+	return err ? err : rxq_count_new;
+}
+
+static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
+	.ndo_queue_create = netkit_queue_create,
+};
+
 static struct net_device *netkit_alloc(struct nlattr *tb[],
 				       const char *ifname,
 				       unsigned char name_assign_type,
@@ -346,8 +374,9 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
 
-	dev->ethtool_ops = &netkit_ethtool_ops;
-	dev->netdev_ops  = &netkit_netdev_ops;
+	dev->netdev_ops     = &netkit_netdev_ops;
+	dev->ethtool_ops    = &netkit_ethtool_ops;
+	dev->queue_mgmt_ops = &netkit_queue_mgmt_ops;
 
 	dev->features |= netkit_features;
 	dev->hw_features = netkit_features;
-- 
2.43.0


