Return-Path: <bpf+bounces-26498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BC8A0BA8
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB74D1F2557D
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11714263A;
	Thu, 11 Apr 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWj0pMDT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D31419A6;
	Thu, 11 Apr 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825587; cv=none; b=Ids8cFcSlwsYb4BvGXNOBTJpfPFLTU1ueEVcCf7LkPr/q4OOL0kf58j2m3Zek1kXcCt3o11Mj15rToH4ekcatJAcU5QpSGRIihi9dkGZRSihTkraDvbr5Y1m9+bEZjuvueGCwn9ZkHMIrYwCYdZjBxB6tvbeKo3PB+Czt0CVNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825587; c=relaxed/simple;
	bh=io9LKvvXimYbev4Iml4NKxNJy86/qa8clb83Jlhvc2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPScXYq9FBHQ37ZJCue6DrB8vIyKEY8Db0rTRQtfmyimRLyZXNMJOaDPkP+RvONgi6NzfgKZJ3mJsbslpZpYbRj9NzPqaowQlZvKRUqEeI448EwoQDnzp/MkfC0uLgpJaaSJFcO9hfMnYHF4YbcbN4gU+Oe4yYW74dE9q4rPsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWj0pMDT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a58209b159so1725595a91.3;
        Thu, 11 Apr 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712825584; x=1713430384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ya5I5hvjUcaAqlpM5swpRYtJfi5w+dWzk4Fz+t660Ec=;
        b=fWj0pMDTjAdkUv5+DmM2PHtR6UEWwt8i8e7QDTipFO6q1Dtcp5h9ESC9VA45otWWSS
         squiWcue9Ok8HBVCbb7vEvDUlqzlARPBj0ZTfxuYerq93t+BQnE3ExCD6JhOJ9SgSw52
         nDWjFaDjZnd5wSeVFM3SXIqJJHYSjNFaLRdbgL/leStTsr5RdBhQULO89yVcKfYZkT1i
         TZFBV/G1Oh7Hdw4mSKu59NDte0J42wtieItOBmjYuOGF7w6CXp6KbY5/UAxK5HVUV9BZ
         ddRyybjEQgqDAoHG0iepsD4a0r9o9/Jx4HFaitRfJOKEJblsoZiAh5ha4aWwKac7HzPX
         Bj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825584; x=1713430384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya5I5hvjUcaAqlpM5swpRYtJfi5w+dWzk4Fz+t660Ec=;
        b=CXQM4lI0PaTAiM8JlryLLLZEPm4VnqnH51kMGcWGA8SuI2xmJuxClS/sqDHN+6zJoU
         PIlCzS5QdxvTWRj+Rm1lBKF/X8b2nghsXnHZH6SHm2IfbJX1igRcDFRgzS1M/gXxcUop
         vZQsyZ+Tr1i7lmPtOpcyqiq+ZhSb0fohGTd94eQnbNGFlmqY1Rq1yA04HG2HJHkgxtHN
         q0ZBVynRuP/TpBeJORTbM0zPLkEZLWDXcOqbxXjOzexK/Oi6IIClXS0RbpyBBItNcUA1
         ZC81wr0MYIMnT2d8BCmfufqZEF39Qaxx38Qo9YeBQPmWDcj0DQl9EDc5MSHdHuikl9pU
         kKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUre2sFRjTIWkytZsCzKg9MmIpz2XiKM/0qWNqnlGBva/mMmVIfW8Tqpfma92aVJQ1uUNv/88/Isg2dKZl/ez+PebI1TrQSgDpi6FdG5cJ3G13hggOwmWb5pBliaV4EgPs1
X-Gm-Message-State: AOJu0YxBnHOOlGcjz4wOIvOFWOlaybJw1XCatJDx7/DwyOpTEVKWqTCa
	1V2A/lFoLhUIWCJRUvnIqIm3/dBKPiThZOBp+PBnX52ZdIzzxzLj
X-Google-Smtp-Source: AGHT+IG0RZWIYvC1TAdiHu4GiCufqpdvQrAKxYmpsyvNmU5fmkX4L1O0eJJwfz5elYuwUFstobv+qw==
X-Received: by 2002:a17:90a:f40b:b0:2a5:d5b1:b99b with SMTP id ch11-20020a17090af40b00b002a5d5b1b99bmr3708871pjb.38.1712825584034;
        Thu, 11 Apr 2024 01:53:04 -0700 (PDT)
Received: from dell.. ([111.196.36.81])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a154c00b002a52c2d82f0sm4534844pja.1.2024.04.11.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:53:02 -0700 (PDT)
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
Subject: [PATCH net-next v6] virtio_net: Support RX hash XDP hint
Date: Thu, 11 Apr 2024 16:52:16 +0800
Message-Id: <20240411085216.361662-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
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
---
  Changes from v5:
- Preservation of the hash value has been dropped, following the conclusion
  from discussions in V3 reviews. The virtio_net driver doesn't
  accessing/using the virtio_net_hdr after the XDP program execution, so
  nothing tragic should happen. As to the xdp program, if it smashes the
  entry in virtio header, it is likely buggy anyways. Additionally, looking
  up the Intel IGC driver,  it also does not bother with this particular
  aspect.
---
 drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..abd07d479508 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+			*rss_type = XDP_RSS_TYPE_L3_IPV4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = __le32_to_cpu(hdr_hash->hash_value);
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
@@ -4747,6 +4801,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1


