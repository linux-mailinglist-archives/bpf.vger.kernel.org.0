Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030635F562F
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJEONg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiJEONf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:35 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA037C316
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59Q-0001eo-H1; Wed, 05 Oct 2022 16:13:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 2/9] netfilter: nat: split nat hook iteration into a helper
Date:   Wed,  5 Oct 2022 16:13:02 +0200
Message-Id: <20221005141309.31758-3-fw@strlen.de>
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

Makes conversion in followup patch simpler.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_nat_core.c | 46 +++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 7981be526f26..bd5ac4ff03f9 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -709,6 +709,32 @@ static bool in_vrf_postrouting(const struct nf_hook_state *state)
 	return false;
 }
 
+static unsigned int nf_nat_inet_run_hooks(const struct nf_hook_state *state,
+					  struct sk_buff *skb,
+					  struct nf_conn *ct,
+					  struct nf_nat_lookup_hook_priv *lpriv)
+{
+	enum nf_nat_manip_type maniptype = HOOK2MANIP(state->hook);
+	struct nf_hook_entries *e = rcu_dereference(lpriv->entries);
+	unsigned int ret;
+	int i;
+
+	if (!e)
+		goto null_bind;
+
+	for (i = 0; i < e->num_hook_entries; i++) {
+		ret = e->hooks[i].hook(e->hooks[i].priv, skb, state);
+		if (ret != NF_ACCEPT)
+			return ret;
+
+		if (nf_nat_initialized(ct, maniptype))
+			return NF_ACCEPT;
+	}
+
+null_bind:
+	return nf_nat_alloc_null_binding(ct, state->hook);
+}
+
 unsigned int
 nf_nat_inet_fn(void *priv, struct sk_buff *skb,
 	       const struct nf_hook_state *state)
@@ -740,23 +766,9 @@ nf_nat_inet_fn(void *priv, struct sk_buff *skb,
 		 */
 		if (!nf_nat_initialized(ct, maniptype)) {
 			struct nf_nat_lookup_hook_priv *lpriv = priv;
-			struct nf_hook_entries *e = rcu_dereference(lpriv->entries);
 			unsigned int ret;
-			int i;
-
-			if (!e)
-				goto null_bind;
-
-			for (i = 0; i < e->num_hook_entries; i++) {
-				ret = e->hooks[i].hook(e->hooks[i].priv, skb,
-						       state);
-				if (ret != NF_ACCEPT)
-					return ret;
-				if (nf_nat_initialized(ct, maniptype))
-					goto do_nat;
-			}
-null_bind:
-			ret = nf_nat_alloc_null_binding(ct, state->hook);
+
+			ret = nf_nat_inet_run_hooks(state, skb, ct, lpriv);
 			if (ret != NF_ACCEPT)
 				return ret;
 		} else {
@@ -775,7 +787,7 @@ nf_nat_inet_fn(void *priv, struct sk_buff *skb,
 		if (nf_nat_oif_changed(state->hook, ctinfo, nat, state->out))
 			goto oif_changed;
 	}
-do_nat:
+
 	return nf_nat_packet(ct, ctinfo, state->hook, skb);
 
 oif_changed:
-- 
2.35.1

