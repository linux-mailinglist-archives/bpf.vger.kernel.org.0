Return-Path: <bpf+bounces-44239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EC9C06BC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4081F213ED
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7996521893D;
	Thu,  7 Nov 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1lWcwnz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826042161E6;
	Thu,  7 Nov 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984273; cv=none; b=OMv8jtGyKJmoe83ouEy5/AILVuzKtySSBYen36mSRaAD8pcfCjiPyY3AebrL2P2zXw49QGK+D/ebTLR1GX1Pg9BZ8XAaMLDDtpyW/02wmuJPZS1Lcy9C1jpTysdBsGbMMUSjta7q+Z3txqC3gaATf8tYQUejOdAqE0LIWS8EHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984273; c=relaxed/simple;
	bh=IYn5S1cwhtaOTvDqjZaJaEnCKsh15AhHI5yVgkDK9C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVrmDsujs5RVSY9vnZeL7GA9nq9oi0o8M89xZ0k+4o8ecmW3XCIo+xIcQ1H2JKTKoGvKANnruN/vKif8A0DXWClL0KueH1cEGjdGKE+BRnqw0M3mJ4jbHgaWLg7seGYCtslEguX2apxWuqnn7olqK//I0V1CuLKpRyx6HPgpYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1lWcwnz; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-723f37dd76cso822512b3a.0;
        Thu, 07 Nov 2024 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984271; x=1731589071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHVagOVhSGH6WueHgFMGm5lkR8eH7OQCXVH1PePUNsk=;
        b=B1lWcwnzcTWtxmIf7lEoNvDci1+pjEHE6M3cflYgFp5BdHXT78xi/11/L1334k5dhu
         jMo+EJr7UWZgVNRX+jrQNtBHSdNNQ9CnZqCOTiHIiv10Qu1ZjF0e8nfGymQ1wiIhVHWo
         Vo32jbXAS91PBI8JyZ3MZicyRzRpyPxwGWU6B9w0opH/rquqSFBI5/CH1BpWgxC0Ik0V
         p0FoRNyor1a5RKLD6iE9xfj6WfoMwyH7dswaEKKBxHwBdYp/cogAGr/6yWddW1ReMk1h
         mNcO2b5ossqeHYG2clqG6QDn7anlbPqgffF7BB8bsSEF8lRTpFA9GYq3K+yxz9SnLtMV
         dc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984271; x=1731589071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHVagOVhSGH6WueHgFMGm5lkR8eH7OQCXVH1PePUNsk=;
        b=niy73DlIMfEQDQxxXAxn0gEpD4Y/4MobV+5ijO+ctTYrzOlKR9R0DUoREyZkwjLjOq
         irfMa8udRt4PGCAM/nZEHuAQXY/6AZ0TA3xU9Lx5JufYE170kiEcJ78xl4OcictNcxoq
         x+86cYDvtfIJFg8Fl1TTUzsaFLlv4o0XKY5iDQx7EAssehRLxF9BDSJhmNJCgueCt8/W
         Jbk+0S2O3fzZ4Ji7gYu/Ov9zTOf4zeWWxIN6QpAlRn6Nysam9G3xVL5Rnvz4qLOIr6Yv
         PQgR7hQ3AEFc7kvhUa0VLWB7zICZ81f87Q0W6vBQjFLjAx1gDazYIV6Vh3SpgKKlCrXd
         +rjA==
X-Forwarded-Encrypted: i=1; AJvYcCV7olNwgGb1cShHYVGxkwZmxzb4j4nw1y60BSVVRzHZQKK+jY/pHiDBsmbQmRqAdyNLTfgL+gQA3oh2CCBTioCa@vger.kernel.org, AJvYcCW21VZbGnRkHA4H6qH3RHeu6YOO9BFpCjFVpoTqHxx0ZB0qmrQMwaqmJt6j+Gc3jO256AYoFOHx@vger.kernel.org, AJvYcCW4bs/xATchbZtuT/wPfXjpMST5vkhqSI82afRp7mvnLJvJocj3jkjIsBfMrz7CDRFvb2I=@vger.kernel.org, AJvYcCWcyU0YsurY1k3oGw3KxAso/dvGZYmYbapOEom1B1gSVj4Px6MKcAdkFCL/1ooN5sVDOTGhqA0C3pJhQQZl@vger.kernel.org
X-Gm-Message-State: AOJu0YybtQ1E5G+XGirSUd6ygy+k0vkmwM59wqetYhu5LlFOc3aBHIHo
	/Q//ZaJbujJOE5qbqC7Vgutaha2R4+4W5TIXqmwwVkmcA9+6Bcjx
X-Google-Smtp-Source: AGHT+IF6AoyPkVC2cAAzV84e4L7QNNOe4LnFK0pviynupGO5O8bo/1kcyphCsBxr8Xqaoavaqu60DA==
X-Received: by 2002:a05:6a20:7488:b0:1d2:e888:3a8e with SMTP id adf61e73a8af0-1dc17a2a834mr1201478637.18.1730984270964;
        Thu, 07 Nov 2024 04:57:50 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:50 -0800 (PST)
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
Subject: [PATCH net-next v5 9/9] net: ip: make ip_route_use_hint() return drop reasons
Date: Thu,  7 Nov 2024 20:56:01 +0800
Message-Id: <20241107125601.1076814-10-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_use_hint() return drop reasons. The
drop reasons that we return are similar to what we do in
ip_route_input_slow(), and no drop reasons are added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v5:
- replace "return 0" with "return SKB_NOT_DROPPED_YET" in
  ip_route_use_hint()
---
 include/net/route.h |  7 ++++---
 net/ipv4/ip_input.c |  9 ++++-----
 net/ipv4/route.c    | 28 +++++++++++++++++-----------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f4ab5412c9c9..4debc335d276 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -206,9 +206,10 @@ ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 enum skb_drop_reason
 ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     dscp_t dscp, struct net_device *dev);
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint);
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint);
 
 static inline enum skb_drop_reason
 ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 513eb0c6435a..f0a4dda246ab 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -322,15 +322,14 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	int err, drop_reason;
 	struct rtable *rt;
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
 	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr,
-					ip4h_dscp(iph), dev, hint);
-		if (unlikely(err))
+		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
+						ip4h_dscp(iph), dev, hint);
+		if (unlikely(drop_reason))
 			goto drop_error;
 	}
 
+	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5061a935ce62..d1c4367d3c20 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2141,28 +2141,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
  * assuming daddr is valid and the destination is not a local broadcast one.
  * Uses the provided hint instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint)
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
-	enum skb_drop_reason reason;
-	int err = -EINVAL;
 	u32 tag = 0;
 
 	if (!in_dev)
-		return -EINVAL;
+		return reason;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+		reason = SKB_DROP_REASON_IP_LOCALNET;
 		goto martian_source;
+	}
 
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
@@ -2174,11 +2180,11 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 skip_validate_source:
 	skb_dst_copy(skb, hint);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
-	return err;
+	return reason;
 }
 
 /* get device for dst_alloc with local routes */
-- 
2.39.5


