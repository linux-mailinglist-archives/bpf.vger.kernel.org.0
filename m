Return-Path: <bpf+bounces-64493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DAB13816
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462FA169C36
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C2254AEC;
	Mon, 28 Jul 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtfPL491"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15377263F5B;
	Mon, 28 Jul 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695847; cv=none; b=cCNw4k+rQCN7SGG4hCGyOgS1JPK+rr+07CvXo8JUsacss1NpyeMjGzh7KtHavUDQNH48BlgzC+Ou5ptkbdSwmlSz6RLpUX/ztSMy+6zkwEWwryjr4y4mtb9woZfv0KL23r3bTR0Am7/uVH0nCwNLTurDOgJudwga5UJk/wngSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695847; c=relaxed/simple;
	bh=qVSRdBW5BWeBb2K0uA4KJ7uaKd1bWg9Klyw/AQcWoNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWgQafzExmLR2l9INO6wCGjEF/O/D4FHHOZEmL32RHmafQee89y4HPBDhW1y2XkCjRh/mxW//E6cIPWegWEHSIdWUJxGYKhg/Ia3lNBl0dpRtSL+2x0aH3XQ8jjVxPQV/zrYlULixyeRtU4pKIeJPgeEBsHtNMyf3hPLmMqb2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtfPL491; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so27194005e9.0;
        Mon, 28 Jul 2025 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695843; x=1754300643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1dsLivZusM5yDXPBZGoVZ6iRqMndovj0MlJwHvinT8=;
        b=dtfPL491AGs/qzZ+fUk0VbDPkZqvrDfA9sE1ye3KOX4yOJUM/HK3rKKjesAVNOuxQb
         iVzIZzdqunsSjhfV/Ds3QOj0J05IqoGLMMGKdOjD2D4GnMc4Xa9ft8AsDIjNnbvvNqSt
         lyv8nevQXT5VGZehvmPXCWtLG5oHhUoUmcyk0DfVD7OuuHahydIvw/C8kMCC/lka+e0p
         3M9wGW0sVJR3ZASi2IJACrRugoUehz+ZroOYJ2mNOZMLcne1mSnEk7bebixWJ2iBed7+
         3zbFCznJIxMZEhi19R1dHOeOHiajPZKbTImUFIkrfV/tiCJSvqFvWGu1DF7naTWrG38C
         Rt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695843; x=1754300643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1dsLivZusM5yDXPBZGoVZ6iRqMndovj0MlJwHvinT8=;
        b=we6gM11kF5ucpBZzgXHKyxxqVrxfUyXunbpxTwJXvm70ek1SPhl06GgMRVuvQkPGWM
         IZMUiU2fgsSr0KhQjPSncgFqIr8gPUC+HrtQoU43KwNOn1FP0+6iyJimRU4bptr0k+NF
         Cn//jXGiPPt9f5FLz7sJI9e9ooHoiQq8WvIRzFJ1rHxxXu88as/DhX8tX2cHZ0DmlN70
         qXB6sASsP7nEJ5SaNxH5b4JUvPJolwW6lg+BhqRTfXgUkgqN5Hr/iD938mGVwzx0p3PA
         HN5WLUIQJeVEQKN5XYJ3Yggv1qPfrAQ1VkecrT5G0Qy6Rd1gEWJBMUf2a2IWZpO1E/yv
         Sviw==
X-Forwarded-Encrypted: i=1; AJvYcCUEkVAvcUMMH46Uhq1LFrnQyxT++EhTXsRcbNYYCb3PLi5FfY6uI1E4hcXbHawcYBu/Z/w=@vger.kernel.org, AJvYcCWxZo7uV6SYe5IUgPg6WtAokvjnpHVZB6iL86zzALdd8uAIHDM2BeyunixFhtq4D3hHBsSEl9Ok@vger.kernel.org, AJvYcCXTuE80ReB57wLybB7rL06mDZSkGgObwaG6Z0hzG3fJiiwcgRM/Dbt808LUfX7RePySisZLFsGG9mnQIGNi2SPp@vger.kernel.org
X-Gm-Message-State: AOJu0YwwS27nP46k/l24eN9JrujMay5P9e1q6Kkf2NZH2g05g9vtpHJJ
	I2mwrEdABXqzJE7RoLSEs0Z+D7pxMOxGhaN6JbXTks1unq0EsJtlwKwQ
X-Gm-Gg: ASbGncutjw2H6JsRecAtvjiJB2i78qHO8CstjLULYmQXJZ4Nt9OF2oSno88EXox57Bu
	YIPOhDno0rUgkckTSMEhvwxanbdcp1+mKT8haz12dmuxMZS/CR6TUmDHJ312x8RT/jmZIUmN3MF
	pelw4EYg0wOC6W7QzVlhcB05AodtpmC4PO45DfFOpT6OqfA9bET6Lg19wO7SQtWFSCvFgsbhKSe
	7iRejfB8z1bDN0X1gMBWLxsAtOSsqWtSF/cYkgCW/CFHde4tYeiR5VweNipSwECzijKw0zpFUD4
	WUR7ifNBcL8AjvYGgKvFfmOQnfLGQAs20gLcQYDtBRRoMra5i2OM7WSmhpLWUFZv2bKuU9wFKKK
	fv+Tesb0SsD6egSz96tz+OM2dZyqh9Ws0QmWCOG+Khr+ziBhWk9/pYGmOgro=
X-Google-Smtp-Source: AGHT+IGJciwZb68b0g2bprFe7Mmy3ICoCqA/L9fq9pjV/9mkZTTrJECq+h8er0WQOsyg7A4Plql44g==
X-Received: by 2002:a05:600c:4f87:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-4587644278emr105559855e9.17.1753695843189;
        Mon, 28 Jul 2025 02:44:03 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bcbfbsm153422725e9.16.2025.07.28.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:02 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: lkp@intel.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v3 2/4] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 28 Jul 2025 09:43:43 +0000
Message-Id: <20250728094345.46132-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728094345.46132-1-mahe.tardy@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fetch_dst in
ipv6/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip6_route that is almost a transparent wrapper around
ip6_route_outputy so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/ip6_route.h             |  2 ++
 net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
 net/ipv6/route.c                    | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 6dbdf60b342f..1426467df547 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -93,6 +93,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 	return ip6_route_output_flags(net, sk, fl6, 0);
 }

+int ip6_route_reply_fetch_dst(struct sk_buff *skb);
+
 /* Only conditionally release dst if flags indicates
  * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
  */
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 9ae2b2725bf9..994a3b88ac52 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -250,21 +250,6 @@ void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 }
 EXPORT_SYMBOL_GPL(nf_reject_ip6_tcphdr_put);

-static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip6.daddr = ipv6_hdr(skb_in)->saddr;
-	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
@@ -398,7 +383,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 		skb_in->dev = net->loopback_dev;

 	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_INGRESS) &&
-	    nf_reject6_fill_skb_dst(skb_in) < 0)
+	    ip6_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0d5464c64965..de61540f9524 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2705,6 +2705,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 }
 EXPORT_SYMBOL_GPL(ip6_route_output_flags);

+int ip6_route_reply_fetch_dst(struct sk_buff *skb)
+{
+	struct dst_entry *result;
+	struct flowi6 fl = {
+		.daddr = ipv6_hdr(skb)->saddr
+	};
+	int err;
+
+	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
+	err = result->error;
+	if (err)
+		dst_release(result);
+	else
+		skb_dst_set(skb, result);
+	return err;
+}
+EXPORT_SYMBOL_GPL(ip6_route_reply_fetch_dst);
+
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
 	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
--
2.34.1


