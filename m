Return-Path: <bpf+bounces-14150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA367E0B11
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B9D282040
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745124A0F;
	Fri,  3 Nov 2023 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="U1RtmWsd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E7249E9;
	Fri,  3 Nov 2023 22:28:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D7D63;
	Fri,  3 Nov 2023 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8tYDaJ2/AsaZ80JHKT7glA/dUH65icmOA0cpg0E4oJ8=; b=U1RtmWsd00CCrIXQ5txYv4pM1N
	X51bUjmeRgOhgh7yczYgQ2qn61JbNAB80L8eUSsDJwYCvFXqbZOFtqPJ5jpPCjP9KQ89o/YCsMJkZ
	YSRee5z72Nhmnuxw/4gRNBWeD1oQsOJo6bAZw9KXMVaH8JtRLcg6b0sI2yC4yzTxgp5EAnI+nrHq+
	/3CVKaXgxsBVnGaZ5K3jB9Ld/22YTVV+Q6aFNBNnHNmjoK/Je9cE1qqyFVxjpH0grCdVJVVHjv14/
	IxRqpzwLaCXvn2vo6foZi5lmJIOVIX1TS8eyxrOgwzUdvyQ1GYtVU9KTME2j5BywUrU8keRZA/4rH
	Mugfgb/g==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qz2dx-000Cpv-Qz; Fri, 03 Nov 2023 23:27:57 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Peilin Ye <peilin.ye@bytedance.com>,
	Youlun Zhang <zhangyoulun@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 3/6] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Fri,  3 Nov 2023 23:27:45 +0100
Message-Id: <20231103222748.12551-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231103222748.12551-1-daniel@iogearbox.net>
References: <20231103222748.12551-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27081/Fri Nov  3 08:43:47 2023)

From: Peilin Ye <peilin.ye@bytedance.com>

Traffic redirected by bpf_redirect_peer() (used by recent CNIs like Cilium)
is not accounted for in the RX stats of supported devices (that is, veth
and netkit), confusing user space metrics collectors such as cAdvisor [0],
as reported by Youlun.

Fix it by calling dev_sw_netstats_rx_add() in skb_do_redirect(), to update
RX traffic counters. Devices that support ndo_get_peer_dev _must_ use the
@tstats per-CPU counters (instead of @lstats, or @dstats).

  [0] Specifically, the "container_network_receive_{byte,packet}s_total"
      counters are affected.

Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Reported-by: Youlun Zhang <zhangyoulun@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/netdevice.h | 3 ++-
 net/core/filter.c         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a16c9cc063fe..fcfeaedb1256 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1408,7 +1408,8 @@ struct netdev_net_notifier {
  *	Add, change, delete or get information on an IPv4 tunnel.
  * struct net_device *(*ndo_get_peer_dev)(struct net_device *dev);
  *	If a device is paired with a peer device, return the peer instance.
- *	The caller must be under RCU read context.
+ *	The caller must be under RCU read context. The driver implementing
+ *	ndo_get_peer_dev must support @tstats packet accounting!
  * int (*ndo_fill_forward_path)(struct net_device_path_ctx *ctx, struct net_device_path *path);
  *     Get the forwarding path to reach the real device from the HW destination address
  * ktime_t (*ndo_get_tstamp)(struct net_device *dev,
diff --git a/net/core/filter.c b/net/core/filter.c
index 21d75108c2e9..7aca28b7d0fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
 		skb->dev = dev;
+		dev_sw_netstats_rx_add(dev, skb->len);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.34.1


