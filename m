Return-Path: <bpf+bounces-44236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576F9C06AD
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494A91C22F18
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B2216209;
	Thu,  7 Nov 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYgIPsjD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492682161E0;
	Thu,  7 Nov 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984246; cv=none; b=hj0hX3OuddF/eh+ujnbekhfG5ePkjghbgscUNq73RFRyJipZBwqAaY1zI4a9QHc4iYfDYpzK8a0B9SZgrxmUVR7qN19lV6AShmfXWn9iXrS43a+63njp3ZIZ1RLr/I6qNN7p4o0iFL55hmx7bQHFn4teRR0+N/dKFlXEm3zevEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984246; c=relaxed/simple;
	bh=AzPTQheRHnGID2X5Qc1c3SAFD2DAdxHcXKCfAmPhexI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUytR1sSvyXsTq6ie5hftSsS3/lWiLkXjnjUd9Uz88CTMbxzCDtSOpOsAArWvvRG2ysqrjT/5F+47FSDh5UMJyeDZvcPX20Ab9RhuPc6+Lgr0kHbvob4DTaEm6krF2bjYrcE/4YWDOI4S8p1X4ZhCXsfvvIEFFvrmZeCQyA3xZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYgIPsjD; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso662787b3a.3;
        Thu, 07 Nov 2024 04:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984244; x=1731589044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp/nxzIF5mrvbeuLb6xwFDuD/3J2mYKGgGC5M8ByCE8=;
        b=NYgIPsjDcDGWhxYi6P6yrBJq180LPwpad7qF/5PkNm+XZkh5C/LFMTP5wu1RfZcJI8
         QlV7ZreR/uYFNJO8aJJ9oFTXp/KJEQWr/+cCozkz3kRBPMZK7wIXcHOw93I+4ddX+mvP
         xA04xWTLNyutBDWOR8zlCfO/c++FyA0XY0rwUc0l30dO7dhuJPXpdeOPa9RhufEF7LLZ
         zk1TjrIWXwUVSkWUM0JkmHAHoCevkh6h7SWhhbXzv96nBNLEVbv78zbIAv77/0xXbM3H
         uaQ/VRTrDpqJJBaCrVrh8/un6isuIcIzkWJa74bmRCYwRtWTBRnBz0ieQT5CIm8zYnXK
         CjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984244; x=1731589044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp/nxzIF5mrvbeuLb6xwFDuD/3J2mYKGgGC5M8ByCE8=;
        b=rFtdPZjWbCgQKAodt2eVbBUWzMNlWpfrL9lot+dqEaVZq/xygATLqgDgwZGvsgInl4
         /e/QcfYlAAk/F7/gdMxRmnUDoFctzPKq+nXcBC1t2yyT2Y/oI6HEkaPmodbZysseeo/s
         YNcQEGYDHYAK2Dq0rnCpSyZhFzC5wS8k9WoDg/2gWycGK+PSd6NIwzTPb3+npeGE9tfs
         PB3IqApSzOO8XbEVqPetkxq3wJ3bwklJkieDQvh5M6gMLyMUUUs4WMVjGRxvaGcfvr08
         fhHFWTDppCX+sKpPLbY1GHI76qoQ8+z82IyFH2j6jowmjkcNLB5IJ43PZuj06beDwfsy
         SDPA==
X-Forwarded-Encrypted: i=1; AJvYcCU/V+VkX/bi851zlmfgvLfkiT1p7KrOEGluI5nZBiGvCmmhMBwGC+ebS61ky1e0o6aop8eK+IV6@vger.kernel.org, AJvYcCUcAUd7P/0WKg+bE8K95n6g/emneo4DVF492pPBFUKIMIOSmuB9+Jsrn5ZQk94RsYD0rnM=@vger.kernel.org, AJvYcCVLUxaajV0ZOmVBDA+AD0ZbOQlnZo/CgMPVhLOH66wEMjM0j2vpqj9p+ZuCTiF0xLlwwHatODy+WYbMZxMUv//D@vger.kernel.org, AJvYcCWUTBMYYWpt3X+RB5TpmDQdZ/R0oIH2Rxf1BtpScfctft2KJBmPHES4U20w3wIrUmLfZ92EWBQy3+u1VjX0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzur6SqZMQkvAzkkz63sU06aXE78Vd74schanmqktyAZxJQQUUN
	mZDZjgb9TjraBrf6kr4BSuRLGDY5w5NNZQ/4FG99x+wgKh/GWxwK
X-Google-Smtp-Source: AGHT+IGvQWsp2b9BeJixZrZUic2hwe5Ix/dR3FT5oeBUy72rHMjXsnL+6qxfDFfM3mnKmw02UNS1+Q==
X-Received: by 2002:a05:6a00:174b:b0:71e:19a:c48b with SMTP id d2e1a72fcca58-720c99915bamr29597108b3a.22.1730984244436;
        Thu, 07 Nov 2024 04:57:24 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:24 -0800 (PST)
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
Subject: [PATCH net-next v5 6/9] net: ip: make ip_route_input_noref() return drop reasons
Date: Thu,  7 Nov 2024 20:55:58 +0800
Message-Id: <20241107125601.1076814-7-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_noref() return drop reasons, which
come from ip_route_input_rcu().

We need adjust the callers of ip_route_input_noref() to make sure the
return value of ip_route_input_noref() is used properly.

The errno that ip_route_input_noref() returns comes from ip_route_input
and bpf_lwt_input_reroute in the origin logic, and we make them return
-EINVAL on error instead. In the following patch, we will make
ip_route_input() returns drop reasons too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v5:
- remove the unneeded "else" in ip_expire()
v4:
- introduce the variable "reason" in bpf_lwt_input_reroute() to make
  things clear
---
 include/net/route.h    | 15 ++++++++-------
 net/core/lwt_bpf.c     |  6 ++++--
 net/ipv4/ip_fragment.c | 11 ++++++-----
 net/ipv4/ip_input.c    |  7 ++++---
 net/ipv4/route.c       |  7 ++++---
 5 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index a828a17a6313..11674f7c6be6 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -203,8 +203,9 @@ enum skb_drop_reason
 ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      struct in_device *in_dev, u32 *itag);
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev);
+enum skb_drop_reason
+ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		     dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
@@ -212,18 +213,18 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 				 dscp_t dscp, struct net_device *devin)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, dscp, devin);
-	if (!err) {
+	reason = ip_route_input_noref(skb, dst, src, dscp, devin);
+	if (!reason) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
-			err = -EINVAL;
+			reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index e0ca24a58810..8a78bff53b2c 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -88,6 +88,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 
 static int bpf_lwt_input_reroute(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 
 	if (skb->protocol == htons(ETH_P_IP)) {
@@ -96,8 +97,9 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 
 		dev_hold(dev);
 		skb_dst_drop(skb);
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
+		reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+					      ip4h_dscp(iph), dev);
+		err = reason ? -EINVAL : 0;
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 48e2810f1f27..07036a2943c1 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -132,12 +132,12 @@ static bool frag_expire_skip_icmp(u32 user)
  */
 static void ip_expire(struct timer_list *t)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	const struct iphdr *iph;
 	struct sk_buff *head = NULL;
 	struct net *net;
 	struct ipq *qp;
-	int err;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -175,14 +175,15 @@ static void ip_expire(struct timer_list *t)
 
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
-	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
-				   head->dev);
-	if (err)
+	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
+				      ip4h_dscp(iph), head->dev);
+	if (reason)
 		goto out;
 
 	/* Only an end host needs to send an ICMP
 	 * "Fragment Reassembly Timeout" message, per RFC792.
 	 */
+	reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	if (frag_expire_skip_icmp(qp->q.key.v4.user) &&
 	    (skb_rtable(head)->rt_type != RTN_LOCAL))
 		goto out;
@@ -195,7 +196,7 @@ static void ip_expire(struct timer_list *t)
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	kfree_skb_reason(head, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+	kfree_skb_reason(head, reason);
 	ipq_put(qp);
 }
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index c40a26972884..513eb0c6435a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -362,10 +362,11 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	 *	how the packet travels inside Linux networking.
 	 */
 	if (!skb_valid_dst(skb)) {
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
-		if (unlikely(err))
+		drop_reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+						   ip4h_dscp(iph), dev);
+		if (unlikely(drop_reason))
 			goto drop_error;
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1926a8a1a83a..ce1201dbf464 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2487,8 +2487,9 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev)
+enum skb_drop_reason ip_route_input_noref(struct sk_buff *skb, __be32 daddr,
+					  __be32 saddr, dscp_t dscp,
+					  struct net_device *dev)
 {
 	enum skb_drop_reason reason;
 	struct fib_result res;
@@ -2497,7 +2498,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
-- 
2.39.5


