Return-Path: <bpf+bounces-40645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7898B407
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CEC28434B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBE1BD4EA;
	Tue,  1 Oct 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxCv8I8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689F1BD031;
	Tue,  1 Oct 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762463; cv=none; b=qHTSUIoKYTk2Xefx+xH4/8OFO97YMP9MqPP7Iej/F39zQeGOH3zkTaXgMgh5V+fkpBGRe/lRNAen04AuUKuJrH7LquLn9OESVjrwB5AUAcBX+OSsmUjk1QqkBI1j8RBelIAG03inouNUhePtDlT+EmI41yabI/cI9ARUDPbISCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762463; c=relaxed/simple;
	bh=YqEogfeJLe9c/3bfq2XxyWEglvHt5kZYl7TE1QySazM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4pN/AE/6oMQJEapC+EqnErLl2iKE6hTmzC9rBQs/E5JdoFOJc5MpoMJ6aT8EJmjBvCOM6q40UHTGOuDkHrX09CxlU9EN76EgwsHXa3lisvqEqo9gnaUSffecl9MA3fpqGXl5Iweh0DDmghkDU8dJbX9zyTZBkurUSwNjc79ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxCv8I8K; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so4049084a91.2;
        Mon, 30 Sep 2024 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762462; x=1728367262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiHzu+ulvjky3wzgvQb46nJbDFBRKyZby3oN41FMw90=;
        b=dxCv8I8KoyFDlFPyd4+nZKDHoPd2yVF5ua2xJCn7zSnCsbdLaiLbe2njRy0IzRxq/7
         eeNDAfe7tI8KOj8hw/LXh4HsgNb/boafe9e0Y7UzAlACqHMF5IU3TIZoFAMoeu7Ph6oz
         muEKCXFXM0+3F5zEV5TavpUV29gm1vdxKUYp1JamU04cz/0oi4b5xa2tzQ4UsDU1Vyjx
         nKDMYCgCqLWEzBPrZp2u556AZEackrbQW9xYI58685ixQ4KeLmHaqqzSTJGyZoqPsyeS
         MJ4Zwwf4b2HFbtBVAJQHlXyslhSAMGJ1lHv2w6hqoJfOR6nrBF8jc6KrTVxmiR798as4
         qchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762462; x=1728367262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiHzu+ulvjky3wzgvQb46nJbDFBRKyZby3oN41FMw90=;
        b=uzTTFCxt8ROAwNUw5aW3MDjyxdQ+6afZUvLanRejGXjZVMnvw/ZIF3OuTVqQ1kWAjf
         A0yXLmY6gKdhLtx23EoPEW5PSz7sqFjlJYbJ82SRfAWksO+yLtIwvbFU0Nu5l8CfSSKx
         hjIvRelwqpnzcPqrBbPiGMjnR47A7rL4hOFKpae4emgyWul4t4pXK/n+b4bkSiYbY0/V
         u12D7VYnX+lM3RyqXV9+TaP/+bzCOa0iNtnGWrZ89/UcbbUHbhTOB7JCjrg9i0tHLPpV
         lyBec4X8BFNFn5v7jBFgf/8T8ExIXWNomEHgqUix1Ewreb2FJj5BK5+5wLMhKY5NccNn
         z8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUP1UFdUl2yiYmn4KqM+//UFZPuO160YcGgB2qwG8LAkOMhBD39lXKu4UlFZFmToCKn+SZw/tvp@vger.kernel.org, AJvYcCUg/mfBDXcxhSUhveUYeU7jCK+wl3vLSgZ28sa2LB9xfb3x6e8UDaG2dVFZZIGkA6IZWfGpUF6pYr6VU9Pq@vger.kernel.org, AJvYcCXR3eJytNs9cFSbzTVOCnMCXNorezed504wlHdLkb0kTbRNoJmpwmPhpp7LGa1Wo0RdeSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8woUmzvw4QRABEXuCbCbafEwAQZrzdZ21iRqgH1sPczT/r50R
	w9Ii20MxtOdn0+755lJBphHe87EqpmaiHJFkp9nnYtdpjGfNhDqa
X-Google-Smtp-Source: AGHT+IGxcp33HKAcRKYo2olYX1EnTuL6eZiMVBrOhxAu/Ez4aMIx0IbRoxiePDmgWrqHJXJmllCczw==
X-Received: by 2002:a17:90a:3486:b0:2d8:89ad:a67e with SMTP id 98e67ed59e1d1-2e0b88903famr18880996a91.1.1727762461479;
        Mon, 30 Sep 2024 23:01:01 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:01:00 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	atenart@kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
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
Subject: [PATCH net-next 3/7] net: ip: add drop reason to ip_route_input_slow()
Date: Tue,  1 Oct 2024 14:00:01 +0800
Message-Id: <20241001060005.418231-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001060005.418231-1-dongml2@chinatelecom.cn>
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_slow() support skb drop reason by
adding the pointer of drop reason to its functions aeguments.

Following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_INVALID_DEST
  SKB_DROP_REASON_IP_LOCALNET

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h | 19 +++++++++++++++++++
 net/ipv4/route.c              | 32 ++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..3d1b09f70bbd 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,10 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
+	FN(IP_INVALID_DEST)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -365,6 +369,21 @@ enum skb_drop_reason {
 	 * IPSTATS_MIB_INADDRERRORS
 	 */
 	SKB_DROP_REASON_IP_INNOROUTES,
+	/** @SKB_DROP_REASON_IP_LOCAL_SOURCE: the source ip is local */
+	SKB_DROP_REASON_IP_LOCAL_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_SOURCE: the source ip is invalid:
+	 * 1) source ip is multicast or limited broadcast
+	 * 2) source ip is zero and not IGMP
+	 */
+	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 385efe6d71a7..ab70917c62e5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2202,8 +2202,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
 
 static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			       u8 tos, struct net_device *dev,
-			       struct fib_result *res)
+			       struct fib_result *res,
+			       enum skb_drop_reason *reason)
 {
+	enum skb_drop_reason __reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2231,8 +2233,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2242,21 +2246,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			__reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			__reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2315,7 +2327,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, tos, flkeys);
-out:	return err;
+out:
+	if (reason && err)
+		*reason = __reason;
+	return err;
 
 brd_input:
 	if (skb->protocol != htons(ETH_P_IP))
@@ -2406,6 +2421,7 @@ out:	return err;
 
 e_nobufs:
 	err = -ENOBUFS;
+	__reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2462,7 +2478,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return err;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res, reason);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


