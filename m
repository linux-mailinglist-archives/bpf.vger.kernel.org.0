Return-Path: <bpf+bounces-40643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8098B3FF
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DB41F24216
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0291BC084;
	Tue,  1 Oct 2024 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIN6JpjO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373203201;
	Tue,  1 Oct 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762454; cv=none; b=RQJ+lmhPAevgb+ImDBV6JqkpLuZyGe2dgg3ut3f1tr/NJw0Hc4zE7gOu3ZW2wyepOdvEnA4KjRzfbZGF1df9EuQnHhjFfexPgU4uGkBflW09eRZOhzTFxH8xDsttPCnJHYEiRuBDZPUevUrfgYbvelSlVUv9KH6QLZtkzygpbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762454; c=relaxed/simple;
	bh=bi9qHUYSYj5R5/Cy89PHJiTTpuqSNTzbMTJblylefAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0iP9GusetzOsxaPYWbMtfyBtQBnouunJJzZENjn2Vvn6WQN8i3/Lir5vSoGlnPOOLHld1df56t79M01RCNNAZITy9W6tQLtvXzOCNWsHDEH8ttigd2K3c9bLaQcvO0bvGTIpHgLDVqNRXR4G+e0CBgIjVCy+Y8E5jhf3Zhzguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIN6JpjO; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b7259be6fso22347885ad.0;
        Mon, 30 Sep 2024 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762450; x=1728367250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdv5HIXyXj+s2ZfUexwxXp65XLHAbGKyjQZiJwWQfHQ=;
        b=AIN6JpjO9zCqEPalqVZqcogGnhuz/p/OHT6C9g/ESf/BxZkmNI+YI4QlnDzno2pKu4
         2gREXGBpliFmHtBFuIGrIIDCcrPPxmxWnmxcQ9UPbkVcSRZi4s+WsA38EjIVFk9dcVsq
         ORQyskT4wTDrUq+aKfNl2ku+jiPmvvbJzCoJbbasadwBjKcbAn5KDZ/Y8FVzLc2mcG0k
         +0G5gZFbPjWqojefUTqQJ/yoaa3WUpYdSV8xnJBWno+73rtSmvSvyxW6uw+rlsa7xSHe
         NhpNScsajJcJE7nF/4TRkCIZtIf20M3v3upinEf816xgyldru5jWYkR2WJtziYmdGe4w
         GgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762450; x=1728367250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qdv5HIXyXj+s2ZfUexwxXp65XLHAbGKyjQZiJwWQfHQ=;
        b=gfZFYLni9d6A63KaCC8qYSAz6He3BI986LezeqBs7cWz+wVwVToRD1Oum2LjtJdvkl
         qAJK9A4eLN7TxHNMEN8gjWuq9InBfmVIAx3fGQE4D1T4wfTklT0+RVY/JvdAPMiNjiMV
         T8iLBYhrw662DESaGeCcLV+2VteG3FhD9esSCfnPSKv1NsKKaMlTEpODUVrJJ8Vis8df
         emSLWWOpS2lDk15Xkv8TnMoWss6PyP78uRg4+vQQAMkNcYzP9V8+sCRW2s4o3YCURQ90
         E4hfN/tftVVai24UnKRnCGibkq7imVV5K9VSyZmddL+yYrahNZLNqU2dp9UtCF17m/ex
         A2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV0mElBpEVbgLXyb20duRZMU8osdtgJCzHebQT4kkJqzyF8jkQ8rmFrKDzdYkz8vFSpfyIIR6IxlfEZfCEt@vger.kernel.org, AJvYcCVU0i6f5zfHJ1WuLlThIcIR+om43mFKKJUm7qBcPPn25kUYFGJ/bvhwc/6uPwRz01PqNRrWyUYn@vger.kernel.org, AJvYcCVXtvO4CETD/kyCBJZVZzUrNXGChBzTF+i57V4POUx621KyXb4AedjTeJUiGsSojLSx6WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/88nXW8mmWnuaG5FZhNW1kCibfao5nXh/O3tDYI9bm3ohWnhF
	AypnLYeJpuP0TudB/X4TBpca4jGGX5BRmjRX3QThM4VGpa+rAz/2
X-Google-Smtp-Source: AGHT+IHvaW3MaFGSFy9uaS3fy6I05gRp/vBshzI/8wk5lXRbhoNPGVz56IpzT1YfXaYtgCndDScOzA==
X-Received: by 2002:a17:903:1ca:b0:20b:4d9b:e4fe with SMTP id d9443c01a7336-20b4d9beaa6mr188282145ad.45.1727762450362;
        Mon, 30 Sep 2024 23:00:50 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:00:50 -0700 (PDT)
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
Subject: [PATCH net-next 1/7] net: ip: add drop reason to ip_route_input_noref()
Date: Tue,  1 Oct 2024 13:59:59 +0800
Message-Id: <20241001060005.418231-2-dongml2@chinatelecom.cn>
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

The errno which ip_route_input_noref() returns can be used and checked by
the caller, so it's complex to make ip_route_input_noref() return drop
reason.

Instead, we add the pointer of the skb drop reason to the function
arguments of ip_route_input_noref, and adjust all the callers of it.
Then, we can pass the skb drop reasons to the caller.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/ipvlan/ipvlan_l3s.c | 2 +-
 include/net/route.h             | 5 +++--
 net/core/lwt_bpf.c              | 2 +-
 net/ipv4/arp.c                  | 2 +-
 net/ipv4/ip_fragment.c          | 2 +-
 net/ipv4/ip_input.c             | 7 +++----
 net/ipv4/route.c                | 3 ++-
 net/ipv4/xfrm4_input.c          | 2 +-
 net/ipv4/xfrm4_protocol.c       | 2 +-
 9 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index d5b05e803219..fbfdd8c00056 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -52,7 +52,7 @@ static struct sk_buff *ipvlan_l3_rcv(struct net_device *dev,
 		int err;
 
 		err = ip_route_input_noref(skb, ip4h->daddr, ip4h->saddr,
-					   ip4h->tos, sdev);
+					   ip4h->tos, sdev, NULL);
 		if (unlikely(err))
 			goto out;
 		break;
diff --git a/include/net/route.h b/include/net/route.h
index 1789f1e6640b..cb9f31080517 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -202,7 +202,8 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  u8 tos, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
-			 u8 tos, struct net_device *devin);
+			 u8 tos, struct net_device *devin,
+			 enum skb_drop_reason *reason);
 int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      u8 tos, struct net_device *devin,
 		      const struct sk_buff *hint);
@@ -213,7 +214,7 @@ static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, tos, devin);
+	err = ip_route_input_noref(skb, dst, src, tos, devin, NULL);
 	if (!err) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 1a14f915b7a4..df50f2977c90 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -96,7 +96,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		dev_hold(dev);
 		skb_dst_drop(skb);
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   iph->tos, dev);
+					   iph->tos, dev, NULL);
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..a9dac0ef2be6 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -835,7 +835,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (arp->ar_op == htons(ARPOP_REQUEST) &&
-	    ip_route_input_noref(skb, tip, sip, 0, dev) == 0) {
+	    ip_route_input_noref(skb, tip, sip, 0, dev, NULL) == 0) {
 
 		rt = skb_rtable(skb);
 		addr_type = rt->rt_type;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a92664a5ef2e..cdc75cfc1826 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -176,7 +176,7 @@ static void ip_expire(struct timer_list *t)
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
 	err = ip_route_input_noref(head, iph->daddr, iph->saddr,
-					   iph->tos, head->dev);
+					   iph->tos, head->dev, NULL);
 	if (err)
 		goto out;
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index b6e7d4921309..dc062ae49137 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -318,12 +318,11 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
 {
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct iphdr *iph = ip_hdr(skb);
-	int err, drop_reason;
+	int err;
 	struct rtable *rt;
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
 	if (ip_can_use_hint(skb, iph, hint)) {
 		err = ip_route_use_hint(skb, iph->daddr, iph->saddr, iph->tos,
 					dev, hint);
@@ -363,7 +362,7 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	 */
 	if (!skb_valid_dst(skb)) {
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   iph->tos, dev);
+					   iph->tos, dev, &drop_reason);
 		if (unlikely(err))
 			goto drop_error;
 	} else {
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..f1767e0cc9d9 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2465,7 +2465,8 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 u8 tos, struct net_device *dev)
+			 u8 tos, struct net_device *dev,
+			 enum skb_drop_reason *reason)
 {
 	struct fib_result res;
 	int err;
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index a620618cc568..14990cc30c68 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -33,7 +33,7 @@ static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
 		const struct iphdr *iph = ip_hdr(skb);
 
 		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					 iph->tos, skb->dev))
+					 iph->tos, skb->dev, NULL))
 			goto drop;
 	}
 
diff --git a/net/ipv4/xfrm4_protocol.c b/net/ipv4/xfrm4_protocol.c
index b146ce88c5d0..9678ff876169 100644
--- a/net/ipv4/xfrm4_protocol.c
+++ b/net/ipv4/xfrm4_protocol.c
@@ -76,7 +76,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 		const struct iphdr *iph = ip_hdr(skb);
 
 		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					 iph->tos, skb->dev))
+					 iph->tos, skb->dev, NULL))
 			goto drop;
 	}
 
-- 
2.39.5


