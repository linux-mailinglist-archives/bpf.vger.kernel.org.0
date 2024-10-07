Return-Path: <bpf+bounces-41093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DE992650
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E821C22416
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D518C35A;
	Mon,  7 Oct 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/ABahJM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD018C345;
	Mon,  7 Oct 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287278; cv=none; b=KKOj7hcaGnFHaZW6dS92jVHvTWUSEMBmq2qq2GCWud7wHwLU51bvHTP2Lr1Iqef6pCXfkejhOHQ03J3QAzysiJplCNc+1bWEPprkYZSIgQjjWjtTLhXmCvRxOrXLW+jk6szZxuB0faaYiiBsqyUUWuuzcopWFfLQX9i+xO3Hz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287278; c=relaxed/simple;
	bh=0mkZZrHN/gwpxej8fgqezYlhQ3jB5OoSLalPv0uqQbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByJ7x53n0OlbxoXak66Vhctr5lq3B93HZjKcUniz14XB/zkMo1oJAbId/P/dTWkz5YqsbH+Yq6shjV+SQcZP5sASUUKQdE19frdmwqUnbqF9d4xtZmJb8AdeMAbs/lqyYSIk+nP5jo0tNzmbhILdHV67ND5Fy36lRBV4G9rMOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/ABahJM; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b5fb2e89dso29982125ad.1;
        Mon, 07 Oct 2024 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287276; x=1728892076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76zvHd9GTjQjT7mAWVL0ptl3w/fNexDfvtqrobrhzGQ=;
        b=Q/ABahJMZSrkriNO9kmsmoi7PJvGpw3WS9FCl+AXUbPJ3zPiSkGPnK5YoYutnDkat2
         VY7owwFUBXkXiuk2i6EZYN+6KgK81/NHGGA11rRB/+/nzG9xJWpxDUN5fSD+/tJRwl+s
         cSBTdSfO3O0N8qt+LJXczSbi6tKqugjpxsxZ8FA3iBzvL/Qo1j2QB6ElUtkJAI59WO9s
         Od/uxaTx6gdTm74Pmzy/tGkYPRg6O7gllTXjf7OkIgrxiF1RFv+u4NZgnQdDJHiRESH6
         NF9FXePMj/3HWPjjfjy09dJIK5UMjzwB2kDIZudW9FOOVX9l5xIdLfI8plr1XXpwCIAb
         npgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287276; x=1728892076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76zvHd9GTjQjT7mAWVL0ptl3w/fNexDfvtqrobrhzGQ=;
        b=Oblu//+AptcFedWVto7AG+M1FyiqXNgw9EpZPOIQgVp1Z7foU5g/FqsVmtazz6EDEZ
         4ijFS0FteoJpLm4J2YGI13iQ5e5bAXQ8yFWNmb33iRmSiZIhEagnusKY9eld2Zqjnctg
         2Mkin1KmY4t4oFHzFn0wrtkhltgMVhQdngOX+GL9D7g3Y8BcKVoxH0Yq4pcWLMw5I6KD
         bT50SdCVDqPCMZSGAT4fh/X0j3X/nFcxyARsmSjRn+h7k7fLWgHu9POuKkJjh1DApxgT
         pvwwTw9V4Mw7Dl0no5LNVMMdSGnIvNb4t8eVf4OzehHqyCllqPdIdJEBd4lVGvU7Jrga
         qQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUYlmaJ/YsIZ55ezxDQwZQEX/3HvciD0VxWi+1NXrNOcCvoT8Csy6wkhldQyvqBuSUMIE=@vger.kernel.org, AJvYcCWSzPfhtaKUomWiPS1bvmFtaT4vmUE5t4WcHFoT8BHbIa2k4pncLpGiUs9ZWkjFHdRTnAO4zE7P@vger.kernel.org, AJvYcCWVRIPqLeWrIQU5QeMgxXd5MtsrRl8S7+I88So0GbJOOXGG3lbR0gPYfc1PSp867WSE14scUNGiaqlF3CNB@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKN5K3SkpRSkAIxwaIYXNVXHNqvTOKqWgWHM4dc74B8Vwxp/U
	tPT3C0NcuVUhYxqfjLWFKnumI5CqDsXUh2/egihuPA0EF/n4p5Wn
X-Google-Smtp-Source: AGHT+IEj7oLYOrrtfJ+9IIi88QVobTgP4b+TyrmLdVb1feMH/NjH1HVEykfIB3d8WhT0shFEZ33gWw==
X-Received: by 2002:a17:903:40ce:b0:20b:59be:77a with SMTP id d9443c01a7336-20bfe496042mr143677485ad.28.1728287275899;
        Mon, 07 Oct 2024 00:47:55 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:55 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/7] net: ip: make ip_route_input_noref() return drop reasons
Date: Mon,  7 Oct 2024 15:47:01 +0800
Message-Id: <20241007074702.249543-7-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_noref() return drop reasons, which
come from ip_route_input_rcu().

We need adjust the callers of ip_route_input_noref() to make sure the
return value of ip_route_input_noref() is used properly.

The errno that ip_route_input_noref() returns in the origin logic is
returned by ip_route_input and bpf_lwt_input_reroute, and we make them
return -EINVAL on error instead. In the following patch, we will make
ip_route_input() returns drop reasons too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h    | 15 ++++++++-------
 net/core/lwt_bpf.c     |  1 +
 net/ipv4/ip_fragment.c | 12 +++++++-----
 net/ipv4/ip_input.c    |  7 ++++---
 net/ipv4/route.c       |  7 ++++---
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 35bc12146960..c0b1b5fb9b59 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -202,8 +202,9 @@ enum skb_drop_reason
 ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      u8 tos, struct net_device *dev,
 		      struct in_device *in_dev, u32 *itag);
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev);
+enum skb_drop_reason
+ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		     dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      u8 tos, struct net_device *devin,
 		      const struct sk_buff *hint);
@@ -211,18 +212,18 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
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
index e0ca24a58810..a4652f2a103a 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		skb_dst_drop(skb);
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
 					   ip4h_dscp(iph), dev);
+		err = err ? -EINVAL : 0;
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 48e2810f1f27..52b991e976ba 100644
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
@@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
 
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
-	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
-				   head->dev);
-	if (err)
+	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
+				      ip4h_dscp(iph), head->dev);
+	if (reason)
 		goto out;
+	else
+		reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 
 	/* Only an end host needs to send an ICMP
 	 * "Fragment Reassembly Timeout" message, per RFC792.
@@ -195,7 +197,7 @@ static void ip_expire(struct timer_list *t)
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	kfree_skb_reason(head, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+	kfree_skb_reason(head, reason);
 	ipq_put(qp);
 }
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index a6f5bfc274ee..aeb71675052c 100644
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
index 56a1ebddde24..6baaaf0bcb3e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2492,8 +2492,9 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
@@ -2502,7 +2503,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
-- 
2.39.5


