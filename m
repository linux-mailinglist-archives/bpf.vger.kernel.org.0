Return-Path: <bpf+bounces-8245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21B78418F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5975228100F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227691C9FD;
	Tue, 22 Aug 2023 13:06:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A91C9F1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E228CD7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:06:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVV3227NCz4f3mJh
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:06:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBH16m+suRk0ldIBQ--.4082S6;
	Tue, 22 Aug 2023 21:06:09 +0800 (CST)
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
Subject: [PATCH bpf-next 2/3] bpf: Enable preemption after irq_work_raise() in unit_free{_rcu}()
Date: Tue, 22 Aug 2023 21:38:06 +0800
Message-Id: <20230822133807.3198625-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBH16m+suRk0ldIBQ--.4082S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kuFW5ZFW8Cr1DXw1xAFb_yoW8Kr43pF
	W7uFy8A3y8ZFWIgw4xKwn7Cr9Fqws3K347GFWkX393Z395Cr9YgFsFkr17XF909r4xCFWf
	Ar1kKrWFgay8AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
	version=3.4.6
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

Fix it by disabling preemption before do freeing and enabling preemption
after irq_work_raise() completes.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 83f8913ebb0a..a4b089876383 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -769,6 +769,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	 */
 	c->tgt = *(struct bpf_mem_cache **)llnode;
 
+	preempt_disable_notrace();
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		__llist_add(llnode, &c->free_llist);
@@ -788,6 +789,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	if (cnt > c->high_watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c);
+	preempt_enable_notrace();
 }
 
 static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
@@ -797,6 +799,7 @@ static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
 
 	c->tgt = *(struct bpf_mem_cache **)llnode;
 
+	preempt_disable_notrace();
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		if (__llist_add(llnode, &c->free_by_rcu))
@@ -809,6 +812,7 @@ static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
 
 	if (!atomic_read(&c->call_rcu_in_progress))
 		irq_work_raise(c);
+	preempt_enable_notrace();
 }
 
 /* Called from BPF program or from sys_bpf syscall.
-- 
2.29.2


