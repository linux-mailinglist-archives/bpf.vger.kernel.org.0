Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D566B6AFF3D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHHAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCHHAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:16 -0500
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [IPv6:2001:41d0:203:375::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DDA17EA
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:15 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNjON9MF/je3R9qY++lrXmdI8DytqFwwkZRkb4zzvNE=;
        b=fEBMvOpq47oAC3IzwEh+0fPae7H6ZcMpA94pO+zavwX9UFD5Rad6NxG89aakaPOzuI/Yt9
        wbrxL7ZhGx6UKGT3pP9sJa4BSmZBbvCm0/yru8zBddLMjAvIuZKScErWpUlHS2g5gIcRDn
        huSVsXdWEpNacnOA6XEova8ZenprXqs=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 09/17] bpf: Add bpf_selem_free()
Date:   Tue,  7 Mar 2023 22:59:28 -0800
Message-Id: <20230308065936.1550103-10-martin.lau@linux.dev>
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

This patch refactors the selem freeing logic into bpf_selem_free().
It is a preparation work for a later patch using
bpf_mem_cache_alloc/free. The other kfree(selem) cases
are also changed to bpf_selem_free(..., reuse_now = true).

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  4 ++++
 kernel/bpf/bpf_local_storage.c    | 21 ++++++++++++++-------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 18a31add2255..a34f61467a2f 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -152,6 +152,10 @@ struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 		bool charge_mem, gfp_t gfp_flags);
 
+void bpf_selem_free(struct bpf_local_storage_elem *selem,
+		    struct bpf_local_storage_map *smap,
+		    bool reuse_now);
+
 int
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 146e9caeda96..512943aac435 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -125,6 +125,17 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 		call_rcu(rcu, bpf_selem_free_rcu);
 }
 
+void bpf_selem_free(struct bpf_local_storage_elem *selem,
+		    struct bpf_local_storage_map *smap,
+		    bool reuse_now)
+{
+	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+	if (!reuse_now)
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
+	else
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+}
+
 /* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
@@ -175,11 +186,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	if (!reuse_now)
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
-	else
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+	bpf_selem_free(selem, smap, reuse_now);
 
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
@@ -423,7 +430,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			kfree(selem);
+			bpf_selem_free(selem, smap, true);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -517,7 +524,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	if (selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		kfree(selem);
+		bpf_selem_free(selem, smap, true);
 	}
 	return ERR_PTR(err);
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a5f185b8e50a..24c3dc0d62e5 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -197,7 +197,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
-				kfree(copy_selem);
+				bpf_selem_free(copy_selem, smap, true);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
-- 
2.34.1

