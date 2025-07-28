Return-Path: <bpf+bounces-64492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692CBB1380F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6566F1686A8
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686C25B1C5;
	Mon, 28 Jul 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw9Oo3aE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26188255F25;
	Mon, 28 Jul 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695846; cv=none; b=SQnwpvEy53/2w0l127mCaBZ+swuWd3ZQXG/vl+YO+bIfP71eE3XmFYx/khHT4/U6gZbgH1iAd7VBeFX/aC01EwUc4eqMoGejfFbFaT9g4cgOvP/x5/cGC3fUki3Fr0f7OTh9IVYEmjpwe9trQveh7onQeW6R/XqyWuiSaIpR6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695846; c=relaxed/simple;
	bh=NFOgSnhWffWrZX8FrBFj28AxcRs4yHqlVKQ/Dmxu3T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUQjBrnvV0engjg11Uec5pNMxiIwTIEFiyuTxwsxLbuLeJ1fALG1TaGoZV4Mt8sNHNe8QWs88JfhjlzijGLDqrh5OmQgMpkDv9HZeaYO79V3zGviE9yVTvAuX2mYcwn/f1s5ZkBk3dIl02mwCI41TCMaPu3NGA2fsClwML1ycFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw9Oo3aE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso44079925e9.3;
        Mon, 28 Jul 2025 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695842; x=1754300642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=Pw9Oo3aEM2UshMkzob5uX02cU40BbdEMT4/JiwXKHyOri4nYyrrAFrBUedbxeAteFJ
         e/k9ytdlNyjHkrmj7PHdk3VoEpW6N+X0TTIJkog5mmQ73FTKezv9s+MwuGltSU2I3T6c
         t3LkRM8TIq/1mueTn+WrTVAS+zJT7AoKLrzMyNuW3JKhxeFjjm9//Le8M0v5t3vv835S
         Hu8Hu3w2LGbHtgXBD7O1oNmHL7xM5yAAWdt7Nz0A36pUEAUniH0bYlResZJtImXgQz3B
         VIXtcT9kN2yBj4+t81VXEigKCMWNrB2qLv6Q25yMMaztXqV+1jzLcxQjXQkmLs8NdQns
         a7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695842; x=1754300642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=dg5afP5+QOCK0fmwmpGMjFyLr2yHOLV0Dfjso+HIDLcw5R2XXSGH5lgg3b+dTaPsiW
         mrsf6Rljm4sk+MOT2zSDZAHfCuFeklVdJ85GG4GneWutUFfjDUx8i8Da1y+8x/rg3QQ7
         fs1wGWBDlFfMIhMGl/oxZJxjcrHhxSpDPCvEylfz6Dh8AkmpvZIhCGpmcexCFw5q7+Oh
         iaUlgFBWs+Jg1HTTMwu/06VC6P6HJz/5i7suqKwpwREdjKFfOiO7flmbpwgJ2vi2Z+qW
         GUOsIvTPQp5IC8e5aKxfZlUGZeYWmSIWuIeC4WRzvgpkpM2HkFp//QEgi8SXyX10eY0Z
         KH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpxJyv8aDfOrZSfXDcwMyHkcU2AZnJ0Ryt04x65KYKUk++rDaRiJEN3JTc8w65Srq/cQ4=@vger.kernel.org, AJvYcCVzWTMKAlyzOm2yOgIOicHz8yFtgUQaPycNDO+Qa5ZwuwYnixynvqpt1kPb6RCwCne3PxX7qK65SOQzChAUHZbx@vger.kernel.org, AJvYcCXPFhIrk9doqNjJe+aRHmLdFIAaFW8dKo+NAnAaAmi9DvAcNKLszsDAG7oniRVudZkCZCBK9Y83@vger.kernel.org
X-Gm-Message-State: AOJu0YwJP+4fBFe6jBlL6LtbTXGxhIFknP2Os6hOs50UszOFM8AAdbRZ
	whTq4A5XVX+9QpiGwaViy4YypZ1r/9DB1qjx4lfj12m2H5r4v3TyT0P7
X-Gm-Gg: ASbGncuGQwlf7tJUnO9YJtCa/ROcqPoh0S6s/TkojjEpOESaZy6d8ZmJY4SBVajVhRC
	hZfv1wQ9cDepjKkrQlkQdeSWw74DD3Frk4ZXPSxWPD8GC5ZpFHF7v84NmCZab9WUG+jAIkF9FEe
	WA3rk7r4iV659b8g1dTtxaQJiX6YwraOBhzNjtsPj5sbB+iQgi/aBzAs+kq4DMyQ6sHs6Sdi8hZ
	vrFN/SD3U8BTdjK5gf6WSYLurEb/PlgpfnfZU6h7zh+SZUx2jJVGz+4rqLm2/siHZZ4Uhb+koVf
	RqRMHUFu4/WnzArKGm2UdZ6XQIfCbuOmeRdOueYCMWV3H/4HyAMzETbRD/Y43uAE/wSDZ8xLH2w
	ejzPSnyMb4YKJ4DYnUMh7KeYSYs+26rRO6k4F0M4cLFSsSOmr
X-Google-Smtp-Source: AGHT+IG7zoWXd3OhLpG3IH76xQg5CAOEMoO/I41EqW5cLVt/mpUHo/XgN6ZnZgHSxF7JODuJNO8BfA==
X-Received: by 2002:a05:600c:a0c:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-4587655b790mr81378335e9.26.1753695841875;
        Mon, 28 Jul 2025 02:44:01 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bcbfbsm153422725e9.16.2025.07.28.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/4] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Mon, 28 Jul 2025 09:43:42 +0000
Message-Id: <20250728094345.46132-2-mahe.tardy@gmail.com>
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


