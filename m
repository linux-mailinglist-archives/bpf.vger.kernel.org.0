Return-Path: <bpf+bounces-9109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577ED78FC37
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3251C20C52
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E8AD35;
	Fri,  1 Sep 2023 11:20:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25081A943
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 11:20:05 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968E10D2
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 04:20:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RcbCx29CYz4f3nqn
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 19:19:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHoqXcyPFkv5VoCA--.40782S6;
	Fri, 01 Sep 2023 19:20:00 +0800 (CST)
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
Subject: [PATCH bpf v2 2/3] bpf: Enable IRQ after irq_work_raise() completes in unit_free{_rcu}()
Date: Fri,  1 Sep 2023 19:19:53 +0800
Message-Id: <20230901111954.1804721-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230901111954.1804721-1-houtao@huaweicloud.com>
References: <20230901111954.1804721-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHoqXcyPFkv5VoCA--.40782S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kuFW5ZFW8Cr1DuFy8Zrb_yoW8tF18pF
	43WFyxtrWrZFyIqw4xCw4xCr9Fqws5Ga47GrW8X343ZrW5Cryvqr92kF1YqFyYvrZ7JF4S
	yrs5ta40vay8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Both unit_free() and unit_free_rcu() invoke irq_work_raise() to free
freed objects back to slab and the invocation may also be preempted by
unit_alloc() and unit_alloc() may return NULL unexpectedly as shown in
the following case:

task A         task B

unit_free()
  // high_watermark = 48
  // free_cnt = 49 after free
  irq_work_raise()
    // mark irq work as IRQ_WORK_PENDING
    irq_work_claim()

               // task B preempts task A
               unit_alloc()
                 // free_cnt = 48 after alloc

               // does unit_alloc() 32-times
	       ......
	       // free_cnt = 16

	       unit_alloc()
	         // free_cnt = 15 after alloc
                 // irq work is already PENDING,
                 // so just return
                 irq_work_raise()

	       // does unit_alloc() 15-times
               ......
	       // free_cnt = 0

               unit_alloc()
                 // free_cnt = 0 before alloc
                 return NULL

Fix it by enabling IRQ after irq_work_raise() completes.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 962472ace98c..7a81dd6b1aed 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -780,11 +780,16 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 		llist_add(llnode, &c->free_llist_extra);
 	}
 	local_dec(&c->active);
-	local_irq_restore(flags);
 
 	if (cnt > c->high_watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c);
+	/* Enable IRQ after irq_work_raise() completes, otherwise when current
+	 * task is preempted by task which does unit_alloc(), unit_alloc() may
+	 * return NULL unexpectedly because irq work is already pending but can
+	 * not been triggered and free_llist can not be refilled timely.
+	 */
+	local_irq_restore(flags);
 }
 
 static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
@@ -802,10 +807,10 @@ static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
 		llist_add(llnode, &c->free_llist_extra_rcu);
 	}
 	local_dec(&c->active);
-	local_irq_restore(flags);
 
 	if (!atomic_read(&c->call_rcu_in_progress))
 		irq_work_raise(c);
+	local_irq_restore(flags);
 }
 
 /* Called from BPF program or from sys_bpf syscall.
-- 
2.29.2


