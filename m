Return-Path: <bpf+bounces-42033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59499EEDF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26B5284ADB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED01DD0FC;
	Tue, 15 Oct 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLge+fq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169E1C07F2;
	Tue, 15 Oct 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001329; cv=none; b=mVBb2V6FYvznR6/d9IKRqqvVJbGhbnTYSzZEd3jASkiWwWTc6TvMcc5U3fZjBV8YqhZsYh0lPS8eM0CnN8xUoiEsAMtnQuqw+v2670lRoXfQ/vFZhi49ocyd04PqxCeNMRF1rHovhr9vLUepuWAgr4izg3+uP9jvHwyErV/w0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001329; c=relaxed/simple;
	bh=GsA6FtIUwBo1zKJkXqIxOwVFmX5xaSmglrhE3X/0RBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOt/0TcpDXmwr2D5JETmK0OMfXScAsk+9NmbvqHIOJNhBAxuM0kdaoF2yZrUYh+/o9g4m2+kJ9zmTTAt2MXFYRuYbYtSjIaE4lwlB6KgMDzA9eRcIfyQtr8FRjhNNrNpBrqJTsPEWzbX3UrQzfHlEYniZdKOR+EZsCq4yeOiSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmLge+fq; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20cb7139d9dso28165765ad.1;
        Tue, 15 Oct 2024 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001327; x=1729606127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9vWKxhK5T4pb/KBHT+yw7K3X7BwQfQYdiydyRU9Uk8=;
        b=BmLge+fqpCj0GKJFgsdU6wRFyO8U8YqPVS563914QFKQmQ/cc68wiWwst234fUs0HE
         B6SxKXQjh3oo7b2iS/8uilT1dt7WuNQL2m33/9tbW41PkWysQLq+XEQ+I90kaNp+tBPo
         O+epg20wCI9HGKVThtrFLXr2qQzgE3EqbORnmpMvBTPcVgWECWInR8tvE8GTS1VZP7SU
         Mg/x7I39avS4BWg1aU9moMabh1RJtQdema7oEiTOeC00MPBpgKJiYwOtHfS9VPraxoOT
         OWK2Ta1YvuoqIN3jlTHiewkb+k70rWaG6eOjLXSePjdk0jO+krsXA3pS1mFLrx5hP0Sh
         dAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001327; x=1729606127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9vWKxhK5T4pb/KBHT+yw7K3X7BwQfQYdiydyRU9Uk8=;
        b=CfBKI1mRnjVHkgETfd8uCZlWpuU23A9/YPtB1klrrPKb/d7zB1JvKOyZqMFtQHch5+
         MI6mf+Hm+2ZsVJkLmsLXdI1ThPxC0k/ilI52UkqU9lGXk1iI+E3Fm4B+UbQ+GFPxV6Q3
         +OSBHf4hyQFiQMiqqvEhMbLi2c9D1wheXED/XcXIeGz1aa6hkMWZehVOq0ciK6jWX6Vf
         44WME1eCpUqyxauTjTIAGirWx2yZotsjY+QeM8IvOxQR+mQSYzfepCimQNLcH88d6Ipk
         S+xICxsn/tBU+SgpY6uEvGKZQssmSRSu9VbI6KV0IevWB8WOdiUV8pOKPx7htLbywHpx
         A3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUrw8/OHnPvVX2q8uhaOs07ZqSrgTbFtP3ArKqFDtn6S1/IRlxmvr6wk5KJ/aFdg2uy/V8K57hSZeg1qJgD9Yxw@vger.kernel.org, AJvYcCVvAN4wd01KyQumtJ6TYypr9/00zGDTSV/kFIxhiwutCZvONMANiaekFB5c8bzyM7R3Q/Ee/rFWMfYD4+Vx@vger.kernel.org, AJvYcCWTDwjM4UAaBRwmAXwMeED9XyS18tnavUiAo1UB5YpiJvlNVHkBQeJKl7i4o2XIrVdPQC6LWnts@vger.kernel.org, AJvYcCXk+WAuKgP4+n9X8NJeP2l6G3VeXA6SgYPm9lGxgPKZvaik1JRzpr/hyRq3u/HlaSBvXR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+NQ0VjPFk8qgInAvr7uC7I+t4o9p7cyvOy1azrb0oVOKLWE0
	wGmMLkyyWcy6klpZfNWyZEc9apyHmWlI8ywGonXJvMgUy1UPKJlz
X-Google-Smtp-Source: AGHT+IFBSG1rXEX3ulld9iULiUd1FzmxZkMBCNGmlo18Bh2FR1zC/W6Ghezo8NmDgV/hbfjHHBjJlg==
X-Received: by 2002:a17:902:e543:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-20d27ea3518mr5284655ad.19.1729001327347;
        Tue, 15 Oct 2024 07:08:47 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:46 -0700 (PDT)
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
Subject: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow() return drop reasons
Date: Tue, 15 Oct 2024 22:07:55 +0800
Message-Id: <20241015140800.159466-6-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  6 ++++
 net/ipv4/route.c              | 55 ++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2a1fb90e0e5..74624d369d48 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -79,6 +79,7 @@
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
 	FN(IP_LOCALNET)			\
+	FN(IP_INVALID_DEST)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -386,6 +387,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
 	SKB_DROP_REASON_IP_LOCALNET,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 917f05a0a5ce..33bf83bcccdb 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2204,9 +2204,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	called with rcu_read_lock()
  */
 
-static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			       dscp_t dscp, struct net_device *dev,
-			       struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		    dscp_t dscp, struct net_device *dev,
+		    struct fib_result *res)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2236,8 +2237,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2247,21 +2250,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = -EHOSTUNREACH;
 		goto no_route;
 	}
-	if (res->type != RTN_UNICAST)
+	if (res->type != RTN_UNICAST) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-out:	return err;
+	if (!err)
+		reason = SKB_NOT_DROPPED_YET;
+
+out:	return reason;
 
 brd_input:
-	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+	if (skb->protocol != htons(ETH_P_IP)) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto out;
+	}
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = -EINVAL;
 		reason = fib_validate_source(skb, saddr, 0, dscp, 0, dev,
 					     in_dev, &itag);
 		if (reason)
@@ -2349,7 +2366,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2386,7 +2403,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2407,12 +2424,8 @@ out:	return err;
 				     &daddr, &saddr, dev->name);
 #endif
 
-e_inval:
-	err = -EINVAL;
-	goto out;
-
 e_nobufs:
-	err = -ENOBUFS;
+	reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2469,7 +2482,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


