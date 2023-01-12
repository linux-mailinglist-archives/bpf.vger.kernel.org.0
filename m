Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6611667A34
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjALQBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjALQAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:52 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB3656D
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:48 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id bp44so16890433qtb.0
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL12hQzfY2vYmbpWyvvoyioaohRiBjaClaYN//mRPYQ=;
        b=FvZrTql4zacpEwvmFGOwf9iV0y/EKQVGFKFf9nq0POhyw8MxgeuS8VG92UdznVgtJV
         4H/D98zVL/EKDRWUVUv/bTaooQENTOj5PpMz29hVWkYQ1ZRPLQnUY0Sd6PEvXnxMvOev
         CeMRpuj/IXWH4Vm8MrrLicNtBXkYMSZtgn4X8EjFb01T/oX9RWsGAhyPBJqs1g7zORKA
         /3WMr8O0TX4mM2Dlnrjcl6ZOmHlUO6+0cXRwaE9beomhlC3WKe/kL9xgoJWOlFRTBqkT
         2f+qA2OwYHqfQ9ANF6cayhBlOmcn6ezYYrkSk1V5VljoG+j79m8UkN5b+XxuanHgZFCt
         XUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL12hQzfY2vYmbpWyvvoyioaohRiBjaClaYN//mRPYQ=;
        b=h2WrJVMQj/+PdnvXFzeI2+pDGzkRe9p7fuOcPiT45maHGJBkWuxCY2zlx7et/ZI2ia
         1jBs1KEIsVEoGJBCKj/etBgPA5c2z+B0KY6qjNGGd5gb7sTi+RQ2KCzxk3eQuXxMdpx2
         Fugjse9/7amcNiKZUFVtGuB9PtEpQ40g4PxjJJHrlumIGl1gVd3iGkjlXmwGQDanvLHM
         wOZeadxPLpURs5IX5voUUSBbbbmrAYuORAW166LmyIEByzZ6knWgZDbOawb1qpoWGOfL
         Si+bRvOxr/3VddH1nUmU7qxHv6i0J5NM3G4Q8WlE8o/F/dji0o6b+cU3xaGQtlI85yKx
         0Tfg==
X-Gm-Message-State: AFqh2kq8m/WGiBQ26oGsrWtar64LEzzEsiZ04ZZdc7BocKvy2GNtxvC+
        p25/2w66e1C1SZfW7ThA2VI=
X-Google-Smtp-Source: AMrXdXsWItcapcAoDWCDnJzKExTlnOFYmnkVbKpZGZioHjBrHENK8zzquTPTX1PHjAt5R5HXxVzEMA==
X-Received: by 2002:ac8:5386:0:b0:3a4:f758:fc6d with SMTP id x6-20020ac85386000000b003a4f758fc6dmr103306816qtp.46.1673538827319;
        Thu, 12 Jan 2023 07:53:47 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:46 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 10/11] bpf: add and use bpf map free helpers
Date:   Thu, 12 Jan 2023 15:53:25 +0000
Message-Id: <20230112155326.26902-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
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

Some new helpers are introduced to free bpf memory, instead of using the
generic free helpers. Then we can do something in these new helpers to
track the free of bpf memory in the future.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            | 19 +++++++++++++++++++
 kernel/bpf/arraymap.c          |  4 ++--
 kernel/bpf/bpf_cgrp_storage.c  |  2 +-
 kernel/bpf/bpf_inode_storage.c |  2 +-
 kernel/bpf/bpf_local_storage.c | 20 ++++++++++----------
 kernel/bpf/bpf_task_storage.c  |  2 +-
 kernel/bpf/cpumap.c            | 13 ++++++-------
 kernel/bpf/devmap.c            | 10 ++++++----
 kernel/bpf/hashtab.c           |  8 ++++----
 kernel/bpf/helpers.c           |  2 +-
 kernel/bpf/local_storage.c     | 12 ++++++------
 kernel/bpf/lpm_trie.c          | 14 +++++++-------
 net/core/bpf_sk_storage.c      |  4 ++--
 net/core/sock_map.c            |  2 +-
 net/xdp/xskmap.c               |  2 +-
 15 files changed, 68 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fb14cc6..17c218e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1869,6 +1869,24 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+
+static inline void bpf_map_kfree(const void *ptr)
+{
+	kfree(ptr);
+}
+
+static inline void bpf_map_kvfree(const void *ptr)
+{
+	kvfree(ptr);
+}
+
+static inline void bpf_map_free_percpu(void __percpu *ptr)
+{
+	free_percpu(ptr);
+}
+
+#define bpf_map_kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+
 #ifdef CONFIG_MEMCG_KMEM
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
@@ -1877,6 +1895,7 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 		       gfp_t flags);
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags);
+
 #else
 static inline void *
 bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e64a417..d218bf0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -24,7 +24,7 @@ static void bpf_array_free_percpu(struct bpf_array *array)
 	int i;
 
 	for (i = 0; i < array->map.max_entries; i++) {
-		free_percpu(array->pptrs[i]);
+		bpf_map_free_percpu(array->pptrs[i]);
 		cond_resched();
 	}
 }
@@ -1132,7 +1132,7 @@ static void prog_array_map_free(struct bpf_map *map)
 		list_del_init(&elem->list);
 		kfree(elem);
 	}
-	kfree(aux);
+	bpf_map_kfree(aux);
 	fd_array_map_free(map);
 }
 
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 6cdf6d9..d0ac4eb 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -64,7 +64,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	rcu_read_unlock();
 
 	if (free_cgroup_storage)
-		kfree_rcu(local_storage, rcu);
+		bpf_map_kfree_rcu(local_storage, rcu);
 }
 
 static struct bpf_local_storage_data *
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 05f4c66..0297f36 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -78,7 +78,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	rcu_read_unlock();
 
 	if (free_inode_storage)
-		kfree_rcu(local_storage, rcu);
+		bpf_map_kfree_rcu(local_storage, rcu);
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 35f4138..2fd79a1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -93,9 +93,9 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 	 */
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
 	if (rcu_trace_implies_rcu_gp())
-		kfree(local_storage);
+		bpf_map_kfree(local_storage);
 	else
-		kfree_rcu(local_storage, rcu);
+		bpf_map_kfree_rcu(local_storage, rcu);
 }
 
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
@@ -104,9 +104,9 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		bpf_map_kfree(selem);
 	else
-		kfree_rcu(selem, rcu);
+		bpf_map_kfree_rcu(selem, rcu);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -162,7 +162,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	if (use_trace_rcu)
 		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
 	else
-		kfree_rcu(selem, rcu);
+		bpf_map_kfree_rcu(selem, rcu);
 
 	return free_local_storage;
 }
@@ -191,7 +191,7 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 			call_rcu_tasks_trace(&local_storage->rcu,
 				     bpf_local_storage_free_rcu);
 		else
-			kfree_rcu(local_storage, rcu);
+			bpf_map_kfree_rcu(local_storage, rcu);
 	}
 }
 
@@ -358,7 +358,7 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	kfree(storage);
+	bpf_map_kfree(storage);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -402,7 +402,7 @@ struct bpf_local_storage_data *
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			kfree(selem);
+			bpf_map_kfree(selem);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -496,7 +496,7 @@ struct bpf_local_storage_data *
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	if (selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		kfree(selem);
+		bpf_map_kfree(selem);
 	}
 	return ERR_PTR(err);
 }
@@ -713,6 +713,6 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	kvfree(smap->buckets);
+	bpf_map_kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1e48605..7287b02 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -91,7 +91,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	rcu_read_unlock();
 
 	if (free_task_storage)
-		kfree_rcu(local_storage, rcu);
+		bpf_map_kfree_rcu(local_storage, rcu);
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index e0b2d01..3470c13 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -164,8 +164,8 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 		/* The queue should be empty at this point */
 		__cpu_map_ring_cleanup(rcpu->queue);
 		ptr_ring_cleanup(rcpu->queue, NULL);
-		kfree(rcpu->queue);
-		kfree(rcpu);
+		bpf_map_kfree(rcpu->queue);
+		bpf_map_kfree(rcpu);
 	}
 }
 
@@ -484,11 +484,11 @@ static int __cpu_map_load_bpf_program(struct bpf_cpu_map_entry *rcpu,
 free_ptr_ring:
 	ptr_ring_cleanup(rcpu->queue, NULL);
 free_queue:
-	kfree(rcpu->queue);
+	bpf_map_kfree(rcpu->queue);
 free_bulkq:
-	free_percpu(rcpu->bulkq);
+	bpf_map_free_percpu(rcpu->bulkq);
 free_rcu:
-	kfree(rcpu);
+	bpf_map_kfree(rcpu);
 	return NULL;
 }
 
@@ -502,8 +502,7 @@ static void __cpu_map_entry_free(struct rcu_head *rcu)
 	 * find this entry.
 	 */
 	rcpu = container_of(rcu, struct bpf_cpu_map_entry, rcu);
-
-	free_percpu(rcpu->bulkq);
+	bpf_map_free_percpu(rcpu->bulkq);
 	/* Cannot kthread_stop() here, last put free rcpu resources */
 	put_cpu_map_entry(rcpu);
 }
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index d01e4c5..be10c47 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -218,7 +218,7 @@ static void dev_map_free(struct bpf_map *map)
 				if (dev->xdp_prog)
 					bpf_prog_put(dev->xdp_prog);
 				dev_put(dev->dev);
-				kfree(dev);
+				bpf_map_kfree(dev);
 			}
 		}
 
@@ -234,7 +234,7 @@ static void dev_map_free(struct bpf_map *map)
 			if (dev->xdp_prog)
 				bpf_prog_put(dev->xdp_prog);
 			dev_put(dev->dev);
-			kfree(dev);
+			bpf_map_kfree(dev);
 		}
 
 		bpf_map_area_free(dtab->netdev_map);
@@ -791,12 +791,14 @@ static void *dev_map_hash_lookup_elem(struct bpf_map *map, void *key)
 static void __dev_map_entry_free(struct rcu_head *rcu)
 {
 	struct bpf_dtab_netdev *dev;
+	struct bpf_dtab *dtab;
 
 	dev = container_of(rcu, struct bpf_dtab_netdev, rcu);
 	if (dev->xdp_prog)
 		bpf_prog_put(dev->xdp_prog);
 	dev_put(dev->dev);
-	kfree(dev);
+	dtab = dev->dtab;
+	bpf_map_kfree(dev);
 }
 
 static int dev_map_delete_elem(struct bpf_map *map, void *key)
@@ -881,7 +883,7 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 err_put_dev:
 	dev_put(dev->dev);
 err_out:
-	kfree(dev);
+	bpf_map_kfree(dev);
 	return ERR_PTR(-EINVAL);
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5aa2b55..1047788 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -266,7 +266,7 @@ static void htab_free_elems(struct bpf_htab *htab)
 
 		pptr = htab_elem_get_ptr(get_htab_elem(htab, i),
 					 htab->map.key_size);
-		free_percpu(pptr);
+		bpf_map_free_percpu(pptr);
 		cond_resched();
 	}
 free_elems:
@@ -584,7 +584,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
-		free_percpu(htab->map_locked[i]);
+		bpf_map_free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
@@ -1511,14 +1511,14 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
-	free_percpu(htab->extra_elems);
+	bpf_map_free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
-		free_percpu(htab->map_locked[i]);
+		bpf_map_free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 458db2d..49b0040 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1383,7 +1383,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
-	kfree(t);
+	bpf_map_kfree(t);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index e90d9f6..ed5cf5b 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -174,7 +174,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 	check_and_init_map_value(map, new->data);
 
 	new = xchg(&storage->buf, new);
-	kfree_rcu(new, rcu);
+	bpf_map_kfree_rcu(new, rcu);
 
 	return 0;
 }
@@ -526,7 +526,7 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 	return storage;
 
 enomem:
-	kfree(storage);
+	bpf_map_kfree(storage);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -535,8 +535,8 @@ static void free_shared_cgroup_storage_rcu(struct rcu_head *rcu)
 	struct bpf_cgroup_storage *storage =
 		container_of(rcu, struct bpf_cgroup_storage, rcu);
 
-	kfree(storage->buf);
-	kfree(storage);
+	bpf_map_kfree(storage->buf);
+	bpf_map_kfree(storage);
 }
 
 static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
@@ -544,8 +544,8 @@ static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
 	struct bpf_cgroup_storage *storage =
 		container_of(rcu, struct bpf_cgroup_storage, rcu);
 
-	free_percpu(storage->percpu_buf);
-	kfree(storage);
+	bpf_map_free_percpu(storage->percpu_buf);
+	bpf_map_kfree(storage);
 }
 
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index d833496..b2bee07 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -379,7 +379,7 @@ static int trie_update_elem(struct bpf_map *map,
 			trie->n_entries--;
 
 		rcu_assign_pointer(*slot, new_node);
-		kfree_rcu(node, rcu);
+		bpf_map_kfree_rcu(node, rcu);
 
 		goto out;
 	}
@@ -421,8 +421,8 @@ static int trie_update_elem(struct bpf_map *map,
 		if (new_node)
 			trie->n_entries--;
 
-		kfree(new_node);
-		kfree(im_node);
+		bpf_map_kfree(new_node);
+		bpf_map_kfree(im_node);
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
@@ -503,8 +503,8 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 		else
 			rcu_assign_pointer(
 				*trim2, rcu_access_pointer(parent->child[0]));
-		kfree_rcu(parent, rcu);
-		kfree_rcu(node, rcu);
+		bpf_map_kfree_rcu(parent, rcu);
+		bpf_map_kfree_rcu(node, rcu);
 		goto out;
 	}
 
@@ -518,7 +518,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 		rcu_assign_pointer(*trim, rcu_access_pointer(node->child[1]));
 	else
 		RCU_INIT_POINTER(*trim, NULL);
-	kfree_rcu(node, rcu);
+	bpf_map_kfree_rcu(node, rcu);
 
 out:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
@@ -602,7 +602,7 @@ static void trie_free(struct bpf_map *map)
 				continue;
 			}
 
-			kfree(node);
+			bpf_map_kfree(node);
 			RCU_INIT_POINTER(*slot, NULL);
 			break;
 		}
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bb378c3..7b6d7fd 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -64,7 +64,7 @@ void bpf_sk_storage_free(struct sock *sk)
 	rcu_read_unlock();
 
 	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
+		bpf_map_kfree_rcu(sk_storage, rcu);
 }
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
@@ -203,7 +203,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
-				kfree(copy_selem);
+				bpf_map_kfree(copy_selem);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 22fa2c5..059e55c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -888,7 +888,7 @@ static void sock_hash_free_elem(struct bpf_shtab *htab,
 				struct bpf_shtab_elem *elem)
 {
 	atomic_dec(&htab->count);
-	kfree_rcu(elem, rcu);
+	bpf_map_kfree_rcu(elem, rcu);
 }
 
 static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 771d0fa..1cb24b1 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -33,7 +33,7 @@ static struct xsk_map_node *xsk_map_node_alloc(struct xsk_map *map,
 static void xsk_map_node_free(struct xsk_map_node *node)
 {
 	bpf_map_put(&node->map->map);
-	kfree(node);
+	bpf_map_kfree(node);
 }
 
 static void xsk_map_sock_add(struct xdp_sock *xs, struct xsk_map_node *node)
-- 
1.8.3.1

