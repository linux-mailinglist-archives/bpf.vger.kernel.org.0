Return-Path: <bpf+bounces-44237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC59C06B2
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C51C23222
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D331216A3C;
	Thu,  7 Nov 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ8QmTrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453B216A0A;
	Thu,  7 Nov 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984256; cv=none; b=b1Z7mmePQd/t8tfHCjtureARUtNhv059e/LIKSSaoY8VzfJLq6MmpDQcBYLj4kKUEAH8azfSKsEQghg3vJMoaX1I0XeaM67kRMiAUold19izeUFb6veBvm6Pv8EXygJyoMJ+RT2gEpgiICmP2GZWpLTijqRyQ2j5tKWFW5eWn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984256; c=relaxed/simple;
	bh=Dxf+YjSfF9s66wnRYYKzNGRdTBF+f3o1p3CcPZ9IKMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSwpKgEehzXmirD+FYa+btskJpS9MegrWKczWAUhe32Y5iNzXPnxN+UdMvvDZbf8hFvJcY0+ZOmwDKFptcWF7latkbI0y9kZrC1RRHYejI06ARCzsaLBTT22ZLg3xzIzjlnaryOjacLHKfL5UVyEsvzuwRi4O4ZyrsRyr7KTxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ8QmTrM; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e52582cf8so657850b3a.2;
        Thu, 07 Nov 2024 04:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984253; x=1731589053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=dQ8QmTrMliQVB56GsFOXNMJuFj5qtU4hwOjb9lDlcPv7JnvU5/whbhSRz5bDYf3/dk
         FT/6kOkryG6fDq4xYi5vGxI66Oo02nEfucuwN02TmwChR1MD6gLpifEegXPi8wbYfg+T
         l61ebgK7wX5Mg1egZmNohEjOfCj28l39Pmi2datTJ0F+2JYUoHv0pm62jT0bsmlKGNG9
         4C4LM7hv9wZ5rEgMLTHF0FDGTMqWh3RgpWDa8jIwdD/3mGkFaR9tSzPoSGsxmt1nTnU9
         HYZRxWOm1DMoEJPOvmaqTLJpYdkMjHxi7Bw8+o1EvYOEg7TXolI+rfRmQy5MPt4EjX8N
         ZSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984253; x=1731589053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=mK0iDt6ncubg3De1RbDGVRRPN9nl38Y2Y+V8ln0Cfimm0+taAQoNQhT8OksRaNxob2
         RkD6V/Vd5f5S2R2zoRBTduQCzA2QY/n1z7BepMqKK0ovj4OnJrdndhhMrkzlh+wnrW0W
         XRw/KiaiBgd9AuOwUXxLlfMiwM0F0QBISlLlt7MtfQi54X0UPmInGCso78CoWBejEP35
         tQbHyDir9g+El8YyMz/RPpIkmU0yKH+jxgGrPsOnVX9sWTbAntjHzzkwMD16Gy0N25qL
         s2filzQrVCfco4EB3g5Z0Y1QzdLJqI5FpYQmrO2In4j5640AbcWT7pujMM9HbZmg479v
         GSvA==
X-Forwarded-Encrypted: i=1; AJvYcCVKLeBZJtin/EgdXWo0jv3OQxyE2r4+GJC/j0Y+OLh5ZTcv07UO6lZFTd+nPxh8p1Jw8kwG31Xn3EqIxFm5@vger.kernel.org, AJvYcCWOINosrENTHdtcxw3grJlIlfqtlMTUd1gx6sSilcpSsHh9SxTBpYaAYVSs/tvFQr4Tnn8dqtTN+qp5grKggCV6@vger.kernel.org, AJvYcCX5b+aRbCiYqbV9Kd/nchC0H+BwkL6MDcJGhBkTj/AoeEGF6ZTLjHN82zZwOYq/V/fWbtie8msx@vger.kernel.org, AJvYcCXELhaW2OVjNQQno69R2pwakkY3W+mSEW2k4blf+GyUedhrXrhk9eYwCtPQIDw+oeKjQTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVug2WiZQXH+VUZYBdsar5gnLxxiZ/jzhb6WIe+e65HdqCt/I
	vHEpiaIRlP8gBxeH1AGDfmPk2PabwbkHpnKwoVqg1wJm3ZSKBR3t
X-Google-Smtp-Source: AGHT+IE3eEOgJ1qWU18w+8ZWk4W8v2UIMOmASaaI5mv+vDl7yedq5Q1v/jaYiqKiIcGj1dcxqIst6Q==
X-Received: by 2002:aa7:88c6:0:b0:71e:104d:62fe with SMTP id d2e1a72fcca58-720c99b80b2mr33334379b3a.20.1730984253181;
        Thu, 07 Nov 2024 04:57:33 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:32 -0800 (PST)
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
Subject: [PATCH net-next v5 7/9] net: ip: make ip_route_input() return drop reasons
Date: Thu,  7 Nov 2024 20:55:59 +0800
Message-Id: <20241107125601.1076814-8-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input() return skb drop reasons that come
from ip_route_input_noref().

Meanwhile, adjust all the call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- replace the variable "err" with "reason" for the return value of
  ip_route_input()
---
 include/net/route.h             |  7 ++++---
 net/bridge/br_netfilter_hooks.c | 11 ++++++-----
 net/ipv4/icmp.c                 |  2 +-
 net/ipv4/ip_options.c           |  2 +-
 net/ipv6/seg6_local.c           | 14 +++++++-------
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 11674f7c6be6..f4ab5412c9c9 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -210,8 +210,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
 
-static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 dscp_t dscp, struct net_device *devin)
+static inline enum skb_drop_reason
+ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
+	       struct net_device *devin)
 {
 	enum skb_drop_reason reason;
 
@@ -224,7 +225,7 @@ static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 	}
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 17a5f5923d61..110cffc24a1d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -373,8 +373,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct net_device *dev = skb->dev, *br_indev;
 	const struct iphdr *iph = ip_hdr(skb);
+	enum skb_drop_reason reason;
 	struct rtable *rt;
-	int err;
 
 	br_indev = nf_bridge_get_physindev(skb, net);
 	if (!br_indev) {
@@ -390,9 +390,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
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
@@ -402,7 +402,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			 * martian destinations: loopback destinations and destination
 			 * 0.0.0.0. In both cases the packet will be dropped because the
 			 * destination is the loopback device and not the bridge. */
-			if (err != -EHOSTUNREACH || !in_dev || IN_DEV_FORWARD(in_dev))
+			if (reason != SKB_DROP_REASON_IP_INADDRERRORS || !in_dev ||
+			    IN_DEV_FORWARD(in_dev))
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 33eec844a5a0..4f088fa1c2f2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -545,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     dscp, rt2->dst.dev);
+				     dscp, rt2->dst.dev) ? -EINVAL : 0;
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index 81e86e5defee..e3321932bec0 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -618,7 +618,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
 		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
-				     dev);
+				     dev) ? -EINVAL : 0;
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c74705ead984..ac1dbd492c22 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -954,10 +954,10 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason;
 	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
-	int err;
 
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 
@@ -967,9 +967,9 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	err = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
-	if (err) {
-		kfree_skb(skb);
+	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	if (reason) {
+		kfree_skb_reason(skb, reason);
 		return -EINVAL;
 	}
 
@@ -1174,8 +1174,8 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 static int input_action_end_dt4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason;
 	struct iphdr *iph;
-	int err;
 
 	if (!decap_and_validate(skb, IPPROTO_IPIP))
 		goto drop;
@@ -1193,8 +1193,8 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	err = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
-	if (unlikely(err))
+	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	if (unlikely(reason))
 		goto drop;
 
 	return dst_input(skb);
-- 
2.39.5


