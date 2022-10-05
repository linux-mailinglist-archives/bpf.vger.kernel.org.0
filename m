Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319425F5634
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJEON5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJEON4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:56 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4A786CA
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59l-0001fY-9W; Wed, 05 Oct 2022 16:13:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 7/9] netfilter: core: do not rebuild bpf program on dying netns
Date:   Wed,  5 Oct 2022 16:13:07 +0200
Message-Id: <20221005141309.31758-8-fw@strlen.de>
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

We can save a few cycles on netns destruction.
When a hook is removed we can just skip building a new
program with the remaining hooks, those will be removed too
in the immediate future.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 6888c7fd5aeb..71974c55de50 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -272,6 +272,7 @@ EXPORT_SYMBOL_GPL(nf_hook_entries_insert_raw);
  *
  * @old -- current hook blob at @pp
  * @pp -- location of hook blob
+ * @recompile -- false if bpf prog should not be replaced
  *
  * Hook unregistration must always succeed, so to-be-removed hooks
  * are replaced by a dummy one that will just move to next hook.
@@ -284,7 +285,8 @@ EXPORT_SYMBOL_GPL(nf_hook_entries_insert_raw);
  * Returns address to free, or NULL.
  */
 static void *__nf_hook_entries_try_shrink(struct nf_hook_entries *old,
-					  struct nf_hook_entries __rcu **pp)
+					  struct nf_hook_entries __rcu **pp,
+					  bool recompile)
 {
 	unsigned int i, j, skip = 0, hook_entries;
 	struct bpf_prog *hook_bpf_prog = NULL;
@@ -329,10 +331,12 @@ static void *__nf_hook_entries_try_shrink(struct nf_hook_entries *old,
 	}
 	hooks_validate(new);
 
-	/* if this fails fallback prog calls nf_hook_slow. */
-	hook_bpf_prog = nf_hook_bpf_create(new);
-	if (hook_bpf_prog)
-		nf_hook_bpf_prog_set(new, hook_bpf_prog);
+	if (recompile) {
+		/* if this fails fallback prog calls nf_hook_slow. */
+		hook_bpf_prog = nf_hook_bpf_create(new);
+		if (hook_bpf_prog)
+			nf_hook_bpf_prog_set(new, hook_bpf_prog);
+	}
 out_assign:
 	nf_hook_bpf_change_prog(NF_DISPATCHER_PTR, nf_hook_bpf_prog_get(old), hook_bpf_prog);
 	rcu_assign_pointer(*pp, new);
@@ -581,7 +585,7 @@ static void __nf_unregister_net_hook(struct net *net, int pf,
 		WARN_ONCE(1, "hook not found, pf %d num %d", pf, reg->hooknum);
 	}
 
-	p = __nf_hook_entries_try_shrink(p, pp);
+	p = __nf_hook_entries_try_shrink(p, pp, check_net(net));
 	mutex_unlock(&nf_hook_mutex);
 	if (!p)
 		return;
@@ -612,7 +616,7 @@ void nf_hook_entries_delete_raw(struct nf_hook_entries __rcu **pp,
 
 	p = rcu_dereference_raw(*pp);
 	if (nf_remove_net_hook(p, reg)) {
-		p = __nf_hook_entries_try_shrink(p, pp);
+		p = __nf_hook_entries_try_shrink(p, pp, false);
 		nf_hook_entries_free(p);
 	}
 }
-- 
2.35.1

