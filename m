Return-Path: <bpf+bounces-33942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A39282DE
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D81C24451
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980514600F;
	Fri,  5 Jul 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f5ChZaay"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FC14534B;
	Fri,  5 Jul 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165066; cv=none; b=aV5k8NHVdW/lBSUO7Ir8OSqqblriqqr+muTW7ZLP7xCaNT4nil9QAgK3f0zlLpGHS2vaE4fc6UB/mNqavnkwdSAnfJKL+ip3fyoF9KfISnEvSraYrESbPl/byIfKXHf/WE6ZByxtRln3YegimAdbCHNnc/DMUS1yZ8h0PcD3uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165066; c=relaxed/simple;
	bh=IV40QPdhsyLoYmU4imjg3UYnG7CDYoFS43lM0om6mkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1ey0zvfmArCbmZrudOUZdgIW+x6+nr9gdPfwiS5wBQVLT2VC7e8c2Uf+Zb5uBTWQ8Orq6ntoDV1jk9HY4ZBxw+jzSgVaJd90aSc05KwfoRtHdhjQ3MVPUt4DhxHOFha0hFoEpkqNUE5HFogdZwPrlLAc+vUmJ9nlPXJQ8H8r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f5ChZaay; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165059; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QkrRXTCDLDlphnBuelc6bjg4YI24a+uIVOKNzc4W2sM=;
	b=f5ChZaay7lYMfCNRV9+IT01iVag+Fi9ExXQnfjM2Pypmle2JuQmARAuSUQDxkDu2Gg/iDPoVCoMVJeJa2FsVyn5ZtG3xsoCXEOuimU6/OIIbSXkR2g0+2wFSxiYL46qSUlrzPXPQC0qJu4eV7ylSaNNYAQy2bhM4q+SmEwTDngQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9u5R-9_1720165058;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9u5R-9_1720165058)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:39 +0800
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
Subject: [PATCH net-next v7 04/10] virtio_net: separate receive_buf
Date: Fri,  5 Jul 2024 15:37:28 +0800
Message-Id: <20240705073734.93905-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
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


