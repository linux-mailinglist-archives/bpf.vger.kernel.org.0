Return-Path: <bpf+bounces-31301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D58FB168
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109F61C22299
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4E145A17;
	Tue,  4 Jun 2024 11:51:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76F145A06;
	Tue,  4 Jun 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501865; cv=none; b=md2vFZbu+1NZouqw5OYqqwGGsywtClyAPInnpxlUVkS3EgTGVwyWW0R6pDpazqS31/7xUYO4Iqm/lZHVepvGApG5PubS5thIxVzY9n7MOK9BRNxSX3jfe3CyBFakTpzfhmCpDjKB8qnpSP0IbLPObA45HOWWhrcXYQprceHidPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501865; c=relaxed/simple;
	bh=JT1cwdj7kPcar/9vB3M3rkQGDKpmZj4FtWdTQaiaBf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Czv/vjw0lPXbq+Mkl0glbT0Q046hT0SdLSriMYOV+YVTFbcaZ0fdDD3eKrnb3zYWEnxqhOz5oLtKqgu4TRtHSgDYpAq5KkyvA8bHdTEIsSh7e3u9X0h3ERs/l5/riyQ4yfKEJEJE17bsKdhG7WsuetBRo6RgouEEmQJM87gdO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vtpng2VG5z4f3nV1;
	Tue,  4 Jun 2024 19:50:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6D5801A01D2;
	Tue,  4 Jun 2024 19:50:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBGd_15metYuOg--.43086S4;
	Tue, 04 Jun 2024 19:50:55 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	akpm@linux-foundation.org,
	trix@redhat.com,
	dianders@chromium.org,
	luogengkun@huaweicloud.com,
	mhocko@suse.com,
	pmladek@suse.com,
	kernelfans@gmail.com,
	lecopzer.chen@mediatek.com,
	song@kernel.org,
	yaoma@linux.alibaba.com,
	tglx@linutronix.de,
	linuxppc-dev@lists.ozlabs.org,
	bpf@vger.kernel.org
Subject: [PATCH] watchdog/core: Fix AA deadlock causeb by watchdog
Date: Tue,  4 Jun 2024 11:57:36 +0000
Message-Id: <20240604115736.1013341-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBGd_15metYuOg--.43086S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArW5tFykAF47Aw4UAFWDJwb_yoW5AF47pr
	9FvFy7tw4UCr4kZayfJ3sxGry8Ca4vgr43GF4DG3yFkF1YkFn8Xrna9FnxXrZ0vrZxZF4j
	vwn0qrWfta4UtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

We found an AA deadlock problem as shown belowed:

TaskA				TaskB				WatchDog			system_wq

...
css_killed_work_fn:
P(cgroup_mutex)
...
								...
								__lockup_detector_reconfigure:
								P(cpu_hotplug_lock.read)
								...
				...
				percpu_down_write:
				P(cpu_hotplug_lock.write)
												...
												cgroup_bpf_release:
												P(cgroup_mutex)
								smp_call_on_cpu:
								Wait system_wq

cpuset_css_offline:
P(cpu_hotplug_lock.read)

WatchDog is waitting for system_wq, who is waitting for cgroup_mutex, to finish
the jobs, but the owner of the cgroup_mutex is waitting for cpu_hotplug_lock.
The key point is the cpu_hotplug_lock, cause the system_wq may be waitting other
lock. What's more, it seems that smp_call_on_cpu doesn't need protection from
cpu_hotplug_lock. I try to revert the old patch to fix this problem, but I
encountered some conflicts. Or I should just release and acquire cpu_hotplug_lock
during between smp_call_on_cpu? I'm looking forward any suggestion :).

Fixes: e31d6883f21c ("watchdog/core, powerpc: Lock cpus across reconfiguration")

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 arch/powerpc/kernel/watchdog.c | 4 ++++
 kernel/watchdog.c              | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 8c464a5d8246..f33f532ea7fa 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -550,17 +550,21 @@ void watchdog_hardlockup_stop(void)
 {
 	int cpu;
 
+	cpus_read_lock();
 	for_each_cpu(cpu, &wd_cpus_enabled)
 		stop_watchdog_on_cpu(cpu);
+	cpus_read_unlock();
 }
 
 void watchdog_hardlockup_start(void)
 {
 	int cpu;
 
+	cpus_read_lock();
 	watchdog_calc_timeouts();
 	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
 		start_watchdog_on_cpu(cpu);
+	cpus_read_unlock();
 }
 
 /*
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 51915b44ac73..13303a932cde 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -867,7 +867,6 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 
 static void __lockup_detector_reconfigure(void)
 {
-	cpus_read_lock();
 	watchdog_hardlockup_stop();
 
 	softlockup_stop_all();
@@ -877,12 +876,6 @@ static void __lockup_detector_reconfigure(void)
 		softlockup_start_all();
 
 	watchdog_hardlockup_start();
-	cpus_read_unlock();
-	/*
-	 * Must be called outside the cpus locked section to prevent
-	 * recursive locking in the perf code.
-	 */
-	__lockup_detector_cleanup();
 }
 
 void lockup_detector_reconfigure(void)
@@ -916,11 +909,9 @@ static __init void lockup_detector_setup(void)
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static void __lockup_detector_reconfigure(void)
 {
-	cpus_read_lock();
 	watchdog_hardlockup_stop();
 	lockup_detector_update_enable();
 	watchdog_hardlockup_start();
-	cpus_read_unlock();
 }
 void lockup_detector_reconfigure(void)
 {
-- 
2.34.1


