Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F716043E1
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiJSLwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiJSLwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 07:52:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165043AB07
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 04:31:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MspNx6Vl4zKFB2
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:27:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXCzKu309jwb9lAA--.56298S5;
        Wed, 19 Oct 2022 19:29:52 +0800 (CST)
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
Subject: [PATCH bpf 1/2] bpf: Wait for busy refill_work when destorying bpf memory allocator
Date:   Wed, 19 Oct 2022 19:55:38 +0800
Message-Id: <20221019115539.983394-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019115539.983394-1-houtao@huaweicloud.com>
References: <20221019115539.983394-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXCzKu309jwb9lAA--.56298S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF17Xw13ur1rZF1UGFy3Arb_yoW5tr1xpF
        4Sqr1rGr4kZFsFv3Wfu3WxCr93AryF93W3G3ykJ3s3ur15Gryqkwn7KF1YqFyagr4Iya12
        vrsF93y0g34DX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

A busy irq work is an unfinished irq work and it can be either in the
pending state or in the running state. When destroying bpf memory
allocator, refill_work may be busy for PREEMPT_RT kernel in which irq
work is invoked in a per-CPU RT-kthread. It is also possible for kernel
with arch_irq_work_has_interrupt() being false (e.g. 1-cpu arm32 host)
and irq work is inovked in timer interrupt.

The busy refill_work leads to various issues. The obvious one is that
there will be concurrent operations on free_by_rcu and free_list between
irq work and memory draining. Another one is call_rcu_in_progress will
not be reliable for the checking of pending RCU callback because
do_call_rcu() may has not been invoked by irq work. The other is there
will be use-after-free if irq work is freed before the callback of
irq work is invoked as shown below:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 12ab94067 P4D 12ab94067 PUD 1796b4067 PMD 0
 Oops: 0010 [#1] PREEMPT_RT SMP
 CPU: 5 PID: 64 Comm: irq_work/5 Not tainted 6.0.0-rt11+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffffadc080293e78 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffcdc07fb6a388 RCX: ffffa05000a2e000
 RDX: ffffa05000a2e000 RSI: ffffffff96cc9827 RDI: ffffcdc07fb6a388
 ......
 Call Trace:
  <TASK>
  irq_work_single+0x24/0x60
  irq_work_run_list+0x24/0x30
  run_irq_workd+0x23/0x30
  smpboot_thread_fn+0x203/0x300
  kthread+0x126/0x150
  ret_from_fork+0x1f/0x30
  </TASK>

Considering the ease of concurrency handling and the short wait time
used for irq_work_sync() under PREEMPT_RT (When running two test_maps on
PREEMPT_RT kernel and 72-cpus host, the max wait time is about 8ms and
the 99th percentile is 10us), just waiting for busy refill_work to
complete before memory draining and memory freeing.

Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 94f0f63443a6..48e606aaacf0 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -497,6 +497,16 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		rcu_in_progress = 0;
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
+			/*
+			 * refill_work may be unfinished for PREEMPT_RT kernel
+			 * in which irq work is invoked in a per-CPU RT thread.
+			 * It is also possible for kernel with
+			 * arch_irq_work_has_interrupt() being false and irq
+			 * work is inovked in timer interrupt. So wait for the
+			 * completion of irq work to ease the handling of
+			 * concurrency.
+			 */
+			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
@@ -511,6 +521,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
+				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
-- 
2.29.2

