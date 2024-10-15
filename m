Return-Path: <bpf+bounces-42035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294E99EEEB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF956B21C5E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC21FAEFF;
	Tue, 15 Oct 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBPEZnqt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D11C4A21;
	Tue, 15 Oct 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001342; cv=none; b=QKZ7OA+tpS2SfKVjmLjS4yokW64LcSIbPnjOMeQoikE92+8keQLoHynUP0wQuIN6HNitKeuDO3K/cMP2yo3NsH0nXnU+SVTI56fmueqPWhktJdH+RtAqoX+VTOuF1pHQelji/S39ECgXyf5cHymZiEG4tlnSbisi6YOEh+EPIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001342; c=relaxed/simple;
	bh=OoQOAY2OIjU+qz6vqbbMH8cX0fA2TJvTDpTKEyg2OEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmMgUrK2hxSaN2IfrPkoA+XvBlGmM8oAe1/hw+cq32ksUu+ijBkEnxiEEWcI6OjS0vY+PKoZ5Wh3t9WcEEZIbp3XjgIIc7nSmbNp+VqDp0tkvmy1BLJxFdhRs8ogeL5N5ab7wNdaOxoobUXg/3+ZGBDjs2B/M0zkYODUgMR5IL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBPEZnqt; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20cdb889222so22176395ad.3;
        Tue, 15 Oct 2024 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001341; x=1729606141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW+1nDdA8utvPm2jP7G49D5vvInvTyAcYQzt/B4r/3E=;
        b=kBPEZnqttqECexn6qnxfvWNIIpzZKUlKaVbsB1XzgCN8gD4DI4uN/v3jEOEJGbrPJ0
         XZJH2B9aBIbCE9EBH8oq5iBVUzjZaRVeiDzgNyGUhUuxCqYaSdRopIZKkwWwzhXOYtnN
         BwVxeP9h0dd9FSNr4eYeIU//+DST5YKCt+SsIohQl7EbYb3Zp7+f53j7NHjtoSzNCAPn
         JIF0hNYYI1VrKHs1FLnm3+h0VhSRWRfcVdBNHFVmcPLyeaYLnLnXv5yuWK7ulujnNkHL
         gFCanCSBttKuXPIEs1Hs+MSkdehZ2Vbge7HHdluRvVkQk5iK88fwDWuzz4mlq/xrwZXX
         sZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001341; x=1729606141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW+1nDdA8utvPm2jP7G49D5vvInvTyAcYQzt/B4r/3E=;
        b=tK6XVMBK9Wi9FEcLIxOLaao7/3/buIsSngH73IFphrkWvf5QhfkCJuLVYOvDr23qvX
         eMOfdfoSMJqE2r2jc3/2nt3RMI6Y7Vn5LE6JlFzMTitgbZoH6g3tj554GR+wHrvrKZli
         Zb2ByG3pk9vLJyg47mVH7eKdq/l+oRgUTtorPAVKXGcFATEzgNPuPKn3USK7d8yn/aoW
         fDnJP0USquzsJoPWzPBTgUVl6ryOhbbeLj5Q2B6crCmFqu0JlExVhQ7tpiYCaoYqEk3o
         rQgm83vGI+dqwTRTLp4qYts8OVDrqGB3gQRrVNVbbLsOUAbpwCmFsfjRcwjKjHxtoxHs
         plyw==
X-Forwarded-Encrypted: i=1; AJvYcCUARA6KYqMwkJSuGL3ViEm10SQVr6ccHaKBd9+bVl28vtI/6bBOTXU5C/NG0C9dHgzywd8=@vger.kernel.org, AJvYcCUYtTIeGZw2/D8zsL2uCrqngWfJcwqJHF0uRKIlIW6cZfXU5WPouPzYl1UE5FaJG7J8/+k9hw+f@vger.kernel.org, AJvYcCWpcfWEZjXQVdaKWA2zbycLT7rWhuQzghTBZqyuM4G1hDWj1CU62KE3S7+Yw/1VH/gt8iKd0cflHCEYY7cE@vger.kernel.org, AJvYcCX5gWhay7O5xCUy0ZpWjBVnjX5Ruf/+c2F41ULgdcw6xd84hTkyZDwwxNMbhHUJ8WbkWvTtSIQAms4ccIhMFIuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X7K9NC62LJ/xds+Rac5t/9ydqmWHEOhlIcFDS1q6KqmO40wC
	vWAi6+dKVeYJKwI3EclfLZ/VngoZCH6B9edMJPI6so/OepcYq9No
X-Google-Smtp-Source: AGHT+IFM+h+UidhY1yUdM2sbMLG9ioWHi58m/J4aqzMYLTVGO9SSSCYk8ttlRJ9p164FGG21NWtORA==
X-Received: by 2002:a17:902:e805:b0:20c:7eaf:8945 with SMTP id d9443c01a7336-20ca14601b3mr227787995ad.28.1729001340617;
        Tue, 15 Oct 2024 07:09:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:00 -0700 (PDT)
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
Subject: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref() return drop reasons
Date: Tue, 15 Oct 2024 22:07:57 +0800
Message-Id: <20241015140800.159466-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015140800.159466-1-dongml2@chinatelecom.cn>
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
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
 include/net/route.h    | 15 ++++++++-------
 net/core/lwt_bpf.c     |  1 +
 net/ipv4/ip_fragment.c | 12 +++++++-----
 net/ipv4/ip_input.c    |  7 ++++---
 net/ipv4/route.c       |  7 ++++---
 5 files changed, 24 insertions(+), 18 deletions(-)

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
index e0ca24a58810..a4652f2a103a 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		skb_dst_drop(skb);
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
 					   ip4h_dscp(iph), dev);
+		err = err ? -EINVAL : 0;
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
index 8ac298d69c8c..86a964734b1d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2486,8 +2486,9 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
@@ -2496,7 +2497,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
-- 
2.39.5


