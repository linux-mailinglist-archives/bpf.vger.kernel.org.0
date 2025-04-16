Return-Path: <bpf+bounces-56044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D9A9084D
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C8A19E0434
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B620FA9D;
	Wed, 16 Apr 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="1LeyLbrS"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BE1F418B;
	Wed, 16 Apr 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819663; cv=none; b=FpR4dfyd6nYH8l85amfL6VSNXVElrkHryblNarLh91/1MZn7FvdkJXsEiSZULBKxp+W7hqWpOBFUH2jCbD5II60nkHBInl6gS3tSaYWh5YwNzWhdHVTUBx/KK00t11jrXKCBnBq2BDulvEsf9A6/F2afWQ5fQuJ0DRos1MQ6Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819663; c=relaxed/simple;
	bh=aY/7WU4Wj6p/7X+qEWN/caeXB/BiU403FgNaMEmMpIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQqHFgM2CG07iuA4wSEw8a2s0EpG3xTOgopPTGYlbgyCQVFIQoyyTp3ZnNpF3JxVCu94TA/9ElJk02lPPMscmoUlFYeRnK9OQnOTZ85Vl+soCdK4CG7w2ge7gbIvju+Y3UxK4s4A4+aK4IR4YoYAZRoK1JcqA77bjfiBHKR7wlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=1LeyLbrS; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 35ABD200BFFE;
	Wed, 16 Apr 2025 18:07:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 35ABD200BFFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744819652;
	bh=M92GeyoNqay7R9kooGw994u2oi5JtmL6fm9Rut6IPgw=;
	h=From:To:Cc:Subject:Date:From;
	b=1LeyLbrSCsB6xo/1ZOlHLOxk4ay0oTZOisTrI4psU6KEi7zaFkdvqpl/deAFvrA3e
	 G05ymUpGDKn8nIHi22bU4o4nkWdLARViu5OSQVLIuqyAWzjCrPWGvy2N7MjKddfwTU
	 b7ZjEqYkW8TGB5XlWjG9/hanyUPcsydUom3MMttbMiV8qQbK2K7QllTocMlVgqI2eq
	 nfQG8RrUqTmrXdDE+Hes1lJOy0VI7C3kP0t3SwVZCQSBUZdlvb9+4beGV7oA2/L5Od
	 2CFsRklfIdiV5kMYOrDquiBjCoN0i1gcGZ7zf+o/zo5W17A44Wla8RK0UkM+J1KKXG
	 g20Gm2fOlrjDA==
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
Subject: [PATCH net v3] net: lwtunnel: disable BHs when required
Date: Wed, 16 Apr 2025 18:07:16 +0200
Message-Id: <20250416160716.8823-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- removed unrelated code cleanups
v2:
- https://lore.kernel.org/netdev/20250415173239.39781-1-justin.iurman@uliege.be/
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
 net/core/lwtunnel.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index e39a459540ec..60f27cb4e54f 100644
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
@@ -348,8 +350,10 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -364,11 +368,13 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_output);
@@ -380,6 +386,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -396,8 +404,10 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -412,11 +422,13 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_xmit);
@@ -428,6 +440,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
-- 
2.34.1


