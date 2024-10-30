Return-Path: <bpf+bounces-43471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43E9B5959
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E17C1F240B8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538B1991D8;
	Wed, 30 Oct 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBc/TwO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED31946DA;
	Wed, 30 Oct 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252595; cv=none; b=htcBUbJGw05x0eKpvVmnu+g8PA6kQERTetHB3F2YexNu93jBwy0zlLblg+1sjx4WHA0lopNsDMlj5UtDC8MElkOuHBpkm9/peMez+aADFDU+R8MNmvwb42IcRuZjSoFpR8cPlIRnxzGmJEKYoMpAVismhE/uPr7ei5AR0nFsZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252595; c=relaxed/simple;
	bh=Hwlyk1RkZ8H0cJe0cYToxVJgBU3qh+yZ7+dZVE9YlwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHa4ydY5+RCAKNQbs+/6Fc10g5CCiI9QFfdL+ECrubM9KmOi56uPSohAh6dvrJp+FLnQhQAt8r13+r0LPOZTPemahpijCJmqL2ganpy3lOWRyqbfXktSSl3hOynwqfbj+kHVelTEcogNCOUfZjrgx2YZob2A4tVAlgYD3XG5HBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBc/TwO5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71ec12160f6so4415021b3a.3;
        Tue, 29 Oct 2024 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252593; x=1730857393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=WBc/TwO5542SPGWNruX5lVBQspzzJGHENSno+6CODcsYcfFJHC3WR/xNqYqit5G0GU
         lxKUcU87cvJOkEffbCeOmo1rFFH3NWoFAbZsnUEJ+busrKdDEx9MjCZfjdL7snHIawa+
         9KnhpJWiF49A2KSWFQRtFPdkmiRTQXo7fiZgbTO0kcBRi3Ffv1Y1uvIUC9vOwh7nj+8+
         KPVbworFHUxvUCsNFRqyz00OXTArARUD60DI4XJUJsCSrCu+pJOXQm8Xzjdt6QqETTur
         on7dtfJQ2MVuluvhuB0CRYsTimdPCsEsi9oDG987CLzGbsF3EV9YyJitEsymtfsa3JOp
         G9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252593; x=1730857393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=YFfsQ8ZDexAgdRvaH2dVoWQgLqFGuTsyiOgz/WHc2u/vinZlUN13K4IEm2F7OBQ+Ax
         HuEV6uWLRZrp8pfO4dzxKtUL7OgMmOOWdpi0hlcoeNpQG3FPzHr/oLIeeet1nPy+pQAi
         g6IKwJkveOXPhGp6WyNSazqUe7YlgiEzxJNNvcS71Dtxn1aEQbev3eqoSTP3GUbU4AlL
         cu+ERed0zSpxruG9yOuog588wcKNZM1Db4h2LxP08EkEBx24yR3rWS9up9IXdec7kJO0
         suu8MD1IWwN0AFpzaUKZcFfa4mRtgnOZIkjJlmqih/9C68ykdPdRI31lIQN6qffzleFd
         kFzg==
X-Forwarded-Encrypted: i=1; AJvYcCU2umFSC711B/ceRi21lMZ3LvkZxq9blGGKZi9l8K1cYJXfeK7pcf1UJ/RAMLFR5lYHv5PIXfpzcDYoBcbG@vger.kernel.org, AJvYcCUUyDYjFNRxjv6CYC0SVgu4VnaItZSwBDsbhehs3D94BYnpVTVyfbbozHGY6BtVPnGATUE=@vger.kernel.org, AJvYcCUj6q14zQCPPDFKDSEXygsbjfico1NHVvubqbngNu4Gvh7q50FTxtfYRaciF9V2x1ViYxOrrm57lkvR2o1GPJ5r@vger.kernel.org, AJvYcCXoYRjFPNf1EHFVrajcSzXDbI7n+B1lB9+HHetdTPrYuIds5PV1KwNE4wPz39/cPJ04wpl7Jabf@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKW/TdvpKtrnRy0OEoWwnnW4fbF0kyI6oQnBcRvIzAWYK3rp0
	daLThrIQn7SovJtUhz5kxem9IyKqQwAULpVuTB5g1ixAoGqmzutf
X-Google-Smtp-Source: AGHT+IH4v8/G90ooRXuHL5VL3WvFQh+cZ0sV0/VQGuWaSAFe5MRXQsSg9uniFnbOt8/gKoCGGc1uKg==
X-Received: by 2002:a05:6a20:b40b:b0:1d9:651:7d6c with SMTP id adf61e73a8af0-1d9a84d97famr19686543637.38.1730252592646;
        Tue, 29 Oct 2024 18:43:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:12 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 3/9] net: ip: make ip_mc_validate_source() return drop reason
Date: Wed, 30 Oct 2024 09:41:39 +0800
Message-Id: <20241030014145.1409628-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
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


