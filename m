Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C137644E04
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 22:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLFVgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 16:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFVgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 16:36:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109D23FBAF;
        Tue,  6 Dec 2022 13:36:35 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q1so14522494pgl.11;
        Tue, 06 Dec 2022 13:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2p4x2vIby7A9eaD3zNIzVP+hr830/5uXFRGUzHINijI=;
        b=EHUjUw32n9qOiPFWZ0ZRqZtjGwfEp8OVqrGW0Fw/QK3WLDCbIY9OUq5oHhm6QL4C8w
         N88EMtSHZwOJ44Cz1OnnzmovCpVjQ51XywjKQrFGtWb0nC8g4dDqMQABOHvdSeVuMdUK
         eHglKWzBZunfgUYQkJpvvkvzbogiTo3M3hMOvlcfdz4RcgmeOJyrMAMq7fydzR/qPwSD
         O/agmUHzfuZjixNYLEJ2tA0Z+Mrfs1yFBVe/WVj4rExHWdWlNz1AwQCkHJ3raEW9a1J3
         K4XfSzXz3bVgywxjKmqGVCT/SuafKbQ5DLc9FKbXCyCETNydBBTnGYr4xIQqGbmKd9kX
         Uppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p4x2vIby7A9eaD3zNIzVP+hr830/5uXFRGUzHINijI=;
        b=Head/IftSL4ib0kDbLfo7YbmXtY9GwxKTccGY22FHB0p60cLKmDDhsVGznVLpxZww2
         JxwcWuEgV6vTII0JTrh53QMUh3hJ29engYZgoEuucZ34geywuDO8c2xfIQ/Z8OAvg5c1
         LIXxGqPvaj9p075Zl3wts0/Sy7urtVKpH5YVuesp8PI+ZSpzMkPhYmyPbFCCD2TxuCTu
         h9ixm/WBjyDROfXNXabT0K4XP8V6bou7j9bED0cB90/uKArz4QsoD1DWq1KliQ8WoEMi
         NV10mEBXUCpU1gPl0tpSRJKJohgq439XxkN12XFhZfctacCDx/VVa6b6nUwP5vfSDtr+
         8Xuw==
X-Gm-Message-State: ANoB5pmqjVlQox6XZ4TUscgL0wg3dEH8lbvOj53CfLkPNcspyYwcyQn3
        4XN+LqxqB+MMdcenwO9xXVs=
X-Google-Smtp-Source: AA0mqf4KqKqUkeqbVZfn8dTKRpbcqh07HkGw+dC+2LZsG0300eaCPNzBb/t9qIhQe5A53E/JuxixaA==
X-Received: by 2002:a63:fb11:0:b0:478:e97b:7a1 with SMTP id o17-20020a63fb11000000b00478e97b07a1mr2600376pgh.113.1670362594208;
        Tue, 06 Dec 2022 13:36:34 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:841a])
        by smtp.gmail.com with ESMTPSA id a23-20020a63e417000000b00476c9df11fesm10198488pgi.68.2022.12.06.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:36:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Dec 2022 11:36:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v2 01/31] rhashtable: Allow rhashtable to be used from
 irq-safe contexts
Message-ID: <Y4+14IFcWXNcLBE7@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-2-tj@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

rhashtable currently only does bh-safe synchronization making it impossible
to use from irq-safe contexts. Switch it to use irq-safe synchronization to
remove the restriction.

v2: Update the lock functions to return the ulong flags value and unlock
    functions to take the value directly instead of passing around the
    pointer. Suggested by Linus.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/rhashtable.h |   61 ++++++++++++++++++++++++++-------------------
 lib/rhashtable.c           |   16 +++++++----
 2 files changed, 46 insertions(+), 31 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -323,29 +323,36 @@ static inline struct rhash_lock_head __r
  * When we write to a bucket without unlocking, we use rht_assign_locked().
  */
 
-static inline void rht_lock(struct bucket_table *tbl,
-			    struct rhash_lock_head __rcu **bkt)
+static inline unsigned long rht_lock(struct bucket_table *tbl,
+				     struct rhash_lock_head __rcu **bkt)
 {
-	local_bh_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	bit_spin_lock(0, (unsigned long *)bkt);
 	lock_map_acquire(&tbl->dep_map);
+	return flags;
 }
 
-static inline void rht_lock_nested(struct bucket_table *tbl,
-				   struct rhash_lock_head __rcu **bucket,
-				   unsigned int subclass)
+static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
+					struct rhash_lock_head __rcu **bucket,
+					unsigned int subclass)
 {
-	local_bh_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	bit_spin_lock(0, (unsigned long *)bucket);
 	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
+	return flags;
 }
 
 static inline void rht_unlock(struct bucket_table *tbl,
-			      struct rhash_lock_head __rcu **bkt)
+			      struct rhash_lock_head __rcu **bkt,
+			      unsigned long flags)
 {
 	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(0, (unsigned long *)bkt);
-	local_bh_enable();
+	local_irq_restore(flags);
 }
 
 static inline struct rhash_head *__rht_ptr(
@@ -393,7 +400,8 @@ static inline void rht_assign_locked(str
 
 static inline void rht_assign_unlock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt,
-				     struct rhash_head *obj)
+				     struct rhash_head *obj,
+				     unsigned long flags)
 {
 	if (rht_is_a_nulls(obj))
 		obj = NULL;
@@ -401,7 +409,7 @@ static inline void rht_assign_unlock(str
 	rcu_assign_pointer(*bkt, (void *)obj);
 	preempt_enable();
 	__release(bitlock);
-	local_bh_enable();
+	local_irq_restore(flags);
 }
 
 /**
@@ -706,6 +714,7 @@ static inline void *__rhashtable_insert_
 	struct rhash_head __rcu **pprev;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
+	unsigned long flags;
 	unsigned int hash;
 	int elasticity;
 	void *data;
@@ -720,11 +729,11 @@ static inline void *__rhashtable_insert_
 	if (!bkt)
 		goto out;
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	flags = rht_lock(tbl, bkt);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		rht_unlock(tbl, bkt);
+		rht_unlock(tbl, bkt, flags);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -756,9 +765,9 @@ slow_path:
 		RCU_INIT_POINTER(list->rhead.next, head);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, flags);
 		} else
-			rht_assign_unlock(tbl, bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj, flags);
 		data = NULL;
 		goto out;
 	}
@@ -785,7 +794,7 @@ slow_path:
 	}
 
 	atomic_inc(&ht->nelems);
-	rht_assign_unlock(tbl, bkt, obj);
+	rht_assign_unlock(tbl, bkt, obj, flags);
 
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
@@ -797,7 +806,7 @@ out:
 	return data;
 
 out_unlock:
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, flags);
 	goto out;
 }
 
@@ -991,6 +1000,7 @@ static inline int __rhashtable_remove_fa
 	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
+	unsigned long flags;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -999,7 +1009,7 @@ static inline int __rhashtable_remove_fa
 	if (!bkt)
 		return -ENOENT;
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	flags = rht_lock(tbl, bkt);
 
 	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
@@ -1043,14 +1053,14 @@ static inline int __rhashtable_remove_fa
 
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, flags);
 		} else {
-			rht_assign_unlock(tbl, bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj, flags);
 		}
 		goto unlocked;
 	}
 
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, flags);
 unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
@@ -1143,6 +1153,7 @@ static inline int __rhashtable_replace_f
 	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
+	unsigned long flags;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -1158,7 +1169,7 @@ static inline int __rhashtable_replace_f
 		return -ENOENT;
 
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	flags = rht_lock(tbl, bkt);
 
 	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		if (he != obj_old) {
@@ -1169,15 +1180,15 @@ static inline int __rhashtable_replace_f
 		rcu_assign_pointer(obj_new->next, obj_old->next);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj_new);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, flags);
 		} else {
-			rht_assign_unlock(tbl, bkt, obj_new);
+			rht_assign_unlock(tbl, bkt, obj_new, flags);
 		}
 		err = 0;
 		goto unlocked;
 	}
 
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, flags);
 
 unlocked:
 	return err;
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -231,6 +231,7 @@ static int rhashtable_rehash_one(struct
 	struct rhash_head *head, *next, *entry;
 	struct rhash_head __rcu **pprev = NULL;
 	unsigned int new_hash;
+	unsigned long flags;
 
 	if (new_tbl->nest)
 		goto out;
@@ -253,13 +254,14 @@ static int rhashtable_rehash_one(struct
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash], SINGLE_DEPTH_NESTING);
+	flags = rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash],
+				SINGLE_DEPTH_NESTING);
 
 	head = rht_ptr(new_tbl->buckets + new_hash, new_tbl, new_hash);
 
 	RCU_INIT_POINTER(entry->next, head);
 
-	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry);
+	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry, flags);
 
 	if (pprev)
 		rcu_assign_pointer(*pprev, next);
@@ -276,18 +278,19 @@ static int rhashtable_rehash_chain(struc
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct rhash_lock_head __rcu **bkt = rht_bucket_var(old_tbl, old_hash);
+	unsigned long flags;
 	int err;
 
 	if (!bkt)
 		return 0;
-	rht_lock(old_tbl, bkt);
+	flags = rht_lock(old_tbl, bkt);
 
 	while (!(err = rhashtable_rehash_one(ht, bkt, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-	rht_unlock(old_tbl, bkt);
+	rht_unlock(old_tbl, bkt, flags);
 
 	return err;
 }
@@ -590,6 +593,7 @@ static void *rhashtable_try_insert(struc
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
 	struct rhash_lock_head __rcu **bkt;
+	unsigned long flags;
 	unsigned int hash;
 	void *data;
 
@@ -607,7 +611,7 @@ static void *rhashtable_try_insert(struc
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
-			rht_lock(tbl, bkt);
+			flags = rht_lock(tbl, bkt);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
@@ -615,7 +619,7 @@ static void *rhashtable_try_insert(struc
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, flags);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
