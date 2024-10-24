Return-Path: <bpf+bounces-43036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA19AE109
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A60B2136A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0811D5170;
	Thu, 24 Oct 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIuQsJjV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C11D515B;
	Thu, 24 Oct 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762523; cv=none; b=N7HgbpWQ77Ud0uEmsZrgtvWzxXJNQvG3JjKuJ4SOD/fe/TETRPH3KCOEoGirjX1e07jCIvwwwMucn5BhmMZ4JMlXB3ZUG1kIq9W6fXvVuz6LY/T5p3fxrfRD9epSQOS3uF56zQVuxGJoVhn3fSUfVVrYnigqg1rh0jIQ18gZva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762523; c=relaxed/simple;
	bh=ZBCJSiNa4CsjTZLKPAoPbJkdOPZmUXoqjlRHJMtpBEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/tpLliwWhtRcLcqh9HJVbg1DQt83hjWpvCnNaELV7u2WF3KJ7FH36x5RTeqWold9tEu8BZuS2rrHNSRg/ONWfWFr2V75CX2HDXjtMiInjqaXRID4a0krd15xNlImrChFpCC2c9Uzm7rWv+pO1tS31jz0JNRxaYQ2Upcx+FAN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIuQsJjV; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so465858a12.0;
        Thu, 24 Oct 2024 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762520; x=1730367320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6zwyUv2KGSH8PlgsFrB+o93Y53y7wbnB82m1YBj/UE=;
        b=QIuQsJjVXnLWZJUzlZJc6GaqJ8Z2JwYTW+JvfmJ6xVO6NgKyseCxjocgFkPvhF4Wsm
         DrtvPDVAR3SBgjTbowtLTHKMECV4hTBTYmnoaHY/IWU5KH/C5z4YxOLYJsqefWJ2rZYf
         odVC0WSK0O1aAHI7DiO1+hb6EnCv+IOT89hQiIMyMveBH7845PUkK/ZlkMLrGetqyu2L
         1X/2TXus2p/CVbRQhw7TjdXhxu71SLkPHMQEQJkmBxGvf8bIzfFQrb5pc9ir5xhn/eIt
         3DEGftY3oONBCCjO6jL2OdEpFPmWFkWL4Ex/ubu9B26O8BDnKzzL1OT9JlSOIr6sNWUK
         /f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762520; x=1730367320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6zwyUv2KGSH8PlgsFrB+o93Y53y7wbnB82m1YBj/UE=;
        b=OkXHvxEaaEUh8ANjeIwElQ5PgYpKn+FlbGkEwaA3SpXxlCQffhZMhls5S8KNWTGRHh
         NI7zu6dQAmDMEbZqtCdWbcD2tyYV+ES91o33H1tZzb6LjFtTYb+KZcXJpGNvxvykicdR
         /MEqK1XukoGkzZk8x8SKizXI48zE2q/AgZ+dWUtv/kG4ZmF8DY8faL4bnZqn8jPhyuA4
         JNgIwJrb1LEjiVwcChcqASYE7s+Ps3XdKRDP0FrHwjFUcUjS8j2shrcNYwRIs6OsCRJA
         hf/QF5HptC0tXvViC4evr0smSYY+AR+W+CbYdrHdp4TebHayCt/hhAftvI6c5dMPsmTV
         NoqA==
X-Forwarded-Encrypted: i=1; AJvYcCURd5vwU7P8zMaoSRU6X0a0usZSaeQNqkb4OJqMkLEtbFUQQLUOeRyWzpi9IcCOlr5QYKQtUrmxf0Jv6VgV@vger.kernel.org, AJvYcCUmeeUY0K8HbxIqSt9eKIH+eWwQf66xzjouBDG9BjnB35y9HrAgp1NnshxeKmPNnIVCcw0YVNHgbk5+19NjalmI@vger.kernel.org, AJvYcCWEIRi50GY96L1+o6cd/2wnczcaeJ+hmhSbJJwgWeifK6+8I6c3jRSXbYS77bIte1O/pCyhL/6m@vger.kernel.org, AJvYcCXAnsbDmG6IWo5zqbTRuhQFe+cs9u59esadrNfBZZOnRoICeEq7PJAsqW9zfbV0UFUxZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Z5Z/H6AVpcnPfN7RLstxqkSAcj7RyWfKJY5DzyGqhHAdcs1w
	w/G/QJ1vPoIsqYTkLf4WCvjiylbqGhaiDvjkJM2ipbSVffwDi2ly
X-Google-Smtp-Source: AGHT+IEhH9mv4sRJVGrpIlkJrNHBz3f9CnsIgWLrxbEHkg0baOEdR6HmBCN2l2m6Svm3SbVXLsLMzA==
X-Received: by 2002:a05:6a21:1709:b0:1d9:782f:8c9a with SMTP id adf61e73a8af0-1d978b2d8b7mr6909181637.21.1729762520057;
        Thu, 24 Oct 2024 02:35:20 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 7/9] net: ip: make ip_route_input() return drop reasons
Date: Thu, 24 Oct 2024 17:33:46 +0800
Message-Id: <20241024093348.353245-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
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
index 23664434922e..69ea33f64a54 100644
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


