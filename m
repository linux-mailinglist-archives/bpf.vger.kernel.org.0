Return-Path: <bpf+bounces-21050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811C846FEA
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B561C26065
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BF13EFFC;
	Fri,  2 Feb 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnAxyBHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890517763F;
	Fri,  2 Feb 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875942; cv=none; b=M19ZPQ7xzl7RoBVzFT7BwusY2bH8+2pxl+P+vHTJzfQMnZ/aSlVrGc9Kdmqd2wXgllN251uzw991oJtg6aEsUHjp/bgUqIIzcPbSV+x3N8nMqV7TrGt+eH2CDplTfTAf6HUeDh8XwsOs8vorld4zjsnwsCyK8e4swQQ8DMGiHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875942; c=relaxed/simple;
	bh=a9eZ3HwZqknc2zSUiPF7zrzeeDIadP3YgWXx4c2KMEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XGg8YGGZi7/CsWI6mZVW5ImmOlsvzbfN2dDzSBUZOzIL++vk87WeC4q6K738p6OvyZqzVXoIYJtYlKEJZYMxvM4O1gr53PvUPwz+nQkATQI2bYIl+KSXlHciCpeKvPyHVBItfyJYQ08tJpfvs3EIJ1D7yJvWQRrPjIqKAiX5yYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnAxyBHN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2963cc5e8acso493611a91.2;
        Fri, 02 Feb 2024 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875940; x=1707480740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp4NtNxYlzNA0izlG+RC3HpTc1kBomDDT2kwsWF7TfA=;
        b=SnAxyBHNT4oOOOctJOx9w+Mig/CvqkM9lTcPS8gP7Qf2f7XVSMsS4H8v+noaGlkoPa
         5e97xio8l9CKVAS3LczlbjENnXgSNB7+Z2tzh9CxDYZfmVtQUevaBrRR8rPeGkExhHXi
         +hcVo5eDk19a53QyRfkWVf6HV7s3BtKSm6d2Rn02BP4PFF2mPSuaR/WkefPAzeouSadl
         UeDKstxflMVsC0V2adwuX6VP6RB4kKBbI6D1vN6uxDcSz6YCfLor0VVuLL08mlKnG+oC
         xELhIylW9pLz63gpIvT63aTbTdYzr48bwya21uQiGGSvqFSDKXprqeRCIIv1M0Ky+EcH
         02bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875940; x=1707480740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mp4NtNxYlzNA0izlG+RC3HpTc1kBomDDT2kwsWF7TfA=;
        b=U1tOJk5MZ91QkNo4qrg0Kq4TVwek/XQEDi/5frBPYWH4i4QAOpxaDX3sqYKBUCR33M
         FAXPbvqvWLrtWSjojv6QtGvRYU/6LufbLbqqhLrohozPqdOzXPEf5amETMjx7wIScJl+
         bVdMpTvjAIeTTc4QPgyvOOXAjRi3L/mepSXrJ58d2muipHgseKTyUMBfzArno4RxFrPF
         91ENH164Z2E8Rcg9nC15ztvhRlLI8ZRnFSgnqFBIiZBagOEHtslOwhNW7RukN1kvZuk+
         Ty00AtZh+K90NGBQfUijc7jxWwww0+Wb8uxxp3zaJ1lSeTdoTJ86gxvIRratKZGNFCeC
         OSVQ==
X-Gm-Message-State: AOJu0Yz9AQpCzxpCQuxDLnQWBYqCwu9ruDssVjBLoHTLHZPK6/B/Ukyn
	Mld5sbf8s7ei4Ky8nJ/QyteTdtk0LhWjFgk9QqJOTMIT1IN1C4uR
X-Google-Smtp-Source: AGHT+IHbNl+xYDhZMNwS0biNacc4HKo9IpZ6rlRKwkdYCvw9+FcE5yGo1gU4FTyuDk5126lWVrueEA==
X-Received: by 2002:a17:90a:8c0c:b0:292:65ad:d57d with SMTP id a12-20020a17090a8c0c00b0029265add57dmr1814551pjo.33.1706875939783;
        Fri, 02 Feb 2024 04:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlc7xtMJCqVVmNNR1LZCmYhIDW4YhAwjf+k3EKQGLxkeHFBbeFE6KRZcZpuLTarJznE9wvxLgphDIC6or8fDXd6rN6QcXJVsiavNTyYV04Ey+rTGMhwTDWFOA1DfTzvm/bGguv7V28KFJcN5S8hRvh4dfXXMb4IBXZHcKvEFYuJg91TZnsJH9Qs/JGJKs3wFt51PL6fU5NHAIOlkTeelkm1oq7g8RzaYN4jNCjogk9nWMd70MrHhThARZOLqnPbDDVMCEiOSAd1nY8NmOKMdseEXYD0eCEsY/96UCnqTFJC7wkDFlGwZwEay+RdhMOZCV0U2HLU7ZdNIZzPYw/y2No38pXDXixQ8jowpDp/fdxxJf9t+zFSGLM6TBGs8y8zhrL9d4prNHh9Jsf5EwOuNvtFwiuS24uSiXyh6Kn9irHU+D8zpQmIAZN/QOvRoucOmOaVxar6rfJOBJJKD16ZE33pWplCZL01VHR1ml1lh6e1XU2WvVm53HOOvOZmgVjv7StVmzRCJw=
Received: from localhost.localdomain ([108.181.46.194])
        by smtp.googlemail.com with ESMTPSA id eu11-20020a17090af94b00b00296521d8ce9sm92804pjb.0.2024.02.02.04.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:12:18 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Date: Fri,  2 Feb 2024 20:11:51 +0800
Message-Id: <20240202121151.65710-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing
XDP hints through kfuncs to allow XDP programs to access the RSS hash.

1.
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
  Changes from v4:
- cc complete list of maintainers
---
 drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..7ce666c86ee0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	__le32 hash_value;
+	__le16 hash_report;
+};
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 	}
 }
 
+static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
+				     struct net_device *dev,
+				     struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	if (dev->features & NETIF_F_RXHASH) {
+		virtnet_xdp->hash_value = hdr_hash->hash_value;
+		virtnet_xdp->hash_report = hdr_hash->hash_report;
+	}
+}
+
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
+	struct virtnet_xdp_buff virtnet_xdp;
 	struct page *xdp_page;
+	struct xdp_buff *xdp;
 	unsigned int buflen;
-	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	unsigned int metasize = 0;
 	u32 act;
@@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp = &virtnet_xdp.xdp;
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		len = xdp.data_end - xdp.data;
-		metasize = xdp.data - xdp.data_meta;
+		len = xdp->data_end - xdp->data;
+		metasize = xdp->data - xdp->data_meta;
 		break;
 
 	case XDP_TX:
@@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb))
 		goto err;
 
@@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
+	struct virtnet_xdp_buff virtnet_xdp;
 	unsigned int xdp_frags_truesz = 0;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
-	struct xdp_buff xdp;
+	struct xdp_buff *xdp;
 	void *data;
 	u32 act;
 	int err;
@@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	xdp = &virtnet_xdp.xdp;
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
 		return head_skb;
@@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(xdp);
 
 err_xdp:
 	put_page(page);
@@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
+
+	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	switch (__le16_to_cpu(virtnet_xdp->hash_report)) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		*rss_type = XDP_RSS_TYPE_L3_IPV4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = __le32_to_cpu(virtnet_xdp->hash_value);
+	return 0;
+}
+
+static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
+	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.42.0


