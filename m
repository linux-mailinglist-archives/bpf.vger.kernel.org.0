Return-Path: <bpf+bounces-55993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3100A8A5B1
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87AC1784A4
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3A21D5B0;
	Tue, 15 Apr 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="IowmYnlh"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304918FDD2;
	Tue, 15 Apr 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738386; cv=none; b=NVPsp7fwsyksI7/CtOx3mLGaFixIQOI6yLI3/2buT7EG1Wp63OFmRWv0RrIYW85MItM/lP0UuglrpE2cnfhYXXgzDeHjEykCYsJeYq6dBFHXD19nTj9iWesjP6QW6Wwb823PWWJg5RvlfKokVDQOAVSk34QkPcIDJ41wAOMLxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738386; c=relaxed/simple;
	bh=1szZC1eehH1SsFARH9SlXFiTiHnWWh4RUAwSHezPxUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3SVlj0woieWkRLnXKP8iRPzr1AASmXVIvARXRHcA3rNngDanxHq6A2XX3uj6qdfCUb7VYt6gWYzRqGet5BtcL3xWoQgF5nbd1+f3htt/py//DuqCwY4IcO621rCYqtAKFUQ5ZYFoac2kLQMFqgVKenamWNieVRi7pnmmrVJHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=IowmYnlh; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 97E1E200DB80;
	Tue, 15 Apr 2025 19:33:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 97E1E200DB80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744738381;
	bh=IbQmDsgxJdY2+2UAwOgv5kT7783Rv22sijWahhN2N3o=;
	h=From:To:Cc:Subject:Date:From;
	b=IowmYnlhiqIVEWxVua8MbV112+Hhw2Hwyj95pby/42Wptq0TC1neWPoOd6cf7Hg39
	 KvZOoQyet53aaPgjHl5Xc/UdclY8MmkgW2EHlqW5eRwvlSes5zxXoLKm/iCFgPxwDc
	 C//LcbJeDnJu37n4XICMfjuLG5zRNKeEcj32H+6PlFomq6cPUpc9GwU7qUhGtPmRfo
	 N271lnoSGhLu3XqKkt75ufsaNtQqUv+kGvUAp7P9aWnJHHCRxCRVE76gCMj5YNBUje
	 30goexQoOzF2tASe71/ExJxGQdWqW8ahCRf2bDnfD/wyEseIjT8XZSKwb3Ujk6JZer
	 P4cyoBjeFEwcw==
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
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: [PATCH net v2] net: lwtunnel: disable BHs when required
Date: Tue, 15 Apr 2025 19:32:39 +0200
Message-Id: <20250415173239.39781-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- replaced preempt_{disable|enable}() by local_bh_{disable|enable}()
- not in lwtunnel_input() since BHs are already disabled on that path
v1:
- https://lore.kernel.org/netdev/20250403083956.13946-1-justin.iurman@uliege.be/

In lwtunnel_{output|xmit}(), dev_xmit_recursion() may be called in
preemptible scope for PREEMPT kernels. This patch disables BHs before
calling dev_xmit_recursion(). BHs are re-enabled only at the end, since
we must ensure the same CPU is used for both dev_xmit_recursion_inc()
and dev_xmit_recursion_dec() (and any other recursion levels in some
cases) in order to maintain valid per-cpu counters.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/netdev/CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com/
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Closes: https://lore.kernel.org/netdev/m2h62qwf34.fsf@gmail.com/
Fixes: 986ffb3a57c5 ("net: lwtunnel: fix recursion loops")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
---
 net/core/lwtunnel.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index e39a459540ec..cc1b78616a94 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -333,6 +333,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
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
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_output);
@@ -380,6 +384,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
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
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_xmit);
@@ -428,6 +435,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -440,8 +449,8 @@ int lwtunnel_input(struct sk_buff *skb)
 		ret = -EINVAL;
 		goto drop;
 	}
-	lwtstate = dst->lwtstate;
 
+	lwtstate = dst->lwtstate;
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
 	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
 		return 0;
@@ -460,10 +469,8 @@ int lwtunnel_input(struct sk_buff *skb)
 		goto drop;
 
 	return ret;
-
 drop:
 	kfree_skb(skb);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_input);
-- 
2.34.1


