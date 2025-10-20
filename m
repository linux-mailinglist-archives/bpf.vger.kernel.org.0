Return-Path: <bpf+bounces-71430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8911BF2835
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6DA425739
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F332F74C;
	Mon, 20 Oct 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pxthquvc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63427E071;
	Mon, 20 Oct 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978967; cv=none; b=ReOlvXoOdXM9XkZxCgapKO/Mrj8caHp3+ZfVtTX1fMF9YeqYravI53Iepq78qOIxsQ0MUx4mLlwK/QKgGOJgyxf292YtHhO6KQC/Pu4X7/WO81H5aneEOpMUSzANpFZL/VNeQIz4N4F04vWYZzSf7TGT7WlsVGGGcGHqwo0dp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978967; c=relaxed/simple;
	bh=fz6d13/8g9fz5cwXCG01qQYhBQPqVULH4k3VjnV6m2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZrRvphmK4jgkPTVyQRLFxyUV9S+YZ9zgQTf5DZYPysn3G2tEu2iw+kSQIBy7OgS34Fb/kOItwL91qkN9xo4g2ijgm4qQ/+Ceh827XorpNJMNPYeAa6Nli2uGiAdeX3fYiH1jJuF3Sqi+o1IX3DkFVdF2XSWVGS0gvzyIuInGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pxthquvc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7brbynTB30Kt41JdXoJYefjsF2tB4KvKdHKaQHe/2TM=; b=pxthquvcJ4nlAhDJWRIpMmjh+D
	V67n3kbfkvgYgVDH/hgp4exgoDJzoX9r/PO2GgarnXkj+ypaEN/Q5Kdu0F7ABdmWf8HuSXBUxiZOP
	IUcp6wTRywnGFVjV+OVutd4w7PSp8/lJQc76YPbSAqjtOaOU9t2QaBq8BUAYLqVaKTsxQ5DReC0LT
	VDiQ+vejMZLkjlVqR3tdj1KWURvHxQhIPPBAscFrmO9DXUSoPZleSpgOnYaof0yFRU8XwE2ZPPAt3
	maP/EBM58cgiNrMxuxiCNqm98LyxEo33eskRB3Zh/pQNfwvEb9Lo7YzUzrwmJ+nwj57Y+i8VcaTJl
	nHiSvrqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsg8-000Jmd-1D;
	Mon, 20 Oct 2025 18:24:12 +0200
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v3 14/15] netkit: Add io_uring zero-copy support for TCP
Date: Mon, 20 Oct 2025 18:23:54 +0200
Message-ID: <20251020162355.136118-15-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

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
  # ip link add type netkit peer numrxqueues 2
  # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
                   --do bind-queue \
                   --json "{"src-ifindex": $(ifindex eth0), "src-queue-id": 15, \
                            "dst-ifindex": $(ifindex nk0), "queue-type": "rx"}"
  {'dst-queue-id': 1}
  # ip link set nk0 netns foo
  # ip link set nk1 up
  # ip netns exec foo ip link set lo up
  # ip netns exec foo ip link set nk0 up
  # ip netns exec foo ip addr add 1.2.3.4/32 dev nk0
  [ ... setup routing etc to get external traffic into the netns ... ]
  # ip netns exec foo ./iou-zcrx -s -p 5000 -i nk0 -q 1

Remote io_uring client:

  # ./iou-zcrx -c -h 1.2.3.4 -p 5000 -l 12840 -z 65536

We have tested the above against a Broadcom BCM957504 (bnxt_en)
100G NIC, supporting TCP header/data split.

Similarly, this also works for devmem which we tested using ncdevmem:

  # ip netns exec foo ./ncdevmem -s 1.2.3.4 -l -p 5000 -f nk0 -t 1 -q 1

And on the remote client:

  # ./ncdevmem -s 1.2.3.4 -p 5000 -f eth0

For Cilium, the plan is to open up support for the various memory providers
for regular Kubernetes Pods when Cilium is configured with netkit datapath
mode.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://kernel-recipes.org/en/2024/schedule/efficient-zero-copy-networking-using-io_uring [0]
---
 drivers/net/netkit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 75b57496b72e..a281b39a1047 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -282,6 +282,21 @@ static const struct ethtool_ops netkit_ethtool_ops = {
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
@@ -307,7 +322,8 @@ static int netkit_queue_create(struct net_device *dev)
 }
 
 static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
-	.ndo_queue_create = netkit_queue_create,
+	.ndo_queue_get_dma_dev		= netkit_queue_get_dma_dev,
+	.ndo_queue_create		= netkit_queue_create,
 };
 
 static struct net_device *netkit_alloc(struct nlattr *tb[],
-- 
2.43.0


