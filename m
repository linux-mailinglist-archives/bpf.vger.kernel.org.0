Return-Path: <bpf+bounces-41090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAB992648
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BDB1C22423
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78118BC22;
	Mon,  7 Oct 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH9M+rko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9718BB93;
	Mon,  7 Oct 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287262; cv=none; b=m0Y0lmx/aNHTYZ1On7ZsizcaPNF6G12dFe4dh5JCy0t1cLwQWDb9bS4c+ih36g+dTJyNsl7U5zYCKLQqyzo69snEbGdweHTljUV+zIBmk8NQEkJlgLf4mCOf3DY+uNe59DTKKryPm4T16Hjqv5i+Bplkd3jZZ0puZRcJG5ubZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287262; c=relaxed/simple;
	bh=uLj2cAm5rTKQ0+BYQBhpNHYDVfwryxhdgiEvOhpTf90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6fx98kItZYNfFOS+4InYddIaHd7/9mJdJiputvXxcI4S2MYWCg7iQLIqNrHYYFDVf8NNzezeWpHHVNSmuTiI8a8HsGPGGVUaLeJ3rEg6tBUDTn2OfuSzphOQLc1PlcUof3GcU5arschOgKtd84XLvbj/i28DFb8YBZ7NCG9z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH9M+rko; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b7eb9e81eso48103405ad.2;
        Mon, 07 Oct 2024 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287260; x=1728892060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8WPQR7zChu9vGAKKT3gtEp8vmWGx/ATFJW+z7i1Xzc=;
        b=NH9M+rkoKsQL+sXB1jbTOmf9JdiO3zEg09IrgyJK7EfivtdP/uTqwHd3bAF4SeLmuv
         /uo8aBAxJt0JXcWyqdUsY9uJWEjtmzfo2d7Q7CeHTWUraovn+8k2pafAdSZtbG32f86P
         s+EZl3dJK6yQYIzltRFhva68d/Egh8LhPEiRRqn8xZM7xlWqASPiT8ehEgh6iEUZlfdo
         B6aReVC/X68j8Qg5wHIwOFX/oBZqurIvJz6UnfhbgJ3/mnHTmpb2/Adn1hkqwNECYXL2
         Mooc9PeZd/pkA6qvuGPasY0gIG863bmmTgP47hXTG+mHFiHkUinKLddkTZkFOM5aPdKk
         ohPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287260; x=1728892060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8WPQR7zChu9vGAKKT3gtEp8vmWGx/ATFJW+z7i1Xzc=;
        b=iF7OMb80b2xhquY4J5Bz0DK776MCtD78Tizj2zPS3Rm2MqpiBf/j4bQMwFtmnRhqef
         56wUnQqla85fbl2luYjjwZk0R6b/o6ChfOZYgHTU9Pn1mRrxg42AbhyFqkLRI4Fa8Tzj
         D3ZAgQx9mVKXpm5Jlgv/gWYlXggV8HMCzDF8cwGhs5zmZhcD4CrMHxIeqYoYtn1YDQ2a
         rKqmkmyogheAtVHWm568JV7q3+4+Rn480blpPNGqfgFqPYgvMro5SLT66fkPSGGdLDbk
         OHfI+L97YnEgUXeGi3ime34Mxn96Ljac2EjBJhMXG0jNGYylfstzmrSibF86YmFSTY3l
         Lf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhoo8KBJ9Od6XPUDv2eqFoBCAeUE5H3uvSCnQgyfLdIauRkqe2WVZAMh1t3YLrOgqM2VG+nzaJ@vger.kernel.org, AJvYcCWYFqZ84u72EsDAUR1i3Enhe5Z5gY5T2mP5zLM1VxkSe6+wo1YO7CSDeP8aGxzbhm4kr2YWok2j4v9O3N8Z@vger.kernel.org, AJvYcCXaRD+v3U/DsA6dYJP3ATkdFMx9KYFs4uCqkRO2tJEBOPjBIbSc5FDe4GWA0lpQSiQbgsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyHTP/uqKRQqpayD2JhJEKGxQmZkT8+CA3eug4xzzaKOsrZqq
	LCy7bI4DTRqACEZfoSlkzCExrrK4C5fTyvwaaLZGyqhkrGhLIY+H
X-Google-Smtp-Source: AGHT+IFFw8N6yA2W0Bz8cAi33a85qMhkcn99BQC0OWw4EtgWLoM/l6pgMAiJBWwJ/xUIJ/SuteH+Hw==
X-Received: by 2002:a17:902:ec8a:b0:20b:449c:8978 with SMTP id d9443c01a7336-20bfe0357b5mr153007545ad.31.1728287260113;
        Mon, 07 Oct 2024 00:47:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/7] net: ip: make ip_mc_validate_source() return drop reason
Date: Mon,  7 Oct 2024 15:46:58 +0800
Message-Id: <20241007074702.249543-4-dongml2@chinatelecom.cn>
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

Make ip_mc_validate_source() return drop reason, and adjust the call of
it in ip_route_input_mc().

Another caller of it is ip_rcv_finish_core->udp_v4_early_demux, and the
errno is not checked in detail, so we don't do more adjustment for it.

The drop reason "SKB_DROP_REASON_IP_LOCALNET" is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  3 +++
 include/net/route.h           |  7 ++++---
 net/ipv4/route.c              | 33 ++++++++++++++++++---------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 76504e25d581..32d9fcb54af9 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -78,6 +78,7 @@
 	FN(IP_INNOROUTES)		\
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -375,6 +376,8 @@ enum skb_drop_reason {
 	 * 2) source ip is zero and not IGMP
 	 */
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/route.h b/include/net/route.h
index 5e4374d66927..35bc12146960 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -198,9 +198,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	fl4->fl4_gre_key = gre_key;
 	return ip_route_output_key(net, fl4);
 }
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 76940ca7c178..b41bb9be18e2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	int err;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
-		return -EINVAL;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr) ||
-	    skb->protocol != htons(ETH_P_IP))
-		return -EINVAL;
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+		return SKB_DROP_REASON_IP_INVALID_SOURCE;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return SKB_DROP_REASON_INVALID_PROTO;
 
 	if (ipv4_is_loopback(saddr) && !IN_DEV_ROUTE_LOCALNET(in_dev))
-		return -EINVAL;
+		return SKB_DROP_REASON_IP_LOCALNET;
 
 	if (ipv4_is_zeronet(saddr)) {
 		if (!ipv4_is_local_multicast(daddr) &&
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
-			return -EINVAL;
+			return SKB_DROP_REASON_IP_INVALID_SOURCE;
 	} else {
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, itag);
 		if (err < 0)
-			return -EINVAL;
+			return -err;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,13 +1705,13 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


