Return-Path: <bpf+bounces-75447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CEC84DA8
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB721350F38
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7F31B82A;
	Tue, 25 Nov 2025 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnnZrtEU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FC31815D
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071891; cv=none; b=k8vbLMpY1COoyLn7lJmEN7vueMsj71MLDGKqmZchG52BSejxQNQ/mHlxuhNhY4oO9gDRGSRgpZERLyRNeDaqB+4RF6504/SOtNRceLmHJKP0AJslSDQL2ebPu3zHpii2lZR7SQE3gz6YzVbOa3M6D/leHCYMRnBxnPvRP8G9X4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071891; c=relaxed/simple;
	bh=RmJ6tcduLw99rCBvSpTn6ufwB5CBLdz5HBuKvmvUTyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWAYDd1qv4232521Y7z523Mq70Y1/h9dbqJ7bn6Cg1vMGvf3GJ48uDf5zlC+8dF6goj2UxPvstPvFr0LCxbKrGLS1u1lhr9+63Kbx+g6G25ST+UK1C7n1WUXQUizMn2sCJKvh5WU1RycVf79XPl9pqhrEbBcMXe9Tm1H7L8xu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnnZrtEU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so4968510b3a.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 03:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764071889; x=1764676689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HThzW+sKYacl4oCHLCD/aAorkU4LgzFr6Ng9iHdQOew=;
        b=KnnZrtEUu8tQXzhOw9qTBe6Cy/7I2hFBQRiw6Dmy8WcgNs1GK43Fcf1Sde/fcN8+uy
         Z8xnqrPBiJq9zwF6dIq6fjqJFLuXxBGeTJ7HQcGLIu9zVyhimo3OzgdtgblBP2R+L9T6
         rD0EDvo3gt+jRH4jnGh5wS6gpkpudoK/8kc5ALM/6NIeZ20k4tlfriG0ZM9D93HrL21Y
         HbZrwWwMlQZordfHg7MbcjYbG10N/S23lbCpVSRCdM++TMU/DRH572E4H/sdtKkBWxcS
         tCqhDniKb/PwTJR1VmlGOmZ46zMuBQu0P5xZcmBVA1bk0pbt5curYp2a9AUERZEtkfRJ
         kMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764071889; x=1764676689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HThzW+sKYacl4oCHLCD/aAorkU4LgzFr6Ng9iHdQOew=;
        b=PTzJVQsjHNTdeEGz28Ka5fyCu/u4sRZkL//G2B7vsr1iLAz01sonrDPFzecMmDw080
         U0jgeYM7UkQt52XbrZQyhWAPxa9k8ZRiQngleIz3HrXRYLI/KU1Ghucs63WMemmIanpk
         61xZvR7XbFMkgKPMramkxItMbwSirbY2t7E6LIubVU+ix6mZi/fEBbwq90rgESoy7NmD
         VBkc9+Nk0RtY0Y8wMgm5Iotcu41N/RP/nX7MNDedZMm+AjmbGHDqGPG49oM01sIuX1ZP
         L6CWJQJ6+G0YIxltCyGhU8tgGaWbepHbv3NSpT8FQts6Odb4hEqYhjuJapBYOEyzZhSi
         cgaw==
X-Gm-Message-State: AOJu0YyuQ/fA0OWORm3AHwQ+IkQyC9sfUOKD3gYZ4dUeyNfPlNbV435P
	TDQVCHwkX8gHJtcQ/TaUN/XKS9EZ2U+1u+WZQaYrsinoIWUmW2b8eimYV7lCYPa7
X-Gm-Gg: ASbGncvD7OHn0DQYiDAHu7jDduQrwzMD8PUqHgb8PMfp7258fJhd2FHtmQ/fbVpvaS1
	LhwLudPiGpmR56loVvmsdwZaZzuLyAN+y2mJiWVqcd9GB6/OYu8UypznYoIi53fmf4F0ivD4IM8
	JQdIXJ97LCIeY/19zRgh5sfrhQ7LQnIP0M/gvzf27d4Aworp2SMxFfe2MJWeTXEOzDMoT9YUA21
	RtBqpRxlgfxDFgIlVeB5AGo2Ft+D4GiH1AWcXekzWUy+x1M2tFXV0AN8RPhwMqScKx/2k7rx5t5
	Z4c7W4/HdDFGiQ89CmZ90eL9JlDXCueQTPK+uWjqdNE8OcykJbpxYyyzSTVTRVLyGghnJJabjAO
	AimkZTZpAvoZrekD4TdbFgD5jqrMwP+Ed6737XGL6DFB+vk1+LbjAjuEOL9g1vOZBYYru+ayQrn
	2X8NAV+Y6ngZWDvX/4mCsShjr1fBvOhGi8YISAtYoLp75lXMkK40kl9q1AGg==
X-Google-Smtp-Source: AGHT+IFpHRNQcOkdUGmbpNFvrYHmxWNLLodzzxkDMCa27chG5uFG7ozmtavTQ06W6mG78qHL398s9A==
X-Received: by 2002:a05:6a00:23ca:b0:7ae:fea:e928 with SMTP id d2e1a72fcca58-7c58e110b35mr18132197b3a.18.1764071889357;
        Tue, 25 Nov 2025 03:58:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed470ff6sm17826562b3a.19.2025.11.25.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:58:09 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3] xsk: skip validating skb list in xmit path
Date: Tue, 25 Nov 2025 19:57:54 +0800
Message-Id: <20251125115754.46793-1-kerneljasonxing@gmail.com>
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
responsible for delivering raw data from userspace to the driver. This
is also how zerocopy works.

The __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
("dev: packet: make packet_direct_xmit a common function"). And a call
to validate_xmit_skb_list was added in commit 104ba78c9880 ("packet: on
direct_xmit, limit tso and csum to supported devices") to support TSO.
Since we don't support tso/vlan offloads in xsk_build_skb, we can remove
validate_xmit_skb_list for xsk. I put the full analysis at the end of
the commit log[1].

Skipping numerous checks helps the transmission especially in the extremely
hot path, say, over 2,000,000 pps. In this kind of workload, even trivial
mathematical operations can bring performance overhead.

Performance-wise, I run './xdpsock -i enp2s0f0np0 -t  -S -s 64' on 1Gb/sec
ixgbe driver to verify. It stably goes up by 5.48%, which can be seen in
the shown below:
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

The above result has been verfied on different NICs, like I40E. I
managed to see the number is going up by 4%.

[1] - analysis of the validate_xmit_skb()
1. validate_xmit_unreadable_skb()
   xsk doesn't initialize skb->unreadable, so the function will not free
   the skb.
2. validate_xmit_vlan()
   xsk also doesn't initialize skb->vlan_all.
3. sk_validate_xmit_skb()
   skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb or
   sk_state, so the skb will not be validated.
4. netif_needs_gso()
   af_xdp doesn't support gso/tso.
5. skb_needs_linearize() && __skb_linearize()
   skb doesn't have frag_list as always, so skb_has_frag_list() returns
   false. In copy mode, skb can put more data in the frags[] that can be
   found in xsk_build_skb_zerocopy().
6. CHECKSUM_PARTIAL
   skb doesn't have to set ip_summed, so we can skip this part as well.
7. validate_xmit_xfrm()
   af_xdp has nothing to do with IPsec/XFRM, so we don't need this check
   either.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V3
Link: https://lore.kernel.org/all/20250716122725.6088-1-kerneljasonxing@gmail.com/
1. add a full analysis about why we can remove validation in af_xdp
2. I didn't add Stan's acked-by since it has been a while.

V2
Link: https://lore.kernel.org/all/20250713025756.24601-1-kerneljasonxing@gmail.com/
1. avoid adding a new flag
2. add more descriptions from Stan
---
 include/linux/netdevice.h | 30 ++++++++++++++++++++----------
 net/core/dev.c            |  6 ------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e808071dbb7d..cafeb06b523d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3374,16 +3374,6 @@ static inline int dev_queue_xmit_accel(struct sk_buff *skb,
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
@@ -4343,6 +4333,26 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
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
index 69515edd17bc..82d5d098464f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4843,19 +4843,13 @@ EXPORT_SYMBOL(__dev_queue_xmit);
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


