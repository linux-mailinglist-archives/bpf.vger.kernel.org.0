Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE65BF781
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIUHU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIUHUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 03:20:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9C7CB79
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 00:20:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXVBm0JbRzlJJJ
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 15:18:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXM0uypjR6SoBA--.9748S4;
        Wed, 21 Sep 2022 15:20:21 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, houtao1@huawei.com
Subject: [PATCH bpf-next RESEND] bpf: Always use raw spinlock for hash bucket lock
Date:   Wed, 21 Sep 2022 15:38:26 +0800
Message-Id: <20220921073826.2365800-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXM0uypjR6SoBA--.9748S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw13GFW8CF13Aw45Wr1xKrg_yoWrKryfpF
        WfKasayr18ZF1S93yDXw10gr15Gw4Ig3yUA3ykW348Aa45Zrnagrn2qryIvFy0vryxAFn0
        vF42gF1YkryUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

For a non-preallocated hash map on RT kernel, regular spinlock instead
of raw spinlock is used for bucket lock. The reason is that on RT kernel
memory allocation is forbidden under atomic context and regular spinlock
is sleepable under RT.

Now hash map has been fully converted to use bpf_map_alloc, and there
will be no synchronous memory allocation for non-preallocated hash map,
so it is safe to always use raw spinlock for bucket lock on RT. So
removing the usage of htab_use_raw_lock() and updating the comments
accordingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 * Forget to add bpf-next for the previous send, so send it again

 kernel/bpf/hashtab.c | 66 ++++++++++----------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 86aec20c22d0..ed3f8a53603b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -68,24 +68,16 @@
  * In theory the BPF locks could be converted to regular spinlocks as well,
  * but the bucket locks and percpu_freelist locks can be taken from
  * arbitrary contexts (perf, kprobes, tracepoints) which are required to be
- * atomic contexts even on RT. These mechanisms require preallocated maps,
- * so there is no need to invoke memory allocations within the lock held
- * sections.
- *
- * BPF maps which need dynamic allocation are only used from (forced)
- * thread context on RT and can therefore use regular spinlocks which in
- * turn allows to invoke memory allocations from the lock held section.
- *
- * On a non RT kernel this distinction is neither possible nor required.
- * spinlock maps to raw_spinlock and the extra code is optimized out by the
- * compiler.
+ * atomic contexts even on RT. Before the introduction of bpf_mem_alloc,
+ * it is only safe to use raw spinlock for preallocated hash map on a RT kernel,
+ * because there is no memory allocation within the lock held sections. However
+ * after hash map was fully converted to use bpf_mem_alloc, there will be
+ * non-synchronous memory allocation for non-preallocated hash map, so it is
+ * safe to always use raw spinlock for bucket lock.
  */
 struct bucket {
 	struct hlist_nulls_head head;
-	union {
-		raw_spinlock_t raw_lock;
-		spinlock_t     lock;
-	};
+	raw_spinlock_t raw_lock;
 };
 
 #define HASHTAB_MAP_LOCK_COUNT 8
@@ -141,26 +133,15 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
 }
 
-static inline bool htab_use_raw_lock(const struct bpf_htab *htab)
-{
-	return (!IS_ENABLED(CONFIG_PREEMPT_RT) || htab_is_prealloc(htab));
-}
-
 static void htab_init_buckets(struct bpf_htab *htab)
 {
 	unsigned int i;
 
 	for (i = 0; i < htab->n_buckets; i++) {
 		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		if (htab_use_raw_lock(htab)) {
-			raw_spin_lock_init(&htab->buckets[i].raw_lock);
-			lockdep_set_class(&htab->buckets[i].raw_lock,
+		raw_spin_lock_init(&htab->buckets[i].raw_lock);
+		lockdep_set_class(&htab->buckets[i].raw_lock,
 					  &htab->lockdep_key);
-		} else {
-			spin_lock_init(&htab->buckets[i].lock);
-			lockdep_set_class(&htab->buckets[i].lock,
-					  &htab->lockdep_key);
-		}
 		cond_resched();
 	}
 }
@@ -170,28 +151,17 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 				   unsigned long *pflags)
 {
 	unsigned long flags;
-	bool use_raw_lock;
 
 	hash = hash & HASHTAB_MAP_LOCK_MASK;
 
-	use_raw_lock = htab_use_raw_lock(htab);
-	if (use_raw_lock)
-		preempt_disable();
-	else
-		migrate_disable();
+	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
 		__this_cpu_dec(*(htab->map_locked[hash]));
-		if (use_raw_lock)
-			preempt_enable();
-		else
-			migrate_enable();
+		preempt_enable();
 		return -EBUSY;
 	}
 
-	if (use_raw_lock)
-		raw_spin_lock_irqsave(&b->raw_lock, flags);
-	else
-		spin_lock_irqsave(&b->lock, flags);
+	raw_spin_lock_irqsave(&b->raw_lock, flags);
 	*pflags = flags;
 
 	return 0;
@@ -201,18 +171,10 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      struct bucket *b, u32 hash,
 				      unsigned long flags)
 {
-	bool use_raw_lock = htab_use_raw_lock(htab);
-
 	hash = hash & HASHTAB_MAP_LOCK_MASK;
-	if (use_raw_lock)
-		raw_spin_unlock_irqrestore(&b->raw_lock, flags);
-	else
-		spin_unlock_irqrestore(&b->lock, flags);
+	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
 	__this_cpu_dec(*(htab->map_locked[hash]));
-	if (use_raw_lock)
-		preempt_enable();
-	else
-		migrate_enable();
+	preempt_enable();
 }
 
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
-- 
2.29.2

