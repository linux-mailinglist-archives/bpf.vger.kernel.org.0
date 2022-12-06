Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDFF643C43
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 05:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLFEaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 23:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFE35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 23:29:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7CDED
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 20:29:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NR6rr4HYcz4f3p0r
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 12:29:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNY7xY5jzaDzBg--.51441S5;
        Tue, 06 Dec 2022 12:29:51 +0800 (CST)
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next 1/2] bpf: Reuse freed element in free_by_rcu during allocation
Date:   Tue,  6 Dec 2022 12:29:45 +0800
Message-Id: <20221206042946.686847-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221206042946.686847-1-houtao@huaweicloud.com>
References: <20221206042946.686847-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXSNY7xY5jzaDzBg--.51441S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fJr45WFy7Zw4kXF1UKFg_yoW8Cw1fpr
        sxGrn5Jan5ZF1a93WSvF4kCr9xCw1kJ343GFW8u34ayr1fXryqgrnayr1UXFy3CrW0ya1S
        yr1kKr43ta15XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

When there are batched freeing operations on a specific CPU, part of
the freed elements ((high_watermark - lower_watermark) / 2 + 1) will
be moved to waiting_for_gp list and the remaining part will be left in
free_by_rcu list and waits for the expiration of RCU-tasks-trace grace
period and the next invocation of free_bulk().

So instead of invoking __alloc_percpu_gfp() or kmalloc_node() to
allocate a new object, in alloc_bulk() just check whether or not there
is freed element in free_by_rcu and reuse it if available.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 8f0d65f2474a..7daf147bc8f6 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -171,9 +171,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
-		obj = __alloc(c, node);
-		if (!obj)
-			break;
+		/*
+		 * free_by_rcu is only manipulated by irq work refill_work().
+		 * IRQ works on the same CPU are called sequentially, so it is
+		 * safe to use __llist_del_first() here. If alloc_bulk() is
+		 * invoked by the initial prefill, there will be no running
+		 * irq work, so __llist_del_first() is fine as well.
+		 *
+		 * In most cases, objects on free_by_rcu are from the same CPU.
+		 * If some objects come from other CPUs, it doesn't incur any
+		 * harm because NUMA_NO_NODE means the preference for current
+		 * numa node and it is not a guarantee.
+		 */
+		obj = __llist_del_first(&c->free_by_rcu);
+		if (!obj) {
+			obj = __alloc(c, node);
+			if (!obj)
+				break;
+		}
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			/* In RT irq_work runs in per-cpu kthread, so disable
 			 * interrupts to avoid preemption and interrupts and
-- 
2.29.2

