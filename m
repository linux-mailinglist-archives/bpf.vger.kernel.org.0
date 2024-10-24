Return-Path: <bpf+bounces-43038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD379AE113
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8410C1F2409F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC821D8A0A;
	Thu, 24 Oct 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyS/PHj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EE1D63DD;
	Thu, 24 Oct 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762533; cv=none; b=kRV4XARNDbxx4/vdKHkx6WyPnt8fFZX5OSktXLCIZZksAwkk1uYGOXZb4EL4BYzJPpjCXE1jeOdXPjg62ofcFSvAa71CHR+jgEqnp1YsQmxvwEyQnjoL6BHTeiwpaRj4REmWXlzvHJtdKoZsYRNiihW7KKRPB0XApvI7/5eGPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762533; c=relaxed/simple;
	bh=JOjiHl0o7arpbaGI4fKyn60i1TcmeSt2tbS6VcLQj6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E5Qmn+HASnsWV89DM9GP1w3fvu/NQV9VYVXe6JpOPfxWb/md8fiB6l/L0yroDVH+WHZJwEBfvwcpsJwiTjGaVBwG4Gmab8wd3oSGRWDHKYTksld78g4NSuT3LodAyVFVHoGqVJncpd6dQrXHZ7HVrGFldBoILKURMnIvRAfoDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyS/PHj6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e7086c231so525888b3a.0;
        Thu, 24 Oct 2024 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762531; x=1730367331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stvt/ug7FcaGbWi1ypKLhLB7lISmAXSv7hL3d+pTSLw=;
        b=PyS/PHj6aU80YmpFaEeiYhYFPXQHqHobn2F04+ixUP5a0gVUzTdR5VxGcIn6hq1Dsi
         AQEOfF3Wx2D860sCDUIHL9o9ux4WNZAS5Fl4LzpFJqQ53gieTrwCMlVQ2XwMNcaepffR
         dCEhXGduuEGECZhdnkFLc4Y8C2m9aJKIic07UjWBKQxNqsVuKeLme8DKt/xRL7+DW8mG
         sGFsBwFOHsOycnHfNApeZuPLe9yBurdTcezIIji38Xm/bZ2elTU/jV5zm5CJ2xWQ1boR
         hmk5djN75RuHJgQ+oaVK0E20ObyAl5C8vlQjDOE6mpJuRz0WU7EZMOa0daEXxinCb70h
         Ph4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762531; x=1730367331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stvt/ug7FcaGbWi1ypKLhLB7lISmAXSv7hL3d+pTSLw=;
        b=YMMvoMEVNU6s/JyzJNpfYOAbGaxC+QD+8Qpl43i04Gp17EG23KZXNQpKzvoA7Nj6fu
         KNmwwHmEZNGgVL/wtTYT1nRXpDX4qxvyRxCOurF4R76PfHd83Gwrb3wtRu6qPaqJj3+X
         lQmGYytj6nDmWOM44wsLqC40228Ee2f8AFKFMewgyaG+3yKZJkQ/KcXWRCR0J8/JUlvB
         s68Vxbi9lCUSXGLkq/yyAdU/0PKHdYHm5WaJC1C0AvbxZ/ufOS07CXInWEZar+EaYb7C
         55BHyuvsMKFcU1vx2Sz6kkZ8iDP3MvQnl5mx+r940bq6190CADpxDKNGPM+n7nYrCRaZ
         f2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHTxk40fY0KKaUB+qf5DxWizuESpQxKw8exgOXr9XBsebkgTV+WTGwh1I7NcMlrPFc2zSGQ9Sk@vger.kernel.org, AJvYcCVyfNUaOYWmCM/E6cF+v+fJtnwbMQM1eyCOgqZgaO5Kg1uGdiHADbDfoyQrTzeaxAAAymcVZwa8nO0/6w0nm5LN@vger.kernel.org, AJvYcCXgH9Y4myhxmOq7iNl37TGA0VQGTb9Eqj1fuXdaFmOgAYB8UH3KPExwXhRG25e+0DhF74bV7dE1B9igReW7@vger.kernel.org, AJvYcCXqqLWcWPK9FWDK723IOr01dlV13/yknO/tzDx+sKMw5I4RHdXcsqo3V8KzBXvYBme5F70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4zaLDJadHD3NiopthPiQACltqRp/NYrbhEs2F4CGEbq6FeyX
	kxHHNXtA2pqnNryiyf1f5gJlQgw/Tx56PBgL/mTFLZxXvuG+HpJz
X-Google-Smtp-Source: AGHT+IEI2KbIxBuhuDZXrMTT1Lpj9/l1Jy9coAQRCILORelpf8QIpMfgUp97aC8o2zTFfXjHv6SKWQ==
X-Received: by 2002:a05:6a00:8d4:b0:71e:617:63c1 with SMTP id d2e1a72fcca58-72045fe2578mr1263741b3a.27.1729762530766;
        Thu, 24 Oct 2024 02:35:30 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 9/9] net: ip: make ip_route_use_hint() return drop reasons
Date: Thu, 24 Oct 2024 17:33:48 +0800
Message-Id: <20241024093348.353245-10-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_use_hint() return drop reasons. The
drop reasons that we return are similar to what we do in
ip_route_input_slow(), and no drop reasons are added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h |  7 ++++---
 net/ipv4/ip_input.c |  9 ++++-----
 net/ipv4/route.c    | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f4ab5412c9c9..4debc335d276 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -206,9 +206,10 @@ ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 enum skb_drop_reason
 ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     dscp_t dscp, struct net_device *dev);
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint);
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint);
 
 static inline enum skb_drop_reason
 ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 513eb0c6435a..f0a4dda246ab 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -322,15 +322,14 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	int err, drop_reason;
 	struct rtable *rt;
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
 	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr,
-					ip4h_dscp(iph), dev, hint);
-		if (unlikely(err))
+		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
+						ip4h_dscp(iph), dev, hint);
+		if (unlikely(drop_reason))
 			goto drop_error;
 	}
 
+	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d47d7ae9fc61..7a064e3a2d49 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2142,28 +2142,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
  * assuming daddr is valid and the destination is not a local broadcast one.
  * Uses the provided hint instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint)
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
-	enum skb_drop_reason reason;
-	int err = -EINVAL;
 	u32 tag = 0;
 
 	if (!in_dev)
-		return -EINVAL;
+		return reason;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+		reason = SKB_DROP_REASON_IP_LOCALNET;
 		goto martian_source;
+	}
 
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
@@ -2179,7 +2185,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
-	return err;
+	return reason;
 }
 
 /* get device for dst_alloc with local routes */
-- 
2.39.5


