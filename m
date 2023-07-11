Return-Path: <bpf+bounces-4759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE074ED76
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6DC281839
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD618C02;
	Tue, 11 Jul 2023 11:58:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657718B10;
	Tue, 11 Jul 2023 11:58:59 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B410C4;
	Tue, 11 Jul 2023 04:58:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R0fXr087Mz4f41Rq;
	Tue, 11 Jul 2023 19:58:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP1 (Coremail) with SMTP id cCh0CgBX6DL7Q61kp17yMw--.23183S2;
	Tue, 11 Jul 2023 19:58:52 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Date: Tue, 11 Jul 2023 19:58:48 +0800
Message-Id: <20230711115848.2701559-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBX6DL7Q61kp17yMw--.23183S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fuF43Cw1kWw43Gr18Grg_yoW7Jw1UpF
	WrJr1UGr40qw4Du3y8t3WrJr10vr1kua4UJ34fG3yFyF1DG3WDXFy8GFWxJrZxurs5ury7
	Xwsrt3yqg3ykJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUOmhFUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Syzkaller reported a memory leak as follows:

BUG: memory leak
unreferenced object 0xff110001198ef748 (size 192):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 32 bytes):
    00 00 00 00 4a 19 00 00 80 ad e3 e4 fe ff c0 00  ....J...........
    00 b2 d3 0c 01 00 11 ff 28 f5 8e 19 01 00 11 ff  ........(.......
  backtrace:
    [<ffffffffadd28087>] __cpu_map_entry_alloc+0xf7/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

BUG: memory leak
unreferenced object 0xff110001198ef528 (size 192):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffadd281f0>] __cpu_map_entry_alloc+0x260/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

BUG: memory leak
unreferenced object 0xff1100010fd93d68 (size 8):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffffade5db3e>] kvmalloc_node+0x11e/0x170
    [<ffffffffadd28280>] __cpu_map_entry_alloc+0x2f0/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

In the cpu_map_update_elem flow, when kthread_stop is called before
calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
will never be executed, and rcpu->refcnt will never be 0, which will
lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
released.

Calling kthread_stop before executing kthread's threadfn will return
-EINTR. We can complete the release of memory resources in this state.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/cpumap.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a33e8747a0e..6ae02be7a48e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -122,22 +122,6 @@ static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	atomic_inc(&rcpu->refcnt);
 }
 
-/* called from workqueue, to workaround syscall using preempt_disable */
-static void cpu_map_kthread_stop(struct work_struct *work)
-{
-	struct bpf_cpu_map_entry *rcpu;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	kthread_stop(rcpu->kthread);
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -165,6 +149,30 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	}
 }
 
+/* called from workqueue, to workaround syscall using preempt_disable */
+static void cpu_map_kthread_stop(struct work_struct *work)
+{
+	struct bpf_cpu_map_entry *rcpu;
+	int err;
+
+	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
+
+	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
+	 * as it waits until all in-flight call_rcu() callbacks complete.
+	 */
+	rcu_barrier();
+
+	/* kthread_stop will wake_up_process and wait for it to complete */
+	err = kthread_stop(rcpu->kthread);
+	if (err) {
+		/* kthread_stop may be called before cpu_map_kthread_run
+		 * is executed, so we need to release the memory related
+		 * to rcpu.
+		 */
+		put_cpu_map_entry(rcpu);
+	}
+}
+
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
-- 
2.25.1


