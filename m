Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3976860624B
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJTN5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJTN5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 09:57:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA7197F82
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 06:57:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MtTcF4PJrz6R53h
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 21:54:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXCzKpU1Fjlm+cAA--.42727S4;
        Thu, 20 Oct 2022 21:56:59 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf] bpf: Support for setting numa node in bpf memory allocator
Date:   Thu, 20 Oct 2022 22:22:47 +0800
Message-Id: <20221020142247.1682009-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXCzKpU1Fjlm+cAA--.42727S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1DGF4rXFWrKr4DXr4DXFb_yoWxXry8pF
        W7CFyrAws8XF47W3WI9w4xAa45J34IqrnrK3y3Wry0vrWrXrnrXr4DJry3XF9Yyr4jya1S
        yryvgr4fCrW8ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
numa node setting for non-preallocated hash table is ignored. The reason
is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
is trivial to support numa node setting for bpf memory allocator.

So adding support for setting numa node in bpf memory allocator and
updating hash map accordingly.

Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  3 ++-
 kernel/bpf/hashtab.c          |  6 +++--
 kernel/bpf/memalloc.c         | 50 ++++++++++++++++++++++++++++-------
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8efaa9..5b1e34d6f133 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,7 +14,8 @@ struct bpf_mem_alloc {
 	struct work_struct work;
 };
 
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, int numa_node,
+		       bool percpu);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
 /* kmalloc/kfree equivalent: */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index ed3f8a53603b..34954195841d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -568,12 +568,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size,
+					 htab->map.numa_node, false);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true);
+						 round_up(htab->map.value_size, 8),
+						 htab->map.numa_node, true);
 			if (err)
 				goto free_map_locked;
 		}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index fc116cf47d24..44c531ba9534 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -6,6 +6,7 @@
 #include <linux/irq_work.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
+#include <linux/nodemask.h>
 #include <asm/local.h>
 
 /* Any context (including NMI) BPF specific memory allocator.
@@ -98,6 +99,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	int numa_node;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -125,8 +127,8 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 {
 	/* Allocate, but don't deplete atomic reserves that typical
 	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-	 * will allocate from the current numa node which is what we
-	 * want here.
+	 * will allocate from the current numa node if numa_node is
+	 * NUMA_NO_NODE, else will allocate from specific numa_node.
 	 */
 	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
 
@@ -301,9 +303,10 @@ static void bpf_mem_refill(struct irq_work *work)
 	cnt = c->free_cnt;
 	if (cnt < c->low_watermark)
 		/* irq_work runs on this cpu and kmalloc will allocate
-		 * from the current numa node which is what we want here.
+		 * from the current numa node if numa_node is NUMA_NO_NODE,
+		 * else allocate from specific numa_node.
 		 */
-		alloc_bulk(c, c->batch, NUMA_NO_NODE);
+		alloc_bulk(c, c->batch, c->numa_node);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
 }
@@ -328,7 +331,7 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
  * bpf progs can and should share bpf_mem_cache when possible.
  */
 
-static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
+static void prefill_mem_cache(struct bpf_mem_cache *c, int node)
 {
 	init_irq_work(&c->refill_work, bpf_mem_refill);
 	if (c->unit_size <= 256) {
@@ -349,7 +352,28 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
 	 */
-	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
+	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, node);
+}
+
+static inline bool is_valid_numa_node(int numa_node, bool percpu)
+{
+	return numa_node == NUMA_NO_NODE ||
+	       (!percpu && (unsigned int)numa_node < nr_node_ids);
+}
+
+/* The initial prefill is running in the context of map creation process, so
+ * if the preferred numa node is NUMA_NO_NODE, needs to use numa node of the
+ * specific cpu instead.
+ */
+static inline int get_prefill_numa_node(int numa_node, int cpu)
+{
+	int prefill_numa_node;
+
+	if (numa_node == NUMA_NO_NODE)
+		prefill_numa_node = cpu_to_node(cpu);
+	else
+		prefill_numa_node = numa_node;
+	return prefill_numa_node;
 }
 
 /* When size != 0 bpf_mem_cache for each cpu.
@@ -359,13 +383,17 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, int numa_node,
+		       bool percpu)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
+	int cpu, i, unit_size, percpu_size = 0;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
-	int cpu, i, unit_size, percpu_size = 0;
+
+	if (!is_valid_numa_node(numa_node, percpu))
+		return -EINVAL;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
@@ -387,7 +415,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
-			prefill_mem_cache(c, cpu);
+			c->numa_node = numa_node;
+			prefill_mem_cache(c, get_prefill_numa_node(numa_node, cpu));
 		}
 		ma->cache = pc;
 		return 0;
@@ -409,7 +438,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
-			prefill_mem_cache(c, cpu);
+			c->numa_node = numa_node;
+			prefill_mem_cache(c, get_prefill_numa_node(numa_node, cpu));
 		}
 	}
 	ma->caches = pcc;
-- 
2.29.2

