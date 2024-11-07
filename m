Return-Path: <bpf+bounces-44238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9B9C06B7
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9391C23BF3
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233A2185B1;
	Thu,  7 Nov 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khMipVli"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B3216A3D;
	Thu,  7 Nov 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984263; cv=none; b=bZlsSJW/H/Ji5o7iq8qduTXvbQ4VajYlQP7i/2OsdVjXpV23L45H0U2O6C9TB6cVVBCHn0hJXjUKeMF/p5trHQAA7ikpBOMf9DVnA3PDReCN9Z0hueCHu6zOXGS0K09WxRDYJxopmBvjVeHpWo3ZmXouAom989xQTP0RlksPMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984263; c=relaxed/simple;
	bh=XS2m++Sgf3ghY+FnwaWLEeDYZlpTGeMq5gxC//6ynBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0DZIU2xZNHp1LEBVCz8VyTZ8eIuHk1dJ1wMrYkLYcdVzEp+TtKHwZ3/Zb32bthS3ksvzKMfI3Lf96KDexbQc1P72jMAv6It22j1/aoYce4ZC4MUhhFEQsGji/jdFNB7WiiXoZnrriv+r5w/GcLFF8YIhuwaU1r3xpAWIlpiH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khMipVli; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7f3f1849849so701325a12.1;
        Thu, 07 Nov 2024 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984261; x=1731589061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejigKO8ihJK0woNi79sU/LHHXIyrY4qa7/hgbBk06OE=;
        b=khMipVliOSQrcR43+GtWS/5/C4nuCz/Hw1u2JwVZHWKYL7zHGNuTRwFOJfGwxASjxm
         u/XLXIL86jJM1r9Hppj0TSzW0Az45KMIuih8qMDWUo8y4iK9n3Bb6VrJJs+9OJBhqR+V
         oD4C/D3DeR2qgBk2xFSaTMkN975GKl003cY2GRoubp7H3KBYhOIXtdQdBG9mmCICGooc
         ATQHlj9ZWlZlvqvRkt7iRwlKF4azIHaBXi39a9tSJgEjS8tdn05cBBOyocEoY1kebCP9
         C0wLp96emJu29tkwdw7kNpYsKoYMPqkqF8WCeDNfcWYYzYi3lGl8jGkZADzZs6OEd3wJ
         Qk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984261; x=1731589061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejigKO8ihJK0woNi79sU/LHHXIyrY4qa7/hgbBk06OE=;
        b=VzWnnCyiumozv79/LmcyqWO5gBgFWQfLt1417JqqlDvQLksAQZiDsMZz3X3NLGH7LY
         E8VVFLVsBu0w44+5Yd482NqknQZ2Kx9CEIwOik7GQydjta4PD04pk5D5JgrI42Ld8fnW
         iawKtmAPdb/3Mpy2ldFgv3/ppVZTExe7/WpG8Nm9pIUCrYQgeASQkCixqjJbVWBsJfqm
         xC+JKXRwleTxWdvJS16dMXnRd7c43gkYPWOIQgnGj0dPqEZKc3HzGGnFtrF81hgsW0aD
         iCeo/kh9tiFsdTwqXfmE6zR2u8bByFggz4JksxzUXrjbRnzElKFuYtMFAH/fzykpqJ+q
         MKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVkErgn7kb9FpPtZRhbByRnU+QaLQmsPprHKX1W3QiGI9KkriXlXHKNVKN/xMpzHGKOQwrloGKp@vger.kernel.org, AJvYcCWQhCkoDcf6bEbPIpxbcM5F7JY+c10jiEryBhjs7lUe4BG5sY1JV9ozArKu6d+upcDVCZQ=@vger.kernel.org, AJvYcCWiwFmHpO60EAt69IrbPBRU07T32XuYF7waAVvUDJU8Az4bP78BosHoU2qJhtZd+EDLqFbEdMJp+AGvdnkT@vger.kernel.org, AJvYcCXF8LCx1k9K27ifUc5kCPfm+Zjk07EuuRW2l5IgNXo9QS8/96UrRqYtZDXx/PLeafV0CaQwuS84mTUyDTSE+Pfv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5FC37MZ6KHcqjK7bsAPYEdQshwGixKGBKeo4jQ1xqniS+6Se
	5EqmOIi13WujfUCuON2a+5cFzWh3hTccLxZir1gNUX/S+fyGiBQA
X-Google-Smtp-Source: AGHT+IEU6zXbGJYonMbPl97a7r0f0+B1j6/MR40EUxdwoG8IsQ9GwfQX/JcxBrCjiLtl5vbF8FLzUQ==
X-Received: by 2002:a05:6a20:a104:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1dc17b5fa12mr1126789637.38.1730984261012;
        Thu, 07 Nov 2024 04:57:41 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:40 -0800 (PST)
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
Subject: [PATCH net-next v5 8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Thu,  7 Nov 2024 20:56:00 +0800
Message-Id: <20241107125601.1076814-9-dongml2@chinatelecom.cn>
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

In this commit, we make ip_mkroute_input() and __mkroute_input() return
drop reasons.

The drop reason "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is introduced for
the case: the packet which is not IP is forwarded to the in_dev, and
the proxy_arp_pvlan is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
This name "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is ugly, and I have not
figured out a suitable name for this case yet :/

v5:
- delete the unneeded comment in __mkroute_input()
---
 include/net/dropreason-core.h |  7 +++++++
 net/ipv4/route.c              | 34 ++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 74624d369d48..6c5a1ea209a2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -104,6 +104,7 @@
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
+	FN(ARP_PVLAN_DISABLE)		\
 	FNe(MAX)
 
 /**
@@ -477,6 +478,12 @@ enum skb_drop_reason {
 	 * the MAC address of the local netdev.
 	 */
 	SKB_DROP_REASON_LOCAL_MAC,
+	/**
+	 * @SKB_DROP_REASON_ARP_PVLAN_DISABLE: packet which is not IP is
+	 * forwarded to the in_dev, and the proxy_arp_pvlan is not
+	 * enabled.
+	 */
+	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce1201dbf464..5061a935ce62 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1769,10 +1769,12 @@ static void ip_handle_martian_source(struct net_device *dev,
 }
 
 /* called in rcu_read_lock() section */
-static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
-			   struct in_device *in_dev, __be32 daddr,
-			   __be32 saddr, dscp_t dscp)
+static enum skb_drop_reason
+__mkroute_input(struct sk_buff *skb, const struct fib_result *res,
+		struct in_device *in_dev, __be32 daddr,
+		__be32 saddr, dscp_t dscp)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct fib_nh_common *nhc = FIB_RES_NHC(*res);
 	struct net_device *dev = nhc->nhc_dev;
 	struct fib_nh_exception *fnhe;
@@ -1786,13 +1788,13 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	out_dev = __in_dev_get_rcu(dev);
 	if (!out_dev) {
 		net_crit_ratelimited("Bug in ip_route_input_slow(). Please report.\n");
-		return -EINVAL;
+		return reason;
 	}
 
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
-		err = -EINVAL;
+		reason = -err;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -1820,7 +1822,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		 */
 		if (out_dev == in_dev &&
 		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
-			err = -EINVAL;
+			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;
 			goto cleanup;
 		}
 	}
@@ -1843,7 +1845,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
-		err = -ENOBUFS;
+		reason = SKB_DROP_REASON_NOMEM;
 		goto cleanup;
 	}
 
@@ -1857,9 +1859,9 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	lwtunnel_set_redirect(&rth->dst);
 	skb_dst_set(skb, &rth->dst);
 out:
-	err = 0;
- cleanup:
-	return err;
+	reason = SKB_NOT_DROPPED_YET;
+cleanup:
+	return reason;
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
@@ -2117,9 +2119,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 }
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 
-static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
-			    struct in_device *in_dev, __be32 daddr,
-			    __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
+static enum skb_drop_reason
+ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
+		 struct in_device *in_dev, __be32 daddr,
+		 __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
 {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
@@ -2333,9 +2336,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-	if (!err)
-		reason = SKB_NOT_DROPPED_YET;
+	reason = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp,
+				  flkeys);
 
 out:
 	return reason;
-- 
2.39.5


