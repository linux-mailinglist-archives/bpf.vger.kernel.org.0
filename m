Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5013B85D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 04:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAODuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 22:50:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44790 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728884AbgAODuI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 22:50:08 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F3ejHi006793
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=0Kri1zPD8T9+oUfWKzpqhXA6kRShgn8nXJs+p1iHyx4=;
 b=dP9Dsy/N1Yguyqp1emeOZpH5O05Ci0/P8fdMnsXk3O44YnX8tgUlleY+BmnaYPq/26yw
 MSPtr65Y7SrGuEKEh97Agjc9tAPVL3+ZdWixcaIGMpjBVb5av9Ybw7dkhjVBkBG44ASI
 kHUH+dM7+OZyC3WRtN9omMvK4WwUZe8naxM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhgwub1me-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:07 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 19:50:06 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6B36B370483F; Tue, 14 Jan 2020 19:50:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_send_signal_thread() helper
Date:   Tue, 14 Jan 2020 19:50:02 -0800
Message-ID: <20200115035002.602336-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115035002.602280-1-yhs@fb.com>
References: <20200115035002.602280-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001150030
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
added helper bpf_send_signal() which permits bpf program to
send a signal to the current process. The signal may be
delivered to any threads in the process.

We found a use case where sending the signal to the current
thread is more preferable.
  - A bpf program will collect the stack trace and then
    send signal to the user application.
  - The user application will add some thread specific
    information to the just collected stack trace for
    later analysis.

If bpf_send_signal() is used, user application will need
to check whether the thread receiving the signal matches
the thread collecting the stack by checking thread id.
If not, it will need to send signal to another thread
through pthread_kill().

This patch proposed a new helper bpf_send_signal_thread(),
which sends the signal to the thread corresponding to
the current kernel task. This way, user space is guaranteed that
bpf_program execution context and user space signal handling
context are the same thread.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h       | 19 +++++++++++++++++--
 kernel/trace/bpf_trace.c       | 27 ++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 19 +++++++++++++++++--
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 52966e758fe5..a88837d4dd18 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2714,7 +2714,8 @@ union bpf_attr {
  *
  * int bpf_send_signal(u32 sig)
  *	Description
- *		Send signal *sig* to the current task.
+ *		Send signal *sig* to the process of the current task.
+ *		The signal may be delivered to any of this process's threads.
  *	Return
  *		0 on success or successfully queued.
  *
@@ -2850,6 +2851,19 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
+ * int bpf_send_signal_thread(u32 sig)
+ *	Description
+ *		Send signal *sig* to the thread corresponding to the current task.
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
@@ -2968,7 +2982,8 @@ union bpf_attr {
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
 	FN(probe_read_kernel_str),	\
-	FN(tcp_send_ack),
+	FN(tcp_send_ack),		\
+	FN(send_signal_thread),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e5ef4ae9edb5..19e793aa441a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -703,6 +703,7 @@ struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
 	u32 sig;
+	enum pid_type type;
 };
 
 static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
@@ -712,10 +713,10 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	struct send_signal_irq_work *work;
 
 	work = container_of(entry, struct send_signal_irq_work, irq_work);
-	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, PIDTYPE_TGID);
+	group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
 }
 
-BPF_CALL_1(bpf_send_signal, u32, sig)
+static int bpf_send_signal_common(u32 sig, enum pid_type type)
 {
 	struct send_signal_irq_work *work = NULL;
 
@@ -748,11 +749,17 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 		 */
 		work->task = current;
 		work->sig = sig;
+		work->type = type;
 		irq_work_queue(&work->irq_work);
 		return 0;
 	}
 
-	return group_send_sig_info(sig, SEND_SIG_PRIV, current, PIDTYPE_TGID);
+	return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
+}
+
+BPF_CALL_1(bpf_send_signal, u32, sig)
+{
+	return bpf_send_signal_common(sig, PIDTYPE_TGID);
 }
 
 static const struct bpf_func_proto bpf_send_signal_proto = {
@@ -762,6 +769,18 @@ static const struct bpf_func_proto bpf_send_signal_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_send_signal_thread, u32, sig)
+{
+	return bpf_send_signal_common(sig, PIDTYPE_PID);
+}
+
+static const struct bpf_func_proto bpf_send_signal_thread_proto = {
+	.func		= bpf_send_signal_thread,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -822,6 +841,8 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 	case BPF_FUNC_send_signal:
 		return &bpf_send_signal_proto;
+	case BPF_FUNC_send_signal_thread:
+		return &bpf_send_signal_thread_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 52966e758fe5..a88837d4dd18 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2714,7 +2714,8 @@ union bpf_attr {
  *
  * int bpf_send_signal(u32 sig)
  *	Description
- *		Send signal *sig* to the current task.
+ *		Send signal *sig* to the process of the current task.
+ *		The signal may be delivered to any of this process's threads.
  *	Return
  *		0 on success or successfully queued.
  *
@@ -2850,6 +2851,19 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
+ * int bpf_send_signal_thread(u32 sig)
+ *	Description
+ *		Send signal *sig* to the thread corresponding to the current task.
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
@@ -2968,7 +2982,8 @@ union bpf_attr {
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
 	FN(probe_read_kernel_str),	\
-	FN(tcp_send_ack),
+	FN(tcp_send_ack),		\
+	FN(send_signal_thread),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.17.1

