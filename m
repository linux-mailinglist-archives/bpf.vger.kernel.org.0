Return-Path: <bpf+bounces-56729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A0CA9D328
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22904C4144
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9A222599;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E33221FC4;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613675; cv=none; b=PwKLc6syicIkyocS4cDNq3gQO4+c9sCnzlDVgtGxLg/XOyi4gOQvRxlwnBhyrxhWarc65hQMmE8hBfnh7YlGHzud4fnsF3IE/WCRyt82jMl2Pphte80unaoKxPEd2aCWCX8uwrUOEBqWFHNb/KYfsXv6XVe+JNpc4WX+LB1tAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613675; c=relaxed/simple;
	bh=jPdKwUpsmRQC+BN2lveV1Gx1mRYsxKjox7ip1iae73I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aGUc9kVaG1499gKGfbug+Oc8Oth6c5wYBv9HwT09ZyvKtkSpkYp9tuMdnEMacYeUjc/eiMBjyp+CQyDqCskOSpDVF2wgU0Ek5DuhCm1zS3QlsfCjEZMZcw/xyluqdXwvqlwgM8P0K/hY3Tv1igmb5XjwZ8k6wuwNp+HE6huzboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A2C4CEEB;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8PtB-000000004Re-3sYB;
	Fri, 25 Apr 2025 16:43:13 -0400
Message-ID: <20250425204313.784243618@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 16:41:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org,
 Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org,
 Tejun Heo <tj@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: [RFC][PATCH 2/2] treewide: Have the task->flags & PF_KTHREAD check use the helper
 functions
References: <20250425204120.639530125@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Getting the check if a task is a kernel thread or a user thread can be
error prone as it's not easy to see the difference.

	if (!(task->flags & PF_KTHREAD))

Is not immediately obvious that it's checking for a user thread.

	if (is_user_thread(task))

Is much easier to review, as it is obvious that it is checking if the task
is a user thread.

Using a coccinelle script, convert these checks over to using either
is_user_thread() or is_kernel_thread().

  $ cat kthread.cocci
  @@
  identifier task;
  @@
  -	!(task->flags & PF_KTHREAD)
  +	is_user_thread(task)
  @@
  identifier task;
  @@
  -	(task->flags & PF_KTHREAD) == 0
  +	is_user_thread(task)
  @@
  identifier task;
  @@
  -	(task->flags & PF_KTHREAD) != 0
  +	is_kernel_thread(task)
  @@
  identifier task;
  @@
  -	task->flags & PF_KTHREAD
  +	is_kernel_thread(task)

  $ spatch --dir --include-headers kthread.cocci . > /tmp/t.patch
  $ patch -p1 < /tmp/t.patch

Make sure to undo the conversion of the helper functions themselves!

  $ git show include/linux/sched.h | patch -p1 -R

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm/mm/init.c                         |  2 +-
 arch/arm64/include/asm/uaccess.h           |  2 +-
 arch/arm64/kernel/process.c                |  2 +-
 arch/arm64/kernel/proton-pack.c            |  2 +-
 arch/mips/kernel/process.c                 |  2 +-
 arch/powerpc/kernel/process.c              |  2 +-
 arch/powerpc/kernel/stacktrace.c           |  2 +-
 arch/x86/kernel/fpu/core.c                 |  2 +-
 arch/x86/kernel/process.c                  |  2 +-
 block/blk-cgroup.c                         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
 drivers/md/dm-vdo/logger.c                 |  2 +-
 drivers/tty/sysrq.c                        |  2 +-
 fs/bcachefs/clock.c                        |  2 +-
 fs/bcachefs/journal_reclaim.c              |  2 +-
 fs/bcachefs/move.c                         |  6 +++---
 fs/exec.c                                  |  2 +-
 fs/file_table.c                            |  2 +-
 fs/namespace.c                             |  2 +-
 fs/proc/array.c                            |  4 ++--
 fs/proc/base.c                             |  6 +++---
 io_uring/io_uring.c                        |  2 +-
 kernel/cgroup/cgroup.c                     |  6 +++---
 kernel/cgroup/freezer.c                    |  4 ++--
 kernel/events/core.c                       |  2 +-
 kernel/exit.c                              |  2 +-
 kernel/fork.c                              |  6 +++---
 kernel/freezer.c                           |  4 ++--
 kernel/futex/pi.c                          |  2 +-
 kernel/kthread.c                           | 12 ++++++------
 kernel/livepatch/transition.c              |  2 +-
 kernel/power/process.c                     |  2 +-
 kernel/sched/core.c                        |  6 +++---
 kernel/sched/idle.c                        |  2 +-
 kernel/sched/sched.h                       |  4 ++--
 kernel/signal.c                            |  4 ++--
 kernel/stacktrace.c                        |  2 +-
 lib/is_single_threaded.c                   |  2 +-
 mm/memcontrol.c                            |  2 +-
 mm/oom_kill.c                              |  4 ++--
 mm/page_alloc.c                            |  2 +-
 mm/vmscan.c                                |  2 +-
 security/keys/request_key.c                |  2 +-
 security/smack/smack_access.c              |  2 +-
 security/smack/smack_lsm.c                 |  4 ++--
 security/tomoyo/network.c                  |  2 +-
 security/yama/yama_lsm.c                   |  2 +-
 tools/sched_ext/scx_central.bpf.c          |  2 +-
 tools/sched_ext/scx_flatcg.bpf.c           |  2 +-
 tools/sched_ext/scx_qmap.bpf.c             |  2 +-
 50 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 54bdca025c9f..48f8a9703910 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -390,7 +390,7 @@ static void update_sections_early(struct section_perm perms[], int n)
 	struct task_struct *t, *s;
 
 	for_each_process(t) {
-		if (t->flags & PF_KTHREAD)
+		if (is_kernel_thread(t))
 			continue;
 		for_each_thread(t, s)
 			if (s->mm)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5b91803201ef..d04e5e8e09b4 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -43,7 +43,7 @@ static inline int access_ok(const void __user *addr, unsigned long size)
 	 * the user address before checking.
 	 */
 	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
-	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
+	    (is_kernel_thread(current) || test_thread_flag(TIF_TAGGED_ADDR)))
 		addr = untagged_addr(addr);
 
 	return likely(__access_ok(addr, size));
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42faebb7b712..0489bc69b434 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -514,7 +514,7 @@ static void ssbs_thread_switch(struct task_struct *next)
 	 * Nothing to do for kernel threads, but 'regs' may be junk
 	 * (e.g. idle task) so check the flags and bail early.
 	 */
-	if (unlikely(next->flags & PF_KTHREAD))
+	if (unlikely(is_kernel_thread(next)))
 		return;
 
 	/*
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index b198dde79e59..032e10445570 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -666,7 +666,7 @@ static void __update_pstate_ssbs(struct pt_regs *regs, bool state)
 void spectre_v4_enable_task_mitigation(struct task_struct *tsk)
 {
 	struct pt_regs *regs = task_pt_regs(tsk);
-	bool ssbs = false, kthread = tsk->flags & PF_KTHREAD;
+	bool ssbs = false, kthread = is_kernel_thread(tsk);
 
 	if (spectre_v4_mitigations_off())
 		ssbs = true;
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b630604c577f..6b4e9d371c4e 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -74,7 +74,7 @@ void exit_thread(struct task_struct *tsk)
 	 * User threads may have allocated a delay slot emulation frame.
 	 * If so, clean up that allocation.
 	 */
-	if (!(current->flags & PF_KTHREAD))
+	if (is_user_thread(current))
 		dsemul_thread_cleanup(tsk);
 }
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ef91f71e07c4..d84466e5f376 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1770,7 +1770,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	klp_init_thread_info(p);
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(p))) {
 		/* kernel thread */
 
 		/* Create initial minimum stack frame. */
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 90882b5175cd..6290d095425d 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -76,7 +76,7 @@ int __no_sanitize_address arch_stack_walk_reliable(stack_trace_consume_fn consum
 	stack_end = stack_page + THREAD_SIZE;
 
 	// See copy_thread() for details.
-	if (task->flags & PF_KTHREAD)
+	if (is_kernel_thread(task))
 		stack_end -= STACK_FRAME_MIN_SIZE;
 	else
 		stack_end -= STACK_USER_INT_FRAME_SIZE;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 91d6341f281f..90a32738842f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -805,7 +805,7 @@ void fpregs_lock_and_load(void)
 	 * Warn about it.
 	 */
 	WARN_ON_ONCE(!irq_fpu_usable());
-	WARN_ON_ONCE(current->flags & PF_KTHREAD);
+	WARN_ON_ONCE(is_kernel_thread(current));
 
 	fpregs_lock();
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 962c3ce39323..e15fb4e260c5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -220,7 +220,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	fpu_clone(p, clone_flags, args->fn, new_ssp);
 
 	/* Kernel thread ? */
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(p))) {
 		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
 		kthread_frame_init(frame, args->fn, args->fn_arg);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5905f277057b..48e39fa3d3ad 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2061,7 +2061,7 @@ void blkcg_maybe_throttle_current(void)
  */
 void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
 {
-	if (unlikely(current->flags & PF_KTHREAD))
+	if (unlikely(is_kernel_thread(current)))
 		return;
 
 	if (current->throttle_disk != disk) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..4df0691e5e1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -279,7 +279,7 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
 			pagefault_disable();				\
 			if ((mmptr) == current->mm) {			\
 				valid = !get_user((dst), (wptr));	\
-			} else if (current->flags & PF_KTHREAD) {	\
+			} else if (is_kernel_thread(current)) {	\
 				kthread_use_mm(mmptr);			\
 				valid = !get_user((dst), (wptr));	\
 				kthread_unuse_mm(mmptr);		\
diff --git a/drivers/md/dm-vdo/logger.c b/drivers/md/dm-vdo/logger.c
index 3f7dc2cb6b98..56f94f997487 100644
--- a/drivers/md/dm-vdo/logger.c
+++ b/drivers/md/dm-vdo/logger.c
@@ -137,7 +137,7 @@ static void emit_log_message(int priority, const char *module, const char *prefi
 	 * If it's a kernel thread and the module name is a prefix of its name, assume it is ours
 	 * and only identify the thread.
 	 */
-	if (((current->flags & PF_KTHREAD) != 0) &&
+	if ((is_kernel_thread(current)) &&
 	    (strncmp(module, current->comm, strlen(module)) == 0)) {
 		emit_log_message_to_kernel(priority, "%s: %s%pV%pV\n", current->comm,
 					   prefix, vaf1, vaf2);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6853c4660e7c..69ccce95052c 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -360,7 +360,7 @@ static void send_sig_all(int sig)
 
 	read_lock(&tasklist_lock);
 	for_each_process(p) {
-		if (p->flags & PF_KTHREAD)
+		if (is_kernel_thread(p))
 			continue;
 		if (is_global_init(p))
 			continue;
diff --git a/fs/bcachefs/clock.c b/fs/bcachefs/clock.c
index d6dd12d74d4f..90a8f3134ea4 100644
--- a/fs/bcachefs/clock.c
+++ b/fs/bcachefs/clock.c
@@ -93,7 +93,7 @@ void bch2_io_clock_schedule_timeout(struct io_clock *clock, u64 until)
 void bch2_kthread_io_clock_wait(struct io_clock *clock,
 				u64 io_until, unsigned long cpu_timeout)
 {
-	bool kthread = (current->flags & PF_KTHREAD) != 0;
+	bool kthread = is_kernel_thread(current);
 	struct io_clock_wait wait = {
 		.io_timer.expire	= io_until,
 		.io_timer.fn		= io_clock_wait_fn,
diff --git a/fs/bcachefs/journal_reclaim.c b/fs/bcachefs/journal_reclaim.c
index 5d1547aa118a..bc7aec50c05b 100644
--- a/fs/bcachefs/journal_reclaim.c
+++ b/fs/bcachefs/journal_reclaim.c
@@ -665,7 +665,7 @@ static int __bch2_journal_reclaim(struct journal *j, bool direct, bool kicked)
 {
 	struct bch_fs *c = container_of(j, struct bch_fs, journal);
 	struct btree_cache *bc = &c->btree_cache;
-	bool kthread = (current->flags & PF_KTHREAD) != 0;
+	bool kthread = is_kernel_thread(current);
 	u64 seq_to_flush;
 	size_t min_nr, min_key_cache, nr_flushed;
 	unsigned flags;
diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
index fc396b9fa754..55e88842d5fc 100644
--- a/fs/bcachefs/move.c
+++ b/fs/bcachefs/move.c
@@ -487,7 +487,7 @@ int bch2_move_get_io_opts_one(struct btree_trans *trans,
 int bch2_move_ratelimit(struct moving_context *ctxt)
 {
 	struct bch_fs *c = ctxt->trans->c;
-	bool is_kthread = current->flags & PF_KTHREAD;
+	bool is_kthread = is_kernel_thread(current);
 	u64 delay;
 
 	if (ctxt->wait_on_copygc && c->copygc_running) {
@@ -749,7 +749,7 @@ static int __bch2_move_data_phys(struct moving_context *ctxt,
 {
 	struct btree_trans *trans = ctxt->trans;
 	struct bch_fs *c = trans->c;
-	bool is_kthread = current->flags & PF_KTHREAD;
+	bool is_kthread = is_kernel_thread(current);
 	struct bch_io_opts io_opts = bch2_opts_to_inode_opts(c->opts);
 	struct btree_iter iter = {}, bp_iter = {};
 	struct bkey_buf sk;
@@ -961,7 +961,7 @@ static int bch2_move_btree(struct bch_fs *c,
 			   move_btree_pred pred, void *arg,
 			   struct bch_move_stats *stats)
 {
-	bool kthread = (current->flags & PF_KTHREAD) != 0;
+	bool kthread = is_kernel_thread(current);
 	struct bch_io_opts io_opts = bch2_opts_to_inode_opts(c->opts);
 	struct moving_context ctxt;
 	struct btree_trans *trans;
diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..7c308786a1ed 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1983,7 +1983,7 @@ int kernel_execve(const char *kernel_filename,
 	int retval;
 
 	/* It is non-sense for kernel threads to call execve */
-	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
+	if (WARN_ON_ONCE(is_kernel_thread(current)))
 		return -EINVAL;
 
 	filename = getname_kernel(kernel_filename);
diff --git a/fs/file_table.c b/fs/file_table.c
index c04ed94cdc4b..e3332cc9091a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -521,7 +521,7 @@ static void __fput_deferred(struct file *file)
 		return;
 	}
 
-	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+	if (likely(!in_interrupt() && is_user_thread(task))) {
 		init_task_work(&file->f_task_work, ____fput);
 		if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
 			return;
diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..5e7ab6b9d9ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1509,7 +1509,7 @@ static void mntput_no_expire(struct mount *mnt)
 
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task = current;
-		if (likely(!(task->flags & PF_KTHREAD))) {
+		if (likely(is_user_thread(task))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
 			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
 				return;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..478f8f380240 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -106,7 +106,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	 */
 	if (p->flags & PF_WQ_WORKER)
 		wq_worker_comm(tcomm, sizeof(tcomm), p);
-	else if (p->flags & PF_KTHREAD)
+	else if (is_kernel_thread(p))
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
 		get_task_comm(tcomm, p);
@@ -221,7 +221,7 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 #endif
 	seq_putc(m, '\n');
 
-	seq_printf(m, "Kthread:\t%c\n", p->flags & PF_KTHREAD ? '1' : '0');
+	seq_printf(m, "Kthread:\t%c\n", is_kernel_thread(p) ? '1' : '0');
 }
 
 void render_sigset_t(struct seq_file *m, const char *header,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b0d4e1908b22..43270431edfe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1179,7 +1179,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 				continue;
 
 			/* do not touch kernel threads or the global init */
-			if (p->flags & PF_KTHREAD || is_global_init(p))
+			if (is_kernel_thread(p) || is_global_init(p))
 				continue;
 
 			task_lock(p);
@@ -1330,7 +1330,7 @@ static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
 	int rv;
 
 	/* Don't let kthreads write their own loginuid */
-	if (current->flags & PF_KTHREAD)
+	if (is_kernel_thread(current))
 		return -EPERM;
 
 	rcu_read_lock();
@@ -1876,7 +1876,7 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	kuid_t uid;
 	kgid_t gid;
 
-	if (unlikely(task->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(task))) {
 		*ruid = GLOBAL_ROOT_UID;
 		*rgid = GLOBAL_ROOT_GID;
 		return;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c6209fe44cb1..27de67fc2642 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -523,7 +523,7 @@ static void io_queue_iowq(struct io_kiocb *req)
 
 	BUG_ON(!tctx);
 
-	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
+	if (is_kernel_thread(current) || !tctx->io_wq) {
 		io_req_task_queue_fail(req, -ECANCELED);
 		return;
 	}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3caf2cd86e65..32489f321605 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4033,7 +4033,7 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
 	while ((task = css_task_iter_next(&it))) {
 		/* Ignore kernel threads here. */
-		if (task->flags & PF_KTHREAD)
+		if (is_kernel_thread(task))
 			continue;
 
 		/* Skip tasks that are already dying. */
@@ -6718,7 +6718,7 @@ void cgroup_post_fork(struct task_struct *child,
 		cset = NULL;
 	}
 
-	if (!(child->flags & PF_KTHREAD)) {
+	if (is_user_thread(child)) {
 		if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
 			/*
 			 * If the cgroup has to be frozen, the new task has
@@ -6800,7 +6800,7 @@ void cgroup_exit(struct task_struct *tsk)
 		dec_dl_tasks_cs(tsk);
 
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
-	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
+	if (unlikely(is_user_thread(tsk) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
 
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..cc216173b355 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -196,7 +196,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
 		 * Ignore kernel threads here. Freezing cgroups containing
 		 * kthreads isn't supported.
 		 */
-		if (task->flags & PF_KTHREAD)
+		if (is_kernel_thread(task))
 			continue;
 		cgroup_freeze_task(task, freeze);
 	}
@@ -224,7 +224,7 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	/*
 	 * Kernel threads are not supposed to be frozen at all.
 	 */
-	if (task->flags & PF_KTHREAD)
+	if (is_kernel_thread(task))
 		return;
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e93c19565914..9c482e6f51ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7317,7 +7317,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (is_user_thread(current)) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
diff --git a/kernel/exit.c b/kernel/exit.c
index 1b51dc099f1e..5c10f9ea39d7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -533,7 +533,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	for_each_process(g) {
 		if (atomic_read(&mm->mm_users) <= 1)
 			break;
-		if (g->flags & PF_KTHREAD)
+		if (is_kernel_thread(g))
 			continue;
 		if (try_to_set_owner(g, mm))
 			goto ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..e3a844a7d55b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -586,7 +586,7 @@ void free_task(struct task_struct *tsk)
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
 	arch_release_task_struct(tsk);
-	if (tsk->flags & PF_KTHREAD)
+	if (is_kernel_thread(tsk))
 		free_kthread_struct(tsk);
 	bpf_task_storage_free(tsk);
 	free_task_struct(tsk);
@@ -1545,7 +1545,7 @@ struct file *get_task_exe_file(struct task_struct *task)
 	struct file *exe_file = NULL;
 	struct mm_struct *mm;
 
-	if (task->flags & PF_KTHREAD)
+	if (is_kernel_thread(task))
 		return NULL;
 
 	task_lock(task);
@@ -1570,7 +1570,7 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 {
 	struct mm_struct *mm;
 
-	if (task->flags & PF_KTHREAD)
+	if (is_kernel_thread(task))
 		return NULL;
 
 	task_lock(task);
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..136008461ee0 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -46,7 +46,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (pm_nosig_freezing || cgroup_freezing(p))
 		return true;
 
-	if (pm_freezing && !(p->flags & PF_KTHREAD))
+	if (pm_freezing && is_user_thread(p))
 		return true;
 
 	return false;
@@ -170,7 +170,7 @@ bool freeze_task(struct task_struct *p)
 		return false;
 	}
 
-	if (!(p->flags & PF_KTHREAD))
+	if (is_user_thread(p))
 		fake_signal_wake_up(p);
 	else
 		wake_up_state(p, TASK_NORMAL);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 7a941845f7ee..dcbe6c6927d0 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -428,7 +428,7 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	if (!p)
 		return handle_exit_race(uaddr, uval, NULL);
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(p))) {
 		put_task_struct(p);
 		return -EPERM;
 	}
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 77c44924cf54..1f2b28076345 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -81,7 +81,7 @@ enum KTHREAD_BITS {
 
 static inline struct kthread *to_kthread(struct task_struct *k)
 {
-	WARN_ON(!(k->flags & PF_KTHREAD));
+	WARN_ON(is_user_thread(k));
 	return k->worker_private;
 }
 
@@ -99,7 +99,7 @@ static inline struct kthread *to_kthread(struct task_struct *k)
 static inline struct kthread *__to_kthread(struct task_struct *p)
 {
 	void *kthread = p->worker_private;
-	if (kthread && !(p->flags & PF_KTHREAD))
+	if (kthread && is_user_thread(p))
 		kthread = NULL;
 	return kthread;
 }
@@ -1601,7 +1601,7 @@ void kthread_use_mm(struct mm_struct *mm)
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
 
-	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
+	WARN_ON_ONCE(is_user_thread(tsk));
 	WARN_ON_ONCE(tsk->mm);
 
 	/*
@@ -1646,7 +1646,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 {
 	struct task_struct *tsk = current;
 
-	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
+	WARN_ON_ONCE(is_user_thread(tsk));
 	WARN_ON_ONCE(!tsk->mm);
 
 	task_lock(tsk);
@@ -1686,7 +1686,7 @@ void kthread_associate_blkcg(struct cgroup_subsys_state *css)
 {
 	struct kthread *kthread;
 
-	if (!(current->flags & PF_KTHREAD))
+	if (is_user_thread(current))
 		return;
 	kthread = to_kthread(current);
 	if (!kthread)
@@ -1712,7 +1712,7 @@ struct cgroup_subsys_state *kthread_blkcg(void)
 {
 	struct kthread *kthread;
 
-	if (current->flags & PF_KTHREAD) {
+	if (is_kernel_thread(current)) {
 		kthread = to_kthread(current);
 		if (kthread)
 			return kthread->blkcg_css;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index ba069459c101..f5bf80b9d768 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -423,7 +423,7 @@ static void klp_send_signals(void)
 		 * Meanwhile the task could migrate itself and the action
 		 * would be meaningless. It is not serious though.
 		 */
-		if (task->flags & PF_KTHREAD) {
+		if (is_kernel_thread(task)) {
 			/*
 			 * Wake up a kthread which sleeps interruptedly and
 			 * still has not been migrated.
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067d9ae6..b3fe1067bfed 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -223,7 +223,7 @@ void thaw_kernel_threads(void)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
-		if (p->flags & PF_KTHREAD)
+		if (is_kernel_thread(p))
 			__thaw_task(p);
 	}
 	read_unlock(&tasklist_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c81cf642dba0..baea079e930f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2448,7 +2448,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
+	if (is_user_thread(p))
 		return cpu_active(cpu);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
@@ -3074,7 +3074,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 {
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
-	bool kthread = p->flags & PF_KTHREAD;
+	bool kthread = is_kernel_thread(p);
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -8895,7 +8895,7 @@ void normalize_rt_tasks(void)
 		/*
 		 * Only normalize user tasks:
 		 */
-		if (p->flags & PF_KTHREAD)
+		if (is_kernel_thread(p))
 			continue;
 
 		p->se.exec_start = 0;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 2c85c86b455f..adb6afc1a7c5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -387,7 +387,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	 */
 	WARN_ON_ONCE(current->policy != SCHED_FIFO);
 	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
-	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	WARN_ON_ONCE(is_user_thread(current));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
 	WARN_ON_ONCE(!duration_ns);
 	WARN_ON_ONCE(current->mm);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f34ea70..cb835fc6854c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2571,7 +2571,7 @@ static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
 		return false;
 
 	/* Can @cpu run a user thread? */
-	if (!(p->flags & PF_KTHREAD) && !task_cpu_possible(cpu, p))
+	if (is_user_thread(p) && !task_cpu_possible(cpu, p))
 		return false;
 
 	return true;
@@ -3556,7 +3556,7 @@ static inline void membarrier_switch_mm(struct rq *rq,
 #ifdef CONFIG_SMP
 static inline bool is_per_cpu_kthread(struct task_struct *p)
 {
-	if (!(p->flags & PF_KTHREAD))
+	if (is_user_thread(p))
 		return false;
 
 	if (p->nr_cpus_allowed != 1)
diff --git a/kernel/signal.c b/kernel/signal.c
index f8859faa26c5..0157f2c55158 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -96,7 +96,7 @@ static bool sig_task_ignored(struct task_struct *t, int sig, bool force)
 		return true;
 
 	/* Only allow kernel generated signals to this kthread */
-	if (unlikely((t->flags & PF_KTHREAD) &&
+	if (unlikely(is_kernel_thread(t) &&
 		     (handler == SIG_KTHREAD_KERNEL) && !force))
 		return true;
 
@@ -1067,7 +1067,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	/*
 	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
 	 */
-	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || is_kernel_thread(t))
 		goto out_set;
 
 	/*
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..f1e886c77f95 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -229,7 +229,7 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	};
 
 	/* Trace user stack if not a kernel thread */
-	if (current->flags & PF_KTHREAD)
+	if (is_kernel_thread(current))
 		return 0;
 
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
index 8c98b20bfc41..45321514da12 100644
--- a/lib/is_single_threaded.c
+++ b/lib/is_single_threaded.c
@@ -28,7 +28,7 @@ bool current_is_single_threaded(void)
 	ret = false;
 	rcu_read_lock();
 	for_each_process(p) {
-		if (unlikely(p->flags & PF_KTHREAD))
+		if (unlikely(is_kernel_thread(p)))
 			continue;
 		if (unlikely(p == task->group_leader))
 			continue;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c96c1f2b9cf5..2195ee072e7f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2555,7 +2555,7 @@ static struct obj_cgroup *current_objcg_update(void)
 		}
 
 		/* If new objcg is NULL, no reason for the second atomic update. */
-		if (!current->mm || (current->flags & PF_KTHREAD))
+		if (!current->mm || is_kernel_thread(current))
 			return NULL;
 
 		/*
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..681cf8ac0f1a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -164,7 +164,7 @@ static bool oom_unkillable_task(struct task_struct *p)
 {
 	if (is_global_init(p))
 		return true;
-	if (p->flags & PF_KTHREAD)
+	if (is_kernel_thread(p))
 		return true;
 	return false;
 }
@@ -987,7 +987,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		 * No kthread_use_mm() user needs to read from the userspace so
 		 * we are ok to reap it.
 		 */
-		if (unlikely(p->flags & PF_KTHREAD))
+		if (unlikely(is_kernel_thread(p)))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5669baf2a6fe..2486e2d33cc4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -590,7 +590,7 @@ static inline struct capture_control *task_capc(struct zone *zone)
 	struct capture_control *capc = current->capture_control;
 
 	return unlikely(capc) &&
-		!(current->flags & PF_KTHREAD) &&
+		is_user_thread(current) &&
 		!capc->page &&
 		capc->cc->zone == zone ? capc : NULL;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3783e45bfc92..3169463c5eb6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6478,7 +6478,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * committing a transaction where throttling it could forcing other
 	 * processes to block on log_wait_commit().
 	 */
-	if (current->flags & PF_KTHREAD)
+	if (is_kernel_thread(current))
 		goto out;
 
 	/*
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18..befed0968068 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -39,7 +39,7 @@ static void cache_requested_key(struct key *key)
 	struct task_struct *t = current;
 
 	/* Do not cache key if it is a kernel thread */
-	if (!(t->flags & PF_KTHREAD)) {
+	if (is_user_thread(t)) {
 		key_put(t->cached_requested_key);
 		t->cached_requested_key = key_get(key);
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 2e4a0cb22782..971f8cc7ad9c 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -697,7 +697,7 @@ bool smack_privileged(int cap)
 	/*
 	 * All kernel tasks are privileged
 	 */
-	if (unlikely(current->flags & PF_KTHREAD))
+	if (unlikely(is_kernel_thread(current)))
 		return true;
 
 	return smack_privileged_cred(cap, current_cred());
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..53b10b9ba5d0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2408,7 +2408,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	/*
 	 * Sockets created by kernel threads receive web label.
 	 */
-	if (unlikely(current->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(current))) {
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	} else {
@@ -2950,7 +2950,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Sockets created by kernel threads receive web label.
 	 */
-	if (unlikely(current->flags & PF_KTHREAD)) {
+	if (unlikely(is_kernel_thread(current))) {
 		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 8dc61335f65e..9e63cf45c200 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -613,7 +613,7 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
 static bool tomoyo_kernel_service(void)
 {
 	/* Nothing to do if I am a kernel service. */
-	return current->flags & PF_KTHREAD;
+	return is_kernel_thread(current);
 }
 
 /**
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..c3b72dd8e86c 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -79,7 +79,7 @@ static void report_access(const char *access, struct task_struct *target,
 
 	assert_spin_locked(&target->alloc_lock); /* for target->comm */
 
-	if (current->flags & PF_KTHREAD) {
+	if (is_kernel_thread(current)) {
 		/* I don't think kthreads call task_work_run() before exiting.
 		 * Imagine angry ranting about procfs here.
 		 */
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 50bc1737c167..f054a14b9156 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -111,7 +111,7 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 	 * behind other threads which is necessary for forward progress
 	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
 	 */
-	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+	if (is_kernel_thread(p) && p->nr_cpus_allowed == 1) {
 		__sync_fetch_and_add(&nr_locals, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
 				   enq_flags | SCX_ENQ_PREEMPT);
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 2c720e3ecad5..07f4d3a6833c 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -370,7 +370,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
 		 * implement per-cgroup fallback dq's instead so that we have
 		 * more control over when tasks with custom cpumask get issued.
 		 */
-		if (p->nr_cpus_allowed == 1 && (p->flags & PF_KTHREAD)) {
+		if (p->nr_cpus_allowed == 1 && is_kernel_thread(p)) {
 			stat_inc(FCG_STAT_LOCAL);
 			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
 					   enq_flags);
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 26c40ca4f36c..b8ea1bb436b2 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -200,7 +200,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	void *ring;
 	s32 cpu;
 
-	if (p->flags & PF_KTHREAD) {
+	if (is_kernel_thread(p)) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
 			return;
 	} else {
-- 
2.47.2



