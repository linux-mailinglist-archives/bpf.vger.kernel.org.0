Return-Path: <bpf+bounces-43474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE139B5969
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC32283B6C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F11CB53B;
	Wed, 30 Oct 2024 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv+KSwKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111A1C9ECE;
	Wed, 30 Oct 2024 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252612; cv=none; b=WUY0DMx4Bjg3g4i6soXXBBf6VHeao/3qMUdiWT1nDVeSv6jZhPQbCqdzAeJKZ1Oe70Dzz5Hkgq2hMsT9cmgwEgJIR5qRYcPQa7MPnKhaMOYwzIzrrhrb7UamLPQjOmTNTgGXJWqn3YHNxORjWGZ3Im4kukkiRtIzdZ80p/ZLJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252612; c=relaxed/simple;
	bh=Scqf0jV7tVnl422Zyw+rn0UJrjxy9FoVtlwHN5lUbik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgRVvJWEq5Na0483a8R3QiAlvzOQtoAC77h9xhlXbqP2aOAAYQVNmwp/SVV98BzTcMbECkikJx9bFYlNh5TMC5atfmX7XZHLY9Wp/REB3qWmg08+pii9RosY8t1hVPjdzPjH1C6+a4EeTtnLZwVFPq8ZZ5GMBR+lp8ZFp31lTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv+KSwKf; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-288916b7fceso3287300fac.3;
        Tue, 29 Oct 2024 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252610; x=1730857410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fplqt3hHi98v9bYNP9CGpDhBaJTQ+L4T3dia3Fq4odk=;
        b=Fv+KSwKfCVT1IaDWNzcAOI0Zb8DZ1notfxPQnmNj38pJ0S5Dhjflk+/eN8l5s+uUoC
         /rq3razBN9um6uEz3RavQDJShnC+cEMZJguC7hLbsWyYZS1POmWRJE+JJK5qtzAtg9gt
         Nk3CgmNn8JUZ0VRYUR5vTOC9eyNVamMPEu8IlSYbWBDqR0/E0c3xv1zvVi8gQHc8FIEc
         dzH645zHRXoJsNbC5LvlruBar+ivt+07Q0KoWK2TXZV5ghT+vgfkjxfTeR4Ypd8UNLih
         GVkRE9IFwNW0c21wKL8BtpD0BZq0SkJJOGg5B6e9Hs/AkDTLTSWA9Pb8B3Xpyfx8j0rc
         kNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252610; x=1730857410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fplqt3hHi98v9bYNP9CGpDhBaJTQ+L4T3dia3Fq4odk=;
        b=YSw3mXtksCzgOOe3LSiyln3vh5pff1cEoHAzh+/g67eJvVQj8Ev//VhppKcYbTgyrW
         d9Lu5237EE7wuUe+ygVni0ouNGZ1RZWSeWMjUnySQpdzoiDBThXnVTj9MWJTk3iJYKQ2
         144lp7OlDoMcdBCXiNpny0czLTG1vBbqIelsE12XCH1VEJ/WJLGAUywLRPE1B4g/YQWo
         wvAMk4DKeAaQjTKQndCjb6PD2UnPDp0/N4SUEgq2Axt1tF9/vZvxx0iiJUbftH9xw1wB
         eXP9x5EgIthwut3+RcXVeK3OUfVpM7KnUgTX50PJpNhhvZ/j4iHBZwjmRlXkF2ZV9VKJ
         qv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc1hH1MbXtxa1vaxPCBtT++8SO2H7c0WOqpLb74taznhoHPO4P2M8JpKLT5h1W0fSXrf8FIU/hRonpVavK@vger.kernel.org, AJvYcCWsg5+6oon7soDxOamO3Zk7IXWBYQzbBFTe/wVlXTzfkIDVmggegUW7WD2VUC7lZAufcpPYVE6L@vger.kernel.org, AJvYcCX0j+zQV0+dMVN2BpgcWu4NSVZOsqi9BPJHx74c1YCJgoXt74ckgi8ULS1X16oZeOrBrTA=@vger.kernel.org, AJvYcCXy1xdYuZ1YH+f+nhUATIOzvQvUZuvF4EZThORpsK2v6vnUJ/lYOJb49vyh5I9k9d6jPU5/lPmCOmsg9bgUrjO6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/0vOj0DTD6/w+JoE0ZFqDa4z0Tv+Nkg3+/GNElwwzUvOJSav
	MN9rMU5k2CWSvz4Ww6ssGqzM5xn2BeWuRiAdq0NCllEGUFjNqH/J
X-Google-Smtp-Source: AGHT+IGsZoEVW0JcVbBUSmiB8lr4N5b/WoG/+LUc4OuJ/6mStCSPFyUGuDfoAu61vAO/Z5Zy76b54Q==
X-Received: by 2002:a05:6870:15d5:b0:278:978:9e9 with SMTP id 586e51a60fabf-29051e0360bmr13656946fac.44.1730252609677;
        Tue, 29 Oct 2024 18:43:29 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:29 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH RESEND net-next v4 6/9] net: ip: make ip_route_input_noref() return drop reasons
Date: Wed, 30 Oct 2024 09:41:42 +0800
Message-Id: <20241030014145.1409628-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_noref() return drop reasons, which
come from ip_route_input_rcu().

We need adjust the callers of ip_route_input_noref() to make sure the
return value of ip_route_input_noref() is used properly.

The errno that ip_route_input_noref() returns comes from ip_route_input
and bpf_lwt_input_reroute in the origin logic, and we make them return
-EINVAL on error instead. In the following patch, we will make
ip_route_input() returns drop reasons too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- introduce the variable "reason" in bpf_lwt_input_reroute() to make
  things clear
---
 include/net/route.h    | 15 ++++++++-------
 net/core/lwt_bpf.c     |  6 ++++--
 net/ipv4/ip_fragment.c | 12 +++++++-----
 net/ipv4/ip_input.c    |  7 ++++---
 net/ipv4/route.c       |  7 ++++---
 5 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index a828a17a6313..11674f7c6be6 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -203,8 +203,9 @@ enum skb_drop_reason
 ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      struct in_device *in_dev, u32 *itag);
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev);
+enum skb_drop_reason
+ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		     dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
@@ -212,18 +213,18 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 				 dscp_t dscp, struct net_device *devin)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, dscp, devin);
-	if (!err) {
+	reason = ip_route_input_noref(skb, dst, src, dscp, devin);
+	if (!reason) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
-			err = -EINVAL;
+			reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index e0ca24a58810..8a78bff53b2c 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -88,6 +88,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 
 static int bpf_lwt_input_reroute(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 
 	if (skb->protocol == htons(ETH_P_IP)) {
@@ -96,8 +97,9 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 
 		dev_hold(dev);
 		skb_dst_drop(skb);
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
+		reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+					      ip4h_dscp(iph), dev);
+		err = reason ? -EINVAL : 0;
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 48e2810f1f27..52b991e976ba 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -132,12 +132,12 @@ static bool frag_expire_skip_icmp(u32 user)
  */
 static void ip_expire(struct timer_list *t)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	const struct iphdr *iph;
 	struct sk_buff *head = NULL;
 	struct net *net;
 	struct ipq *qp;
-	int err;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
 
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
-	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
-				   head->dev);
-	if (err)
+	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
+				      ip4h_dscp(iph), head->dev);
+	if (reason)
 		goto out;
+	else
+		reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 
 	/* Only an end host needs to send an ICMP
 	 * "Fragment Reassembly Timeout" message, per RFC792.
@@ -195,7 +197,7 @@ static void ip_expire(struct timer_list *t)
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	kfree_skb_reason(head, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+	kfree_skb_reason(head, reason);
 	ipq_put(qp);
 }
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index c40a26972884..513eb0c6435a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -362,10 +362,11 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	 *	how the packet travels inside Linux networking.
 	 */
 	if (!skb_valid_dst(skb)) {
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
-		if (unlikely(err))
+		drop_reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+						   ip4h_dscp(iph), dev);
+		if (unlikely(drop_reason))
 			goto drop_error;
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1926a8a1a83a..ce1201dbf464 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2487,8 +2487,9 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev)
+enum skb_drop_reason ip_route_input_noref(struct sk_buff *skb, __be32 daddr,
+					  __be32 saddr, dscp_t dscp,
+					  struct net_device *dev)
 {
 	enum skb_drop_reason reason;
 	struct fib_result res;
@@ -2497,7 +2498,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
-- 
2.39.5


