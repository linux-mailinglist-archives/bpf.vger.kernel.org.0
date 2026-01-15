Return-Path: <bpf+bounces-78999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E478D23196
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CD3F302A06E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549DA334C17;
	Thu, 15 Jan 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BkOVbOOy"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71F330D35;
	Thu, 15 Jan 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465590; cv=none; b=LHQBO4mUPsovy/S69y+l2aYGhEWN0BUx4pzq+EM0C3KgH1l4xs4TfblD4rL0UvQda2LSmtej9f53TpPkfBQRj/gF+WtBEJC5Eoa3sHmb5mnYu3pVp9ndilpSgg1pejFGbYfPr9sUno/4/psCX4KNvSVslALefWtYFNsNfv/IrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465590; c=relaxed/simple;
	bh=MjI+BB+GddwAIb9RAIEWQUfnZjTGEGTkM1e1iviyqqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWCMKfoY9mYYP1cdd+I+nEfQgTYeIiv6/kJzw7oN5wFNN2HMaRBiEQFSMd+rKdolJLo+u5rh5D4NzpaNWNZyfoaFEZ+YPybtRXBZHqhWxOjXES8cgdEff6S5ZsTjmFEyHGtg4pn0JCua1w6DZIlpZdEADYjRfgeyyjOt9BZJsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BkOVbOOy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5WY0eqWS9VmdSszhAaFq+o3JXP+PjOQ+HDOwKRfkQAE=; b=BkOVbOOy2jox66BbQo4msjqu4J
	HWbyRCQbbEBaFApjQoNzRRRvRk93edbH7JMsg+FfMzUFXJFGzXu3b6ZMQyvjCwgQmfEl/CYUSMCGH
	i2gJzBIQX2FMnWPQTmDlYp+mapBsuYzPmdPUaF3otV/Pti9ZvJkIo/2Z09gtd1wwZXMzQUAwqL64P
	6Ze/zmGRIRrCvnkE1fqIs+Jx+aZ9QkMTVuHTa3lNxvgoiXnSeyW7BOW43ajXyaPLB1ADjuQhz6gnU
	06scYPqhrlZj0/7Y7r5RnxQdwKHANtF3UH/wqPg/c/AzhYtN/LXPro19c5ZtX1TuZqj/559/zURKE
	FiWKBs+w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgI-000Nqb-0t;
	Thu, 15 Jan 2026 09:26:14 +0100
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
Subject: [PATCH net-next v7 08/16] xsk: Proxy pool management for leased queues
Date: Thu, 15 Jan 2026 09:25:55 +0100
Message-ID: <20260115082603.219152-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

Similarly to the net_mp_{open,close}_rxq handling for leased queues, proxy
the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
that in case a virtual netdev picked a leased rxq, the request gets through
to the real rxq in the physical netdev. The proxying is only relevant for
queue_id < dev->real_num_rx_queues since right now its only supported for
rxqs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 15e54bb9f372..3043cadce6bd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -23,6 +23,8 @@
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/vmalloc.h>
+
+#include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
 #include <net/netdev_lock.h>
@@ -117,10 +119,18 @@ EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 {
-	if (queue_id < dev->num_rx_queues)
-		dev->_rx[queue_id].pool = NULL;
-	if (queue_id < dev->num_tx_queues)
-		dev->_tx[queue_id].pool = NULL;
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+
+	if (id < dev->real_num_rx_queues)
+		WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &id));
+
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = NULL;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = NULL;
+
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -130,17 +140,29 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id)
 {
-	if (queue_id >= max_t(unsigned int,
-			      dev->real_num_rx_queues,
-			      dev->real_num_tx_queues))
-		return -EINVAL;
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+	int ret = 0;
 
-	if (queue_id < dev->real_num_rx_queues)
-		dev->_rx[queue_id].pool = pool;
-	if (queue_id < dev->real_num_tx_queues)
-		dev->_tx[queue_id].pool = pool;
+	if (id >= max(dev->real_num_rx_queues,
+		      dev->real_num_tx_queues))
+		return -EINVAL;
+	if (id < dev->real_num_rx_queues) {
+		if (!netif_get_rx_queue_lease_locked(&dev, &id))
+			return -EBUSY;
+		if (xsk_get_pool_from_qid(dev, id)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
-	return 0;
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = pool;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = pool;
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
 }
 
 static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
-- 
2.43.0


