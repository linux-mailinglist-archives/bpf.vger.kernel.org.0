Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4F59B163
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 05:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiHUDO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 23:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiHUDOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 23:14:22 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2811808
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 20:14:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M9LCc0Vktzlkdd
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:13:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAH8r0DowFjsgGLAg--.45130S6;
        Sun, 21 Aug 2022 11:14:18 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH 2/3] bpf: Allow normally concurrent map updates for !htab_use_raw_lock() case
Date:   Sun, 21 Aug 2022 11:32:22 +0800
Message-Id: <20220821033223.2598791-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220821033223.2598791-1-houtao@huaweicloud.com>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAH8r0DowFjsgGLAg--.45130S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DAr15XF17Xw1DAFWDurg_yoWrGFy3pF
        W8Gr9IkF4UXF9293yDXr40qr45Jw1I93yIy397Gay8ZF4jqr1fXr1ktF1IvryFvr93CrZa
        9r4IqrWFkw1UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

For htab_use_raw_lock=true case, the normally concurrent map updates
are allowed by using preempt_disable() instead of migrate_disable()
before increasing htab->map_locked. However the false case can not use
preempt_disable(), because a sleepable spin-lock is acquired afterwards.

So introducing a locking_bpf_map bit in task_struct. Setting it before
acquiring bucket lock and clearing it after releasing the lock, so if
htab_lock_bucket() is re-entered, the re-enterancy will be rejected. And
if there is just preemption from another process, these processes can
run concurrently.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/sched.h |  3 +++
 kernel/bpf/hashtab.c  | 61 ++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 51dc1e89d43f..55667f46e459 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -944,6 +944,9 @@ struct task_struct {
 #ifdef	CONFIG_CPU_SUP_INTEL
 	unsigned			reported_split_lock:1;
 #endif
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_BPF_SYSCALL)
+	unsigned			bpf_map_busy:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index ad09da139589..3ef7a853c737 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -138,6 +138,23 @@ static inline bool htab_use_raw_lock(const struct bpf_htab *htab)
 	return (!IS_ENABLED(CONFIG_PREEMPT_RT) || htab_is_prealloc(htab));
 }
 
+static inline void bpf_clear_map_busy(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+	current->bpf_map_busy = 0;
+#endif
+}
+
+static inline int bpf_test_and_set_map_busy(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+	if (current->bpf_map_busy)
+		return 1;
+	current->bpf_map_busy = 1;
+#endif
+	return 0;
+}
+
 static void htab_init_buckets(struct bpf_htab *htab)
 {
 	unsigned int i;
@@ -162,28 +179,21 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 				   unsigned long *pflags)
 {
 	unsigned long flags;
-	bool use_raw_lock;
 
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
-
-	use_raw_lock = htab_use_raw_lock(htab);
-	if (use_raw_lock)
+	if (htab_use_raw_lock(htab)) {
+		hash = hash & HASHTAB_MAP_LOCK_MASK;
 		preempt_disable();
-	else
-		migrate_disable();
-	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
-		__this_cpu_dec(*(htab->map_locked[hash]));
-		if (use_raw_lock)
+		if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
+			__this_cpu_dec(*(htab->map_locked[hash]));
 			preempt_enable();
-		else
-			migrate_enable();
-		return -EBUSY;
-	}
-
-	if (use_raw_lock)
+			return -EBUSY;
+		}
 		raw_spin_lock_irqsave(&b->raw_lock, flags);
-	else
+	} else {
+		if (bpf_test_and_set_map_busy())
+			return -EBUSY;
 		spin_lock_irqsave(&b->lock, flags);
+	}
 	*pflags = flags;
 
 	return 0;
@@ -193,18 +203,15 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      struct bucket *b, u32 hash,
 				      unsigned long flags)
 {
-	bool use_raw_lock = htab_use_raw_lock(htab);
-
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
-	if (use_raw_lock)
+	if (htab_use_raw_lock(htab)) {
+		hash = hash & HASHTAB_MAP_LOCK_MASK;
 		raw_spin_unlock_irqrestore(&b->raw_lock, flags);
-	else
-		spin_unlock_irqrestore(&b->lock, flags);
-	__this_cpu_dec(*(htab->map_locked[hash]));
-	if (use_raw_lock)
+		__this_cpu_dec(*(htab->map_locked[hash]));
 		preempt_enable();
-	else
-		migrate_enable();
+	} else {
+		spin_unlock_irqrestore(&b->lock, flags);
+		bpf_clear_map_busy();
+	}
 }
 
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
-- 
2.29.2

