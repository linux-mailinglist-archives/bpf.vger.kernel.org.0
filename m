Return-Path: <bpf+bounces-8244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CB78418E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C471F1C20B13
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FB1C9F7;
	Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4C1C9F1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF0CD4
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:06:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVV335myFz4f3pFC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:06:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBH16m+suRk0ldIBQ--.4082S5;
	Tue, 22 Aug 2023 21:06:08 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 1/3] bpf: Enable preemption after irq_work_raise() in unit_alloc()
Date: Tue, 22 Aug 2023 21:38:05 +0800
Message-Id: <20230822133807.3198625-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230822133807.3198625-1-houtao@huaweicloud.com>
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH16m+suRk0ldIBQ--.4082S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyUWr47XrWkJw4fJrWkWFg_yoW5Xw4DpF
	4ayryxtw48ZF12q3W29w1xAr9Ivws5G347JrW0gry3Zws8Aryvgws7Kr1YqrykursrJFWf
	ArWktay09FW8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
unexpectedly because all qp-trie operations were initiated from
bpf syscalls and there was still available free memory. bpf_obj_new()
has the same problem as shown by the following selftest.

The failure is due to the preemption. irq_work_raise() will invoke
irq_work_claim() first to mark the irq work as pending and then inovke
__irq_work_queue_local() to raise an IPI. So when the current task
which is invoking irq_work_raise() is preempted by other task,
unit_alloc() may return NULL for preemptive task as shown below:

task A         task B

unit_alloc()
  // low_watermark = 32
  // free_cnt = 31 after alloc
  irq_work_raise()
    // mark irq work as IRQ_WORK_PENDING
    irq_work_claim()

	       // task B preempts task A
	       unit_alloc()
	         // free_cnt = 30 after alloc
	         // irq work is already PENDING,
	         // so just return
	         irq_work_raise()
	       // does unit_alloc() 30-times
	       ......
	       unit_alloc()
	         // free_cnt = 0 before alloc
	         return NULL

Fix it by invoking preempt_disable_notrace() before allocation and
invoking preempt_enable_notrace() to enable preemption after
irq_work_raise() completes. An alternative fix is to move
local_irq_restore() after the invocation of irq_work_raise(), but it
will enlarge the irq-disabled region. Another feasible fix is to only
disable preemption before invoking irq_work_queue() and enable
preemption after the invocation in irq_work_raise(), but it can't
handle the case when c->low_watermark is 1.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9c49ae53deaf..83f8913ebb0a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -6,6 +6,7 @@
 #include <linux/irq_work.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
+#include <linux/preempt.h>
 #include <asm/local.h>
 
 /* Any context (including NMI) BPF specific memory allocator.
@@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	 * Use per-cpu 'active' counter to order free_list access between
 	 * unit_alloc/unit_free/bpf_mem_refill.
 	 */
+	preempt_disable_notrace();
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		llnode = __llist_del_first(&c->free_llist);
@@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 
 	if (cnt < c->low_watermark)
 		irq_work_raise(c);
+	/* Enable preemption after the enqueue of irq work completes,
+	 * so free_llist may be refilled by irq work before other task
+	 * preempts current task.
+	 */
+	preempt_enable_notrace();
+
 	return llnode;
 }
 
-- 
2.29.2


