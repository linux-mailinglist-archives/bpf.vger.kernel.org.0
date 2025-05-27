Return-Path: <bpf+bounces-59001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC043AC52F2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D40A1BA38C2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63127FB1E;
	Tue, 27 May 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJxrjPk4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3C27FB05;
	Tue, 27 May 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362777; cv=none; b=t7mDCQEP2oFUnAExHYF2FcJyAF2eagjNL7twvhD8w0qjejdxMG20i2t7RE00FY/tUp1A/svj+DgFRAp/YZ1SJgAsaMZwnmNyKxatEhZutfUI0ykXqSAJPY6/yXq8Y7E2e5DegByH4ZmD2YEb95ZM5ZIK4x3b0lFS0CkIK5peWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362777; c=relaxed/simple;
	bh=IUzh3BLEMlZQ5rPvOCcCqz3khKM+z1S4yWpg+KfuQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8mpGIS7cDStob6qBYk3Idd8AKlNrYFmflnmQJNxd6CkgnQRtvZN4OdVefNbi2HosXt3psDoMrVd9eXXXOrSgmOlhJLAOfouKwtNAiHrWcAEfajaKvsgvHugTJ7exPzeBxJZw0+6lIvH9MkvU1KWnCisAQX0ssyW4vuPesKW21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJxrjPk4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3976298b3a.2;
        Tue, 27 May 2025 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362774; x=1748967574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyumaTW6lo7mIeb7nd+vfxQ27K0rqMNzwb6ZVHOGqO4=;
        b=mJxrjPk4ZW69TkirA6bn83PoyXJNJDwC10dNW5vFzDPuri76fFE7D+vKutJr9cTWEk
         xFMwaoSjBM+9O70Ht/fmUJKtIPnb9IR3Nc1h1bUCA4rHeWjk5W6+a/6dr0hh0TOWkxTW
         5rRCVFNUTZY22sU8UWZURCzGVDjJ6QoL1WpIS7a8/FuUotHxXcsF8vkANCp+eaYi7vyz
         KkQ7zsDa+mYVbbfBTpSi99MO/Nj1vJkGYq05jOU3RumawuHw0HZxSNQRw5wmlOSqRzTP
         NmEeEdQ56n2V++Nnc01okZibl3EtSHplzqqQ84vPiBrvC6Z2+2rDOC3bQ0XGFAtPhxjZ
         LLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362774; x=1748967574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyumaTW6lo7mIeb7nd+vfxQ27K0rqMNzwb6ZVHOGqO4=;
        b=lEuuz92nNeHM32IFf+IfXUEL5BhxO4KBhEgYABJoVr0iWWIdiupw4Jpz2gL48X0ojB
         6xmbuNClFC2Cg38j+fpBe+BHO0H5o9fcPrmnYrjnoJd2GZjIXmKOMgnkv3zTLB+mmQNg
         nBuXOt7V831xhLVrChe0ralfwvBiPw9Z/hx46ildPEsgEzV9kmUsrIyW7tlupPJTo5Vp
         N8i0t60CTrW5my8JmrqSUTGZ9lsQw1vmnXE6CN8h49Jx8zEw+xlTI2/f+sXa/mzEU2lK
         55JMEuJ1EweIWOwb2xkkRQqNxzxl8neLy0dxP8A7sEsn3PygriQMkWjK7VnGob1t9Gtw
         OqKg==
X-Forwarded-Encrypted: i=1; AJvYcCW84XOrXekdaNZhIKZhAyuvDY0dbCqDfbtcDcMERrFp8Wnau5muTPNWMEYC2ocrGYV6jBCSFMp6CjwNQSkq@vger.kernel.org, AJvYcCXazNbBjYsA0rlR7+zHf0jAdX+D4vjfUCtG2RbhK0qznrr3SYEN9eanrG4ZsoJSvienKa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeB723Fj9ZsINSQeT9ixvKmTTTg+XWx1z92SSwsLCWxdVZF9x6
	iJCrMTDMe7S+gDbigVIeV+9197C6I6i1805CtRhGh3C5jobAhN9k5q1Ogp5Ae798n6A=
X-Gm-Gg: ASbGncswYXdf7ZJSLNW53qI0yJv/8GT4kOYfjqhCz8Wzhf/gS4WBjp9bjbvyl+spaRz
	lM9PpaT/Uc6cwzRoe/5rVdkqMeaSyLiI//+DKsIFXbQD22JbLGn9r3wcnxd1weezTjbQl6iU2Yw
	L8QbvFpATvL0ncqGXyE2rK3AcjmoRPAidhn8OKBNTFJmYOrr/0t4ZVQtOmiNaqxZE7pFzhdf2kk
	TzcftriGylU2ouvV8kwYNffZNwLj7ajjB45fxutJQi6E0FLW54CoPBzgelBIqccxT48SB9xtg65
	/yfzfY2yRw5cApydvMBbW4u5YwOUKCDcOFXv/wEiyH1K8sL8iMmRvYchskRkMPLLhEk=
X-Google-Smtp-Source: AGHT+IHgfUjhe5piUBHcuQNK/0nrtm0tXgcRsbtKkH28640CNrWGf0iRv7DTvT+hKCAanahN8yWIzA==
X-Received: by 2002:a05:6a21:329a:b0:215:d611:5d9b with SMTP id adf61e73a8af0-2188c240698mr21613605637.12.1748362774298;
        Tue, 27 May 2025 09:19:34 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52e0:fc81:ee8a:bb3f])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7462aefb414sm1118121b3a.34.2025.05.27.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:19:33 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Tue, 27 May 2025 23:19:03 +0700
Message-ID: <20250527161904.75259-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527161904.75259-1-minhquangbui99@gmail.com>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
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
 drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 57 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..a9558650f205 100644
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
@@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 
 	ret = XDP_PASS;
+	if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
+		goto drop;
+
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* We are in zerocopy mode so we cannot copy the multi-buffer
+		 * xdp buff to a single linear xdp buff. If we do so, in case
+		 * the BPF program decides to redirect to a XDP socket (XSK),
+		 * it will trigger the zerocopy receive logic in XDP socket.
+		 * The receive logic thinks it receives zerocopy buffer while
+		 * in fact, it is the copy one and everything is messed up.
+		 * So just drop the packet here if we have a multi-buffer xdp
+		 * buff and the BPF program does not support it.
+		 */
+		if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
+			ret = XDP_DROP;
+		else
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+	}
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
 
@@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
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
@@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		return -ENOMEM;
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+	/* Reserve some space for skb_shared_info */
+	len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	for (i = 0; i < num; ++i) {
 		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
@@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
+	dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
-- 
2.43.0


