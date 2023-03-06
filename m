Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F976AB8A1
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCFInG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCFIm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:59 -0500
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0262133
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:42:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOdOn6pI5wLZ1GrmY4ODB/F7jRX93wYKeaPBoIIkNGg=;
        b=libUOaF3FIYn5kidghZADsvPsAag37zTftwwUKiPxoExwno+S98aNEvTlqwAEasG1RbevO
        0RoWEf0RL+Q31tD+5Rfj55elurbCkuj0IAiCeNZ5fOkytMa51zUuCAJ25RYQUh/RWRI6YI
        hZUy0e02AWkqt8qi4o3692aEcZO28Pk=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 10/16] bpf: Add bpf_local_storage_rcu callback
Date:   Mon,  6 Mar 2023 00:42:10 -0800
Message-Id: <20230306084216.3186830-11-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-1-martin.lau@linux.dev>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The existing bpf_local_storage_free_rcu is renamed to
bpf_local_storage_free_trace_rcu. A new bpf_local_storage_rcu
callback is added to do the kfree instead of using kfree_rcu.
It is a preparation work for a later patch using
bpf_mem_cache_alloc/free.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index f611668f8a0b..0568b479bdb0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -99,14 +99,19 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
+	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
+	kfree(local_storage);
+}
+
+static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
+{
 	/* If RCU Tasks Trace grace period implies RCU grace period, do
 	 * kfree(), else do kfree_rcu().
 	 */
-	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
 	if (rcu_trace_implies_rcu_gp())
-		kfree(local_storage);
+		bpf_local_storage_free_rcu(rcu);
 	else
-		kfree_rcu(local_storage, rcu);
+		call_rcu(rcu, bpf_local_storage_free_rcu);
 }
 
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
@@ -216,9 +221,9 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	if (free_local_storage) {
 		if (!reuse_now)
 			call_rcu_tasks_trace(&local_storage->rcu,
-				     bpf_local_storage_free_rcu);
+				     bpf_local_storage_free_trace_rcu);
 		else
-			kfree_rcu(local_storage, rcu);
+			call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
 	}
 }
 
@@ -631,7 +636,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_storage)
-		kfree_rcu(local_storage, rcu);
+		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
 }
 
 struct bpf_map *
-- 
2.30.2

