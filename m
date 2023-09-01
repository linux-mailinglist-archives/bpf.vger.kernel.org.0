Return-Path: <bpf+bounces-9108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298B78FC36
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9A28179C
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB4AD29;
	Fri,  1 Sep 2023 11:20:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F21A943
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 11:20:05 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6DE42
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 04:20:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RcbCw60THz4f3nqf
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 19:19:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHoqXcyPFkv5VoCA--.40782S5;
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
Subject: [PATCH bpf v2 1/3] bpf: Enable IRQ after irq_work_raise() completes in unit_alloc()
Date: Fri,  1 Sep 2023 19:19:52 +0800
Message-Id: <20230901111954.1804721-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHoqXcyPFkv5VoCA--.40782S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1kWF48XF1UWr4DXr4rGrg_yoW8uw4kpF
	43Xryftw4jqF12vw17Kw4xArya9w4rG347GrW8Xr9xZrZ8Aryvgrn7Kr1YqFy3urZrJFW8
	ArWktay0gay5ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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
unit_alloc() may return NULL for preemption task as shown below:

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

Fix it by enabling IRQ after irq_work_raise() completes. An alternative
fix is using preempt_{disable|enable}_notrace() pair, but it may have
extra overhead. Another feasible fix is to only disable preemption or
IRQ before invoking irq_work_queue() and enable preemption or IRQ after
the invocation completes, but it can't handle the case when
c->low_watermark is 1.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9c49ae53deaf..962472ace98c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -734,12 +734,17 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 		}
 	}
 	local_dec(&c->active);
-	local_irq_restore(flags);
 
 	WARN_ON(cnt < 0);
 
 	if (cnt < c->low_watermark)
 		irq_work_raise(c);
+	/* Enable IRQ after the enqueue of irq work completes, so irq work
+	 * will run after IRQ is enabled and free_llist may be refilled by
+	 * irq work before other task preempts current task.
+	 */
+	local_irq_restore(flags);
+
 	return llnode;
 }
 
-- 
2.29.2


