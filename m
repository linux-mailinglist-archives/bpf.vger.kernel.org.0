Return-Path: <bpf+bounces-26703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E408A3AFA
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 06:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E6B1F2324C
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 04:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F051C2BE;
	Sat, 13 Apr 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsJy92Sd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18781BC3E;
	Sat, 13 Apr 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712981491; cv=none; b=Rwi23q90lPH/zN8eG5TL708WYNlmHiWTLJRKXf9GVms5K1pQ2rSViDBZ5A1wRFV2WAwI13Nr5a7ab4Nh96IK0TOoW+cJEFkFVxoRGMYP78Xoyctgp0gGQa0RjcNhIebdQl8rQXXjSDRswF7HmNwQNRCCiHuUEjfFXFAQTIeGHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712981491; c=relaxed/simple;
	bh=AfPGdpoeXhVGR+SHbrTki7kqPG4xqSDp/j1KG2K2pxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfGPjEJICAs+Gzqw+6L3UwLntS7vGVVxVEt/QH6JyQeKP2y6fLDdbNVbTu0DQT1IRtI7RREYqlAv11MRzJqpelD9M2FE3jlqSs0/TKoSFZELuKuxEUdlh3k9KSj6PYHBUkA6DpHjoyAaIoVXhUM5O8J4OWvyxa7AIS/WqGwESkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsJy92Sd; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23319017c4cso969751fac.2;
        Fri, 12 Apr 2024 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712981489; x=1713586289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDhCSWEgnV+NzpnZC+839Wmob9VMoO2EjVmXGFw60QM=;
        b=fsJy92SdASlRp4ceIXK8tDG7RmaqnR+JTDhucQXVIlwMMyKLJ2bI/RFLx83AkWLQZU
         g0cqca1VsapH7j9WsoFqsg0W25tplq8axLI+BoD6dZ2SyCdQBJt/x2lZLzVDw9DZV/dd
         Gu/dSjwvxcHORA1lEFkHJ/of5QVfnIsEd8Rwq20HqOqOaDou+aLEePJhmgoIQ4rer4Ep
         75VE+bkfHV3lsUB45Pf8lfp/7LR4HyjIBJSdNrrsQBnOAco4BaJMUaqQxOafV9Eyenee
         noOfqZV+8ziwUw4EUiiXIHB6UtfXE0NCeC9y+LETaSuryrhd9ZvkWMc7Q4BJgW+/Mh5s
         HAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712981489; x=1713586289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDhCSWEgnV+NzpnZC+839Wmob9VMoO2EjVmXGFw60QM=;
        b=rmEYQEqZXHTcQk4W/BbkVwCFT+WBSk3Lg+V5mW0zO9Pe5f0thEJKHkWT8dylliQBlw
         sm+hJnI6yPxvZL1tP1+CLRBppKTMObtkzI2M0BfFxt4nB4muF0paGDyY4Xp6NRXgXt4D
         ZYYhz4pm6YrCtvgHsizPsuhXzk+vwTjz1LE0zxxSsTOJnErfOOBE5ig9h+BZVzElERgk
         nIdScbyBBN/040rUoIthAe2Aaxiph97CrItZzunrb+wOpf8n4WglIwikSphps+RsThjw
         K7nGNKuPS2QNhIpPMYbcHMn9Nt4B63C2yQ/Z1+0ah8QlEQelTb7/PoyUV015Uu7tX4en
         Uhxg==
X-Forwarded-Encrypted: i=1; AJvYcCUPbVL08yHQ6UFbnMPIyc4oLIbl+be6CqqsmuxfXsyIxFUOq16WRSQJcKYVCko9vezDz5/faVaN1f+Ty9QXaFzVmym5xbLbOahhrCOjSmCZ84InS2YTRqQOKFt/oNoFfSwd
X-Gm-Message-State: AOJu0YyTPgqk0+018E2eEnVqEe2fHyvHwQkzrx8yvsgRedgDZVyYZJR0
	nzpnFInFjmf7isLv82DOaAcWxfbsNfkS7SkmUrOcuEg1xJn61Mnx
X-Google-Smtp-Source: AGHT+IE+nEAWcd0+Z2P4/AV17wHWyQPGohLUz5foVK2JC1p4PEX3jDqCCzVk0FB1zWXVp5Fn7Jr8DQ==
X-Received: by 2002:a05:6870:5488:b0:22e:cbfa:678d with SMTP id f8-20020a056870548800b0022ecbfa678dmr4605735oan.57.1712981488680;
        Fri, 12 Apr 2024 21:11:28 -0700 (PDT)
Received: from localhost.localdomain ([123.116.201.21])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78556000000b006ea81423c65sm3722131pfn.148.2024.04.12.21.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 21:11:27 -0700 (PDT)
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
Subject: [PATCH net-next v7] virtio_net: Support RX hash XDP hint
Date: Sat, 13 Apr 2024 12:10:35 +0800
Message-Id: <20240413041035.7344-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
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
  Changes from v6:
- fix a coding style issue
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
index c22d1118a133..2a1892b7b8d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
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


