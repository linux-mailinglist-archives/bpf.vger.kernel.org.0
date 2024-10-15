Return-Path: <bpf+bounces-42036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944699EEF1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870C0B211CD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6F20B1EA;
	Tue, 15 Oct 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7CfowX3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96541B21AA;
	Tue, 15 Oct 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001350; cv=none; b=RDoEtNH4K2LnjWpVEWfYAAomim5ovp6vMvIuejkklKAXHz7pGmdQOkmg2SV65G+wuNB0KvFXT9fFHG6aSgZJVOVaJTFQC6I7Fyzc9t5HUwUzOzmMi0Cs0jlOZhfOzHpG3GJi1NKRpwmOPX3SkgkTtDV3ggggGF+Of0m54woCMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001350; c=relaxed/simple;
	bh=hRfn5rQNGzGek2Rl/WYwV2CDrJdk9y+72tdDnLlRft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8+LdOwsdpORv17p4f8rI7d8/+4fW0fTwHQz/2bn/7Jx4DC8aqCuzvwJ8+jdFC5tBXRvzH5+JpOo0kETXq7x+Hg7rUkYwGlMFWof7jrnf9UpTAokp6Ffut7DKOPOGT5krEHAxu6uW/0C1+Ws61q+PP7bG6jtg+pAF2c+2jLNHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7CfowX3; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cb7139d9dso28171075ad.1;
        Tue, 15 Oct 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001348; x=1729606148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byj17PnEdOWNMLLbQ9DjmcaQd6Z/d2VuphpY3zlwdig=;
        b=T7CfowX3L9l4QR+niwhkGGIevVgaaJcxW/a5ObAsawJo1vRQ4fo5+VuLRQbxQupYB2
         KbcatjamsNh+pnTOV26xIq0SV0X0SJ9cJ/1kQoSDHPSqBbEiI1BHPt0eD9IPhN0DSbt9
         egXkGTys/HyRaFp3WJsHzPS2tXdzKq6/SM1ZoDmQO8ndoGsxqtTVnyuzhDXF7f7ERFPQ
         J1cb9PW5si3jzBLlA1Z6S2Cix/KqN43nMG7fTrcSOxbdjKd0tVUnV1AKcTyn5+ijfRKH
         /49E5hr0c4egai03aw8Y+irtnU8MA7Kwz5hQXc/X7gfELGhUEoXPVvua0yH4F1FZeKf3
         6gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001348; x=1729606148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byj17PnEdOWNMLLbQ9DjmcaQd6Z/d2VuphpY3zlwdig=;
        b=fr77C1jT2oNP+m3MSt4cRokDGLsBFyowEX9wd+/fwvrxasUOmJ+Yase1zeGiJX0XJ6
         Wnkn1BwvdlXSUmIU7Rdu5EglWjD242pXzhE9EePGTPZhvNIhSy7L1uUBRIzNWueC2Lk4
         zlet/kHyFRWIogLiI8SENGK63muL9UIZ2ufOElgVWewuEO4+wMBtuyNOMLjsLXqIbZfN
         cQ3p3VfR1QNa5cLfKMKs3+SmdHrO/nXM89LSnUVVMBZwskyEIp33yQqd2ltjFROtM58p
         HwbOaesR4agr7rCluBDwBvrXFaAGCjtTSIQkD7abys5bJzKwlMKQs+euZIwGBGeY3K0q
         ndCw==
X-Forwarded-Encrypted: i=1; AJvYcCVHInib2L4l2f/lPCWL2PQEjU0m3Gyl9mlCClR1o7gSatzdWr9GLquENpM/UodaAEEGMmbXuFrSjMYyUQIJFyEy@vger.kernel.org, AJvYcCWYzz4ReYRpsSXTrEUKyOCF3U8Ixg5LGaF6ZlaI3Vufavyqx/tv+4iJ8UI7XqIumnjwKgGL7/Xs@vger.kernel.org, AJvYcCX/+XMi5m4/ejZ//hse12ZYPzzB7CMLNGEqOoYmjes4xwiJUzvoe5ACePKRw49rMqB4JOw=@vger.kernel.org, AJvYcCXFTy9H3qg3g6JyVvJsA2z6bPGBb5vtvx8e9b+Ht74mNBogNMb+n8vcrwgvSi2V3hgJux6qNynfRcovmD1m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9az5UtJNlYZnOxQ51WdDhGAL6uxIJlBqIQzytoyAPyhB1Ij5h
	wfQtRSEwt+2K77HCHwjYZrOU+CNknRbG4y66x6fLcJOY2DPiCMuR
X-Google-Smtp-Source: AGHT+IFho0wkJSC3nuCh8eieAcM7whz7jbKavyQJaZKAu/jxcgJCiyMBMEcoEEjLgWEevXYGayEQiA==
X-Received: by 2002:a17:902:ceca:b0:20c:8839:c517 with SMTP id d9443c01a7336-20d27f26c00mr5475865ad.53.1729001348049;
        Tue, 15 Oct 2024 07:09:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:07 -0700 (PDT)
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
Subject: [PATCH net-next v3 08/10] net: ip: make ip_route_input() return drop reasons
Date: Tue, 15 Oct 2024 22:07:58 +0800
Message-Id: <20241015140800.159466-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015140800.159466-1-dongml2@chinatelecom.cn>
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
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


