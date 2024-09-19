Return-Path: <bpf+bounces-40087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE397C743
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91720289BA7
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B119D08F;
	Thu, 19 Sep 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBRvs/DZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD919B5A3;
	Thu, 19 Sep 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738992; cv=none; b=YlZDaePye6Pp1AlDyzlSX8rFEIzVTTZkZ5jr1w0ZkMc5B5pSSsTQQCn14gdy8Y7lgOKdt+3pUi/PB4wQ4u+N+qbmQVF5Eimx7nxxTgZmu7CHfwpSRAlI5D6K6+bIEnjiZBAZZoQ631h//fPVbz+pbtaN4K0zbyTx53QagbToTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738992; c=relaxed/simple;
	bh=bi9qHUYSYj5R5/Cy89PHJiTTpuqSNTzbMTJblylefAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snhT6wF9S4amot2idY9ikcMvOdTIFkv69x5s+DwuSshE0L//neqe8baxmSy6hBfh5rSHoldplL9NwOdM2yljDWkS2LUX0/SYVByFO2LCUMNBJ6h3jNkzuMuRZADfx0hJNld/y9lsLema7V1sCXQWwvf8zax7oEtVElrBYwc+GSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBRvs/DZ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71923d87be4so454549b3a.0;
        Thu, 19 Sep 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738968; x=1727343768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdv5HIXyXj+s2ZfUexwxXp65XLHAbGKyjQZiJwWQfHQ=;
        b=SBRvs/DZg/zwaztzUtrUu+D2pE4FTvo4j2769UdEVLN1Ckc1USWqbl+BHS2P/BQ9E8
         VTChEc9PLBM1b9tfIc2XR0mX3AYH4/sSflbFyp0W3qp+6hJbRHAlErIkOKg52dX5wxBu
         b9fU1p22tCIFy7ePwDGNLhJ32BTkeZwmstzybj/A/Kc57FxAuzt0aMBqMsQF/dOLFYvS
         ITHFX6ScrGZWwDGVHERzhRIsy8zuh9eo8C9OOqhtoS1ePo/fkgqZea8AYMUhM0FaGe0A
         qNidM26hXG7+DS5D0pe2TEkaeAPtt7Y8vxQFcLRmD1qPZDC3/Skp0u9pqLO8CvQxqmRV
         sQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738968; x=1727343768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qdv5HIXyXj+s2ZfUexwxXp65XLHAbGKyjQZiJwWQfHQ=;
        b=w1KbKzWXASMEihM8KjFDFdAK1E81a5u5ZrYBCditCfdFIwqSxdiu5BC62w47XBx1nm
         HGqEjlCXHN00gPWRPrcvWpA+ukIXzxmRguYdFI9yPjXnKQGXmSqKoeXTtPdn43I1ltcz
         e/m+DJkFSZg6yM7sOHlAFZrmxWWZrkAZvf9VH/z/K4SIeiSvqixnXpxO/B5HsiJT+JYq
         2A5z0Yrm21HTwIaLqxe5zTk72AJD5RlCSIumK4S2fiAduAgZv6jnnbwcEBWWovUXkLmo
         ERmV++Q+tERJl+YjSoG3UcnJtwjiJdOAl3jSclhEd+JnohBNzAg00L6zH+aRnudoKhop
         nmqw==
X-Forwarded-Encrypted: i=1; AJvYcCUeFZ1d2m2+8wyIv9w+4ifEkzUv0l1MUawqiN4Pfsfq8/cMI7iB62haJ4AWmPtc+vexRrMXqd8q@vger.kernel.org, AJvYcCXNVTtyPSJfle/lx9oTev7lgsb8SR882OQQb1MZUNQebIDilg5MM2N+5hZkiu+7+qYMeVU=@vger.kernel.org, AJvYcCXYagAv3cFOV9OItIoqavc+MGJnZib2tauPkPwrNr1tqNuJ7dv1yfZs+P9+r8Hk6GqIn7Vqi9XeXP6ZGWKE@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRF1Ub8LZlg/ayNSjLnWb0D5wGtUsXI1d5dO2Y9XUgSn7o0pb
	w6acZ/EZdLgGrXdN8+2vCbuMfJLx7L+GZF7F3P0XyDpCSvGs2tjN
X-Google-Smtp-Source: AGHT+IEaghm/PKlv4pWD+V10NvlwF9cqV5TGy84i0y5asM8Fy5rVh8rnsA83ELFce6Qr5SzWhxzVZg==
X-Received: by 2002:a05:6a20:c707:b0:1cf:2ef7:b396 with SMTP id adf61e73a8af0-1d112b339d8mr34052623637.6.1726738967640;
        Thu, 19 Sep 2024 02:42:47 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:47 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
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
Subject: [RFC PATCH net-next 1/7] net: ip: add drop reason to ip_route_input_noref()
Date: Thu, 19 Sep 2024 17:41:41 +0800
Message-Id: <20240919094147.328737-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919094147.328737-1-dongml2@chinatelecom.cn>
References: <20240919094147.328737-1-dongml2@chinatelecom.cn>
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


