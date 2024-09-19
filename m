Return-Path: <bpf+bounces-40091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E497C755
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147151C2673A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5418E04D;
	Thu, 19 Sep 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfGK/3p9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8919C56D;
	Thu, 19 Sep 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739009; cv=none; b=Ic+hRluDahGCWMEKhwQRmusN/xCwtsPdK0hPPP3ocm3w4k0Zv3pSLDHJ0sZj+1FX0kVIoLQQuzZNlfvUzl/AtRm1PcSQbQP19RtemUTUdIoReP/2RYBkzv/zVKLpgddmyQnBKaqaozgL789VEIk2DI5Pm/IKv3v+DVRhbqn4EjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739009; c=relaxed/simple;
	bh=01sg2zMVd1oVMDp9kVXp8rgM1zgRtpG8t/SrRBvKPko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnNHR9RMEhAi8blpY9OD7ObEOUwHK4eOj9EbE371S1iOfuAgb8DS9koIO9CpccF+IwVQbCkqna2CabrK9q6h8rNJ60+Ow0Lp0LfHQRYPQwJSjVdZ7p7RZLQkFVsNP7+QWy2AshBRoSCLHC3pmZX0HnpX97S2q3A/RkEMx+v/RdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfGK/3p9; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5dfaccba946so343675eaf.1;
        Thu, 19 Sep 2024 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738989; x=1727343789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePcqGTH0Kg0x3qgdAakqngmH7w8Gex0rfBmpVr2hqzg=;
        b=OfGK/3p9DGtOyWWxQe24Dr+vDH8OUx9VvsEfdYOVCTwAop5iackFxFB5sNByZu5qlH
         3vuk0ZIeyy5gVMsi5dbRHSGvQ1bvdL7itvp0WKLLzDogzkSRsq4kUfmxfdFD/lOYN/Jp
         Fkx4cJMZtaoLWpiwDe/BDJ6BzAtnYUP3EBk3SZuxycvMAU+jrbiex/FJiUs75fDPuZT8
         7FdDrxIpego0kPF0lnF6Krma2JhANYkqjWhHcCgPXlqPVwKxr7nOiA1MzxX7GgT3W7di
         aWB79oKaB0rPuegJ8xm/cETdJKxwHDxW+xFv4f29Q+9yMtgCoQnQGI7GyT2X6lTeuwZX
         zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738989; x=1727343789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePcqGTH0Kg0x3qgdAakqngmH7w8Gex0rfBmpVr2hqzg=;
        b=grlGUrtCAVALLxb5HuslF10oL0gPVBWFZMVSpiV40QHGwdBcqo8d3k5cyJjYBMFZ5v
         pzLnwH8JJOhYDExaRU8+bKfMhIBybmPiSUbruTADjPDDafxAsLRMQsFwaz2H5cPzeq8G
         UmZrQqxSORv7BZGi3HZUHxhiWmEeVA6BchKYXRWQrH6pZeptnkilfQJTrV+m0iNzYSnR
         Q7WHW185tMNjP6jH4pIrR0oZQRvg4bAPmwgNf6quYg8WXlGlJAbfqGifEiosOwLxntEj
         7IxAXRh8wj0zeKDFr3CX7REtjSX5fLOSJDtoooxb0H7p+ARwB8TYOwx3pLYd6OeURFUw
         YMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU6gmUqxtnKkOGSNb6oAsQmcfNWrR/vt2zF9JcWpTOg2eGdmrEmhj7Q/zmy/NnLOYVTeYQXg7J+Bpui1//@vger.kernel.org, AJvYcCWHhXEu1JnYvHslws7OkcDk0b0sA09uHTl2xeZy6DWsicdJJIFmZ+6H0g8hHbuDILmt1ujeNj98@vger.kernel.org, AJvYcCWM9O3Nmy40cDhF/9sdP5gmIy7eKiYmvMbZb9YbYBLA4RO17y4vm8QYMDXj1WLhWZfqvQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6Ox5sZkt6u7Wy9of/WboS5wOi68J50YrcorfRO5jNZvnUbeH
	iTxCZYOjVuWBJvKBFVwz+mrcyLtxJlIJiuo513E8anBuLMuglAuU
X-Google-Smtp-Source: AGHT+IGT+GB8jczoNpoAA8VLFkChC4I98TyZ15dJ+fhyfuQZ0MmfMbuU20DB3/3Ip/QBhuYmXxKxJw==
X-Received: by 2002:a05:6870:a3d0:b0:270:1d71:f596 with SMTP id 586e51a60fabf-27c3f6a9bc2mr13021450fac.45.1726738988781;
        Thu, 19 Sep 2024 02:43:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:43:08 -0700 (PDT)
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
Subject: [RFC PATCH net-next 6/7] net: ip: make ip_mc_validate_source() return drop reason
Date: Thu, 19 Sep 2024 17:41:46 +0800
Message-Id: <20240919094147.328737-7-dongml2@chinatelecom.cn>
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

Make ip_mc_validate_source() return drop reason, and adjust the call of
it in ip_route_input_mc().

Another caller of it is ip_rcv_finish_core->udp_v4_early_demux, and the
errno is not checked in detail, so we don't do more adjustment for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h |  7 ++++---
 net/ipv4/route.c    | 33 ++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index cb9f31080517..cd0f585dacf0 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -198,9 +198,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	fl4->fl4_gre_key = gre_key;
 	return ip_route_output_key(net, fl4);
 }
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
 			 u8 tos, struct net_device *devin,
 			 enum skb_drop_reason *reason);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3e11a1849ac0..fa27f2120334 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	int err;
 
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
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, itag);
 		if (err < 0)
-			return err;
+			return -err;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1701,14 +1704,14 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		  u8 tos, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
+	enum skb_drop_reason reason;
 	unsigned int flags = RTCF_MULTICAST;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
-	if (err)
-		return err;
+	reason = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


