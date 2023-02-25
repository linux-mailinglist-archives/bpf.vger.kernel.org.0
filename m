Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA06A2A87
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBYPkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 10:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 10:40:19 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B013D60
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:17 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id ee7so8937548edb.2
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26YHYGhzhMtvy0wI74hWTknpqfsq9gjq9pZ+N8DJ2Ds=;
        b=qUXlqj7ghgBg+s9E4FVdYsvMop3Z+SVqgbaKEXq4WWoepdpVWhqppEehKC+xXv97D7
         OvLnOVQLttk0T+5PmXrUcwx+VSmu5Vp7+ThVb0Y4HkBk9vopiAI0pGS3hx+FXWz9wE5G
         tWrM1j9ClBAXY5gvY37evf3zWLmV06vFBuAcD+9YZoGLMiuy2a1vEh8CRD9/s19ggDUG
         RMz7ldWkcmzmO9wLti1pfIFoaOB1hewmLT5lYtaRt9ShdGAgYvEzRUZiN2x6d/vzQ3xu
         JDYdn3we8O7bvPIrgpzsPxuqVZPnyIr8uLPGzhJVqIl8n/BddFZhjeVt5xUaDlUWTc96
         zHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26YHYGhzhMtvy0wI74hWTknpqfsq9gjq9pZ+N8DJ2Ds=;
        b=cREZXN9udq9DzJ+BZKKqAO5xN6RvbCwUrfJn74SGYIZ8EiHjRJ9KiH6E0HN3rKOAS/
         88roQcEjPEnEhJ0X2UtwBDlouuObJRC7RZUqj/OpFIPpj+Xr8oicCsx/G4cYQKTAAiZc
         00YXdauqn03hZG601mGFZJxSl18ELACt5uUUaXULBqiG7VHCtGVnWnzuaYjscnRQsJs3
         mwjqErVqKmTop3nR+uKTrMlGdwiAYgO/Od7oW5GQGG7QQOZLa1laM1By+MIDmbnR2Q3B
         7hVCN0DRj4VFhMJpEFKGF+x5uainrF5ZLPflGz4ouk6fw2mtVXJLXzdDc8UXkjIpO11g
         n8GA==
X-Gm-Message-State: AO0yUKX0FxuGO7emJ1dXysLjb5V13Q8tJ+0d+hPdR39toZe05964f8t6
        Vl4CaC3adE93wRqrQ98cKNVqXE3ku/7VNA==
X-Google-Smtp-Source: AK7set9qGorhHHREy9Q8H7O2MKbnf1N/CvAyqz92UTf0A0gqb7q79VVvd/RseuPv9gC+Wpq8yTqrVQ==
X-Received: by 2002:a50:fb06:0:b0:4ac:be42:5c66 with SMTP id d6-20020a50fb06000000b004acbe425c66mr18859305edq.11.1677339615879;
        Sat, 25 Feb 2023 07:40:15 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:30])
        by smtp.gmail.com with ESMTPSA id b27-20020a50ccdb000000b004aef48a8af7sm978157edj.50.2023.02.25.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:40:15 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
Date:   Sat, 25 Feb 2023 16:40:09 +0100
Message-Id: <20230225154010.391965-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225154010.391965-1-memxor@gmail.com>
References: <20230225154010.391965-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7787; i=memxor@gmail.com; h=from:subject; bh=6rZNexUWA0MowrydGJmFUaPGZ3AMN2NlSiMGW5GBv78=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj+itKpBjzsEWVZYBmRHUQ97KSGShtIJY38quT1RMm tZwLmeSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/orSgAKCRBM4MiGSL8RymNjD/ 9J4FY7YaSLxzJfXeN++OQFb7PoCuI/Um967R0gUkXs0D51NhBOKPS9Kd3ZN8lV4umTRENQ27ZtUFrf /cdnFxlca87HpyoOdtuGmKtGBcE0NqMG27UY8fQyvlADtD5+uVSwZzuHDMc/c1LuQtB3slDFfCFVx6 kXin8R7e25SncD4Xvnz7XthU1UiUSWU+Gx3UcvTrZKZGMOxMwkiQyjqFCBAWHlZRjiofzdIzM5d6cF 47YJ1F7ZI5y54dBcYHoS2Ny0/9TTfpwfe+NqXetqUlQJtofbCmIlq3BUuEvGa969dWbW5XC3DlS778 SIbIN4ajvE8DaadkevhlRUI8hG36LOf98DQ/Y75cWjn7A/01xlo2W8/tpfBhkAalxI9Wtl3ibZq67H f+vqS4K5dWgP4D8UzD/TIQ3ShvoPxMISO+vHgWGVbTkyVnAQDMBGzOFoTpgwxug4Dfc6g2+hxKPLZS 6K1hz5ukwzCl4ixBFIba/eDf1fTSszGGZJp2ibuAF9gxHWZ7bC9gqE7m1gPpZcOCemAjrgeeMKeiNs OiiCjczSvizSoa8uBlfDYGQX2tO/0nvmwKAxR2EyZcGoObnqWe3xOlfN/C/CWK/d9HLCQQV04Wz/m5 h32DkUjpZwL3G29fzL6tbQh4yu8XDjpLOtHsPTdG7NDN+NbLAGUwpAgZuOlA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable support for kptrs in local storage maps by wiring up the freeing
of these kptrs from map value. Freeing of bpf_local_storage_map is only
delayed in case there are special fields, therefore bpf_selem_free_*
path can also only dereference smap safely in that case. This is
recorded using a bool utilizing a hole in bpF_local_storage_elem. It
could have been tagged in the pointer value smap using the lowest bit
(since alignment > 1), but since there was already a hole I went with
the simpler option. Only the map structure freeing is delayed using RCU
barriers, as the buckets aren't used when selem is being freed, so they
can be freed once all readers of the bucket lists can no longer access
it.

Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_local_storage.h |  6 ++++
 kernel/bpf/bpf_local_storage.c    | 48 ++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c              |  6 +++-
 kernel/bpf/verifier.c             | 12 +++++---
 4 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6d37a40cd90e..0fe92986412b 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -74,6 +74,12 @@ struct bpf_local_storage_elem {
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
+	bool can_use_smap; /* Is it safe to access smap in bpf_selem_free_* RCU
+			    * callbacks? bpf_local_storage_map_free only
+			    * executes rcu_barrier when there are special
+			    * fields, this field remembers that to ensure we
+			    * don't access already freed smap in sdata.
+			    */
 	/* 8 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 58da17ae5124..2bdd722fe293 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (selem) {
 		if (value)
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
+		/* No need to call check_and_init_map_value as memory is zero init */
 		return selem;
 	}
 
@@ -113,10 +114,25 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	/* The can_use_smap bool is set whenever we need to free additional
+	 * fields in selem data before freeing selem. bpf_local_storage_map_free
+	 * only executes rcu_barrier to wait for RCU callbacks when it has
+	 * special fields, hence we can only conditionally dereference smap, as
+	 * by this time the map might have already been freed without waiting
+	 * for our call_rcu callback if it did not have any special fields.
+	 */
+	if (selem->can_use_smap)
+		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
+	kfree(selem);
+}
+
+static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
+{
+	/* Free directly if Tasks Trace RCU GP also implies RCU GP */
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		bpf_selem_free_rcu(rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(rcu, bpf_selem_free_rcu);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -170,9 +186,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	if (use_trace_rcu)
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
 
 	return free_local_storage;
 }
@@ -240,6 +256,11 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	/* If our data will have special fields, smap will wait for us to use
+	 * its record in bpf_selem_free_* RCU callbacks before freeing itself.
+	 */
+	selem->can_use_smap = !IS_ERR_OR_NULL(smap->map.record);
 }
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
@@ -723,6 +744,25 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
+	/* Only delay freeing of smap, buckets are not needed anymore */
 	kvfree(smap->buckets);
+
+	/* When local storage has special fields, callbacks for
+	 * bpf_selem_free_rcu and bpf_selem_free_tasks_trace_rcu will keep using
+	 * the map BTF record, we need to execute an RCU barrier to wait for
+	 * them as the record will be freed right after our map_free callback.
+	 */
+	if (!IS_ERR_OR_NULL(smap->map.record)) {
+		rcu_barrier_tasks_trace();
+		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
+		 * is true, because while call_rcu invocation is skipped in that
+		 * case in bpf_selem_free_tasks_trace_rcu (and all local storage
+		 * maps pass use_trace_rcu = true), there can be call_rcu
+		 * callbacks based on use_trace_rcu = false in the earlier while
+		 * ((selem = ...)) loop or from bpf_local_storage_unlink_nolock
+		 * called from owner's free path.
+		 */
+		rcu_barrier();
+	}
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index da117a2a83b2..eb50025b03c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1063,7 +1063,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
-				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
+				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
+				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5cb8b623f639..f5e2813e22de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7151,22 +7151,26 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 		if (func_id != BPF_FUNC_sk_storage_get &&
-		    func_id != BPF_FUNC_sk_storage_delete)
+		    func_id != BPF_FUNC_sk_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_INODE_STORAGE:
 		if (func_id != BPF_FUNC_inode_storage_get &&
-		    func_id != BPF_FUNC_inode_storage_delete)
+		    func_id != BPF_FUNC_inode_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_TASK_STORAGE:
 		if (func_id != BPF_FUNC_task_storage_get &&
-		    func_id != BPF_FUNC_task_storage_delete)
+		    func_id != BPF_FUNC_task_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGRP_STORAGE:
 		if (func_id != BPF_FUNC_cgrp_storage_get &&
-		    func_id != BPF_FUNC_cgrp_storage_delete)
+		    func_id != BPF_FUNC_cgrp_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-- 
2.39.2

