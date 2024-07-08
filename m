Return-Path: <bpf+bounces-34071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC492A135
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C444281A43
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662847E0E9;
	Mon,  8 Jul 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qhr6gP97"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472741DA23;
	Mon,  8 Jul 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438263; cv=none; b=aSNj9sOtrckgcWCvTHqFV41ry7HdjIVXfuOLvpkIXPCxDVr2W9Kkgzumt4wz6zg17IEyi1Ue4gpGH/Kw37UUenbg7meJgzEYTRlN0PWD+kWtOAyfK6e7r+eUt0hTqhUEhv6RX9gkWmb665SJHSuRv/rdaXjcxY5/+WZyhqJCwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438263; c=relaxed/simple;
	bh=0jZjEaUhIa4kjMxApw45GwmU1L+qR15NukAIO2t3zHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLq15mdOYR4jqARjtXKJsD+fqvj3rMBiSaKFTp3tWOQSPybtVWAhEZre2M9pidCTnbeOJWuiw6KIB/iSBUDJf4NgNRpzmAh5Zp+90dV8kar6TJKmpqvKtXl/69jQmWjx+lU0tgLQpZdlg3rhQayrcLcXonCN8/KierCnQZop12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qhr6gP97; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720438258; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zutL2RDiLihbk6EtLlmSHI1k6TN4aKZBqoYLfKB8B0g=;
	b=qhr6gP97VvZobmJEsor+A0gML/XAqKMjAMRha/OWkTriwhYmIvbVgkb2FgIkuYm37rQifvRHwOribolGk8hfC1vElYHjeZ9looyQdelI6kPVBZKOQbccrlmxLAlcSXTUOYbCOi/QR4G6io2CUMmIIWiKIBi4pa/b6ELdAnU+i14=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA5oE5x_1720437939;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA5oE5x_1720437939)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v8 01/10] virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
Date: Mon,  8 Jul 2024 19:25:28 +0800
Message-Id: <20240708112537.96291-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 74fbc055cff2
Content-Transfer-Encoding: 8bit

virtio net has VIRTIO_XDP_HEADROOM that is equal to
XDP_PACKET_HEADROOM to calculate the headroom for xdp.

But here we should use the macro XDP_PACKET_HEADROOM from bpf.h to
calculate the headroom for xdp. So here we remove the
VIRTIO_XDP_HEADROOM, and use the XDP_PACKET_HEADROOM to replace it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0b4747e81464..d99898e44456 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -40,9 +40,6 @@ module_param(napi_tx, bool, 0644);
 
 #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
-/* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
-#define VIRTIO_XDP_HEADROOM 256
-
 /* Separating two types of XDP xmit */
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
@@ -1268,7 +1265,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 
 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
 {
-	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
+	return vi->xdp_enabled ? XDP_PACKET_HEADROOM : 0;
 }
 
 /* We copy the packet for XDP in the following cases:
@@ -1332,7 +1329,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	}
 
 	/* Headroom does not contribute to packet length */
-	*len = page_off - VIRTIO_XDP_HEADROOM;
+	*len = page_off - XDP_PACKET_HEADROOM;
 	return page;
 err_buf:
 	__free_pages(page, 0);
@@ -1619,8 +1616,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	void *ctx;
 
 	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
-	xdp_prepare_buff(xdp, buf - VIRTIO_XDP_HEADROOM,
-			 VIRTIO_XDP_HEADROOM + vi->hdr_len, len - vi->hdr_len, true);
+	xdp_prepare_buff(xdp, buf - XDP_PACKET_HEADROOM,
+			 XDP_PACKET_HEADROOM + vi->hdr_len, len - vi->hdr_len, true);
 
 	if (!*num_buf)
 		return 0;
@@ -1737,12 +1734,12 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 		/* linearize data for XDP */
 		xdp_page = xdp_linearize_page(rq, num_buf,
 					      *page, offset,
-					      VIRTIO_XDP_HEADROOM,
+					      XDP_PACKET_HEADROOM,
 					      len);
 		if (!xdp_page)
 			return NULL;
 	} else {
-		xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
+		xdp_room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
 					  sizeof(struct skb_shared_info));
 		if (*len + xdp_room > PAGE_SIZE)
 			return NULL;
@@ -1751,7 +1748,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 		if (!xdp_page)
 			return NULL;
 
-		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
+		memcpy(page_address(xdp_page) + XDP_PACKET_HEADROOM,
 		       page_address(*page) + offset, *len);
 	}
 
@@ -1761,7 +1758,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 
 	*page = xdp_page;
 
-	return page_address(*page) + VIRTIO_XDP_HEADROOM;
+	return page_address(*page) + XDP_PACKET_HEADROOM;
 }
 
 static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
@@ -4971,7 +4968,7 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			   struct netlink_ext_ack *extack)
 {
-	unsigned int room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
+	unsigned int room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
 					   sizeof(struct skb_shared_info));
 	unsigned int max_sz = PAGE_SIZE - room - ETH_HLEN;
 	struct virtnet_info *vi = netdev_priv(dev);
-- 
2.32.0.3.g01195cf9f


