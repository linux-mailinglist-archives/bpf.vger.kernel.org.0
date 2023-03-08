Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEED36AFF35
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCHHAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCHHAC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:02 -0500
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF6A1FC4
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:00 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DSOiTnA3mrGiWDf17Zn5OcRlMFJvKEy0MTw+dNgtvs=;
        b=GJK/g/fgyyP/JXX0cj3jkcPhvdfQfX7OrF8yV9vVOljnF6cmpfCYCkCBifDGOg6YU1nYxe
        eAoX92+GU57bW9g1j6fHxamrG12E2IPe4hVpmwCypyu5ZrAwtnnZFyOUNdXR8h9qFJ+D3Z
        hVY8TrUyEuRc6DCKtNstpbUFcAJDdd0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 01/17] bpf: Move a few bpf_local_storage functions to static scope
Date:   Tue,  7 Mar 2023 22:59:20 -0800
Message-Id: <20230308065936.1550103-2-martin.lau@linux.dev>
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

This patch moves the bpf_local_storage_free_rcu() and
bpf_selem_unlink_map() to static because they are
not used outside of bpf_local_storage.c.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h | 3 ---
 kernel/bpf/bpf_local_storage.c    | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index d934248b8e81..502ad7093f13 100644
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
@@ -163,7 +161,6 @@ struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags, gfp_t gfp_flags);
 
-void bpf_local_storage_free_rcu(struct rcu_head *rcu);
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d3ba3f2db640..1904a4245ebe 100644
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
2.34.1

