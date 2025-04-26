Return-Path: <bpf+bounces-56771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF5A9D95B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DD97A983A
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363422505BB;
	Sat, 26 Apr 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GazXByNl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6319CC0A;
	Sat, 26 Apr 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745656147; cv=none; b=n4yTq7xFBchDr0DjiP4FutAx+qELoYGjFwlWM1cWda+Q2fbG7JMWGDjdTK6Ne2B7MiGINLpyLdpXSE5k7Mw4wv/ydHYf9/lJQ0mKsBKu21ycLcuq7qD5gqjxixcrpsP0cqHNtm0FaHX1RAWThjmDfsfSK6V5s/WZI9RH0saXE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745656147; c=relaxed/simple;
	bh=BlPT224zKcRmpKp/wnthT4KPe5thFT9m4jEmdANvCiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBhOxZaW0Ca7dqXLUnyNFEW26iWiz9JzmHqnP9CGDChHGIIJ2S40CtIPLSbuQu1ADH9OnUanYdYCM2aZpOrSRccHLtPdWBnWyLLZS3Ud8BlWkvQCi87MmplaLJRRqytyN6YTGiYfx/RYDxPJo1Pkg6xLyHKMygDL55iEdQzmteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GazXByNl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22d95f0dda4so48302655ad.2;
        Sat, 26 Apr 2025 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745656144; x=1746260944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM8A37+YXmFikaBp3T7wLJanwbx1aYEE9fR5m8vuRi4=;
        b=GazXByNlMwubRpfDauTgejm2W/qCAFH3g6pvTIPY541h6QOnThYLZ06B+DgwtmDDSb
         OfHAiOmmr7XhGp7sC08OCDdUZpKAbcCEWXpm22w8nC8PtR7a72lEli/KjUD6BC9KHmCW
         HOlRVXlD9ww3+VMaXrPiwGcd++yEMGT5jdm2mLkDDpYYoHT5yisOtYqSIC/74NxQS9No
         zQmdKr3RyZlARifAf0YQntbwnsKb7maXxxrb66N7C4PxLYHRac4MqzsXotyULI6RNKJX
         2UR9yKEnzB8KVCIYS/Cfw64ypC7kL9zruImK/Me+6klfTbwoiwbvZ4KE1O12cHNs5Quv
         CyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745656144; x=1746260944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM8A37+YXmFikaBp3T7wLJanwbx1aYEE9fR5m8vuRi4=;
        b=JcZVIBFupRnVza/mFVO+5JJCyNzdwxsdvJKwysbl3OMFWqWrqFHXlHwtKewpcQMBL0
         4IlEKavOtw36vq7e1LSviP4WlTPZZWgqwuGOJ1ttmKxpimZet5sXVxE/1ACqaxHRtk2e
         7yqtUzKqqJLrUZ4lMYeAOCmMS4rzH9KCqwyx2lKpHaTe0i2cbPsOvnN3nhSrCHE9fazY
         iRAgKEw9Z+D54arXPGEJ+Jg5u0rC35GGGyFCXQxaUPYAcgZPr2HwHyZPLZx6v/KnC9z3
         xqP3DcAEICMnPUeCQ4SWMaZoVwQdQeMlq7bYQoFGwMS5N3nBYHwfA2nzo1oMTlhzFg+j
         03PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEbVkCYfooDbuIcQv1wbYmLdSd9QLaOWT0SBPt3VYxciFJWuhIDgr7t9Oc04tAbS5/K4=@vger.kernel.org, AJvYcCVu6a+PkisNrKn0Gm0Y0hVOdVXfVIoDSBZXQtBFSuk2OQdqTYzPtLxLJGus/0sYAqDdDx7LNIYiCMXKxT8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnfDfBwXLPYQkp6n4gkeGDfOJC+WkytMkT0KNnqtKGwyC/Y+z
	cbhSij87FN7B6FswXhWUJnNdbeD+odPitCIdLBbvnrINrbqoP6yzPZg46g7Jy9E=
X-Gm-Gg: ASbGncte7Y+7D4/2ekRkXUdpIp0fawGB2EoJgJB2TgJ5iobta7P9iQ6qL+HS2CnXJxk
	NX83IoB7DX0Rj2dCsR9lAgPcfiQom/cyFwC2wbEnemPZy+IfmUntxc6Eaqfb6nRwO0rktfm23Dy
	5OmSfos4pVp+umhgdb/kCHYMz41tCYINpD6wE2vlgG4M6ytSNRYhzfhhIkRZXdVt2mT3VYxupwt
	ziVj5JVPB64tmJFpNIXjsnohwHAwaZq/hEtBP/4V8OJeYrcOaHOKRa+TUKfvXFn/l74auOUNuBw
	3od3JkHaVzZofTkUF0y6sZFTe9THv0tTUivEvTrsqB3V7wnlK15CPMuC
X-Google-Smtp-Source: AGHT+IEbUSASmLNrEsQTJTPBK3hQZC0/5KtkWZdyCfJJQEIBmwlysntni1JLhUzFc4HajkuPZxOc7w==
X-Received: by 2002:a17:902:ccc4:b0:224:c76:5e57 with SMTP id d9443c01a7336-22dbf62255bmr81362875ad.39.1745656144410;
        Sat, 26 Apr 2025 01:29:04 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db5100ab2sm45155165ad.183.2025.04.26.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:29:03 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [RFC PATCH net-next] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Sat, 26 Apr 2025 15:27:52 +0700
Message-ID: <20250426082752.43222-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in zerocopy mode with mergeable receive buffer, virtio-net
does not support multi buffer but a single buffer only. This commit adds
support for multi mergeable receive buffer in the zerocopy XDP path by
utilizing XDP buffer with frags.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 107 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848fab51dfa1..8d21767dd607 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
+#define VIRTNET_MAX_ZC_SEGS	8
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
 	}
 }
 
-static int xsk_append_merge_buffer(struct virtnet_info *vi,
-				   struct receive_queue *rq,
-				   struct sk_buff *head_skb,
-				   u32 num_buf,
-				   struct virtio_net_hdr_mrg_rxbuf *hdr,
-				   struct virtnet_rq_stats *stats)
+static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
+				      struct receive_queue *rq,
+				      u32 num_buf,
+				      struct xdp_buff *xdp,
+				      struct virtnet_rq_stats *stats)
 {
-	struct sk_buff *curr_skb;
-	struct xdp_buff *xdp;
-	u32 len, truesize;
-	struct page *page;
+	unsigned int len;
 	void *buf;
 
-	curr_skb = head_skb;
+	if (num_buf < 2)
+		return 0;
+
+	while (num_buf > 1) {
+		struct xdp_buff *new_xdp;
 
-	while (--num_buf) {
 		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers out of %d missing\n",
-				 vi->dev->name, num_buf,
-				 virtio16_to_cpu(vi->vdev,
-						 hdr->num_buffers));
+		if (!unlikely(buf)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 vi->dev->name, num_buf);
 			DEV_STATS_INC(vi->dev, rx_length_errors);
-			return -EINVAL;
-		}
-
-		u64_stats_add(&stats->bytes, len);
-
-		xdp = buf_to_xdp(vi, rq, buf, len);
-		if (!xdp)
-			goto err;
-
-		buf = napi_alloc_frag(len);
-		if (!buf) {
-			xsk_buff_free(xdp);
-			goto err;
+			return -1;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
-
-		xsk_buff_free(xdp);
+		new_xdp = buf_to_xdp(vi, rq, buf, len);
+		if (!new_xdp)
+			goto drop_bufs;
 
-		page = virt_to_page(buf);
+		/* In virtnet_add_recvbuf_xsk(), we ask the host to fill from
+		 * xdp->data - vi->hdr_len with both virtio_net_hdr and data.
+		 * However, only the first packet has the virtio_net_hdr, the
+		 * following ones do not. So we need to adjust the following
+		 * packets' data pointer to the correct place.
+		 */
+		new_xdp->data -= vi->hdr_len;
+		new_xdp->data_end = new_xdp->data + len;
 
-		truesize = len;
+		if (!xsk_buff_add_frag(xdp, new_xdp))
+			goto drop_bufs;
 
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
-						    buf, len, truesize);
-		if (!curr_skb) {
-			put_page(page);
-			goto err;
-		}
+		num_buf--;
 	}
 
 	return 0;
 
-err:
+drop_bufs:
 	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
-	return -EINVAL;
+	return -1;
 }
 
 static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
@@ -1307,23 +1297,28 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 
 	ret = XDP_PASS;
+	if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
+		goto drop;
+
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
+	if (prog)
 		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
 	rcu_read_unlock();
 
 	switch (ret) {
 	case XDP_PASS:
-		skb = xsk_construct_skb(rq, xdp);
+		skb = xdp_build_skb_from_zc(xdp);
 		if (!skb)
-			goto drop_bufs;
+			break;
 
-		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
-			dev_kfree_skb(skb);
-			goto drop;
-		}
+		/* Later, in virtnet_receive_done(), eth_type_trans()
+		 * is called. However, in xdp_build_skb_from_zc(), it is called
+		 * already. As a result, we need to reset the data to before
+		 * the mac header so that the later call in
+		 * virtnet_receive_done() works correctly.
+		 */
+		skb_push(skb, ETH_HLEN);
 
 		return skb;
 
@@ -1332,14 +1327,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 		return NULL;
 
 	default:
-		/* drop packet */
-		xsk_buff_free(xdp);
+		break;
 	}
 
-drop_bufs:
-	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
-
 drop:
+	xsk_buff_free(xdp);
 	u64_stats_inc(&stats->drops);
 	return NULL;
 }
@@ -1396,6 +1388,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		return -ENOMEM;
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+	/* Reserve some space for skb_shared_info */
+	len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	for (i = 0; i < num; ++i) {
 		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
@@ -6721,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
+	dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
-- 
2.43.0


