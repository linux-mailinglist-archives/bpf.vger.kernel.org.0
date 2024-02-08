Return-Path: <bpf+bounces-21503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60784DFFE
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEF81C22E2B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5474E01;
	Thu,  8 Feb 2024 11:48:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34D6F095;
	Thu,  8 Feb 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392913; cv=none; b=en27UQYCmC2Yn2QlB7RJ62N6ncuvMWYWMp4rTBvqYxAfNTFyh0vmeIPBNTjxm8RnZox82jzxvFIW4pDWWiA6YKZmq4J7UU+7uAFrk2elTe8MPbTil1U8ZFAfOUapsfsWj8bi1Ubq3aWYjqyE0tlJTNzCLt5bNl7mxTjPlRrTNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392913; c=relaxed/simple;
	bh=tIcxlaynASNxUtEmPx4UvmCBfpJO5p2cP96FiPLo3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jmr8XTvANK5Wtyw3mlEOXmaTDNbeG4BZpzly9WQmbtzj80szs1Fdr2WvN5owodz/A7oQN0aeu65MY0tVd932utFxtJhVupze8YEj8zGmbn74liiV4o5qkG1fEn0stC0pe7kFcN+7X7pxlwc5oppr4VOMbIkN4PZlIKNdvSRVl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.233.118])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TVwGs45C9zfZJT;
	Thu,  8 Feb 2024 14:48:21 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 5.10 2/2] bpf, cpumap: Make sure kthread is running before map update returns
Date: Thu,  8 Feb 2024 14:48:00 +0300
Message-Id: <20240208114800.27676-3-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240208114800.27676-1-apanov@astralinux.ru>
References: <20240208114800.27676-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigvhicurfgrnhhovhcuoegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepteeigfefledvueefgfdvieejgefgieeiiefggeekueejheefvdekvdefhfduudetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtrddujeejrddvfeefrdduudeknecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdduheeijedtfedrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvdeffedruddukeemgeefjedtvddpmhgrihhlfhhrohhmpegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghprghnohhvsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpd
 hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrfhgrihesfhgsrdgtohhmpdhrtghpthhtohepshhonhhglhhiuhgsrhgrvhhinhhgsehfsgdrtghomhdprhgtphhtthhopeihhhhssehfsgdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgpdhrtghpthhtohephhhouhhtrghoudeshhhurgifvghirdgtohhmpdhrtghpthhtohepphhulhgvhhhuiheshhhurgifvghirdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehkvghrnhgvlhdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.61.08090, Virus records: 12345016, Updated: 2024-Feb-08 09:34:35 UTC]

From: Hou Tao <houtao1@huawei.com>

commit 640a604585aa30f93e39b17d4d6ba69fcb1e66c9 upstream.

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
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/20230729095107.1722450-2-houtao@huaweicloud.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 kernel/bpf/cpumap.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 2097ed9bd583..f54b7321a7bc 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -25,6 +25,7 @@
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/capability.h>
+#include <linux/completion.h>
 #include <trace/events/xdp.h>
 
 #include <linux/netdevice.h>   /* netif_receive_skb_core */
@@ -69,6 +70,7 @@ struct bpf_cpu_map_entry {
 	struct rcu_head rcu;
 
 	struct work_struct kthread_stop_wq;
+	struct completion kthread_running;
 };
 
 struct bpf_cpu_map {
@@ -213,7 +215,6 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 static void cpu_map_kthread_stop(struct work_struct *work)
 {
 	struct bpf_cpu_map_entry *rcpu;
-	int err;
 
 	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
 
@@ -223,14 +224,7 @@ static void cpu_map_kthread_stop(struct work_struct *work)
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
 
 static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
@@ -308,6 +302,7 @@ static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
 
+	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	/* When kthread gives stop order, then rcpu have been disconnected
@@ -462,6 +457,7 @@ __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u32 cpu, int map_id)
 		goto free_ptr_ring;
 
 	/* Setup kthread */
+	init_completion(&rcpu->kthread_running);
 	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
 					       "cpumap/%d/map:%d", cpu, map_id);
 	if (IS_ERR(rcpu->kthread))
@@ -474,6 +470,12 @@ __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u32 cpu, int map_id)
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
2.30.2


