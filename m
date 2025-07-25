Return-Path: <bpf+bounces-64394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E0B1246B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C809B562EB4
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5E25B1EA;
	Fri, 25 Jul 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEUqaPi6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5F252286;
	Fri, 25 Jul 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469753; cv=none; b=YpvczIJz9tTk91+bMPr01hCiR63hP7waXOcMIwzdvegYOG6u3NKCh6Ndb/zzRRms1pD7Ys1hgRSxdOl9f1lrIJ2k5GbpCXDpc5tY3Q2EbF77uBN00j3Pcv1zQ2p+Zw39vNe3JmY1342Q5DCHwuWSr8/RtW1CPzLKa/mzmNN3+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469753; c=relaxed/simple;
	bh=qVSRdBW5BWeBb2K0uA4KJ7uaKd1bWg9Klyw/AQcWoNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcrjZC2wrvu1w1ZA/gMy1DXf8uvyaAton4hUV3HPwzw+PicTl3QztT2QEGs7eHGeVyq84IF0Gw12iXVHn9jY7zMKpisq1MgFg4gAd0084SPzZ9L8fCJE9oGqv3S6HKf7pnQALWGCsw5uBpdogYNVsmNvFjF6FimLhsBCuKK0DIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEUqaPi6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1493571f8f.1;
        Fri, 25 Jul 2025 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469750; x=1754074550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1dsLivZusM5yDXPBZGoVZ6iRqMndovj0MlJwHvinT8=;
        b=lEUqaPi66gwZNZBX5vBycenFc+XuHU/1P/6UiJq2onYpqouHBw7IKsAeccoR0WnMwJ
         SZg6AOdkimY7QOd2rV0lsXn7X24a3cKuhsnjZK7H0e83NecmqWVBx2l4TBXOURhTvAze
         hK1MZ3UOwYYtdHifEeT1Czh3asyl9jcOzoDEW5Gz6C8EACebvnSdFJ5VK5mMyVbXW5iw
         WMGr0X8ec3SUcVdS+QVkj9bArkMg+wuXaKYm57viMtWKCrEotSTYnNvYXNAJXrw3ptNj
         gud1Zf6+cpV5y8287DR+8qj3VAg311HlPMLxEVwsiQebxm+nRAvvcjoXpv5QA+2+C/Z1
         klsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469750; x=1754074550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1dsLivZusM5yDXPBZGoVZ6iRqMndovj0MlJwHvinT8=;
        b=Rl5jjhFs8HPmuRWB0QlYnmXbaeIlqNBKMke8nup5BJztDBnWnDFCFopMBv1QirZLyC
         fM69oj+sI38DipwfXW0o4gp79MPezdDiC1zMc8SD411tLhWA44rPrXFrk43mY0ql6SAq
         +V1ebPIlfJ6dnuMFMwbS5ZsIdJUAKcV2ycng2CBTcz17jMPu67iri7LmL0dOAWXV7tiF
         aiQVnNBo5KdmSzrquokyhJWlaiHjXIXOEwa1b/VnS1VU1IyY+Yy7rQWN3Y4ftSgjNw8T
         Hu6q0He22X1T/3BjBQKiiR+v+i8plMvvNdWv8P72sJ+lhlj1lKPYxHUGgOiWewPuLiN+
         78Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUNtexVdFb9Xb0vGhqxWGDhWVs++XmVdcWZ6G4wRXvoJtEF9tpNiuM7YSOuHU4D9Or+ajY=@vger.kernel.org, AJvYcCWROEhIl6WzJvJE75GXdJ/07Y0KAWRzapz7hd+n5h4P0kCCuA81m+e5Fyoas6lWP+zRS3Rhwfnx@vger.kernel.org, AJvYcCWpBDi0wUB/xje/fpaYpsPC1D/I1hJQq879U5CIe8/Lb/hQXBCFJunJmcxrlRfI7CNcDF24dBAVSUX9miC+ysYS@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcWppyFexaIZFSY+o2hxUpLryXRB6GhMXvZeSSj6cGeU/F7HK
	LH/rBSVP+sEFOUUA78v1hxbii3cbk8uB07iYkE5zNtoG0vqsJLMtqgEw
X-Gm-Gg: ASbGncs6w//CKzmy/7i2rmSdvMo+6H5IwFY42/A/KuJ7NGvR3ehMMER59nosCzTgxvA
	wd4NjXHjRBHMcAsuy1we02YKCjBmIqtkS3hYAxgUfZ5barrkWf3K7vICbU6Jx0Sy2Y/WK2x5CGr
	HgnrgCYwFYftHKCHG46va/IgsnLBqq1WxM00SEAbDAXwkH7go+P+Au7L1xFwv90LSU3MoBBtlhe
	bEutisUNDFTEteM6g0h8jB2lKwQsu2aoBw4UUjfUJi/0iZo9OH/bAmnVHzQA2O+5GhJfcxlYwVm
	7byXhqXNHGojlQBqNNeG04MdU4gBLWE6UmyjphX6MPzj5q0awzlkGa/vKZkPURm+vJj+SWr5H+o
	J1GVQ5abhtbbkIgp/YVOVwMVGQCWbu/peOv2Ax1hwqj5ShLZD
X-Google-Smtp-Source: AGHT+IFyeV+CEbJGTjj2jXITY2kjKlrud8vSmgpuYPCPd8cCzaIK/Lwpb/n9kvRdk/bpX6bw8ISmQQ==
X-Received: by 2002:a05:6000:200b:b0:3a3:6991:dcbb with SMTP id ffacd0b85a97d-3b7765e5abamr2398725f8f.12.1753469749489;
        Fri, 25 Jul 2025 11:55:49 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb276esm607743f8f.6.2025.07.25.11.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:55:49 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH bpf-next v2 2/4] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Fri, 25 Jul 2025 18:53:40 +0000
Message-Id: <20250725185342.262067-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725185342.262067-1-mahe.tardy@gmail.com>
References: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
 <20250725185342.262067-1-mahe.tardy@gmail.com>
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


