Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963B6AFF4A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCHHA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCHHAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:20 -0500
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D4A1FF0
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iu7L2ErGW26jtDIV3c9OTDh69QdHhg1s5aBD7bIyq/A=;
        b=xLH0n6KO9VgHalefOBVmx+6XadiWrSS6MXVomSnL8AF3GHYkzLH6I0sOnfKAlY1xSNz37D
        SC7fVXRFjtd5c3gJbuevvAEvudcjimfx+rgu6bLsRpx0pwB55PG0b+6I6jqjUyGktu6sNj
        bjNaDYEbnbp/HIywkgvuVIqnWZJwp44=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 11/17] bpf: Add bpf_local_storage_free()
Date:   Tue,  7 Mar 2023 22:59:30 -0800
Message-Id: <20230308065936.1550103-12-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch refactors local_storage freeing logic into
bpf_local_storage_free(). It is a preparation work for a later
patch that uses bpf_mem_cache_alloc/free. The other kfree(local_storage)
cases are also changed to bpf_local_storage_free(..., reuse_now = true).

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0fbc477c8b27..351d991694cb 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -114,6 +114,16 @@ static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 		call_rcu(rcu, bpf_local_storage_free_rcu);
 }
 
+static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
+				   bool reuse_now)
+{
+	if (!reuse_now)
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     bpf_local_storage_free_trace_rcu);
+	else
+		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+}
+
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
@@ -218,13 +228,8 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 			local_storage, selem, true, reuse_now);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	if (free_local_storage) {
-		if (!reuse_now)
-			call_rcu_tasks_trace(&local_storage->rcu,
-				     bpf_local_storage_free_trace_rcu);
-		else
-			call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
-	}
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -391,7 +396,7 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	kfree(storage);
+	bpf_local_storage_free(storage, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -636,7 +641,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_storage)
-		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+		bpf_local_storage_free(local_storage, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.34.1

