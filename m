Return-Path: <bpf+bounces-6312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CE767D9A
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853121C20977
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44463FE3;
	Sat, 29 Jul 2023 09:19:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8A7C;
	Sat, 29 Jul 2023 09:19:07 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC31B9;
	Sat, 29 Jul 2023 02:19:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RCf853pS2z4f3pF0;
	Sat, 29 Jul 2023 17:19:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHLaGE2cRkf9BOPA--.1627S5;
	Sat, 29 Jul 2023 17:19:02 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	houtao1@huawei.com
Subject: [PATCH bpf 1/2] bpf, cpumap: Make sure kthread is running before map update returns
Date: Sat, 29 Jul 2023 17:51:06 +0800
Message-Id: <20230729095107.1722450-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230729095107.1722450-1-houtao@huaweicloud.com>
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHLaGE2cRkf9BOPA--.1627S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UJrW5try8JryfCFW8Xrb_yoWrZrWfpF
	WSy347Gr40vw4q93y0q3Wjyr40qr4vqa1UJ340k34rA3W7K398XFWkKFyvvFy5urWkCw17
	WF4qqrWkC3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU24rWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The following warning was reported when running stress-mode enabled
xdp_redirect_cpu with some RT threads:

  ------------[ cut here ]------------
  WARNING: CPU: 4 PID: 65 at kernel/bpf/cpumap.c:135
  CPU: 4 PID: 65 Comm: kworker/4:1 Not tainted 6.5.0-rc2+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: events cpu_map_kthread_stop
  RIP: 0010:put_cpu_map_entry+0xda/0x220
  ......
  Call Trace:
   <TASK>
   ? show_regs+0x65/0x70
   ? __warn+0xa5/0x240
   ......
   ? put_cpu_map_entry+0xda/0x220
   cpu_map_kthread_stop+0x41/0x60
   process_one_work+0x6b0/0xb80
   worker_thread+0x96/0x720
   kthread+0x1a5/0x1f0
   ret_from_fork+0x3a/0x70
   ret_from_fork_asm+0x1b/0x30
   </TASK>

The root cause is the same as commit 436901649731 ("bpf: cpumap: Fix memory
leak in cpu_map_update_elem"). The kthread is stopped prematurely by
kthread_stop() in cpu_map_kthread_stop(), and kthread() doesn't call
cpu_map_kthread_run() at all but XDP program has already queued some
frames or skbs into ptr_ring. So when __cpu_map_ring_cleanup() checks
the ptr_ring, it will find it was not emptied and report a warning.

An alternative fix is to use __cpu_map_ring_cleanup() to drop these
pending frames or skbs when kthread_stop() returns -EINTR, but it may
confuse the user, because these frames or skbs have been handled
correctly by XDP program. So instead of dropping these frames or skbs,
just make sure the per-cpu kthread is running before
__cpu_map_entry_alloc() returns.

After apply the fix, the error handle for kthread_stop() will be
unnecessary because it will always return 0, so just remove it.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cpumap.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 0a16e30b16ef..08351e0863e5 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
+#include <linux/completion.h>
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
 
@@ -71,6 +72,7 @@ struct bpf_cpu_map_entry {
 	struct rcu_head rcu;
 
 	struct work_struct kthread_stop_wq;
+	struct completion kthread_running;
 };
 
 struct bpf_cpu_map {
@@ -151,7 +153,6 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 static void cpu_map_kthread_stop(struct work_struct *work)
 {
 	struct bpf_cpu_map_entry *rcpu;
-	int err;
 
 	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
 
@@ -161,14 +162,7 @@ static void cpu_map_kthread_stop(struct work_struct *work)
 	rcu_barrier();
 
 	/* kthread_stop will wake_up_process and wait for it to complete */
-	err = kthread_stop(rcpu->kthread);
-	if (err) {
-		/* kthread_stop may be called before cpu_map_kthread_run
-		 * is executed, so we need to release the memory related
-		 * to rcpu.
-		 */
-		put_cpu_map_entry(rcpu);
-	}
+	kthread_stop(rcpu->kthread);
 }
 
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
@@ -296,11 +290,11 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	return nframes;
 }
 
-
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
 
+	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	/* When kthread gives stop order, then rcpu have been disconnected
@@ -465,6 +459,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 		goto free_ptr_ring;
 
 	/* Setup kthread */
+	init_completion(&rcpu->kthread_running);
 	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
 					       "cpumap/%d/map:%d", cpu,
 					       map->id);
@@ -478,6 +473,12 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	kthread_bind(rcpu->kthread, cpu);
 	wake_up_process(rcpu->kthread);
 
+	/* Make sure kthread has been running, so kthread_stop() will not
+	 * stop the kthread prematurely and all pending frames or skbs
+	 * will be handled by the kthread before kthread_stop() returns.
+	 */
+	wait_for_completion(&rcpu->kthread_running);
+
 	return rcpu;
 
 free_prog:
-- 
2.29.2


