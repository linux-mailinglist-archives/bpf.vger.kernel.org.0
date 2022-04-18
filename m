Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D00505B22
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiDRPfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbiDRPfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 11:35:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF62DA8C
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 07:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F1C4B80EE2
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 14:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AAAC385A1;
        Mon, 18 Apr 2022 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650293531;
        bh=++3Rrqwj1Hv7Gtlz8RRsVJ+MtuONQCQizPPHa+mFSok=;
        h=From:To:Cc:Subject:Date:From;
        b=AIkfC6HXpNj9DcJWs7XWAshefk5C6vSR4zHSVlzSPEmkfKz8vIF9blDrcO8oItNdh
         sOugImj9pn/PmRqEFArSCKnwq/N0htghXniaWahFAzCTrfJcvTQN6eLWM9oAY08s5V
         cpxkMZ6LcbWOyGfM4fCaVw9zIG8Jsjtwpa/F2vjHfISSTkg2omjL1bahS2W+xNUhKs
         B+BQc6XbDLKAAYd6mciFwII/yfDuq9shIUupnLWK9cvULd1V+eI1Nzykl3fGiCv6Ol
         gintwGer530oL0NAswidclR63KoQiXCvIX8cZyTJS69sW1WWSt1FPft0tTSDUDnCw8
         8cU5qRQwx+Gug==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH bpf-next] bpf: Fix usage of trace RCU in local storage.
Date:   Mon, 18 Apr 2022 14:52:02 +0000
Message-Id: <20220418145202.2855726-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_{sk,task,inode}_storage_free() do not need to use
call_rcu_tasks_trace as no BPF program should be accessing the owner
as it's being destroyed. The only other reader at this point is
bpf_local_storage_map_free() which uses normal RCU.

The only path that needs trace RCU are:

* bpf_local_storage_{delete,update} helpers
* map_{delete,update}_elem() syscalls

Fixes: 8553c67b1b54 ("bpf: Reduce usage of trace RCU in local storage.")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf_local_storage.h |  4 ++--
 kernel/bpf/bpf_inode_storage.c    |  4 ++--
 kernel/bpf/bpf_local_storage.c    | 29 +++++++++++++++++++----------
 kernel/bpf/bpf_task_storage.c     |  4 ++--
 net/core/bpf_sk_storage.c         |  6 +++---
 5 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 493e63258497..7ea18d4da84b 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -143,9 +143,9 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_omem);
+				     bool uncharge_omem, bool use_trace_rcu);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu);
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 96be8d518885..10424a1cda51 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -90,7 +90,7 @@ void bpf_inode_storage_free(struct inode *inode)
 		 */
 		bpf_selem_unlink_map(selem);
 		free_inode_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false);
+			local_storage, selem, false, false);
 	}
 	raw_spin_unlock_bh(&local_storage->lock);
 	rcu_read_unlock();
@@ -149,7 +149,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata));
+	bpf_selem_unlink(SELEM(sdata), true);
 
 	return 0;
 }
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 01aa2b51ec4d..8ce40fd869f6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -106,7 +106,7 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
  */
 bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_mem)
+				     bool uncharge_mem, bool use_trace_rcu)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -150,11 +150,16 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+	if (use_trace_rcu)
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+	else
+		kfree_rcu(selem, rcu);
+
 	return free_local_storage;
 }
 
-static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
+static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
+				       bool use_trace_rcu)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -169,12 +174,16 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true);
+			local_storage, selem, true, use_trace_rcu);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	if (free_local_storage)
-		call_rcu_tasks_trace(&local_storage->rcu,
+	if (free_local_storage) {
+		if (use_trace_rcu)
+			call_rcu_tasks_trace(&local_storage->rcu,
 				     bpf_local_storage_free_rcu);
+		else
+			kfree_rcu(local_storage, rcu);
+	}
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -214,14 +223,14 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
 {
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
 	 * the local_storage.
 	 */
 	bpf_selem_unlink_map(selem);
-	__bpf_selem_unlink_storage(selem);
+	__bpf_selem_unlink_storage(selem, use_trace_rcu);
 }
 
 struct bpf_local_storage_data *
@@ -466,7 +475,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						false);
+						false, true);
 	}
 
 unlock:
@@ -548,7 +557,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 				migrate_disable();
 				__this_cpu_inc(*busy_counter);
 			}
-			bpf_selem_unlink(selem);
+			bpf_selem_unlink(selem, false);
 			if (busy_counter) {
 				__this_cpu_dec(*busy_counter);
 				migrate_enable();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6638a0ecc3d2..57904263a710 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -102,7 +102,7 @@ void bpf_task_storage_free(struct task_struct *task)
 		 */
 		bpf_selem_unlink_map(selem);
 		free_task_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false);
+			local_storage, selem, false, false);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_task_storage_unlock();
@@ -192,7 +192,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata));
+	bpf_selem_unlink(SELEM(sdata), true);
 
 	return 0;
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e3ac36380520..83d7641ef67b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,7 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata));
+	bpf_selem_unlink(SELEM(sdata), true);
 
 	return 0;
 }
@@ -75,8 +75,8 @@ void bpf_sk_storage_free(struct sock *sk)
 		 * sk_storage.
 		 */
 		bpf_selem_unlink_map(selem);
-		free_sk_storage = bpf_selem_unlink_storage_nolock(sk_storage,
-								  selem, true);
+		free_sk_storage = bpf_selem_unlink_storage_nolock(
+			sk_storage, selem, true, false);
 	}
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
-- 
2.36.0.rc0.470.gd361397f0d-goog

