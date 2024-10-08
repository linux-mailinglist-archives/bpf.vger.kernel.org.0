Return-Path: <bpf+bounces-41252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDB9947A6
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179C2287299
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7A1DDC31;
	Tue,  8 Oct 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktSWF1iQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA521DC046;
	Tue,  8 Oct 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388197; cv=none; b=UOm3eZVVaHTJirSJg2vtaW6JUOr0q9vMYKDlr0NxYYlFg26FNSvCziauy7xhdLSgZrxyRKH6L44/bluoTLk5/FlDrBLVCId7G84DAnaSLiCI+2vCX+hNpZpfctdvylNzyvxjJoPpaBHc3hxxVK2pd6Xb5D9eZkSSaxjFLA6Gac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388197; c=relaxed/simple;
	bh=d+3xGC5kWs3uQkS1AdUBbn/V4ucQF3MN+94QVKIFWKI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkxFnTY5zbWzJsPybhtJ1vwE+L6S74hxEOwgrz0k14gWmDSQTgsa9I40wADVbflg/TKQDnHTNtjZQVVXZt5k6Ic9kXo6Bn/vEkxgDyV0hhVtw5vUYl4TqpMrqluD5ScY9ZCBRa7kGCe4PGS9UDGc5TUbzUmYY6M5WAHNw5Al7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktSWF1iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CBC4CEC7;
	Tue,  8 Oct 2024 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728388197;
	bh=d+3xGC5kWs3uQkS1AdUBbn/V4ucQF3MN+94QVKIFWKI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ktSWF1iQqb9QUns8+W5nEFVixO8ixm17R8tETSHZ65wkPICLjUmnGZ46w+Y9sGCdq
	 nrn4DYlMubXteJFksCdoYoCzTaUe8F+hzszHrzJgp2pIjcEJL8QGpCFvtz8ra0BH1q
	 O6QHL07oB762YBXOiweuVUBO9XNgTc00aHoIOmihsy+ppUG4Am+G+GR9eJZW/JMMke
	 n37Sxs9rW1sf9ohX6gbQTu9Ldeb/UbjwWORRMRw0qSQGbytF6mo6UUxju7IOKVTw0S
	 lMfdZjBEPwA+mVlty5FtmCluZ6BJhZ1wrxwEh1stPrVDDTSvdS+uCfCvvRdYW5uaD3
	 Tm3bfRKhu6Y3A==
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
Subject: [PATCH bpf-next v4 1/2] bpf: implement bpf_send_signal_task() kfunc
Date: Tue,  8 Oct 2024 11:49:39 +0000
Message-Id: <20241008114940.44305-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241008114940.44305-1-puranjay@kernel.org>
References: <20241008114940.44305-1-puranjay@kernel.org>
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
 kernel/trace/bpf_trace.c | 52 +++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 8 deletions(-)

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
index a582cd25ca876..d9662e84510d3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -802,6 +802,8 @@ struct send_signal_irq_work {
 	struct task_struct *task;
 	u32 sig;
 	enum pid_type type;
+	bool has_siginfo;
+	struct kernel_siginfo info;
 };
 
 static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
@@ -809,27 +811,46 @@ static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
 static void do_bpf_send_signal(struct irq_work *entry)
 {
 	struct send_signal_irq_work *work;
+	struct kernel_siginfo *siginfo;
 
 	work = container_of(entry, struct send_signal_irq_work, irq_work);
-	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+	siginfo = work->has_siginfo ? &work->info : SEND_SIG_PRIV;
+
+	group_send_sig_info(work->sig, siginfo, work->task, work->type);
 	put_task_struct(work->task);
 }
 
-static int bpf_send_signal_common(u32 sig, enum pid_type type)
+static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *task, u64 value)
 {
 	struct send_signal_irq_work *work = NULL;
+	struct kernel_siginfo info;
+	struct kernel_siginfo *siginfo;
+
+	if (!task) {
+		task = current;
+		siginfo = SEND_SIG_PRIV;
+	} else {
+		clear_siginfo(&info);
+		info.si_signo = sig;
+		info.si_errno = 0;
+		info.si_code = SI_KERNEL;
+		info.si_pid = 0;
+		info.si_uid = 0;
+		info.si_value.sival_ptr = (void *)(unsigned long)value;
+		siginfo = &info;
+	}
 
 	/* Similar to bpf_probe_write_user, task needs to be
 	 * in a sound condition and kernel memory access be
 	 * permitted in order to send signal to the current
 	 * task.
 	 */
-	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
+	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 	/* Task should not be pid=1 to avoid kernel panic. */
-	if (unlikely(is_global_init(current)))
+	if (unlikely(is_global_init(task)))
 		return -EPERM;
 
 	if (irqs_disabled()) {
@@ -847,19 +868,21 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task = get_task_struct(current);
+		work->task = get_task_struct(task);
+		work->has_siginfo = siginfo == &info;
+		copy_siginfo(&work->info, &info);
 		work->sig = sig;
 		work->type = type;
 		irq_work_queue(&work->irq_work);
 		return 0;
 	}
 
-	return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
+	return group_send_sig_info(sig, siginfo, task, type);
 }
 
 BPF_CALL_1(bpf_send_signal, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_TGID);
+	return bpf_send_signal_common(sig, PIDTYPE_TGID, NULL, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_proto = {
@@ -871,7 +894,7 @@ static const struct bpf_func_proto bpf_send_signal_proto = {
 
 BPF_CALL_1(bpf_send_signal_thread, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_PID);
+	return bpf_send_signal_common(sig, PIDTYPE_PID, NULL, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_thread_proto = {
@@ -3484,3 +3507,16 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
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


