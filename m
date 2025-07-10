Return-Path: <bpf+bounces-62909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE35AFFF42
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3107BC85A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538482DA74C;
	Thu, 10 Jul 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQSqQ2Fq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F12D8772
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143202; cv=none; b=mPtiRojrnUlnQqolnlHi2l9JqKIUiIabrAp51WAqBxdGCWdJQOH/zzA8OFUMI4cgWQRxDwbgjNxEqXOf3XdZK+vU4wMr7/dua7caDCNkzq79OduSxrO31KV9ysGSYHmhgKyR2qj9DqLwgHP9TkLOGyAiXCmV+TrlwiECqCEqCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143202; c=relaxed/simple;
	bh=NFOgSnhWffWrZX8FrBFj28AxcRs4yHqlVKQ/Dmxu3T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDeNlmleEmSoPI7X07EOk+kWnCPx4DdclwV5ZpKsmy7DSW3/eXmAXU7Fg65f6QWjw13hE5WpSoK0Q4sacd5K1dnMVI7UPwbR2EzwPObpy3KQzJGxqx/32hs3ny7qHHynOFx3UJeFs4HK8DErkjDIsVwlM8Sy4JhAtjDPa/fny9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQSqQ2Fq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453647147c6so7270265e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143199; x=1752747999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=kQSqQ2FqQ5dgRI5+LPo+lcyd7Ll0FdkG8JOTg5wUrg7asXrAKtK5qBd4Jp92lwgaLK
         6HVbht/q8ZWNa8jmwSGxo1qJEupGP22nKstF8idzh7VzX36bzpnza003ZnSuV3HvG4B9
         AyRy8ETQquFyJ1rMVj+JAiUS1RddDRTBu8aFE9xPNFRbdkIulsgA65+rAqa7wyhkVukL
         yGI7cGpeeA04qdUpjfffsbyCFFmKHLtoZGrQNzo7bkdFVZPNrg7e+KpDAyyGhcyvICzB
         0irNuzs8a0XPztQLyBVbdVSTmu6ULwK1w1G27wchW4Tr2lw0hUMYQtlZrNa838M2Dn70
         TK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143199; x=1752747999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=Te5Yg8dtuau3Thu2NPv7n9E3LSy5GU3QtoiyI2D9czuJNwSoTxDVHSsPOwozX103X9
         Ofe+b12WVj7nu0Z0c8IYJHC4uIUsSKROAglwnqHxcsq/OzVIO5zW4c4YZ1B5arOT0EtF
         ZoLeCtCr/n7vz9c01e+TxO/cwJhFSXtG13KyssLg5uszsy1ZXHx2JuzlJs4UBVTsBtba
         ZomoK0BH76Fo+FSZl5p6IbBvbapF1U0olbQ04TeyKJqZ4oqW1IeZyt7kYj1NSpRoOoAx
         B8WdC1gSEG7qAyF4xRluKskc8nFMpYN+vzmSPjOAqrNM/YweiDQMLIOYP6egR5qWpKTQ
         E19w==
X-Gm-Message-State: AOJu0Yz95UBEp/BChDO3xC9pBH0IULXRzIMGm/IPDP8+1vUCmUD5IDlc
	HeQd4rO3E0hxhHsTUptH2yFcAg52U9pL5/TLyHo+xANuX4QhYUGMULOFG2RXx8w4SHI=
X-Gm-Gg: ASbGncsoqWh2W/7+uXAHI25Uakkr0ktOmkfi2T8ebI7uYqaNPETTNlseFfUzEmJa2KN
	/6XImJ07nOliL8KNHcrpUYNp5QoPagPpmag5Fm02MSy6ZrpWyyoQGqgXkUEvCkqbMLHvBMtMqRy
	NyOlSQcjUbz/8IGVrtGzXiPT5IKHJT35coiRoxQJ0Dorgfh639it6wB8TEWC3CEo609g3o/KPKT
	bOchHP5YHH8KNl8Sh4OFfU8z31NYa2zy5iSZWa4oA1lUgM3necF1GWN0JhmyLnZZ5pN8q3++1J0
	bZPJFAHkHs5xr5BhubZ1rj9rGMCSJeGcGyygbezB8xPudxrTtsR0vioqhWPtyXfuBNoXTIgZwkJ
	/2KN35GQupmtQ
X-Google-Smtp-Source: AGHT+IGXDFEyB058g+pdResCFhWidcljPsOaEryY/xxD4CWPUVnLK9s2Q594VZB5M6pGIaz9XYDOTg==
X-Received: by 2002:a05:600c:3e0a:b0:453:2433:1c5b with SMTP id 5b1f17b1804b1-454dc757cfamr23725535e9.5.1752143198689;
        Thu, 10 Jul 2025 03:26:38 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm52639745e9.36.2025.07.10.03.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:26:38 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v1 1/4] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Thu, 10 Jul 2025 10:26:04 +0000
Message-Id: <20250710102607.12413-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710102607.12413-1-mahe.tardy@gmail.com>
References: <20250710102607.12413-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fetch_dst in
ipv4/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/route.h                 |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
 net/ipv4/route.c                    | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 8e39aa822cf9..1f032f768d52 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
+int ip_route_reply_fetch_dst(struct sk_buff *skb);

 static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 87fd945a0d27..76beb78f556a 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -220,21 +220,6 @@ void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
 }
 EXPORT_SYMBOL_GPL(nf_reject_ip_tcphdr_put);

-static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
-	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 /* Send RST reply */
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
@@ -248,7 +233,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		return;

 	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(oldskb) < 0)
+	    ip_route_reply_fetch_dst(oldskb) < 0)
 		return;

 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -322,7 +307,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 		return;

 	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(skb_in) < 0)
+	    ip_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3a79..59b8fc3c01c0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2934,6 +2934,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);

+int ip_route_reply_fetch_dst(struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl4 = {
+		.daddr = ip_hdr(skb)->saddr
+	};
+
+	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+	skb_dst_set(skb, &rt->dst);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);
+
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, dscp_t dscp,
--
2.34.1


