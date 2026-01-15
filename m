Return-Path: <bpf+bounces-78992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C2D231FC
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC5E30EA26E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2263314C8;
	Thu, 15 Jan 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FmsBICbe"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C3326D5C;
	Thu, 15 Jan 2026 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465588; cv=none; b=O9AgF3h9qUpskElBPCf5beQXL5EjCB3ZMbCGrVv35Y8L9LeLKgX7SuN/ax7uS7zM4lNj2/Qs0iscGi5yu7oY9JyWn8gv/6Dlj2F0XfojFoiwphgJUopHDN8xmx2ea6iD8VofoG2PziKfMtPDnfJVDnauUGEss2yWn+vnWwF2zE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465588; c=relaxed/simple;
	bh=deHERidX6Uj50jqArC5AnAHfZyrBeWMJABClTGf0c9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPWrvc9iYegpkLlYtA9mY0kzcdu4bvSF08mM8CJytlg3yxlK79pXdPr9QkySLlYY3kcEutdgyM50fMKv69nIkZOmLHVVx6XrG1ucppcYd1ht3xb86s3xE2Is4p3Ck48avGHzx2oYt4F1HsN26D1+SdaD7oNIj8GifeYEHkrpTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FmsBICbe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jKRcqnAN1FejFT21FpY8AxftZkZMdt43RnsJvrkKQQU=; b=FmsBICbeY4mWZKcIr+cNCff1y4
	paQss6DSn/Zlq1KmIhp0bVpzyv/+ARgbSRG5f/GcojEu24ziBFYDNZPryAJY11SYTUVbagAErTVAB
	q+djdsVJUM01uFwJFOBbc/nF56jCWRXJ90xdxmuMHkyMNuyemaWdFnqN8iJD/cloDTUhTZB99GUbZ
	9+PcLPyh8cw1VKg0VuXpG+Cu8r3xf/UpjOTHAg8rtHVKG5ZPCNd446TkZxrgGnNRckte0OgyGkjTk
	j01Cxsi14vL2T20PSf9n3xGiIcWdIYnEVNy1ScSxpFtiXZky9rSISw8xIbVyOPhsZDrC4FTvxXitS
	7tV1wNpg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgD-000NpU-25;
	Thu, 15 Jan 2026 09:26:09 +0100
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
Subject: [PATCH net-next v7 04/16] net, ethtool: Disallow leased real rxqs to be resized
Date: Thu, 15 Jan 2026 09:25:51 +0100
Message-ID: <20260115082603.219152-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

Similar to AF_XDP, do not allow queues in a physical netdev to be
resized by ethtool -L when they are leased.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/ethtool/channels.c | 12 +++++++-----
 net/ethtool/ioctl.c    |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..797d2a08c515 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock_drv.h>
+#include <net/netdev_queues.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -169,14 +169,16 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
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
+		if (netdev_queue_busy(dev, i, NULL)) {
+			GENL_SET_ERR_MSG(info,
+					 "requested channel counts are too low due to busy queues (AF_XDP or queue leasing)");
 			return -EINVAL;
 		}
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9431e305b233..02a3454234d6 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -27,12 +27,13 @@
 #include <linux/net.h>
 #include <linux/pm_runtime.h>
 #include <linux/utsname.h>
+#include <linux/ethtool_netlink.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
-#include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <net/netdev_lock.h>
-#include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
+
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -2282,12 +2283,12 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* Disabling channels, query busy queues (AF_XDP, queue leasing) */
 	from_channel = channels.combined_count +
 		min(channels.rx_count, channels.tx_count);
 	to_channel = curr.combined_count + max(curr.rx_count, curr.tx_count);
 	for (i = from_channel; i < to_channel; i++)
-		if (xsk_get_pool_from_qid(dev, i))
+		if (netdev_queue_busy(dev, i, NULL))
 			return -EINVAL;
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
-- 
2.43.0


