Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8131D28CA0
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfEWVrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 17:47:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388220AbfEWVrv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 May 2019 17:47:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NLkTnk014010
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 14:47:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=r2d4pHl3/bSKyYPycBlx7udd+Bu6dj3iVQPty4L8K0g=;
 b=DmsJyLEkAtFA1+aCaJw0XoesCEJrjLdMdIe34kcSkHkpKRWmwLYeLpiGGpVg63MY2Va/
 i63YzKfMgc88cS8AaN6ssdYYSpMQqgjNG/yV4nqw11bq4JrG4iXskaNSYmSZvVC9hZQg
 RJeoFC4mVnAg4Chyo9/UduVHTEazZEEpSTo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sp15ngjt7-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 14:47:49 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 23 May 2019 14:47:48 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 75F9B370201B; Thu, 23 May 2019 14:47:45 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v5 1/3] bpf: implement bpf_send_signal() helper
Date:   Thu, 23 May 2019 14:47:45 -0700
Message-ID: <20190523214745.854355-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523214745.854300-1-yhs@fb.com>
References: <20190523214745.854300-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230139
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch tries to solve the following specific use case.

Currently, bpf program can already collect stack traces
through kernel function get_perf_callchain()
when certain events happens (e.g., cache miss counter or
cpu clock counter overflows). But such stack traces are
not enough for jitted programs, e.g., hhvm (jited php).
To get real stack trace, jit engine internal data structures
need to be traversed in order to get the real user functions.

bpf program itself may not be the best place to traverse
the jit engine as the traversing logic could be complex and
it is not a stable interface either.

Instead, hhvm implements a signal handler,
e.g. for SIGALARM, and a set of program locations which
it can dump stack traces. When it receives a signal, it will
dump the stack in next such program location.

Such a mechanism can be implemented in the following way:
  . a perf ring buffer is created between bpf program
    and tracing app.
  . once a particular event happens, bpf program writes
    to the ring buffer and the tracing app gets notified.
  . the tracing app sends a signal SIGALARM to the hhvm.

But this method could have large delays and causing profiling
results skewed.

This patch implements bpf_send_signal() helper to send
a signal to hhvm in real time, resulting in intended stack traces.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h | 17 +++++++++-
 kernel/trace/bpf_trace.c | 72 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 63e0cf66f01a..68d4470523a0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2672,6 +2672,20 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf-local-storage cannot be found.
+ *
+ * int bpf_send_signal(u32 sig)
+ *	Description
+ *		Send signal *sig* to the current task.
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
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2782,7 +2796,8 @@ union bpf_attr {
 	FN(strtol),			\
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
-	FN(sk_storage_delete),
+	FN(sk_storage_delete),		\
+	FN(send_signal),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f92d6ad5e080..70029eafc71f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -567,6 +567,63 @@ static const struct bpf_func_proto bpf_probe_read_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+struct send_signal_irq_work {
+	struct irq_work irq_work;
+	struct task_struct *task;
+	u32 sig;
+};
+
+static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
+
+static void do_bpf_send_signal(struct irq_work *entry)
+{
+	struct send_signal_irq_work *work;
+
+	work = container_of(entry, struct send_signal_irq_work, irq_work);
+	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, PIDTYPE_TGID);
+}
+
+BPF_CALL_1(bpf_send_signal, u32, sig)
+{
+	struct send_signal_irq_work *work = NULL;
+
+	/* Similar to bpf_probe_write_user, task needs to be
+	 * in a sound condition and kernel memory access be
+	 * permitted in order to send signal to the current
+	 * task.
+	 */
+	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
+		return -EPERM;
+	if (unlikely(uaccess_kernel()))
+		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
+
+	if (in_nmi()) {
+		work = this_cpu_ptr(&send_signal_work);
+		if (work->irq_work.flags & IRQ_WORK_BUSY)
+			return -EBUSY;
+
+		/* Add the current task, which is the target of sending signal,
+		 * to the irq_work. The current task may change when queued
+		 * irq works get executed.
+		 */
+		work->task = current;
+		work->sig = sig;
+		irq_work_queue(&work->irq_work);
+		return 0;
+	}
+
+	return group_send_sig_info(sig, SEND_SIG_PRIV, current, PIDTYPE_TGID);
+}
+
+static const struct bpf_func_proto bpf_send_signal_proto = {
+	.func		= bpf_send_signal,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -617,6 +674,8 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
 #endif
+	case BPF_FUNC_send_signal:
+		return &bpf_send_signal_proto;
 	default:
 		return NULL;
 	}
@@ -1343,5 +1402,18 @@ static int __init bpf_event_init(void)
 	return 0;
 }
 
+static int __init send_signal_irq_work_init(void)
+{
+	int cpu;
+	struct send_signal_irq_work *work;
+
+	for_each_possible_cpu(cpu) {
+		work = per_cpu_ptr(&send_signal_work, cpu);
+		init_irq_work(&work->irq_work, do_bpf_send_signal);
+	}
+	return 0;
+}
+
 fs_initcall(bpf_event_init);
+subsys_initcall(send_signal_irq_work_init);
 #endif /* CONFIG_MODULES */
-- 
2.17.1

