Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55C63D05D
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiK3IXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiK3IXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:43 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E275CD20;
        Wed, 30 Nov 2022 00:23:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so15373680pgf.7;
        Wed, 30 Nov 2022 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07zmtYwtZNHOeI0n4lVsdVba4Oqv1PX4InXOLTY/bBE=;
        b=J44k0xFxvr3pbIt2/0+Dhckp3Yq5cPLDBa9WgYLjhNVHUxkt1cMmipofxaglV+YHyr
         DDMh3rOhxcK9n4xVLsLz/UIDCdGKpw6QjIbXXj/eof3wAdmOxlURJTP34vLoYIyeXApR
         Z/VBSuaKv/oDGxvBJ/W6EyzgGuk3QVMZ7MPaTRaAu2MbmRw+Tlhbx4G1qDV66xjPUOlS
         stsYqEO7hOHJUEPaALhk+kxKppdXtzaNExPenwCHoGtFGUEgkRU/4op7LugP53ND8YBp
         IzTQ56+BTSFadSHKSuD3pOndeemQlksi7I/OByOQdM40VFN7fmiqk0RaoL/M1kvK11wR
         VMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07zmtYwtZNHOeI0n4lVsdVba4Oqv1PX4InXOLTY/bBE=;
        b=IO/OhCxYDeHWSc1ABlU/cG67w9kMNVG9VThsvX0pIC6mvCEqmfOjH59m5iRWdjXlwS
         3RGpJ7y9e9Osx1mOyklqh6SGhpTcmB0li7nrrvKoDf2GUnLtwNzE7VPMJO9hRKC12aaF
         NXyXD6YcIuP4mUCH7if8CCD+qvkDd3f/T517scMPRX48XpcB9qmswP5dmAoBNw7tJuHq
         be+ZCqW026Ixk8TgQAhYsf5Qly9KL/TAvjJ5iEHrGXh202PZ123JbmXhXoZfoJ+79Gy9
         TAsbJtqib2CW5BuS8oUwHJRYvkxyN3/FIVPcNEOpiMP/U6awFge8H5ALkIJZflCTIc5P
         4z6g==
X-Gm-Message-State: ANoB5plzUyo2kbGq5a8DG55XhaI3ApHxAqeb4sEo2ADhIceiLZ7ZZs7F
        GMOQxCA8Z+oV6rH1tmprfCc=
X-Google-Smtp-Source: AA0mqf4ZGiPXyblarl8VUJWZ2zKl8vFsW0DkgV3YCcylRX9sizJiI5IpJ4q3MTh4W/5a06oTVYpa0Q==
X-Received: by 2002:a63:d48:0:b0:474:6739:6a09 with SMTP id 8-20020a630d48000000b0047467396a09mr43063850pgn.292.1669796620340;
        Wed, 30 Nov 2022 00:23:40 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id 4-20020a621404000000b005743cdde1b8sm795302pfu.127.2022.11.30.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/31] rhashtable: Allow rhashtable to be used from irq-safe contexts
Date:   Tue, 29 Nov 2022 22:22:43 -1000
Message-Id: <20221130082313.3241517-2-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/rhashtable.h | 51 ++++++++++++++++++++++----------------
 lib/rhashtable.c           | 16 +++++++-----
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 68dab3e08aad..785fba3464f2 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -324,28 +324,31 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
  */
 
 static inline void rht_lock(struct bucket_table *tbl,
-			    struct rhash_lock_head __rcu **bkt)
+			    struct rhash_lock_head __rcu **bkt,
+			    unsigned long *flags)
 {
-	local_bh_disable();
+	local_irq_save(*flags);
 	bit_spin_lock(0, (unsigned long *)bkt);
 	lock_map_acquire(&tbl->dep_map);
 }
 
 static inline void rht_lock_nested(struct bucket_table *tbl,
 				   struct rhash_lock_head __rcu **bucket,
-				   unsigned int subclass)
+				   unsigned int subclass,
+				   unsigned long *flags)
 {
-	local_bh_disable();
+	local_irq_save(*flags);
 	bit_spin_lock(0, (unsigned long *)bucket);
 	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
 
 static inline void rht_unlock(struct bucket_table *tbl,
-			      struct rhash_lock_head __rcu **bkt)
+			      struct rhash_lock_head __rcu **bkt,
+			      unsigned long *flags)
 {
 	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(0, (unsigned long *)bkt);
-	local_bh_enable();
+	local_irq_restore(*flags);
 }
 
 static inline struct rhash_head *__rht_ptr(
@@ -393,7 +396,8 @@ static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
 
 static inline void rht_assign_unlock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt,
-				     struct rhash_head *obj)
+				     struct rhash_head *obj,
+				     unsigned long *flags)
 {
 	if (rht_is_a_nulls(obj))
 		obj = NULL;
@@ -401,7 +405,7 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 	rcu_assign_pointer(*bkt, (void *)obj);
 	preempt_enable();
 	__release(bitlock);
-	local_bh_enable();
+	local_irq_restore(*flags);
 }
 
 /**
@@ -706,6 +710,7 @@ static inline void *__rhashtable_insert_fast(
 	struct rhash_head __rcu **pprev;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
+	unsigned long flags;
 	unsigned int hash;
 	int elasticity;
 	void *data;
@@ -720,11 +725,11 @@ static inline void *__rhashtable_insert_fast(
 	if (!bkt)
 		goto out;
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	rht_lock(tbl, bkt, &flags);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		rht_unlock(tbl, bkt);
+		rht_unlock(tbl, bkt, &flags);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -756,9 +761,9 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->rhead.next, head);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, &flags);
 		} else
-			rht_assign_unlock(tbl, bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj, &flags);
 		data = NULL;
 		goto out;
 	}
@@ -785,7 +790,7 @@ static inline void *__rhashtable_insert_fast(
 	}
 
 	atomic_inc(&ht->nelems);
-	rht_assign_unlock(tbl, bkt, obj);
+	rht_assign_unlock(tbl, bkt, obj, &flags);
 
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
@@ -797,7 +802,7 @@ static inline void *__rhashtable_insert_fast(
 	return data;
 
 out_unlock:
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, &flags);
 	goto out;
 }
 
@@ -991,6 +996,7 @@ static inline int __rhashtable_remove_fast_one(
 	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
+	unsigned long flags;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -999,7 +1005,7 @@ static inline int __rhashtable_remove_fast_one(
 	if (!bkt)
 		return -ENOENT;
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	rht_lock(tbl, bkt, &flags);
 
 	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
@@ -1043,14 +1049,14 @@ static inline int __rhashtable_remove_fast_one(
 
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, &flags);
 		} else {
-			rht_assign_unlock(tbl, bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj, &flags);
 		}
 		goto unlocked;
 	}
 
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, &flags);
 unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
@@ -1143,6 +1149,7 @@ static inline int __rhashtable_replace_fast(
 	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
+	unsigned long flags;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -1158,7 +1165,7 @@ static inline int __rhashtable_replace_fast(
 		return -ENOENT;
 
 	pprev = NULL;
-	rht_lock(tbl, bkt);
+	rht_lock(tbl, bkt, &flags);
 
 	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		if (he != obj_old) {
@@ -1169,15 +1176,15 @@ static inline int __rhashtable_replace_fast(
 		rcu_assign_pointer(obj_new->next, obj_old->next);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj_new);
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, &flags);
 		} else {
-			rht_assign_unlock(tbl, bkt, obj_new);
+			rht_assign_unlock(tbl, bkt, obj_new, &flags);
 		}
 		err = 0;
 		goto unlocked;
 	}
 
-	rht_unlock(tbl, bkt);
+	rht_unlock(tbl, bkt, &flags);
 
 unlocked:
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index e12bbfb240b8..9781572b2f31 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -231,6 +231,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 	struct rhash_head *head, *next, *entry;
 	struct rhash_head __rcu **pprev = NULL;
 	unsigned int new_hash;
+	unsigned long flags;
 
 	if (new_tbl->nest)
 		goto out;
@@ -253,13 +254,14 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash], SINGLE_DEPTH_NESTING);
+	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash],
+			SINGLE_DEPTH_NESTING, &flags);
 
 	head = rht_ptr(new_tbl->buckets + new_hash, new_tbl, new_hash);
 
 	RCU_INIT_POINTER(entry->next, head);
 
-	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry);
+	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry, &flags);
 
 	if (pprev)
 		rcu_assign_pointer(*pprev, next);
@@ -276,18 +278,19 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct rhash_lock_head __rcu **bkt = rht_bucket_var(old_tbl, old_hash);
+	unsigned long flags;
 	int err;
 
 	if (!bkt)
 		return 0;
-	rht_lock(old_tbl, bkt);
+	rht_lock(old_tbl, bkt, &flags);
 
 	while (!(err = rhashtable_rehash_one(ht, bkt, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-	rht_unlock(old_tbl, bkt);
+	rht_unlock(old_tbl, bkt, &flags);
 
 	return err;
 }
@@ -590,6 +593,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
 	struct rhash_lock_head __rcu **bkt;
+	unsigned long flags;
 	unsigned int hash;
 	void *data;
 
@@ -607,7 +611,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
-			rht_lock(tbl, bkt);
+			rht_lock(tbl, bkt, &flags);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
@@ -615,7 +619,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
-			rht_unlock(tbl, bkt);
+			rht_unlock(tbl, bkt, &flags);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
-- 
2.38.1

