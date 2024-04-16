Return-Path: <bpf+bounces-26907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B748A63AE
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4141F21F60
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B356F06A;
	Tue, 16 Apr 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC/3s/M5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F36EB59;
	Tue, 16 Apr 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248401; cv=none; b=KGcE793YI9OmHSh+3TUgqSeED1IwCM6BC/mf6mmvf+1P3PUsKuqdBspbJ/CU1OHYjRJO9edCmU4s5fKga9sQs2nNm3SpcjXWqEGj9I4uhsoQm1dePTYHAtyiON0jq6SqfNQ3Ou67UlNhEsVUssFfXj84G/JT8nkErwN+QeGgjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248401; c=relaxed/simple;
	bh=5libF+8hh3TL7tmz0fygEpN1XEmmSu9D/V7nn3/kmg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s7TJKKQaOZmkMSIXk+ee4jP3AlupWqvh/pNc+IXpat9XCXrpdcGh52lgZ7AuDVFQ6sxyVjwMTn7Q+ZzNe+Z/HEZUv+oVQai3E6Od6/14P+N6jQk3yegkbZ3aBXo/B3jI8gtW82LWheVHacTYvbdQYDwEuLSmXOgmuXuW+SBnYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC/3s/M5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c6f785208dso606463b6e.1;
        Mon, 15 Apr 2024 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713248399; x=1713853199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkzd5w1QQiYFlbRgjzY4vgNg7bOQ7GZARMu1hSWDq2A=;
        b=DC/3s/M5+ogIV89Eu8lqGXLza3sRajQXeucKwSI8D4etdIN+vyco8bd7DNr7eqe/qV
         wm4RNUlDUrVrm6p57jxs/kaHbNHNx8GPVK7LHK9Yk6O4pDYPKYYEEcPzO/V0FNde3JnN
         7FmLhspCM4A8TU5RXAO74GDNqKF45RwmXDIvECNpD3Ob6Sbu4Ov8n1bxyE0oArgQDONq
         vI2yILtipTLyANwQo2mYZVIFFWCKLREn/a/zP0BZAZsbfwAywjsgD8kh/kL0J8/be235
         9Sitp/t58V+CzTWLGhYprlY1HLBo7uGp57fYZbMtZroM6eZvexoH2B1WkMuQkai9U5Ta
         cJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248399; x=1713853199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkzd5w1QQiYFlbRgjzY4vgNg7bOQ7GZARMu1hSWDq2A=;
        b=jRXZBAKHSRQ8cvBSuEKOSvkZGMdBidfIFQu4KUyTDLDMqqBfYn6V50f9EEl1PUb0sw
         RL8XRV0xU4wdJv7aBQ1lfDbkQrOTykKu5K/9pIgjNp9n31yUc6k3/GnidUxjbMm68HPy
         TizXxrcFrnkHVgl4sQnpaJwyaYzcBU5Rtq0QrR9uYSUPtP9ps597s5NfnUDp0n9+6lKQ
         YKWWqDcNB4h8A2fahwPoVfjTuQpD5oGRoA1wvuso/WIjz7zXn5XLbF7s5UVm1EEZ/Ro6
         t2w0iiQhdMbmePMXbK9uAOwS4hGMqDWy5MLxYvqHhgoNpY2gJTH3yUXpc8haPt5SYQ45
         p6aA==
X-Forwarded-Encrypted: i=1; AJvYcCUvYpfFZUt3kGZW0gwXkAnQCLhiEkpQMSKigtCbdlJQEALQwiXGDg64U0n5U44kfeW+fBhoEZ2L38BgUgzyxT/Y+JpHcoAD8xTxUasWjAoAzIYf6RmxhposyKGnOuICbHGx
X-Gm-Message-State: AOJu0YzaRYx+kWXzx7VfmqwVZoqqT3A34q41KWRhgpngozhylUlElRzr
	/+2S1Y2rf+hwEf7cVFjEW5H9C9fgtcauMC1UiCNg+rJ46Szjpl++
X-Google-Smtp-Source: AGHT+IGTkeE2Qjnfg0ozjPDsXrqLB0bPuKPv9epzqELVHCsVzN8HvsXh3pGhutgvU87N1jOlyeX6zQ==
X-Received: by 2002:a05:6808:20a3:b0:3c5:f495:b8df with SMTP id s35-20020a05680820a300b003c5f495b8dfmr15444511oiw.11.1713248398778;
        Mon, 15 Apr 2024 23:19:58 -0700 (PDT)
Received: from dell.. ([111.196.36.81])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056a000ac900b006e647716b6esm8487134pfl.149.2024.04.15.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 23:19:57 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
Date: Tue, 16 Apr 2024 14:19:43 +0800
Message-Id: <20240416061943.407082-1-liangchen.linux@gmail.com>
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
  Changes from v7:
- use table lookup for rss hash type 
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
 drivers/net/virtio_net.c        | 42 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..1d750009f615 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static enum xdp_rss_hash_type
+virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] = {
+	[VIRTIO_NET_HASH_REPORT_NONE] = XDP_RSS_TYPE_NONE,
+	[VIRTIO_NET_HASH_REPORT_IPv4] = XDP_RSS_TYPE_L3_IPV4,
+	[VIRTIO_NET_HASH_REPORT_TCPv4] = XDP_RSS_TYPE_L4_IPV4_TCP,
+	[VIRTIO_NET_HASH_REPORT_UDPv4] = XDP_RSS_TYPE_L4_IPV4_UDP,
+	[VIRTIO_NET_HASH_REPORT_IPv6] = XDP_RSS_TYPE_L3_IPV6,
+	[VIRTIO_NET_HASH_REPORT_TCPv6] = XDP_RSS_TYPE_L4_IPV6_TCP,
+	[VIRTIO_NET_HASH_REPORT_UDPv6] = XDP_RSS_TYPE_L4_IPV6_UDP,
+	[VIRTIO_NET_HASH_REPORT_IPv6_EX] = XDP_RSS_TYPE_L3_IPV6_EX,
+	[VIRTIO_NET_HASH_REPORT_TCPv6_EX] = XDP_RSS_TYPE_L4_IPV6_TCP_EX,
+	[VIRTIO_NET_HASH_REPORT_UDPv6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX
+};
+
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+	u16 hash_report;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+	hash_report = __le16_to_cpu(hdr_hash->hash_report);
+
+	if (hash_report >= VIRTIO_NET_HASH_REPORT_MAX_TABLE)
+		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
+
+	*rss_type = virtnet_xdp_rss_type[hash_report];
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
@@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index cc65ef0f3c3e..3ee695450096 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
 #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
 #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
 	__le16 hash_report;
 	__le16 padding;
 };
-- 
2.40.1


