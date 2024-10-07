Return-Path: <bpf+bounces-41091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C099264B
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C92848FF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0D18C01A;
	Mon,  7 Oct 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zoc67R8v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3518C00D;
	Mon,  7 Oct 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287267; cv=none; b=hw1UhO0es5WWIwr8QcBrOXWZ5oyVH9cMVYD28iLvy386xRTNlL00rXd/DYODlA6NlpTSycrtNx3u9tQGId4PTQQprd4yOEEVdSqr7Zr5rEnoG9onxFczckBweRCKFiASGQIIQ0VBsqAs7uIxi49t6zuMbHSgiy/HXUyCAihIBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287267; c=relaxed/simple;
	bh=PcBRA/xqFnL+MQ07gHCcLehxHh4Rb4BzAYlM5Dxl7aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFUnH5VIl9OV6oRZq1IUsArAVzxEhSD16eu+Y+gVr/DVorddmBlSHbB5O3CijCBuEr943dJnmZSWDklgq8l8oiK2/OfmosgEgErxrudNiU6loGiNeJeNBIJhO8vjY3WdoGpDZjAx5j5l6tYqMEzxBWXVETS26U8s2YjTf8fjF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zoc67R8v; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b7463dd89so43441965ad.2;
        Mon, 07 Oct 2024 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287265; x=1728892065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfQ47ggmFri0VQv7FK4Zlb4Ak1exGMOdHKZ5pgC6MzE=;
        b=Zoc67R8vUKLj6QiS7B3NCEYdVgOmDOmlUrOgPaLvZEbRA9tPfWTLwFq8Rzd7Iz5GU1
         VQed9vzKFaBLAgXz1N2QLpnDRnI+sQsEUb1YcUMPhx8/ZZI7eTdJXdmG8Z0QMDfNj7kO
         p9phTUyhzNRS9jj95HCtaywqC0eP7fMgEuOYpDseCyMLUmH0wU/UuJmtaO0a8/WFq9hg
         0L8wkQTTRStKEMLeZBIfqugXSYlIwzbnG+qKX0PQHzPQTQjEsm6DvrfWkUFhYBs3xYh/
         Tl7c+OYUlqJLLxseh5mA7fHJn7soxyMf/kwjHxmhKzCKEFdXSktQ36gMI2BHStJjHh7H
         4DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287265; x=1728892065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfQ47ggmFri0VQv7FK4Zlb4Ak1exGMOdHKZ5pgC6MzE=;
        b=CwX+Bj6r2nmeND+6lQWJe0oN0fUrSaK/V0YdQgn/qXIIFrxOm4LEgyakLi/0s8W+5P
         /JRf2oYAh1bTr2k/56t33YUxEibCuPJ9RIB6bDUD/6tidBBn73pIxci5mcllnviZZguM
         2483o1euJzIxZQbgb/Jok/3Po0FQFpgTGICURdKiiZEhfJOYRn0aTtzgGjZ32RWe016A
         guKuNs7uMahuAKMIrOWsAf4if8t6DgxHFJGJjgFpcLd124vIu9QyTyVHGYJPbZdtqIp5
         VVqhVWJFDVGEU/3/9XeZ8X11bAhpI5Lzlt331vLlqnsg7PXHwehJuAAY/p7bID8nsnHr
         FeMA==
X-Forwarded-Encrypted: i=1; AJvYcCU79KYZxOC5N22cOrF+rP36wUVCga5vPyBZxe6fcUuY4OJ2r/XFJ9ABCAfJ25U3kd9hcPoWLtKzoBIIXc5a@vger.kernel.org, AJvYcCXFFqIxwwj7bQkTMUo572Ax4F8c89gCh7roRIHofkM71R0xANlWciz0gWC2+zx8vOC7zLQ=@vger.kernel.org, AJvYcCXWUHPwVuMRVyVGb7mx0BZUA+A3sZBsZJw/GWeogyRfTPUjfQFDhpFn2vI+3iT12aC528Z6YkFc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XK3huSLEy21YNLtiAusQnLwsrHKGG7eESv1M7B1QLOEOXBTk
	0aVRjODeBRSx7TAdecOLBts4WbaVM/jTXzsDCd+K+7Lo8y/b+yJg
X-Google-Smtp-Source: AGHT+IFKkPjceCn3dCoGeUfXxEm+Qd5/Ckkg2CB2n81ZyGDLB+2/5J4Ua1mC/Zq2eFgTrR9xxcG5rw==
X-Received: by 2002:a17:902:ce88:b0:20b:6457:31db with SMTP id d9443c01a7336-20bfe044da1mr153723435ad.30.1728287265043;
        Mon, 07 Oct 2024 00:47:45 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:44 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/7] net: ip: make ip_route_input_slow() return drop reasons
Date: Mon,  7 Oct 2024 15:46:59 +0800
Message-Id: <20241007074702.249543-5-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  6 +++++
 net/ipv4/route.c              | 51 +++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 32d9fcb54af9..e53f3d944e04 100644
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
@@ -378,6 +379,11 @@ enum skb_drop_reason {
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
index b41bb9be18e2..9b3f7bebcd86 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2207,10 +2207,12 @@ static struct net_device *ip_rt_get_dev(struct net *net,
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
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2238,8 +2240,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2249,21 +2253,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
@@ -2310,7 +2322,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, &itag);
 		if (err < 0) {
-			err = -EINVAL;
+			reason = -err;
 			goto martian_source;
 		}
 		goto local_input;
@@ -2326,18 +2338,21 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr,
 			       inet_dscp_to_dsfield(dscp), flkeys);
-out:	return err;
+	if (!err)
+		reason = SKB_NOT_DROPPED_YET;
+
+out:	return reason;
 
 brd_input:
 	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+		goto out;
 
 	if (!ipv4_is_zeronet(saddr)) {
 		err = fib_validate_source(skb, saddr, 0,
 					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, &itag);
 		if (err < 0) {
-			err = -EINVAL;
+			reason = -err;
 			goto martian_source;
 		}
 	}
@@ -2356,7 +2371,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2393,7 +2408,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2414,12 +2429,8 @@ out:	return err;
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
@@ -2477,7 +2488,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


