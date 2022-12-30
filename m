Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74879659497
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiL3EMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B2E0C3;
        Thu, 29 Dec 2022 20:12:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NjsKC081Mz4f3mT2;
        Fri, 30 Dec 2022 12:11:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S5;
        Fri, 30 Dec 2022 12:12:01 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 1/6] bpf: Support ctor in bpf memory allocator
Date:   Fri, 30 Dec 2022 12:11:46 +0800
Message-Id: <20221230041151.1231169-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1kuw4xur48XrW5ur1kGrg_yoW7KFy7pF
        W7Gr18Aws8XFsrWa12gws2kayaq340gF17Kay3XryF9r1rWrnrGF4kJry7ZF909r4jyayf
        Ar1vgrW8Z3yUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Currently the freed element in bpf memory allocator may be immediately
reused, for htab map the reuse will reinitialize special fields in map
value (e.g., bpf_spin_lock), but lookup procedure may still access
these special fields, and it may lead to hard-lockup as shown below:

 NMI backtrace for cpu 16
 CPU: 16 PID: 2574 Comm: htab.bin Tainted: G             L     6.1.0+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
 RIP: 0010:queued_spin_lock_slowpath+0x283/0x2c0
 ......
 Call Trace:
  <TASK>
  copy_map_value_locked+0xb7/0x170
  bpf_map_copy_value+0x113/0x3c0
  __sys_bpf+0x1c67/0x2780
  __x64_sys_bpf+0x1c/0x20
  do_syscall_64+0x30/0x60
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 ......
  </TASK>

For htab map, just like the preallocated case, these is no need to
initialize these special fields in map value again once these fields
have been initialized, but now only bpf memory allocator knows whether
or not an allocated object is reused or not. So introducing ctor support
in bpf memory allocator and calling ctor for the allocated object only
when it is newly allocated.

Fixes: 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  4 +++-
 kernel/bpf/core.c             |  2 +-
 kernel/bpf/hashtab.c          | 16 ++++++++++++----
 kernel/bpf/memalloc.c         | 10 +++++++++-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8efaa9..3c287db087e7 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -12,9 +12,11 @@ struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
 	struct work_struct work;
+	void (*ctor)(struct bpf_mem_alloc *ma, void *obj);
 };
 
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+		       void (*ctor)(struct bpf_mem_alloc *, void *));
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
 /* kmalloc/kfree equivalent: */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7f98dec6e90f..6da2f9a6b085 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2755,7 +2755,7 @@ static int __init bpf_global_ma_init(void)
 {
 	int ret;
 
-	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false, NULL);
 	bpf_global_ma_set = !ret;
 	return ret;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5aa2b5525f79..3d6557ec4b92 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -453,6 +453,15 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+static void htab_elem_ctor(struct bpf_mem_alloc *ma, void *obj)
+{
+	struct bpf_htab *htab = container_of(ma, struct bpf_htab, ma);
+	struct htab_elem *elem = obj;
+
+	check_and_init_map_value(&htab->map,
+				 elem->key + round_up(htab->map.key_size, 8));
+}
+
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -565,12 +574,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false,
+					 htab_elem_ctor);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true);
+						 round_up(htab->map.value_size, 8), true, NULL);
 			if (err)
 				goto free_map_locked;
 		}
@@ -1004,8 +1014,6 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
 		}
-		check_and_init_map_value(&htab->map,
-					 l_new->key + round_up(key_size, 8));
 	}
 
 	memcpy(l_new->key, key, key_size);
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ebcc3dd0fa19..ac5b92fece14 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	struct bpf_mem_alloc *ma;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -188,6 +189,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 			obj = __alloc(c, node);
 			if (!obj)
 				break;
+			/* Only do initialize for newly allocated object */
+			if (c->ma->ctor)
+				c->ma->ctor(c->ma, obj);
 		}
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			/* In RT irq_work runs in per-cpu kthread, so disable
@@ -374,7 +378,8 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+		       void (*ctor)(struct bpf_mem_alloc *, void *))
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
@@ -382,6 +387,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
 
+	ma->ctor = ctor;
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
 		if (!pc)
@@ -402,6 +408,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->ma = ma;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -424,6 +431,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->ma = ma;
 			prefill_mem_cache(c, cpu);
 		}
 	}
-- 
2.29.2

