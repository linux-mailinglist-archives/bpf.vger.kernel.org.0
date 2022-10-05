Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761195F5630
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJEONj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJEONj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4567AC20
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59U-0001ex-Km; Wed, 05 Oct 2022 16:13:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 3/9] netfilter: remove hook index from nf_hook_slow arguments
Date:   Wed,  5 Oct 2022 16:13:03 +0200
Message-Id: <20221005141309.31758-4-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005141309.31758-1-fw@strlen.de>
References: <20221005141309.31758-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous patch added hook_entry member to nf_hook_state struct, so
use that for passing the index.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h        | 5 +++--
 include/linux/netfilter_netdev.h | 4 ++--
 net/bridge/br_netfilter_hooks.c  | 3 ++-
 net/netfilter/core.c             | 6 +++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 7a1a2c4787f0..ec416d79352e 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -154,6 +154,7 @@ static inline void nf_hook_state_init(struct nf_hook_state *p,
 {
 	p->hook = hook;
 	p->pf = pf;
+	p->hook_index = 0;
 	p->in = indev;
 	p->out = outdev;
 	p->sk = sk;
@@ -198,7 +199,7 @@ extern struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 #endif
 
 int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
-		 const struct nf_hook_entries *e, unsigned int i);
+		 const struct nf_hook_entries *e);
 
 void nf_hook_slow_list(struct list_head *head, struct nf_hook_state *state,
 		       const struct nf_hook_entries *e);
@@ -255,7 +256,7 @@ static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
 		nf_hook_state_init(&state, hook, pf, indev, outdev,
 				   sk, net, okfn);
 
-		ret = nf_hook_slow(skb, &state, hook_head, 0);
+		ret = nf_hook_slow(skb, &state, hook_head);
 	}
 	rcu_read_unlock();
 
diff --git a/include/linux/netfilter_netdev.h b/include/linux/netfilter_netdev.h
index 8676316547cc..92996b1ac90f 100644
--- a/include/linux/netfilter_netdev.h
+++ b/include/linux/netfilter_netdev.h
@@ -31,7 +31,7 @@ static inline int nf_hook_ingress(struct sk_buff *skb)
 	nf_hook_state_init(&state, NF_NETDEV_INGRESS,
 			   NFPROTO_NETDEV, skb->dev, NULL, NULL,
 			   dev_net(skb->dev), NULL);
-	ret = nf_hook_slow(skb, &state, e, 0);
+	ret = nf_hook_slow(skb, &state, e);
 	if (ret == 0)
 		return -1;
 
@@ -104,7 +104,7 @@ static inline struct sk_buff *nf_hook_egress(struct sk_buff *skb, int *rc,
 
 	/* nf assumes rcu_read_lock, not just read_lock_bh */
 	rcu_read_lock();
-	ret = nf_hook_slow(skb, &state, e, 0);
+	ret = nf_hook_slow(skb, &state, e);
 	rcu_read_unlock();
 
 	if (ret == 1) {
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index f20f4373ff40..cc4b5a19ca31 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1036,7 +1036,8 @@ int br_nf_hook_thresh(unsigned int hook, struct net *net,
 	nf_hook_state_init(&state, hook, NFPROTO_BRIDGE, indev, outdev,
 			   sk, net, okfn);
 
-	ret = nf_hook_slow(skb, &state, e, i);
+	state.hook_index = i;
+	ret = nf_hook_slow(skb, &state, e);
 	if (ret == 1)
 		ret = okfn(net, sk, skb);
 
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index c094742e3ec3..a8176351f120 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -605,9 +605,9 @@ EXPORT_SYMBOL(nf_unregister_net_hooks);
 /* Returns 1 if okfn() needs to be executed by the caller,
  * -EPERM for NF_DROP, 0 otherwise.  Caller must hold rcu_read_lock. */
 int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
-		 const struct nf_hook_entries *e, unsigned int s)
+		 const struct nf_hook_entries *e)
 {
-	unsigned int verdict;
+	unsigned int verdict, s = state->hook_index;
 	int ret;
 
 	for (; s < e->num_hook_entries; s++) {
@@ -651,7 +651,7 @@ void nf_hook_slow_list(struct list_head *head, struct nf_hook_state *state,
 
 	list_for_each_entry_safe(skb, next, head, list) {
 		skb_list_del_init(skb);
-		ret = nf_hook_slow(skb, state, e, 0);
+		ret = nf_hook_slow(skb, state, e);
 		if (ret == 1)
 			list_add_tail(&skb->list, &sublist);
 	}
-- 
2.35.1

