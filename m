Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BB6AB898
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCFImj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCFImh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:37 -0500
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC0321299
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:42:36 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFyAArbNVcnMNQbb+W1aPE9Iuq3XKYyouulyG+SmakQ=;
        b=aSFlOQRGDVuUbFfM9Otwxnr7XbbgRjbUW7Th8MGkPNpBk1MLVn+UBmwQVgvFIcYGf+EK4l
        /x1zpGqfOHc1VdKgpSPRddeZH1UB1R9dTAG4Hf6v/X7H/uX+1FKNQEzLHv6OQ/Tj1Ibf1A
        RPYu+qOR8VRhytvHpmzh1WBCRJgXxWs=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 01/16] bpf: Move a few bpf_local_storage functions to static scope
Date:   Mon,  6 Mar 2023 00:42:01 -0800
Message-Id: <20230306084216.3186830-2-martin.lau@linux.dev>
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

This patch moves the bpf_local_storage_free_rcu() and
bpf_selem_unlink_map() to static because they are
not used outside of bpf_local_storage.c.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h | 4 ----
 kernel/bpf/bpf_local_storage.c    | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6d37a40cd90e..6917c9a408a1 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -147,8 +147,6 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu);
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
-
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 		bool charge_mem, gfp_t gfp_flags);
@@ -163,6 +161,4 @@ struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags, gfp_t gfp_flags);
 
-void bpf_local_storage_free_rcu(struct rcu_head *rcu);
-
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3d320393a12c..0510f50bd3ea 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -95,7 +95,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
-void bpf_local_storage_free_rcu(struct rcu_head *rcu)
+static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
@@ -251,7 +251,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
-- 
2.30.2

