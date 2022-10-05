Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0E5F5632
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJEONw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJEONr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7557C33D
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 07:13:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1og59c-0001fE-VS; Wed, 05 Oct 2022 16:13:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v2 5/9] netfilter: reduce allowed hook count to 32
Date:   Wed,  5 Oct 2022 16:13:05 +0200
Message-Id: <20221005141309.31758-6-fw@strlen.de>
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

1k is huge and will mean we'd need to support tailcalls in the
nf_hook bpf converter.

We need about 5 insns per hook at this time, ignoring prologue/epilogue.

32 should be fine, typically even extreme cases need about 8 hooks per
hook location.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 593fec9434d7..17165f9cf4a1 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL(nf_hooks_needed);
 static DEFINE_MUTEX(nf_hook_mutex);
 
 /* max hooks per family/hooknum */
-#define MAX_HOOK_COUNT		1024
+#define MAX_HOOK_COUNT		32
 
 #define nf_entry_dereference(e) \
 	rcu_dereference_protected(e, lockdep_is_held(&nf_hook_mutex))
-- 
2.35.1

