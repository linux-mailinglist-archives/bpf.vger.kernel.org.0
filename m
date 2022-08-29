Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980D5A4108
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 04:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2CTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2CTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 22:19:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94733C8C4
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 19:19:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGDbn4dDZzKHP4
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:17:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMTIgxjzJZKAA--.51878S5;
        Mon, 29 Aug 2022 10:19:04 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v3 1/3] bpf: Disable preemption when increasing per-cpu map_locked
Date:   Mon, 29 Aug 2022 10:37:07 +0800
Message-Id: <20220829023709.1958204-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220829023709.1958204-1-houtao@huaweicloud.com>
References: <20220829023709.1958204-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMTIgxjzJZKAA--.51878S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFykXFWkCF18GFWxCFy7trb_yoW5ZFyxpF
        48GF9ayw48XF9Y9a9rXr1Iqr15Aw4xK3yIy3ykGrWxZr45Zr1fur1IyFySqF1Fvr9xArsa
        vw42qa1Yyr4UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
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

Per-cpu htab->map_locked is used to prohibit the concurrent accesses
from both NMI and non-NMI contexts. But since commit 74d862b682f5
("sched: Make migrate_disable/enable() independent of RT"),
migrate_disable() is also preemptible under CONFIG_PREEMPT case, so now
map_locked also disallows concurrent updates from normal contexts
(e.g. userspace processes) unexpectedly as shown below:

process A                      process B

htab_map_update_elem()
  htab_lock_bucket()
    migrate_disable()
    /* return 1 */
    __this_cpu_inc_return()
    /* preempted by B */

                               htab_map_update_elem()
                                 /* the same bucket as A */
                                 htab_lock_bucket()
                                   migrate_disable()
                                   /* return 2, so lock fails */
                                   __this_cpu_inc_return()
                                   return -EBUSY

A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
only checking the value of map_locked for nmi context. But it will
re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
through non-tracing program (e.g. fentry program).

One cannot use preempt_disable() to fix this issue as htab_use_raw_lock
being false causes the bucket lock to be a spin lock which can sleep and
does not work with preempt_disable().

Therefore, use migrate_disable() when using the spinlock instead of
preempt_disable() and defer fixing concurrent updates to when the kernel
has its own BPF memory allocator.

Fixes: 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
Reviewed-by: Hao Luo <haoluo@google.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b301a63afa2f..6fb3b7fd1622 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 				   unsigned long *pflags)
 {
 	unsigned long flags;
+	bool use_raw_lock;
 
 	hash = hash & HASHTAB_MAP_LOCK_MASK;
 
-	migrate_disable();
+	use_raw_lock = htab_use_raw_lock(htab);
+	if (use_raw_lock)
+		preempt_disable();
+	else
+		migrate_disable();
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
 		__this_cpu_dec(*(htab->map_locked[hash]));
-		migrate_enable();
+		if (use_raw_lock)
+			preempt_enable();
+		else
+			migrate_enable();
 		return -EBUSY;
 	}
 
-	if (htab_use_raw_lock(htab))
+	if (use_raw_lock)
 		raw_spin_lock_irqsave(&b->raw_lock, flags);
 	else
 		spin_lock_irqsave(&b->lock, flags);
@@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      struct bucket *b, u32 hash,
 				      unsigned long flags)
 {
+	bool use_raw_lock = htab_use_raw_lock(htab);
+
 	hash = hash & HASHTAB_MAP_LOCK_MASK;
-	if (htab_use_raw_lock(htab))
+	if (use_raw_lock)
 		raw_spin_unlock_irqrestore(&b->raw_lock, flags);
 	else
 		spin_unlock_irqrestore(&b->lock, flags);
 	__this_cpu_dec(*(htab->map_locked[hash]));
-	migrate_enable();
+	if (use_raw_lock)
+		preempt_enable();
+	else
+		migrate_enable();
 }
 
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
-- 
2.29.2

