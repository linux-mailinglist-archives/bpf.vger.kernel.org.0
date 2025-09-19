Return-Path: <bpf+bounces-68997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6605B8B6A1
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7947BFF2F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EC92D46B7;
	Fri, 19 Sep 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aui9D0by"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC925BEF1;
	Fri, 19 Sep 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318730; cv=none; b=o6Nrz+gg2V4JwWVjt4N0vdnar06t+U9c3KHdKoeMsd5S3PchOG81LAnIkbKjac592hiIIBZ2NDvi7p2HH1s0Qqgab5tF57SiyP5Y3uakHTNHp6X9DkExbd6u9ofmVuOqBl5m2nQqYU9ZeWu6W4Q15KX64AqikYGf4hqsxl87MEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318730; c=relaxed/simple;
	bh=4OaDL3zrRtaDStHRe6/1Biq2t/Nf1mV/1JFDrJJGNfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khDePJ296MH8sGoHVf2uSA2mP6estHIc7PvyO53kcW28V+rY36WsSEum+N5lMhiXTql35Z2uLtu/i8T+W0IrMi48wB+qHCtu3TQAWwa19luVxHWlLo0NZTXnF1qAmb6pVao/Tjqqv5tPHSjeLZHmPX6ekiLcDL/JW019o6ciREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aui9D0by; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Tq+s3moi4aETY4tdJE1DrMRVk78qBpcdzGrGspHui+c=; b=aui9D0byxJR7P0X6HSPzzA5phm
	7KoSANnmlgyHiNonMrmhAtJc9Feq+/nENyIvX07WjbQrIFDVye+WnV+gKaawuOaQEmDsZmHzoHXjZ
	pV5eVtbjP4un1fJgLRt+ipm9tDE/zE014I98CbW/pntMYeIZm9JcQlt+hBFsOxzylQOJu7D9D7L8Q
	MZRk2wwwqZnsWD+s++GOScqmpZSDr73ABpcxQ4zi7Rqg81dF7HOHwhFkGn7dFkOOnbNM99b0kTKDT
	Gsix1I0rk8SWjJINzwIsHKBHxuD3NXkDQDHZ7T2gZunwJfme51H/03n23I+IlzH0hpkYCrtjMIww0
	7vRqUEQQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uziiB-000NtK-2P;
	Fri, 19 Sep 2025 23:32:11 +0200
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
Subject: [PATCH net-next 18/20] netkit: Add io_uring zero-copy support for TCP
Date: Fri, 19 Sep 2025 23:31:51 +0200
Message-ID: <20250919213153.103606-19-daniel@iogearbox.net>
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

This adds the last missing bit to netkit for supporting io_uring with
zero-copy mode [0]. Up until this point it was not possible to consume
the latter out of containers or Kubernetes Pods where applications are
in their own network namespace.

Thus, as a last missing bit, implement ndo_queue_get_dma_dev() in netkit
to return the physical device of the real rxq for DMA. This allows memory
providers like io_uring zero-copy or devmem to bind to the physically
mapped rxq in netkit.

io_uring example with eth0 being a physical device with 16 queues where
netkit is bound to the last queue, iou-zcrx.c is binary from selftests.
Flow steering to that queue is based on the service VIP:port of the
server utilizing io_uring:

  # ethtool -X eth0 start 0 equal 15
  # ethtool -X eth0 start 15 equal 1 context new
  # ethtool --config-ntuple eth0 flow-type tcp4 dst-ip 1.2.3.4 dst-port 5000 action 15
  # ip netns add foo
  # ip link add numrxqueues 2 type netkit
  # ynl-bind eth0 15 nk0
  # ip link set nk0 netns foo
  # ip link set nk1 up
  # ip netns exec foo ip link set lo up
  # ip netns exec foo ip link set nk0 up
  # ip netns exec foo ip addr add 1.2.3.4/32 dev nk0
  [ ... setup routing etc to get external traffic into the netns ... ]
  # ip netns exec foo ./iou-zcrx -s -p 5000 -i nk0 -q 1

Remote io_uring client:

  # ./iou-zcrx -c -h 1.2.3.4 -p 5000 -l 12840 -z 65536

We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
100G NIC as well as Broadcom BCM957504 (bnxt_en) 100G NIC, both
supporting TCP header/data split. For Cilium, the plan is to open
up support for io_uring in zero-copy mode for regular Kubernetes Pods
when Cilium is configured with netkit datapath mode.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://kernel-recipes.org/en/2024/schedule/efficient-zero-copy-networking-using-io_uring [0]
---
 drivers/net/netkit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 27ff84833f28..5129b27a7c3c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -274,6 +274,21 @@ static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_channels		= netkit_get_channels,
 };
 
+static struct device *netkit_queue_get_dma_dev(struct net_device *dev, int idx)
+{
+	struct netdev_rx_queue *rxq, *peer_rxq;
+	unsigned int peer_idx;
+
+	rxq = __netif_get_rx_queue(dev, idx);
+	if (!rxq->peer)
+		return NULL;
+
+	peer_rxq = rxq->peer;
+	peer_idx = get_netdev_rx_queue_index(peer_rxq);
+
+	return netdev_queue_get_dma_dev(peer_rxq->dev, peer_idx);
+}
+
 static int netkit_queue_create(struct net_device *dev)
 {
 	struct netkit *nk = netkit_priv(dev);
@@ -299,7 +314,8 @@ static int netkit_queue_create(struct net_device *dev)
 }
 
 static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
-	.ndo_queue_create = netkit_queue_create,
+	.ndo_queue_get_dma_dev		= netkit_queue_get_dma_dev,
+	.ndo_queue_create		= netkit_queue_create,
 };
 
 static struct net_device *netkit_alloc(struct nlattr *tb[],
-- 
2.43.0


