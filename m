Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23515F562E
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiJEONg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJEONb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:31 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17062786CA
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:30 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59L-0001ee-Sc; Wed, 05 Oct 2022 16:13:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 1/9] netfilter: nf_queue: carry index in hook state
Date:   Wed,  5 Oct 2022 16:13:01 +0200
Message-Id: <20221005141309.31758-2-fw@strlen.de>
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

Rather than passing the index (hook function to call next)
as function argument, store it in the hook state.

This is a prerequesite to allow passing all nf hook arguments in a single
structure.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h        |  1 +
 include/net/netfilter/nf_queue.h |  3 +--
 net/bridge/br_input.c            |  3 ++-
 net/netfilter/core.c             |  6 +++++-
 net/netfilter/nf_queue.c         | 12 ++++++------
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d8817d381c14..7a1a2c4787f0 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -67,6 +67,7 @@ struct sock;
 struct nf_hook_state {
 	u8 hook;
 	u8 pf;
+	u16 hook_index; /* index in hook_entries->hook[] */
 	struct net_device *in;
 	struct net_device *out;
 	struct sock *sk;
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 980daa6e1e3a..bdcdece2bbff 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -13,7 +13,6 @@ struct nf_queue_entry {
 	struct list_head	list;
 	struct sk_buff		*skb;
 	unsigned int		id;
-	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	struct net_device	*physin;
 	struct net_device	*physout;
@@ -125,6 +124,6 @@ nfqueue_hash(const struct sk_buff *skb, u16 queue, u16 queues_total, u8 family,
 }
 
 int nf_queue(struct sk_buff *skb, struct nf_hook_state *state,
-	     unsigned int index, unsigned int verdict);
+	     unsigned int verdict);
 
 #endif /* _NF_QUEUE_H */
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 68b3e850bcb9..5be7e4573528 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -264,7 +264,8 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 			kfree_skb(skb);
 			return RX_HANDLER_CONSUMED;
 		case NF_QUEUE:
-			ret = nf_queue(skb, &state, i, verdict);
+			state.hook_index = i;
+			ret = nf_queue(skb, &state, verdict);
 			if (ret == 1)
 				continue;
 			return RX_HANDLER_CONSUMED;
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5a6705a0e4ec..c094742e3ec3 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -623,7 +623,8 @@ int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
 				ret = -EPERM;
 			return ret;
 		case NF_QUEUE:
-			ret = nf_queue(skb, state, s, verdict);
+			state->hook_index = s;
+			ret = nf_queue(skb, state, verdict);
 			if (ret == 1)
 				continue;
 			return ret;
@@ -772,6 +773,9 @@ int __init netfilter_init(void)
 {
 	int ret;
 
+	/* state->index */
+	BUILD_BUG_ON(MAX_HOOK_COUNT > USHRT_MAX);
+
 	ret = register_pernet_subsys(&netfilter_net_ops);
 	if (ret < 0)
 		goto err;
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 63d1516816b1..9f9dfde3e054 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -156,7 +156,7 @@ static void nf_ip6_saveroute(const struct sk_buff *skb,
 }
 
 static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
-		      unsigned int index, unsigned int queuenum)
+		      unsigned int queuenum)
 {
 	struct nf_queue_entry *entry = NULL;
 	const struct nf_queue_handler *qh;
@@ -204,7 +204,6 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.state	= *state,
-		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
 	};
 
@@ -235,11 +234,11 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 
 /* Packets leaving via this function must come back through nf_reinject(). */
 int nf_queue(struct sk_buff *skb, struct nf_hook_state *state,
-	     unsigned int index, unsigned int verdict)
+	     unsigned int verdict)
 {
 	int ret;
 
-	ret = __nf_queue(skb, state, index, verdict >> NF_VERDICT_QBITS);
+	ret = __nf_queue(skb, state, verdict >> NF_VERDICT_QBITS);
 	if (ret < 0) {
 		if (ret == -ESRCH &&
 		    (verdict & NF_VERDICT_FLAG_QUEUE_BYPASS))
@@ -311,7 +310,7 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
-	i = entry->hook_index;
+	i = entry->state.hook_index;
 	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
 		kfree_skb(skb);
 		nf_queue_entry_free(entry);
@@ -343,7 +342,8 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 		local_bh_enable();
 		break;
 	case NF_QUEUE:
-		err = nf_queue(skb, &entry->state, i, verdict);
+		entry->state.hook_index = i;
+		err = nf_queue(skb, &entry->state, verdict);
 		if (err == 1)
 			goto next_hook;
 		break;
-- 
2.35.1

