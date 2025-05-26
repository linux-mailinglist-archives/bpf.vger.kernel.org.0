Return-Path: <bpf+bounces-58922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C5AC39A6
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0318925FC
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCC1D54E9;
	Mon, 26 May 2025 06:08:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547F1CAA65
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239713; cv=none; b=cTlQcrArSaLeRdmnHYLWwQ6L175T172a2S+cAxKNLW/TZKAxVeHRsM3rVJoA+1Q4+uycqkx1/AJ8lcE5LhhRFzltPCGR3NrY6TGpEC2WnDUHWhhva1hA/cr89L0HPz4uTOpP1ywaVJr3wsqMT0Jt3Q30vXJPQ1zX3LnAiVM8KUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239713; c=relaxed/simple;
	bh=9zuELYnOxQfJsiDb7+cNvnFCcTGAsm+vD0o8BrBFYv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOUPoIYEV8R/l/3IiDAsZNB4vx9r7zx98qL9/ODP8mZzzC9h3QI0EBtl6LotAA0Kt+/XIhnnufFpTW1fPimR2XPrY//uWEKYXMSPoUzIhz1O9CTYO1cp4sLJIgFHMa2cdiIYhw6hts1AWqcvXdhyB+HQk/isJ0hOZb47f0GKtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5QL03vZMz4f3jtT
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9A5271A019B
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9aBTRoMQovNg--.11895S5;
	Mon, 26 May 2025 14:08:28 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next 1/3] bpf: Add a new dtor callback argument for bpf_mem_alloc_init
Date: Mon, 26 May 2025 14:25:53 +0800
Message-Id: <20250526062555.1106061-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250526062555.1106061-1-houtao@huaweicloud.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9aBTRoMQovNg--.11895S5
X-Coremail-Antispam: 1UD129KBjvJXoWfJw4UuFWrZrWxZrWruw18uFg_yoWDZw1rpF
	WxGrykAr4DXFs7u3W7Jws7A3s8Xw1Fga4xKayUuryF9r13Zr1DtFWkAry7uFyYkrWkKayS
	yr9YgrW8C3yUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7S_M
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The bpf program could keep the pointer of a newly-allocated resource
after the object allocated from bpf mem allocator has been freed through
bpf_mem_cache_free() or bpf_mem_cache_free_rcu(). The resource will be
leaked if the bpf ma is destroyed later. Take the non-preallocated hash
map as an example, the bpf program could first use bpf_map_lookup_elem()
to find the value, then use bpf_map_delete_elem() to delete the element,
and lastly use bpf_xchg() to save a newly-allocated kptr to the deleted
element. The kptr will be leaked if the map is freed afterwards.
However, the local storage map doesn't have such problem. The reason is
that after the bpf program has deleted the element, the free callback
(namely bpf_selem_free_rcu) will free the special fields after one RCU
tasks trace grace period.

For hash map, before switching to bpf mem allocator, the callback passed
to call_rcu() will free these linger resources after no one will be
accessible to these resources. Therefore, add a similar cb for
bpf_mem_alloc_init() to handle the case. The bpf mem allocator will use
the dtor callback to free the maybe-lingered resources before it is
destroyed. It may be reasonable to also invoke the dtor callback for the
reused object, but for now just keep the reused object as-is to be
consistent with the preallocated hash map case.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h  |  5 ++++-
 kernel/bpf/bpf_local_storage.c |  5 +++--
 kernel/bpf/core.c              |  2 +-
 kernel/bpf/cpumask.c           |  2 +-
 kernel/bpf/hashtab.c           |  5 +++--
 kernel/bpf/lpm_trie.c          |  2 +-
 kernel/bpf/memalloc.c          | 38 ++++++++++++++++++++--------------
 7 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index e45162ef59bb..955368a6fc49 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -8,6 +8,8 @@
 struct bpf_mem_cache;
 struct bpf_mem_caches;
 
+typedef void (*bpf_ma_dtor)(void *obj, void *ctx);
+
 struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
@@ -26,7 +28,8 @@ struct bpf_mem_alloc {
  * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
  * should be used to do on-demand per-cpu allocation for each size.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+		       bpf_ma_dtor dtor, void *dtor_ctx);
 /* Initialize a non-fix-size percpu memory allocator */
 int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg);
 /* The percpu allocation with a specific unit size. */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fa56c30833ff..baffd92477f0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -839,11 +839,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	 */
 	smap->bpf_ma = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : bpf_ma;
 	if (smap->bpf_ma) {
-		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
+		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false, NULL, NULL);
 		if (err)
 			goto free_smap;
 
-		err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false);
+		err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false,
+					 NULL, NULL);
 		if (err) {
 			bpf_mem_alloc_destroy(&smap->selem_ma);
 			goto free_smap;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e571688421..ec657177d842 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3176,7 +3176,7 @@ static int __init bpf_global_ma_init(void)
 {
 	int ret;
 
-	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false, NULL, NULL);
 	bpf_global_ma_set = !ret;
 	return ret;
 }
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 9876c5fe6c2a..c638fabf3892 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -522,7 +522,7 @@ static int __init cpumask_kfunc_init(void)
 		},
 	};
 
-	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
+	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false, NULL, NULL);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &cpumask_kfunc_set);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..dd6c157cb828 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -568,12 +568,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false, NULL, NULL);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true);
+						 round_up(htab->map.value_size, 8), true,
+						 NULL, NULL);
 			if (err)
 				goto free_map_locked;
 		}
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index be66d7e520e0..7b66e75a559b 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -600,7 +600,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	/* Allocate intermediate and leaf nodes from the same allocator */
 	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
 		    trie->map.value_size;
-	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false);
+	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false, NULL, NULL);
 	if (err)
 		goto free_out;
 	return &trie->map;
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..4dabeb268f34 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -117,6 +117,8 @@ struct bpf_mem_cache {
 	struct llist_head waiting_for_gp_ttrace;
 	struct rcu_head rcu_ttrace;
 	atomic_t call_rcu_ttrace_in_progress;
+	bpf_ma_dtor dtor;
+	void *dtor_ctx;
 };
 
 struct bpf_mem_caches {
@@ -252,21 +254,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 	mem_cgroup_put(memcg);
 }
 
-static void free_one(void *obj, bool percpu)
+static void free_one(struct bpf_mem_cache *c, void *obj, bool percpu)
 {
+	if (c->dtor)
+		c->dtor(obj + LLIST_NODE_SZ, c->dtor_ctx);
+
 	if (percpu)
 		free_percpu(((void __percpu **)obj)[1]);
 
 	kfree(obj);
 }
 
-static int free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
 	int cnt = 0;
 
 	llist_for_each_safe(pos, t, llnode) {
-		free_one(pos, percpu);
+		free_one(c, pos, percpu);
 		cnt++;
 	}
 	return cnt;
@@ -276,7 +281,7 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -308,7 +313,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
 			llnode = llist_del_all(&c->free_by_rcu_ttrace);
-			free_all(llnode, !!c->percpu_size);
+			free_all(c, llnode, !!c->percpu_size);
 		}
 		return;
 	}
@@ -417,7 +422,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 	dec_active(c, &flags);
 
 	if (unlikely(READ_ONCE(c->draining))) {
-		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
+		free_all(c, llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 		atomic_set(&c->call_rcu_in_progress, 0);
 	} else {
 		call_rcu_hurry(&c->rcu, __free_by_rcu);
@@ -506,14 +511,15 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+		       bpf_ma_dtor dtor, void *dtor_ctx)
 {
 	struct bpf_mem_caches *cc; struct bpf_mem_caches __percpu *pcc;
 	struct bpf_mem_cache *c; struct bpf_mem_cache __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
 
-	if (percpu && size == 0)
+	if ((percpu || dtor) && size == 0)
 		return -EINVAL;
 
 	/* room for llist_node and per-cpu pointer */
@@ -542,6 +548,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			c->dtor = dtor;
+			c->dtor_ctx = dtor_ctx;
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -635,13 +643,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
-	free_all(__llist_del_all(&c->free_llist), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra), percpu);
-	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
+	free_all(c, __llist_del_all(&c->free_llist), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
+	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void check_mem_cache(struct bpf_mem_cache *c)
-- 
2.29.2


