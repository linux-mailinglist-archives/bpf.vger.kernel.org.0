Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A896F23E6
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjD2Jle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Apr 2023 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2Jlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Apr 2023 05:41:32 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431621994;
        Sat, 29 Apr 2023 02:41:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q7kxx74z2z4f3lwK;
        Sat, 29 Apr 2023 17:41:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBA5kxkK36NIQ--.13426S9;
        Sat, 29 Apr 2023 17:41:27 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v3 5/6] bpf: Add two module parameters in htab for memory benchmark
Date:   Sat, 29 Apr 2023 18:12:14 +0800
Message-Id: <20230429101215.111262-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230429101215.111262-1-houtao@huaweicloud.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBA5kxkK36NIQ--.13426S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWDAr1fGr1fCw15try5Arb_yoWrAr45pF
        WfGr17Aa1kZrsFgw4fJr48KrWYqr1I9w1jka4UKa4Fyr15Zr97X3WxAFyfGFy5urW8Aws3
        Zr9Fgw1UWayrWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add two module parameters in htab:
* reuse_flag: possible values are 0, 2 (REUSE_AFTER_RCU_GP) or
  4 (FREE_AFTER_RCU_GP). The default value is 0 and this creates
  a hash map which does immediate reuse.
* delayed_free: possible values are 0, 1. The default value is 0 and
  the hash map will call bpf_mem_cache_free() directly. If the value
  is 1, the hash map will call bpf_mem_cache_free() after one RCU GP
  which mimics the free of bpf_cpumask.

These two module parameters are used for benchmarking purpose only and
are not intended for merging.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 93009b94ac9b..8502957b8bcc 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -100,6 +100,7 @@ struct bpf_htab {
 	struct percpu_counter pcount;
 	atomic_t count;
 	bool use_percpu_counter;
+	bool delayed_free;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
@@ -120,14 +121,24 @@ struct htab_elem {
 		};
 	};
 	union {
-		/* pointer to per-cpu pointer */
-		void *ptr_to_pptr;
+		struct {
+			/* pointer to per-cpu pointer */
+			void *ptr_to_pptr;
+			struct bpf_mem_alloc *ma;
+			struct rcu_head rcu;
+		};
 		struct bpf_lru_node lru_node;
 	};
 	u32 hash;
 	char key[] __aligned(8);
 };
 
+static int reuse_flag;
+module_param(reuse_flag, int, 0644);
+
+static bool delayed_free;
+module_param(delayed_free, bool, 0644);
+
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 {
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
@@ -539,6 +550,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab_init_buckets(htab);
 
+	htab->delayed_free = delayed_free;
 /* compute_batch_value() computes batch value as num_online_cpus() * 2
  * and __percpu_counter_compare() needs
  * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
@@ -576,7 +588,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, 0);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, reuse_flag);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
@@ -878,12 +890,24 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return -ENOENT;
 }
 
-static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
+static void htab_elem_free_rcu(struct rcu_head *rcu)
+{
+	struct htab_elem *l = container_of(rcu, struct htab_elem, rcu);
+
+	bpf_mem_cache_free(l->ma, l);
+}
+
+static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l, bool destroy)
 {
 	check_and_free_fields(htab, l);
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-	bpf_mem_cache_free(&htab->ma, l);
+	if (destroy || !htab->delayed_free) {
+		bpf_mem_cache_free(&htab->ma, l);
+		return;
+	}
+	l->ma = &htab->ma;
+	call_rcu(&l->rcu, htab_elem_free_rcu);
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
@@ -931,7 +955,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
-		htab_elem_free(htab, l);
+		htab_elem_free(htab, l, false);
 	}
 }
 
@@ -1468,7 +1492,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			htab_elem_free(htab, l);
+			htab_elem_free(htab, l, true);
 		}
 	}
 	migrate_enable();
@@ -1522,6 +1546,8 @@ static void htab_map_free(struct bpf_map *map)
 	 * during bpf_mem_alloc_destroy().
 	 */
 	if (!htab_is_prealloc(htab)) {
+		if (htab->delayed_free)
+			rcu_barrier();
 		delete_all_elements(htab);
 	} else {
 		htab_free_prealloced_fields(htab);
-- 
2.29.2

