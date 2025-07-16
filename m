Return-Path: <bpf+bounces-63431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEDB075A0
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E749E1897137
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284962F5081;
	Wed, 16 Jul 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnc0juZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBD20110B;
	Wed, 16 Jul 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668856; cv=none; b=TLnO+3LrFVqCi4iylJXoHbUch/UCLGNyB4O3Hgo0EAK2+U5X8KLhMbphmB+hX1crwTRy81YAVhtX9IVE9X8QEPaFC/egpIku/18VlDAnVN9vdv4kF/YXRq2z6J8HPVGMjWd1bkm8oHszrBCzvp6I8STP8dQyYf2eTl+m7mwke4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668856; c=relaxed/simple;
	bh=xwq/vRLbdM7WL4q5HIsuxXoQO20oEJ8lc3HqoaMuIeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhFFJAGS2YNmz4ceTZApkm28sSL+4D7vgzwv4JteFvFTIYq+N5B4INBrfCwOIVHTvSGcAAMPx1mWpJ1J5x7LDuiVSvg40vmux8HrSLEc/8kSIruqshB4nw3uvVxG0BxZ9KrQBqXPbiF2kAaMoltOo0LG68F1BxlDjEfCXPPScOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNnc0juZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5409600b3a.3;
        Wed, 16 Jul 2025 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752668854; x=1753273654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COHxjyd9TVO00pYSe36h0VbD3h6ewBA8auhnHn9D4Vs=;
        b=GNnc0juZxgbVRGyKoBRKfZNXEe6HEwkbZ13ayBioTK/lepHBZU5eoe6LLH9DAzTN6d
         dbWL1fSgXPnI5F8PpEUknKMzXaxSHaB0mPlwKwAmBsuF1uXppciVulYgVnVsOCDeWv3l
         zMLT7sH5es/csMRDOaQYQdHGImCLGrNYpqyZVe5pJfPVPYuFGMvcyJrmy+G+RD0IMteX
         TNOQ3rrIx9U12vNUDLFP3jjNzZtO5VmolIIy8amvuTbWsCB3p3DyG6VbAoHKrDJTpkyM
         SETBDBfe0J4GfNzCcQiIgF4y9Uo69iZds7uVx/bSm2DGoSuYRxA1br4PcbNulbAIhRY0
         r19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668854; x=1753273654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COHxjyd9TVO00pYSe36h0VbD3h6ewBA8auhnHn9D4Vs=;
        b=buiD7w8F12MNhgOTodLbmMvtJ2zrLiO9ZozOv4vO8Jv1F9wi+jCa3d1BzGT3nLiVlR
         RsEU/Fcv1GqPcUxx3sRrivr6uda5FOplWFTsGBAXc+4c6m0VvQ0KWXHkGrT0dyFDGG5n
         f/NLzXgpzxZLL1Y2DeClPhl6KoCaaRU/6a58zWgZQs+InQby9aGJkUVdOYcIN11TxdKP
         1FiyYQ8MwGLuQEvrXS09JqjymcVUAsdY4gLWQpYQ2hqrEXVjvCEpOcUpVtlCNjkrmY8c
         y0EN56jt9/W/hX4GqDy/Yc8gP39Qd/NgloqNtPv+HycYhwQieR+mtdVZHclRnCv3Tbw0
         rSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OVIb5c9541N/JbCLdksrE+N9YcV3TH48bDO92rg/8PT14F01eCFoGJITvACaMF70rBBBP0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuikNUenaxBGBFeQP5eWKQ8IdZD90/vJP3BGA+UmKtFFgBveT
	tPyw3sC7CTtKAPbHUH8aXe9c6/1EDWo7JsYHcwi5dtNz1BO+od86jvFJ
X-Gm-Gg: ASbGncuzngEqmSmYsqnHDschs6cBJSCiAuvbQF+jprx1lUS6pk8Bef/67VQ1dTTnc1O
	zUCIYFHXwOFTKIraZx6o1lbLIRgvWboD3cGTSRkMAEMVSeW8ZTsX9BUa5oN5XaxXhCyeCVQItro
	FLjvC5JzTjd89zMbVzxrxlh2O/u4VRd0Xs/a4P0ZGPi0Waj9zmvFhAnaQ8vC0vCIlCWUGgRDmnk
	JvZD03jn4V7MVCv6VrYLjgak7XLuqYBCUmtL0eaHqYC+spKjs4GW0tVDMmPW3g/mg5lN2Apu37k
	9aDn15p9z6O8lsYGGNm0gi4BQCXVxmGxv8T2LnQHaIq628EPUDgDdM7/mOBuPCG+NCQvCqX5TzF
	wHAUXYuAcmmgbdv1TItaYgS6Y9RWJx7EaseaVzzcF+GzMX2DBABaG88T2X4f7pkkQfh7ziA==
X-Google-Smtp-Source: AGHT+IHyJtLsZB/0aPAdoOaZcA2I1LWb6k5JcJIxHbQDwRstjmQx8MuU8sX1SNxozXJnQaCI2D6eNw==
X-Received: by 2002:a05:6a00:887:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-756ea8b5c61mr4275871b3a.21.1752668854345;
        Wed, 16 Jul 2025 05:27:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5a94sm14164946b3a.21.2025.07.16.05.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:27:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Date: Wed, 16 Jul 2025 20:27:25 +0800
Message-Id: <20250716122725.6088-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch only does one thing that removes validate_xmit_skb_list()
for xsk.

For xsk, it's not needed to validate and check the skb in
validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
and doesn't need to prepare those requisites to validate. Xsk is just
responsible for delivering raw data from userspace to the driver.

The __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
("dev: packet: make packet_direct_xmit a common function"). And a call
to validate_xmit_skb_list was added in commit 104ba78c9880 ("packet: on
direct_xmit, limit tso and csum to supported devices") to support TSO.
Since we don't support tso/vlan offloads in xsk_build_skb, we can remove
validate_xmit_skb_list for xsk. Skipping numerous checks somehow
contributes to the transmission especially in the extremely hot path.

Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
the guess and then measured on the machine with ixgbe driver. It stably
goes up by 5.48%, which can be seen in the shown below:
Before:
 sock0@enp2s0f0np0:0 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,187,410      3,513,536
After:
 sock0@enp2s0f0np0:0 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,252,590      2,459,456

This patch also removes total ~4% consumption which can be observed
by perf:
|--2.97%--validate_xmit_skb
|          |
|           --1.76%--netif_skb_features
|                     |
|                      --0.65%--skb_network_protocol
|
|--1.06%--validate_xmit_xfrm

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V2
Link: https://lore.kernel.org/all/20250713025756.24601-1-kerneljasonxing@gmail.com/
1. avoid adding a new flag
2. add more descriptions from Stan
---
 include/linux/netdevice.h | 30 ++++++++++++++++++++----------
 net/core/dev.c            |  6 ------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a80d21a14612..8e05c99928e1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3364,16 +3364,6 @@ static inline int dev_queue_xmit_accel(struct sk_buff *skb,
 	return __dev_queue_xmit(skb, sb_dev);
 }
 
-static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
-{
-	int ret;
-
-	ret = __dev_direct_xmit(skb, queue_id);
-	if (!dev_xmit_complete(ret))
-		kfree_skb(skb);
-	return ret;
-}
-
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
@@ -4301,6 +4291,26 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
 	return 0;
 }
 
+static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
+{
+	struct net_device *dev = skb->dev;
+	struct sk_buff *orig_skb = skb;
+	bool again = false;
+	int ret;
+
+	skb = validate_xmit_skb_list(skb, dev, &again);
+	if (skb != orig_skb) {
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_list(skb);
+		return NET_XMIT_DROP;
+	}
+
+	ret = __dev_direct_xmit(skb, queue_id);
+	if (!dev_xmit_complete(ret))
+		kfree_skb(skb);
+	return ret;
+}
+
 bool dev_nit_active_rcu(const struct net_device *dev);
 static inline bool dev_nit_active(const struct net_device *dev)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index e365b099484e..793f5d45c6b2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4744,19 +4744,13 @@ EXPORT_SYMBOL(__dev_queue_xmit);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-	struct sk_buff *orig_skb = skb;
 	struct netdev_queue *txq;
 	int ret = NETDEV_TX_BUSY;
-	bool again = false;
 
 	if (unlikely(!netif_running(dev) ||
 		     !netif_carrier_ok(dev)))
 		goto drop;
 
-	skb = validate_xmit_skb_list(skb, dev, &again);
-	if (skb != orig_skb)
-		goto drop;
-
 	skb_set_queue_mapping(skb, queue_id);
 	txq = skb_get_tx_queue(dev, skb);
 
-- 
2.41.3


