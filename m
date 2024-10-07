Return-Path: <bpf+bounces-41088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253CF992641
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946311F222A1
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856A1885B7;
	Mon,  7 Oct 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiF3oA0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BA13E40F;
	Mon,  7 Oct 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287254; cv=none; b=D/g6UVHR4c7GWj/Voks9FXz6I/ZveFF06wPSkqpzXsfAs408rJJUqJG5rRC2xpKfuiZntOX7lh9NS1kKx7o39fUsq0DgBB1mDp3nku5pooqcsZmjobWPxzvDvmnDXPw4BUfs58wOXLxHoOeJuMqQvWalp8bijqeiPRg1m2eYgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287254; c=relaxed/simple;
	bh=Fo+ptBtT6UPPnDahPnacUgXk1sFrEC0JlQw244eQ8aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoiMjJkeG0N9U/0zWbr4lz04jRF75CKjhwniaCcJqEusOqO4hzYctX4RdSADZm0q3iKZ7BN8NAS+rjBOtsyTDH0k3CwRL2lnzokNGKuQMvc3o+p06/2Cdw0+iBqrJC4esi10Y3FYAvcvN7o6R24y6goEJ3ds/e/LR+LVaZee7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiF3oA0G; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b8be13cb1so43913645ad.1;
        Mon, 07 Oct 2024 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287251; x=1728892051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG1gKM6LqD/QEAjCSVvStNkTZW3iw+H01oEnAiBabsA=;
        b=eiF3oA0GmXc0mTZOpA8ETuYWLunkvT2+UD0pu907PcoNQi3v05vmcYYrW9NzDPQJKO
         yOSp0z/2T2zuCaIufXjXkEltNeE+GcS/yGQc8jeP6woIZcqh427bkNO5oJ3dxjR5IhTK
         mpS/UXXmxiOqtsnhuQKgR9mPRykOXWy78eu3Sw4nE75QTo+LS2jdNjgv3HeyvATCKY52
         34sIRSCfYzzuj17N8vNCYXziTKZzlAvp7Fd1ZXuSYQQMzK1Xa7frBKFjQb/CBpTGdMKk
         a6fqRfVR5g391DYLoPU1xsRsIMnkHuJULi4xwFVax8YYqabJjKoKaZcZSlI9KOAykvAB
         z/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287251; x=1728892051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG1gKM6LqD/QEAjCSVvStNkTZW3iw+H01oEnAiBabsA=;
        b=jUOr6f2jaq2WmR4TEjhQZkEfGFfaLJjCThnxTsRIUdSMWORe83ALyR4yfSx8elFbrw
         KhazHdKUsxG/wIKUeLg+GE7S9NIZnhQvy745MfBusr4bip5RtaHiTB0z+jVgZ+K0NzgK
         dmKCry0jDXrV8XwN0grlY/8G3911NiYgsk0YsC3bZ7X5cx+aFYu43Sbzn2EbdBetGj4W
         GZlJgrGQJX6BbJLDmavKVLIGLcxkfuskjDaT/3BBbGe0bbWjOW/gv98KoWO45n5vKRl9
         jymn3XFHM8X5ACwtQh8TQP8i+JfQKpIw3C9UaGRBV2FPVnLA0VH2cl+R3yD8+LNdnm6a
         RZWg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDA1aXfdIP1ulYjAYq1hXZJCd/nyRSIE4P+kMPqKTAAYNY4ayU7AB0n9PhCdsPwfrVysRdB8g9QKxinTT@vger.kernel.org, AJvYcCVPew7xyXQKJ/9qfZXAzIGakwPT8LU+bqYMQ4LuLJYiykkN/HlzHxjChWyiv0V9WVhlGCkAsIus@vger.kernel.org, AJvYcCVnONPRDO6Ik9OM/FQ+HEsDVR0WAM+tJRULB2FL0U2k3zSDose1tKGz7SGkeeVyWKU97rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGtjBhSDDXJIG1doV0zcMCwORowjgg1S6YxxAoP1/JEos+cBa
	EcNLl3VbtgXJ0Y+A2jTrATO6m/skMgZ3yEj2RE8TYbOTv4BicNYP
X-Google-Smtp-Source: AGHT+IGy2D36iKuftjttk2FrDhorl/s8RhZNMmtf9iFoBikAeEISY5rprKA3oT8OVgjbSFXH8aKkDw==
X-Received: by 2002:a17:903:32c1:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20bfdfd4340mr147887695ad.18.1728287250665;
        Mon, 07 Oct 2024 00:47:30 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:30 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/7] net: ip: make fib_validate_source() return drop reason
Date: Mon,  7 Oct 2024 15:46:56 +0800
Message-Id: <20241007074702.249543-2-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source/__fib_validate_source return
-reason instead of errno on error. As the return value of them can be
-errno, 0, and 1, we can't make it return enum skb_drop_reason directly.

In the origin logic, if __fib_validate_source() return -EXDEV,
LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
effect only after the patch "net: ip: make ip_route_input_noref() return
drop reasons", as we can't pass the drop reasons from
fib_validate_source() to ip_rcv_finish_core() in this patch.

We set the errno to -EINVAL when fib_validate_source() is called and the
validation fails, as the errno can be checked in the caller and now its
value is -reason, which can lead misunderstand.

Following new drop reasons are added in this patch:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h | 10 ++++++++++
 net/ipv4/fib_frontend.c       | 19 +++++++++++++------
 net/ipv4/ip_input.c           |  4 +---
 net/ipv4/route.c              | 15 +++++++++++----
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..76504e25d581 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,8 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -365,6 +367,14 @@ enum skb_drop_reason {
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
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 793e6781399a..779c90de3a54 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -346,6 +346,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -377,9 +378,15 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 	if (fib_lookup(net, &fl4, &res, 0))
 		goto last_resort;
-	if (res.type != RTN_UNICAST &&
-	    (res.type != RTN_LOCAL || !IN_DEV_ACCEPT_LOCAL(idev)))
-		goto e_inval;
+	if (res.type != RTN_UNICAST) {
+		if (res.type != RTN_LOCAL) {
+			reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
+			goto e_inval;
+		} else if (!IN_DEV_ACCEPT_LOCAL(idev)) {
+			reason = SKB_DROP_REASON_IP_LOCAL_SOURCE;
+			goto e_inval;
+		}
+	}
 	fib_combine_itag(itag, &res);
 
 	dev_match = fib_info_nh_uses_dev(res.fi, dev);
@@ -412,9 +419,9 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 /* Ignore rp_filter for packets protected by IPsec. */
@@ -440,7 +447,7 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 		 * and the same host but different containers are not.
 		 */
 		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
+			return -SKB_DROP_REASON_IP_LOCAL_SOURCE;
 
 ok:
 		*itag = 0;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index c0a2490eb7c1..a6f5bfc274ee 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -425,10 +425,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 
 drop_error:
-	if (err == -EXDEV) {
-		drop_reason = SKB_DROP_REASON_IP_RPFILTER;
+	if (drop_reason == SKB_DROP_REASON_IP_RPFILTER)
 		__NET_INC_STATS(net, LINUX_MIB_IPRPFILTER);
-	}
 	goto drop;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6e1cd0065b87..e49b4ce1804a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1690,7 +1690,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, itag);
 		if (err < 0)
-			return err;
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1788,6 +1788,7 @@ static int __mkroute_input(struct sk_buff *skb,
 	err = fib_validate_source(skb, saddr, daddr, tos, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
+		err = -EINVAL;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -2162,8 +2163,10 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	tos &= INET_DSCP_MASK;
 	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
-	if (err < 0)
+	if (err < 0) {
+		err = -EINVAL;
 		goto martian_source;
+	}
 
 skip_validate_source:
 	skb_dst_copy(skb, hint);
@@ -2302,8 +2305,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = fib_validate_source(skb, saddr, daddr,
 					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			err = -EINVAL;
 			goto martian_source;
+		}
 		goto local_input;
 	}
 
@@ -2327,8 +2332,10 @@ out:	return err;
 		err = fib_validate_source(skb, saddr, 0,
 					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			err = -EINVAL;
 			goto martian_source;
+		}
 	}
 	flags |= RTCF_BROADCAST;
 	res->type = RTN_BROADCAST;
-- 
2.39.5


