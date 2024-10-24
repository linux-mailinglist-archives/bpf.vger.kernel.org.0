Return-Path: <bpf+bounces-43033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C219AE0F9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8212B2136A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FF1CEE8A;
	Thu, 24 Oct 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpfLS0rJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8011CBA10;
	Thu, 24 Oct 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762506; cv=none; b=m185IZAH2ZZKkFLM5lTlycdkiQZcNCtkrTHt9zpw7CYQsLiEXBTIveUwHjN0T+5jcrNJLLjLsO43busJ4nkIU8xb6QPYSXv173sO6un54QnpZJYjCX5nn926/IElJrPoCRyny6ExgaQ/JdQ29MGg0O65uaBduXmxfEGsAWJibrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762506; c=relaxed/simple;
	bh=t2qbhSnr2J280GmqHB3cOqoaPQoBk9NuwAi6VMRWxwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hek7Z9JY6YIBvvdnGRV8hdwJcZFyxrCTcBoK4skqQ+fF7wrRPxYxIewvF8UnMNif5/DvFCzBYqpy9HnxHgalSZxv6r0wEha7mbRE7/0+6HoxU/lkAs+rdHK4z2gQtKppiBfRDkhNMYLSmlm/ilgiC0q21decVE1IWWnXoaceKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpfLS0rJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cdb889222so5436135ad.3;
        Thu, 24 Oct 2024 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762503; x=1730367303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sYHu3jOQDhnsGiy2j7wnqe5lcTLCFT6TdpJY1JQ60c=;
        b=mpfLS0rJHVjqJxE+7cEcV659MOlvKSHZVn5KU8QG6Oa2eijqnziZwdFKYaijXiIt8p
         VJWfjp7R0K2JQy/IoHcKbaRdMtRDz3DXXypQrCB99ZE9Ltiv048TmDUo6fXQ8Cai8g4k
         NnBMYc/ftTgPKkCfUKt/XMYUg80ul+Jh6puztr2ikt95DdiRPKxH6qgoh5Ppje8af//o
         4LS2zCjM7iAZFoKAOhTNRV8ggD2tHHfbE6INTEeFdEiXG4BY95M5d+Qv7ZBNaztq0W0N
         vUfuBJf/INIIb3aQMUZzGG2vngKuwGVvYJ8wLPmtxlJt4kSTS6V2ZA1baZ1GzmPx11c/
         yfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762503; x=1730367303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sYHu3jOQDhnsGiy2j7wnqe5lcTLCFT6TdpJY1JQ60c=;
        b=SsPyfRiLhDfd7C5Os76UYkeYflYix5UKckiiLpg8T8nJMtDvqUHVSXQcnTEKg7S/wR
         UtTQhZb/FHWaMnw1cbWy24aRumJ3jO3BUSqFh7Lta50xtvccXU4lR1bJc2FbO3/Z/lMw
         ESoe7E6zQKS79Pgmi6Lt1R+mh8eZI6U5R6gS3E5BEnXCrQVnlCwrliL13pjXfYsokp6G
         iAuuVF9tcEMLa/Uy+N7tN9eCr8ihyUUrk0cUQcLy3jeVHZPp7JSWdXeYuTbcuQz0afcX
         19pGaR6ENKWp3A5gufbYZNYdPrSHJ2zZ0+tts87aXSYIHhWsK+LmK8CwdZvVqIDda2Vx
         gBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGEUfqfYAWtOoOMnylqN2eanHinCGFmFAk1pVrimzwKlHmHxYLWBH7D6wYtz76gWDXukCyZe48@vger.kernel.org, AJvYcCUJ1aF4Ipptb2AWURGBI3j4vTHDQcO8fFpe2Y1IWSNTt9Pj/Jhzpd6mhsBK6QyR7z8A5AOvLCVlIQinmQQ2Sl2P@vger.kernel.org, AJvYcCUefaNmUGSzmLCoHR/40AYORl+4p2dclihhn9ckn4JZPPZ1FWp0HbiVbvUBKogJgYx+CSo=@vger.kernel.org, AJvYcCWJZCyjQ64/5UPcePqtH7UOHCseVrV0pX24/b9HOdhtY9/2aPENdqgXX6+1/4kuZ/xgVb6XNPxE2YQ3OXMU@vger.kernel.org
X-Gm-Message-State: AOJu0YxncXDmg+ZE+2Qn/EKcjzGT9FXtyy8DTZ7edvz9+0cKgSYOKIxk
	Ae2hKZbvBBEyGQWxSZgbKQUChxXi9wkJhNIDmFqBzbg8UyvAwzfa
X-Google-Smtp-Source: AGHT+IFA2/ZyjL+ClK4gyJ1frpG1cZXgBHF08kEZXuKcPerDgVOxZbqCB9MgVDu5Zl/rKCC8Aomcvw==
X-Received: by 2002:a05:6a21:2d88:b0:1d9:2453:4343 with SMTP id adf61e73a8af0-1d978bd2ff7mr6757395637.41.1729762502939;
        Thu, 24 Oct 2024 02:35:02 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/9] net: ip: make ip_route_input_slow() return drop reasons
Date: Thu, 24 Oct 2024 17:33:43 +0800
Message-Id: <20241024093348.353245-5-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- use indentation after the out label
---
 include/net/dropreason-core.h |  6 ++++
 net/ipv4/route.c              | 56 ++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 21 deletions(-)

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
index 61e316f93291..7976f687d039 100644
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
@@ -2316,19 +2327,26 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
+out:
+	return reason;
 
 brd_input:
-	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+	if (skb->protocol != htons(ETH_P_IP)) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto out;
+	}
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = -EINVAL;
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, &itag);
 		if (reason)
@@ -2349,7 +2367,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2386,7 +2404,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2407,12 +2425,8 @@ out:	return err;
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
@@ -2469,7 +2483,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


