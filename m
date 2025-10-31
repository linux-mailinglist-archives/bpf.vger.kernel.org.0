Return-Path: <bpf+bounces-73200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B4C2703A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FF924F79DF
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5C33E35F;
	Fri, 31 Oct 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Nb5Dvc0d"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CD323401;
	Fri, 31 Oct 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945696; cv=none; b=I9cKenydzoiinqjnswkibSyWFMZkRN/DBtoVOcD5sDgb0aYtIoU4vjKeq9DzY7S3sQoNDxMjvc6VQva9dM/MWE/gLwefoSRy93iHHET0M7KE/iWHz9/VGKaFQuI61NdQhXfNTjCoq716ZXz1fj/LEgCQrKJu+gPDpHJzMIxTt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945696; c=relaxed/simple;
	bh=P465Gk/aJIvOE/3TAivHhkfRA9r44bgJpUf+wc+H544=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtG9JGBvuiP8q6j77xiU+tlrD1nZT18ODOgsrY0wPu0Zrrj/IJ4jETtKszkSgO/7Mvr6jBvRXqKswtgX2CTtlVnoEPA4FfqKAz2WHjT3GsxOVipq0COWHCcHAemRu+MwrTbYjvtkiPHDG92PpGgqgt+cliNWCIZ+AjdYj4+griY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Nb5Dvc0d; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I9ZuILu7rbWBvftc02q3zj9OWJnycfcMVVK/txoT71c=; b=Nb5Dvc0dtTv0BfEwos3EiMwqRI
	1V73+vdmfE0pYNYcjcGigzPxscqLcENpyKJVDTUL7w1G1E+kXJHNDeMf0OQgMlLJabdJrWB69eLmd
	KRz1dKzhNQqQb0ybOT9wvKo8NhKPbI2Qt9e/szdNvDzr4V5CbhBrnRnM3+Uc7sMm+4F+BAJT4Aybs
	FrzFc6YIcR4RjIUkHjfZSRz/lg5Msw1kU2kbZYmITqsY6i6arARvBw3mYlD7TYwH7O0QsbUuyccud
	bVvaSRnxDlcHxfcnfpdlEGC3LMLU4lf5nDfnBYOl0d1cWWYme8ROlHYKZHbxI476MVrLsqXxv4rf3
	aQB/mkcg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYc-0005dZ-1G;
	Fri, 31 Oct 2025 22:21:14 +0100
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
Subject: [PATCH net-next v4 08/14] xsk: Proxy pool management for mapped queues
Date: Fri, 31 Oct 2025 22:20:57 +0100
Message-ID: <20251031212103.310683-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

Similarly what we do for net_mp_{open,close}_rxq for mapped queues, proxy
also the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_peer_locked
such that when a virtual netdev picked a mapped rxq, the request gets
through to the real rxq in the physical netdev. The proxying is only
relevant for queue_id < dev->real_num_rx_queues since right now its only
supported for rxqs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6ae9ad5f27ad..872b243b7fcc 100644
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
@@ -124,10 +126,18 @@ EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
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
+		WARN_ON_ONCE(!netif_get_rx_queue_peer_locked(&dev, &id));
+
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = NULL;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = NULL;
+
+	netif_put_rx_queue_peer_locked(orig_dev, dev);
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -137,17 +147,29 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
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
+		if (!netif_get_rx_queue_peer_locked(&dev, &id))
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
+	netif_put_rx_queue_peer_locked(orig_dev, dev);
+	return ret;
 }
 
 static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
-- 
2.43.0


