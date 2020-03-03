Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742B6178634
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCCXQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:16:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727805AbgCCXQL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 18:16:11 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023NG1at008514
        for <bpf@vger.kernel.org>; Tue, 3 Mar 2020 15:16:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=dUVsZGIuYu1PknvR7nj8kRx+fvImNpIcrU82e9s1z+g=;
 b=jhV6bvn/bOZe7Ub9aHbDJnBVwPj8IK9O6Oub4DbI/8Te8RtCmRuGhqX30/tUQ7OCM4+0
 X6P2XUQazgw1nLU0+9kcOc9XSwckF4sDVLNn5E9uPkrh3xiDSscR/VDeDZL37OKlp4/G
 PtiJyHF13GUE9iDIoQfnAXXxrJ2xTqr+lDo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yhs5g2ud3-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 15:16:10 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 15:16:00 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1B3593701059; Tue,  3 Mar 2020 15:15:56 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 2/2] bpf: avoid irq_work for bpf_send_signal() if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
Date:   Tue, 3 Mar 2020 15:15:56 -0800
Message-ID: <20200303231556.2553287-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303231554.2553105-1-yhs@fb.com>
References: <20200303231554.2553105-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=13 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003030152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an optimization. In task_work_add(), we have
the following loop:
        do {
                head = READ_ONCE(task->task_works);
                if (unlikely(head == &work_exited))
                        return -ESRCH;
                work->next = head;
        } while (cmpxchg(&task->task_works, head, work) != head);

If CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, even in the
nmi context, we are safe to call task_work_add().
In such cases, irq_work() can be avoided, to avoid
the intermediate step to set up the task_work.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 52 +++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index db7b6194e38a..b7bb11c0e5b0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -713,21 +713,26 @@ static void do_send_signal_work(struct callback_head *twork)
 	kfree(twcb);
 }
 
-static void add_send_signal_task_work(u32 sig, enum pid_type type)
+static int add_send_signal_task_work(u32 sig, enum pid_type type)
 {
 	struct send_signal_work_cb *twcb;
+	int ret;
 
 	twcb = kzalloc(sizeof(*twcb), GFP_ATOMIC);
 	if (!twcb)
-		return;
+		return -ENOMEM;
 
 	twcb->sig = sig;
 	twcb->type = type;
 	init_task_work(&twcb->twork, do_send_signal_work);
-	if (task_work_add(current, &twcb->twork, true))
+	ret = task_work_add(current, &twcb->twork, true);
+	if (ret)
 		kfree(twcb);
+
+	return ret;
 }
 
+#ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
@@ -748,10 +753,29 @@ static void do_bpf_send_signal(struct irq_work *entry)
 	put_task_struct(work->task);
 }
 
-static int bpf_send_signal_common(u32 sig, enum pid_type type)
+static int add_send_signal_irq_work(u32 sig, enum pid_type type)
 {
 	struct send_signal_irq_work *work = NULL;
 
+	work = this_cpu_ptr(&send_signal_work);
+	if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
+		return -EBUSY;
+
+	/* Add the current task, which is the target of sending signal,
+	 * to the irq_work. The current task may change when queued
+	 * irq works get executed.
+	 */
+	work->task = get_task_struct(current);
+	work->sig = sig;
+	work->type = type;
+	irq_work_queue(&work->irq_work);
+
+	return 0;
+}
+#endif
+
+static int bpf_send_signal_common(u32 sig, enum pid_type type)
+{
 	/* Similar to bpf_probe_write_user, task needs to be
 	 * in a sound condition and kernel memory access be
 	 * permitted in order to send signal to the current
@@ -771,19 +795,11 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 		if (unlikely(!valid_signal(sig)))
 			return -EINVAL;
 
-		work = this_cpu_ptr(&send_signal_work);
-		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
-			return -EBUSY;
-
-		/* Add the current task, which is the target of sending signal,
-		 * to the irq_work. The current task may change when queued
-		 * irq works get executed.
-		 */
-		work->task = get_task_struct(current);
-		work->sig = sig;
-		work->type = type;
-		irq_work_queue(&work->irq_work);
-		return 0;
+#ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
+		return add_send_signal_irq_work(sig, type);
+#else
+		return add_send_signal_task_work(sig, type);
+#endif
 	}
 
 	return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
@@ -1673,6 +1689,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 	return err;
 }
 
+#ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 static int __init send_signal_irq_work_init(void)
 {
 	int cpu;
@@ -1686,6 +1703,7 @@ static int __init send_signal_irq_work_init(void)
 }
 
 subsys_initcall(send_signal_irq_work_init);
+#endif
 
 #ifdef CONFIG_MODULES
 static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
-- 
2.17.1

