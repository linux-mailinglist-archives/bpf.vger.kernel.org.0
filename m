Return-Path: <bpf+bounces-34063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968292A10A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACBD1C21136
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECB7E10B;
	Mon,  8 Jul 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kA15+Rl+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DC7D08F;
	Mon,  8 Jul 2024 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437949; cv=none; b=dUMAMPnDrjKitX0QqDTSFezvtGpxHBo9RM6+5kEsooOjqmH7NtCGyfYNuga70Hua4XWTc/BfXCHHDgWg9DlSR47SL1cEcwksblEasm33qUmgwARwPTDMhu/FpiQc0r3JN+wud7OkXLFBHZ3Suam/Y0cKiedh4cgfqo9E8Pi91Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437949; c=relaxed/simple;
	bh=IV40QPdhsyLoYmU4imjg3UYnG7CDYoFS43lM0om6mkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0BTCQecff6NR6VkiMnhl53vUa28urck2BA+ZF/OHKGSC0HkmWlqNj6oR7cP2+M7XY4rPDMysshI1se2RhKJw2P77vM43VuiRaaoeqk7CfghU7dkNf6bKl66wrAKmFMilUSjlvsnlq+gSDIsdVCYSzzhB3Ze4AuuzHc1QCX8YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kA15+Rl+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720437944; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QkrRXTCDLDlphnBuelc6bjg4YI24a+uIVOKNzc4W2sM=;
	b=kA15+Rl+hPwykEPPCZTAqo9pudHWHsrIinX2e1c8AbUto+00anx6BGiRiBPlV1RdpH+DfVDuD+W+Y8u/kZvF2Xp/D9cAD++T//LxshfgTigVhs2XHMo/YLoWJvAwZjycK1YzBohEH0H/spcQdHsp8mS9lQvE/iR5KHAPQUWnOdI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA5oE71_1720437942;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA5oE71_1720437942)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:42 +0800
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
Subject: [PATCH net-next v8 04/10] virtio_net: separate receive_buf
Date: Mon,  8 Jul 2024 19:25:31 +0800
Message-Id: <20240708112537.96291-5-xuanzhuo@linux.alibaba.com>
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

This commit separates the function receive_buf(), then we wrap the logic
of handling the skb to an independent function virtnet_receive_done().
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 62 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d762614113b..abfc84af90ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1968,6 +1968,40 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
+static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
+				 struct sk_buff *skb, u8 flags)
+{
+	struct virtio_net_common_hdr *hdr;
+	struct net_device *dev = vi->dev;
+
+	hdr = skb_vnet_common_hdr(skb);
+	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
+		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
+
+	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
+				  virtio_is_little_endian(vi->vdev))) {
+		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
+				     dev->name, hdr->hdr.gso_type,
+				     hdr->hdr.gso_size);
+		goto frame_err;
+	}
+
+	skb_record_rx_queue(skb, vq2rxq(rq->vq));
+	skb->protocol = eth_type_trans(skb, dev);
+	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
+		 ntohs(skb->protocol), skb->len, skb->pkt_type);
+
+	napi_gro_receive(&rq->napi, skb);
+	return;
+
+frame_err:
+	DEV_STATS_INC(dev, rx_frame_errors);
+	dev_kfree_skb(skb);
+}
+
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
@@ -1975,7 +2009,6 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
-	struct virtio_net_common_hdr *hdr;
 	u8 flags;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
@@ -2005,32 +2038,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!skb))
 		return;
 
-	hdr = skb_vnet_common_hdr(skb);
-	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
-		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
-
-	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
-				  virtio_is_little_endian(vi->vdev))) {
-		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
-				     dev->name, hdr->hdr.gso_type,
-				     hdr->hdr.gso_size);
-		goto frame_err;
-	}
-
-	skb_record_rx_queue(skb, vq2rxq(rq->vq));
-	skb->protocol = eth_type_trans(skb, dev);
-	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
-		 ntohs(skb->protocol), skb->len, skb->pkt_type);
-
-	napi_gro_receive(&rq->napi, skb);
-	return;
-
-frame_err:
-	DEV_STATS_INC(dev, rx_frame_errors);
-	dev_kfree_skb(skb);
+	virtnet_receive_done(vi, rq, skb, flags);
 }
 
 /* Unlike mergeable buffers, all buffers are allocated to the
-- 
2.32.0.3.g01195cf9f


