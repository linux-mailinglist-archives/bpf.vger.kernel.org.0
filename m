Return-Path: <bpf+bounces-41094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C5992653
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1071C22415
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200AB18C92C;
	Mon,  7 Oct 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA1Ad1ne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7D188CB7;
	Mon,  7 Oct 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287284; cv=none; b=mudoYDW63Zg1sHPSsObqvHtwpEwsKkAW0OTYVaayqjj2GTQ61BuoRLfmtJq77IoZo2sDql1uTl+RwlABvB1ZQz/u00XBZZ6qjeIxOD4Ip2PP/CQvuGAuxFeek1O5r+s/4ihKL7v1XBHvuB808QpuslL80BrzNt4qh1A9h2RhEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287284; c=relaxed/simple;
	bh=AFtinQhikZyKitdPfZNlcdt31jcLu6Yv1Ja9JGIMARQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keCGbpxtJ5xfFEDqWqBCoCs58WanFZ6GWige43bVhCA8XoGFYuqbhdTlzjkwDW0ewOKc7QwKp0r9g6iiKysmaL7lXCsI2Q8y+HU2GSc1CehreLlJUu2P3rJWI4xBq8Mv3O/N/Gi8unQtg5Ubu/fwwqlSkW1f1vP929okmGDYwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA1Ad1ne; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20ba8d92af9so29867565ad.3;
        Mon, 07 Oct 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287282; x=1728892082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyp3LmvP1ogw5p4ky3MkRZN9RsleA4VcicUieYoXaao=;
        b=fA1Ad1neHv790sl7YlyP53QqXqCZAql5nHGZh2lLiE8LKOSgwD8AJJcEaZ3WyiNpWw
         3j2xDQ7dabw/A3uENkYNiIqnyBm69xRB3n/UQdC+UJPI55btZoRTLfeNd7CFPoREeYed
         10FVNBE/zac7haB5z1dOrbMr3MAJGbdKssUsFXy9VLjTFqocR8I6N9QYHlA37xwHRA8s
         tXEsj66uavSonBfS5qC9c1a0RFh00DZ6W+3vLlhWe5yMC1qJOiJXEe/LtckYwO2WpuHI
         pBTm63V/pistTHx+mqJDfRSvm1NWErtHbEVhvhwXZTxDFAn4ftmv+S3a8kvnsvWE3LYP
         Qh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287282; x=1728892082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyp3LmvP1ogw5p4ky3MkRZN9RsleA4VcicUieYoXaao=;
        b=DCbFnGvQPMwWk1OUmmXepvqtDL0GsdUzG7YrNzntUObXWIj4u1LvDq/ZTgL+0/ShEG
         t/bh3vPaCJc12aeVraZNih/xP+8ssHVbiGGIR/1QS1wAOqJvk7rJIOeVhNqApevuKUe3
         KzTf0ccypN7bHdAXeALo4nYq5zp8lhc1tFJeqdM4LFfsn9OTGd78HxjQ73qb8PWJF91K
         lJ6uO/apkCackITqjULXFKn6JnoW9VFwTQKKoORoAKLyemTsY1EtY8wxiyzr4RXVV2GC
         uVoI2x1iQQKwtHgwNseXwYWjEZ+pR6E6kf30IPq0cyC225U/IRFCcCxIje+8CgBleeTH
         lhfg==
X-Forwarded-Encrypted: i=1; AJvYcCUp95wOGcRFXTgXyRpTHYX7fffyKCCASXg2GerQ+drCHaeOqM2HEj1Qs4Yi4cJtrJQYJQyqNuzU@vger.kernel.org, AJvYcCW7C6bnWfan2i7LpWZQISYox4WpJ7xyQtWRCyz8BHyOFQUkANs/THbnAxsw3XvxK6dBRnDdZLh+2ivyR9df@vger.kernel.org, AJvYcCXG3kSIctkwAjrycTxijGiWRnmAJI+TMiybtKWrsVcGPz99pewIVq08X6aDqUjYhleyBcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1Hq1x1TS9RCjSvGM1AnNSRPMtD8UK8DAyvxXgVCLYVAECbuC
	bkWjmvxYyC5Ub691dFbveN4U9hY664dwo/eYBDF2m0B/jbZYlGNK
X-Google-Smtp-Source: AGHT+IHwrjE/SnjfkzYiNUS/YvoOeTq8epmjrCoTM4gX34wia0xyYe74rL6fiPjkr6JnxSxiotfjNg==
X-Received: by 2002:a17:902:e547:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20bfde5567cmr190170345ad.4.1728287281651;
        Mon, 07 Oct 2024 00:48:01 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:48:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dongml2@chinatelecom.cn,
	bigeasy@linutronix.de,
	toke@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net: ip: make ip_route_input() return drop reasons
Date: Mon,  7 Oct 2024 15:47:02 +0800
Message-Id: <20241007074702.249543-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input() return skb drop reasons that come
from ip_route_input_noref().

Meanwhile, adjust all the call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h             |  7 ++++---
 net/bridge/br_netfilter_hooks.c | 11 ++++++-----
 net/ipv4/icmp.c                 |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index c0b1b5fb9b59..87d2c103616e 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -209,8 +209,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      u8 tos, struct net_device *devin,
 		      const struct sk_buff *hint);
 
-static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 dscp_t dscp, struct net_device *devin)
+static inline enum skb_drop_reason
+ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
+	       struct net_device *devin)
 {
 	enum skb_drop_reason reason;
 
@@ -223,7 +224,7 @@ static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 	}
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index c6bab2b5e834..ab4b9c6ae34b 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -372,8 +372,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct net_device *dev = skb->dev, *br_indev;
 	const struct iphdr *iph = ip_hdr(skb);
+	enum skb_drop_reason reason;
 	struct rtable *rt;
-	int err;
 
 	br_indev = nf_bridge_get_physindev(skb, net);
 	if (!br_indev) {
@@ -389,9 +389,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	}
 	nf_bridge->in_prerouting = 0;
 	if (br_nf_ipv4_daddr_was_changed(skb, nf_bridge)) {
-		err = ip_route_input(skb, iph->daddr, iph->saddr,
-				     ip4h_dscp(iph), dev);
-		if (err) {
+		reason = ip_route_input(skb, iph->daddr, iph->saddr,
+					ip4h_dscp(iph), dev);
+		if (reason) {
 			struct in_device *in_dev = __in_dev_get_rcu(dev);
 
 			/* If err equals -EHOSTUNREACH the error is due to a
@@ -401,7 +401,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			 * martian destinations: loopback destinations and destination
 			 * 0.0.0.0. In both cases the packet will be dropped because the
 			 * destination is the loopback device and not the bridge. */
-			if (err != -EHOSTUNREACH || !in_dev || IN_DEV_FORWARD(in_dev))
+			if (reason != SKB_DROP_REASON_IP_INADDRERRORS || !in_dev ||
+			    IN_DEV_FORWARD(in_dev))
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23664434922e..c3bafff093e0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -546,6 +546,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
 				     dscp, rt2->dst.dev);
+		err = err ? -EINVAL : 0;
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
-- 
2.39.5


