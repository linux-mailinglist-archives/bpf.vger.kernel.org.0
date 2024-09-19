Return-Path: <bpf+bounces-40090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BB97C751
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF1B289AEB
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB219DFB5;
	Thu, 19 Sep 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgwibEVw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190019CC18;
	Thu, 19 Sep 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739001; cv=none; b=W/6yhIrBNt8g7LIwvxU+gwI6gPBfips0XcyG8xTCCJTw9HE0LS+MwlsY/bjyGQ1jBq7yeR8t5TNqwojxdSym5GNZDahnqxm5pmDigc4QpYU2aM+EzMf8SsW7jt3Ul/BPIENmRjlpFikR6MyZuIcB8KbRJwsGabfMYec/UXtCDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739001; c=relaxed/simple;
	bh=d3HvNr5Uv6zRmT0BJX/m1cHJMfPBhhVo3oaWKjmncic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfFD2hi4lY5vwlIgj+2a65XI4QbAOrMzD+FWK09imV+2Dwgt88IwWnWcu0b+C+U8GsDxUaanNBGxHj51cT1Zx7Um7ahxXsg6doHVqASawu76kRD7xhrkLek7EATvHnwKg9Y0iub7PIRcTmbp8ZvxQeXBFiBdgTJ0sqBjXlHi8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgwibEVw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7197970e2aeso432812b3a.2;
        Thu, 19 Sep 2024 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738980; x=1727343780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA/2gib5aEwXowh4Zb3tw2IHR3ChieAV3weMhIRamWQ=;
        b=cgwibEVwepQm88BRazzMASkzvy2EQWGqBA6jl/3KKS9vP6Hs/vAJW0Of8sXgi5Za+R
         x2KM9EmGVPwNLC8zrKi6Od0Z5HvEKEgo8wEj6dsRB6jsSW3i3YZ6E6ZnvbEQlSrBG64e
         BLG470FZ5WfPXI+FDKKnOMJd+RlWO1cr6IJHya/XKxKpfonied5DznavwmPJcScyxH1d
         HhZruxaUvaVIT6qCX+Q4ahVBuQohfKLg9CoyqAHz8NR+ely1Okhx8z84DTFRpY5jm7lQ
         JQR/wdRNpffcMI6WIiKOGidRu6C3XGVnxfQ9I81a2KRs7os7kpg89Lz9SG/Grl4GA4ex
         RBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738980; x=1727343780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA/2gib5aEwXowh4Zb3tw2IHR3ChieAV3weMhIRamWQ=;
        b=IiW9LWkF247s0dJ2DY0lvwfURx9dZ39J8FzRcfl22Cxd6sWVZ2LwQo7WR1Eg+6NtI5
         I9Tx23O8OF4FFlllQ0qISYvzkwd9ubwAemYIcH4xzpER+unePOlP0iuA8TK3zCm5ZN99
         37+i37msLG391HzCObaOJorqf5vXmooy4EGbQ8qo3Mvl2bMtIuPcP8yx802e9xuMZh94
         i3hcqyECXvhdMpZM0MwssQIy6rOd+hVr1iYuUbVGdZBJBDMjjOt1fXeMHfMBOFF9JH9m
         ruxLzJSpeQ+BvN/dxGcZgeyf4GcRtcxNP+mqwSpwqacZQTQV635QwqwoJSPdCeZllSsV
         NzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf8aCceQUH/bGp+CaS5VxeInL/7akJ0dZyWolIxnFBWXsJZmPNTYig8CaVg67HOIuo94aM4u58J25Z1ZmX@vger.kernel.org, AJvYcCWPk3RIj/ZeOrMR6Lmc8TTjl1ndtt9abov/Ox4Jb66iSk8STXYhRP+5heqSB5msoksOL/g=@vger.kernel.org, AJvYcCXzld4NXS3Y9SPEDw7IX0L2SYYV5LmmPZETLpvrf82mI9QSt/7MlZce8Q0TVNoKiRIwe1bAkFyM@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAqoFQnweOUpHfx+jMuCoGI6oR8HE/ZS32x91KsMaoVnYj8he
	uHMrQUhIcUQLPriERv/6vaFweuOvEjrN4U/X9fAJmnV+kKzUCJpN
X-Google-Smtp-Source: AGHT+IGX/eoHZJwZe5ddJiHbodmkBrNjnA93JGb5CYL7b4kt50T3ftjZqawUOQ9E1aXOrU1vDkR4IQ==
X-Received: by 2002:a05:6a00:8c7:b0:717:8eb7:6c57 with SMTP id d2e1a72fcca58-71936afb999mr30401247b3a.19.1726738979968;
        Thu, 19 Sep 2024 02:42:59 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:59 -0700 (PDT)
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
Subject: [RFC PATCH net-next 4/7] net: ip: make fib_validate_source() return drop reason
Date: Thu, 19 Sep 2024 17:41:44 +0800
Message-Id: <20240919094147.328737-5-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source/__fib_validate_source return
-reason instead of errno on error. As the return value of them can be
-errno, 0, and 1, we can't make it return enum skb_drop_reason directly.

In the origin logic, if __fib_validate_source() return -EXDEV,
LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER".

We set the errno to -EINVAL when fib_validate_source() is called and the
validation fails, as the errno can be checked in the caller and now its
value is -reason, which can lead misunderstand.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/fib_frontend.c | 19 +++++++++++++------
 net/ipv4/ip_input.c     |  4 +---
 net/ipv4/route.c        | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 12 deletions(-)

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
index dc062ae49137..aac0575bb1a4 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -424,10 +424,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
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
index ab70917c62e5..89b498bd9752 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
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
@@ -2313,8 +2316,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (res->type == RTN_LOCAL) {
 		err = fib_validate_source(skb, saddr, daddr, tos,
 					  0, dev, in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			__reason = -err;
+			err = -EINVAL;
 			goto martian_source;
+		}
 		goto local_input;
 	}
 
@@ -2339,8 +2345,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (!ipv4_is_zeronet(saddr)) {
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			err = -EINVAL;
+			__reason = -err;
 			goto martian_source;
+		}
 	}
 	flags |= RTCF_BROADCAST;
 	res->type = RTN_BROADCAST;
-- 
2.39.5


