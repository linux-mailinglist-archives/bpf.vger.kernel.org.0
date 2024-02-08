Return-Path: <bpf+bounces-21502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55B84DFFD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49534B27A40
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB971B2A;
	Thu,  8 Feb 2024 11:48:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAE6BFA7;
	Thu,  8 Feb 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392912; cv=none; b=EJY47f7NCaquddQRBUhpV8x1up1w3iBHRdZ916sOJmIQ+llPihmglTzCq5kVdOoh92OSg9amI3SlTI4jwWmepWxCMDxYpGmTCvBo/66zfJ0avIRlcriOGdt6v2g5QJxl0OGcTsDMYkkAukGQ4HToI0F4ZO29D7UcwMXE4LvGxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392912; c=relaxed/simple;
	bh=lNnvn42Le0dxfnc9tfCKSniD850SfnLB8+PQT5qb2OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faH6LXU8SK1whr8nnapo24JFoFbPx1zLMzysWY9/EU919/8JooHlJpjqepigW8CwnYSOBsd2umTEJFsaszsgHexjw3HLlKt7L70dS0hWH5QYSp6FT8tnSYpYQNngQ5avjAgIRWeZMpf7HljRmjL5B3ySZQAuCWEuMqKj3DfxW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.233.118])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TVwGr1lppzfZDr;
	Thu,  8 Feb 2024 14:48:20 +0300 (MSK)
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
	Pu Lehui <pulehui@huawei.com>,
	Hou Tao <houtao1@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 1/2] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Date: Thu,  8 Feb 2024 14:47:59 +0300
Message-Id: <20240208114800.27676-2-apanov@astralinux.ru>
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
 hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrfhgrihesfhgsrdgtohhmpdhrtghpthhtohepshhonhhglhhiuhgsrhgrvhhinhhgsehfsgdrtghomhdprhgtphhtthhopeihhhhssehfsgdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgpdhrtghpthhtohepphhulhgvhhhuiheshhhurgifvghirdgtohhmpdhrtghpthhtohephhhouhhtrghoudeshhhurgifvghirdgtohhmpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.61.08090, Virus records: 12345016, Updated: 2024-Feb-08 09:34:35 UTC]

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 4369016497319a9635702da010d02af1ebb1849d ]

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
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20230711115848.2701559-1-pulehui@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 kernel/bpf/cpumap.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c61a23b564aa..2097ed9bd583 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -139,22 +139,6 @@ static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
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
 static struct sk_buff *cpu_map_build_skb(struct xdp_frame *xdpf,
 					 struct sk_buff *skb)
 {
@@ -225,6 +209,30 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
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
 static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
-- 
2.30.2


