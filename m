Return-Path: <bpf+bounces-35504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B793B07C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A68E1C21DBC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8D1586C1;
	Wed, 24 Jul 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNYbGmK2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775F157491;
	Wed, 24 Jul 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821199; cv=none; b=CFqmxm7r14E60Bqxzp9iiC4V+V7JCCq08prMHe106tFN3PbvsH4sswoU0Wj4upzu1inpj+doHljpfxyr35/oF46BH+xFNqMnv392OD3PaIqh/IcFDvK/4cylLwiWyCHlKS0bNDkMOlaePHdBjZrX5SAlueWeFuYJWC2IXPX3gdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821199; c=relaxed/simple;
	bh=TRLbiSG3uwVen1pBB1Ajq3MdLhJUNd5VKgOElz2rJYI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oC4AJYnVmLq9/+QnyBWJfQ1ghbJsS1OhTALQEQHPdsR2LWrUGTBJkNTgai3v8oTUkKAG9qp3LAJK2JWHf3KAjqtd3CK9EqbqxdyhNY0BQb4o5JOcTmWz2KVHS3c1Rxv+7Cww7qvoRnhN8YE9n2IFdtGAxs6DSOdI1/O/XZLk0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNYbGmK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38CAC32782;
	Wed, 24 Jul 2024 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721821199;
	bh=TRLbiSG3uwVen1pBB1Ajq3MdLhJUNd5VKgOElz2rJYI=;
	h=From:To:Subject:Date:From;
	b=TNYbGmK2ibITmrRBNHwRgd0zAjyFXgvyKCGiKcjuKKkGZvoprg+PeQnDp7F2hOGat
	 owFcpmxFmAhYjR7bGITleueb/Eo4CD0r536oC8ngNM9pX+y9ldbJ2Kk3sZNnSRrEmF
	 qqBbovfcLg7sJ28cXY0Nitm16vsAHKYishffMGStM9mdXSeNBcctJtX+XXExtPfizM
	 aY+k8eTYQJYe1B9d1zhN+qaorlY20ahlnIxFpB8pp7jW9FDJ8ll4v88Ak1Ord5+b+x
	 J9w5ySVNprJvFiQL01TcVXTcxIJ8CiYPRnkVWDCWBg26h9ciwsPl4ntgisw0feTPkl
	 2LNrH2sdcxGwQ==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid() helpers
Date: Wed, 24 Jul 2024 11:39:43 +0000
Message-Id: <20240724113944.75977-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which are
similar to bpf_send_signal_thread and bpf_send_signal helpers
respectively but can be used to send signals to other threads and
processes.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/uapi/linux/bpf.h       | 37 ++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 53 +++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 37 ++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..7b29003c079c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5792,6 +5792,41 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_send_signal_pid(u32 sig, u32 pid)
+ *	Description
+ *		Send signal *sig* to the thread corresponding to the
+ *		process id *pid*.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ *		**-EINVAL** if *sig* is invalid.
+ *
+ *		**-EPERM** if no permission to send the *sig*.
+ *
+ *		**-EAGAIN** if bpf program can try again.
+ *
+ *		**-ESRCH** if *pid* is invalid.
+ *
+ * long bpf_send_signal_tgid(u32 sig, u32 tgid)
+ *	Description
+ *		Send signal *sig* to the process corresponding to the
+ *		thread group id *tgid*.
+ *		The signal may be delivered to any of this process's threads.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ *		**-EINVAL** if *sig* is invalid.
+ *
+ *		**-EPERM** if no permission to send the *sig*.
+ *
+ *		**-EAGAIN** if bpf program can try again.
+ *
+ *		**-ESRCH** if *tgid* is invalid.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6041,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(send_signal_pid, 212, ##ctx)		\
+	FN(send_signal_tgid, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..f1e58122600d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	put_task_struct(work->task);
 }
 
-static int bpf_send_signal_common(u32 sig, enum pid_type type)
+static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 pid)
 {
 	struct send_signal_irq_work *work = NULL;
+	struct task_struct *tsk;
+
+	if (pid) {
+		tsk = find_task_by_vpid(pid);
+		if (!tsk)
+			return -ESRCH;
+	} else {
+		tsk = current;
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
@@ -871,19 +880,19 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task = get_task_struct(current);
+		work->task = get_task_struct(tsk);
 		work->sig = sig;
 		work->type = type;
 		irq_work_queue(&work->irq_work);
 		return 0;
 	}
 
-	return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
+	return group_send_sig_info(sig, SEND_SIG_PRIV, tsk, type);
 }
 
 BPF_CALL_1(bpf_send_signal, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_TGID);
+	return bpf_send_signal_common(sig, PIDTYPE_TGID, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_proto = {
@@ -895,7 +904,7 @@ static const struct bpf_func_proto bpf_send_signal_proto = {
 
 BPF_CALL_1(bpf_send_signal_thread, u32, sig)
 {
-	return bpf_send_signal_common(sig, PIDTYPE_PID);
+	return bpf_send_signal_common(sig, PIDTYPE_PID, 0);
 }
 
 static const struct bpf_func_proto bpf_send_signal_thread_proto = {
@@ -905,6 +914,32 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_2(bpf_send_signal_pid, u32, sig, u32, pid)
+{
+	return bpf_send_signal_common(sig, PIDTYPE_PID, pid);
+}
+
+static const struct bpf_func_proto bpf_send_signal_pid_proto = {
+	.func		= bpf_send_signal_pid,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_send_signal_tgid, u32, sig, u32, tgid)
+{
+	return bpf_send_signal_common(sig, PIDTYPE_TGID, tgid);
+}
+
+static const struct bpf_func_proto bpf_send_signal_tgid_proto = {
+	.func		= bpf_send_signal_tgid,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
 	struct path copy;
@@ -1583,6 +1618,10 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_send_signal_proto;
 	case BPF_FUNC_send_signal_thread:
 		return &bpf_send_signal_thread_proto;
+	case BPF_FUNC_send_signal_pid:
+		return &bpf_send_signal_pid_proto;
+	case BPF_FUNC_send_signal_tgid:
+		return &bpf_send_signal_tgid_proto;
 	case BPF_FUNC_perf_event_read_value:
 		return &bpf_perf_event_read_value_proto;
 	case BPF_FUNC_ringbuf_output:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..7b29003c079c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5792,6 +5792,41 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_send_signal_pid(u32 sig, u32 pid)
+ *	Description
+ *		Send signal *sig* to the thread corresponding to the
+ *		process id *pid*.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ *		**-EINVAL** if *sig* is invalid.
+ *
+ *		**-EPERM** if no permission to send the *sig*.
+ *
+ *		**-EAGAIN** if bpf program can try again.
+ *
+ *		**-ESRCH** if *pid* is invalid.
+ *
+ * long bpf_send_signal_tgid(u32 sig, u32 tgid)
+ *	Description
+ *		Send signal *sig* to the process corresponding to the
+ *		thread group id *tgid*.
+ *		The signal may be delivered to any of this process's threads.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ *		**-EINVAL** if *sig* is invalid.
+ *
+ *		**-EPERM** if no permission to send the *sig*.
+ *
+ *		**-EAGAIN** if bpf program can try again.
+ *
+ *		**-ESRCH** if *tgid* is invalid.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6041,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(send_signal_pid, 212, ##ctx)		\
+	FN(send_signal_tgid, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.40.1


