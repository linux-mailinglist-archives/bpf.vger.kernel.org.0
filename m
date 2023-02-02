Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A991688022
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjBBO3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 09:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBBO3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 09:29:39 -0500
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 06:29:37 PST
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE65B98
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 06:29:37 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4P71BK5CrJzvjfm; Thu,  2 Feb 2023 15:19:21 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next] bpf: Drop always true do_idr_lock parameter to bpf_map_free_id
Date:   Thu,  2 Feb 2023 15:19:21 +0100
Message-Id: <20230202141921.4424-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The do_idr_lock parameter to bpf_map_free_id was introduced by commit
bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID"). However, all callers set
do_idr_lock = true since commit 1e0bd5a091e5 ("bpf: Switch bpf_map ref
counter to atomic64_t so bpf_map_inc() never fails").

While at it also inline __bpf_map_put into its only caller bpf_map_put
now that do_idr_lock can be dropped from its signature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/bpf.h  |  2 +-
 kernel/bpf/offload.c |  2 +-
 kernel/bpf/syscall.c | 23 ++++++-----------------
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e11db75094d0..35c18a98c21a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1846,7 +1846,7 @@ struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
 void bpf_prog_free_id(struct bpf_prog *prog);
-void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
+void bpf_map_free_id(struct bpf_map *map);
 
 struct btf_field *btf_record_find(const struct btf_record *rec,
 				  u32 offset, enum btf_field_type type);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 88aae38fde66..0c85e06f7ea7 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -136,7 +136,7 @@ static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
 {
 	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
 	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
-	bpf_map_free_id(&offmap->map, true);
+	bpf_map_free_id(&offmap->map);
 	list_del_init(&offmap->offloads);
 	offmap->netdev = NULL;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 99417b387547..bcc97613de76 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -390,7 +390,7 @@ static int bpf_map_alloc_id(struct bpf_map *map)
 	return id > 0 ? 0 : id;
 }
 
-void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
+void bpf_map_free_id(struct bpf_map *map)
 {
 	unsigned long flags;
 
@@ -402,18 +402,12 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
 	if (!map->id)
 		return;
 
-	if (do_idr_lock)
-		spin_lock_irqsave(&map_idr_lock, flags);
-	else
-		__acquire(&map_idr_lock);
+	spin_lock_irqsave(&map_idr_lock, flags);
 
 	idr_remove(&map_idr, map->id);
 	map->id = 0;
 
-	if (do_idr_lock)
-		spin_unlock_irqrestore(&map_idr_lock, flags);
-	else
-		__release(&map_idr_lock);
+	spin_unlock_irqrestore(&map_idr_lock, flags);
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -706,13 +700,13 @@ static void bpf_map_put_uref(struct bpf_map *map)
 }
 
 /* decrement map refcnt and schedule it for freeing via workqueue
- * (unrelying map implementation ops->map_free() might sleep)
+ * (underlying map implementation ops->map_free() might sleep)
  */
-static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
+void bpf_map_put(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->refcnt)) {
 		/* bpf_map_free_id() must be called first */
-		bpf_map_free_id(map, do_idr_lock);
+		bpf_map_free_id(map);
 		btf_put(map->btf);
 		INIT_WORK(&map->work, bpf_map_free_deferred);
 		/* Avoid spawning kworkers, since they all might contend
@@ -721,11 +715,6 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 		queue_work(system_unbound_wq, &map->work);
 	}
 }
-
-void bpf_map_put(struct bpf_map *map)
-{
-	__bpf_map_put(map, true);
-}
 EXPORT_SYMBOL_GPL(bpf_map_put);
 
 void bpf_map_put_with_uref(struct bpf_map *map)
-- 
2.39.1

