Return-Path: <bpf+bounces-41102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD40992951
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409EF1F2241A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F81D07B0;
	Mon,  7 Oct 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqHnNV93"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41D1C878B;
	Mon,  7 Oct 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297292; cv=none; b=NyKr7Hid/Mrc+R9uultufE79K/wSxbeDJAP4PZFcWb3M5Bu00ILjC6RBaK3kVEuo/S4phfcZJ1rgno4FHozJkkMqYu9Ttx9AcCLGw82evWi6/+2z7CrajP8TiMDb2w021V+ODRobir3Z1MvSHihEzUQSPizZmZq7e8TyWoTOZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297292; c=relaxed/simple;
	bh=zLBswqHmt+tMJ0oWb6dIQHlYuJg5CCE1zs0HIuD9lzg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHCBj9ObibVQR3vo4UMLXZFG60n0Ic45efH6jnJhw/kjF/MiBxXpCDyJ1qr7ixW3kaQyPE2q1Vf2FOmgBJpdKUkEe0HQDO7x3RF4DclD8gkHZ5NwJkc8zjQdYrNw4SUtEQ37ERlSyh7dvNEjhgFu661k4jiTIwwkhT8rO5nCKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqHnNV93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D57C4CECC;
	Mon,  7 Oct 2024 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728297292;
	bh=zLBswqHmt+tMJ0oWb6dIQHlYuJg5CCE1zs0HIuD9lzg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hqHnNV932lUsJI/DfMjunFOdZOtGtaQ2jPIAUz8mZQvwYq8p3iR460aqJ190Qnx1k
	 DCy1KH+hRdAv2d98yQ2qJhQZHrMabrrgPh+OSXbFRLRknigWGTv9N7yY5MIfNGfM1I
	 khRa4T6+5oDwivtaQKyB58zGyw8DFy/XPo7Fir6mLTMvmxWgXRSNRCHoJHtJo6x1j8
	 hiorTdrb181D9Z6T6WpU3x6MbwD/xsE+5u/DtPCGUWaz2S5S0RNqjFRWcK2FuZvvVd
	 /EAhGPHromJOyqT501nN01n+kc/E86tpfGbbcUKyrfeea+zH2dvD0QyEvCRaDX7yb0
	 5tTvcc8mxzshQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task() kfunc
Date: Mon,  7 Oct 2024 10:34:25 +0000
Message-Id: <20241007103426.128923-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241007103426.128923-1-puranjay@kernel.org>
References: <20241007103426.128923-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf_send_signal_task kfunc that is similar to
bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
send signals to other threads and processes. It also supports sending a
cookie with the signal similar to sigqueue().

If the receiving process establishes a handler for the signal using the
SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
si_value field of the siginfo_t structure passed as the second argument
to the handler.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/helpers.c     |  1 +
 kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4053f279ed4cc..2fd3feefb9d94 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca876..ae8c9fa8b04d1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -802,6 +802,8 @@ struct send_signal_irq_work {
 	struct task_struct *task;
 	u32 sig;
 	enum pid_type type;
+	bool has_siginfo;
+	kernel_siginfo_t info;
 };
 
 static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
@@ -811,25 +813,43 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	struct send_signal_irq_work *work;
 
 	work = container_of(entry, struct send_signal_irq_work, irq_work);
-	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+	if (work->has_siginfo)
+		group_send_sig_info(work->sig, &work->info, work->task, work->type);
+	else
+		group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
 	put_task_struct(work->task);
 }
 
-static int bpf_send_signal_common(u32 sig, enum pid_type type)
+static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *tsk, u64 value)
 {
 	struct send_signal_irq_work *work = NULL;
+	kernel_siginfo_t info;
+	bool has_siginfo = false;
+
+	if (!tsk) {
+		tsk = current;
+	} else {
+		has_siginfo = true;
+		clear_siginfo(&info);
+		info.si_signo = sig;
+		info.si_errno = 0;
+		info.si_code = SI_KERNEL;
+		info.si_pid = 0;
+		info.si_uid = 0;
+		info.si_value.sival_ptr = (void *)value;
+	}
 
 	/* Similar to bpf_probe_write_user, task needs to be
 	 * in a sound condition and kernel memory access be
 	 * permitted in order to send signal to the current
 	 * task.
 	 */
-	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
+	if (unlikely(tsk->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 	/* Task should not be pid=1 to avoid kernel panic. */
-	if (unlikely(is_global_init(current)))
+	if (unlikely(is_global_init(tsk)))
 		return -EPERM;
 
 	if (irqs_disabled()) {
@@ -847,19 +867,24 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task = get_task_struct(current);
+		work->task = get_task_struct(tsk);
+		work->has_siginfo = has_siginfo;
+		work->info = info;
 		work->sig = sig;
 		work->type = type;
 		irq_work_queue(&work->irq_work);
 		return 0;
 	}
 
-	return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
+	if (has_siginfo)
+		return group_send_sig_info(sig, &info, tsk, type);
+
+	return group_send_sig_info(sig, SEND_SIG_PRIV, tsk, type);
 }
 
 BPF_CALL_1(bpf_send_signal, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_TGID);
+	return bpf_send_signal_common(sig, PIDTYPE_TGID, NULL, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_proto = {
@@ -871,7 +896,7 @@ static const struct bpf_func_proto bpf_send_signal_proto = {
 
 BPF_CALL_1(bpf_send_signal_thread, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_PID);
+	return bpf_send_signal_common(sig, PIDTYPE_PID, NULL, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_thread_proto = {
@@ -3484,3 +3509,16 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type,
+				     u64 value)
+{
+	if (type != PIDTYPE_PID && type != PIDTYPE_TGID)
+		return -EINVAL;
+
+	return bpf_send_signal_common(sig, type, task, value);
+}
+
+__bpf_kfunc_end_defs();
-- 
2.40.1


