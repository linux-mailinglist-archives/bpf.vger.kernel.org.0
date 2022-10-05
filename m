Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04505F5635
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJEOOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJEON7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D67C316
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:59 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59p-0001fh-DK; Wed, 05 Oct 2022 16:13:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 8/9] netfilter: netdev: switch to invocation via bpf
Date:   Wed,  5 Oct 2022 16:13:08 +0200
Message-Id: <20221005141309.31758-9-fw@strlen.de>
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

Handle ingress and egress hook invocation via bpf.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter_netdev.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/netfilter_netdev.h b/include/linux/netfilter_netdev.h
index 92996b1ac90f..b0d50a28626f 100644
--- a/include/linux/netfilter_netdev.h
+++ b/include/linux/netfilter_netdev.h
@@ -19,6 +19,9 @@ static inline bool nf_hook_ingress_active(const struct sk_buff *skb)
 static inline int nf_hook_ingress(struct sk_buff *skb)
 {
 	struct nf_hook_entries *e = rcu_dereference(skb->dev->nf_hooks_ingress);
+#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
+	const struct bpf_prog *prog;
+#endif
 	struct nf_hook_state state;
 	int ret;
 
@@ -31,7 +34,19 @@ static inline int nf_hook_ingress(struct sk_buff *skb)
 	nf_hook_state_init(&state, NF_NETDEV_INGRESS,
 			   NFPROTO_NETDEV, skb->dev, NULL, NULL,
 			   dev_net(skb->dev), NULL);
+
+#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
+	prog = READ_ONCE(e->hook_prog);
+
+	state.priv = (void *)e;
+	state.skb = skb;
+
+	migrate_disable();
+	ret = bpf_prog_run_nf(prog, &state);
+	migrate_enable();
+#else
 	ret = nf_hook_slow(skb, &state, e);
+#endif
 	if (ret == 0)
 		return -1;
 
@@ -87,6 +102,9 @@ static inline struct sk_buff *nf_hook_egress(struct sk_buff *skb, int *rc,
 {
 	struct nf_hook_entries *e;
 	struct nf_hook_state state;
+#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
+	const struct bpf_prog *prog;
+#endif
 	int ret;
 
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
@@ -104,7 +122,18 @@ static inline struct sk_buff *nf_hook_egress(struct sk_buff *skb, int *rc,
 
 	/* nf assumes rcu_read_lock, not just read_lock_bh */
 	rcu_read_lock();
+#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
+	prog = READ_ONCE(e->hook_prog);
+
+	state.priv = (void *)e;
+	state.skb = skb;
+
+	migrate_disable();
+	ret = bpf_prog_run_nf(prog, &state);
+	migrate_enable();
+#else
 	ret = nf_hook_slow(skb, &state, e);
+#endif
 	rcu_read_unlock();
 
 	if (ret == 1) {
-- 
2.35.1

