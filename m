Return-Path: <bpf+bounces-31506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBD8FF104
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4375B2905A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E2197517;
	Thu,  6 Jun 2024 15:32:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485F1667E6;
	Thu,  6 Jun 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687924; cv=none; b=DSAj0ezBZF+LOCLrWQ/w9QoDoriNRIWQ9OXR+FzIieAzh934Fi0gG4QwyXl3mCtQ004P8SvFeTOnlvt3dELFil8dg9vjw/qSi3Vd9HY77Ub02YZAxdiOixY2+jhfg9GOZY9dXRzBViDgigTdR894sYeJiu5J86yl1mlPhQrWzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687924; c=relaxed/simple;
	bh=zmNGyEPJd4agncjsLzbajet35+uF8WCH96WeoPGE/7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9P7R1IK7Z8dZcG82iTWuekiEwn+mw7nP+B+/aAAB8F0iJJAfQ5GYyMyGp/3ivxmG4NUB0OOMlL5bWt3LU0vDlrx1HTYWm7u6Gb+IgkW3mTt/nJZsDwuhrIEQ3fjMkf5uczlMMKsXLEZ2MqGZkiVg4J4xFCGbnC1BOjahqwYCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vw7bp3kldz4f3kkX;
	Thu,  6 Jun 2024 23:31:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D5B6F1A0BCC;
	Thu,  6 Jun 2024 23:31:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5j1mFmxZX2Og--.51957S4;
	Thu, 06 Jun 2024 23:31:48 +0800 (CST)
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
Subject: [PATCH] watchdog/core: Fix AA deadlock due to watchdog holding cpu_hotplug_lock and wait for wq
Date: Thu,  6 Jun 2024 15:38:28 +0000
Message-Id: <20240606153828.3261006-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5j1mFmxZX2Og--.51957S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww18tF4ktFyDAry8Kry8Xwb_yoW8tF1rpr
	9rZryUtw1UuF1vvayft39xWFy8uayvgr47Ja1DGw1SkF1rCFs8Zrnakr1aqrZ8ZrZxuF1j
	9w12vFWYqa4UtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	QVy7UUUUU==
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
				cpu_up:
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
lock. It seems unhealthy to hold a lock when waitting system_wq, because we
never know what jobs are system_wq doing. So I fix this by replace cpu_read_lock/unlock
with cpu_hotplug_disable/enable to prevent cpu offline/online.

Fixes: e31d6883f21c ("watchdog/core, powerpc: Lock cpus across reconfiguration")

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 51915b44ac73..6ac6fb8d3be0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -867,7 +867,7 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 
 static void __lockup_detector_reconfigure(void)
 {
-	cpus_read_lock();
+	cpu_hotplug_disable();
 	watchdog_hardlockup_stop();
 
 	softlockup_stop_all();
@@ -877,7 +877,7 @@ static void __lockup_detector_reconfigure(void)
 		softlockup_start_all();
 
 	watchdog_hardlockup_start();
-	cpus_read_unlock();
+	cpu_hotplug_enable();
 	/*
 	 * Must be called outside the cpus locked section to prevent
 	 * recursive locking in the perf code.
@@ -916,11 +916,11 @@ static __init void lockup_detector_setup(void)
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static void __lockup_detector_reconfigure(void)
 {
-	cpus_read_lock();
+	cpu_hotplug_disable();
 	watchdog_hardlockup_stop();
 	lockup_detector_update_enable();
 	watchdog_hardlockup_start();
-	cpus_read_unlock();
+	cpu_hotplug_enable();
 }
 void lockup_detector_reconfigure(void)
 {
-- 
2.34.1


