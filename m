Return-Path: <bpf+bounces-73194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8F1C2701C
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFA233508C7
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B3329C74;
	Fri, 31 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eg7mRb+M"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C27310625;
	Fri, 31 Oct 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945694; cv=none; b=iZBgZfIFzUen89GOgim6J3j5UMZ7gLtXhavf0oe7Eb9oSdsnqoRdwnMgpisGKDXtGE+B/632xoK15oW48d2u38Ue7zCIQz7TcXk1lWFx65WrXNaRBuiaUOBV9NBfKlaVgNpWMuQh3lmnT89GB/HbbFcH2vtt6cdaHUvqAXNyQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945694; c=relaxed/simple;
	bh=Omk7jk0dxGCXWAhwtBEjMM94mNZdi3yja+LJywjznI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VREcJohnna0eJ7UsZAEQqL9CrfUH5BrNDo+Iwu75GKfyQbTQ7+HuG5cy5NEpofOpodGlKHlx3oWha+7R/sEcqRgA/eZ9shAs/0jsGFAN5y+jbcb1OIdphXX3357i8BJ4Mccv6cuFnC0LCnep4ZsBnlo74zeyw41vlMyEYeyzSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eg7mRb+M; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BguaqZhiXsXPHXRHzfvB17XcpR+Q9up2QBKeZB5EYFY=; b=eg7mRb+MUiuw4AKxzp7FYqy2Qy
	jKl0Ex0DXM2Ho9pVXyzM8ku0RZEdy+guZ01LoynEZA2ch8LbabWTz5r7IqmQdeWq0/RtImdtBbR1Y
	/pq4jUpTtrrmbCVR2VBBgJy1pVTHNhERMjOCyy8YrT7wcJaAvEEMoGzkH6dW2bEB8TY5bk0bidcU7
	Z3QebPlp8Lh+8lATu37Mpoebj/7XKho4EyxFCPzdR1VJ18ZwSC3FZQiizGxhJc2vf9QbJms526kss
	SK5biBPAG7KXgV5V+a1vQYqal6WKoJPv6NmrntIduelmHKtepvERo7JM9YQBZAYLiWZdz14qXobpj
	3v6Jqv6Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYX-0005cS-2w;
	Fri, 31 Oct 2025 22:21:09 +0100
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
Subject: [PATCH net-next v4 04/14] net, ethtool: Disallow peered real rxqs to be resized
Date: Fri, 31 Oct 2025 22:20:53 +0100
Message-ID: <20251031212103.310683-5-daniel@iogearbox.net>
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

Similar to AF_XDP, do not allow queues in a physical netdev to be
resized by ethtool -L when they are peered.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/ethtool.h |  1 +
 net/ethtool/channels.c  | 12 ++++++------
 net/ethtool/common.c    | 10 +++++++++-
 net/ethtool/ioctl.c     |  4 ++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c2d8b4ec62eb..151fc920234d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1481,4 +1481,5 @@ struct ethtool_forced_speed_map {
 
 void
 ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
+bool ethtool_channel_busy(struct net_device *dev, u32 channel);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..b3de8064275c 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock_drv.h>
-
 #include "netlink.h"
 #include "common.h"
 
@@ -169,14 +167,16 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* ensure channels are not busy at the moment */
 	from_channel = channels.combined_count +
 		       min(channels.rx_count, channels.tx_count);
-	for (i = from_channel; i < old_total; i++)
-		if (xsk_get_pool_from_qid(dev, i)) {
-			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing zerocopy AF_XDP sockets");
+	for (i = from_channel; i < old_total; i++) {
+		if (ethtool_channel_busy(dev, i)) {
+			GENL_SET_ERR_MSG(info,
+					 "requested channel counts are too low due to busy queues (AF_XDP or queue peering)");
 			return -EINVAL;
 		}
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..a67382c2208b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -6,13 +6,15 @@
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/phy_link_topology.h>
+
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 
 #include "netlink.h"
 #include "common.h"
 #include "../core/dev.h"
 
-
 const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_SG_BIT] =               "tx-scatter-gather",
 	[NETIF_F_IP_CSUM_BIT] =          "tx-checksum-ipv4",
@@ -1101,6 +1103,12 @@ EXPORT_SYMBOL(ethtool_get_ts_info_by_layer);
 
 const struct ethtool_phy_ops *ethtool_phy_ops;
 
+bool ethtool_channel_busy(struct net_device *dev, u32 channel)
+{
+	return netdev_rx_queue_peered(dev, channel) ||
+	       xsk_get_pool_from_qid(dev, channel);
+}
+
 void ethtool_set_ethtool_phy_ops(const struct ethtool_phy_ops *ops)
 {
 	ASSERT_RTNL();
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index fa83ddade4f8..9ed87a18e48a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2282,12 +2282,12 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* Disabling channels, query busy queues (AF_XDP, queue peering) */
 	from_channel = channels.combined_count +
 		min(channels.rx_count, channels.tx_count);
 	to_channel = curr.combined_count + max(curr.rx_count, curr.tx_count);
 	for (i = from_channel; i < to_channel; i++)
-		if (xsk_get_pool_from_qid(dev, i))
+		if (ethtool_channel_busy(dev, i))
 			return -EINVAL;
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
-- 
2.43.0


