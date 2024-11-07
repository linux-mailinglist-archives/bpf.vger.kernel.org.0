Return-Path: <bpf+bounces-44233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B79C069E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5C41C229A8
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988F2141CE;
	Thu,  7 Nov 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzqrs1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942142139C7;
	Thu,  7 Nov 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984225; cv=none; b=CLcfY0eQZXS1J59d2hP+BOAkGs2gmtJY4aV77pFDtg1GxJXWwDsB7GO+4XiGj3DRhoesYj0bz+8uwTSoMC8uwM3u+G6plhVpYu6gHzJycvarsLyw1Ip3gkP1zXpP1UUB2h5RL2N83SSI4giYdwvTRGAJEyW9LVSW6dfQyukI8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984225; c=relaxed/simple;
	bh=Hwlyk1RkZ8H0cJe0cYToxVJgBU3qh+yZ7+dZVE9YlwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9+Slqak4J8AeLrWed25s4eA7818C/oDLKFWu36HqJWbRT+Frd5VmeHnr1Xd5tra22JtdEhvBtxIR57bBuFhkyvDjiiAGRoJVkMbYD2ZgR+gWaz5PLneYFJd7AubUHVdTEH4v/pZ8GI5itVkRjHzBU1Djlui3K/VthJ/ZfCbCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPzqrs1F; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so667940b3a.1;
        Thu, 07 Nov 2024 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984223; x=1731589023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=dPzqrs1FqPjRr9XV8qqUUcofOfEP7KyvbrIIA3ApDiDH4XnCYS0WoV/jcGtbdoin2W
         WezhozgX9NcU7IhEGVVvydklz7ltFuYIfd58vaUUKLj1xOwcpHz16eZWUUSu1kNdG7Q1
         A4sLsAcBVlE88owGM16b9fBRNROhnu7muKR2KvxjT0jccOssw3FinMOmg87a6GA748zr
         vbL/qbUxUcPPbuK/C62zepa+JEwP2aBxuIQOOWUpGv2zVlCrly1G084YZKubGgurB6nq
         iJdB9eH3vQOr3RRCV0VWgCGCGWoMb5fYqeOLknd8tk21SPWdPfxjzwxLKYMLthyEkE7P
         3fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984223; x=1731589023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=rHUPyKXqQKJVoiUslx4n8I+d48LpSx8J64MaNqi3z3j7hQqhRrNIQ9xJrFT460Dc8p
         Zv0Vs8kk9c1Fto7yRlpKjVDUk3PEpl/zz8JVGueGqFHVlu+95smA9O8rvVpcscdbeFxg
         TCZMZe6T0UTgDXgHdJ278fVy5hP4UgHYtcR+nahjlypX+PZGT+aAOztzEAaMy4tE0Vq3
         sUa7fShUNWsGp6BKASUqx4F2h92xwAW2bdHjyW/kYw4VuLLLwYcFr8LzrMO1fZS/oTKZ
         CfmoWmhRH9BlKfEHFXO428pPpE8ZM2Co+Tx4B+pTszmrh/AqbG0BMWWxYjQMIfAiI37L
         rZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVWNFEqKVXh/WrP2R9GnvrMbxK/l1JZ8DhyIxbEpNWKaJGSrHqHev1Wv4t7o/YejzHeiqtIV7t@vger.kernel.org, AJvYcCV+rtP9KvqrRluJ5II3H4q0WhltMWB0BUYZREpNspJERbbFZUNAxQWDB5AzNVLVwklmpfyZA7RwhIrUsRJu@vger.kernel.org, AJvYcCVKaq4cc+iWrwT/W2qD8Q4e895nxsC6o+UMvcTdERTaIFi9rePC5uvi2quEQvVjHqKDPOo=@vger.kernel.org, AJvYcCWOEQxf+zy4g01LNZXE3cHUIkZUx6FAxVgE/B1f5rTtxj+PQRcN7Wa5UJLV4AhycaDKE44GM5Zb0jj6VG1/R8bL@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKSmOsFzW2cPrZJ5r/F9ctLUAVilwNlsxSBCgAqh50IP7JHdu
	aWNf3Z99L54Y7BV3A+LpV5GFRVJNbsVjaLDYI6KFZG6+R7RdbXrS
X-Google-Smtp-Source: AGHT+IF2zGAUBIBaXz3X1zvbLv2DoqVWAuK2tyX4mIgaYAkA4p1rjVUF8Y9Cn80G6QcS+PeexU17lw==
X-Received: by 2002:a05:6a00:3d0b:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-720c998d909mr31610613b3a.17.1730984222858;
        Thu, 07 Nov 2024 04:57:02 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:02 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 3/9] net: ip: make ip_mc_validate_source() return drop reason
Date: Thu,  7 Nov 2024 20:55:55 +0800
Message-Id: <20241107125601.1076814-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
References: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
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
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 62a60be1db84..a2a1fb90e0e5 100644
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
@@ -383,6 +384,8 @@ enum skb_drop_reason {
 	 * 2) source ip is zero and not IGMP
 	 */
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..a828a17a6313 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -199,9 +199,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	return ip_route_output_key(net, fl4);
 }
 
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ccbaf6207299..566acd08aedf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	enum skb_drop_reason reason;
 
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
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, itag);
 		if (reason)
-			return -EINVAL;
+			return reason;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,14 +1705,14 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
-				    &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
+				       &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


