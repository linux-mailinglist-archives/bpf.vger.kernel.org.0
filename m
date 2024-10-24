Return-Path: <bpf+bounces-43035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB799AE103
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3131F232B5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA91D3184;
	Thu, 24 Oct 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISwmANcV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912B1B85DF;
	Thu, 24 Oct 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762517; cv=none; b=RZ2sw5xkfOqoidgUcMYTHYfL2s6Yr8cPWscoS/CkB58/H1vYwl1uyeOFptpxtG5LhcfhNz3gx4FBc3lyQMq7mMxJjEhjBgMD2s9MHA4+Z9DLdV5OF7VbnjrdiCYp1iI56mCcawtCeFSGUePJsrT7r6jfLZkML8lgQI1ibxJ9ZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762517; c=relaxed/simple;
	bh=cJ0OGLfON7rfzJI4gOqeXOhVCn6upuw2yPV7fi7n4MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7GRxLwlIHWYL1XchQFif/xc2bpoaHC7rqjJ32LtKkm8m0IXCobT1c1Ai/YGzahnrce7gZ/EIXwkve+aIakt5TRZWOreyYvlc1cAPh8aNtJe8AGx2LhDdFCR21es7DPrOP/qD96INJBPIieqxpO3ON/xkjuNHW4yNV12/Ga0ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISwmANcV; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so384834a12.3;
        Thu, 24 Oct 2024 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762515; x=1730367315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GMKPzguG4mlKFwZhzBDmmWl0vg75LYwmRRCcfaNtRw=;
        b=ISwmANcVNLlEqm7qjsVBatnEuW7HdSQOFdDzhX5fD2FOg7Ryfle4LfJ/9fV7qwgBfn
         7vP8wK6GijjsjW+ta9XFf1UKD1oYgx+kIY1CyLIwkIUqv5orqtJZmwcmTSyZMiqZnJ/u
         eNPTK+ChF5gzcT6pf1Px58S5FBT4C9V2d77x/OGdr1j15yQ9k3lqP1T8FEq6aMZ5bdjl
         CivOqMYI+9TjxQo6QJ4P0QVTN8YP9Oy26Ef1h58FwDfwmDgeYsey8AKKCKYl+/xx8h77
         HoR6cdF3VILBWWc2wFn9icZHtdWkumbyRtBAFLmu7uhKVDszLMTbVh1Fzi0GnJjl7tJT
         +pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762515; x=1730367315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GMKPzguG4mlKFwZhzBDmmWl0vg75LYwmRRCcfaNtRw=;
        b=xGE1tYXVbZG1KMuEoeyREzuZUHJF240YgjavJ/1U+EqSQC4+/bk+q8IXXzOgONa9Jf
         mFXKOY1uAP11OjXArbCzrRF6+Ywx7Ion/z/WEhRm0w8fUrKlRClw8Funu31sSQRtxmTe
         sqWut9Co1o5l7v9CHKzvzruVKnpYq8pWiXCOhg8pMSHZSk3VzHOw9ZYBS7hYHGjSBd4j
         1Z7QzeHwm4Zv6/PwjKGTmbYpFEltDErkNui1ivCxTEd9zC/ueb4pwImWexxcMdQYAJOV
         cWUcL7+R7hwgqYigmuTMFT2qna10Yr+X47dlQigUqRevy97Cd/k9rYwqB1gxzyh/HKvX
         HpJA==
X-Forwarded-Encrypted: i=1; AJvYcCUiMGu/JCa2eJCSFdy1TXy2Jo1Awao5HMlDOe+drpU4ekXnUmV+Zi2AOk/jIKgHQKGaxTwj5jpq@vger.kernel.org, AJvYcCUkuk4QHpz7zMVZ3XJsP47EYUEOJmZZmiN8tStqBuy6LCwWjYtK1SS7PEWXh8+E+J9QV6ztSORWlAZgsdq5dwRg@vger.kernel.org, AJvYcCW9VQ1wZ8Qr0B7k1m2sk6sLr48bZtNzjsDs1SZ7t2Ka/T75Kg7ytpgC/Lc3RceJw364/icawRGVVI4s6al2@vger.kernel.org, AJvYcCWBN6PRC6ulbougmA2s1L7v7Sc7Q3YbSPJqX1+FHYoOzk5stXSA72uv60y9cO8xk4XYxHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rjW+ECvHDW36O8Fzs3dafGQH1M6+lendAyxskm7ttF/dyK0S
	w5pBS+la6QjGII24telszwKyWGPwIch4XtZbgnVp32wKA6aPH2eK
X-Google-Smtp-Source: AGHT+IH9dDA5gU7g4QgEHskFkl8XfuOQh79z1eQgclz1Dh1YoNkH/2OIUkhoMgBdVlcei/4GI6Xn+w==
X-Received: by 2002:a05:6300:4043:b0:1d9:29c8:2d32 with SMTP id adf61e73a8af0-1d9898ff732mr1534360637.5.1729762514698;
        Thu, 24 Oct 2024 02:35:14 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/9] net: ip: make ip_route_input_noref() return drop reasons
Date: Thu, 24 Oct 2024 17:33:45 +0800
Message-Id: <20241024093348.353245-7-dongml2@chinatelecom.cn>
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
index 4b0daf3510d7..757526e450fd 100644
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


