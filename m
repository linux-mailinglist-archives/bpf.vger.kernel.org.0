Return-Path: <bpf+bounces-44096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC6E9BDC5B
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BB51F24BCC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336101DED73;
	Wed,  6 Nov 2024 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnQzFHN2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C71DED62;
	Wed,  6 Nov 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859112; cv=none; b=e7ma22zUR3mJ2gFdbahFBdVYOlXLB+zrbY699f+1l4S2im7MgZIlBKVYf84EicqsXWTQ0IOT8H6+YRpuPoT5Zu7BlW3s29k3wxHLs5EQ/Ne1LDDcuFt5uRkws7WTb7NV6T64ij6ZIiVu968yPzqVvkllM2YcRtFxBUR/zg7NBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859112; c=relaxed/simple;
	bh=ti/DGWP5LfaDz6PiL4R1L6tKhTIaXEnWg44CnOfKWho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM2CPMjIZTkxQ+niPTo1g59LTfp5a1U1oqipfxVWLmp5LrD613wADQ/SwQcpbs3lKXLXHLx7g5ydW2aKh0gg8v+dFmj7WxlKeE9FLNAlbuDj5w/TGP431PDXdcamOaHeKB5T0U2q0tNrqAJHlzlCHjptos3K3YxjKa4p0qIveNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnQzFHN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59033C4CECF;
	Wed,  6 Nov 2024 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859112;
	bh=ti/DGWP5LfaDz6PiL4R1L6tKhTIaXEnWg44CnOfKWho=;
	h=From:To:Cc:Subject:Date:From;
	b=mnQzFHN2AlsXGpFsmnDDA5LQKxc3tEmxVj1gkZYlVG+h7K9bBwbODMTuByWRQCDCI
	 HR8dUrrOv9ikznzatrMWLambpk1n5QTsxCHSd1Vdjtsy5qSyDFPPJ70fmyuLtpE5e+
	 koaEHm7QPBYLrtX14UCkhx9fjYKTifUkvQGPKiybk/X9c6MD3idE36MPDYoyMMNuxz
	 Ktm8NmhQWMCxgtMiW1TZRM9/TJBlXi8LpjJvw1R2CoegaCWeIki8rjbyP86r08qm0j
	 vQ+xmuW7meRiNteGUARxHQ4UyX/vG7V4SEXZeem+s21s0tOe5A5IwG32bFRjQklKDi
	 gz366Dk4ejhsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenridong@huawei.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:11:49 -0500
Message-ID: <20241106021149.182497-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 117932eea99b729ee5d12783601a4f7f5fd58a23 Mon Sep 17 00:00:00 2001
From: Chen Ridong <chenridong@huawei.com>
Date: Tue, 8 Oct 2024 11:24:56 +0000
Subject: [PATCH] cgroup/bpf: use a dedicated workqueue for cgroup bpf
 destruction

A hung_task problem shown below was found:

INFO: task kworker/0:0:8 blocked for more than 327 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Workqueue: events cgroup_bpf_release
Call Trace:
 <TASK>
 __schedule+0x5a2/0x2050
 ? find_held_lock+0x33/0x100
 ? wq_worker_sleeping+0x9e/0xe0
 schedule+0x9f/0x180
 schedule_preempt_disabled+0x25/0x50
 __mutex_lock+0x512/0x740
 ? cgroup_bpf_release+0x1e/0x4d0
 ? cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? cgroup_bpf_release+0x1e/0x4d0
 ? mutex_lock_nested+0x2b/0x40
 ? __pfx_delay_tsc+0x10/0x10
 mutex_lock_nested+0x2b/0x40
 cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
 ? process_scheduled_works+0x161/0x8a0
 process_scheduled_works+0x23a/0x8a0
 worker_thread+0x231/0x5b0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x14d/0x1c0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x59/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

This issue can be reproduced by the following pressuse test:
1. A large number of cpuset cgroups are deleted.
2. Set cpu on and off repeatly.
3. Set watchdog_thresh repeatly.
The scripts can be obtained at LINK mentioned above the signature.

The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
acquired in different tasks, which may lead to deadlock.
It can lead to a deadlock through the following steps:
1. A large number of cpusets are deleted asynchronously, which puts a
   large number of cgroup_bpf_release works into system_wq. The max_active
   of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
   cgroup_bpf_release works, and many cgroup_bpf_release works will be put
   into inactive queue. As illustrated in the diagram, there are 256 (in
   the acvtive queue) + n (in the inactive queue) works.
2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
   smp_call_on_cpu work into system_wq. However step 1 has already filled
   system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
   to wait until the works that were put into the inacvtive queue earlier
   have executed (n cgroup_bpf_release), so it will be blocked for a while.
3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
4. Cpusets that were deleted at step 1 put cgroup_release works into
   cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
   When cgroup_metux is acqured by work at css_killed_work_fn, it will
   call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
   However, cpuset_css_offline will be blocked for step 3.
5. At this moment, there are 256 works in active queue that are
   cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
   a result, all of them are blocked. Consequently, sscs.work can not be
   executed. Ultimately, this situation leads to four processes being
   blocked, forming a deadlock.

system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
...
2000+ cgroups deleted asyn
256 actives + n inactives
				__lockup_detector_reconfigure
				P(cpu_hotplug_lock.read)
				put sscs.work into system_wq
256 + n + 1(sscs.work)
sscs.work wait to be executed
				warting sscs.work finish
								percpu_down_write
								P(cpu_hotplug_lock.write)
								...blocking...
											css_killed_work_fn
											P(cgroup_mutex)
											cpuset_css_offline
											P(cpu_hotplug_lock.read)
											...blocking...
256 cgroup_bpf_release
mutex_lock(&cgroup_mutex);
..blocking...

To fix the problem, place cgroup_bpf_release works on a dedicated
workqueue which can break the loop and solve the problem. System wqs are
for misc things which shouldn't create a large number of concurrent work
items. If something is going to generate >WQ_DFL_ACTIVE(256) concurrent
work items, it should use its own dedicated workqueue.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Cc: stable@vger.kernel.org # v5.3+
Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/cgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e7113d700b878..025d7e2214aeb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,23 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+/*
+ * cgroup bpf destruction makes heavy use of work items and there can be a lot
+ * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
+ * destruction work items don't end up filling up max_active of system_wq
+ * which may lead to deadlock.
+ */
+static struct workqueue_struct *cgroup_bpf_destroy_wq;
+
+static int __init cgroup_bpf_wq_init(void)
+{
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	if (!cgroup_bpf_destroy_wq)
+		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
+	return 0;
+}
+core_initcall(cgroup_bpf_wq_init);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -334,7 +351,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
-- 
2.43.0





