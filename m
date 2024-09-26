Return-Path: <bpf+bounces-40348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A998731E
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78AC7B22F86
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4781714CD;
	Thu, 26 Sep 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co2A07VR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BC1798F;
	Thu, 26 Sep 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351630; cv=none; b=qFf76vbphVxiPh+R0aEBU2MFYLj30E5KOYNt6ZGHghE6uFMfkHkGCJ+7IDPn2o9eekdsqADz3jVP++OTMmD7o9UakqnRtDvzv7UMTc3UVGKiazQXCHGdwWI4Z5Rd/9IjsXlNcMkf/EPge2RNle4Fy2tTWBoKIuiLhN9M30JNkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351630; c=relaxed/simple;
	bh=2WVwb/Rv5Uv37R0eDSMuZzkbHgeTyCNWtZJ35FWrJeo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzQC9VtInfmmKdlq/eabPyxnJ956VTljy4Z+YcQx/7Fgi4Uc8xmGNzAl1t2WW7vOL7GxJP2acp7czJwiPjNRYO/3stAzzARDiq2s1bcB8MbwAsSECPzHSb5cXN7Q3roRelJ+Sfo1jvFXpWLHyRxGSad1P4EoOeHadHYC6SMFfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co2A07VR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A491BC4CEC9;
	Thu, 26 Sep 2024 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727351629;
	bh=2WVwb/Rv5Uv37R0eDSMuZzkbHgeTyCNWtZJ35FWrJeo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Co2A07VRLi0ocLBpYplZWldH4eiLkBVrb0kBvKBfRQtRWTqQrHo5jUD2tQlMQIwkz
	 DC5iJ0Sx6vkm54Bq7H58EPVn62oSi9ZG9UYe3pcBCqpxg0XWO6UpU5AAExpbmVM8yA
	 JWbqo0fcvmKXC7gV7R/6W4TZEk4/HrOmFAkMO2KTi4Nz/2igpaO7f7s3CXCeQIeIuV
	 jpI6X44oz/fGrLLqK+HBkK2uyqt7gUUnQa0nVn7fsv+zKbUAzVJFcBrtyBmLdpZ4f6
	 krnPO0t+5kWhoawDr+FvmbZoKByMtKVR97HB+pnxag83V98vUR/XKhRUETpVyr8idh
	 4jCvY9grFWcZQ==
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
Subject: [PATCH bpf-next v2 1/2] bpf: implement bpf_send_signal_remote() kfunc
Date: Thu, 26 Sep 2024 11:53:27 +0000
Message-Id: <20240926115328.105634-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240926115328.105634-1-puranjay@kernel.org>
References: <20240926115328.105634-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf_send_signal_remote kfunc that is similar to
bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
send signals to other threads and processes. It also supports sending a
cookie with the signal similar to sigqueue().

If the receiving process establishes a handler for the signal using the
SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
si_value field of the siginfo_t structure passed as the second argument
to the handler.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/trace/bpf_trace.c | 78 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca876..51b27db1321fc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -802,6 +802,9 @@ struct send_signal_irq_work {
 	struct task_struct *task;
 	u32 sig;
 	enum pid_type type;
+	bool is_siginfo;
+	kernel_siginfo_t info;
+	int value;
 };
 
 static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
@@ -811,7 +814,11 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	struct send_signal_irq_work *work;
 
 	work = container_of(entry, struct send_signal_irq_work, irq_work);
-	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+	if (work->is_siginfo)
+		group_send_sig_info(work->sig, &work->info, work->task, work->type);
+	else
+		group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
+
 	put_task_struct(work->task);
 }
 
@@ -848,6 +855,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		 * irq works get executed.
 		 */
 		work->task = get_task_struct(current);
+		work->is_siginfo = false;
 		work->sig = sig;
 		work->type = type;
 		irq_work_queue(&work->irq_work);
@@ -3484,3 +3492,71 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_send_signal_remote(struct task_struct *task, int sig, enum pid_type type,
+				       int value)
+{
+	struct send_signal_irq_work *work = NULL;
+	kernel_siginfo_t info;
+
+	if (type != PIDTYPE_PID && type != PIDTYPE_TGID)
+		return -EINVAL;
+	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
+		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
+	/* Task should not be pid=1 to avoid kernel panic. */
+	if (unlikely(is_global_init(task)))
+		return -EPERM;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	info.si_value.sival_int = value;
+
+	if (irqs_disabled()) {
+		/* Do an early check on signal validity. Otherwise,
+		 * the error is lost in deferred irq_work.
+		 */
+		if (unlikely(!valid_signal(sig)))
+			return -EINVAL;
+
+		work = this_cpu_ptr(&send_signal_work);
+		if (irq_work_is_busy(&work->irq_work))
+			return -EBUSY;
+
+		work->task = get_task_struct(task);
+		work->is_siginfo = true;
+		work->info = info;
+		work->sig = sig;
+		work->type = type;
+		work->value = value;
+		irq_work_queue(&work->irq_work);
+		return 0;
+	}
+
+	return group_send_sig_info(sig, &info, task, type);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(send_signal_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_send_signal_remote, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(send_signal_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_send_signal_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &send_signal_kfunc_ids,
+};
+
+static int __init bpf_send_signal_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_send_signal_kfunc_set);
+}
+
+late_initcall(bpf_send_signal_kfuncs_init);
-- 
2.40.1


