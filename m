Return-Path: <bpf+bounces-65905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65BBB2AEDA
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5851BA416F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BFE350837;
	Mon, 18 Aug 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGk1dplm"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC0345733
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536537; cv=none; b=gf9B5dk30wUsgG/wDoWQwdNakPdwMDHeYhNLThbUYl+t4IWCHqHLgwPzmO86Ehzn3PL4fpJ3FYehtYAuXQU++7fSDGAZtCm4ECWGLMiLvNR/BJRBdZqPK87ZBacWJY0mZojrN/pTfexzGgZDDPjTLiqlPI4L37VvW/IJlJ1WADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536537; c=relaxed/simple;
	bh=iEwPyLarkYZ1SYl78PTz6f3Tq7siad3IfaAtYtYAiwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9T+G4C121ZKS83ww+VW74rI7qVtNp2v330GkCCK47fRrG1i/hqagJHwiMZbQZ72ksoh4q5858YxHYfF/w1QNlw09kFIJOcHoaZrwM0V+RseciAY3gOgBMBTV+1c4EC8aD2f0ZNBjNveStWmodU2PvC/a4PBHeasmr6fYeHBuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGk1dplm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PLsLBHEH7fH2DeVbRY37aGg0nfytx5nHxzamt/J4w8=;
	b=fGk1dplmhX8TBaKAV1v7A3rxD9Ol2v1dVG0iJpNbN08nSv/gNpwrxCdezuKtXAgWuH7pnH
	0ubEOf+1Y1+QbRYQuqvw96/rOTlUWv2I2DKvu9jhtXsjugbpPT3L17R5EjGmPe28KovF8S
	xmIqxrmPCQw+j3alA32yMAWl/zfhADM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 07/14] mm: allow specifying custom oom constraint for bpf triggers
Date: Mon, 18 Aug 2025 10:01:29 -0700
Message-ID: <20250818170136.209169-8-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently there is a hard-coded list of possible oom constraints:
NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
Also, add an ability to specify a custom constraint name
when calling bpf_out_of_memory(). If an empty string is passed
as an argument, CONSTRAINT_BPF is displayed.

The resulting output in dmesg will look like this:

[  315.224875] kworker/u17:0 invoked oom-killer: gfp_mask=0x0(), order=0, oom_score_adj=0
               oom_policy=default
[  315.226532] CPU: 1 UID: 0 PID: 74 Comm: kworker/u17:0 Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
[  315.226534] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
[  315.226536] Workqueue: bpf_psi_wq bpf_psi_handle_event_fn
[  315.226542] Call Trace:
[  315.226545]  <TASK>
[  315.226548]  dump_stack_lvl+0x4d/0x70
[  315.226555]  dump_header+0x59/0x1c6
[  315.226561]  oom_kill_process.cold+0x8/0xef
[  315.226565]  out_of_memory+0x111/0x5c0
[  315.226577]  bpf_out_of_memory+0x6f/0xd0
[  315.226580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  315.226589]  bpf_prog_3018b0cf55d2c6bb_handle_psi_event+0x5d/0x76
[  315.226594]  bpf__bpf_psi_ops_handle_psi_event+0x47/0xa7
[  315.226599]  bpf_psi_handle_event_fn+0x63/0xb0
[  315.226604]  process_one_work+0x1fc/0x580
[  315.226616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  315.226624]  worker_thread+0x1d9/0x3b0
[  315.226629]  ? __pfx_worker_thread+0x10/0x10
[  315.226632]  kthread+0x128/0x270
[  315.226637]  ? lock_release+0xd4/0x2d0
[  315.226645]  ? __pfx_kthread+0x10/0x10
[  315.226649]  ret_from_fork+0x81/0xd0
[  315.226652]  ? __pfx_kthread+0x10/0x10
[  315.226655]  ret_from_fork_asm+0x1a/0x30
[  315.226667]  </TASK>
[  315.239745] memory: usage 42240kB, limit 9007199254740988kB, failcnt 0
[  315.240231] swap: usage 0kB, limit 0kB, failcnt 0
[  315.240585] Memory cgroup stats for /cgroup-test-work-dir673/oom_test/cg2:
[  315.240603] anon 42897408
[  315.241317] file 0
[  315.241493] kernel 98304
...
[  315.255946] Tasks state (memory values in pages):
[  315.256292] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[  315.257107] [    675]     0   675   162013    10969    10712      257         0   155648        0             0 test_progs
[  315.257927] oom-kill:constraint=CONSTRAINT_BPF_PSI_MEM,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/cgroup-test-work-dir673/oom_test/cg2,task_memcg=/cgroup-test-work-dir673/oom_test/cg2,task=test_progs,pid=675,uid=0
[  315.259371] Memory cgroup out of memory: Killed process 675 (test_progs) total-vm:648052kB, anon-rss:42848kB, file-rss:1028kB, shmem-rss:0kB, UID:0 pgtables:152kB oom_score_adj:0

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/oom.h |  4 ++++
 mm/oom_kill.c       | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index ef453309b7ea..4b04944b42de 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -19,6 +19,7 @@ enum oom_constraint {
 	CONSTRAINT_CPUSET,
 	CONSTRAINT_MEMORY_POLICY,
 	CONSTRAINT_MEMCG,
+	CONSTRAINT_BPF,
 };
 
 /*
@@ -58,6 +59,9 @@ struct oom_control {
 
 	/* Policy name */
 	const char *bpf_policy_name;
+
+	/* BPF-specific constraint name */
+	const char *bpf_constraint;
 #endif
 };
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index df409f0fac45..67afcd43a5f7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -240,13 +240,6 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	return points;
 }
 
-static const char * const oom_constraint_text[] = {
-	[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
-	[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
-	[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
-	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
-};
-
 static const char *oom_policy_name(struct oom_control *oc)
 {
 #ifdef CONFIG_BPF_SYSCALL
@@ -256,6 +249,27 @@ static const char *oom_policy_name(struct oom_control *oc)
 	return "default";
 }
 
+static const char *oom_constraint_text(struct oom_control *oc)
+{
+	switch (oc->constraint) {
+	case CONSTRAINT_NONE:
+		return "CONSTRAINT_NONE";
+	case CONSTRAINT_CPUSET:
+		return "CONSTRAINT_CPUSET";
+	case CONSTRAINT_MEMORY_POLICY:
+		return "CONSTRAINT_MEMORY_POLICY";
+	case CONSTRAINT_MEMCG:
+		return "CONSTRAINT_MEMCG";
+#ifdef CONFIG_BPF_SYSCALL
+	case CONSTRAINT_BPF:
+		return oc->bpf_constraint ? : "CONSTRAINT_BPF";
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return "";
+	}
+}
+
 /*
  * Determine the type of allocation constraint.
  */
@@ -267,6 +281,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	bool cpuset_limited = false;
 	int nid;
 
+	if (oc->constraint == CONSTRAINT_BPF)
+		return CONSTRAINT_BPF;
+
 	if (is_memcg_oom(oc)) {
 		oc->totalpages = mem_cgroup_get_max(oc->memcg) ?: 1;
 		return CONSTRAINT_MEMCG;
@@ -458,7 +475,7 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 {
 	/* one line summary of the oom killer context. */
 	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
-			oom_constraint_text[oc->constraint],
+			oom_constraint_text(oc),
 			nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
 	mem_cgroup_print_oom_context(oc->memcg, victim);
@@ -1344,11 +1361,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
  * Returns a negative value if an error has been occurred.
  */
 __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
-				  int order, bool wait_on_oom_lock)
+				  int order, bool wait_on_oom_lock,
+				  const char *constraint_text__nullable)
 {
 	struct oom_control oc = {
 		.memcg = memcg__nullable,
 		.order = order,
+		.constraint = CONSTRAINT_BPF,
+		.bpf_constraint = constraint_text__nullable,
 	};
 	int ret;
 
-- 
2.50.1


