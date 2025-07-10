Return-Path: <bpf+bounces-62908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE1AFFF37
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6A65A5101
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CB2D8778;
	Thu, 10 Jul 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWkVuZjJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6B1F956
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143202; cv=none; b=BJcjCfUxXEaamhd2sr4et67WT92FPyWMpuEDxCCdpEt1CZ7BKwcywYbbPnz5vNH8zcIgvhO5j8Bl5quA8MLer61148fweqiloaU774S+MkowtRRH3Ff7dX6q1GGPTMuoENxURWz6o8nCxB7F9vbFGS0jV6smvvAr6a1E4trbil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143202; c=relaxed/simple;
	bh=s6imH3eRm8BCbXAnCKf65Sw5Cr3u34AezTQapx16DaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXSOVQpA2wY5ULUAhyUMaMxvxHivb3WKwk8tBjJRdb9dKRuwc3s8jiS66MRr4nSEvlNHIBzOizG/zXNSh/fcdWuY+IuxovE/VkERPyIYbTIJYrcHJiVu+H7ChQA1GkvzaDSFYuML+gC3VdrNxzj1voPPovf7oMy3tMt5lZ6eSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWkVuZjJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so569548f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143199; x=1752747999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09OQ0GamPclvQk8VnJfNUS7u9GWcLk9CW8PoDzaOMlM=;
        b=RWkVuZjJbcpOM2ZqFsQsypN7/rrwYia4wx8L/+pluSj/xfrXvqpIu/UK+0ed1vj3KJ
         WGt3pPAKVVAp/zFAlpMR/I5Drzp2JPDsKC2D59oUXKCBk9US0QhN9uIzicCxxWoMlHso
         e49A7bj+4cTg6DRrQixxV4PF99og0pGnIpLoz5uQyKCaLY9TrZIr3Ju0ZYiAEC2KYVML
         jGx9lQv2DduuzexazCUMx54ycwOWV93TLQ1NmJyh3KiuWqqqwvSwStbKS5XDRj0DIdxd
         lCNeTr2PrWL+wwxlex2Z3ZQ2Vgy1SNgou0Lz6n1IpWvOEmXanUccsJAyPzPtZG5RTdtV
         tJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143199; x=1752747999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09OQ0GamPclvQk8VnJfNUS7u9GWcLk9CW8PoDzaOMlM=;
        b=ugjWa7njTiEiGTQpEPVLkgBhMhnKIiTTL/C84M3S9PVeTyX9P28pz2MSN01UCWLiyK
         LF7wwY8uObLZ403+9W1w/K41GmEf8swa727I/iAnmS3EcXpKXOjA5yPkuOle5n/CdYpU
         TZqp4sn7ORpcpl5ZQX8TilrXRBnLXydjIqravMyh81NJh0NKvZSiHR4nmXQISVyAP3Ym
         fIFoSSAZncHtEsp8njqVKcoJ3ZcBEVsyrBwv4gaYPlOgwi1sp/FRuSndzTkAeBiGjfzs
         h9vHdCIkOedrfNtQPLLHHwHeUFXw7UhRy0BTx8Iz0o1tQ9wDSOQT8LynOVurwyvl4XqP
         1PBA==
X-Gm-Message-State: AOJu0Yzf7vm04PrkFpi7AIToL4BLvkup0rBIZBffgmwVUdLZx71665pK
	TCUw5QfRizEeZqpPCRh73zCkP1ggMVUW6MQroRfF89gpgyCAnDZU5Up6+nMQCjPC74w=
X-Gm-Gg: ASbGncvtUPA/UWb2/H1CPfiHRMP/NXbKFTcJ9cWjSLMPPN17ZSXcaK8NghJUbA8cYDy
	SSTdVwt9OJ7aEZF/kO2FRKLrU6yIMr5OqSufBrru8kqPF4kXYX1XMD/btSCDkGFBCkp+t4N4v/L
	gd3IdcFm7eSX6K+chkh1FBa8mgS1RKrhOgzVk6QOnhCz6lpWt5eB6tbLi9oFTMhm48OR8L7TBVc
	/Zjz6jQI+lzZSr4NIh9vT8N1KJQF5jTti1Id3eF4BYnnvxveaxtQIrbDT9xmSTDfHN+oKAaVyWu
	ABYsAzsIlIucztNYf/vxV7/0/oK+GCxBuYT38l/+luQZoSMCLTBcUzbq/fxVendbzX+iS9Q8NrA
	q4VjjoO92vkZTG3WkB3i6+g4=
X-Google-Smtp-Source: AGHT+IFDAEI0IM/7BO45vqCVTPzSwJf8E7QWFwBVrPVxyfgTYWe0r9WG4K/ucysv+mFhIV8NGa2w/Q==
X-Received: by 2002:a5d:59c6:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b5e44e174dmr4228915f8f.12.1752143199241;
        Thu, 10 Jul 2025 03:26:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/4] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Thu, 10 Jul 2025 10:26:05 +0000
Message-Id: <20250710102607.12413-3-mahe.tardy@gmail.com>
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
index 9ae2b2725bf9..2553b0d43a0e 100644
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
+	    ip6_reply_fill_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0143262094b0..f1120f6fe0a2 100644
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


