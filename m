Return-Path: <bpf+bounces-55212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0759A79E5D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00911896FB9
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BF241CA3;
	Thu,  3 Apr 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="qC4mrEeX"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D81F03CB;
	Thu,  3 Apr 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669637; cv=none; b=QY4j5b+0dTqbugrhxbokB/AnGYobhKbjG1+joXwGP7PCv7FUPYoxud2jl3pXMKy2JnELyOcaOfyV+SjOzOQ69oauRqJ0ejcXvX6ceScajXS437oOpv5+LxTtVR1fnZ3MYX/viqp+mL+2KalUyG0DbBUR3ffMEPZu6rMZZnMOT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669637; c=relaxed/simple;
	bh=adNmKijgwJ0/HuyYribCZ1SflALgeVpdt9ZDAd8R8f8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gBT3na7UD4mdsnp056Vydde7dL/x3JfyhLGKcJL/ao5PshnwJNrWZReT2AgOtI/DMh+NsFQKuA7Wf16x848uBflSDlH20eBtWBzbnNQL1l+UO+vAcfVFBXo/QaggKaqinpSW+mVUgeiCouTAgwfvfIaAZu8CwUF9HkNOMe9POGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=qC4mrEeX; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D00A9200A728;
	Thu,  3 Apr 2025 10:40:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D00A9200A728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1743669626;
	bh=94DJ7KtPQKubwfSja/wln0B8MjCkiuH0R9N/UpDkdu8=;
	h=From:To:Cc:Subject:Date:From;
	b=qC4mrEeXIlQbcEHZIvGjHX2tGfByiQQd7iOyDqXJmls0X1oYFndmOj9uE36Y3jQOH
	 3jNjR0GCM2LZAqEO99ZohOCxP/JqBc3d/38sSAMgZIB5BiDwjiRAPmyxIJjjkJtB/x
	 1SKJyTUjxMyy7bcBaRuAj0/dUVkwt3myWYU5qzZRaK/0TuBwI2etY6HXOvf1b7vqif
	 2zWm8FDfZrCY81vqhnGqJydUkPQsijjqvxUOEXUcqn7pKFuVLagE69wfNnUrM58tI7
	 3cZ/R/N8UiaMevmSYCwN6iVIGrDB5iNYduprAwatAb5bxyuqDlW7UkTM+C+mP2XT3J
	 WtvpqvjKa3+pA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	justin.iurman@uliege.be,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net] net: lwtunnel: disable preemption when required
Date: Thu,  3 Apr 2025 10:39:56 +0200
Message-Id: <20250403083956.13946-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lwtunnel_{input|output|xmit}(), dev_xmit_recursion() may be called in
preemptible scope for PREEMPT kernels. This patch disables preemption
before calling dev_xmit_recursion(). Preemption is re-enabled only at
the end, since we must ensure the same CPU is used for both
dev_xmit_recursion_inc() and dev_xmit_recursion_dec() (and any other
recursion levels in some cases) in order to maintain valid per-cpu
counters.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/netdev/CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com/
Fixes: 986ffb3a57c5 ("net: lwtunnel: fix recursion loops")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/lwtunnel.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index e39a459540ec..a9ad068e5707 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -333,6 +333,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	preempt_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -345,11 +347,13 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		ret = -EINVAL;
 		goto drop;
 	}
-	lwtstate = dst->lwtstate;
 
+	lwtstate = dst->lwtstate;
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -364,11 +368,11 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
-
+	goto out;
 drop:
 	kfree_skb(skb);
-
+out:
+	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_output);
@@ -380,6 +384,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	preempt_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -394,10 +400,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	}
 
 	lwtstate = dst->lwtstate;
-
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -412,11 +419,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
-
+	goto out;
 drop:
 	kfree_skb(skb);
-
+out:
+	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_xmit);
@@ -428,6 +435,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	preempt_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -440,11 +449,13 @@ int lwtunnel_input(struct sk_buff *skb)
 		ret = -EINVAL;
 		goto drop;
 	}
-	lwtstate = dst->lwtstate;
 
+	lwtstate = dst->lwtstate;
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -459,11 +470,11 @@ int lwtunnel_input(struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
-
+	goto out;
 drop:
 	kfree_skb(skb);
-
+out:
+	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_input);
-- 
2.34.1


